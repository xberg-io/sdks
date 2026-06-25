# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Changed

- CI: `spec-sync.yml` now authenticates via the `kreuzberg-dev-publisher` GitHub App (`actions/create-github-app-token@v2`) scoped to both `kreuzberg-cloud-sdk` and `xberg-enterprise`. PRs opened by the weekly sync now trigger downstream CI checks, which the default `GITHUB_TOKEN` suppresses.

## [0.3.1] - 2026-06-01

### Fixed

- **TypeScript strict-mode regression on `extractBatch`.** The `body.job_ids` parameter is now guarded with `?? []` before indexing to resolve `error TS18048: 'body.job_ids' is possibly 'undefined'` under TypeScript strict mode in `packages/typescript/src/client.ts`.
- **Go gofmt drift on `DiffResponse`.** Struct-field padding in `packages/go/v1/documents.go` has been re-aligned to match `gofmt` standards.

### Changed

- **Dart codegen hand-roll preservation.** The six hand-rolled freezed sealed-union files that `swagger_parser` cannot synthesize (`annotation_kind`, `diff_line`, `node_content`, `ocr_bounding_geometry`, `revision_anchor`, `job_lookup_response`) now live in `packages/dart/handrolled/models/` and are restored automatically by `task dart:generate` after `swagger_parser` and `build_runner` run.

## [0.3.0] - 2026-06-01

### Added

- **Document lineage + diff surface.** Tracks the cloud's `1.1.0` API additions backing design-partner Asks #47/#48/#49/#51.
  - `GET /v1/documents/{document_id}/versions` — paginated list of versions for a logical document, newest first.
  - `GET /v1/documents/{document_id}` — latest version envelope with the stored `ExtractionResult` inline.
  - `GET /v1/documents/{document_id}/diff?from=&to=` — pairwise structural diff. Sync default with a 2-second in-handler budget; on overflow returns `202 Accepted` + a `diff_job_id` for async fallback.
  - `GET /v1/documents/{document_id}/diff/{diff_job_id}` — polling endpoint for the async diff result.
- **Submission-side `document_id`.** `DocumentInput` carries an optional `document_id` (UUID) on the JSON body and per-file multipart fields. When provided the response envelope adds `documents[].document_id` + `documents[].version_sequence` (1-based, server-assigned via `MAX+1`). Re-upload of the same bytes under the same `document_id` is idempotent: the existing job is returned, no new row inserted. Backwards-compatible additive field; clients ignoring it see the same wire shape as v0.2.0.
- **Go bindings.** Hand-written `Client.ListDocumentVersions`, `Client.GetLatestDocument`, `Client.GetDocumentDiff` (returns a union of `DiffResponse` / `DiffAsyncAccepted`), `Client.PollDocumentDiff`. New `doRaw` / `doWithStatus` helpers in `http.go` distinguish `200` and `202` on the diff endpoint.
- **Python / TypeScript / Dart bindings.** Regenerated from the cloud's `v1.1` spec; the four new routes + envelopes (`DiffResponse`, `DiffAsyncAccepted`, `DiffJobStatus`, `DocumentVersionEntry`) appear on every client.

### Changed

