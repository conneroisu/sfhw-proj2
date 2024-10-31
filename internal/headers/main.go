package main

import (
	"bufio"
	"bytes"
	"encoding/json"
	"fmt"
	"log"
	"log/slog"
	"os"
	"os/exec"
	"path/filepath"
	"strings"
)

var (
	blacklist   = "github-actions[bot]"
	emBlacklist = "noreply"
)

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

// Header template for VHDL files
const headerTemplate = `-- <header>
-- Author(s): %s
-- Name: %s
-- Notes:
%s
-- </header>

`

// CommitInfo stores commit details for a contributor
type CommitInfo struct {
	AuthorName  string
	AuthorEmail string
	CommitMsg   string
}

func main() {
	// Define the file type that you want to add headers to
	fileExtension := ".vhd"

	// Get the list of all files with the given extension
	files, err := findFilesWithExtension(fileExtension)
	if err != nil {
		log.Fatalf("Error finding VHDL files: %v", err)
	}

	// Add header to each VHDL file
	for _, file := range files {
		commitInfos, err := GetCommitHistory(file)
		if err != nil {
			log.Printf("Error getting commit history for %s: %v", file, err)
			continue
		}

		// Generate header content based on commit information
		headerContent := generateHeader(file, commitInfos)
		if err := updateHeaderInFile(file, headerContent); err != nil {
			log.Printf("Error updating header in file %s: %v", file, err)
		}
	}
}

// findFilesWithExtension finds all files with the given extension
func findFilesWithExtension(extension string) ([]string, error) {
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

// Commit is a struct for parsing the output of git log.
type Commit struct {
	Commit      string `json:"commit"`
	AuthorName  string `json:"author_name"`
	AuthorEmail string `json:"author_email"`
	Date        string `json:"date"`
	Timestamp   int64  `json:"timestamp"`
	Message     string `json:"message"`
	Repo        string `json:"repo"`
}

// GetCommitHistory gets the commit history for a given file
func GetCommitHistory(filename string) ([]Commit, error) {
	cmd := exec.Command("git", "log",
		"--date=iso8601-strict",
		"--all",
		"--pretty=format:{%n  \"commit\": \"%H\",%n  \"author_name\": \"%aN\", \"author_email\": \"<%aE>\",%n  \"date\": \"%ad\",%n  \"timestamp\": %at,%n  \"message\": \"%f\",%n  \"repo\": \"$repository\"%n},",
		filename)

	var gitLogBuffer bytes.Buffer
	cmd.Stdout = &gitLogBuffer

	err := cmd.Run()
	if err != nil {
		log.Fatalf("Failed to run git log command: %v", err)
	}

	output := gitLogBuffer.String()

	// Split the output by lines and process each commit
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
			log.Printf("Error unmarshalling commit entry: %v", err)
			continue
		}
		commits = append(commits, commit)
	}
	return commits, err
}

// generateHeader generates the header content for a VHDL file
func generateHeader(filename string, commitInfos []Commit) string {
	var notes strings.Builder
	authors := []string{}
	for i, commit := range commitInfos {
		if commit.AuthorName == blacklist {
			logger.Debug("Blacklisted author", slog.String("author", commit.AuthorName))
			continue
		}
		if strings.Contains(commit.AuthorEmail, emBlacklist) {
			logger.Debug("Blacklisted email", slog.String("email", commit.AuthorEmail))
			continue
		}
		if !contains(authors, commit.AuthorName) {
			authors = append(authors, commit.AuthorName)
		}
		notes.WriteString(fmt.Sprintf("--	%s  %s %s", commit.AuthorName, commit.AuthorEmail, commit.Message))
		if i < len(commitInfos)-1 {
			notes.WriteString("\n")
		}
	}
	return fmt.Sprintf(headerTemplate, strings.Join(authors, ", "), filename, notes.String())
}
func contains(s []string, e string) bool {
	for _, a := range s {
		if a == e {
			return true
		}
	}
	return false
}

// updateHeaderInFile updates the header in the VHDL file if the content has changed
func updateHeaderInFile(filename, headerContent string) error {
	// Read the original content of the file
	file, err := os.Open(filename)
	if err != nil {
		return err
	}
	defer file.Close()

	var originalContent strings.Builder
	scanner := bufio.NewScanner(file)
	insideHeader := false
	for scanner.Scan() {
		line := scanner.Text()
		if strings.Contains(line, "-- <header>") {
			insideHeader = true
		}
		if insideHeader && strings.Contains(line, "-- </header>") {
			insideHeader = false
			continue
		}
		if !insideHeader {
			originalContent.WriteString(line + "\n")
		}
	}

	if err := scanner.Err(); err != nil {
		return err
	}

	ogCnt := ""
	done := false
	for _, line := range strings.Split(originalContent.String(), "\n") {
		if !done && line == "" {
			continue
		}
		if strings.Contains(line, "library ie") {
			done = true
		}
		ogCnt += line + "\n"
	}
	// Combine the new header with the original content
	newContent := headerContent + ogCnt

	// Check if the new content is different from the current content
	currentContent, err := os.ReadFile(filename)
	if err != nil {
		return err
	}

	if newContent == string(currentContent) {
		// No changes needed
		return nil
	}

	// Write the updated content to the file
	return os.WriteFile(filename, []byte(newContent), 0644)
}
