// Package main contains the main package of the header program.
package main

import (
	"bytes"
	"context"
	_ "embed"
	"encoding/json"
	"fmt"
	"log"
	"log/slog"
	"os"
	"os/exec"
	"os/signal"
	"path/filepath"
	"slices"
	"strings"
	"syscall"
	"text/template"
)

type (
	// Commits is a slice of Commits.
	Commits []Commit

	// Commit is a struct for parsing the output of git log.
	Commit struct {
		Commit      string `json:"commit"`
		AuthorName  string `json:"author_name"`
		AuthorEmail string `json:"author_email"`
		Date        string `json:"date"`
		Timestamp   int64  `json:"timestamp"`
		Message     string `json:"message"`
		Repo        string `json:"repo"`
	}
)

var (
	//go:embed file.tmpl
	fileTemplate string

	file = template.Must(template.New("file").Parse(fileTemplate))

	logger = slog.New(slog.NewTextHandler(os.Stdout, &slog.HandlerOptions{
		AddSource: true,
		Level:     slog.LevelDebug,
		ReplaceAttr: func(_ []string, a slog.Attr) slog.Attr {
			if a.Key == "time" {
				return slog.Attr{}
			}
			if a.Key == "level" {
				return slog.Attr{}
			}
			if a.Key == slog.SourceKey {
				str := a.Value.String()
				split := strings.Split(str, "/")
				if len(split) > 2 {
					a.Value = slog.StringValue(strings.Join(split[len(split)-2:], "/"))
					a.Value = slog.StringValue(strings.Replace(a.Value.String(), "}", "", -1))
				}
				a.Key = a.Value.String()
				a.Value = slog.IntValue(0)
			}
			if a.Key == "body" {
				a.Value = slog.StringValue(strings.Replace(a.Value.String(), "/", "", -1))
				a.Value = slog.StringValue(strings.Replace(a.Value.String(), "\n", "", -1))
				a.Value = slog.StringValue(strings.Replace(a.Value.String(), "\"", "", -1))
			}
			return a
		}}))
)

const (
	blacklist   = "github-actions[bot]"
	emBlacklist = "noreply"
	igCommit    = "Format-and-Header"
)

// FillTemplate fills the template with the given data
func FillTemplate(
	authors []string,
	description string,
	name string,
	notes []string,
	content string,
) (string, error) {
	type data struct {
		Author  string
		Name    string
		Notes   []string
		Content string
		Desc    string
	}
	rNotes := []string{}
	for _, note := range notes {
		if strings.Contains(note, igCommit) {
			continue
		}
		rNotes = append(rNotes, note)
	}
	var builder strings.Builder
	err := file.Execute(&builder, data{
		Author:  strings.Join(authors, ", "),
		Name:    name,
		Notes:   rNotes,
		Content: content,
	})
	if err != nil {
		return "", err
	}
	return builder.String(), nil
}

// Authors returns a sorted list of authors from the given commits.
func (cs Commits) Authors() []string {
	var authors []string
	for _, c := range cs {
		if contains(authors, c.AuthorName) {
			continue
		}
		if strings.Contains(c.AuthorEmail, emBlacklist) {
			continue
		}
		if strings.Contains(c.AuthorName, blacklist) {
			continue
		}
		authors = append(authors, c.AuthorName)
	}
	return authors
}

// Notes returns a sorted list of notes from the given commits.
func (cs Commits) Notes() []string {
	var notes []string
	for _, c := range cs {
		if strings.Contains(c.Commit, igCommit) {
			continue
		}
		notes = append(notes, c.AuthorName+" "+c.Date+" "+c.Message)
	}
	return notes
}

func main() {
	ctx, cancel := context.WithCancel(context.Background())
	sigCh := make(chan os.Signal, 1)
	signal.Notify(sigCh, syscall.SIGINT, syscall.SIGTERM)
	go func() {
		<-sigCh
		cancel()
	}()
	defer cancel()
	if err := run(ctx); err != nil {
		fmt.Fprintf(os.Stderr, "Error: %v\n", err)
		fmt.Fprintf(os.Stdout, "Error: %v\n", err)
		os.Exit(1)
	}
}

