package main

import (
	"context"
	_ "embed"
	"encoding/json"
	"os"
	"testing"

	"github.com/kylelemons/godebug/diff"
)

//go:embed testdata/basic_input.json
var input string

//go:embed testdata/golden_basic.vhd
var golden string

//go:embed testdata/basic.vhd
var content string

func TestFile(t *testing.T) {
	var commits Commits
	ctx := context.Background()
	err := json.Unmarshal([]byte(input), &commits)
	if err != nil {
		t.Errorf("Error: %v", err)
	}

	file := "internal/headers/testdata/golden_basic.vhd"
	headless := reduceContent(ctx, string(content))
	output, err := FillTemplate(commits.Authors(), file, commits.Notes(), headless)
	if err != nil {
		t.Errorf("Error: %v", err)
	}
	if output != golden {
		differences := diff.Diff(golden, output)
		t.Logf("Differences: \n%s", differences)
		// write the output to a file for debugging
		err = os.WriteFile("output.vhd", []byte(output), 0644)
		if err != nil {
			t.Errorf("Error: %v", err)
		}
		err = os.WriteFile("golden.vhd", []byte(golden), 0644)
		if err != nil {
			t.Errorf("Error: %v", err)
		}
	}
}
