# TypeScript deployment contracts

This opt-in suite uses the built SDK's public exports and real HTTP requests.
It complements the MSW unit tests and the existing Python live release checks.
It does not provision infrastructure or connect directly to PostgreSQL.

Run `mise run typescript:build`, then
`mise run typescript:integration:test` for fifteen local controls.
The local HTTP server verifies actual SDK multipart serialization, opaque
structured/RAG/enrichment payload transport, pagination, typed errors and a
failed connection. These controls do not establish extraction or model quality.

The journal records the complete synthetic text fixture manifest before the
first extraction submission. The SDK receives typed `projectId` on every job
operation; the Pro job API scopes reads through a query parameter.

The first live epoch is intentionally small: eight cases, three native-text jobs,
one synthetic saved preset created, updated and deleted, and zero model calls.
It requires an isolated, operator-owned project and authentication disabled.
It validates exact native text, filenames, result identity/cardinality, cache
state, successful terminal status, pagination and typed absence errors.
The terminal-cancel case checks cancellation of an already-completed job and its idempotence; active cancellation remains separate.

Run `node run.mjs` from this directory with these environment values:

- `XBERG_SDK_LIVE_APPROVED=1`: explicit operator authorization for this epoch.
- `XBERG_BASE_URL`: API origin.
- `XBERG_PROJECT_ID`: dedicated synthetic project, never a customer project.
- `XBERG_SDK_OUTPUT_DIR`: absolute, new private evidence directory.
- `XBERG_SDK_LIVE_LEASE`: absolute shared writer lease path; an existing lease blocks the run.
- `XBERG_SDK_GUARD_COMMAND_JSON`: JSON array containing the executable and
  arguments for an operator-supplied, read-only deployment fingerprint guard.
  The command must exit nonzero if the expected runtime or database changed.

The journal is appended and fsynced before requests and before responses reach
SDK assertions. It captures valid observed job IDs even on contradictory non-2xx responses,
while marking duplicate, mixed, noncanonical, unexpected-count or crawl admissions
unresolved. It stores method/path/status and acknowledged IDs, never request
bodies, headers or query strings. An unexpected successful job admission is
recorded even when a later assertion fails. Cleanup drains acknowledged jobs;
ambiguous writes remain failures and require reconciliation before another run.
Do not replay a failed campaign without reviewing its journal and deployment.
Evidence directories must stay outside Git.

This baseline does not claim API-key scope isolation, production authentication,
provider inference, PDF/OCR quality, RAG ranking, active cancellation, crawling,
auto-tune or Enterprise-only APIs. Those require separately authorized epochs.
No cases are silently skipped when configuration is absent.
