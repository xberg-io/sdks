// Command oapi-schemaset-config derives the oapi-codegen configuration for a
// SECONDARY schema set — one generated into a Go package that already holds the
// types of other specs.
//
// The Go SDK ships one package (`xberg`) built from three specs kept as separate
// schema sets (never merged; see xberg-enterprise ADR-0072): the Enterprise data
// plane, Pro, and the Enterprise control plane. Anything an earlier schema set
// already declares must therefore be excluded from a later one, or the two files
// declare the same Go identifier twice and the package stops compiling.
//
// That exclusion set used to be hand-maintained and went stale on every spec
// sync. This command computes it instead: it reads the specs already generated
// (`-prior`, repeatable, in generation order) and the spec being configured
// (`-spec`), intersects their `components.schemas` keys and their operation IDs,
// and writes a derived config that merges those two lists into a checked-in base
// config. A spec sync that adds, removes, or reclassifies a schema is picked up
// automatically the next time `mise run go:generate` runs.
//
// A shared NAME does not always mean a shared SHAPE. `ReadinessChecks`, for
// one, requires `nats` on Enterprise and `storage` on Pro — the two products
// genuinely report different dependencies. Excluding such a name would hand the
// later schema set the earlier struct, so a Pro caller would read a `Nats` field
// the service never sends and have no field at all for the one it does. Only the
// schemas that are structurally identical are therefore excluded; a divergent
// one is renamed behind `-prefix` in a derived copy of the spec, which is what
// oapi-codegen actually reads. The vendored spec is never touched, so it stays
// byte-identical to the upstream copy `mise run spec:fetch` vendors.
//
// A prior schema set that was itself generated from a derived copy must be
// passed as that DERIVED copy, not as its vendored original: the renames the
// earlier run applied are part of what the package declares, and a name it moved
// out of the way is free for this one.
package main

import (
	"errors"
	"flag"
	"fmt"
	"os"
	"path/filepath"
	"sort"
	"strings"

	"gopkg.in/yaml.v3"
)

const toolName = "oapi-schemaset-config"

// httpMethods are the path-item keys that hold an operation. Every other key
// (`parameters`, `summary`, `servers`, `$ref`, …) is metadata, not an operation.
var httpMethods = map[string]struct{}{
	"get":     {},
	"put":     {},
	"post":    {},
	"delete":  {},
	"options": {},
	"head":    {},
	"patch":   {},
	"trace":   {},
}

// documentationKeys hold prose only. Two schemas that differ solely in these
// keys generate identical Go types, so they are stripped before comparing a
// shared schema's two definitions.
var documentationKeys = map[string]struct{}{
	"description": {},
	"example":     {},
	"examples":    {},
	"summary":     {},
	"title":       {},
}

// specDocument is the narrow view of an OpenAPI document this command needs.
type specDocument struct {
	Components struct {
		Schemas map[string]any `yaml:"schemas"`
	} `yaml:"components"`
	Paths map[string]map[string]any `yaml:"paths"`
}

// specPaths collects a repeatable path flag, preserving the order it was given
// in — which is the order the schema sets are generated in.
type specPaths []string

func (p *specPaths) String() string { return strings.Join(*p, ",") }

func (p *specPaths) Set(value string) error {
	*p = append(*p, value)
	return nil
}

func main() {
	var priorSpecPaths specPaths
	flag.Var(&priorSpecPaths, "prior",
		"path to a spec whose Go types the package already declares; repeat in generation order")
	specPath := flag.String("spec", "", "path to the OpenAPI spec whose schema set is being configured")
	prefix := flag.String("prefix", "", "Go name prefix for a schema this spec declares with its own shape")
	basePath := flag.String("base", "", "path to the checked-in base oapi-codegen config for this schema set")
	outputPath := flag.String("out", "", "path of the derived oapi-codegen config to write")
	flag.Parse()

	if err := run(priorSpecPaths, *specPath, *prefix, *basePath, *outputPath); err != nil {
		fmt.Fprintf(os.Stderr, "%s: %v\n", toolName, err)
		os.Exit(1)
	}
}

