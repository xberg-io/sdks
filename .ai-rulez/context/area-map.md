---
type: Concept
title: Area Map
x-ai-rulez:
  kind: context
  id: area-map
  metadata:
    priority: high
---

## Area Map

Dual-target (Enterprise + Pro) API clients for Go, Python and TypeScript, generated from three vendored OpenAPI specs.

- `spec/{api,pro,backend}/openapi.yaml` — copied from xberg-enterprise `development` (its `main` trails). `mise run spec:fetch` reads `../xberg-enterprise` as checked out; in a worktree set `XBERG_ENTERPRISE_DIR`. `spec-sync.yml` opens the refresh PR.
- `packages/{go,python,typescript}` — hand-written clients over generated code. `mise run generate` writes the committed `packages/go/generated_*.go` and the gitignored Python/TS `_generated*` trees; never hand-edit them. Drift gates: `go:check:generated`, `spec:coverage`, `docs:reference:check`.
- `docs-site/` — Starlight site; `reference/api-*.md` is generated (`mise run docs:reference`).
- Versions: edit `VERSION`, then `mise run version:sync`.
- `enterprise:*` / `pro:*` run isolated live stacks from `../xberg-enterprise` (same override); `pro:up` needs `PRO_IMAGE` naming a locally built Pro image.
