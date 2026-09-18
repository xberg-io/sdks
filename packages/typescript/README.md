<p align="center">
  <picture>
    <source media="(prefers-color-scheme: dark)" srcset="https://cdn.jsdelivr.net/gh/xberg-io/assets@v1/banner/readme-banner-dark.svg">
    <img alt="Xberg" width="420" src="https://cdn.jsdelivr.net/gh/xberg-io/assets@v1/banner/readme-banner-light.svg">
  </picture>
</p>

# @xberg-io/sdk

<div align="center">

<img width="3384" height="573" alt="Xberg Enterprise" src="https://github.com/user-attachments/assets/1b6c6ad7-3b6d-4171-b1c9-f2026cc9deb8">

</div>

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

Official TypeScript / Node.js client for the [Xberg Enterprise](https://xberg.io)
and Xberg Pro document-processing APIs. One `XbergClient` speaks to either
product: the shared surface (extraction, jobs, audit, curated presets, RAG) is
written once, and tier-specific methods are capability-gated.

- ESM-only, modern (Node 22+, Bun, Deno, Cloudflare Workers)
- Dual-target: two generated schema sets (Enterprise + Pro), never merged
- Generated types via `openapi-typescript`, runtime via `openapi-fetch`
- Tree-shakable, no bundled dependencies

## Install

```sh
pnpm add @xberg-io/sdk
```

## Targets

Both products are self-hosted, so `XbergClient` requires the deployment's
`baseUrl`. Pass `target: "pro"` when the target is already known:

```ts
import { XbergClient } from "@xberg-io/sdk";

const pro = new XbergClient({ apiKey: process.env.XBERG_API_KEY!, target: "pro", baseUrl: "https://pro.example.com" });
```

When `target` is omitted the tier is discovered lazily from `GET /healthz`.
Calling a method not available on the connected tier (e.g. `versions()` on Pro,
or `login()` on Enterprise) throws a clear "not available on this tier" error.

## Quickstart — single file

```ts
import { XbergClient } from "@xberg-io/sdk";
import { readFile } from "node:fs/promises";

const client = new XbergClient({ baseUrl: "https://xberg.example.com", apiKey: process.env.XBERG_API_KEY! });

const data = await readFile("invoice.pdf");
const result = await client.extractAndWait({
  file: { name: "invoice.pdf", data, mimeType: "application/pdf" },
});
console.log(result.result?.content);
```

## Quickstart — batch + parallel wait

```ts
import { XbergClient } from "@xberg-io/sdk";
import { readFile } from "node:fs/promises";

const client = new XbergClient({ baseUrl: "https://xberg.example.com", apiKey: process.env.XBERG_API_KEY! });

const files = await Promise.all(
  ["a.pdf", "b.pdf", "c.pdf"].map(async (name) => ({
    name,
    data: await readFile(name),
  })),
);
const jobs = await client.extractBatch({ files });
const results = await client.waitForJobs(jobs.map((j) => j.id));
for (const r of results) console.log(r.id, r.status);
```

## API

Shared surface (both tiers):

| Method | Returns |
|---|---|
| `extract({ file, options? })` | `Promise<Job>` |
| `extractBatch({ files, options? })` | `Promise<Job[]>` |
| `getJob(jobId)` | `Promise<Job>` |
| `getJobResult(jobId)` | `Promise<JobResult>` |
| `waitForJob(jobId, opts?)` | `Promise<Job>` |
| `waitForJobs(jobIds, opts?)` | `Promise<Job[]>` |
| `extractAndWait({ file, options?, ...waitOpts })` | `Promise<Job>` |
| `listJobs({ limit?, offset? })` | `Promise<ListJobsResponse>` |
| `cancelJob(jobId)` | `Promise<void>` |
| `audit({ action?, limit?, offset? })` | `Promise<ListAuditEntriesResponse>` |
| `presets()`, `getPreset(id)`, `getPresetSample(id, name)` | Curated preset registry |
| `listSavedPresets({ limit?, offset? })`, `createSavedPreset(body)`, `getSavedPreset(id)`, `updateSavedPreset(id, body)`, `deleteSavedPreset(id)` | Project-owned saved presets |
| `listAutoTuneJobs({ limit?, offset? })`, `submitAutoTune({ request, files })`, `getAutoTuneCapabilities()`, `getAutoTuneStatus(id)`, `getAutoTuneResult(id)`, `promoteAutoTuneProfile(id, body)`, `deleteAutoTuneJob(id)` | Auto-tune |
| `listTuningProfiles({ limit?, offset? })`, `getTuningProfile(id)`, `deleteTuningProfile(id)` | Tuning profiles |
| `listRagCollections()`, `createRagCollection(body)`, `deleteRagCollection(name)`, `ragRetrieve(name, body)`, `deleteRagDocuments(name, body)`, … | RAG surface |

`Job` is the job envelope (`GET /v1/jobs/{id}`); `JobResult` is the stored
extraction result (`GET /v1/jobs/{id}/result`). They are different schemas — the
polling helpers return the former, `getJobResult` the latter.

Saved presets are shared, and both products serve them at `/v1/saved_presets`
with identical schemas.

Xberg Pro only: `login`, `authConfig`, `getRagConfig` / `setRagConfig`,
`getLicenseInfo`, `putLocalUpload`, and the
control plane — `listProjects` / `createProject`, `listApiKeys` / `createApiKey` /
`revokeApiKey`, `listIntegrations` / `createIntegration` / `getIntegration` /
`deleteIntegration`, `connectIntegration` / `disconnectIntegration`,
`listIntegrationDocuments` / `fetchIntegrationDocument`.

Xberg Enterprise only: `getDocument`, `versions`, `diff` / `getDiffJob`,
`listExtractionEvents`, `listSubscriptionDeliveries` / `getSubscriptionDelivery`.

Both tiers also carry `stopAutoTuneJob` and `listManagedEmbeddingPresets`.

Available on both tiers, though earlier releases wrongly gated them to
Enterprise: `presignUpload` / `confirmUpload`, `usage`, `getJobPage`,
`submitEnrich` / `getEnrichStatus`, `streamCrawlEvents` (an `AsyncIterable` over
a Server-Sent Events stream).

`getPresetSample`, `fetchIntegrationDocument`, and `getJobPage` return raw
`Uint8Array` bytes rather than JSON; `getJobPage` serves `image/png`.

### Not covered

A few documented endpoints are deliberately left out of the client:

- `GET /readyz` — an infrastructure readiness probe for orchestrators, not
  application surface. `GET /healthz` *is* used: it backs the tier probe.
- `GET /v1/oauth/callback` and `DELETE /auth/account` (Pro) — browser
  redirect/cookie flows, not API-key surface. `POST /auth/login`, which does
  work with a verified ID token, is exposed.

Errors throw subclasses of `XbergError` (`AuthError`, `RateLimitError`,
`ValidationError`, `NotFoundError`, `ServerError`, `TimeoutError`). Each
carries `status: number` and `body: unknown`. `RateLimitError.retryAfter`
is parsed from the `Retry-After` response header.

The low-level `createClient(...)` factory (a thin `openapi-fetch` wrapper)
is still exported for direct OpenAPI access.

## Docs

- SDK docs: <https://docs.sdks.xberg.io>
- Product overview: <https://xberg.io>

## License

MIT — © Kreuzberg, Inc.
