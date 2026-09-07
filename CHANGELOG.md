# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

## [0.5.0] - 2026-09-07

### Added

- Add the SDK documentation site with per-language references, all three OpenAPI schemas, tier and authentication guides,
  and runnable extraction, project lifecycle and idle-stream cancellation examples.
- Support Enterprise document lineage IDs for single and batch extraction in all three SDKs, validating UUIDs and
  duplicate filenames before reading uploads and preserving IDs through extract-and-wait helpers.
- Add isolated Pro and Enterprise stacks and SDK-driven live contract checks for extraction, jobs and saved presets.
- Expose all 48 Enterprise control-plane operations in Python (sync and async), TypeScript, and Go, with independently
  typed backend schemas, a separate control-plane origin and bearer, public sandbox support, and OAuth redirect handling.
  Existing Pro method names and signatures remain unchanged; colliding backend names carry a backend prefix.

### Fixed

- Generate all three Python schema sets before packaging from a clean checkout and publish from the actual distribution directory.
- Refresh generated contracts for nullable enrichment entities, latest-document results, document-diff conflicts, and
  the current processing status vocabulary.
- Accept nonempty opaque JSON objects in generated TypeScript schemas, including preset configuration and integration
  credentials, while retaining validation for explicitly typed fields.
- Preserve path identifiers without allowing dot-segment navigation to retarget destructive requests. TypeScript rejects
  exact dot identifiers because WHATWG URLs normalize even escaped dots; Python and Go encode them.
- Isolate backend cookies and bearer credentials, omit explicit empty credentials, reject known Pro targets, and avoid
  requiring an unrelated data-plane health request before a backend call.
- Ship the generated Go sources in tagged modules and preserve them during cleanup; verify a consumer of the committed
  module before publishing any packages. Build the requested release tag, require both language coverage suites, and
  stop publication when registry probes fail.
- Bound Python SSE lines and frames by UTF-8 bytes, reject oversized unterminated lines early, and preserve split Unicode
  and CR/LF framing without treating Unicode paragraph separators as line endings.

### Performance

- Remove redundant TypeScript multipart byte copies while preserving typed-array slices and immutable Blob snapshots;
  construction now allocates about one additional payload instead of two in the 100 MiB regression workload.

- Reduce Go crawl-stream allocations by transferring ownership of validated frame bytes while retaining prior events.

### Tooling

- Execute all documentation examples against locally built packages and both live tiers during validation; require
  live deployment contracts before release, with strict fixture, execution-count and idle-cancellation checks.
  Mint a temporary Pro key for each run and revoke it after success or failure without altering reusable fixture credentials.

- Validate every version target before changing manifests, preventing malformed later targets from leaving a partial bump.
  Keep the local release version check read-only and clarify the lint alias and local-only release tag task.

## [0.4.0] - 2026-09-06

### Changed