func run(priorSpecPaths []string, specPath, prefix, basePath, outputPath string) error {
	for name, value := range map[string]string{
		"-spec": specPath, "-prefix": prefix, "-base": basePath, "-out": outputPath,
	} {
		if value == "" {
			return fmt.Errorf("%s is required", name)
		}
	}
	if len(priorSpecPaths) == 0 {
		return errors.New("-prior is required at least once")
	}

	priorSchemas, priorOperations, err := alreadyDeclared(priorSpecPaths)
	if err != nil {
		return err
	}
	spec, err := loadSpec(specPath)
	if err != nil {
		return err
	}

	sharedSchemas := intersection(keys(priorSchemas), keys(spec.Components.Schemas))
	newOperations := difference(operationIDs(spec), priorOperations)

	config, err := loadBaseConfig(basePath)
	if err != nil {
		return err
	}
	outputOptions, err := outputOptionsOf(config)
	if err != nil {
		return fmt.Errorf("reading %s: %w", basePath, err)
	}
	for _, key := range []string{"exclude-schemas", "include-operation-ids", "exclude-operation-ids"} {
		if _, present := outputOptions[key]; present {
			return fmt.Errorf("%s must not set output-options.%s — it is derived from the specs", basePath, key)
		}
	}

	// Only a shared name whose two definitions generate the same Go type may be
	// excluded. A divergent one is renamed instead, so this spec keeps its shape.
	divergent := divergentClosure(priorSchemas, spec, sharedSchemas)
	outputOptions["exclude-schemas"] = withoutNames(sharedSchemas, divergent)
	outputOptions["include-operation-ids"] = newOperations

	renames, err := typeNames(divergent, prefix, priorSchemas, spec)
	if err != nil {
		return err
	}
	if err := writeDerivedSpec(derivedSpecPathFor(outputPath, prefix), specPath, prefix, renames); err != nil {
		return err
	}
	for _, name := range divergent {
		fmt.Fprintf(os.Stderr,
			"%s: schema %q differs structurally from the already-generated definition; "+
				"this schema set emits it as %s\n", toolName, name, renames[name])
	}

	body, err := yaml.Marshal(config)
	if err != nil {
		return fmt.Errorf("marshalling derived config: %w", err)
	}
	document := header(basePath, prefix, sharedSchemas, newOperations, divergent) + string(body)
	if err := os.WriteFile(outputPath, []byte(document), 0o644); err != nil { //nolint:gosec // generated build input, not a secret
		return fmt.Errorf("writing %s: %w", outputPath, err)
	}

	fmt.Fprintf(os.Stderr,
		"%s: wrote %s (%d shared schemas excluded, %d renamed, %d new operations included)\n",
		toolName, outputPath, len(sharedSchemas)-len(divergent), len(divergent), len(newOperations))
	return nil
}

// alreadyDeclared merges the schemas and operation IDs of every schema set the
// package already holds into the two sets this run compares against.
//
// The first declaration of a name wins, and which one that is does not matter: a
// name two prior specs share is one an earlier run already proved structurally
// identical, and a name they declare differently was renamed apart by that run.
func alreadyDeclared(priorSpecPaths []string) (map[string]any, map[string]struct{}, error) {
	schemas := map[string]any{}
	operations := map[string]struct{}{}
	for _, path := range priorSpecPaths {
		spec, err := loadSpec(path)
		if err != nil {
			return nil, nil, err
		}
		for name, definition := range spec.Components.Schemas {
			if _, present := schemas[name]; !present {
				schemas[name] = definition
			}
		}
		for id := range operationIDs(spec) {
			operations[id] = struct{}{}
		}
	}
	return schemas, operations, nil
}

