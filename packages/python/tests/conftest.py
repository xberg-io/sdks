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
    mime_type: str = "application/pdf",
    result: dict[str, Any] | None = None,
    processing_time_ms: int | None = None,
) -> dict[str, Any]:
    """Build an ExtractionJobResponse-shaped payload for stubbed responses.

    ``mime_type`` is required by the schema on both tiers, so the fixture always
    sends it -- a payload without it is a shape no instance serves.
    """
    payload: dict[str, Any] = {
        "id": job_id or str(uuid.uuid4()),
        "filename": filename,
        "mime_type": mime_type,
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

    ``metadata``, ``tables`` and ``counts`` are all required by
    ``JobResultDocument``, and a live instance sends every one of them on every
    document -- ``counts`` as ``{"pages": n, "tables": n, "images": n}``. The
    defaults here mirror that, so a fixture cannot encode a shape the server
    never sends.
    """
    return {
        "content": content,
        "mime_type": "text/plain",
        "metadata": {},
        "tables": [],
        "counts": {"pages": 0, "tables": 0, "images": 0},
    }


def make_job_result_payload(
    *,
    job_id: str = "aaaaaaaa-0000-4000-8000-000000000001",
    status: str = "completed",
    cached: bool = False,
    results: list[dict[str, Any]] | None = None,
    child_job_ids: list[str] | None = None,
    errors: list[dict[str, Any]] | None = None,
    completed_at: str | None = "2026-05-09T10:05:00Z",
) -> dict[str, Any]:
    """Build a ``JobResult``-shaped body, as served by ``GET /v1/jobs/{id}/result`` on both tiers."""
    return {
        "job_id": job_id,
        "status": status,
        "cached": cached,
        "results": [make_extraction_result()] if results is None else results,
        "child_job_ids": child_job_ids if child_job_ids is not None else [],
        "errors": errors if errors is not None else [],
        "completed_at": completed_at,
    }


def make_preset_summary(*, preset_id: str = "invoice-v1") -> dict[str, Any]:
    """Build a ``PresetSummary``-shaped element of the ``GET /v1/presets`` array."""
    return {
        "id": preset_id,
        "version": "1.0.0",
        "schema_name": "Invoice",
        "description": "Structured invoice fields",
        "category": "finance",
        "preferred_call_mode": "text_only",
        "emit_citations": True,
        "fingerprint": "sha256:0badc0de",
    }


def make_preset_detail(*, preset_id: str = "invoice-v1") -> dict[str, Any]:
    """Build a ``PresetDetail``-shaped body, as served by ``GET /v1/presets/{id}``."""
    return {
        **make_preset_summary(preset_id=preset_id),
        "schema": {"type": "object", "properties": {"total": {"type": "number"}}},
        "system_prompt": "Extract the invoice fields.",
    }


@pytest.fixture
def base_url() -> str:
    """Return the synthetic base URL used by the respx-mocked tests."""
    return TEST_BASE_URL


@pytest.fixture
def api_key() -> str:
    """Return the synthetic API key used by the respx-mocked tests."""
    return TEST_API_KEY
