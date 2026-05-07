# kreuzberg-cloud-sdk

Official client SDKs for the [Kreuzberg Cloud](https://kreuzberg.cloud) API,
generated from the upstream OpenAPI 3.1 specification.

| Language | Package | Registry |
|----------|---------|----------|
| Python | `kreuzberg-cloud` | [PyPI](https://pypi.org/project/kreuzberg-cloud/) |
| TypeScript / Node.js | `@kreuzberg/cloud` | [npm](https://www.npmjs.com/package/@kreuzberg/cloud) |
| Go | `github.com/kreuzberg-dev/kreuzberg-cloud-sdk/go/v1` | [pkg.go.dev](https://pkg.go.dev/github.com/kreuzberg-dev/kreuzberg-cloud-sdk/go/v1) |

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

The OpenAPI spec is vendored from `kreuzberg-cloud`. To refresh:

```sh
task spec:fetch  # copy from ../kreuzberg-cloud/frontend/openapi-backend.yaml
```

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