func loadSpec(path string) (*specDocument, error) {
	raw, err := os.ReadFile(path) //nolint:gosec // path comes from the go:generate task, not user input
	if err != nil {
		return nil, fmt.Errorf("reading spec %s: %w", path, err)
	}
	var spec specDocument
	if err := yaml.Unmarshal(raw, &spec); err != nil {
		return nil, fmt.Errorf("parsing spec %s: %w", path, err)
	}
	if len(spec.Components.Schemas) == 0 {
		return nil, fmt.Errorf("spec %s declares no components.schemas", path)
	}
	if len(spec.Paths) == 0 {
		return nil, fmt.Errorf("spec %s declares no paths", path)
	}
	return &spec, nil
}

func loadBaseConfig(path string) (map[string]any, error) {
	raw, err := os.ReadFile(path) //nolint:gosec // path comes from the go:generate task, not user input
	if err != nil {
		return nil, fmt.Errorf("reading base config %s: %w", path, err)
	}
	var config map[string]any
	if err := yaml.Unmarshal(raw, &config); err != nil {
		return nil, fmt.Errorf("parsing base config %s: %w", path, err)
	}
	if config == nil {
		return nil, fmt.Errorf("base config %s is empty", path)
	}
	return config, nil
}

// outputOptionsOf returns the config's `output-options` map, creating it when absent.
func outputOptionsOf(config map[string]any) (map[string]any, error) {
	value, present := config["output-options"]
	if !present || value == nil {
		options := map[string]any{}
		config["output-options"] = options
		return options, nil
	}
	options, ok := value.(map[string]any)
	if !ok {
		return nil, errors.New("output-options is not a mapping")
	}
	return options, nil
}

// operationIDs collects every operationId declared by the spec's paths.
func operationIDs(spec *specDocument) map[string]struct{} {
	ids := map[string]struct{}{}
	for _, pathItem := range spec.Paths {
		for method, rawOperation := range pathItem {
			if _, isMethod := httpMethods[strings.ToLower(method)]; !isMethod {
				continue
			}
			operation, ok := rawOperation.(map[string]any)
			if !ok {
				continue
			}
			if id, ok := operation["operationId"].(string); ok && id != "" {
				ids[id] = struct{}{}
			}
		}
	}
	return ids
}

// divergentSharedSchemas reports shared schema names whose two definitions
// differ beyond documentation, meaning this schema set would silently reuse the
// already-generated shape for a type its own spec describes differently.
func divergentSharedSchemas(priorSchemas map[string]any, spec *specDocument, shared []string) []string {
	var divergent []string
	for _, name := range shared {
		priorSchema := stripDocumentation(priorSchemas[name])
		schema := stripDocumentation(spec.Components.Schemas[name])
		priorRendered, priorErr := yaml.Marshal(priorSchema)
		rendered, err := yaml.Marshal(schema)
		if priorErr != nil || err != nil || string(priorRendered) != string(rendered) {
			divergent = append(divergent, name)
		}
	}
	return divergent
}

// schemaRefs collects the component schema names a definition references,
// at any depth.
func schemaRefs(value any) map[string]struct{} {
	found := map[string]struct{}{}
	var walk func(any)
	walk = func(node any) {
		switch typed := node.(type) {
		case map[string]any:
			for key, nested := range typed {
				if key == "$ref" {
					if target, ok := nested.(string); ok {
						found[target[strings.LastIndex(target, "/")+1:]] = struct{}{}
					}
					continue
				}
				walk(nested)
			}
		case []any:
			for _, nested := range typed {
				walk(nested)
			}
		}
	}
	walk(value)
	return found
}

