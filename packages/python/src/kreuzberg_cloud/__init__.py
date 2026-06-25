"""Official Python client for the Xberg Enterprise API."""

from __future__ import annotations

from kreuzberg_cloud._generated.models.extraction_options import ExtractionOptions
from kreuzberg_cloud._generated.models.extraction_result import ExtractionResult
from kreuzberg_cloud._generated.models.job_response import JobResponse
from kreuzberg_cloud._generated.models.job_status import JobStatus
from kreuzberg_cloud.client import AsyncKreuzbergCloud, KreuzbergCloud
from kreuzberg_cloud.errors import (
    AuthError,
    KreuzbergCloudError,
    NotFoundError,
    RateLimitError,
    ServerError,
    TimeoutError,  # noqa: A004 — domain-specific timeout, intentionally shadows builtin in this namespace
    ValidationError,
)
from kreuzberg_cloud.models import SandboxKey

# Friendly aliases over the generated types: the API talks about "jobs" and
# "extraction results", so expose the typed models under those names.
Job = JobResponse
JobResult = ExtractionResult

__all__ = [
    "AsyncKreuzbergCloud",
    "AuthError",
    "ExtractionOptions",
    "ExtractionResult",
    "Job",
    "JobResponse",
    "JobResult",
    "JobStatus",
    "KreuzbergCloud",
    "KreuzbergCloudError",
    "NotFoundError",
    "RateLimitError",
    "SandboxKey",
    "ServerError",
    "TimeoutError",
    "ValidationError",
    "__version__",
]

__version__ = "0.1.1"
