"""The derived generator spec must produce both tagged job response variants."""

from __future__ import annotations

import importlib
from uuid import UUID

import httpx
import pytest

JOB_ID = UUID("11111111-1111-1111-1111-111111111111")


@pytest.mark.parametrize("schema_set", ["api", "pro"])
@pytest.mark.parametrize("job_type", ["extraction", "crawl"])
def test_generated_get_job_keeps_both_discriminated_variants(schema_set: str, job_type: str) -> None:
    client_module = importlib.import_module(f"xberg_io_sdk._generated_{schema_set}.client")
    endpoint = importlib.import_module(f"xberg_io_sdk._generated_{schema_set}.api.jobs.get_job")
    payload = {
        "id": str(JOB_ID),
        "created_at": "2026-10-12T10:00:00Z",
        "status": "completed",
        "job_type": job_type,
        "filename": "document.pdf",
        "mime_type": "application/pdf",
        "output_mode": "markdown",
        "seed_urls": ["https://example.test"],
        "progress": {
            "documents_discovered": 1,
            "documents_extracted": 1,
            "documents_failed": 0,
            "pages_crawled": 1,
        },
    }

    def respond(request: httpx.Request) -> httpx.Response:
        assert request.method == "GET"
        assert request.url.path == f"/v1/jobs/{JOB_ID}"
        return httpx.Response(200, json=payload)

    with httpx.Client(base_url="https://api.example.test", transport=httpx.MockTransport(respond)) as http:
        client = client_module.AuthenticatedClient(
            base_url="https://api.example.test", token="test-token"
        ).set_httpx_client(http)
        response = endpoint.sync_detailed(JOB_ID, client=client)
    assert response.parsed.job_type == job_type
    assert response.parsed.id == JOB_ID
    if job_type == "crawl":
        assert response.parsed.progress.documents_extracted == 1
    else:
        assert response.parsed.filename == "document.pdf"


@pytest.mark.parametrize("schema_set", ["api", "pro"])
@pytest.mark.parametrize("threshold", [False, True, 0, 1, 2])
def test_generated_tesseract_keeps_legacy_booleans_and_numeric_methods(schema_set: str, threshold: bool | int) -> None:
    model = importlib.import_module(f"xberg_io_sdk._generated_{schema_set}.models.tesseract_config").TesseractConfig
    constructed = model(thresholding_method=threshold).to_dict()["thresholding_method"]
    decoded = model.from_dict({"thresholding_method": threshold}).to_dict()["thresholding_method"]
    assert type(constructed) is type(threshold)
    assert type(decoded) is type(threshold)
    assert constructed == threshold
    assert decoded == threshold