// divergentClosure extends divergentSharedSchemas with every shared schema that
// reaches a divergent one through a `$ref`.
//
// Structural equality is not enough on its own. Pro's `ReadinessResponse` is
// word-for-word the Enterprise shape apart from prose, so it compares equal —
// but its `checks` field references `ReadinessChecks`, which is not. Excluding
// it would hand Pro an Enterprise `ReadinessResponse` whose `Checks` is the
// Enterprise struct, reintroducing through one field exactly the mismatch the
// rename removes. A schema is only safe to share when everything it reaches is.
func divergentClosure(priorSchemas map[string]any, spec *specDocument, shared []string) []string {
	divergent := map[string]struct{}{}
	for _, name := range divergentSharedSchemas(priorSchemas, spec, shared) {
		divergent[name] = struct{}{}
	}

	for changed := true; changed; {
		changed = false
		for _, name := range shared {
			if _, already := divergent[name]; already {
				continue
			}
			for reference := range schemaRefs(spec.Components.Schemas[name]) {
				if _, isDivergent := divergent[reference]; isDivergent {
					divergent[name] = struct{}{}
					changed = true
					break
				}
			}
		}
	}

	names := make([]string, 0, len(divergent))
	for name := range divergent {
		names = append(names, name)
	}
	sort.Strings(names)
	return names
}

// stripDocumentation recursively removes prose-only keys so two schemas that
// differ solely in wording compare equal.
func stripDocumentation(value any) any {
	switch typed := value.(type) {
	case map[string]any:
		stripped := make(map[string]any, len(typed))
		for key, nested := range typed {
			if _, isDoc := documentationKeys[key]; isDoc {
				continue
			}
			stripped[key] = stripDocumentation(nested)
		}
		return stripped
	case []any:
		stripped := make([]any, len(typed))
		for index, nested := range typed {
			stripped[index] = stripDocumentation(nested)
		}
		return stripped
	default:
		return value
	}
}

// typeNameFor is the Go identifier a divergent shared schema is emitted under in
// this schema set. The already-generated definition keeps the bare name.
func typeNameFor(prefix, schemaName string) string {
	return prefix + schemaName
}

// typeNames maps each divergent schema to its prefixed Go name, refusing a name
// any of the specs already declares. Without this guard the rename would trade
// one silent redeclaration for another.
func typeNames(divergent []string, prefix string, priorSchemas map[string]any,
	spec *specDocument,
) (map[string]string, error) {
	renames := make(map[string]string, len(divergent))
	for _, name := range divergent {
		renamed := typeNameFor(prefix, name)
		_, inPrior := priorSchemas[renamed]
		_, inSpec := spec.Components.Schemas[renamed]
		if inPrior || inSpec {
			return nil, fmt.Errorf(
				"schema %q differs from the already-generated definition and would be renamed to %q, "+
					"but that name is already declared; rename one of them upstream", name, renamed)
		}
		renames[name] = renamed
	}
	return renames, nil
}

// derivedSpecPathFor places the derived spec beside the derived config, so the
// two generated build inputs live and die together. The prefix is part of the
// name because every schema set derives its own copy into the same directory.
func derivedSpecPathFor(outputPath, prefix string) string {
	directory := filepath.Dir(outputPath)
	return filepath.Join(directory, "spec-"+strings.ToLower(prefix)+".gen.yaml")
}

// writeDerivedSpec copies the spec, renaming each divergent schema and every
// reference to it.
//
// It is written unconditionally, even when nothing is renamed, so the
// `mise run go:generate` step can always hand oapi-codegen the same path instead
// of branching on whether a rename happened.
func writeDerivedSpec(path, specPath, prefix string, renames map[string]string) error {
	raw, err := os.ReadFile(specPath) //nolint:gosec // path comes from the go:generate task, not user input
	if err != nil {
		return fmt.Errorf("reading spec %s: %w", specPath, err)
	}
	var document map[string]any
	if err := yaml.Unmarshal(raw, &document); err != nil {
		return fmt.Errorf("parsing spec %s: %w", specPath, err)
	}

	renameSchemaKeys(document, renames)
	renameSchemaRefs(document, renames)

	body, err := yaml.Marshal(document)
	if err != nil {
		return fmt.Errorf("marshalling derived spec: %w", err)
	}

	header := "# Code generated by tools/" + toolName + "; DO NOT EDIT.\n" +
		"#\n" +
		"# A copy of the vendored spec with every schema an already-generated schema set\n" +
		"# declares differently renamed behind a `" + prefix + "` prefix, so both shapes can\n" +
		"# live in one Go package. Edit the vendored spec — never this file.\n"

	if err := os.WriteFile(path, []byte(header+string(body)), 0o644); err != nil { //nolint:gosec // generated build input, not a secret
		return fmt.Errorf("writing %s: %w", path, err)
	}
	return nil
}