- **Dependency churn.** Cloud bump to `kreuzberg e1bfcf9371` flows through every binding (no behavior change beyond what's listed above).

## [0.2.0] - 2026-06-01

### Changed (breaking)

- **Response wire shape.** Aligned with the xberg-enterprise `1.0.0` API which now re-exports kreuzberg core's authoritative response types instead of a hand-maintained shadow.
  - `Table.cells`: `Vec<{values: Vec<String>}>` → `Vec<Vec<String>>` (nested string arrays).
  - `Metadata.authors` / `Metadata.keywords` / `Metadata.tags`: always-present `Vec<String>` → optional `Option<Vec<String>>`.
  - `ExtractionResult.metadata`: now required (was optional).
  - `ExtractionResult.detected_languages` / `chunks` / `pages`: now optional.
  - New top-level response fields surface: `extracted_keywords` (YAKE/RAKE scored keywords), `children` (recursively-extracted embedded docs), `revisions` (tracked changes from DOCX/ODT/PDF/PPTX/XLSX), `uris` (hyperlinks/citations/email addresses discovered during extraction), `format` (discriminated `FormatMetadata` union with `format_type` discriminator: `pdf`/`office`/`excel`/`email`/`image`/`xml`/`text`/`archive`/`csv`/`epub`/`html`/`markdown`/`ocr`), `image_preprocessing`, `json_schema`, `ocr_used`, `error`, `quality_score`.

### Added

- **Dart sealed-union dispatch.** `FormatMetadata`, `NodeContent`, `RevisionAnchor`, `OcrBoundingGeometry`, `DiffLine`, `AnnotationKind` are hand-rolled freezed sealed unions with `unionKey` discriminator dispatch. New `JobLookupResponse` sealed union supports the discriminated job lookup endpoint.
- **Fixture-driven response tests.** Five canonical JSON fixtures in `spec/fixtures/` (minimal, pdf, xlsx with children, docx with revisions, with uris) exercised by Python (32 new tests), TypeScript (37 new tests), Go (25 new tests), and Dart (44 new tests). Locks the cloud wire-shape contract across all four languages.

### Fixed

- **Python codegen.** Earlier upstream kreuzberg fixes (cloud bumped to `e1bfcf9371`) eliminated `prefixItems + items: false` tuple emissions and flattened `oneOf-of-allOf` discriminator wrappers, so `openapi-python-client 0.28.4` regenerates cleanly without preprocessing.
- **Dart codegen.** Same upstream fixes unblocked `swagger_parser 1.43.1`. The 6 freezed sealed unions complete the discriminator dispatch that `json_serializable` cannot synthesize automatically.

## [0.1.1] - 2026-05-23

### Fixed

- Added a split pub.dev publishing workflow so Dart releases publish from a tag-push OIDC token accepted by pub.dev.
- Updated npm release publishing to use npm trusted publishing instead of the repository `NPM_TOKEN` secret.
- Included Dart package version validation in the release workflow.

## [0.1.0] - 2026-05-23

### Added

- Dart client `xberg_enterprise_sdk` on pub.dev with async extraction, webhook delivery fields, presigned uploads, job polling, retry policy, and typed exceptions.

### Changed

- Default SDK API endpoint is now `https://api.xberg.io` across Python, TypeScript, Go, and Dart.
- Dependency update tooling now exposes `task upgrade`, refreshes Dart dependencies, updates pre-commit hooks, and runs GitHub Actions pin maintenance through `uvx`.

### Fixed

- Multipart extraction requests now send file, options, and webhook fields in the wire format expected by the API.
- Python package metadata now publishes as `kreuzberg-cloud-sdk`.

## [0.0.1] - 2026-05-10

### Added

- Python client `kreuzberg-cloud-sdk` on PyPI: ergonomic `KreuzbergCloud` and `AsyncKreuzbergCloud` clients with `extract`, `extract_batch`, `get_job`, `wait_for_job`, `extract_and_wait`, plus typed error hierarchy (`AuthError`, `RateLimitError`, `ValidationError`, `NotFoundError`, `ServerError`, `TimeoutError`).
- TypeScript client `@kreuzberg/cloud` on npm: ESM-only client with the same method surface as Python (`extract`, `extractBatch`, `getJob`, `waitForJob`, `extractAndWait`), error hierarchy, retry/backoff config, and full type declarations.
- Go client `github.com/xberg-io/sdks/go/v1`: hand-written interim client with `Extract`, `ExtractBatch`, `GetJob`, `WaitForJob`, `WaitForJobs`, `ExtractAndWait`, `FromSandbox`; idiomatic error hierarchy via `errors.As`.
- Zero-friction sandbox onboarding: `client.create_sandbox_key()` (Py), `KreuzbergCloud.fromSandbox()` (TS), `client.FromSandbox(ctx)` (Go) — fetch an anonymous sandbox key (50 pages, 24h) and start extracting without signup.
- All three packages generated from `services/api`'s public extraction OpenAPI spec.
- Comprehensive test coverage: 53 tests (Python), 57 tests (TypeScript), ~44 tests (Go).

[Unreleased]: https://github.com/xberg-io/sdks/compare/v0.2.0...HEAD
[0.2.0]: https://github.com/xberg-io/sdks/compare/v0.1.1...v0.2.0
[0.1.1]: https://github.com/xberg-io/sdks/compare/v0.1.0...v0.1.1
[0.1.0]: https://github.com/xberg-io/sdks/compare/v0.0.1...v0.1.0
[0.0.1]: https://github.com/xberg-io/sdks/releases/tag/v0.0.1
