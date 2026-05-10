# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

## [0.0.1] - 2026-05-10

### Added

- Python client `kreuzberg-cloud` on PyPI: ergonomic `KreuzbergCloud` and `AsyncKreuzbergCloud` clients with `extract`, `extract_batch`, `get_job`, `wait_for_job`, `extract_and_wait`, plus typed error hierarchy (`AuthError`, `RateLimitError`, `ValidationError`, `NotFoundError`, `ServerError`, `TimeoutError`).
- TypeScript client `@kreuzberg/cloud` on npm: ESM-only client with the same method surface as Python (`extract`, `extractBatch`, `getJob`, `waitForJob`, `extractAndWait`), error hierarchy, retry/backoff config, and full type declarations.
- Go client `github.com/kreuzberg-dev/kreuzberg-cloud-sdk/go/v1`: hand-written interim client with `Extract`, `ExtractBatch`, `GetJob`, `WaitForJob`, `WaitForJobs`, `ExtractAndWait`, `FromSandbox`; idiomatic error hierarchy via `errors.As`.
- Zero-friction sandbox onboarding: `client.create_sandbox_key()` (Py), `KreuzbergCloud.fromSandbox()` (TS), `client.FromSandbox(ctx)` (Go) — fetch an anonymous sandbox key (50 pages, 24h) and start extracting without signup.
- All three packages generated from `services/api`'s public extraction OpenAPI spec.
- Comprehensive test coverage: 53 tests (Python), 57 tests (TypeScript), ~44 tests (Go).

[Unreleased]: https://github.com/kreuzberg-dev/kreuzberg-cloud-sdk/compare/v0.0.1...HEAD
[0.0.1]: https://github.com/kreuzberg-dev/kreuzberg-cloud-sdk/releases/tag/v0.0.1