// renameSchemaKeys moves each renamed schema to its new key under
// components.schemas.
func renameSchemaKeys(document map[string]any, renames map[string]string) {
	components, ok := document["components"].(map[string]any)
	if !ok {
		return
	}
	schemas, ok := components["schemas"].(map[string]any)
	if !ok {
		return
	}
	for name, renamed := range renames {
		definition, present := schemas[name]
		if !present {
			continue
		}
		delete(schemas, name)
		schemas[renamed] = definition
	}
}

// renameSchemaRefs rewrites every `$ref` that points at a renamed schema.
func renameSchemaRefs(node any, renames map[string]string) {
	switch typed := node.(type) {
	case map[string]any:
		for key, nested := range typed {
			if key == "$ref" {
				reference, isString := nested.(string)
				if !isString {
					continue
				}
				name := reference[strings.LastIndex(reference, "/")+1:]
				if renamed, shouldRename := renames[name]; shouldRename {
					typed[key] = reference[:strings.LastIndex(reference, "/")+1] + renamed
				}
				continue
			}
			renameSchemaRefs(nested, renames)
		}
	case []any:
		for _, nested := range typed {
			renameSchemaRefs(nested, renames)
		}
	}
}

// withoutNames returns names minus every entry of excluded, preserving order.
func withoutNames(names, excluded []string) []string {
	drop := make(map[string]struct{}, len(excluded))
	for _, name := range excluded {
		drop[name] = struct{}{}
	}
	kept := make([]string, 0, len(names))
	for _, name := range names {
		if _, skip := drop[name]; !skip {
			kept = append(kept, name)
		}
	}
	return kept
}

func header(basePath, prefix string, shared, newOperations, divergent []string) string {
	var builder strings.Builder
	builder.WriteString("# Code generated by tools/" + toolName + "; DO NOT EDIT.\n")
	builder.WriteString("#\n")
	fmt.Fprintf(&builder, "# %s plus two lists derived from this spec and the ones already generated.\n", basePath)
	fmt.Fprintf(&builder, "# exclude-schemas is the %d schema names an earlier schema set already\n",
		len(shared)-len(divergent))
	fmt.Fprintf(&builder, "# declares identically; include-operation-ids is the %d operations this spec\n",
		len(newOperations))
	builder.WriteString("# declares and no earlier one does. Edit the base config or the specs — never\n")
	builder.WriteString("# this file.\n")
	if len(divergent) > 0 {
		builder.WriteString("#\n")
		builder.WriteString("# These shared schemas differ structurally from the already-generated definition,\n")
		builder.WriteString("# so this schema set emits each under its own Go name in the derived spec:\n")
		for _, name := range divergent {
			fmt.Fprintf(&builder, "#   %s -> %s\n", name, typeNameFor(prefix, name))
		}
	}
	return builder.String()
}

func keys(m map[string]any) map[string]struct{} {
	set := make(map[string]struct{}, len(m))
	for key := range m {
		set[key] = struct{}{}
	}
	return set
}

func intersection(left, right map[string]struct{}) []string {
	var both []string
	for key := range left {
		if _, present := right[key]; present {
			both = append(both, key)
		}
	}
	sort.Strings(both)
	return both
}

func difference(left, right map[string]struct{}) []string {
	var only []string
	for key := range left {
		if _, present := right[key]; !present {
			only = append(only, key)
		}
	}
	sort.Strings(only)
	return only
}
