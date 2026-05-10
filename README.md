# kreuzberg-cloud-sdk

Official client SDKs for the [Kreuzberg Cloud](https://kreuzberg.cloud)
public extraction API, generated from the upstream OpenAPI 3.1 specification
(`kreuzberg-cloud/services/api/spec/openapi.json`).

[![PyPI](https://img.shields.io/pypi/v/kreuzberg-cloud?label=PyPI&color=blue)](https://pypi.org/project/kreuzberg-cloud/)
[![npm](https://img.shields.io/npm/v/%40kreuzberg%2Fcloud?label=npm&color=red)](https://www.npmjs.com/package/@kreuzberg/cloud)
[![Go Reference](https://pkg.go.dev/badge/github.com/kreuzberg-dev/kreuzberg-cloud-sdk/go/v1.svg)](https://pkg.go.dev/github.com/kreuzberg-dev/kreuzberg-cloud-sdk/go/v1)
[![License](https://img.shields.io/badge/license-MIT-green)](LICENSE)
[![CI](https://github.com/kreuzberg-dev/kreuzberg-cloud-sdk/actions/workflows/validate.yml/badge.svg)](https://github.com/kreuzberg-dev/kreuzberg-cloud-sdk/actions/workflows/validate.yml)

| Language | Package | Registry | Status |
|----------|---------|----------|--------|
| Python | `kreuzberg-cloud` | [PyPI](https://pypi.org/project/kreuzberg-cloud/) | generated (httpx) |
| TypeScript / Node.js | `@kreuzberg/cloud` | [npm](https://www.npmjs.com/package/@kreuzberg/cloud) | generated (openapi-fetch) |
| Go | `github.com/kreuzberg-dev/kreuzberg-cloud-sdk/go/v1` | [pkg.go.dev](https://pkg.go.dev/github.com/kreuzberg-dev/kreuzberg-cloud-sdk/go/v1) | hand-written interim — codegen blocked on [oapi-codegen 3.1 support](https://github.com/oapi-codegen/oapi-codegen/issues/373) |

## Install

**Python:**
```sh
pip install kreuzberg-cloud
```

**TypeScript / Node.js:**
```sh
pnpm add @kreuzberg/cloud
# or npm install @kreuzberg/cloud
# or yarn add @kreuzberg/cloud
```

**Go:**
```sh
go get github.com/kreuzberg-dev/kreuzberg-cloud-sdk/go/v1
```

For language-specific details, examples, and API documentation, see the per-language READMEs in `packages/{python,typescript,go/v1}/`.

## Layout

```
packages/
  python/         # PyPI distribution (httpx-based, fully async)
  typescript/     # npm distribution (ESM-only, openapi-fetch)
  go/v1/          # Go module (oapi-codegen, stdlib net/http)
spec/
  openapi.yaml    # Vendored copy of the API spec
tasks/            # Per-language Taskfile fragments
```

## Development

This repo is part of the [`kreuzberg-dev`](https://github.com/kreuzberg-dev) polyrepo.

```sh
task setup       # install pnpm + uv + Go deps, install pre-commit hooks
task generate    # regenerate clients from spec/openapi.yaml
task lint        # prek run --all-files
task test        # run all language test suites
```

The OpenAPI spec is vendored from `kreuzberg-cloud`. The source of truth is
the public extraction API spec emitted by `services/api` (utoipa-generated)
and committed at `kreuzberg-cloud/services/api/spec/openapi.json`. To refresh:

```sh
task spec:fetch  # copy + JSON→YAML from ../kreuzberg-cloud/services/api/spec/openapi.json
```

CI also runs a weekly `spec-sync` workflow that opens an automated PR with
the latest snapshot.

## Versioning

Each package versions independently; tags are language-scoped:

- `python-vX.Y.Z` → PyPI
- `ts-vX.Y.Z` → npm
- `go/vX.Y.Z` → Go module proxy

## Contact

- Issues: https://github.com/kreuzberg-dev/kreuzberg-cloud-sdk/issues
- Email: contact@kreuzberg.dev

## License

MIT © Kreuzberg, Inc. — see [LICENSE](./LICENSE).
