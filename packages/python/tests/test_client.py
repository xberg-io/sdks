"""Smoke tests for the public client surface."""

from __future__ import annotations

import pytest

import xberg_io_sdk
from xberg_io_sdk import (
    AsyncXbergClient,
    ExtractedDocument,
    ExtractionJobResponse,
    ExtractionResult,
    Job,
    JobResponse,
    JobResult,
    JobResultError,
    XbergClient,
    XbergError,
)
from xberg_io_sdk._generated_api.models.extraction_job_response import (
    ExtractionJobResponse as GeneratedExtractionJobResponse,
)
from xberg_io_sdk._generated_api.models.job_result import JobResult as GeneratedJobResult


def test_job_response_alias_survives_the_upstream_schema_rename() -> None:
    # Upstream renamed `JobResponse` to `ExtractionJobResponse`; the old public name is an alias.
    assert ExtractionJobResponse is GeneratedExtractionJobResponse
    assert JobResponse is ExtractionJobResponse
    assert Job is ExtractionJobResponse
    assert {"ExtractionJobResponse", "Job", "JobResponse"} <= set(xberg_io_sdk.__all__)


def test_job_result_is_the_spec_schema_not_an_extraction_result_alias() -> None:
    assert JobResult is GeneratedJobResult
    assert JobResult is not ExtractionResult
    assert JobResult is not ExtractedDocument
    assert JobResult is not JobResponse
    assert {"job_id", "status", "results", "child_job_ids", "completed_at", "errors"} <= set(
        JobResult.__annotations__,
    )
    assert {"error_type", "message", "code", "index", "source"} <= set(JobResultError.__annotations__)


def test_sync_client_constructs_with_api_key() -> None:
    with XbergClient(api_key="secret-test") as client:
        assert client._headers["Authorization"] == "Bearer secret-test"


def test_sync_client_constructs_without_api_key() -> None:
    with XbergClient() as client:
        assert "Authorization" not in client._headers


def test_sync_client_uses_custom_base_url() -> None:
    with XbergClient(base_url="https://api.example.test/") as client:
        assert client._base_url == "https://api.example.test"


@pytest.mark.asyncio
async def test_async_client_constructs_with_api_key() -> None:
    async with AsyncXbergClient(api_key="secret-test") as client:
        assert client._headers["Authorization"] == "Bearer secret-test"


@pytest.mark.asyncio
async def test_async_client_uses_custom_base_url() -> None:
    async with AsyncXbergClient(base_url="https://api.example.test/") as client:
        assert client._base_url == "https://api.example.test"


def test_error_carries_status_code_and_payload() -> None:
    err = XbergError("bad request", status_code=400, payload={"detail": "no file"})
    assert err.status_code == 400
    assert err.payload == {"detail": "no file"}
    assert str(err) == "bad request"
