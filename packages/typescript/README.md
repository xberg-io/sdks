# @kreuzberg/cloud

<div align="center">

<img width="3384" height="573" alt="Kreuzberg Cloud" src="https://github.com/user-attachments/assets/1b6c6ad7-3b6d-4171-b1c9-f2026cc9deb8">

</div>

<div align="center" style="display: flex; flex-wrap: wrap; gap: 8px; justify-content: center; margin: 20px 0;">

<a href="https://pypi.org/project/kreuzberg-cloud-sdk/"><img src="https://img.shields.io/pypi/v/kreuzberg-cloud-sdk?label=PyPI&color=007ec6" alt="PyPI"></a>
<a href="https://www.npmjs.com/package/@kreuzberg/cloud"><img src="https://img.shields.io/npm/v/%40kreuzberg%2Fcloud?label=npm&color=007ec6" alt="npm"></a>
<a href="https://pkg.go.dev/github.com/kreuzberg-dev/kreuzberg-cloud-sdk/go/v1"><img src="https://img.shields.io/badge/Go-pkg.go.dev-007ec6?logo=go&logoColor=white" alt="Go Reference"></a>
<a href="https://github.com/kreuzberg-dev/kreuzberg-cloud-sdk/blob/main/LICENSE"><img src="https://img.shields.io/badge/License-MIT-blue.svg" alt="License"></a>
<a href="https://docs.kreuzberg.cloud"><img src="https://img.shields.io/badge/docs-kreuzberg.cloud-007ec6" alt="Documentation"></a>
<a href="https://github.com/kreuzberg-dev/kreuzberg-cloud-sdk/actions/workflows/validate.yml"><img src="https://github.com/kreuzberg-dev/kreuzberg-cloud-sdk/actions/workflows/validate.yml/badge.svg" alt="CI"></a>

</div>

<div align="center" style="margin-top: 20px;">

<a href="https://discord.gg/xt9WY3GnKR"><img height="22" src="https://img.shields.io/badge/Discord-Join%20our%20community-7289da?logo=discord&logoColor=white" alt="Discord"></a>

</div>

Official TypeScript / Node.js client for the [Kreuzberg Cloud](https://kreuzberg.cloud)
document-processing API.

- ESM-only, modern (Node 20+, Bun, Deno, Cloudflare Workers)
- Generated types via `openapi-typescript`, runtime via `openapi-fetch`
- Tree-shakable, ~6 KB runtime, no bundled dependencies

## Install

```sh
pnpm add @kreuzberg/cloud
```

## Quickstart — single file

```ts
import { KreuzbergCloud } from "@kreuzberg/cloud";
import { readFile } from "node:fs/promises";

const client = new KreuzbergCloud({ apiKey: process.env.KREUZBERG_API_KEY! });

const data = await readFile("invoice.pdf");
const result = await client.extractAndWait({
  file: { name: "invoice.pdf", data, mimeType: "application/pdf" },
});
console.log(result.result?.content);
```

## Quickstart — batch + parallel wait

```ts
import { KreuzbergCloud } from "@kreuzberg/cloud";
import { readFile } from "node:fs/promises";

const client = new KreuzbergCloud({ apiKey: process.env.KREUZBERG_API_KEY! });

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

## Quickstart — sandbox (no signup)

```ts
import { KreuzbergCloud } from "@kreuzberg/cloud";

const client = await KreuzbergCloud.fromSandbox();
const result = await client.extractAndWait({
  file: new Blob(["Hello world"], { type: "text/plain" }),
});
console.log(result.result?.content);
```

## API

| Method | Returns |
|---|---|
| `extract({ file, options? })` | `Promise<Job>` |
| `extractBatch({ files, options? })` | `Promise<Job[]>` |
| `getJob(jobId)` | `Promise<Job>` |
| `waitForJob(jobId, opts?)` | `Promise<JobResult>` |
| `waitForJobs(jobIds, opts?)` | `Promise<JobResult[]>` |
| `extractAndWait({ file, options?, ...waitOpts })` | `Promise<JobResult>` |
| `createSandboxKey()` | `Promise<SandboxKey>` |
| `KreuzbergCloud.fromSandbox(opts?)` | `Promise<KreuzbergCloud>` (static) |

Errors throw subclasses of `KreuzbergError` (`AuthError`, `RateLimitError`,
`ValidationError`, `NotFoundError`, `ServerError`, `TimeoutError`). Each
carries `status: number` and `body: unknown`. `RateLimitError.retryAfter`
is parsed from the `Retry-After` response header.

The low-level `createClient(...)` factory (a thin `openapi-fetch` wrapper)
is still exported for direct OpenAPI access.

## Docs

Full reference at <https://docs.kreuzberg.cloud>.

## License

MIT — © Kreuzberg, Inc.
