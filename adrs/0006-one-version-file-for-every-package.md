---
status: accepted
date: 2026-05-07
decision-makers: ["Na'aman Hirschfeld"]
---

# One VERSION file for every package

## Context and Problem Statement

The repository publishes a Python, a TypeScript and a Go package from one tree, each with its own version fields: the
manifests, and the constants that feed `__version__` and the User-Agent. They need a single release version, and the
scaffold had to say where it is set.

## Considered Options

* One `VERSION` file at the root, propagated to every package by `scripts/sync-versions.py`

No alternatives were recorded.

## Decision Outcome

Chosen option: "One `VERSION` file at the root, propagated to every package by `scripts/sync-versions.py`", because
it releases the packages in lockstep from one edit, as the scaffold commit set out ("single-version source of truth
(VERSION file) propagated via scripts/sync-versions.py", 99e810a).

* A release edits `VERSION`, then runs `mise run version:sync`, which writes `packages/python/pyproject.toml`,
  `packages/python/src/xberg_io_sdk/__init__.py`, `packages/typescript/package.json`,
  `packages/typescript/src/version.ts` and `packages/go/version.go`.
* `sync-versions.py --check` reports drift without writing, and the script checks that every target exists before
  its first write (9f011e2, 5954e59).
* The publish workflow compares the tag, `VERSION` and all five targets before anything is published.

### Consequences

* Good, because the three packages always carry the same version, so one tag names one release of all three.
* Bad, because a change to one language still bumps all three packages.
* Bad, because every new version-carrying file must be added to both the script and the publish check; a path the
  script lost after a module move once left a bump half-applied (5d7f0a9).

### Confirmation

* `VERSION`; `scripts/sync-versions.py:2` to `sync-versions.py:4` and `sync-versions.py:187` (all targets must
  exist).
* `mise.toml:83` to `mise.toml:86` (`version:sync`).
* `.github/workflows/publish.yaml:74` to `publish.yaml:100` (`validate-versions`).
* `.ai-rulez/context/area-map.md:18`.
