# kreuzberg-cloud-sdk

<div align="center">

<img width="3384" height="573" alt="Xberg Enterprise" src="https://github.com/user-attachments/assets/1b6c6ad7-3b6d-4171-b1c9-f2026cc9deb8">

</div>

<div align="center" style="display: flex; flex-wrap: wrap; gap: 8px; justify-content: center; margin: 20px 0;">

<a href="https://pypi.org/project/kreuzberg-cloud-sdk/"><img src="https://img.shields.io/pypi/v/kreuzberg-cloud-sdk?label=PyPI&color=007ec6" alt="PyPI"></a>
<a href="https://www.npmjs.com/package/@kreuzberg/cloud"><img src="https://img.shields.io/npm/v/%40kreuzberg%2Fcloud?label=npm&color=007ec6" alt="npm"></a>
<a href="https://pkg.go.dev/github.com/xberg-io/sdks/go/v1"><img src="https://img.shields.io/badge/Go-pkg.go.dev-007ec6?logo=go&logoColor=white" alt="Go Reference"></a>
<a href="https://github.com/xberg-io/sdks/blob/main/LICENSE"><img src="https://img.shields.io/badge/License-MIT-blue.svg" alt="License"></a>
<a href="https://enterprise.xberg.io"><img src="https://img.shields.io/badge/docs-enterprise.xberg.io-007ec6" alt="Documentation"></a>
<a href="https://github.com/xberg-io/sdks/actions/workflows/validate.yml"><img src="https://github.com/xberg-io/sdks/actions/workflows/validate.yml/badge.svg" alt="CI"></a>

</div>

<div align="center" style="margin-top: 20px;">

<a href="https://discord.gg/xt9WY3GnKR"><img height="22" src="https://img.shields.io/badge/Discord-Join%20our%20community-7289da?logo=discord&logoColor=white" alt="Discord"></a>

</div>

Official client SDKs for the [Xberg Enterprise](https://enterprise.xberg.io) public extraction API. Generated from the upstream OpenAPI 3.1 specification.

| Language | Package | Registry | Status |
|----------|---------|----------|--------|
| Python | `kreuzberg-cloud-sdk` | [PyPI](https://pypi.org/project/kreuzberg-cloud-sdk/) | generated (httpx) |
| TypeScript / Node.js | `@kreuzberg/cloud` | [npm](https://www.npmjs.com/package/@kreuzberg/cloud) | generated (openapi-fetch) |
| Go | `github.com/xberg-io/sdks/go/v1` | [pkg.go.dev](https://pkg.go.dev/github.com/xberg-io/sdks/go/v1) | hand-written interim — codegen blocked on [oapi-codegen 3.1 support](https://github.com/oapi-codegen/oapi-codegen/issues/373) |
| Dart | `xberg_enterprise_sdk` | [pub.dev](https://pub.dev/packages/xberg_enterprise_sdk) | generated (Retrofit + Dio) |

## Install

**Python:**

```sh
pip install kreuzberg-cloud-sdk
```

**TypeScript / Node.js:**

```sh
pnpm add @kreuzberg/cloud
# or npm install @kreuzberg/cloud
# or yarn add @kreuzberg/cloud
```

**Go:**

```sh
go get github.com/xberg-io/sdks/go/v1
```

**Dart:**

```sh
dart pub add xberg_enterprise_sdk
```

For language-specific quickstarts, examples, and API documentation, see the per-language READMEs in `packages/{python,typescript,go/v1,dart}/`.

## Documentation

- API & Quickstart: [enterprise.xberg.io](https://enterprise.xberg.io)
- API Reference: [enterprise.xberg.io/reference/api](https://enterprise.xberg.io/reference/api/)
- Sandbox onboarding: zero-friction key issuance documented in the per-language READMEs
- Changelog: [CHANGELOG.md](CHANGELOG.md)

## Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md) for development workflows, repo layout, and release procedures.

## License

MIT — see [LICENSE](LICENSE).
