# @kreuzberg/cloud

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

Full reference at <https://kreuzberg.cloud/docs>.

## License

MIT — © Kreuzberg, Inc.
