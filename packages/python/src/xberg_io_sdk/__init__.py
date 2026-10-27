"""Official Python client for the Xberg Enterprise and Xberg Pro APIs."""

from __future__ import annotations

from xberg_io_sdk._generated_api.models.extracted_document import ExtractedDocument
from xberg_io_sdk._generated_api.models.extraction_job_response import ExtractionJobResponse
from xberg_io_sdk._generated_api.models.extraction_options import ExtractionOptions
from xberg_io_sdk._generated_api.models.file_extraction_config import FileExtractionConfig
from xberg_io_sdk._generated_api.models.job_result import JobResult
from xberg_io_sdk._generated_api.models.job_result_error import JobResultError
from xberg_io_sdk._generated_api.models.job_status import JobStatus
from xberg_io_sdk._generated_pro.models.health_response import HealthResponse as ProHealthResponse
from xberg_io_sdk._generated_pro.models.pro_integration_list_response import ProIntegrationListResponse
from xberg_io_sdk.client import AsyncXbergClient, GetJobResponse, XbergClient
from xberg_io_sdk.errors import (
    AuthError,
    GatewayTimeoutError,
    NotFoundError,
    PreconditionFailedError,
    PreconditionRequiredError,
    RateLimitError,
    RequestTimeoutError,
    ResultExpiredError,
    ServerError,
    TimeoutError,  # noqa: A004 — domain-specific timeout, intentionally shadows builtin in this namespace
    ValidationError,
    XbergError,
)

ListIntegrationsResponse = ProIntegrationListResponse
ExtractionResult = ExtractedDocument
# ~keep Upstream renamed this schema to `ExtractionJobResponse`; `JobResponse` was
# ~keep already exported here, so it stays as an alias rather than breaking callers.
JobResponse = ExtractionJobResponse
Job = ExtractionJobResponse

__all__ = [
    "AsyncXbergClient",
    "AuthError",
    "ExtractedDocument",
    "ExtractionJobResponse",
    "ExtractionOptions",
    "ExtractionResult",
    "FileExtractionConfig",
    "GatewayTimeoutError",
    "GetJobResponse",
    "Job",
    "JobResponse",
    "JobResult",
    "JobResultError",
    "JobStatus",
    "ListIntegrationsResponse",
    "NotFoundError",
    "PreconditionFailedError",
    "PreconditionRequiredError",
    "ProHealthResponse",
    "ProIntegrationListResponse",
    "RateLimitError",
    "RequestTimeoutError",
    "ResultExpiredError",
    "ServerError",
    "TimeoutError",
    "ValidationError",
    "XbergClient",
    "XbergError",
    "__version__",
]

__version__ = "0.9.0"
