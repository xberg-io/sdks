---
status: accepted
date: 2026-07-31
decision-makers: ["Na'aman Hirschfeld"]
---

# One dual-target client per language

## Context and Problem Statement

The repository started as `kreuzberg-cloud-sdk`, a client for one hosted REST API generated from one vendored spec
(99e810a, 2026-05-07). The product then split into Xberg Enterprise and Xberg Pro, two self-hosted products over one
overlapping API with tier-specific operations on each side. Each language needed a way to reach both, and
xberg-enterprise had just decided, in its ADR-0072 (2026-07-26), not to maintain a single merged OpenAPI document,
because Pro and Enterprise mount different route sets and operation ids collide when documents are merged.

## Considered Options

* One client per language that serves both tiers, generated from separate, unmerged schema sets
* Two packages per language, one per tier
* One client generated from a merged spec

## Decision Outcome

Chosen option: "One client per language that serves both tiers, generated from separate, unmerged schema sets",
because the shared surface is written once and serves either deployment, while keeping each spec as published avoids
the operation-id collisions a merge produces and keeps the generated types honest to each service's topology
(`mise.toml:92`).

* Python, TypeScript and Go each ship one client (`XbergClient`, plus `AsyncXbergClient` in Python). The shared
  surface carries no tier gate; tier-specific methods are gated as ADR-0002 records.
* Each schema set generates into its own module: `_generated_api`, `_generated_pro` and `_generated_backend` in
  Python, `_generated/{api,pro,backend}` in TypeScript, `generated_{api,pro,backend}.go` in Go.
* The third set, the Enterprise control plane, was added in 932bd2c (2026-09-06), because without it the Enterprise
  target could not create a project or mint an API key while the Pro target could.

The Python (aca1bf4), TypeScript (8431d14) and Go (285925f) clients were reworked on the same day.

### Consequences

* Good, because a user installs one package per language whichever product the deployment runs.
* Good, because a spec change in one tier regenerates only that tier's module.
* Bad, because the client must know or discover the tier before a tier-specific call (ADR-0002).
* Bad, because Go puts all three sets in one package, so `tools/oapi-schemaset-config` has to derive a config for
  each secondary set that excludes the types an earlier set already defines.

### Confirmation

* `docs-site/src/content/docs/concepts/tiers.md:6` ("Rather than two packages per language, each package carries
  one client that works against either").
* `mise.toml:87` to `mise.toml:93` (three specs, one dual-target client, "Merging is deliberately avoided").
* `packages/python/src/xberg_io_sdk/client.py:1` to `client.py:10`; `tools/oapi-schemaset-config/main.go:5` to
  `main.go:7`.
* `packages/python/tests/test_dual_target.py`, `packages/typescript/tests/dual-target.test.ts` and
  `packages/go/dual_target_test.go` run in `ci-python.yml`, `ci-typescript.yml` and `ci-go.yml`.

## More Information

* [xberg-enterprise ADR-0072](https://github.com/xberg-io/xberg-enterprise/blob/development/adrs/0072-openapi-generated-typed-client-contract.md)