// run is the main function that runs the program
func run(ctx context.Context) error {
	files, err := findFiles(ctx)
	if err != nil {
		log.Fatalf("Error finding VHDL files: %v", err)
	}

	// Add header to each VHDL file
	for _, file := range files {
		logger.Debug("Processing file", "file", file)
		commits, err := GetCommitHistory(ctx, file)
		if err != nil {
			return err
		}
		logger.Debug("Got Commits for file", "file", file)
		oldContent, err := os.ReadFile(file)
		if err != nil {
			return err
		}
		headless := reduceContent(ctx, string(oldContent))
		logger.Debug("Reduced Content", "file", file)
		newContent, err := FillTemplate(
			commits.Authors(),
			file,
			"",
			commits.Notes(),
			headless,
		)
		if err != nil {
			return err
		}
		logger.Debug("Filled Template", "file", file)
		if newContent != string(oldContent) {
			logger.Debug("Writing new content", "file", file)
			if err := os.WriteFile(file, []byte(newContent), 0644); err != nil {
				return err
			}
			continue
		}
		logger.Debug("No changes", "file", file)
	}
	return nil
}

// findFiles finds all files with the given extension, vhd.
func findFiles(ctx context.Context) ([]string, error) {
	extension := ".vhd"
	var files []string
	err := filepath.Walk(".", func(path string, info os.FileInfo, err error) error {
		select {
		case <-ctx.Done():
			return ctx.Err()
		default:
			if err != nil {
				return err
			}
			if !info.IsDir() && strings.HasSuffix(info.Name(), extension) {
				files = append(files, path)
			}
			return nil
		}
	})
	if err != nil {
		return nil, err
	}
	return files, nil
}

const (
	rmTill = "library ieee"
)

func reduceContent(ctx context.Context, content string) string {
	rCh := make(chan string)
	go func(rCh chan string, content string) {
		found := false
		newLines := []string{}
		for _, line := range strings.Split(content, "\n") {
			if found {
				newLines = append(newLines, line)
				continue
			}
			if strings.Contains(strings.ToLower(line), rmTill) {
				found = true
				newLines = append(newLines, line)
			}
		}
		newEndLines := []string{}
		newEndLines = append(newEndLines, newLines...)
		slices.Reverse(newEndLines)
		revLines := []string{}
		endFound := false
		for _, line := range newEndLines {
			if endFound {
				revLines = append(revLines, line)
				continue
			}
			if len(line) > 0 {
				endFound = true
				revLines = append(revLines, line)
			}
		}
		slices.Reverse(revLines)
		rCh <- strings.Join(revLines, "\n")
	}(rCh, content)
	select {
	case output := <-rCh:
		return output
	case <-ctx.Done():
		return ""
	}
}

// GetCommitHistory gets the commit history for a given file
func GetCommitHistory(ctx context.Context, path string) (Commits, error) {
	cmd := exec.Command("git", "log",
		"--date=iso8601-strict",
		"--all",
		"--pretty=format:{%n  \"commit\": \"%H\",%n  \"author_name\": \"%aN\", \"author_email\": \"<%aE>\",%n  \"date\": \"%ad\",%n  \"timestamp\": %at,%n  \"message\": \"%f\",%n  \"repo\": \"$repository\"%n},",
		path)
	var gitLogBuffer bytes.Buffer
	cmd.Stdout = &gitLogBuffer
	err := cmd.Run()
	if err != nil {
		return nil, err
	}
	output := gitLogBuffer.String()
	rCh := make(chan Commits)
	errCh := make(chan error)
	go func(rCh chan Commits, output string) {
		commits := []Commit{}
		entries := strings.Split(output, "},")
		for _, entry := range entries {
			entry = strings.TrimSuffix(entry, "}") // Handle trailing comma at the end
			entry = strings.TrimSpace(entry)
			if len(entry) == 0 {
				continue
			}
			// Clean up the JSON string and unmarshal it into the Commit struct
			entry = entry + "}" // Add closing brace back
			var commit Commit
			err = json.Unmarshal([]byte(entry), &commit)
			if err != nil {
				errCh <- err
			}
			commits = append(commits, commit)
		}
		rCh <- commits
	}(rCh, output)
	select {
	case commits := <-rCh:
		return commits, nil
	case err := <-errCh:
		return nil, err
	case <-ctx.Done():
		return nil, ctx.Err()
	}
}

func contains(s []string, e string) bool {
	for _, a := range s {
		if a == e {
			return true
		}
	}
	return false
}
