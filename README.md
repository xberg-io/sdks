<p align="center">
  <picture>
    <source media="(prefers-color-scheme: dark)" srcset="https://cdn.jsdelivr.net/gh/xberg-io/assets@v1/banner/readme-banner-dark.svg">
    <img alt="Xberg" width="420" src="https://cdn.jsdelivr.net/gh/xberg-io/assets@v1/banner/readme-banner-light.svg">
  </picture>
</p>

# xberg-io-sdk

<div align="center" style="display: flex; flex-wrap: wrap; gap: 8px; justify-content: center; margin: 20px 0;">

<a href="https://pypi.org/project/xberg-io-sdk/"><img src="https://img.shields.io/pypi/v/xberg-io-sdk?label=PyPI&color=007ec6" alt="PyPI"></a>
<a href="https://www.npmjs.com/package/@xberg-io/sdk"><img src="https://img.shields.io/npm/v/%40xberg-io%2Fsdk?label=npm&color=007ec6" alt="npm"></a>
<a href="https://pkg.go.dev/github.com/xberg-io/sdks/packages/go"><img src="https://img.shields.io/badge/Go-pkg.go.dev-007ec6?logo=go&logoColor=white" alt="Go Reference"></a>
<a href="https://github.com/xberg-io/sdks/blob/main/LICENSE"><img src="https://img.shields.io/badge/License-MIT-007ec6" alt="License"></a>
<a href="https://docs.sdks.xberg.io"><img src="https://img.shields.io/badge/docs-docs.sdks.xberg.io-007ec6" alt="Documentation"></a>
<a href="https://github.com/xberg-io/sdks/actions/workflows/validate.yml"><img src="https://github.com/xberg-io/sdks/actions/workflows/validate.yml/badge.svg" alt="CI"></a>

</div>

<div align="center" style="margin-top: 20px;">

<a href="https://discord.gg/xt9WY3GnKR"><img height="22" src="https://img.shields.io/badge/Discord-Join%20our%20community-7289da?logo=discord&logoColor=white" alt="Discord"></a>

</div>

Official client SDKs for the extraction API served by [Xberg Enterprise](https://xberg.io)
and Xberg Pro. One package per language, one dual-target client:
point it at an Enterprise or a Pro deployment and it exposes the shared surface plus the tier-specific
methods available on that target. Generated from the upstream OpenAPI 3.1 specifications.

| Language | Package | Registry | Codegen |
|----------|---------|----------|---------|
| Python | `xberg-io-sdk` | [PyPI](https://pypi.org/project/xberg-io-sdk/) | openapi-python-client (httpx) |
| TypeScript / Node.js | `@xberg-io/sdk` | [npm](https://www.npmjs.com/package/@xberg-io/sdk) | openapi-typescript (openapi-fetch) |
| Go | `github.com/xberg-io/sdks/packages/go` | [pkg.go.dev](https://pkg.go.dev/github.com/xberg-io/sdks/packages/go) | oapi-codegen |

## Install

**Python:**

```sh
pip install xberg-io-sdk
```

**TypeScript / Node.js:**

```sh
pnpm add @xberg-io/sdk
# or npm install @xberg-io/sdk
# or yarn add @xberg-io/sdk
```

**Go:**

```sh
go get github.com/xberg-io/sdks/packages/go
```

Read the [documentation](https://docs.sdks.xberg.io) or the package guides for
[Python](packages/python/README.md), [TypeScript](packages/typescript/README.md), and [Go](packages/go/README.md).

## Documentation

- SDK docs and API reference: [docs.sdks.xberg.io](https://docs.sdks.xberg.io)
- Product overview: [xberg.io](https://xberg.io)
- OpenAPI specifications: [`spec/`](https://github.com/xberg-io/sdks/tree/main/spec) — the vendored contracts these clients are generated from
- Changelog: [CHANGELOG.md](CHANGELOG.md)

## Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md) for development workflows, repo layout, and release procedures.

## License

MIT — see [LICENSE](LICENSE).
