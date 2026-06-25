"""Shared pytest fixtures for the xberg-enterprise test suite."""

from __future__ import annotations

import uuid
from typing import Any

import pytest

TEST_BASE_URL = "https://api.example.test"
TEST_API_KEY = "test-api-key"


def make_job_payload(
    *,
    job_id: str | None = None,
    status: str = "pending",
    filename: str = "invoice.pdf",
    result: dict[str, Any] | None = None,
    processing_time_ms: int | None = None,
) -> dict[str, Any]:
    """Build a JobResponse-shaped payload for stubbed responses."""
    payload: dict[str, Any] = {
        "id": job_id or str(uuid.uuid4()),
        "filename": filename,
        "status": status,
        "created_at": "2026-05-09T10:00:00Z",
    }
    if result is not None:
        payload["result"] = result
    if processing_time_ms is not None:
        payload["processing_time_ms"] = processing_time_ms
    return payload


def make_extract_response(*, job_ids: list[str] | None = None, status: str = "pending") -> dict[str, Any]:
    """Build a 202 Accepted body returned by ``POST /v1/extract``."""
    return {
        "job_ids": job_ids or [str(uuid.uuid4())],
        "status": status,
    }


def make_extraction_result(*, content: str = "hello world") -> dict[str, Any]:
    """Build a minimal ExtractionResult dict.

    ``metadata`` and ``tables`` became required fields in the post-shadow-type
    OpenAPI surface; provide empty defaults so wire-level parsing succeeds.
    """
    return {
        "content": content,
        "mime_type": "text/plain",
        "metadata": {},
        "tables": [],
    }


@pytest.fixture
def base_url() -> str:
    """Return the synthetic base URL used by the respx-mocked tests."""
    return TEST_BASE_URL


@pytest.fixture
def api_key() -> str:
    """Return the synthetic API key used by the respx-mocked tests."""
    return TEST_API_KEY
