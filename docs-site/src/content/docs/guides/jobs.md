---
title: Jobs and polling
description: Submit, poll, terminal statuses, the wait helpers, and timeouts.
---

## The job lifecycle

`POST /v1/extract` never returns extracted content — it returns one job id per submitted document
with status `pending`, HTTP **202**. A job then moves through zero or more intermediate states
until it reaches one of four terminal statuses: `completed`, `partial_success`, `failed` or
`cancelled`. Only `completed` and `partial_success` carry a usable result; the other two are
failures the wait helpers raise on rather than return.

`GET /v1/jobs/{id}` fetches the current status. `GET /v1/jobs/{id}/result` fetches the stored
result document and answers **409** until the job reaches a terminal successful status.

## Polling by hand

```python title="Python"
from pathlib import Path

from xberg_io_sdk import XbergClient

with XbergClient(api_key="kz_...", base_url="https://xberg.example.com") as client:
    job = client.extract(file=Path("invoice.pdf"))
    job = client.get_job(job.id)
    print(job.status)
```

```ts title="TypeScript"
import { XbergClient } from "@xberg-io/sdk";

const client = new XbergClient({ baseUrl: "https://xberg.example.com", apiKey: process.env.XBERG_API_KEY! });

const job = await client.extract({ file: { name: "invoice.pdf", data, mimeType: "application/pdf" } });
const current = await client.getJob(job.id);
console.log(current.status);
```

```go title="Go"
job, err := client.Extract(ctx, xberg.FileSource{Name: "invoice.pdf", Reader: file}, nil)
if err != nil {
    log.Fatal(err)
}
current, err := client.GetJob(ctx, job.Id.String())
```

## The wait helpers

`wait_for_job` / `waitForJob` / `WaitForJob` poll `GET /v1/jobs/{id}` until the job reaches a
terminal status, backing off between polls, and raise instead of returning a failed job:

```python title="Python"
from xberg_io_sdk.errors import TimeoutError as XbergTimeoutError, XbergError

try:
    result = client.wait_for_job(job.id, timeout=120, poll_interval=1.0, backoff="exponential")
except XbergTimeoutError:
    print("still running after 120s")
except XbergError as exc:
    print(f"job failed: {exc}")
```

```ts title="TypeScript"
import { TimeoutError, XbergError } from "@xberg-io/sdk";

try {
  const result = await client.waitForJob(job.id, { timeoutMs: 120_000, pollIntervalMs: 1000 });
} catch (err) {
  if (err instanceof TimeoutError) {
    console.log("still running after 120s");
  } else if (err instanceof XbergError) {
    console.log(`job failed: ${err.message}`);
  }
}
```

```go title="Go"
result, err := client.WaitForJob(ctx, job.Id.String(), &xberg.WaitOptions{
    Timeout:      120 * time.Second,
    PollInterval: time.Second,
    Backoff:      xberg.BackoffExponential,
})
var timeoutErr *xberg.TimeoutError
if errors.As(err, &timeoutErr) {
    fmt.Println("still running after 120s")
}
```

Defaults (all three clients): a 5-minute wait timeout, a 1-second initial poll interval, and
exponential backoff capped at 30 seconds. Raise the **wait** timeout for large documents rather
than the per-request timeout — the poll itself is always a short status read; only the wait loop
needs to span the whole extraction.

`wait_for_jobs` / `waitForJobs` / `WaitForJobs` wait for several job ids. Python waits sequentially;
TypeScript and Go wait concurrently and Go cancels the remaining waits on the first error.

`extract_and_wait` / `extractAndWait` / `ExtractAndWait` combine submit and wait in one call — see
the quickstart for the single-document form.

## Cancelling and listing

`cancel_job` / `cancelJob` / `CancelJob` issues `DELETE /v1/jobs/{id}` and is idempotent: a job
already in a terminal state also answers 204. `list_jobs` / `listJobs` / `ListJobs` paginates
`GET /v1/jobs` with `limit`/`offset`.

## Partial success

A batch can end with one job `completed` and another `partial_success` for a different document in
the same request — jobs are independent even when submitted together. A `partial_success` job's
result carries per-document errors alongside whatever did extract; read those before assuming the
whole batch failed. See [Batches](/guides/batches/) for how batch results correlate back to inputs.
