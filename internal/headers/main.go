// Package main contains the main package of the header program.
package main

import (
	"bytes"
	_ "embed"
	"encoding/json"
	"fmt"
	"log"
	"log/slog"
	"os"
	"os/exec"
	"path/filepath"
	"strings"
	"text/template"
)

var (
	blacklist   = "github-actions[bot]"
	emBlacklist = "noreply"
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

//go:embed file.tmpl
var fileTemplate string

var file = template.Must(template.New("file").Parse(fileTemplate))

// FillTemplate fills the template with the given data
func FillTemplate(
	authors []string,
	name string,
	notes []string,
	content string,
) (string, error) {
	type data struct {
		Author  string
		Name    string
		Notes   []string
		Content string
	}
	var builder strings.Builder
	err := file.Execute(&builder, data{
		Author:  strings.Join(authors, ", "),
		Name:    name,
		Notes:   notes,
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
		authors = append(authors, c.AuthorName+" <"+c.AuthorEmail+">")
	}
	return authors
}

// Notes returns a sorted list of notes from the given commits.
func (cs Commits) Notes() []string {
	var notes []string
	for _, c := range cs {
		notes = append(notes, c.AuthorName+" "+c.Date+" "+c.Message)
	}
	return notes
}

var (
	logger = slog.New(slog.NewTextHandler(os.Stdout, &slog.HandlerOptions{
		AddSource: true,
		Level:     slog.LevelDebug,
		ReplaceAttr: func(groups []string, a slog.Attr) slog.Attr {
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

func main() {
	if err := run(); err != nil {
		fmt.Fprintf(os.Stderr, "Error: %v\n", err)
		fmt.Fprintf(os.Stdout, "Error: %v\n", err)
		os.Exit(1)
	}
}

// run is the main function that runs the program
func run() error {
	files, err := findFiles()
	if err != nil {
		log.Fatalf("Error finding VHDL files: %v", err)
	}

	// Add header to each VHDL file
	for _, file := range files {
		commits, err := GetCommitHistory(file)
		if err != nil {
			return err
		}
		oldContent, err := os.ReadFile(file)
		if err != nil {
			return err
		}
		headless := removeHeader(string(oldContent))
		newContent, err := FillTemplate(
			commits.Authors(),
			file,
			commits.Notes(),
			headless,
		)
		if err != nil {
			return err
		}
		if newContent != string(oldContent) {
			if err := os.WriteFile(file, []byte(newContent), 0644); err != nil {
				return err
			}
		}
	}
	return nil
}

// findFiles finds all files with the given extension, vhd.
func findFiles() ([]string, error) {
	extension := ".vhd"
	var files []string
	err := filepath.Walk(".", func(path string, info os.FileInfo, err error) error {
		if err != nil {
			return err
		}
		if !info.IsDir() && strings.HasSuffix(info.Name(), extension) {
			files = append(files, path)
		}
		return nil
	})
	if err != nil {
		return nil, err
	}
	return files, nil
}

func removeHeader(content string) string {
	lines := strings.Split(content, "\n")
	var start bool
	var done bool
	newLines := []string{}
	empties := []int{}
	for _, line := range lines {
		if strings.HasPrefix(line, "-- <header>") {
			start = true
			continue
		}
		if strings.HasPrefix(line, "-- </header>") {
			done = true
			continue
		}
		if start && done {
			newLines = append(newLines, line)
		}
		if line == "" {
			empties = append(empties, len(newLines))
		}
		if line != "" {
			empties = []int{}
		}
	}
	content = strings.Join(newLines[:empties[0]], "\n")
	return content
}

// GetCommitHistory gets the commit history for a given file
func GetCommitHistory(path string) (Commits, error) {
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
			return nil, err
		}
		commits = append(commits, commit)
	}
	return commits, err
}
func contains(s []string, e string) bool {
	for _, a := range s {
		if a == e {
			return true
		}
	}
	return false
}
