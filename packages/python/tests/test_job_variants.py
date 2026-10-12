"""The job detail route returns tagged extraction and crawl records on both tiers."""

from __future__ import annotations

import pytest
import respx

from tests.conftest import make_job_payload
from xberg_io_sdk import AsyncXbergClient, ValidationError, XbergClient

JOB_ID = "11111111-1111-1111-1111-111111111111"
CRAWL = {
    "id": JOB_ID,
    "created_at": "2026-10-12T10:00:00Z",
    "job_type": "crawl",
    "status": "completed",
    "output_mode": "markdown",
    "seed_urls": ["https://example.test"],
    "progress": {"documents_discovered": 2, "documents_extracted": 1, "documents_failed": 0, "pages_crawled": 3},
    "jobs": [{"id": JOB_ID, "filename": "page.html", "status": "completed", "source_url": "https://example.test/page"}],
    "pages": [{"url": "https://example.test", "status": "fetched", "fetched_at": "2026-10-12T10:00:00Z"}],
    "future_field": "retained",
}


@pytest.mark.parametrize("target", ["enterprise", "pro"])
@pytest.mark.parametrize("asynchronous", [False, True])
@pytest.mark.parametrize("kind", ["extraction", "crawl", "legacy"])
@respx.mock
async def test_get_job_decodes_both_variants_and_legacy_extraction(
    base_url: str, target: str, asynchronous: bool, kind: str
) -> None:
    payload = (
        dict(CRAWL)
        if kind == "crawl"
        else {**make_job_payload(job_id=JOB_ID, status="completed"), "future_field": "retained"}
    )
    if kind == "extraction":
        payload["job_type"] = kind
    respx.get(f"{base_url}/v1/jobs/{JOB_ID}").respond(200, json=payload)
    if asynchronous:
        async with AsyncXbergClient(base_url=base_url, target=target) as client:
            job = await client.get_job(JOB_ID)
    else:
        with XbergClient(base_url=base_url, target=target) as client:
            job = client.get_job(JOB_ID)
    assert job.job_type == ("crawl" if kind == "crawl" else "extraction")
    assert str(job.id) == JOB_ID
    assert job.to_dict()["future_field"] == "retained"
    if kind == "crawl":
        assert job.progress.pages_crawled == 3
        assert job.jobs[0].source_url == "https://example.test/page"
        assert job.pages[0].url == "https://example.test"
    else:
        assert job.filename == "invoice.pdf"


@pytest.mark.parametrize("asynchronous", [False, True])
@pytest.mark.parametrize("discriminator", ["future", None, 42])
@respx.mock
async def test_get_job_rejects_unknown_discriminator(base_url: str, asynchronous: bool, discriminator: object) -> None:
    payload = {**make_job_payload(job_id=JOB_ID, status="completed"), "job_type": discriminator}
    respx.get(f"{base_url}/v1/jobs/{JOB_ID}").respond(200, json=payload)
    if asynchronous:
        async with AsyncXbergClient(base_url=base_url) as client:
            with pytest.raises(ValidationError, match="job_type"):
                await client.get_job(JOB_ID)
    else:
        with XbergClient(base_url=base_url) as client, pytest.raises(ValidationError, match="job_type"):
            client.get_job(JOB_ID)


@pytest.mark.parametrize("asynchronous", [False, True])
@respx.mock
async def test_extraction_wait_rejects_crawl_kind(base_url: str, asynchronous: bool) -> None:
    route = respx.get(f"{base_url}/v1/jobs/{JOB_ID}").respond(200, json=CRAWL)
    if asynchronous:
        async with AsyncXbergClient(base_url=base_url) as client:
            with pytest.raises(ValidationError, match=r"extraction.*crawl"):
                await client.wait_for_job(JOB_ID)
    else:
        with XbergClient(base_url=base_url) as client, pytest.raises(ValidationError, match=r"extraction.*crawl"):
            client.wait_for_job(JOB_ID)
    assert route.call_count == 1
