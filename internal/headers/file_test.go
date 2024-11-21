package main

import (
	"context"
	_ "embed"
	"encoding/json"
	"testing"

	"github.com/kylelemons/godebug/diff"
)

//go:embed testdata/basic_input.json
var input string

//go:embed testdata/basic_golden.vhd.t
var golden string

//go:embed testdata/basic.vhd.t
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
		t.Fail()
	}

}
