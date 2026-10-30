---
status: accepted
date: 2026-09-07
decision-makers: ["Na'aman Hirschfeld"]
---

# Commit the generated Go sources

## Context and Problem Statement

The generated client code of all three packages was gitignored and produced by the generate task before a build. That
works for Python and TypeScript, whose registries receive a built artifact. A Go module is published as the tagged
source tree itself: `go get` resolves `github.com/xberg-io/sdks/packages/go` from the repository at the tag, so a
module whose `generated_{api,pro,backend}.go` were gitignored reached consumers without its types (4c4c0c0, "ship
generated sources in the published module"; CHANGELOG.md:308).

## Considered Options

* Commit the generated Go sources, and gate them against the vendored specs
* Keep every generated tree gitignored and generate it in CI before each build

## Decision Outcome

Chosen option: "Commit the generated Go sources, and gate them against the vendored specs", because the tagged
source tree is the only thing a Go consumer receives, so it must already contain the generated types.

* `packages/go/generated_api.go`, `generated_pro.go` and `generated_backend.go` are committed. The Python and
  TypeScript `_generated*` trees stay gitignored.
* `go:check:generated` regenerates the three files and fails on any diff. `go:test:package` extracts
  `packages/go` from `git archive HEAD`, checks that the generated files are non-empty and builds a consumer
  module against it.
* poly excludes the generated files from discovery, lint and format.

### Consequences

* Good, because a `go get` of any tag compiles without running a generator.
* Good, because a spec sync shows the change to the Go types in the pull request diff.
* Bad, because the generated files are large (12,111 lines for `generated_api.go` when first committed) and every
  spec sync rewrites them.
* Bad, because the packages differ: Go's generated code is reviewed in git, Python's and TypeScript's only through
  the built artifact.

### Confirmation

* `mise.toml:217` to `mise.toml:222` (`go:check:generated`) and `mise.toml:224` to `mise.toml:226`
  (`go:test:package`, `packages/go/test-package.sh`).
* `.github/workflows/ci-go.yml:82` to `ci-go.yml:85` run both on changes to the Go package or the specs, and `.github/workflows/publish.yaml:236`
  to `publish.yaml:239` before publishing.
* `.gitignore:39` to `.gitignore:43` list only the Python and TypeScript generated trees; `poly.toml:22` to
  `poly.toml:24` exclude the Go files.
