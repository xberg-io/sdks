package xberg_test

import (
	"encoding/json"
	"go/ast"
	"go/parser"
	"go/token"
	"go/types"
	"os"
	"path/filepath"
	"sort"
	"strings"
	"testing"
)

// ~keep Field-level pin of every exported type the published v0.9.0 module declares. The
// testdata/public-v0.9.0/contract.go check only proves a NAME still compiles; a spec sync that
// makes two specs share a schema name silently changes what that name means (ListDocumentsResponse
// became the data-room listing while keeping the identifier). Additive changes (new fields, new
// types) stay legal; a removed type, a removed field, or a field whose type or json tag changed fails.
const (
	contractSnapshot = "testdata/public-v0.9.0/fields.json"
	// Set to a directory holding the v0.9.0 package sources to rewrite the snapshot.
	contractSourceEnv = "XBERG_CONTRACT_SOURCE_DIR"
	// Set to any value to check the intended breaks below as well.
	contractExemptEnv = "XBERG_CONTRACT_NO_EXEMPT"
)

// ~keep Intended, documented breaks only. A spec-sync collision is never exempted here: rename the
// schema upstream instead (the data-room schemas became Room*/ProjectDocument* names for this reason).
var contractIntendedBreaks = map[string]bool{
	// Upstream made ExtractedImage.data optional (inline bytes can be omitted).
	"ExtractedImage":        true,
	"BackendExtractedImage": true,
}

type contractType map[string]string

func collectPublicTypes(t *testing.T, dir string) map[string]contractType {
	t.Helper()
	fset := token.NewFileSet()
	entries, err := os.ReadDir(dir)
	if err != nil {
		t.Fatalf("read %s: %v", dir, err)
	}
	var files []*ast.File
	for _, entry := range entries {
		name := entry.Name()
		if entry.IsDir() || !strings.HasSuffix(name, ".go") || strings.HasSuffix(name, "_test.go") {
			continue
		}
		file, err := parser.ParseFile(fset, filepath.Join(dir, name), nil, 0)
		if err != nil {
			t.Fatalf("parse %s: %v", name, err)
		}
		files = append(files, file)
	}
	if len(files) == 0 {
		t.Fatalf("no Go sources in %s", dir)
	}
	out := map[string]contractType{}
	for _, file := range files {
		for _, decl := range file.Decls {
			gen, ok := decl.(*ast.GenDecl)
			if !ok || gen.Tok != token.TYPE {
				continue
			}
			for _, spec := range gen.Specs {
				ts := spec.(*ast.TypeSpec)
				if !ts.Name.IsExported() {
					continue
				}
				out[ts.Name.Name] = describeType(ts)
			}
		}
	}
	return out
}

func describeType(ts *ast.TypeSpec) contractType {
	desc := contractType{}
	st, ok := ts.Type.(*ast.StructType)
	if !ok {
		desc["="] = types.ExprString(ts.Type)
		return desc
	}
	for _, field := range st.Fields.List {
		tag := ""
		if field.Tag != nil {
			tag = field.Tag.Value
		}
		typ := types.ExprString(field.Type)
		if len(field.Names) == 0 {
			desc["embed:"+typ] = typ + " " + tag
			continue
		}
		for _, name := range field.Names {
			desc[name.Name] = typ + " " + tag
		}
	}
	return desc
}

func TestPublicContractV090WriteSnapshot(t *testing.T) {
	source := os.Getenv(contractSourceEnv)
	if source == "" {
		t.Skipf("set %s to rewrite %s", contractSourceEnv, contractSnapshot)
	}
	snapshot := collectPublicTypes(t, source)
	if len(snapshot) < 700 {
		t.Fatalf("refusing to write a snapshot of only %d types", len(snapshot))
	}
	raw, err := json.MarshalIndent(snapshot, "", " ")
	if err != nil {
		t.Fatal(err)
	}
	if err := os.WriteFile(filepath.FromSlash(contractSnapshot), append(raw, '\n'), 0o644); err != nil {
		t.Fatal(err)
	}
}

func TestPublicContractV090FieldsAreStable(t *testing.T) {
	raw, err := os.ReadFile(filepath.FromSlash(contractSnapshot))
	if err != nil {
		t.Fatalf("read snapshot: %v", err)
	}
	var pinned map[string]contractType
	if err := json.Unmarshal(raw, &pinned); err != nil {
		t.Fatalf("decode snapshot: %v", err)
	}
	// A snapshot that decodes to nothing would pass every comparison below.
	if len(pinned) < 700 {
		t.Fatalf("snapshot pins only %d types, expected the 720 published in v0.9.0", len(pinned))
	}
	current := collectPublicTypes(t, ".")
	exempt := os.Getenv(contractExemptEnv) == ""

	names := make([]string, 0, len(pinned))
	for name := range pinned {
		names = append(names, name)
	}
	sort.Strings(names)

	var problems []string
	for _, name := range names {
		if exempt && contractIntendedBreaks[name] {
			continue
		}
		got, ok := current[name]
		if !ok {
			problems = append(problems, name+": type removed")
			continue
		}
		for field, want := range pinned[name] {
			have, ok := got[field]
			switch {
			case !ok:
				problems = append(problems, name+"."+field+": removed")
			case have != want:
				problems = append(problems, name+"."+field+": was `"+want+"`, now `"+have+"`")
			}
		}
	}
	if len(problems) > 0 {
		t.Fatalf("%d public v0.9.0 contract break(s):\n%s", len(problems), strings.Join(problems, "\n"))
	}
}
