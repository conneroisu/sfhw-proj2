package main

import "testing"

func TestFile(t *testing.T) {
	content := "hello world"
	authors := []string{"conneroisu", "Conner Ohnesorge"}
	notes := []string{"note1", "note2"}
	name := "test.vhd"

	output, err := FillTemplate(authors, name, notes, content)
	if err != nil {
		t.Errorf("Error: %v", err)
	}
	t.Log(output)
}
