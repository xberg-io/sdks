# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

## [0.1.1] - 2026-05-23

### Fixed

- Added a split pub.dev publishing workflow so Dart releases publish from a tag-push OIDC token accepted by pub.dev.
- Updated npm release publishing to use npm trusted publishing instead of the repository `NPM_TOKEN` secret.
- Included Dart package version validation in the release workflow.

## [0.1.0] - 2026-05-23

### Added

- Dart client `kreuzberg_cloud_sdk` on pub.dev with async extraction, webhook delivery fields, presigned uploads, job polling, retry policy, and typed exceptions.

### Changed

- Default SDK API endpoint is now `https://api.kreuzberg.dev` across Python, TypeScript, Go, and Dart.
- Dependency update tooling now exposes `task upgrade`, refreshes Dart dependencies, updates pre-commit hooks, and runs GitHub Actions pin maintenance through `uvx`.

### Fixed

- Multipart extraction requests now send file, options, and webhook fields in the wire format expected by the API.
- Python package metadata now publishes as `kreuzberg-cloud-sdk`.

## [0.0.1] - 2026-05-10

### Added

- Python client `kreuzberg-cloud-sdk` on PyPI: ergonomic `KreuzbergCloud` and `AsyncKreuzbergCloud` clients with `extract`, `extract_batch`, `get_job`, `wait_for_job`, `extract_and_wait`, plus typed error hierarchy (`AuthError`, `RateLimitError`, `ValidationError`, `NotFoundError`, `ServerError`, `TimeoutError`).
- TypeScript client `@kreuzberg/cloud` on npm: ESM-only client with the same method surface as Python (`extract`, `extractBatch`, `getJob`, `waitForJob`, `extractAndWait`), error hierarchy, retry/backoff config, and full type declarations.
- Go client `github.com/kreuzberg-dev/kreuzberg-cloud-sdk/go/v1`: hand-written interim client with `Extract`, `ExtractBatch`, `GetJob`, `WaitForJob`, `WaitForJobs`, `ExtractAndWait`, `FromSandbox`; idiomatic error hierarchy via `errors.As`.
- Zero-friction sandbox onboarding: `client.create_sandbox_key()` (Py), `KreuzbergCloud.fromSandbox()` (TS), `client.FromSandbox(ctx)` (Go) — fetch an anonymous sandbox key (50 pages, 24h) and start extracting without signup.
- All three packages generated from `services/api`'s public extraction OpenAPI spec.
- Comprehensive test coverage: 53 tests (Python), 57 tests (TypeScript), ~44 tests (Go).

[Unreleased]: https://github.com/kreuzberg-dev/kreuzberg-cloud-sdk/compare/v0.1.1...HEAD
[0.1.1]: https://github.com/kreuzberg-dev/kreuzberg-cloud-sdk/compare/v0.1.0...v0.1.1
[0.1.0]: https://github.com/kreuzberg-dev/kreuzberg-cloud-sdk/compare/v0.0.1...v0.1.0
[0.0.1]: https://github.com/kreuzberg-dev/kreuzberg-cloud-sdk/releases/tag/v0.0.1
