# kreuzberg-cloud

Official Python client for the [Kreuzberg Cloud](https://kreuzberg.cloud)
document-processing API.

- httpx-based, sync (`KreuzbergCloud`) and async (`AsyncKreuzbergCloud`) surfaces
- Generated from the upstream OpenAPI 3.1 spec, then wrapped in ergonomic helpers
- Type-annotated end to end, `py.typed` shipped
- Zero-friction onboarding via `from_sandbox()` — no signup needed for evaluation

## Install

```sh
pip install kreuzberg-cloud
# or
uv add kreuzberg-cloud
```

Requires Python 3.10+.

## Quickstart

### Sync — single file with explicit API key

```python
from pathlib import Path
from kreuzberg_cloud import KreuzbergCloud

with KreuzbergCloud(api_key="sk_live_...") as client:
    job = client.extract_and_wait(file=Path("invoice.pdf"))
    if job.result is not None:
        print(job.result.content)
```

### Async — batch extract with parallel waits

```python
import asyncio
from pathlib import Path
from kreuzberg_cloud import AsyncKreuzbergCloud

async def main() -> None:
    async with AsyncKreuzbergCloud(api_key="sk_live_...") as client:
        jobs = await client.extract_batch([Path("a.pdf"), Path("b.pdf"), Path("c.pdf")])
        results = await client.wait_for_jobs([str(j.id) for j in jobs])
        for job in results:
            print(job.filename, job.status)

asyncio.run(main())
```

### Async — sandbox onboarding (no API key required)

```python
import asyncio
from kreuzberg_cloud import AsyncKreuzbergCloud

async def main() -> None:
    async with await AsyncKreuzbergCloud.from_sandbox() as client:
        job = await client.extract_and_wait(file=b"hello world")
        print(job.status, job.result and job.result.content)

asyncio.run(main())
```

## Public API

The following methods are available on both `KreuzbergCloud` (sync) and
`AsyncKreuzbergCloud` (async):

| Method | Purpose |
|---|---|
| `extract(file=..., options=...)` | Submit one document, get back a `Job`. |
| `extract_batch(files, options=...)` | Submit many documents (parallel for async). |
| `get_job(job_id)` | Fetch current job status / result. |
| `wait_for_job(job_id, timeout=300, ...)` | Poll until terminal status. |
| `wait_for_jobs(job_ids, ...)` | Wait for multiple jobs. |
| `extract_and_wait(file=..., ...)` | Submit + wait in one call. |
| `create_sandbox_key()` | Mint an ephemeral sandbox API key. |
| `from_sandbox()` (classmethod) | Build a client preconfigured with a sandbox key. |

Errors are raised as one of:
`KreuzbergCloudError` (base), `AuthError`, `ValidationError`, `NotFoundError`,
`RateLimitError` (carries `retry_after`), `ServerError`, `TimeoutError`.

## Documentation

Full reference and guides: <https://docs.kreuzberg.cloud>

## License

MIT — © Kreuzberg, Inc.