- **Breaking, saved presets.** `list_saved_presets` takes `limit`/`offset`; Go's
  `ListSavedPresets` gains those parameters and `DeleteSavedPreset` returns a bare `error`
  (TypeScript's `deleteSavedPreset` likewise resolves to `void`), matching the 204 the spec
  declares and the other delete methods.
- **Rebrand kreuzberg → xberg.** Package identity is now PyPI `xberg-io-sdk` (import
  `xberg_io_sdk`), npm `@xberg-io/sdk`, Go `github.com/xberg-io/sdks/packages/go`. Main clients
  are `XbergClient` / `AsyncXbergClient`; error base is `XbergError` (the `Auth/Validation/NotFound/
  RateLimit/Server/Timeout` subclasses keep their suffixes). The legal entity `Kreuzberg, Inc.`
  is unchanged.
- **Dual-target (Enterprise + Pro).** One package, one configurable client per language, generated
  from two side-by-side specs (`spec/api` + `spec/pro`; never merged — mirrors xberg-enterprise
  ADR-0072). Shared methods are written once; tier-specific methods are capability-gated via the
  `/healthz` tier probe. Enterprise defaults `baseUrl` to `https://api.xberg.io`; Pro requires an
  explicit `baseUrl`.
- **Contract unified** across languages: throw on a failed/cancelled terminal job in
  `wait_for_job`/`extract_and_wait`; single multipart request for `extract_batch`; configurable
  retry engine in Python for parity; `401` **and** `403` map to the auth error.
- **Go codegen unblocked.** `oapi-codegen` v2.8.0 handles the OpenAPI 3.1 specs, so the Go client
  is generated (typed `JobResult`) rather than hand-written; the stale root `/go` tree was removed.
- CI: `spec-sync.yml` is now release-triggered (`repository_dispatch` from xberg-enterprise, with
  the weekly cron as a fallback), syncs **both** specs, and authenticates via the publisher GitHub
  App scoped to `sdks` + `xberg-enterprise`. PRs it opens trigger downstream per-language CI, which
  regenerates clients and runs the full suite as the consistency gate.

### Fixed

- **`get_job_result` returned the wrong type and was gated to the wrong tier.** It was typed
  against `GetJobResponse`, the `GET /v1/jobs/{id}` *metadata* schema, which shares no field with
  `JobResult` beyond `status` and `completed_at` — reading `results` did not compile, and reading
  `id` compiled and was always empty. Both specs now declare the operation, so the Pro-only gate is
  gone too. Verified against a live Pro instance, which returns
  `{completed_at, job_id, results, status}`.
- **`/v1/presets`, `/v1/presets/{id}` and the preset sample were gated to Enterprise** although both
  specs declare them, so they raised on Pro. Now ungated, and the previously missing sample
  endpoint is exposed.
- **Pro was given the Enterprise shape for schemas the two specs define differently.** The Go
  generator excluded every shared schema *name*; `ReadinessChecks` reports `nats` on Enterprise and
  `storage` on Pro, so a Pro caller got a field the service never sends and none for the one it
  does. Only structurally identical schemas are excluded now; a divergent one — or one reaching a
  divergent one through a `$ref` — is emitted under a `Pro`-prefixed name.
- **Spec sync pulled from `main`**, a deploy-only branch hundreds of commits behind, which is why
  the bot reported zero drift while the vendored specs went stale. It now defaults to
  `development`.
- **Saved presets used the Pro spelling on both tiers and were gated to Pro.** Enterprise serves
  `/v1/saved_presets` (underscore, `{preset_id}`) and Pro serves `/v1/saved-presets` (hyphen,
  `{id}`); neither serves the other's spelling, so all five operations were unreachable on
  Enterprise. The path is now rendered from the resolved tier and the gate is gone. The premise is
  asserted against a live Pro instance by `task pro:verify`, which confirms Pro 404s the underscore
  form.
- **Go never retried a transport failure.** `httpClient.Do` returning an error — DNS failure,
  refused connection, TLS handshake, dial timeout — was wrapped in a bare error the retry engine
  could not classify, so `WithRetries` was inert for every failure that never reached a response,
  while Python retries `httpx.TransportError` and TypeScript retries a thrown `fetch`. The new
  `ConnectionError` embeds `XbergError` for the base catch and unwraps to the transport cause for
  `errors.Is`.
- **An event-stream frame could grow without bound in all three clients.** The per-line cap does
  not bound an endless *succession* of ordinary `data:` lines that never reach the blank line
  closing the frame; the cap now applies to the running frame total as well as the pending line.
- **A malformed crawl frame raised a different type in each language** — `XbergError` in
  TypeScript, a bare `ValueError` in Python, a bare error in Go — so `except XbergError` and
  `errors.As(err, &XbergError{})` both missed a stream that went wrong mid-flight, contradicting
  the base-error contract Go's own `XbergError` documents. Python's other response-shape checks
  raised `ValueError` for the same reason and are converted with them.
- **Go treated an explicitly empty `Configs` slice as "no overrides"**, where Python and TypeScript
  treat `[]` against a non-empty file list as the length mismatch it is; only `nil` skips now.
- **Go double-escaped a quote in the multipart filename**, replacing `"` with `\"` before
  rendering with `%q`, which escapes it again.

### Added

- **Crawl-event streaming.** `stream_crawl_events` / `streamCrawlEvents` / `StreamCrawlEvents`
  (returning an `iter.Seq2[CrawlEvent, error]`) subscribe to
  `GET /v1/crawl-jobs/{id}/events`, the one Enterprise operation answering `text/event-stream`.
  Each client decodes real WHATWG framing — a frame is closed by a blank line, not a newline, so a
  payload may span several `data:` fields, and heartbeat comments and `event:`/`id:`/`retry:` are
  tolerated — rather than parsing one JSON object per line, which passes a friendly server and
  fails a real one. Nothing is requested until iteration begins, and the response body is released
  on exhaustion, `break` and exception alike.
- **Per-file extraction configs on the extract convenience methods.** `extract`/`extract_and_wait`
  take a `config` (Go: `ExtractOptions.Configs`) and `extract_batch` takes a list parallel to the
  files, sent as the `config-<filename>` multipart part; precedence against
  `options.extraction_config` stays the server's. Because that part is keyed on the filename, a
  batch repeating one filename with differing configs is rejected client-side instead of dropping
  one silently.
- **The Enterprise control-plane spec** (`spec/backend/openapi.yaml`, 48 operations) is vendored as
  a third schema set and generates types in all three languages; `tools/oapi-pro-config` became
  `tools/oapi-schemaset-config`, which now derives the exclusion, inclusion and rename lists for any
  secondary Go schema set rather than only Pro's. Each client gains a
  `control_plane_base_url` / `controlPlaneBaseUrl` / `WithControlPlaneBaseURL` option, defaulting to
  the data-plane base URL so Pro — which serves both planes from one binary — is unaffected. No
  method routes to it yet: it records the origin the control-plane operations will use when they
  land, and reads back so a two-origin client can be inspected.
- **The Pro control plane** — projects, api-keys and integrations (13 operations) — in all three
  languages. Without these a Pro user could not create a project or mint an API key, so the client
  could not reach an instance it had not been handed a key for out of band.
- **The operations no client could reach**, in all three languages: auto-tune (7) and
  tuning-profiles (3) on both tiers, and enrich (2), `GET /v1/documents/{id}`, `GET /v1/extractions`
  and `GET /v1/jobs/{id}/pages/{n}` on Enterprise, plus the missing `get_saved_preset` and
  `update_saved_preset`, `cancel_job` and `delete_rag_documents`. Enterprise coverage goes from 27
  of 49 operations to 48, Pro from 42 of 56 to 53 — both tiers are now complete, the remaining
  operations on each being deliberate exclusions. These counts are measured by `task spec:coverage`
  rather than asserted, and its list of tracked gaps is empty; the previous
  edition of this entry claimed numbers nothing checked, and two of them were wrong. auto-tune is
  the notable addition: a licensed Pro instance advertises `auto_tune` as enabled, so the SDK named
  a feature it could not call.
- Each package README now lists what is **deliberately** not exposed — `GET /readyz` (an
  infrastructure probe; `/healthz` is the tier probe and is used) and Pro's redirect/cookie login
  flows — so an absence reads as a decision rather than an oversight.
- `task pro:up|down|reset|key|verify`, which check a real Pro container against the vendored spec.
  The existing fixtures encoded a shape neither spec declares, so they agreed with the client and
  with nothing else. Note these assertions currently drive `curl`, not the clients — driving the
  SDKs themselves is tracked separately, and until it lands the client's own conformance is still
  inferred rather than executed.
- `task spec:coverage`, which loads both vendored specs, computes the set of operations the client
  actually reaches, and fails on any that is neither covered nor recorded as a deliberate exclusion
  or a tracked gap. Nothing asserted this before, which is how `cancel_job` and `delete_documents`
  sat in both specs, in no client, and outside every exclusion list — so they read as covered in
  four hand-maintained places that agreed with each other and with nothing else.
- A cross-language parity gate in the reference generator. It previously skipped any method it could
  not find in a language, so a surface present in two clients and missing from the third produced
  three clean pages and no error.

### Removed

- **`list_rag_documents` / `listRagDocuments` / `ListRagDocuments`.** They issued `GET` on
  `/v1/rag/collections/{name}/documents`, where both specs declare only `post` and `delete`. The
  real document listing is scoped to a project and integration and is part of the control plane
  added above.
- **The conflicting `JobResult` aliases.** The name meant three different things — the spec schema,
  `Job` in TypeScript, and `ExtractionResult` in Python. It now means the spec schema everywhere.
- **Sandbox-key helper** (`create_sandbox_key` / `fromSandbox` / `FromSandbox`) in all languages.
  It POSTed to `/v1/sandbox/key`, which exists in neither service — sandbox keys are minted (and
  revoked) server-side inside `/v1/sandbox/public/extract`, so the helper always 404'd.
- **The Dart SDK** (`packages/dart`, `kreuzberg_cloud_sdk` on pub.dev), along with its task file,
  its pub.dev publishing workflow, and its leg of the release version-consistency gate. It never
  gained Pro support, so it was the one client that could not honour the dual-target contract the
  rest of this release is built around. Unlike every other language its generated tree had to be
  committed — pub.dev archives only ship git-tracked files — which meant regeneration drift was
  invisible to CI, and it had neither a CI workflow nor coverage tooling to catch that drift. With
  no known consumers, deleting it is cheaper than bringing it up to parity. Python, TypeScript and
  Go are unaffected.

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

- Dart client `kreuzberg_cloud_sdk` on pub.dev with async extraction, webhook delivery fields, presigned uploads, job polling, retry policy, and typed exceptions.

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

[Unreleased]: https://github.com/xberg-io/sdks/compare/v0.5.0...HEAD
[0.5.0]: https://github.com/xberg-io/sdks/compare/v0.4.0...v0.5.0
[0.4.0]: https://github.com/xberg-io/sdks/compare/v0.3.1...v0.4.0
[0.3.1]: https://github.com/xberg-io/sdks/compare/v0.3.0...v0.3.1
[0.3.0]: https://github.com/xberg-io/sdks/compare/v0.2.0...v0.3.0
[0.2.0]: https://github.com/xberg-io/sdks/compare/v0.1.1...v0.2.0
[0.1.1]: https://github.com/xberg-io/sdks/compare/v0.1.0...v0.1.1
[0.1.0]: https://github.com/xberg-io/sdks/compare/v0.0.1...v0.1.0
[0.0.1]: https://github.com/xberg-io/sdks/releases/tag/v0.0.1
