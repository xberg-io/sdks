---
status: accepted
date: 2026-09-05
decision-makers: ["Na'aman Hirschfeld"]
---

# Python, TypeScript and Go only

## Context and Problem Statement

A Dart SDK, generated with `swagger_parser`, was added beside the Python, TypeScript and Go packages (cb0959a,
2026-05-11). It never gained Pro support, so it was the one client that could not honour the dual-target contract of
ADR-0001. Its generated tree had to be committed, because pub.dev archives ship git-tracked files only, and it had no
CI workflow or coverage tooling to catch regeneration drift. It had no known consumers (0b55029).

## Considered Options

* Remove the Dart SDK and ship Python, TypeScript and Go only
* Bring the Dart SDK up to dual-target parity

## Decision Outcome

Chosen option: "Remove the Dart SDK and ship Python, TypeScript and Go only", because with no known consumers,
deleting it was cheaper than bringing it up to parity (CHANGELOG.md:467 to CHANGELOG.md:474).

* 0b55029 removed `packages/dart`, its task file, the pub.dev publish workflow, its leg of the release
  version-consistency gate and its `sync-versions` targets.
* The `kreuzberg_cloud_sdk` package on pub.dev is no longer built or published.

### Consequences

* Good, because every shipped client honours the dual-target contract and is covered by CI and the release gates.
* Bad, because Dart and Flutter users have no maintained client and must call the HTTP API directly or generate their
  own from `spec/`.

### Confirmation

* `packages/` holds only `go`, `python` and `typescript`; `README.md:34` to `README.md:36` list the three packages.
* `.github/workflows/publish.yaml:241` (`publish-pypi`) and `publish.yaml:269` (`publish-npm`) are the only registry
  publish jobs, and `publish.yaml:300` (`tag-go`) tags the Go module.
