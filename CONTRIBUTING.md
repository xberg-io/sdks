# Contributing to kreuzberg-cloud-sdk

[← Back to README](README.md)

Official client SDKs for the Xberg Enterprise public extraction API, generated from the upstream OpenAPI 3.1 specification.

## Layout

```text
packages/
  python/         # PyPI distribution (httpx-based, sync + async)
  typescript/     # npm distribution (ESM-only, openapi-fetch)
  go/v1/          # Go module — hand-written interim while oapi-codegen 3.1 support is upstream-blocked
spec/
  openapi.yaml    # Vendored copy of the API spec
tasks/            # Per-language Taskfile fragments
scripts/
  sync-versions.py  # Propagates the root VERSION file into every per-package manifest
VERSION           # Single source of truth for the SDK version across all three packages
```

## Development

This repo is part of the [`kreuzberg-dev`](https://github.com/xberg-io) polyrepo.

```sh
task setup       # install pnpm + uv + Go deps, install pre-commit hooks
task generate    # regenerate clients from spec/openapi.yaml
task test        # run all language test suites
task lint        # prek run --all-files
task build       # build all language packages
```

The OpenAPI spec is vendored from `xberg-enterprise`. The source of truth is the public extraction API spec emitted by `services/api` (utoipa-generated) and committed at `xberg-enterprise/services/api/spec/openapi.json`. To refresh:

```sh
task spec:fetch  # copy + JSON→YAML from ../xberg-enterprise/services/api/spec/openapi.json
```

CI also runs a weekly `spec-sync` workflow that opens an automated PR with the latest snapshot.

## Versioning

The single source of truth is the root `VERSION` file. `scripts/sync-versions.py` (run via `task version:sync`) propagates that value into every per-package manifest:

- `packages/python/pyproject.toml` (`project.version`)
- `packages/python/src/kreuzberg_cloud/__init__.py` (`__version__`)
- `packages/typescript/package.json` (`version`)
- `packages/go/v1/version.go` (`const Version`)

Go module versions for the module path itself live in git tags only (`packages/go/v1/vX.Y.Z`), created automatically by the release workflow.

Tasks:

- `task version:show` — print current version
- `task version:set -- X.Y.Z` — set explicit version, propagate, validate
- `task version:bump:patch` / `bump:minor` / `bump:major` — semver-aware wrappers

## Releasing

Releases use a single unified `vX.Y.Z` tag that drives all three publishes from one workflow run.

1. `task version:set -- X.Y.Z` — propagates the new version to every manifest.
2. `task release:check` — pre-flight: validates semver, runs lint + test + build.
3. Commit: `git commit -am "chore(release): vX.Y.Z"` and open a PR to `main`.
4. After merge to `main`: `git checkout main && git pull && task release:tag` creates the annotated `vX.Y.Z` tag locally (refuses to run on a dirty tree).
5. `git push origin vX.Y.Z` — pushes the tag, triggering `.github/workflows/publish.yaml`:
   - Validates every manifest matches the tag's version.
   - Pre-checks PyPI + npm registries; skips already-published versions.
   - Builds + publishes Python (PyPI, OIDC trusted publisher) and TypeScript (npm, `--provenance`, org `NPM_TOKEN`).
   - Creates the Go module subtag `packages/go/v1/vX.Y.Z` via `xberg-io/actions/finalize-release@v1`.
   - Auto-generates a GitHub Release with notes.
6. `workflow_dispatch` supports `dry_run=true` and `force_republish=true` for staged verification before tagging.

## Code style & checks

Run `prek run --all-files` to validate formatting, linting, and type checking across all languages. Pre-commit hooks enforce this automatically.

## Contact

- Issues: <https://github.com/xberg-io/sdks/issues>
- Email: <contact@xberg.io>
- Discord: <https://discord.gg/xt9WY3GnKR>
