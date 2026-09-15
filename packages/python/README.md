<p align="center">
  <picture>
    <source media="(prefers-color-scheme: dark)" srcset="https://cdn.jsdelivr.net/gh/xberg-io/assets@v1/banner/readme-banner-dark.svg">
    <img alt="Xberg" width="420" src="https://cdn.jsdelivr.net/gh/xberg-io/assets@v1/banner/readme-banner-light.svg">
  </picture>
</p>

# xberg-io-sdk

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

Official Python client for the [Xberg Enterprise](https://xberg.io)
and Xberg Pro document-processing APIs — one client, two targets.

- httpx-based, sync (`XbergClient`) and async (`AsyncXbergClient`) surfaces
- One client speaks to both products: shared
  extraction/jobs/presets/auto-tune/RAG surface, plus capability-gated
  tier-specific methods (Pro auth and control plane; Enterprise
  uploads/usage/document diff/enrichment)
- Generated from two OpenAPI 3.1 specs (Enterprise + Pro), then wrapped in
  ergonomic helpers
- Configurable retry engine (honors `Retry-After`, exponential backoff)
- Type-annotated end to end, `py.typed` shipped

## Install

```sh
pip install xberg-io-sdk
# or
uv add xberg-io-sdk
```

Requires Python 3.10+.

## Quickstart

### Sync — single file with explicit API key

```python
from pathlib import Path
from xberg_io_sdk import XbergClient

# Enterprise (base_url defaults to https://api.xberg.io)
with XbergClient(api_key="kz_...") as client:
    job = client.extract_and_wait(file=Path("invoice.pdf"))
    if job.result is not None:
        print(job.result.content)
```

### Connecting to Xberg Pro

Pro is self-hosted and has no default URL — pass `base_url` (and, to skip the
`/healthz` tier probe, `target="pro"`):

```python
from xberg_io_sdk import XbergClient

with XbergClient(api_key="kz_...", base_url="https://pro.internal", target="pro") as client:
    config = client.auth_config()          # Pro-only
    presets = client.list_saved_presets()  # both tiers; the path spelling follows the tier
```

Saved presets are served by both products at `/v1/saved_presets`, so the same
call works against either target.

### Async — batch extract with parallel waits

```python
import asyncio
from pathlib import Path
from xberg_io_sdk import AsyncXbergClient

async def main() -> None:
    async with AsyncXbergClient(api_key="kz_...") as client:
        jobs = await client.extract_batch([Path("a.pdf"), Path("b.pdf"), Path("c.pdf")])
        results = await client.wait_for_jobs([str(j.id) for j in jobs])
        for job in results:
            print(job.filename, job.status)

asyncio.run(main())
```

## Public API

One `XbergClient` (sync) / `AsyncXbergClient` (async) serves both products.
Constructor: `(api_key=None, base_url=None, target=None, timeout=30,
headers=None, retries=0, retry_on=..., retry_backoff="exponential")`.

Shared methods (both tiers):

| Method | Purpose |
|---|---|
| `extract(file=..., options=..., webhook=...)` | Submit one document, get back a `Job`. |
| `extract_batch(files, options=...)` | Submit many documents in ONE multipart request. |
| `get_job(job_id)` | Fetch current job status / result. |
| `wait_for_job(job_id, timeout=300, ...)` | Poll until terminal (raises on `failed`/`cancelled`). |
| `wait_for_jobs(job_ids, ...)` | Wait for multiple jobs. |
| `extract_and_wait(file=..., ...)` | Submit + wait in one call. |
| `get_job_result(job_id)` | Fetch a job's stored `JobResult` envelope. |
| `list_jobs(...)`, `audit(...)` | List jobs / read the audit log. |
| `cancel_job(job_id)` | Cancel a job (idempotent — also 204s if already terminal). |
| `list_rag_collections()`, `rag_retrieve(name, body)`, `get_rag_job(job_id)`, … | RAG collections/documents/retrieval. |
| `delete_rag_documents(name, body)` | Delete documents from a collection by ID list or metadata filter. |
| `presets()`, `get_preset(id)`, `get_preset_sample(id, name)` | Curated managed presets. |
| `usage(...)` | Per-project usage totals for a date window. |
| `presign_upload(body)`, `confirm_upload(body)` | Stage a large document in object storage, then submit it. |
| `get_job_page(job_id, page_number)` | A rendered page image, as raw `image/png` bytes. |
| `submit_enrich(body)`, `get_enrich_status(job_id)` | Keyword, entity and label enrichment over extracted text. |
| `stream_crawl_events(crawl_job_id)` | A generator of Server-Sent Events for a running crawl. |
| `stop_auto_tune_job(id)` | Stop a running auto-tune job. |
| `list_managed_embedding_presets()` | The deployment's available embedding presets. |
| `list_saved_presets(...)`, `create_saved_preset(body)`, `get_saved_preset(id)`, `update_saved_preset(id, body)`, `delete_saved_preset(id)` | Project-owned saved presets. |
| `list_auto_tune_jobs(...)`, `submit_auto_tune(request, files)`, `get_auto_tune_status(id)`, `get_auto_tune_result(id)`, `delete_auto_tune_job(id)` | Auto-tune runs (`submit_auto_tune` is multipart). |
| `get_auto_tune_capabilities()`, `promote_auto_tune_profile(id, body)` | Discover tunable knobs; promote a run to a named profile. |
| `list_tuning_profiles(...)`, `get_tuning_profile(id)`, `delete_tuning_profile(id)` | Promoted tuning profiles. |

Tier-specific methods are capability-gated — calling one against the wrong tier
raises a clear error instead of a raw 404:

- **Pro only:** `login`, `auth_config`, `get_rag_config`/`set_rag_config`, `get_license_info`, `put_local_upload`
- **Pro only (control plane):** `list_projects`/`create_project`, `list_api_keys`/`create_api_key`/`revoke_api_key`, `list_integrations`/`create_integration`/`get_integration`/`delete_integration`, `connect_integration`/`disconnect_integration`, `list_integration_documents`/`fetch_integration_document`
- **Enterprise only:** `versions`, `get_document`, `diff`/`get_diff_job`, `list_extraction_events`, `list_subscription_deliveries`/`get_subscription_delivery`

### Deliberately not exposed

Three documented routes have no client method, on purpose:

- `GET /readyz` — an infrastructure readiness probe for orchestrators, not
  caller-facing API surface. `GET /healthz` is exposed indirectly: it is the
  tier probe behind `target=None`.
- `GET /v1/oauth/callback` (Pro) — a browser redirect leg of the OIDC flow. The
  provider calls it, not an API client.
- `DELETE /auth/account` (Pro) — a session-cookie account-deletion flow, not
  API-key surface. `POST /auth/login` is exposed because it mints the session
  JWT this client can then send as a bearer token.

Errors are raised as one of:
`XbergError` (base), `AuthError` (401 **and** 403), `ValidationError`,
`NotFoundError`, `RateLimitError` (carries `retry_after`), `ServerError`,
`TimeoutError`.

## Documentation

- SDK docs: <https://docs.sdks.xberg.io>
- Product overview: <https://xberg.io>

## License

MIT — © Kreuzberg, Inc.
