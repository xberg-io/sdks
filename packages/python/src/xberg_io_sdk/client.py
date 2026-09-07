"""High-level dual-target client for the Xberg Enterprise and Xberg Pro HTTP APIs.

One :class:`XbergClient` (and its async twin :class:`AsyncXbergClient`) speaks to
either product. The shared surface — extraction, jobs (including job results),
audit, managed presets, saved presets, auto-tune, tuning profiles, and the RAG
API — is written once and carries no tier gate. Tier-specific methods are
capability-gated: they probe the
connected instance (``GET /healthz``'s ``tier``, or an explicit ``target``) and
raise a clear error instead of a raw 404 when invoked against the wrong tier.

Both products authenticate identically: ``Authorization: Bearer {api_key}`` —
Enterprise uses a ``kz_`` project key, Pro accepts a ``kz_`` key or an OIDC
session JWT. Enterprise defaults ``base_url`` to ``https://api.xberg.io``; Pro
has no default (its spec ships no servers block) and requires an explicit one.

Enterprise splits into two binaries — the data plane ``base_url`` addresses and
a control plane (projects, API keys, integrations) on its own origin — while Pro
serves both from one. ``control_plane_base_url`` records the origin of the
second and defaults to ``base_url``. Backend operations use ``control_plane_token``
when supplied, otherwise the API key; public sandbox OIDC tokens are passed
separately as ``sandbox_token``.
"""

from __future__ import annotations

import asyncio
import json
import mimetypes
import re
import threading
import time
from collections.abc import Mapping
from contextlib import asynccontextmanager, contextmanager
from pathlib import Path
from typing import TYPE_CHECKING, Any, BinaryIO, Literal, Protocol
from urllib.parse import quote

import httpx

from xberg_io_sdk._generated_api.models.auto_tune_capabilities_response import AutoTuneCapabilitiesResponse
from xberg_io_sdk._generated_api.models.auto_tune_job_status import AutoTuneJobStatus
from xberg_io_sdk._generated_api.models.auto_tune_result import AutoTuneResult
from xberg_io_sdk._generated_api.models.crawl_event_v1_type_0 import CrawlEventV1Type0
from xberg_io_sdk._generated_api.models.crawl_event_v1_type_1 import CrawlEventV1Type1
from xberg_io_sdk._generated_api.models.crawl_event_v1_type_2 import CrawlEventV1Type2
from xberg_io_sdk._generated_api.models.crawl_event_v1_type_3 import CrawlEventV1Type3
from xberg_io_sdk._generated_api.models.create_auto_tune_job_response import CreateAutoTuneJobResponse
from xberg_io_sdk._generated_api.models.create_saved_preset_response import CreateSavedPresetResponse
from xberg_io_sdk._generated_api.models.enrich_job_status_type_0 import EnrichJobStatusType0
from xberg_io_sdk._generated_api.models.enrich_job_status_type_1 import EnrichJobStatusType1
from xberg_io_sdk._generated_api.models.enrich_job_status_type_2 import EnrichJobStatusType2
from xberg_io_sdk._generated_api.models.enrich_job_submitted import EnrichJobSubmitted
from xberg_io_sdk._generated_api.models.extraction_options import ExtractionOptions
from xberg_io_sdk._generated_api.models.file_extraction_config import FileExtractionConfig
from xberg_io_sdk._generated_api.models.job_response import JobResponse
from xberg_io_sdk._generated_api.models.job_result import JobResult
from xberg_io_sdk._generated_api.models.list_auto_tune_jobs_response import ListAutoTuneJobsResponse
from xberg_io_sdk._generated_api.models.list_extraction_events_response import ListExtractionEventsResponse
from xberg_io_sdk._generated_api.models.list_saved_presets_response import ListSavedPresetsResponse
from xberg_io_sdk._generated_api.models.list_tuning_profiles_response import ListTuningProfilesResponse
from xberg_io_sdk._generated_api.models.preset_detail import PresetDetail
from xberg_io_sdk._generated_api.models.preset_summary import PresetSummary
from xberg_io_sdk._generated_api.models.saved_preset_detail import SavedPresetDetail
from xberg_io_sdk._generated_api.models.tuning_profile_detail import TuningProfileDetail
from xberg_io_sdk._generated_api.models.update_saved_preset_response import UpdateSavedPresetResponse
from xberg_io_sdk._generated_backend.models.analytics_response import AnalyticsResponse as BackendAnalyticsResponse
from xberg_io_sdk._generated_backend.models.auth_config_response import AuthConfigResponse as BackendAuthConfigResponse
from xberg_io_sdk._generated_backend.models.begin_connect_response import (
    BeginConnectResponse as BackendBeginConnectResponse,
)
from xberg_io_sdk._generated_backend.models.billing_response import BillingResponse as BackendBillingResponse
from xberg_io_sdk._generated_backend.models.checkout_response import CheckoutResponse as BackendCheckoutResponse
from xberg_io_sdk._generated_backend.models.create_api_key_response import (
    CreateApiKeyResponse as BackendCreateApiKeyResponse,
)
from xberg_io_sdk._generated_backend.models.create_invitation_response import (
    CreateInvitationResponse as BackendCreateInvitationResponse,
)
from xberg_io_sdk._generated_backend.models.health_response import HealthResponse as BackendHealthResponse
from xberg_io_sdk._generated_backend.models.integration_response import (
    IntegrationResponse as BackendIntegrationResponse,
)
from xberg_io_sdk._generated_backend.models.list_api_keys_response import (
    ListApiKeysResponse as BackendListApiKeysResponse,
)
from xberg_io_sdk._generated_backend.models.list_audit_entries_response import (
    ListAuditEntriesResponse as BackendListAuditEntriesResponse,
)
from xberg_io_sdk._generated_backend.models.list_documents_response import (
    ListDocumentsResponse as BackendListDocumentsResponse,
)
from xberg_io_sdk._generated_backend.models.list_integrations_response import (
    ListIntegrationsResponse as BackendListIntegrationsResponse,
)
from xberg_io_sdk._generated_backend.models.list_invitations_response import (
    ListInvitationsResponse as BackendListInvitationsResponse,
)
from xberg_io_sdk._generated_backend.models.list_members_response import (
    ListMembersResponse as BackendListMembersResponse,
)
from xberg_io_sdk._generated_backend.models.list_projects_response import (
    ListProjectsResponse as BackendListProjectsResponse,
)
from xberg_io_sdk._generated_backend.models.list_webhook_deliveries_response import (
    ListWebhookDeliveriesResponse as BackendListWebhookDeliveriesResponse,
)
from xberg_io_sdk._generated_backend.models.list_webhooks_response import (
    ListWebhooksResponse as BackendListWebhooksResponse,
)
from xberg_io_sdk._generated_backend.models.login_response import LoginResponse as BackendLoginResponse
from xberg_io_sdk._generated_backend.models.member_response import MemberResponse as BackendMemberResponse
from xberg_io_sdk._generated_backend.models.portal_response import PortalResponse as BackendPortalResponse
from xberg_io_sdk._generated_backend.models.project_response import ProjectResponse as BackendProjectResponse
from xberg_io_sdk._generated_backend.models.rag_config_response import RagConfigResponse as BackendRagConfigResponse
from xberg_io_sdk._generated_backend.models.readiness_response import ReadinessResponse as BackendReadinessResponse
from xberg_io_sdk._generated_backend.models.retry_webhook_delivery_response import (
    RetryWebhookDeliveryResponse as BackendRetryWebhookDeliveryResponse,
)
from xberg_io_sdk._generated_backend.models.sandbox_extract_response import (
    SandboxExtractResponse as BackendSandboxExtractResponse,
)
from xberg_io_sdk._generated_backend.models.usage_response import UsageResponse as BackendUsageResponse
from xberg_io_sdk._generated_backend.models.webhook_response import WebhookResponse as BackendWebhookResponse
from xberg_io_sdk._generated_backend.models.webhook_test_response import (
    WebhookTestResponse as BackendWebhookTestResponse,
)
from xberg_io_sdk._generated_pro.models.begin_o_auth_response import BeginOAuthResponse
from xberg_io_sdk._generated_pro.models.create_api_key_response import CreateApiKeyResponse
from xberg_io_sdk._generated_pro.models.integration_response import IntegrationResponse
from xberg_io_sdk._generated_pro.models.list_api_keys_response import ListApiKeysResponse
from xberg_io_sdk._generated_pro.models.list_documents_response import ListDocumentsResponse
from xberg_io_sdk._generated_pro.models.list_integrations_response import ListIntegrationsResponse
from xberg_io_sdk._generated_pro.models.list_projects_response import ListProjectsResponse
from xberg_io_sdk._generated_pro.models.project_response import ProjectResponse
from xberg_io_sdk.errors import TimeoutError as ClientTimeoutError
from xberg_io_sdk.errors import XbergError, parse_retry_after, raise_for_status

if TYPE_CHECKING:
    import sys
    from collections.abc import AsyncIterator, Iterable, Iterator, Sequence
    from types import TracebackType

    from xberg_io_sdk._generated_api.models.create_auto_tune_job_request import CreateAutoTuneJobRequest
    from xberg_io_sdk._generated_api.models.create_saved_preset_request import CreateSavedPresetRequest
    from xberg_io_sdk._generated_api.models.enrich_text_request import EnrichTextRequest
    from xberg_io_sdk._generated_api.models.promote_profile_request import PromoteProfileRequest
    from xberg_io_sdk._generated_api.models.update_saved_preset_request import UpdateSavedPresetRequest
    from xberg_io_sdk._generated_backend.models.accept_invitation_request import (
        AcceptInvitationRequest as BackendAcceptInvitationRequest,
    )
    from xberg_io_sdk._generated_backend.models.create_api_key_request import (
        CreateApiKeyRequest as BackendCreateApiKeyRequest,
    )
    from xberg_io_sdk._generated_backend.models.create_integration_request import (
        CreateIntegrationRequest as BackendCreateIntegrationRequest,
    )
    from xberg_io_sdk._generated_backend.models.create_invitation_request import (
        CreateInvitationRequest as BackendCreateInvitationRequest,
    )
    from xberg_io_sdk._generated_backend.models.create_project_request import (
        CreateProjectRequest as BackendCreateProjectRequest,
    )
    from xberg_io_sdk._generated_backend.models.create_webhook_request import (
        CreateWebhookRequest as BackendCreateWebhookRequest,
    )
    from xberg_io_sdk._generated_backend.models.login_request import LoginRequest as BackendLoginRequest
    from xberg_io_sdk._generated_backend.models.set_rag_config_request import (
        SetRagConfigRequest as BackendSetRagConfigRequest,
    )
    from xberg_io_sdk._generated_backend.models.update_member_role_request import (
        UpdateMemberRoleRequest as BackendUpdateMemberRoleRequest,
    )
    from xberg_io_sdk._generated_backend.models.update_project_request import (
        UpdateProjectRequest as BackendUpdateProjectRequest,
    )
    from xberg_io_sdk._generated_backend.models.update_webhook_request import (
        UpdateWebhookRequest as BackendUpdateWebhookRequest,
    )
    from xberg_io_sdk._generated_pro.models.create_api_key_request import CreateApiKeyRequest
    from xberg_io_sdk._generated_pro.models.create_integration_request import CreateIntegrationRequest
    from xberg_io_sdk._generated_pro.models.create_project_request import CreateProjectRequest

    if sys.version_info >= (3, 11):
        from typing import Self
    else:
        from typing_extensions import Self

DEFAULT_ENTERPRISE_BASE_URL = "https://api.xberg.io"
DEFAULT_TIMEOUT_SECONDS = 30.0


# The two specs spell the saved-preset collection differently; every saved-preset
# call renders its path from the resolved tier via ``_saved_presets_path``.
def _q(value: object) -> str:
    """Percent-encode a path parameter.

    Every segment goes through this. A collection name or filename containing
    `/`, `?` or `#` would otherwise retarget the request -- into another route,
    or truncated at the query or fragment marker. `safe=""` because nothing is
    safe in a single path segment, `/` least of all.
    """
    segment = str(value)
    if segment in {".", ".."}:
        return segment.replace(".", "%2E")
    return quote(segment, safe="")


_SAVED_PRESETS_PATH_ENTERPRISE = "/v1/saved_presets"
_SAVED_PRESETS_PATH_PRO = "/v1/saved-presets"

_AUTO_TUNE_PATH = "/v1/auto-tune"
_TUNING_PROFILES_PATH = "/v1/tuning-profiles"
_ENRICH_PATH = "/v1/enrich"
_EXTRACTIONS_PATH = "/v1/extractions"

_TERMINAL_STATUSES: frozenset[str] = frozenset({"completed", "failed", "cancelled", "partial_success"})
_FAILED_STATUSES: frozenset[str] = frozenset({"failed", "cancelled"})

_DEFAULT_POLL_INTERVAL = 1.0
_DEFAULT_WAIT_TIMEOUT = 300.0
_MAX_BACKOFF_INTERVAL = 30.0
_BACKOFF_FACTOR = 2.0

_DEFAULT_RETRIES = 0
_DEFAULT_RETRY_STATUSES: frozenset[int] = frozenset({429, 502, 503, 504})
_RETRY_BACKOFF_BASE = 0.2

FileInput = Path | bytes | BinaryIO
"""Accepted shapes for a single file argument: filesystem path, raw bytes, or an open binary stream."""

OptionsInput = ExtractionOptions | dict[str, Any] | None
"""Accepted shapes for the ``options`` argument: typed model, plain dict, or ``None``."""

FileConfigInput = FileExtractionConfig | dict[str, Any] | None
"""Accepted shapes for one per-file ``config`` override: typed model, plain dict, or ``None`` for no override."""

BackoffStrategy = Literal["constant", "exponential"]
Target = Literal["enterprise", "pro"]


class _SupportsToDict(Protocol):
    """Structural type for the generated request models, which all serialize via ``to_dict()``."""

    def to_dict(self) -> dict[str, Any]:
        """Return the JSON-ready wire representation of this model."""
        ...


BodyInput = _SupportsToDict | Mapping[str, Any]
"""Accepted shapes for a typed JSON request body: a generated request model or a plain mapping."""

EnrichJobStatus = EnrichJobStatusType0 | EnrichJobStatusType1 | EnrichJobStatusType2
"""The three ``status``-discriminated variants ``GET /v1/enrich/{job_id}`` can return."""

_EnrichJobStatusModel = type[EnrichJobStatusType0] | type[EnrichJobStatusType1] | type[EnrichJobStatusType2]

_ENRICH_STATUS_MODELS: dict[str, _EnrichJobStatusModel] = {
    "pending": EnrichJobStatusType0,
    "completed": EnrichJobStatusType1,
    "failed": EnrichJobStatusType2,
}

CrawlEvent = CrawlEventV1Type0 | CrawlEventV1Type1 | CrawlEventV1Type2 | CrawlEventV1Type3
"""The four ``kind``-discriminated variants ``GET /v1/crawl-jobs/{id}/events`` streams.

``page`` (:class:`CrawlEventV1Type0`), ``error`` (:class:`CrawlEventV1Type1`),
``discovered`` (:class:`CrawlEventV1Type2`) and ``complete``
(:class:`CrawlEventV1Type3`). Every variant carries ``crawl_job_id`` and ``ts``;
narrow on ``event.kind`` before touching a variant-specific field.
"""

_CrawlEventModel = type[CrawlEventV1Type0] | type[CrawlEventV1Type1] | type[CrawlEventV1Type2] | type[CrawlEventV1Type3]

_CRAWL_EVENT_MODELS: dict[str, _CrawlEventModel] = {
    "page": CrawlEventV1Type0,
    "error": CrawlEventV1Type1,
    "discovered": CrawlEventV1Type2,
    "complete": CrawlEventV1Type3,
}

_SSE_ACCEPT = "text/event-stream"
_SSE_DATA_FIELD = "data"
_SSE_COMMENT_PREFIX = ":"
_MAX_SSE_FRAME_BYTES = 1 << 20
_SSE_LINE_END = re.compile(rb"\r\n|\r|\n")


def _user_agent() -> str:
    """Return the ``User-Agent`` header, sourcing the version from the package root."""
    from xberg_io_sdk import __version__  # noqa: PLC0415 — local import breaks the __init__/client cycle  # ~keep

    return f"xberg-io-sdk-python/{__version__}"


def _coerce_options(options: OptionsInput) -> dict[str, Any] | None:
    """Normalize an :class:`ExtractionOptions`/dict/``None`` into a plain dict (or ``None``)."""
    if options is None:
        return None
    if isinstance(options, ExtractionOptions):
        return options.to_dict()
    return dict(options)


def _guess_mime_type(filename: str) -> str:
    if filename.lower().endswith(".md"):
        return "text/markdown"
    return mimetypes.guess_type(filename)[0] or "application/octet-stream"


def _prepare_file_part(file: FileInput) -> tuple[str, bytes | BinaryIO, str]:
    """Convert a ``FileInput`` into the ``(filename, payload, content-type)`` tuple httpx wants."""
    if isinstance(file, Path):
        return (file.name, file.read_bytes(), _guess_mime_type(file.name))
    if isinstance(file, (bytes, bytearray)):
        return ("upload.bin", bytes(file), "application/octet-stream")
    name = getattr(file, "name", None)
    filename = Path(str(name)).name if isinstance(name, str) and name else "upload.bin"
    return (filename, file, _guess_mime_type(filename))


def _multipart_files(files: Iterable[FileInput]) -> list[tuple[str, tuple[str, bytes | BinaryIO, str]]]:
    """Build the ``files=`` argument for a single multipart request carrying every document."""
    return [("file", _prepare_file_part(file)) for file in files]


def _backend_json(response: httpx.Response) -> Any:
    try:
        return response.json()
    except ValueError as exc:
        raise XbergError("backend response was not valid JSON", status_code=response.status_code) from exc


def _public_sandbox_files(file: FileInput | None, *, mode: str | None, preset: str | None, url: str | None) -> Any:
    if file is None and (mode != "web" or not url):
        raise XbergError("public sandbox requires a file, or web mode with a URL", status_code=None)
    parts: list[Any] = _multipart_files([file]) if file is not None else []
    parts.extend(
        (key, (None, value, "text/plain"))
        for key, value in {"mode": mode, "preset": preset, "url": url}.items()
        if value is not None
    )
    return parts


def _reject_unretryable_files(files: Any) -> None:
    """Refuse to retry a multipart upload whose stream cannot be replayed.

    httpx rewinds seekable file parts itself -- ``_multipart.py`` seeks each
    file to 0 before rendering, on every attempt -- so a retried upload of a
    ``Path``, ``bytes`` or any seekable handle already re-sends the whole body
    and needs no help here.

    A stream that reports ``seekable() is False`` is the case httpx cannot
    save: it swallows the ``UnsupportedOperation`` and reads from an exhausted
    stream, so attempt two uploads zero bytes and the server accepts an empty
    document. Failing loudly is the only honest option, because the caller
    cannot detect the truncation from the response.
    """
    for _, (_, payload, _) in files:
        if isinstance(payload, (bytes, bytearray)):
            continue
        seekable = getattr(payload, "seekable", None)
        if seekable is not None and not seekable():
            raise XbergError(
                "cannot retry this request: an uploaded file stream is not seekable "
                "(pass a pathlib.Path, bytes, or a seekable file handle to allow retries)",
                status_code=None,
            )


def _multipart_data(options: OptionsInput, webhook: Mapping[str, Any] | None) -> dict[str, str]:
    """Build the ``data=`` argument carrying serialized options and webhook config as JSON parts.

    ``webhook`` is optional on the wire -- omit the part entirely rather than
    sending a placeholder ``{"url": ""}`` when the caller supplied none.
    """
    data: dict[str, str] = {}
    if webhook is not None:
        data["webhook"] = json.dumps(dict(webhook))
    coerced = _coerce_options(options)
    if coerced is not None:
        data["options"] = json.dumps(coerced)
    return data


def _coerce_file_config(config: FileConfigInput) -> dict[str, Any] | None:
    """Normalize a :class:`FileExtractionConfig`/dict/``None`` into a plain dict (or ``None``)."""
    if config is None:
        return None
    if isinstance(config, FileExtractionConfig):
        return config.to_dict()
    return dict(config)


def _per_file_config_data(
    file_parts: Sequence[tuple[str, tuple[str, bytes | BinaryIO, str]]],
    configs: Sequence[FileConfigInput] | None,
) -> dict[str, str]:
    """Build the ``config-<filename>`` parts carrying per-file extraction overrides.

    The multipart form keys a per-file override on the *filename*, mirroring the
    existing ``document_id-<filename>`` convention. That means two copies of the
    same filename in one batch cannot carry different overrides -- the wire has
    exactly one slot for that name. Rather than send whichever config happened to
    be written last and silently drop the other, that case raises here. Callers
    who need the same document extracted twice under different instructions give
    the copies distinct filenames.

    Precedence between this override and ``options.extraction_config`` is the
    server's; nothing is merged, validated or reordered client-side.
    """
    if configs is None:
        return {}
    coerced = [_coerce_file_config(config) for config in configs]
    if len(coerced) != len(file_parts):
        raise XbergError(
            f"configs has {len(coerced)} entries but {len(file_parts)} files were supplied; "
            "pass exactly one entry per file (None for no override)",
            status_code=None,
        )
    data: dict[str, str] = {}
    seen: dict[str, dict[str, Any] | None] = {}
    for (_, (filename, _, _)), config in zip(file_parts, coerced, strict=True):
        if filename in seen and seen[filename] != config:
            raise XbergError(
                f"per-file config conflict for {filename!r}: the same filename appears more than "
                "once in this batch with different configs, but a multipart request carries at "
                "most one config part per filename. Give the copies distinct filenames.",
                status_code=None,
            )
        seen[filename] = config
        if config is not None:
            data[f"config-{filename}"] = json.dumps(config)
    return data


def _saved_presets_path(tier: str, preset_id: str | None = None) -> str:
    """Render the saved-preset route for ``tier`` — Pro hyphenates the collection, Enterprise underscores it."""
    base = _SAVED_PRESETS_PATH_PRO if tier == "pro" else _SAVED_PRESETS_PATH_ENTERPRISE
    return base if preset_id is None else f"{base}/{_q(preset_id)}"


def _job_ids_from_extract_response(payload: Any) -> list[str]:
    """Pluck the ``job_ids`` list out of a ``POST /v1/extract`` response body."""
    if not isinstance(payload, dict):
        raise XbergError(f"unexpected extract response shape: {payload!r}", status_code=None)
    job_ids = payload.get("job_ids")
    if not isinstance(job_ids, list) or not job_ids:
        raise XbergError(f"extract response missing job_ids: {payload!r}", status_code=None)
    return [str(job_id) for job_id in job_ids]


def _coerce_body(body: BodyInput) -> dict[str, Any]:
    """Normalize a generated request model or plain mapping into a JSON-ready dict."""
    if isinstance(body, Mapping):
        return dict(body)
    return body.to_dict()


def _auto_tune_multipart_data(request: BodyInput) -> dict[str, str]:
    """Build the ``data=`` argument carrying the JSON-encoded ``request`` part of a submit-auto-tune call."""
    return {"request": json.dumps(_coerce_body(request))}


def _expect_object(payload: Any, what: str) -> Mapping[str, Any]:
    """Assert a decoded response body is a JSON object before handing it to a model parser.

    Raises :class:`XbergError`, not ``ValueError``: a server that answers with
    the wrong shape is an SDK-level failure, and a caller wrapping a call in
    ``except XbergError`` should not have to also catch a bare built-in to
    cover it. The TypeScript client raises its base error here too.
    """
    if not isinstance(payload, Mapping):
        raise XbergError(f"unexpected {what} response shape: {payload!r}", status_code=None)
    return payload


def _parse_enrich_status(payload: Any) -> EnrichJobStatus:
    """Parse a ``GET /v1/enrich/{job_id}`` body into the generated variant its ``status`` names."""
    body = _expect_object(payload, "enrich status")
    model = _ENRICH_STATUS_MODELS.get(str(body.get("status", "")))
    if model is None:
        raise XbergError(f"unexpected enrich status response shape: {payload!r}", status_code=None)
    return model.from_dict(body)


class _SSEDecoder:
    """Incremental decoder for a ``text/event-stream`` body, fed response byte chunks.

    Implements the parts of the WHATWG event-stream parser this endpoint can
    exercise. A frame is terminated by a blank line, not by a newline: its
    payload is every ``data:`` field it carried, joined with newlines. Lines
    opening with ``:`` are comments -- the endpoint's 15s heartbeat is one --
    and ``event:``/``id:``/``retry:`` fields are accepted and ignored. A single
    space after a field's colon is framing, not value, so it is stripped.

    All of which is why this exists instead of ``json.loads(line)`` per line:
    against a server that happens to emit one compact frame per line the naive
    version passes every test, then silently drops every multi-line payload and
    raises on the first heartbeat comment against a real one.

    A stream that ends mid-frame -- no terminating blank line -- discards it,
    as the spec requires; the payload is by definition incomplete.
    """

    def __init__(self) -> None:
        self._data: list[str] = []
        self._size = 0
        self._line = bytearray()
        self._after_cr = False

    def feed_bytes(self, chunk: bytes) -> Iterator[str]:
        """Split only SSE line endings, bounding pending bytes before copying them."""
        start = int(self._after_cr and chunk.startswith(b"\n"))
        if not chunk:
            return
        self._after_cr = False
        for ending in _SSE_LINE_END.finditer(chunk, start):
            self._append_line(chunk, start, ending.start())
            line = self._line.decode("utf-8", errors="replace")
            self._line.clear()
            payload = self.feed(line)
            start = ending.end()
            self._after_cr = ending.group() == b"\r" and start == len(chunk)
            if payload is not None:
                yield payload
        self._append_line(chunk, start, len(chunk))

    def _append_line(self, chunk: bytes, start: int, end: int) -> None:
        if len(self._line) + end - start > _MAX_SSE_FRAME_BYTES:
            raise XbergError(
                f"crawl event line exceeded {_MAX_SSE_FRAME_BYTES} bytes before the stream closed it",
                status_code=None,
            )
        self._line.extend(memoryview(chunk)[start:end])

    def feed(self, line: str) -> str | None:
        """Consume one terminator-stripped line, returning a payload if it completed a frame."""
        if not line:
            return self._dispatch()
        if line.startswith(_SSE_COMMENT_PREFIX):
            return None
        field, separator, value = line.partition(":")
        if separator and value.startswith(" "):
            value = value[1:]
        if field == _SSE_DATA_FIELD:
            self._size += len(value.encode("utf-8")) + 1  # +1 for the newline _dispatch joins with
            if self._size > _MAX_SSE_FRAME_BYTES:
                raise XbergError(
                    f"crawl event frame exceeded {_MAX_SSE_FRAME_BYTES} bytes before the stream closed it",
                    status_code=None,
                )
            self._data.append(value)
        return None

    def _dispatch(self) -> str | None:
        """Emit the buffered ``data`` payload, or ``None`` when the blank line closed nothing."""
        if not self._data:
            return None
        payload = "\n".join(self._data)
        self._data.clear()
        self._size = 0
        return payload


def _parse_crawl_event(payload: str) -> CrawlEvent:
    """Parse one SSE frame payload into the ``kind``-discriminated variant it names."""
    try:
        body = json.loads(payload)
    except json.JSONDecodeError as exc:
        raise XbergError(f"crawl event stream sent a non-JSON frame: {payload!r}", status_code=None) from exc
    document = _expect_object(body, "crawl event")
    model = _CRAWL_EVENT_MODELS.get(str(document.get("kind", "")))
    if model is None:
        raise XbergError(f"unexpected crawl event kind: {document.get('kind')!r}", status_code=None)
    return model.from_dict(document)


def _parse_job(payload: Any) -> JobResponse:
    """Parse a ``GET /v1/jobs/{id}`` response body into a typed :class:`JobResponse`."""
    if not isinstance(payload, dict):
        raise XbergError(f"unexpected job response shape: {payload!r}", status_code=None)
    return JobResponse.from_dict(payload)


def _parse_job_result(payload: Any) -> JobResult:
    """Parse a ``GET /v1/jobs/{id}/result`` response body into a typed :class:`JobResult`."""
    return JobResult.from_dict(_expect_object(payload, "job result"))


def _parse_presets(payload: Any) -> list[PresetSummary]:
    """Parse a ``GET /v1/presets`` response body into a list of :class:`PresetSummary`."""
    if not isinstance(payload, list):
        raise XbergError(f"unexpected preset list response shape: {payload!r}", status_code=None)
    return [PresetSummary.from_dict(_expect_object(item, "preset summary")) for item in payload]


def _query_params(**candidates: Any) -> dict[str, Any] | None:
    """Drop the ``None`` entries from a query-parameter mapping, returning ``None`` when nothing is left."""
    params = {key: value for key, value in candidates.items() if value is not None}
    return params or None


def _pagination(limit: int | None, offset: int | None) -> dict[str, Any] | None:
    """Build the shared ``limit``/``offset`` query parameters for the paginated list endpoints."""
    return _query_params(limit=limit, offset=offset)


def _job_failure_detail(job: JobResponse) -> str | None:
    """Best-effort extraction of a human-readable error detail from a terminal-failed job."""
    data = job.to_dict()
    if isinstance(data, dict):
        for key in ("error", "detail", "message"):
            value = data.get(key)
            if isinstance(value, str) and value:
                return value
    return None


def _raise_if_failed(job: JobResponse) -> None:
    """Raise :class:`XbergError` when ``job`` reached a ``failed``/``cancelled`` terminal state."""
    if job.status in _FAILED_STATUSES:
        detail = _job_failure_detail(job)
        suffix = f": {detail}" if detail else ""
        raise XbergError(
            f"job {job.id} ended with status '{job.status}'{suffix}",
            status_code=None,
            payload=job.to_dict(),
        )


def _next_interval(current: float, backoff: BackoffStrategy) -> float:
    """Advance the polling/backoff interval according to the configured strategy."""
    if backoff == "constant":
        return current
    return min(current * _BACKOFF_FACTOR, _MAX_BACKOFF_INTERVAL)


def _resolve_base_url(base_url: str | None, target: Target | None) -> str:
    """Resolve the effective base URL, enforcing that Pro requires an explicit one."""
    if base_url is not None:
        return base_url.rstrip("/")
    if target == "pro":
        raise XbergError(
            "Xberg Pro has no default base_url (its spec ships no servers block); "
            "pass base_url=... pointing at your Pro instance.",
            status_code=None,
        )
    return DEFAULT_ENTERPRISE_BASE_URL


def _resolve_control_plane_base_url(control_plane_base_url: str | None, base_url: str) -> str:
    """Resolve the base URL of the Enterprise control plane, defaulting to the data plane's.

    Enterprise runs the control plane (projects, API keys, integrations, RAG
    config, members, invitations, managed webhooks, usage, analytics, billing)
    as a second binary on its own origin; Pro serves it from the same one. The
    default therefore has to be ``base_url``, exactly as the console's
    ``NEXT_PUBLIC_BACKEND_API_URL`` is same-origin unless set — anything else
    would break every Pro control-plane call the moment this argument existed.
    """
    if control_plane_base_url is not None:
        return control_plane_base_url.rstrip("/")
    return base_url


_KNOWN_TIERS: frozenset[str] = frozenset({"enterprise", "pro"})


def _parse_probed_tier(body: Any) -> str:
    """Extract and validate the ``tier`` field of a ``GET /healthz`` response body.

    Raises :class:`XbergError` for a missing, null, or unrecognized tier rather
    than returning a sentinel -- callers must never cache the result of a
    failed probe, or an instance that answers ``/healthz`` without a tier
    would poison every tier-gated method for the client's lifetime.
    """
    tier = body.get("tier") if isinstance(body, Mapping) else None
    if not isinstance(tier, str) or tier not in _KNOWN_TIERS:
        raise XbergError(
            f"/healthz returned an unrecognized tier {tier!r} (expected one of {sorted(_KNOWN_TIERS)})",
            status_code=None,
            payload=body if isinstance(body, Mapping) else None,
        )
    return tier


class _BaseClient:
    """Shared configuration and tier-gating state for the sync and async clients."""

    def __init__(
        self,
        *,
        api_key: str | None = None,
        base_url: str | None = None,
        control_plane_base_url: str | None = None,
        control_plane_token: str | None = None,
        target: Target | None = None,
        timeout: float = DEFAULT_TIMEOUT_SECONDS,
        headers: Mapping[str, str] | None = None,
        retries: int = _DEFAULT_RETRIES,
        retry_on: Iterable[int] | None = None,
        retry_backoff: BackoffStrategy = "exponential",
    ) -> None:
        self._control_plane_token = control_plane_token if control_plane_token is not None else api_key
        self._api_key = api_key
        self._target: Target | None = target
        self._base_url = _resolve_base_url(base_url, target)
        self._control_plane_base_url = _resolve_control_plane_base_url(control_plane_base_url, self._base_url)
        # ~keep Readable, unlike the other constructor arguments, because a
        # ~keep two-origin client is the one case where "which host will this
        # ~keep actually call?" is not answerable from the constructor call: the
        # ~keep control plane silently defaults to `base_url`. Go exposes it as
        # ~keep `ControlPlaneBaseURL()` and TypeScript as a public field, so all
        # ~keep three read it back the same way.
        self._timeout = timeout
        self._retries = retries
        self._retry_on: frozenset[int] = frozenset(retry_on) if retry_on is not None else _DEFAULT_RETRY_STATUSES
        self._retry_backoff: BackoffStrategy = retry_backoff
        self._probed_tier: str | None = None
        self._headers = httpx.Headers({"User-Agent": _user_agent()})
        if headers:
            self._headers.update(headers)
        if api_key is not None:
            self._headers["Authorization"] = f"Bearer {api_key}"

    def _require_tier_or_raise(self, tier: str, required: Target, method_name: str) -> None:
        if tier != required:
            actual = tier or "unknown"
            raise XbergError(
                f"{method_name}() is not available on the '{actual}' tier (requires the '{required}' tier)",
                status_code=None,
            )

    @property
    def control_plane_base_url(self) -> str:
        """Origin the control-plane surface will be addressed at.

        The same as the data-plane base URL unless ``control_plane_base_url``
        was passed: Enterprise runs the control plane as a second binary on its
        own origin, while Pro serves both planes from one.

        """
        return self._control_plane_base_url


class XbergClient(_BaseClient):
    """Synchronous client for Xberg Enterprise and Xberg Pro.

    >>> with XbergClient(api_key="kz_...") as client:  # doctest: +SKIP
    ...     job = client.extract(file=Path("invoice.pdf"))
    ...     result = client.wait_for_job(str(job.id))
    """

    def __init__(
        self,
        *,
        api_key: str | None = None,
        base_url: str | None = None,
        control_plane_base_url: str | None = None,
        control_plane_token: str | None = None,
        target: Target | None = None,
        timeout: float = DEFAULT_TIMEOUT_SECONDS,
        headers: Mapping[str, str] | None = None,
        retries: int = _DEFAULT_RETRIES,
        retry_on: Iterable[int] | None = None,
        retry_backoff: BackoffStrategy = "exponential",
    ) -> None:
        super().__init__(
            api_key=api_key,
            base_url=base_url,
            control_plane_base_url=control_plane_base_url,
            control_plane_token=control_plane_token,
            target=target,
            timeout=timeout,
            headers=headers,
            retries=retries,
            retry_on=retry_on,
            retry_backoff=retry_backoff,
        )
        self._http = httpx.Client(base_url=self._base_url, timeout=self._timeout, headers=self._headers)
        self._tier_lock = threading.Lock()

    def __enter__(self) -> Self:
        """Enter the context manager."""
        return self

    def __exit__(
        self,
        exc_type: type[BaseException] | None,
        exc_val: BaseException | None,
        exc_tb: TracebackType | None,
    ) -> None:
        """Exit the context manager and close the underlying HTTP transport."""
        self.close()

    def close(self) -> None:
        """Close the underlying HTTP transport, releasing connections."""
        self._http.close()

    def _request(
        self,
        method: str,
        path: str,
        *,
        files: Any | None = None,
        data: Any | None = None,
        json_body: Any | None = None,
        params: Mapping[str, Any] | None = None,
        control_plane: bool = False,
        public: bool = False,
        token: str | None = None,
    ) -> httpx.Response:
        """Issue one HTTP request with the configured retry engine, returning the raw response."""
        attempt = 0
        interval = _RETRY_BACKOFF_BASE
        if files and self._retries > 0:
            _reject_unretryable_files(files)
        while True:
            try:
                if control_plane:
                    request = self._http.build_request(
                        method,
                        self._control_plane_base_url + path,
                        files=files,
                        data=data,
                        json=json_body,
                        params=params,
                    )
                    request.headers.pop("Authorization", None)
                    credential = token if public else self._control_plane_token
                    if credential is not None:
                        request.headers["Authorization"] = f"Bearer {credential}"
                    response = self._http.send(request, follow_redirects=False)
                else:
                    response = self._http.request(method, path, files=files, data=data, json=json_body, params=params)
            except httpx.TransportError as exc:
                if attempt < self._retries:
                    attempt += 1
                    time.sleep(interval)
                    interval = _next_interval(interval, self._retry_backoff)
                    continue
                raise XbergError(f"network error contacting {path}", status_code=None) from exc
            if response.is_success:
                return response
            if response.status_code in self._retry_on and attempt < self._retries:
                attempt += 1
                retry_after = parse_retry_after(response.headers.get("Retry-After"))
                time.sleep(retry_after if retry_after is not None else interval)
                interval = _next_interval(interval, self._retry_backoff)
                continue
            return response

    def _request_json(
        self,
        method: str,
        path: str,
        *,
        files: Any | None = None,
        data: Any | None = None,
        json_body: Any | None = None,
        params: Mapping[str, Any] | None = None,
    ) -> Any:
        """Issue a request, raise on non-2xx, and decode the JSON body (``None`` for empty bodies)."""
        response = self._request(method, path, files=files, data=data, json_body=json_body, params=params)
        raise_for_status(response)
        if response.status_code == 204 or not response.content:
            return None
        return response.json()

    def _request_bytes(self, method: str, path: str, *, params: Mapping[str, Any] | None = None) -> bytes:
        """Issue a request, raise on non-2xx, and return the raw (non-JSON) response body."""
        response = self._request(method, path, params=params)
        raise_for_status(response)
        return response.content

    @contextmanager
    def _request_stream(self, method: str, path: str, *, accept: str) -> Iterator[httpx.Response]:
        """Open a streaming response, closing it on every exit path.

        Deliberately not routed through :meth:`_request`. That method is the
        retry engine, and retrying a partially-consumed stream replays every
        event the caller already handled -- from the client's side an
        indistinguishable duplicate, from the server's a second subscription.
        No ``Retry-After`` makes that safe, so the stream simply opts out.

        The read timeout is lifted for a related reason: ``timeout`` bounds a
        request/response round trip, while a subscription is idle between
        events by design. Connect, write and pool timeouts still apply.
        """
        timeout = httpx.Timeout(self._timeout, read=None)
        with self._http.stream(method, path, headers={"Accept": accept}, timeout=timeout) as response:
            if not response.is_success:
                response.read()
                raise_for_status(response)
            yield response

    def _resolve_tier(self) -> str:
        """Return the effective tier — an explicit ``target`` if set, else probed from ``/healthz``.

        ``_tier_lock`` makes the probe single-flight: concurrent callers share
        one in-flight ``GET /healthz`` instead of each issuing their own. The
        lock is dedicated to tier resolution, so it never serializes unrelated
        requests. A failed probe (see :func:`_parse_probed_tier`) is never
        cached, so a later call can retry instead of being stuck with a bad
        result for the client's lifetime.
        """
        if self._target is not None:
            return self._target
        with self._tier_lock:
            if self._probed_tier is None:
                self._probed_tier = _parse_probed_tier(self._request_json("GET", "/healthz"))
            return self._probed_tier

    def _require_tier(self, required: Target, method_name: str) -> None:
        self._require_tier_or_raise(self._resolve_tier(), required, method_name)

    # -- Shared surface (Enterprise + Pro) ---------------------------------

    def extract(
        self,
        *,
        file: FileInput,
        options: OptionsInput = None,
        webhook: Mapping[str, Any] | None = None,
        config: FileConfigInput = None,
    ) -> JobResponse:
        """Submit a single document for extraction via ``POST /v1/extract`` (multipart).

        ``config`` is a per-file :class:`FileExtractionConfig` override sent as the
        ``config-<filename>`` part. The server resolves it against
        ``options.extraction_config``, any preset and the project default.
        """
        return self.extract_batch(
            [file],
            options=options,
            webhook=webhook,
            configs=None if config is None else [config],
        )[0]

    def extract_batch(
        self,
        files: Iterable[FileInput],
        options: OptionsInput = None,
        webhook: Mapping[str, Any] | None = None,
        configs: Sequence[FileConfigInput] | None = None,
    ) -> list[JobResponse]:
        """Submit multiple documents in a SINGLE multipart request carrying every file.

        ``configs``, when given, holds one per-file override per entry of ``files``
        in the same order (``None`` for no override) and must be the same length.
        """
        materialized = list(files)
        if not materialized:
            raise XbergError("extract_batch called with no files", status_code=None)
        file_parts = _multipart_files(materialized)
        data = _multipart_data(options, webhook)
        data.update(_per_file_config_data(file_parts, configs))
        payload = self._request_json("POST", "/v1/extract", files=file_parts, data=data)
        job_ids = _job_ids_from_extract_response(payload)
        return [self.get_job(job_id) for job_id in job_ids]

    def get_job(self, job_id: str) -> JobResponse:
        """Fetch a job's current status and (when terminal) its extraction result."""
        return _parse_job(self._request_json("GET", f"/v1/jobs/{_q(job_id)}"))

    def get_job_result(self, job_id: str) -> JobResult:
        """Fetch a job's stored result envelope (``GET /v1/jobs/{id}/result``).

        Served identically by both tiers. Answers 409 until the job reaches a terminal
        successful status (``completed`` or ``partial_success``), and 404 once the stored
        result has passed its retention window.
        """
        return _parse_job_result(self._request_json("GET", f"/v1/jobs/{_q(job_id)}/result"))

    def list_jobs(self, *, limit: int | None = None, offset: int | None = None) -> Any:
        """List jobs via ``GET /v1/jobs`` (paginated). Returns the decoded response body."""
        params = {k: v for k, v in (("limit", limit), ("offset", offset)) if v is not None}
        return self._request_json("GET", "/v1/jobs", params=params or None)

    def cancel_job(self, job_id: str) -> None:
        """Cancel an extraction job (``DELETE /v1/jobs/{id}``, 204 whether pending or already terminal)."""
        self._request_json("DELETE", f"/v1/jobs/{_q(job_id)}")

    def wait_for_job(
        self,
        job_id: str,
        *,
        timeout: float = _DEFAULT_WAIT_TIMEOUT,
        poll_interval: float = _DEFAULT_POLL_INTERVAL,
        backoff: BackoffStrategy = "exponential",
    ) -> JobResponse:
        """Poll ``GET /v1/jobs/{id}`` until the job reaches a terminal status or ``timeout`` elapses.

        Raises :class:`xberg_io_sdk.errors.TimeoutError` if the deadline is hit first, and
        :class:`xberg_io_sdk.errors.XbergError` if the job ends ``failed``/``cancelled``.
        """
        deadline = time.monotonic() + timeout
        interval = poll_interval
        while True:
            job = self.get_job(job_id)
            if job.status in _TERMINAL_STATUSES:
                _raise_if_failed(job)
                return job
            now = time.monotonic()
            if now >= deadline:
                raise ClientTimeoutError(
                    f"job {job_id} did not reach a terminal status within {timeout}s",
                    status_code=None,
                )
            time.sleep(min(interval, deadline - now))
            interval = _next_interval(interval, backoff)

    def wait_for_jobs(
        self,
        job_ids: Iterable[str],
        *,
        timeout: float = _DEFAULT_WAIT_TIMEOUT,
        poll_interval: float = _DEFAULT_POLL_INTERVAL,
        backoff: BackoffStrategy = "exponential",
    ) -> list[JobResponse]:
        """Wait for multiple jobs sequentially (sync)."""
        return [
            self.wait_for_job(job_id, timeout=timeout, poll_interval=poll_interval, backoff=backoff)
            for job_id in job_ids
        ]

    def extract_and_wait(
        self,
        *,
        file: FileInput,
        options: OptionsInput = None,
        webhook: Mapping[str, Any] | None = None,
        config: FileConfigInput = None,
        timeout: float = _DEFAULT_WAIT_TIMEOUT,
        poll_interval: float = _DEFAULT_POLL_INTERVAL,
        backoff: BackoffStrategy = "exponential",
    ) -> JobResponse:
        """Submit a document and block until extraction completes (raises on failure/timeout)."""
        job = self.extract(file=file, options=options, webhook=webhook, config=config)
        return self.wait_for_job(str(job.id), timeout=timeout, poll_interval=poll_interval, backoff=backoff)

    def audit(self, *, action: str | None = None, limit: int | None = None, offset: int | None = None) -> Any:
        """Fetch audit-log entries via ``GET /v1/audit``. Returns the decoded response body."""
        params = {k: v for k, v in (("action", action), ("limit", limit), ("offset", offset)) if v is not None}
        return self._request_json("GET", "/v1/audit", params=params or None)

    def list_rag_collections(self) -> Any:
        """List RAG collections (``GET /v1/rag/collections``)."""
        return self._request_json("GET", "/v1/rag/collections")

    def create_rag_collection(self, body: Mapping[str, Any]) -> Any:
        """Create a RAG collection (``POST /v1/rag/collections``)."""
        return self._request_json("POST", "/v1/rag/collections", json_body=body)

    def get_rag_collection(self, name: str) -> Any:
        """Fetch a RAG collection (``GET /v1/rag/collections/{name}``)."""
        return self._request_json("GET", f"/v1/rag/collections/{_q(name)}")

    def delete_rag_collection(self, name: str) -> None:
        """Delete a RAG collection (``DELETE /v1/rag/collections/{name}``, 204)."""
        self._request_json("DELETE", f"/v1/rag/collections/{_q(name)}")

    def add_rag_documents(self, name: str, body: Mapping[str, Any]) -> Any:
        """Add documents to a RAG collection (``POST /v1/rag/collections/{name}/documents``)."""
        return self._request_json("POST", f"/v1/rag/collections/{_q(name)}/documents", json_body=body)

    def delete_rag_documents(self, name: str, body: Mapping[str, Any]) -> Any:
        """Delete documents from a RAG collection by ID or filter (``DELETE .../documents``).

        Returns the decoded ``{"deleted_count": ...}`` response body.
        """
        return self._request_json("DELETE", f"/v1/rag/collections/{_q(name)}/documents", json_body=body)

    def reindex_rag_document(self, name: str, document_id: str, body: Mapping[str, Any] | None = None) -> Any:
        """Reindex a RAG document (``POST /v1/rag/collections/{name}/documents/{id}/reindex``)."""
        return self._request_json(
            "POST", f"/v1/rag/collections/{_q(name)}/documents/{_q(document_id)}/reindex", json_body=body
        )

    def rag_retrieve(self, name: str, body: Mapping[str, Any]) -> Any:
        """Retrieve chunks from a RAG collection (``POST /v1/rag/collections/{name}/retrieve``)."""
        return self._request_json("POST", f"/v1/rag/collections/{_q(name)}/retrieve", json_body=body)

    def migrate_rag_embeddings(self, name: str, body: Mapping[str, Any]) -> Any:
        """Kick off an embedding migration (``POST /v1/rag/collections/{name}/migrate-embeddings``)."""
        return self._request_json("POST", f"/v1/rag/collections/{_q(name)}/migrate-embeddings", json_body=body)

    def get_rag_migration_job(self, name: str, job_id: str) -> Any:
        """Poll an embedding-migration job (``GET .../migrate-embeddings/{job_id}``)."""
        return self._request_json("GET", f"/v1/rag/collections/{_q(name)}/migrate-embeddings/{_q(job_id)}")

    def get_rag_job(self, job_id: str) -> Any:
        """Fetch a RAG job's status (``GET /v1/rag/jobs/{job_id}``)."""
        return self._request_json("GET", f"/v1/rag/jobs/{_q(job_id)}")

    def presets(self) -> list[PresetSummary]:
        """List the curated, read-only managed presets (``GET /v1/presets``)."""
        return _parse_presets(self._request_json("GET", "/v1/presets"))

    def get_preset(self, preset_id: str) -> PresetDetail:
        """Fetch one managed preset in full (``GET /v1/presets/{id}``)."""
        return PresetDetail.from_dict(
            _expect_object(self._request_json("GET", f"/v1/presets/{_q(preset_id)}"), "preset")
        )

    def get_preset_sample(self, preset_id: str, name: str) -> bytes:
        """Fetch a preset's bundled sample document (``GET /v1/presets/{id}/sample/{name}``, raw bytes)."""
        return self._request_bytes("GET", f"/v1/presets/{_q(preset_id)}/sample/{_q(name)}")

    def list_saved_presets(
        self,
        *,
        limit: int | None = None,
        offset: int | None = None,
    ) -> ListSavedPresetsResponse:
        """List the project's saved presets (``GET /v1/saved_presets``; Pro spells it ``/v1/saved-presets``)."""
        path = _saved_presets_path(self._resolve_tier())
        payload = self._request_json("GET", path, params=_pagination(limit, offset))
        return ListSavedPresetsResponse.from_dict(_expect_object(payload, "saved preset list"))

    def create_saved_preset(self, body: CreateSavedPresetRequest | Mapping[str, Any]) -> CreateSavedPresetResponse:
        """Create a saved preset (``POST /v1/saved_presets``; Pro spells it ``/v1/saved-presets``)."""
        path = _saved_presets_path(self._resolve_tier())
        payload = self._request_json("POST", path, json_body=_coerce_body(body))
        return CreateSavedPresetResponse.from_dict(_expect_object(payload, "saved preset"))

    def get_saved_preset(self, preset_id: str) -> SavedPresetDetail:
        """Fetch one saved preset in full (``GET /v1/saved_presets/{preset_id}``)."""
        path = _saved_presets_path(self._resolve_tier(), preset_id)
        return SavedPresetDetail.from_dict(_expect_object(self._request_json("GET", path), "saved preset"))

    def update_saved_preset(
        self,
        preset_id: str,
        body: UpdateSavedPresetRequest | Mapping[str, Any],
    ) -> UpdateSavedPresetResponse:
        """Replace a saved preset's definition (``PATCH /v1/saved_presets/{preset_id}``)."""
        path = _saved_presets_path(self._resolve_tier(), preset_id)
        payload = self._request_json("PATCH", path, json_body=_coerce_body(body))
        return UpdateSavedPresetResponse.from_dict(_expect_object(payload, "saved preset"))

    def delete_saved_preset(self, preset_id: str) -> None:
        """Delete a saved preset (``DELETE /v1/saved_presets/{preset_id}``, 204)."""
        self._request_json("DELETE", _saved_presets_path(self._resolve_tier(), preset_id))

    def list_auto_tune_jobs(self, *, limit: int | None = None, offset: int | None = None) -> ListAutoTuneJobsResponse:
        """List auto-tune jobs (``GET /v1/auto-tune``, paginated)."""
        payload = self._request_json("GET", _AUTO_TUNE_PATH, params=_pagination(limit, offset))
        return ListAutoTuneJobsResponse.from_dict(_expect_object(payload, "auto-tune job list"))

    def submit_auto_tune(
        self,
        request: CreateAutoTuneJobRequest | Mapping[str, Any],
        files: Iterable[FileInput],
    ) -> CreateAutoTuneJobResponse:
        """Submit an auto-tune job (``POST /v1/auto-tune``: a JSON ``request`` part plus one ``file`` part each)."""
        materialized = list(files)
        if not materialized:
            raise XbergError("submit_auto_tune called with no files", status_code=None)
        payload = self._request_json(
            "POST",
            _AUTO_TUNE_PATH,
            files=_multipart_files(materialized),
            data=_auto_tune_multipart_data(request),
        )
        return CreateAutoTuneJobResponse.from_dict(_expect_object(payload, "auto-tune job"))

    def get_auto_tune_capabilities(self) -> AutoTuneCapabilitiesResponse:
        """Fetch the tunable knobs and OCR backends this instance offers (``GET /v1/auto-tune/capabilities``)."""
        payload = self._request_json("GET", f"{_AUTO_TUNE_PATH}/capabilities")
        return AutoTuneCapabilitiesResponse.from_dict(_expect_object(payload, "auto-tune capabilities"))

    def get_auto_tune_status(self, auto_tune_job_id: str) -> AutoTuneJobStatus:
        """Fetch an auto-tune job's progress (``GET /v1/auto-tune/{id}``)."""
        payload = self._request_json("GET", f"{_AUTO_TUNE_PATH}/{_q(auto_tune_job_id)}")
        return AutoTuneJobStatus.from_dict(_expect_object(payload, "auto-tune status"))

    def delete_auto_tune_job(self, auto_tune_job_id: str) -> None:
        """Delete an auto-tune job and its artifacts (``DELETE /v1/auto-tune/{id}``, 204)."""
        self._request_json("DELETE", f"{_AUTO_TUNE_PATH}/{_q(auto_tune_job_id)}")

    def promote_auto_tune_profile(
        self,
        auto_tune_job_id: str,
        body: PromoteProfileRequest | Mapping[str, Any],
    ) -> TuningProfileDetail:
        """Promote an auto-tune result to a named tuning profile (``POST /v1/auto-tune/{id}/promote``)."""
        payload = self._request_json(
            "POST", f"{_AUTO_TUNE_PATH}/{_q(auto_tune_job_id)}/promote", json_body=_coerce_body(body)
        )
        return TuningProfileDetail.from_dict(_expect_object(payload, "tuning profile"))

    def get_auto_tune_result(self, auto_tune_job_id: str) -> AutoTuneResult:
        """Fetch a finished auto-tune job's leaderboard and winning profile (``GET /v1/auto-tune/{id}/result``)."""
        payload = self._request_json("GET", f"{_AUTO_TUNE_PATH}/{_q(auto_tune_job_id)}/result")
        return AutoTuneResult.from_dict(_expect_object(payload, "auto-tune result"))

    def list_tuning_profiles(
        self, *, limit: int | None = None, offset: int | None = None
    ) -> ListTuningProfilesResponse:
        """List the promoted tuning profiles (``GET /v1/tuning-profiles``, paginated)."""
        payload = self._request_json("GET", _TUNING_PROFILES_PATH, params=_pagination(limit, offset))
        return ListTuningProfilesResponse.from_dict(_expect_object(payload, "tuning profile list"))

    def get_tuning_profile(self, profile_id: str) -> TuningProfileDetail:
        """Fetch one tuning profile in full (``GET /v1/tuning-profiles/{id}``)."""
        payload = self._request_json("GET", f"{_TUNING_PROFILES_PATH}/{_q(profile_id)}")
        return TuningProfileDetail.from_dict(_expect_object(payload, "tuning profile"))

    def delete_tuning_profile(self, profile_id: str) -> None:
        """Delete a tuning profile (``DELETE /v1/tuning-profiles/{id}``, 204)."""
        self._request_json("DELETE", f"{_TUNING_PROFILES_PATH}/{_q(profile_id)}")

    # -- Pro-only surface --------------------------------------------------

    def auth_config(self) -> Any:
        """Pro only: fetch the instance's accepted auth methods (unauthenticated ``GET /auth/config``)."""
        self._require_tier("pro", "auth_config")
        return self._request_json("GET", "/auth/config")

    def login(self, body: Mapping[str, Any]) -> Any:
        """Pro only: exchange a verified OIDC ID token for a Pro session JWT (``POST /auth/login``)."""
        self._require_tier("pro", "login")
        return self._request_json("POST", "/auth/login", json_body=body)

    def get_rag_config(self, project_id: str) -> Any:
        """Pro only: fetch a project's RAG config (``GET /v1/projects/{project_id}/rag-config``)."""
        self._require_tier("pro", "get_rag_config")
        return self._request_json("GET", f"/v1/projects/{_q(project_id)}/rag-config")

    def set_rag_config(self, project_id: str, body: Mapping[str, Any]) -> Any:
        """Pro only: update a project's RAG config (``PUT /v1/projects/{project_id}/rag-config``)."""
        self._require_tier("pro", "set_rag_config")
        return self._request_json("PUT", f"/v1/projects/{_q(project_id)}/rag-config", json_body=body)

    # -- Pro-only control plane (projects, API keys, integrations) ---------

    def list_projects(self, *, limit: int | None = None, offset: int | None = None) -> ListProjectsResponse:
        """Pro only: list the caller's projects (``GET /v1/projects``, paginated)."""
        self._require_tier("pro", "list_projects")
        payload = self._request_json("GET", "/v1/projects", params=_pagination(limit, offset))
        return ListProjectsResponse.from_dict(_expect_object(payload, "project list"))

    def create_project(self, body: CreateProjectRequest | Mapping[str, Any]) -> ProjectResponse:
        """Pro only: create a project (``POST /v1/projects``)."""
        self._require_tier("pro", "create_project")
        payload = self._request_json("POST", "/v1/projects", json_body=_coerce_body(body))
        return ProjectResponse.from_dict(_expect_object(payload, "project"))

    def list_api_keys(
        self,
        project_id: str,
        *,
        limit: int | None = None,
        offset: int | None = None,
    ) -> ListApiKeysResponse:
        """Pro only: list a project's API keys (``GET /v1/projects/{project_id}/api-keys``)."""
        self._require_tier("pro", "list_api_keys")
        payload = self._request_json(
            "GET", f"/v1/projects/{_q(project_id)}/api-keys", params=_pagination(limit, offset)
        )
        return ListApiKeysResponse.from_dict(_expect_object(payload, "API key list"))

    def create_api_key(
        self,
        project_id: str,
        body: CreateApiKeyRequest | Mapping[str, Any],
    ) -> CreateApiKeyResponse:
        """Pro only: mint a project API key (``POST /v1/projects/{project_id}/api-keys``).

        The plaintext ``key`` is returned exactly once, in this response.
        """
        self._require_tier("pro", "create_api_key")
        payload = self._request_json("POST", f"/v1/projects/{_q(project_id)}/api-keys", json_body=_coerce_body(body))
        return CreateApiKeyResponse.from_dict(_expect_object(payload, "API key"))

    def revoke_api_key(self, project_id: str, key_id: str) -> None:
        """Pro only: revoke an API key (``DELETE /v1/projects/{project_id}/api-keys/{key_id}``)."""
        self._require_tier("pro", "revoke_api_key")
        self._request_json("DELETE", f"/v1/projects/{_q(project_id)}/api-keys/{_q(key_id)}")

    def list_integrations(
        self,
        project_id: str,
        *,
        limit: int | None = None,
        offset: int | None = None,
    ) -> ListIntegrationsResponse:
        """Pro only: list a project's integrations (``GET /v1/projects/{project_id}/integrations``)."""
        self._require_tier("pro", "list_integrations")
        payload = self._request_json(
            "GET", f"/v1/projects/{_q(project_id)}/integrations", params=_pagination(limit, offset)
        )
        return ListIntegrationsResponse.from_dict(_expect_object(payload, "integration list"))

    def create_integration(
        self,
        project_id: str,
        body: CreateIntegrationRequest | Mapping[str, Any],
    ) -> IntegrationResponse:
        """Pro only: create an integration (``POST /v1/projects/{project_id}/integrations``)."""
        self._require_tier("pro", "create_integration")
        payload = self._request_json(
            "POST", f"/v1/projects/{_q(project_id)}/integrations", json_body=_coerce_body(body)
        )
        return IntegrationResponse.from_dict(_expect_object(payload, "integration"))

    def get_integration(self, project_id: str, integration_id: str) -> IntegrationResponse:
        """Pro only: fetch one integration (``GET .../integrations/{integration_id}``)."""
        self._require_tier("pro", "get_integration")
        payload = self._request_json("GET", f"/v1/projects/{_q(project_id)}/integrations/{_q(integration_id)}")
        return IntegrationResponse.from_dict(_expect_object(payload, "integration"))

    def delete_integration(self, project_id: str, integration_id: str) -> None:
        """Pro only: delete an integration (``DELETE .../integrations/{integration_id}``)."""
        self._require_tier("pro", "delete_integration")
        self._request_json("DELETE", f"/v1/projects/{_q(project_id)}/integrations/{_q(integration_id)}")

    def connect_integration(self, project_id: str, integration_id: str) -> BeginOAuthResponse:
        """Pro only: begin the OAuth connect flow (``POST .../integrations/{integration_id}/connect``).

        Returns the provider ``authorize_url`` the end user must visit.
        """
        self._require_tier("pro", "connect_integration")
        payload = self._request_json("POST", f"/v1/projects/{_q(project_id)}/integrations/{_q(integration_id)}/connect")
        return BeginOAuthResponse.from_dict(_expect_object(payload, "OAuth connect"))

    def disconnect_integration(self, project_id: str, integration_id: str) -> None:
        """Pro only: drop an integration's stored credentials (``POST .../disconnect``)."""
        self._require_tier("pro", "disconnect_integration")
        self._request_json("POST", f"/v1/projects/{_q(project_id)}/integrations/{_q(integration_id)}/disconnect")

    def list_integration_documents(
        self,
        project_id: str,
        integration_id: str,
        *,
        mime_types: str | None = None,
        folder_id: str | None = None,
        max_results: int | None = None,
    ) -> ListDocumentsResponse:
        """Pro only: list documents visible through an integration (``GET .../documents``)."""
        self._require_tier("pro", "list_integration_documents")
        params = _query_params(mime_types=mime_types, folder_id=folder_id, max_results=max_results)
        payload = self._request_json(
            "GET", f"/v1/projects/{_q(project_id)}/integrations/{_q(integration_id)}/documents", params=params
        )
        return ListDocumentsResponse.from_dict(_expect_object(payload, "integration document list"))

    def fetch_integration_document(self, project_id: str, integration_id: str, document_id: str) -> bytes:
        """Pro only: download one document through an integration (``GET .../documents/{document_id}``)."""
        self._require_tier("pro", "fetch_integration_document")
        return self._request_bytes(
            "GET", f"/v1/projects/{_q(project_id)}/integrations/{_q(integration_id)}/documents/{_q(document_id)}"
        )

    # -- Enterprise-only surface ------------------------------------------

    def _request_control(self, method: str, path: str, **kwargs: Any) -> httpx.Response:
        known_tier = self._target or self._probed_tier
        if known_tier is not None:
            self._require_tier_or_raise(known_tier, "enterprise", "backend operation")
        return self._request(method, path, control_plane=True, **kwargs)

    def _request_control_json(self, method: str, path: str, **kwargs: Any) -> Any:
        response = self._request_control(method, path, **kwargs)
        raise_for_status(response)
        return _backend_json(response)

    def _request_control_bytes(self, method: str, path: str, **kwargs: Any) -> bytes:
        response = self._request_control(method, path, **kwargs)
        raise_for_status(response)
        return response.content

    def _request_control_none(self, method: str, path: str, **kwargs: Any) -> None:
        response = self._request_control(method, path, **kwargs)
        raise_for_status(response)

    def _request_control_redirect(self, method: str, path: str, **kwargs: Any) -> str:
        response = self._request_control(method, path, **kwargs)
        if response.status_code != 303 or not response.headers.get("Location"):
            raise_for_status(response)
            raise XbergError("OAuth callback did not return a redirect location", status_code=response.status_code)
        return response.headers["Location"]

    def delete_account(self) -> None:
        """Enterprise backend: Delete the authenticated user's account and all associated data (``DELETE /auth/account``)."""
        self._request_control_none("DELETE", "/auth/account")

    def get_auth_config(self) -> BackendAuthConfigResponse:
        """Enterprise backend: `GET /auth/config`: which auth methods this instance accepts. (``GET /auth/config``)."""
        payload = self._request_control_json("GET", "/auth/config", public=True)
        return BackendAuthConfigResponse.from_dict(_expect_object(payload, "get_auth_config"))

    def backend_login(self, body: BackendLoginRequest | Mapping[str, Any]) -> BackendLoginResponse:
        """Enterprise backend: Authenticate with an OIDC ID token and receive a backend JWT (``POST /auth/login``)."""
        payload = self._request_control_json("POST", "/auth/login", json_body=_coerce_body(body), public=True)
        return BackendLoginResponse.from_dict(_expect_object(payload, "login"))

    def healthz(self) -> BackendHealthResponse:
        """Enterprise backend: Liveness probe - returns 200 if the process is running (``GET /healthz``)."""
        payload = self._request_control_json("GET", "/healthz", public=True)
        return BackendHealthResponse.from_dict(_expect_object(payload, "healthz"))

    def readyz(self) -> BackendReadinessResponse:
        """Enterprise backend: Readiness probe - returns 200 if the service can handle traffic (``GET /readyz``)."""
        payload = self._request_control_json("GET", "/readyz", public=True)
        return BackendReadinessResponse.from_dict(_expect_object(payload, "readyz"))

    def accept_invitation(self, body: BackendAcceptInvitationRequest | Mapping[str, Any]) -> BackendMemberResponse:
        """Enterprise backend: Accept an invitation using a token (``POST /v1/invitations/accept``)."""
        payload = self._request_control_json("POST", "/v1/invitations/accept", json_body=_coerce_body(body))
        return BackendMemberResponse.from_dict(_expect_object(payload, "accept_invitation"))

    def oauth_callback(self, *, code: str, state: str) -> str:
        """Enterprise backend: OAuth callback handler (``GET /v1/oauth/callback``)."""
        return self._request_control_redirect(
            "GET", "/v1/oauth/callback", params=_query_params(code=code, state=state), public=True
        )

    def backend_list_projects(
        self, *, limit: int | None = None, offset: int | None = None
    ) -> BackendListProjectsResponse:
        """Enterprise backend: List all projects for the authenticated user (``GET /v1/projects``)."""
        payload = self._request_control_json("GET", "/v1/projects", params=_query_params(limit=limit, offset=offset))
        return BackendListProjectsResponse.from_dict(_expect_object(payload, "list_projects"))

    def backend_create_project(self, body: BackendCreateProjectRequest | Mapping[str, Any]) -> BackendProjectResponse:
        """Enterprise backend: Create a new project (``POST /v1/projects``)."""
        payload = self._request_control_json("POST", "/v1/projects", json_body=_coerce_body(body))
        return BackendProjectResponse.from_dict(_expect_object(payload, "create_project"))

    def get_project(self, project_id: str) -> BackendProjectResponse:
        """Enterprise backend: Get project details by ID (``GET /v1/projects/{id}``)."""
        payload = self._request_control_json("GET", f"/v1/projects/{_q(project_id)}")
        return BackendProjectResponse.from_dict(_expect_object(payload, "get_project"))

    def delete_project(self, project_id: str, *, erase: bool | None = None) -> None:
        """Enterprise backend: Delete a project (``DELETE /v1/projects/{id}``)."""
        self._request_control_none("DELETE", f"/v1/projects/{_q(project_id)}", params=_query_params(erase=erase))

    def update_project(
        self, project_id: str, body: BackendUpdateProjectRequest | Mapping[str, Any]
    ) -> BackendProjectResponse:
        """Enterprise backend: Update project details (``PATCH /v1/projects/{id}``)."""
        payload = self._request_control_json("PATCH", f"/v1/projects/{_q(project_id)}", json_body=_coerce_body(body))
        return BackendProjectResponse.from_dict(_expect_object(payload, "update_project"))

    def get_analytics(self, project_id: str, *, start_date: str, end_date: str) -> BackendAnalyticsResponse:
        """Enterprise backend: Get analytics data for a project within a date range (``GET /v1/projects/{id}/analytics``)."""
        payload = self._request_control_json(
            "GET",
            f"/v1/projects/{_q(project_id)}/analytics",
            params=_query_params(start_date=start_date, end_date=end_date),
        )
        return BackendAnalyticsResponse.from_dict(_expect_object(payload, "get_analytics"))

    def backend_list_api_keys(
        self, project_id: str, *, limit: int | None = None, offset: int | None = None
    ) -> BackendListApiKeysResponse:
        """Enterprise backend: List all API keys for a project (``GET /v1/projects/{id}/api-keys``)."""
        payload = self._request_control_json(
            "GET", f"/v1/projects/{_q(project_id)}/api-keys", params=_query_params(limit=limit, offset=offset)
        )
        return BackendListApiKeysResponse.from_dict(_expect_object(payload, "list_api_keys"))

    def backend_create_api_key(
        self, project_id: str, body: BackendCreateApiKeyRequest | Mapping[str, Any]
    ) -> BackendCreateApiKeyResponse:
        """Enterprise backend: Create a new API key for a project (``POST /v1/projects/{id}/api-keys``)."""
        payload = self._request_control_json(
            "POST", f"/v1/projects/{_q(project_id)}/api-keys", json_body=_coerce_body(body)
        )
        return BackendCreateApiKeyResponse.from_dict(_expect_object(payload, "create_api_key"))

    def backend_revoke_api_key(self, project_id: str, key_id: str) -> None:
        """Enterprise backend: Revoke an API key (``DELETE /v1/projects/{id}/api-keys/{key_id}``)."""
        self._request_control_none("DELETE", f"/v1/projects/{_q(project_id)}/api-keys/{_q(key_id)}")

    def regenerate_api_key(self, project_id: str, key_id: str) -> BackendCreateApiKeyResponse:
        """Enterprise backend: Regenerate an API key (``POST /v1/projects/{id}/api-keys/{key_id}/regenerate``)."""
        payload = self._request_control_json("POST", f"/v1/projects/{_q(project_id)}/api-keys/{_q(key_id)}/regenerate")
        return BackendCreateApiKeyResponse.from_dict(_expect_object(payload, "regenerate_api_key"))

    def list_project_audit(
        self, project_id: str, *, action: str | None = None, limit: int | None = None, offset: int | None = None
    ) -> BackendListAuditEntriesResponse:
        """Enterprise backend: List a project's audit events, most recent first. (``GET /v1/projects/{id}/audit``)."""
        payload = self._request_control_json(
            "GET",
            f"/v1/projects/{_q(project_id)}/audit",
            params=_query_params(action=action, limit=limit, offset=offset),
        )
        return BackendListAuditEntriesResponse.from_dict(_expect_object(payload, "list_project_audit"))

    def get_billing(self, project_id: str) -> BackendBillingResponse:
        """Enterprise backend: Get billing and quota information for a project (``GET /v1/projects/{id}/billing``)."""
        payload = self._request_control_json("GET", f"/v1/projects/{_q(project_id)}/billing")
        return BackendBillingResponse.from_dict(_expect_object(payload, "get_billing"))

    def create_checkout(self, project_id: str) -> BackendCheckoutResponse:
        """Enterprise backend: Create a Stripe Checkout Session for a project (``POST /v1/projects/{id}/billing/checkout``)."""
        payload = self._request_control_json("POST", f"/v1/projects/{_q(project_id)}/billing/checkout")
        return BackendCheckoutResponse.from_dict(_expect_object(payload, "create_checkout"))

    def create_portal(self, project_id: str) -> BackendPortalResponse:
        """Enterprise backend: Create a Stripe Customer Portal Session for a project (``POST /v1/projects/{id}/billing/portal``)."""
        payload = self._request_control_json("POST", f"/v1/projects/{_q(project_id)}/billing/portal")
        return BackendPortalResponse.from_dict(_expect_object(payload, "create_portal"))

    def backend_list_integrations(
        self, project_id: str, *, limit: int | None = None, offset: int | None = None
    ) -> BackendListIntegrationsResponse:
        """Enterprise backend: List all integrations for a project (``GET /v1/projects/{id}/integrations``)."""
        payload = self._request_control_json(
            "GET", f"/v1/projects/{_q(project_id)}/integrations", params=_query_params(limit=limit, offset=offset)
        )
        return BackendListIntegrationsResponse.from_dict(_expect_object(payload, "list_integrations"))

    def backend_create_integration(
        self, project_id: str, body: BackendCreateIntegrationRequest | Mapping[str, Any]
    ) -> BackendIntegrationResponse:
        """Enterprise backend: Create a new integration (``POST /v1/projects/{id}/integrations``)."""
        payload = self._request_control_json(
            "POST", f"/v1/projects/{_q(project_id)}/integrations", json_body=_coerce_body(body)
        )
        return BackendIntegrationResponse.from_dict(_expect_object(payload, "create_integration"))

    def backend_get_integration(self, project_id: str, integration_id: str) -> BackendIntegrationResponse:
        """Enterprise backend: Get a specific integration (``GET /v1/projects/{id}/integrations/{iid}``)."""
        payload = self._request_control_json("GET", f"/v1/projects/{_q(project_id)}/integrations/{_q(integration_id)}")
        return BackendIntegrationResponse.from_dict(_expect_object(payload, "get_integration"))

    def backend_delete_integration(self, project_id: str, integration_id: str) -> None:
        """Enterprise backend: Delete an integration (``DELETE /v1/projects/{id}/integrations/{iid}``)."""
        self._request_control_none("DELETE", f"/v1/projects/{_q(project_id)}/integrations/{_q(integration_id)}")

    def oauth_connect(self, project_id: str, integration_id: str) -> BackendBeginConnectResponse:
        """Enterprise backend: Begin an OAuth authorization flow for an integration (owner-gated). (``POST /v1/projects/{id}/integrations/{iid}/connect``)."""
        payload = self._request_control_json(
            "POST", f"/v1/projects/{_q(project_id)}/integrations/{_q(integration_id)}/connect"
        )
        return BackendBeginConnectResponse.from_dict(_expect_object(payload, "oauth_connect"))

    def backend_disconnect_integration(self, project_id: str, integration_id: str) -> None:
        """Enterprise backend: Disconnect an integration (revoke OAuth connection) (``POST /v1/projects/{id}/integrations/{iid}/disconnect``)."""
        self._request_control_none(
            "POST", f"/v1/projects/{_q(project_id)}/integrations/{_q(integration_id)}/disconnect"
        )

    def backend_list_integration_documents(
        self,
        project_id: str,
        integration_id: str,
        *,
        mime_types: str | None = None,
        folder_id: str | None = None,
        max_results: int | None = None,
    ) -> BackendListDocumentsResponse:
        """Enterprise backend: List documents in a connected integration (``GET /v1/projects/{id}/integrations/{iid}/documents``)."""
        payload = self._request_control_json(
            "GET",
            f"/v1/projects/{_q(project_id)}/integrations/{_q(integration_id)}/documents",
            params=_query_params(mime_types=mime_types, folder_id=folder_id, max_results=max_results),
        )
        return BackendListDocumentsResponse.from_dict(_expect_object(payload, "list_integration_documents"))

    def backend_fetch_integration_document(self, project_id: str, integration_id: str, document_id: str) -> bytes:
        """Enterprise backend: Fetch a single document from a connected integration (``GET /v1/projects/{id}/integrations/{iid}/documents/{doc_id}``)."""
        return self._request_control_bytes(
            "GET", f"/v1/projects/{_q(project_id)}/integrations/{_q(integration_id)}/documents/{_q(document_id)}"
        )

    def list_invitations(
        self, project_id: str, *, limit: int | None = None, offset: int | None = None
    ) -> BackendListInvitationsResponse:
        """Enterprise backend: List pending invitations for a project (``GET /v1/projects/{id}/invitations``)."""
        payload = self._request_control_json(
            "GET", f"/v1/projects/{_q(project_id)}/invitations", params=_query_params(limit=limit, offset=offset)
        )
        return BackendListInvitationsResponse.from_dict(_expect_object(payload, "list_invitations"))

    def invite_user(
        self, project_id: str, body: BackendCreateInvitationRequest | Mapping[str, Any]
    ) -> BackendCreateInvitationResponse:
        """Enterprise backend: Create a project invitation (sends token for email delivery by frontend) (``POST /v1/projects/{id}/invitations``)."""
        payload = self._request_control_json(
            "POST", f"/v1/projects/{_q(project_id)}/invitations", json_body=_coerce_body(body)
        )
        return BackendCreateInvitationResponse.from_dict(_expect_object(payload, "invite_user"))

    def revoke_invitation(self, project_id: str, invitation_id: str) -> None:
        """Enterprise backend: Revoke a pending invitation (``DELETE /v1/projects/{id}/invitations/{inv_id}``)."""
        self._request_control_none("DELETE", f"/v1/projects/{_q(project_id)}/invitations/{_q(invitation_id)}")

    def leave_project(self, project_id: str) -> None:
        """Enterprise backend: Self-service: caller leaves a project they belong to (``POST /v1/projects/{id}/leave``)."""
        self._request_control_none("POST", f"/v1/projects/{_q(project_id)}/leave")

    def list_members(
        self, project_id: str, *, limit: int | None = None, offset: int | None = None
    ) -> BackendListMembersResponse:
        """Enterprise backend: List all members of a project (``GET /v1/projects/{id}/members``)."""
        payload = self._request_control_json(
            "GET", f"/v1/projects/{_q(project_id)}/members", params=_query_params(limit=limit, offset=offset)
        )
        return BackendListMembersResponse.from_dict(_expect_object(payload, "list_members"))

    def remove_member(self, project_id: str, user_id: str) -> None:
        """Enterprise backend: Remove a member from a project (``DELETE /v1/projects/{id}/members/{user_id}``)."""
        self._request_control_none("DELETE", f"/v1/projects/{_q(project_id)}/members/{_q(user_id)}")

    def update_member_role(
        self, project_id: str, user_id: str, body: BackendUpdateMemberRoleRequest | Mapping[str, Any]
    ) -> BackendMemberResponse:
        """Enterprise backend: Update a member's role in a project (``PATCH /v1/projects/{id}/members/{user_id}``)."""
        payload = self._request_control_json(
            "PATCH", f"/v1/projects/{_q(project_id)}/members/{_q(user_id)}", json_body=_coerce_body(body)
        )
        return BackendMemberResponse.from_dict(_expect_object(payload, "update_member_role"))

    def backend_get_rag_config(self, project_id: str) -> BackendRagConfigResponse:
        """Enterprise backend: Read a project's RAG configuration. (``GET /v1/projects/{id}/rag-config``)."""
        payload = self._request_control_json("GET", f"/v1/projects/{_q(project_id)}/rag-config")
        return BackendRagConfigResponse.from_dict(_expect_object(payload, "get_rag_config"))

    def backend_set_rag_config(
        self, project_id: str, body: BackendSetRagConfigRequest | Mapping[str, Any]
    ) -> BackendRagConfigResponse:
        """Enterprise backend: Set a project's RAG configuration. (``PUT /v1/projects/{id}/rag-config``)."""
        payload = self._request_control_json(
            "PUT", f"/v1/projects/{_q(project_id)}/rag-config", json_body=_coerce_body(body)
        )
        return BackendRagConfigResponse.from_dict(_expect_object(payload, "set_rag_config"))

    def sandbox_extract(self, project_id: str, file: FileInput) -> BackendSandboxExtractResponse:
        """Enterprise backend: Extract a document in the sandbox (first page only) (``POST /v1/projects/{id}/sandbox/extract``)."""
        payload = self._request_control_json(
            "POST", f"/v1/projects/{_q(project_id)}/sandbox/extract", files=_multipart_files([file])
        )
        return BackendSandboxExtractResponse.from_dict(_expect_object(payload, "sandbox_extract"))

    def get_usage(self, project_id: str, *, start_date: str, end_date: str) -> BackendUsageResponse:
        """Enterprise backend: Get usage statistics for a project within a date range (``GET /v1/projects/{id}/usage``)."""
        payload = self._request_control_json(
            "GET",
            f"/v1/projects/{_q(project_id)}/usage",
            params=_query_params(start_date=start_date, end_date=end_date),
        )
        return BackendUsageResponse.from_dict(_expect_object(payload, "get_usage"))

    def list_webhooks(
        self, project_id: str, *, limit: int | None = None, offset: int | None = None
    ) -> BackendListWebhooksResponse:
        """Enterprise backend: List all webhooks for a project (``GET /v1/projects/{id}/webhooks``)."""
        payload = self._request_control_json(
            "GET", f"/v1/projects/{_q(project_id)}/webhooks", params=_query_params(limit=limit, offset=offset)
        )
        return BackendListWebhooksResponse.from_dict(_expect_object(payload, "list_webhooks"))

    def create_webhook(
        self, project_id: str, body: BackendCreateWebhookRequest | Mapping[str, Any]
    ) -> BackendWebhookResponse:
        """Enterprise backend: Create a new webhook for a project (``POST /v1/projects/{id}/webhooks``)."""
        payload = self._request_control_json(
            "POST", f"/v1/projects/{_q(project_id)}/webhooks", json_body=_coerce_body(body)
        )
        return BackendWebhookResponse.from_dict(_expect_object(payload, "create_webhook"))

    def delete_webhook(self, project_id: str, webhook_id: str) -> None:
        """Enterprise backend: Delete a webhook (``DELETE /v1/projects/{id}/webhooks/{wh_id}``)."""
        self._request_control_none("DELETE", f"/v1/projects/{_q(project_id)}/webhooks/{_q(webhook_id)}")

    def update_webhook(
        self, project_id: str, webhook_id: str, body: BackendUpdateWebhookRequest | Mapping[str, Any]
    ) -> BackendWebhookResponse:
        """Enterprise backend: Update a webhook's configuration (``PATCH /v1/projects/{id}/webhooks/{wh_id}``)."""
        payload = self._request_control_json(
            "PATCH", f"/v1/projects/{_q(project_id)}/webhooks/{_q(webhook_id)}", json_body=_coerce_body(body)
        )
        return BackendWebhookResponse.from_dict(_expect_object(payload, "update_webhook"))

    def list_webhook_deliveries(
        self, project_id: str, webhook_id: str, *, limit: int | None = None, offset: int | None = None
    ) -> BackendListWebhookDeliveriesResponse:
        """Enterprise backend: List delivery attempts recorded for a webhook. (``GET /v1/projects/{id}/webhooks/{wh_id}/deliveries``)."""
        payload = self._request_control_json(
            "GET",
            f"/v1/projects/{_q(project_id)}/webhooks/{_q(webhook_id)}/deliveries",
            params=_query_params(limit=limit, offset=offset),
        )
        return BackendListWebhookDeliveriesResponse.from_dict(_expect_object(payload, "list_webhook_deliveries"))

    def retry_webhook_delivery(
        self, project_id: str, webhook_id: str, delivery_id: str
    ) -> BackendRetryWebhookDeliveryResponse:
        """Enterprise backend: Manually retry one past delivery attempt. (``POST /v1/projects/{id}/webhooks/{wh_id}/deliveries/{delivery_id}/retry``)."""
        payload = self._request_control_json(
            "POST", f"/v1/projects/{_q(project_id)}/webhooks/{_q(webhook_id)}/deliveries/{_q(delivery_id)}/retry"
        )
        return BackendRetryWebhookDeliveryResponse.from_dict(_expect_object(payload, "retry_webhook_delivery"))

    def test_webhook(self, project_id: str, webhook_id: str) -> BackendWebhookTestResponse:
        """Enterprise backend: Send a test delivery to a webhook endpoint (``POST /v1/projects/{id}/webhooks/{wh_id}/test``)."""
        payload = self._request_control_json("POST", f"/v1/projects/{_q(project_id)}/webhooks/{_q(webhook_id)}/test")
        return BackendWebhookTestResponse.from_dict(_expect_object(payload, "test_webhook"))

    def public_sandbox_extract(
        self,
        *,
        file: FileInput | None = None,
        mode: str | None = None,
        preset: str | None = None,
        url: str | None = None,
        sandbox_token: str | None = None,
    ) -> BackendSandboxExtractResponse:
        """Extract in the public sandbox; pass its optional OIDC bearer as ``sandbox_token``."""
        payload = self._request_control_json(
            "POST",
            "/v1/sandbox/public/extract",
            files=_public_sandbox_files(file, mode=mode, preset=preset, url=url),
            token=sandbox_token,
            public=True,
        )
        return BackendSandboxExtractResponse.from_dict(_expect_object(payload, "public_sandbox_extract"))

    def versions(self, document_id: str) -> Any:
        """Enterprise only: list a document's versions (``GET /v1/documents/{id}/versions``)."""
        self._require_tier("enterprise", "versions")
        return self._request_json("GET", f"/v1/documents/{_q(document_id)}/versions")

    def diff(self, document_id: str, *, params: Mapping[str, Any] | None = None) -> Any:
        """Enterprise only: diff document versions (``GET /v1/documents/{id}/diff``)."""
        self._require_tier("enterprise", "diff")
        return self._request_json("GET", f"/v1/documents/{_q(document_id)}/diff", params=params)

    def get_diff_job(self, document_id: str, diff_job_id: str) -> Any:
        """Enterprise only: poll a diff job (``GET /v1/documents/{id}/diff/{diff_job_id}``)."""
        self._require_tier("enterprise", "get_diff_job")
        return self._request_json("GET", f"/v1/documents/{_q(document_id)}/diff/{_q(diff_job_id)}")

    def presign_upload(self, body: Mapping[str, Any]) -> Any:
        """Enterprise only: request a presigned upload URL (``POST /v1/uploads/presign``)."""
        self._require_tier("enterprise", "presign_upload")
        return self._request_json("POST", "/v1/uploads/presign", json_body=body)

    def confirm_upload(self, body: Mapping[str, Any]) -> Any:
        """Enterprise only: confirm a presigned upload (``POST /v1/uploads/confirm``)."""
        self._require_tier("enterprise", "confirm_upload")
        return self._request_json("POST", "/v1/uploads/confirm", json_body=body)

    def usage(self, *, params: Mapping[str, Any] | None = None) -> Any:
        """Enterprise only: fetch usage/metering data (``GET /v1/usage``)."""
        self._require_tier("enterprise", "usage")
        return self._request_json("GET", "/v1/usage", params=params)

    def get_document(self, document_id: str) -> Any:
        """Enterprise only: fetch a document's latest version (``GET /v1/documents/{document_id}``).

        The spec declares an inline response schema, so the decoded body is returned as-is.
        """
        self._require_tier("enterprise", "get_document")
        return self._request_json("GET", f"/v1/documents/{_q(document_id)}")

    def get_job_page(self, job_id: str, page_number: int) -> bytes:
        """Enterprise only: fetch a rendered page image (``GET /v1/jobs/{id}/pages/{n}``, ``image/png`` bytes)."""
        self._require_tier("enterprise", "get_job_page")
        return self._request_bytes("GET", f"/v1/jobs/{_q(job_id)}/pages/{_q(page_number)}")

    def list_extraction_events(
        self,
        *,
        days: int | None = None,
        limit: int | None = None,
        offset: int | None = None,
    ) -> ListExtractionEventsResponse:
        """Enterprise only: list recent extraction events (``GET /v1/extractions``)."""
        self._require_tier("enterprise", "list_extraction_events")
        params = _query_params(days=days, limit=limit, offset=offset)
        payload = self._request_json("GET", _EXTRACTIONS_PATH, params=params)
        return ListExtractionEventsResponse.from_dict(_expect_object(payload, "extraction event list"))

    def submit_enrich(self, body: EnrichTextRequest | Mapping[str, Any]) -> EnrichJobSubmitted:
        """Enterprise only: submit text for enrichment (``POST /v1/enrich``, 202 Accepted)."""
        self._require_tier("enterprise", "submit_enrich")
        payload = self._request_json("POST", _ENRICH_PATH, json_body=_coerce_body(body))
        return EnrichJobSubmitted.from_dict(_expect_object(payload, "enrich submission"))

    def get_enrich_status(self, job_id: str) -> EnrichJobStatus:
        """Enterprise only: poll an enrichment job (``GET /v1/enrich/{job_id}``)."""
        self._require_tier("enterprise", "get_enrich_status")
        return _parse_enrich_status(self._request_json("GET", f"{_ENRICH_PATH}/{_q(job_id)}"))

    def stream_crawl_events(self, crawl_job_id: str) -> Iterator[CrawlEvent]:
        """Enterprise only: stream a crawl job's events (``GET /v1/crawl-jobs/{id}/events``).

        Yields the ``kind``-discriminated :data:`CrawlEvent` variants as the
        server publishes them, and returns when the server closes the stream
        (which it does once it has sent the ``complete`` event).

        This is a generator: nothing is requested -- not even the ``/healthz``
        tier probe -- until iteration begins, and the response body is closed
        when iteration ends, whether that is exhaustion, ``break``, or an
        exception. Closing the generator explicitly (or letting it fall out of
        scope) is enough to hang up on the server.

        >>> for event in client.stream_crawl_events(job_id):  # doctest: +SKIP
        ...     if event.kind == "page":
        ...         print(event.url, event.status_code)
        ...     elif event.kind == "complete":
        ...         break
        """
        self._require_tier("enterprise", "stream_crawl_events")
        decoder = _SSEDecoder()
        with self._request_stream("GET", f"/v1/crawl-jobs/{_q(crawl_job_id)}/events", accept=_SSE_ACCEPT) as response:
            for chunk in response.iter_bytes():
                for payload in decoder.feed_bytes(chunk):
                    yield _parse_crawl_event(payload)


class AsyncXbergClient(_BaseClient):
    """Asynchronous client for Xberg Enterprise and Xberg Pro.

    Mirrors :class:`XbergClient` method-for-method; everything is awaitable.

    >>> async with AsyncXbergClient(api_key="kz_...") as client:  # doctest: +SKIP
    ...     result = await client.extract_and_wait(file=Path("invoice.pdf"))
    """

    def __init__(
        self,
        *,
        api_key: str | None = None,
        base_url: str | None = None,
        control_plane_base_url: str | None = None,
        control_plane_token: str | None = None,
        target: Target | None = None,
        timeout: float = DEFAULT_TIMEOUT_SECONDS,
        headers: Mapping[str, str] | None = None,
        retries: int = _DEFAULT_RETRIES,
        retry_on: Iterable[int] | None = None,
        retry_backoff: BackoffStrategy = "exponential",
    ) -> None:
        super().__init__(
            api_key=api_key,
            base_url=base_url,
            control_plane_base_url=control_plane_base_url,
            control_plane_token=control_plane_token,
            target=target,
            timeout=timeout,
            headers=headers,
            retries=retries,
            retry_on=retry_on,
            retry_backoff=retry_backoff,
        )
        self._http = httpx.AsyncClient(base_url=self._base_url, timeout=self._timeout, headers=self._headers)
        self._tier_lock = asyncio.Lock()

    async def __aenter__(self) -> Self:
        """Enter the async context manager."""
        return self

    async def __aexit__(
        self,
        exc_type: type[BaseException] | None,
        exc_val: BaseException | None,
        exc_tb: TracebackType | None,
    ) -> None:
        """Exit the async context manager and close the underlying HTTP transport."""
        await self.aclose()

    async def aclose(self) -> None:
        """Close the underlying async HTTP transport, releasing connections."""
        await self._http.aclose()

    async def _request(
        self,
        method: str,
        path: str,
        *,
        files: Any | None = None,
        data: Any | None = None,
        json_body: Any | None = None,
        params: Mapping[str, Any] | None = None,
        control_plane: bool = False,
        public: bool = False,
        token: str | None = None,
    ) -> httpx.Response:
        """Issue one HTTP request with the configured retry engine, returning the raw response."""
        attempt = 0
        interval = _RETRY_BACKOFF_BASE
        if files and self._retries > 0:
            _reject_unretryable_files(files)
        while True:
            try:
                if control_plane:
                    request = self._http.build_request(
                        method,
                        self._control_plane_base_url + path,
                        files=files,
                        data=data,
                        json=json_body,
                        params=params,
                    )
                    request.headers.pop("Authorization", None)
                    credential = token if public else self._control_plane_token
                    if credential is not None:
                        request.headers["Authorization"] = f"Bearer {credential}"
                    response = await self._http.send(request, follow_redirects=False)
                else:
                    response = await self._http.request(
                        method, path, files=files, data=data, json=json_body, params=params
                    )
            except httpx.TransportError as exc:
                if attempt < self._retries:
                    attempt += 1
                    await asyncio.sleep(interval)
                    interval = _next_interval(interval, self._retry_backoff)
                    continue
                raise XbergError(f"network error contacting {path}", status_code=None) from exc
            if response.is_success:
                return response
            if response.status_code in self._retry_on and attempt < self._retries:
                attempt += 1
                retry_after = parse_retry_after(response.headers.get("Retry-After"))
                await asyncio.sleep(retry_after if retry_after is not None else interval)
                interval = _next_interval(interval, self._retry_backoff)
                continue
            return response

    async def _request_json(
        self,
        method: str,
        path: str,
        *,
        files: Any | None = None,
        data: Any | None = None,
        json_body: Any | None = None,
        params: Mapping[str, Any] | None = None,
    ) -> Any:
        """Issue a request, raise on non-2xx, and decode the JSON body (``None`` for empty bodies)."""
        response = await self._request(method, path, files=files, data=data, json_body=json_body, params=params)
        raise_for_status(response)
        if response.status_code == 204 or not response.content:
            return None
        return response.json()

    async def _request_bytes(self, method: str, path: str, *, params: Mapping[str, Any] | None = None) -> bytes:
        """Issue a request, raise on non-2xx, and return the raw (non-JSON) response body."""
        response = await self._request(method, path, params=params)
        raise_for_status(response)
        return response.content

    @asynccontextmanager
    async def _request_stream(self, method: str, path: str, *, accept: str) -> AsyncIterator[httpx.Response]:
        """Async equivalent of :meth:`XbergClient._request_stream` — no retries, no read timeout."""
        timeout = httpx.Timeout(self._timeout, read=None)
        async with self._http.stream(method, path, headers={"Accept": accept}, timeout=timeout) as response:
            if not response.is_success:
                await response.aread()
                raise_for_status(response)
            yield response

    async def _resolve_tier(self) -> str:
        """Return the effective tier — an explicit ``target`` if set, else probed from ``/healthz``.

        ``_tier_lock`` makes the probe single-flight: concurrent callers share
        one in-flight ``GET /healthz`` instead of each issuing their own. The
        lock is dedicated to tier resolution, so it never serializes unrelated
        requests. A failed probe (see :func:`_parse_probed_tier`) is never
        cached, so a later call can retry instead of being stuck with a bad
        result for the client's lifetime.
        """
        if self._target is not None:
            return self._target
        async with self._tier_lock:
            if self._probed_tier is None:
                self._probed_tier = _parse_probed_tier(await self._request_json("GET", "/healthz"))
            return self._probed_tier

    async def _require_tier(self, required: Target, method_name: str) -> None:
        self._require_tier_or_raise(await self._resolve_tier(), required, method_name)

    # -- Shared surface (Enterprise + Pro) ---------------------------------

    async def extract(
        self,
        *,
        file: FileInput,
        options: OptionsInput = None,
        webhook: Mapping[str, Any] | None = None,
        config: FileConfigInput = None,
    ) -> JobResponse:
        """Async equivalent of :meth:`XbergClient.extract`."""
        jobs = await self.extract_batch(
            [file],
            options=options,
            webhook=webhook,
            configs=None if config is None else [config],
        )
        return jobs[0]

    async def extract_batch(
        self,
        files: Iterable[FileInput],
        options: OptionsInput = None,
        webhook: Mapping[str, Any] | None = None,
        configs: Sequence[FileConfigInput] | None = None,
    ) -> list[JobResponse]:
        """Submit multiple documents in a SINGLE multipart request; fetch jobs concurrently."""
        materialized = list(files)
        if not materialized:
            raise XbergError("extract_batch called with no files", status_code=None)
        file_parts = _multipart_files(materialized)
        data = _multipart_data(options, webhook)
        data.update(_per_file_config_data(file_parts, configs))
        payload = await self._request_json("POST", "/v1/extract", files=file_parts, data=data)
        job_ids = _job_ids_from_extract_response(payload)
        return list(await asyncio.gather(*(self.get_job(job_id) for job_id in job_ids)))

    async def get_job(self, job_id: str) -> JobResponse:
        """Async equivalent of :meth:`XbergClient.get_job`."""
        return _parse_job(await self._request_json("GET", f"/v1/jobs/{_q(job_id)}"))

    async def get_job_result(self, job_id: str) -> JobResult:
        """Async equivalent of :meth:`XbergClient.get_job_result`."""
        return _parse_job_result(await self._request_json("GET", f"/v1/jobs/{_q(job_id)}/result"))

    async def list_jobs(self, *, limit: int | None = None, offset: int | None = None) -> Any:
        """Async equivalent of :meth:`XbergClient.list_jobs`."""
        params = {k: v for k, v in (("limit", limit), ("offset", offset)) if v is not None}
        return await self._request_json("GET", "/v1/jobs", params=params or None)

    async def cancel_job(self, job_id: str) -> None:
        """Async equivalent of :meth:`XbergClient.cancel_job`."""
        await self._request_json("DELETE", f"/v1/jobs/{_q(job_id)}")

    async def wait_for_job(
        self,
        job_id: str,
        *,
        timeout: float = _DEFAULT_WAIT_TIMEOUT,
        poll_interval: float = _DEFAULT_POLL_INTERVAL,
        backoff: BackoffStrategy = "exponential",
    ) -> JobResponse:
        """Async equivalent of :meth:`XbergClient.wait_for_job` (raises on failure/timeout)."""
        deadline = time.monotonic() + timeout
        interval = poll_interval
        while True:
            job = await self.get_job(job_id)
            if job.status in _TERMINAL_STATUSES:
                _raise_if_failed(job)
                return job
            now = time.monotonic()
            if now >= deadline:
                raise ClientTimeoutError(
                    f"job {job_id} did not reach a terminal status within {timeout}s",
                    status_code=None,
                )
            await asyncio.sleep(min(interval, deadline - now))
            interval = _next_interval(interval, backoff)

    async def wait_for_jobs(
        self,
        job_ids: Iterable[str],
        *,
        timeout: float = _DEFAULT_WAIT_TIMEOUT,
        poll_interval: float = _DEFAULT_POLL_INTERVAL,
        backoff: BackoffStrategy = "exponential",
    ) -> list[JobResponse]:
        """Wait for multiple jobs concurrently."""
        coros = [
            self.wait_for_job(job_id, timeout=timeout, poll_interval=poll_interval, backoff=backoff)
            for job_id in job_ids
        ]
        return list(await asyncio.gather(*coros))

    async def extract_and_wait(
        self,
        *,
        file: FileInput,
        options: OptionsInput = None,
        webhook: Mapping[str, Any] | None = None,
        config: FileConfigInput = None,
        timeout: float = _DEFAULT_WAIT_TIMEOUT,
        poll_interval: float = _DEFAULT_POLL_INTERVAL,
        backoff: BackoffStrategy = "exponential",
    ) -> JobResponse:
        """Submit a document and await extraction in a single call (raises on failure/timeout)."""
        job = await self.extract(file=file, options=options, webhook=webhook, config=config)
        return await self.wait_for_job(str(job.id), timeout=timeout, poll_interval=poll_interval, backoff=backoff)

    async def audit(self, *, action: str | None = None, limit: int | None = None, offset: int | None = None) -> Any:
        """Async equivalent of :meth:`XbergClient.audit`."""
        params = {k: v for k, v in (("action", action), ("limit", limit), ("offset", offset)) if v is not None}
        return await self._request_json("GET", "/v1/audit", params=params or None)

    async def list_rag_collections(self) -> Any:
        """Async equivalent of :meth:`XbergClient.list_rag_collections`."""
        return await self._request_json("GET", "/v1/rag/collections")

    async def create_rag_collection(self, body: Mapping[str, Any]) -> Any:
        """Async equivalent of :meth:`XbergClient.create_rag_collection`."""
        return await self._request_json("POST", "/v1/rag/collections", json_body=body)

    async def get_rag_collection(self, name: str) -> Any:
        """Async equivalent of :meth:`XbergClient.get_rag_collection`."""
        return await self._request_json("GET", f"/v1/rag/collections/{_q(name)}")

    async def delete_rag_collection(self, name: str) -> None:
        """Async equivalent of :meth:`XbergClient.delete_rag_collection`."""
        await self._request_json("DELETE", f"/v1/rag/collections/{_q(name)}")

    async def add_rag_documents(self, name: str, body: Mapping[str, Any]) -> Any:
        """Async equivalent of :meth:`XbergClient.add_rag_documents`."""
        return await self._request_json("POST", f"/v1/rag/collections/{_q(name)}/documents", json_body=body)

    async def delete_rag_documents(self, name: str, body: Mapping[str, Any]) -> Any:
        """Async equivalent of :meth:`XbergClient.delete_rag_documents`."""
        return await self._request_json("DELETE", f"/v1/rag/collections/{_q(name)}/documents", json_body=body)

    async def reindex_rag_document(self, name: str, document_id: str, body: Mapping[str, Any] | None = None) -> Any:
        """Async equivalent of :meth:`XbergClient.reindex_rag_document`."""
        return await self._request_json(
            "POST", f"/v1/rag/collections/{_q(name)}/documents/{_q(document_id)}/reindex", json_body=body
        )

    async def rag_retrieve(self, name: str, body: Mapping[str, Any]) -> Any:
        """Async equivalent of :meth:`XbergClient.rag_retrieve`."""
        return await self._request_json("POST", f"/v1/rag/collections/{_q(name)}/retrieve", json_body=body)

    async def migrate_rag_embeddings(self, name: str, body: Mapping[str, Any]) -> Any:
        """Async equivalent of :meth:`XbergClient.migrate_rag_embeddings`."""
        return await self._request_json("POST", f"/v1/rag/collections/{_q(name)}/migrate-embeddings", json_body=body)

    async def get_rag_migration_job(self, name: str, job_id: str) -> Any:
        """Async equivalent of :meth:`XbergClient.get_rag_migration_job`."""
        return await self._request_json("GET", f"/v1/rag/collections/{_q(name)}/migrate-embeddings/{_q(job_id)}")

    async def get_rag_job(self, job_id: str) -> Any:
        """Async equivalent of :meth:`XbergClient.get_rag_job`."""
        return await self._request_json("GET", f"/v1/rag/jobs/{_q(job_id)}")

    async def presets(self) -> list[PresetSummary]:
        """Async equivalent of :meth:`XbergClient.presets`."""
        return _parse_presets(await self._request_json("GET", "/v1/presets"))

    async def get_preset(self, preset_id: str) -> PresetDetail:
        """Async equivalent of :meth:`XbergClient.get_preset`."""
        payload = await self._request_json("GET", f"/v1/presets/{_q(preset_id)}")
        return PresetDetail.from_dict(_expect_object(payload, "preset"))

    async def get_preset_sample(self, preset_id: str, name: str) -> bytes:
        """Async equivalent of :meth:`XbergClient.get_preset_sample`."""
        return await self._request_bytes("GET", f"/v1/presets/{_q(preset_id)}/sample/{_q(name)}")

    async def list_saved_presets(
        self,
        *,
        limit: int | None = None,
        offset: int | None = None,
    ) -> ListSavedPresetsResponse:
        """Async equivalent of :meth:`XbergClient.list_saved_presets`."""
        path = _saved_presets_path(await self._resolve_tier())
        payload = await self._request_json("GET", path, params=_pagination(limit, offset))
        return ListSavedPresetsResponse.from_dict(_expect_object(payload, "saved preset list"))

    async def create_saved_preset(
        self,
        body: CreateSavedPresetRequest | Mapping[str, Any],
    ) -> CreateSavedPresetResponse:
        """Async equivalent of :meth:`XbergClient.create_saved_preset`."""
        path = _saved_presets_path(await self._resolve_tier())
        payload = await self._request_json("POST", path, json_body=_coerce_body(body))
        return CreateSavedPresetResponse.from_dict(_expect_object(payload, "saved preset"))

    async def get_saved_preset(self, preset_id: str) -> SavedPresetDetail:
        """Async equivalent of :meth:`XbergClient.get_saved_preset`."""
        path = _saved_presets_path(await self._resolve_tier(), preset_id)
        return SavedPresetDetail.from_dict(_expect_object(await self._request_json("GET", path), "saved preset"))

    async def update_saved_preset(
        self,
        preset_id: str,
        body: UpdateSavedPresetRequest | Mapping[str, Any],
    ) -> UpdateSavedPresetResponse:
        """Async equivalent of :meth:`XbergClient.update_saved_preset`."""
        path = _saved_presets_path(await self._resolve_tier(), preset_id)
        payload = await self._request_json("PATCH", path, json_body=_coerce_body(body))
        return UpdateSavedPresetResponse.from_dict(_expect_object(payload, "saved preset"))

    async def delete_saved_preset(self, preset_id: str) -> None:
        """Async equivalent of :meth:`XbergClient.delete_saved_preset`."""
        await self._request_json("DELETE", _saved_presets_path(await self._resolve_tier(), preset_id))

    async def list_auto_tune_jobs(
        self,
        *,
        limit: int | None = None,
        offset: int | None = None,
    ) -> ListAutoTuneJobsResponse:
        """Async equivalent of :meth:`XbergClient.list_auto_tune_jobs`."""
        payload = await self._request_json("GET", _AUTO_TUNE_PATH, params=_pagination(limit, offset))
        return ListAutoTuneJobsResponse.from_dict(_expect_object(payload, "auto-tune job list"))

    async def submit_auto_tune(
        self,
        request: CreateAutoTuneJobRequest | Mapping[str, Any],
        files: Iterable[FileInput],
    ) -> CreateAutoTuneJobResponse:
        """Async equivalent of :meth:`XbergClient.submit_auto_tune`."""
        materialized = list(files)
        if not materialized:
            raise XbergError("submit_auto_tune called with no files", status_code=None)
        payload = await self._request_json(
            "POST",
            _AUTO_TUNE_PATH,
            files=_multipart_files(materialized),
            data=_auto_tune_multipart_data(request),
        )
        return CreateAutoTuneJobResponse.from_dict(_expect_object(payload, "auto-tune job"))

    async def get_auto_tune_capabilities(self) -> AutoTuneCapabilitiesResponse:
        """Async equivalent of :meth:`XbergClient.get_auto_tune_capabilities`."""
        payload = await self._request_json("GET", f"{_AUTO_TUNE_PATH}/capabilities")
        return AutoTuneCapabilitiesResponse.from_dict(_expect_object(payload, "auto-tune capabilities"))

    async def get_auto_tune_status(self, auto_tune_job_id: str) -> AutoTuneJobStatus:
        """Async equivalent of :meth:`XbergClient.get_auto_tune_status`."""
        payload = await self._request_json("GET", f"{_AUTO_TUNE_PATH}/{_q(auto_tune_job_id)}")
        return AutoTuneJobStatus.from_dict(_expect_object(payload, "auto-tune status"))

    async def delete_auto_tune_job(self, auto_tune_job_id: str) -> None:
        """Async equivalent of :meth:`XbergClient.delete_auto_tune_job`."""
        await self._request_json("DELETE", f"{_AUTO_TUNE_PATH}/{_q(auto_tune_job_id)}")

    async def promote_auto_tune_profile(
        self,
        auto_tune_job_id: str,
        body: PromoteProfileRequest | Mapping[str, Any],
    ) -> TuningProfileDetail:
        """Async equivalent of :meth:`XbergClient.promote_auto_tune_profile`."""
        payload = await self._request_json(
            "POST", f"{_AUTO_TUNE_PATH}/{_q(auto_tune_job_id)}/promote", json_body=_coerce_body(body)
        )
        return TuningProfileDetail.from_dict(_expect_object(payload, "tuning profile"))

    async def get_auto_tune_result(self, auto_tune_job_id: str) -> AutoTuneResult:
        """Async equivalent of :meth:`XbergClient.get_auto_tune_result`."""
        payload = await self._request_json("GET", f"{_AUTO_TUNE_PATH}/{_q(auto_tune_job_id)}/result")
        return AutoTuneResult.from_dict(_expect_object(payload, "auto-tune result"))

    async def list_tuning_profiles(
        self,
        *,
        limit: int | None = None,
        offset: int | None = None,
    ) -> ListTuningProfilesResponse:
        """Async equivalent of :meth:`XbergClient.list_tuning_profiles`."""
        payload = await self._request_json("GET", _TUNING_PROFILES_PATH, params=_pagination(limit, offset))
        return ListTuningProfilesResponse.from_dict(_expect_object(payload, "tuning profile list"))

    async def get_tuning_profile(self, profile_id: str) -> TuningProfileDetail:
        """Async equivalent of :meth:`XbergClient.get_tuning_profile`."""
        payload = await self._request_json("GET", f"{_TUNING_PROFILES_PATH}/{_q(profile_id)}")
        return TuningProfileDetail.from_dict(_expect_object(payload, "tuning profile"))

    async def delete_tuning_profile(self, profile_id: str) -> None:
        """Async equivalent of :meth:`XbergClient.delete_tuning_profile`."""
        await self._request_json("DELETE", f"{_TUNING_PROFILES_PATH}/{_q(profile_id)}")

    # -- Pro-only surface --------------------------------------------------

    async def auth_config(self) -> Any:
        """Pro only: async equivalent of :meth:`XbergClient.auth_config`."""
        await self._require_tier("pro", "auth_config")
        return await self._request_json("GET", "/auth/config")

    async def login(self, body: Mapping[str, Any]) -> Any:
        """Pro only: async equivalent of :meth:`XbergClient.login`."""
        await self._require_tier("pro", "login")
        return await self._request_json("POST", "/auth/login", json_body=body)

    async def get_rag_config(self, project_id: str) -> Any:
        """Pro only: async equivalent of :meth:`XbergClient.get_rag_config`."""
        await self._require_tier("pro", "get_rag_config")
        return await self._request_json("GET", f"/v1/projects/{_q(project_id)}/rag-config")

    async def set_rag_config(self, project_id: str, body: Mapping[str, Any]) -> Any:
        """Pro only: async equivalent of :meth:`XbergClient.set_rag_config`."""
        await self._require_tier("pro", "set_rag_config")
        return await self._request_json("PUT", f"/v1/projects/{_q(project_id)}/rag-config", json_body=body)

    # -- Pro-only control plane (projects, API keys, integrations) ---------

    async def list_projects(self, *, limit: int | None = None, offset: int | None = None) -> ListProjectsResponse:
        """Async equivalent of :meth:`XbergClient.list_projects`."""
        await self._require_tier("pro", "list_projects")
        payload = await self._request_json("GET", "/v1/projects", params=_pagination(limit, offset))
        return ListProjectsResponse.from_dict(_expect_object(payload, "project list"))

    async def create_project(self, body: CreateProjectRequest | Mapping[str, Any]) -> ProjectResponse:
        """Async equivalent of :meth:`XbergClient.create_project`."""
        await self._require_tier("pro", "create_project")
        payload = await self._request_json("POST", "/v1/projects", json_body=_coerce_body(body))
        return ProjectResponse.from_dict(_expect_object(payload, "project"))

    async def list_api_keys(
        self,
        project_id: str,
        *,
        limit: int | None = None,
        offset: int | None = None,
    ) -> ListApiKeysResponse:
        """Async equivalent of :meth:`XbergClient.list_api_keys`."""
        await self._require_tier("pro", "list_api_keys")
        payload = await self._request_json(
            "GET", f"/v1/projects/{_q(project_id)}/api-keys", params=_pagination(limit, offset)
        )
        return ListApiKeysResponse.from_dict(_expect_object(payload, "API key list"))

    async def create_api_key(
        self,
        project_id: str,
        body: CreateApiKeyRequest | Mapping[str, Any],
    ) -> CreateApiKeyResponse:
        """Async equivalent of :meth:`XbergClient.create_api_key`."""
        await self._require_tier("pro", "create_api_key")
        payload = await self._request_json(
            "POST", f"/v1/projects/{_q(project_id)}/api-keys", json_body=_coerce_body(body)
        )
        return CreateApiKeyResponse.from_dict(_expect_object(payload, "API key"))

    async def revoke_api_key(self, project_id: str, key_id: str) -> None:
        """Async equivalent of :meth:`XbergClient.revoke_api_key`."""
        await self._require_tier("pro", "revoke_api_key")
        await self._request_json("DELETE", f"/v1/projects/{_q(project_id)}/api-keys/{_q(key_id)}")

    async def list_integrations(
        self,
        project_id: str,
        *,
        limit: int | None = None,
        offset: int | None = None,
    ) -> ListIntegrationsResponse:
        """Async equivalent of :meth:`XbergClient.list_integrations`."""
        await self._require_tier("pro", "list_integrations")
        payload = await self._request_json(
            "GET", f"/v1/projects/{_q(project_id)}/integrations", params=_pagination(limit, offset)
        )
        return ListIntegrationsResponse.from_dict(_expect_object(payload, "integration list"))

    async def create_integration(
        self,
        project_id: str,
        body: CreateIntegrationRequest | Mapping[str, Any],
    ) -> IntegrationResponse:
        """Async equivalent of :meth:`XbergClient.create_integration`."""
        await self._require_tier("pro", "create_integration")
        payload = await self._request_json(
            "POST", f"/v1/projects/{_q(project_id)}/integrations", json_body=_coerce_body(body)
        )
        return IntegrationResponse.from_dict(_expect_object(payload, "integration"))

    async def get_integration(self, project_id: str, integration_id: str) -> IntegrationResponse:
        """Async equivalent of :meth:`XbergClient.get_integration`."""
        await self._require_tier("pro", "get_integration")
        payload = await self._request_json("GET", f"/v1/projects/{_q(project_id)}/integrations/{_q(integration_id)}")
        return IntegrationResponse.from_dict(_expect_object(payload, "integration"))

    async def delete_integration(self, project_id: str, integration_id: str) -> None:
        """Async equivalent of :meth:`XbergClient.delete_integration`."""
        await self._require_tier("pro", "delete_integration")
        await self._request_json("DELETE", f"/v1/projects/{_q(project_id)}/integrations/{_q(integration_id)}")

    async def connect_integration(self, project_id: str, integration_id: str) -> BeginOAuthResponse:
        """Async equivalent of :meth:`XbergClient.connect_integration`."""
        await self._require_tier("pro", "connect_integration")
        payload = await self._request_json(
            "POST", f"/v1/projects/{_q(project_id)}/integrations/{_q(integration_id)}/connect"
        )
        return BeginOAuthResponse.from_dict(_expect_object(payload, "OAuth connect"))

    async def disconnect_integration(self, project_id: str, integration_id: str) -> None:
        """Async equivalent of :meth:`XbergClient.disconnect_integration`."""
        await self._require_tier("pro", "disconnect_integration")
        await self._request_json("POST", f"/v1/projects/{_q(project_id)}/integrations/{_q(integration_id)}/disconnect")

    async def list_integration_documents(
        self,
        project_id: str,
        integration_id: str,
        *,
        mime_types: str | None = None,
        folder_id: str | None = None,
        max_results: int | None = None,
    ) -> ListDocumentsResponse:
        """Async equivalent of :meth:`XbergClient.list_integration_documents`."""
        await self._require_tier("pro", "list_integration_documents")
        params = _query_params(mime_types=mime_types, folder_id=folder_id, max_results=max_results)
        payload = await self._request_json(
            "GET", f"/v1/projects/{_q(project_id)}/integrations/{_q(integration_id)}/documents", params=params
        )
        return ListDocumentsResponse.from_dict(_expect_object(payload, "integration document list"))

    async def fetch_integration_document(self, project_id: str, integration_id: str, document_id: str) -> bytes:
        """Async equivalent of :meth:`XbergClient.fetch_integration_document`."""
        await self._require_tier("pro", "fetch_integration_document")
        return await self._request_bytes(
            "GET", f"/v1/projects/{_q(project_id)}/integrations/{_q(integration_id)}/documents/{_q(document_id)}"
        )

    # -- Enterprise-only surface ------------------------------------------

    async def _request_control(self, method: str, path: str, **kwargs: Any) -> httpx.Response:
        known_tier = self._target or self._probed_tier
        if known_tier is not None:
            self._require_tier_or_raise(known_tier, "enterprise", "backend operation")
        return await self._request(method, path, control_plane=True, **kwargs)

    async def _request_control_json(self, method: str, path: str, **kwargs: Any) -> Any:
        response = await self._request_control(method, path, **kwargs)
        raise_for_status(response)
        return _backend_json(response)

    async def _request_control_bytes(self, method: str, path: str, **kwargs: Any) -> bytes:
        response = await self._request_control(method, path, **kwargs)
        raise_for_status(response)
        return response.content

    async def _request_control_none(self, method: str, path: str, **kwargs: Any) -> None:
        response = await self._request_control(method, path, **kwargs)
        raise_for_status(response)

    async def _request_control_redirect(self, method: str, path: str, **kwargs: Any) -> str:
        response = await self._request_control(method, path, **kwargs)
        if response.status_code != 303 or not response.headers.get("Location"):
            raise_for_status(response)
            raise XbergError("OAuth callback did not return a redirect location", status_code=response.status_code)
        return response.headers["Location"]

    async def delete_account(self) -> None:
        """Enterprise backend: Delete the authenticated user's account and all associated data (``DELETE /auth/account``)."""
        await self._request_control_none("DELETE", "/auth/account")

    async def get_auth_config(self) -> BackendAuthConfigResponse:
        """Enterprise backend: `GET /auth/config`: which auth methods this instance accepts. (``GET /auth/config``)."""
        payload = await self._request_control_json("GET", "/auth/config", public=True)
        return BackendAuthConfigResponse.from_dict(_expect_object(payload, "get_auth_config"))

    async def backend_login(self, body: BackendLoginRequest | Mapping[str, Any]) -> BackendLoginResponse:
        """Enterprise backend: Authenticate with an OIDC ID token and receive a backend JWT (``POST /auth/login``)."""
        payload = await self._request_control_json("POST", "/auth/login", json_body=_coerce_body(body), public=True)
        return BackendLoginResponse.from_dict(_expect_object(payload, "login"))

    async def healthz(self) -> BackendHealthResponse:
        """Enterprise backend: Liveness probe - returns 200 if the process is running (``GET /healthz``)."""
        payload = await self._request_control_json("GET", "/healthz", public=True)
        return BackendHealthResponse.from_dict(_expect_object(payload, "healthz"))

    async def readyz(self) -> BackendReadinessResponse:
        """Enterprise backend: Readiness probe - returns 200 if the service can handle traffic (``GET /readyz``)."""
        payload = await self._request_control_json("GET", "/readyz", public=True)
        return BackendReadinessResponse.from_dict(_expect_object(payload, "readyz"))

    async def accept_invitation(
        self, body: BackendAcceptInvitationRequest | Mapping[str, Any]
    ) -> BackendMemberResponse:
        """Enterprise backend: Accept an invitation using a token (``POST /v1/invitations/accept``)."""
        payload = await self._request_control_json("POST", "/v1/invitations/accept", json_body=_coerce_body(body))
        return BackendMemberResponse.from_dict(_expect_object(payload, "accept_invitation"))

    async def oauth_callback(self, *, code: str, state: str) -> str:
        """Enterprise backend: OAuth callback handler (``GET /v1/oauth/callback``)."""
        return await self._request_control_redirect(
            "GET", "/v1/oauth/callback", params=_query_params(code=code, state=state), public=True
        )

    async def backend_list_projects(
        self, *, limit: int | None = None, offset: int | None = None
    ) -> BackendListProjectsResponse:
        """Enterprise backend: List all projects for the authenticated user (``GET /v1/projects``)."""
        payload = await self._request_control_json(
            "GET", "/v1/projects", params=_query_params(limit=limit, offset=offset)
        )
        return BackendListProjectsResponse.from_dict(_expect_object(payload, "list_projects"))

    async def backend_create_project(
        self, body: BackendCreateProjectRequest | Mapping[str, Any]
    ) -> BackendProjectResponse:
        """Enterprise backend: Create a new project (``POST /v1/projects``)."""
        payload = await self._request_control_json("POST", "/v1/projects", json_body=_coerce_body(body))
        return BackendProjectResponse.from_dict(_expect_object(payload, "create_project"))

    async def get_project(self, project_id: str) -> BackendProjectResponse:
        """Enterprise backend: Get project details by ID (``GET /v1/projects/{id}``)."""
        payload = await self._request_control_json("GET", f"/v1/projects/{_q(project_id)}")
        return BackendProjectResponse.from_dict(_expect_object(payload, "get_project"))

    async def delete_project(self, project_id: str, *, erase: bool | None = None) -> None:
        """Enterprise backend: Delete a project (``DELETE /v1/projects/{id}``)."""
        await self._request_control_none("DELETE", f"/v1/projects/{_q(project_id)}", params=_query_params(erase=erase))

    async def update_project(
        self, project_id: str, body: BackendUpdateProjectRequest | Mapping[str, Any]
    ) -> BackendProjectResponse:
        """Enterprise backend: Update project details (``PATCH /v1/projects/{id}``)."""
        payload = await self._request_control_json(
            "PATCH", f"/v1/projects/{_q(project_id)}", json_body=_coerce_body(body)
        )
        return BackendProjectResponse.from_dict(_expect_object(payload, "update_project"))

    async def get_analytics(self, project_id: str, *, start_date: str, end_date: str) -> BackendAnalyticsResponse:
        """Enterprise backend: Get analytics data for a project within a date range (``GET /v1/projects/{id}/analytics``)."""
        payload = await self._request_control_json(
            "GET",
            f"/v1/projects/{_q(project_id)}/analytics",
            params=_query_params(start_date=start_date, end_date=end_date),
        )
        return BackendAnalyticsResponse.from_dict(_expect_object(payload, "get_analytics"))

    async def backend_list_api_keys(
        self, project_id: str, *, limit: int | None = None, offset: int | None = None
    ) -> BackendListApiKeysResponse:
        """Enterprise backend: List all API keys for a project (``GET /v1/projects/{id}/api-keys``)."""
        payload = await self._request_control_json(
            "GET", f"/v1/projects/{_q(project_id)}/api-keys", params=_query_params(limit=limit, offset=offset)
        )
        return BackendListApiKeysResponse.from_dict(_expect_object(payload, "list_api_keys"))

    async def backend_create_api_key(
        self, project_id: str, body: BackendCreateApiKeyRequest | Mapping[str, Any]
    ) -> BackendCreateApiKeyResponse:
        """Enterprise backend: Create a new API key for a project (``POST /v1/projects/{id}/api-keys``)."""
        payload = await self._request_control_json(
            "POST", f"/v1/projects/{_q(project_id)}/api-keys", json_body=_coerce_body(body)
        )
        return BackendCreateApiKeyResponse.from_dict(_expect_object(payload, "create_api_key"))

    async def backend_revoke_api_key(self, project_id: str, key_id: str) -> None:
        """Enterprise backend: Revoke an API key (``DELETE /v1/projects/{id}/api-keys/{key_id}``)."""
        await self._request_control_none("DELETE", f"/v1/projects/{_q(project_id)}/api-keys/{_q(key_id)}")

    async def regenerate_api_key(self, project_id: str, key_id: str) -> BackendCreateApiKeyResponse:
        """Enterprise backend: Regenerate an API key (``POST /v1/projects/{id}/api-keys/{key_id}/regenerate``)."""
        payload = await self._request_control_json(
            "POST", f"/v1/projects/{_q(project_id)}/api-keys/{_q(key_id)}/regenerate"
        )
        return BackendCreateApiKeyResponse.from_dict(_expect_object(payload, "regenerate_api_key"))

    async def list_project_audit(
        self, project_id: str, *, action: str | None = None, limit: int | None = None, offset: int | None = None
    ) -> BackendListAuditEntriesResponse:
        """Enterprise backend: List a project's audit events, most recent first. (``GET /v1/projects/{id}/audit``)."""
        payload = await self._request_control_json(
            "GET",
            f"/v1/projects/{_q(project_id)}/audit",
            params=_query_params(action=action, limit=limit, offset=offset),
        )
        return BackendListAuditEntriesResponse.from_dict(_expect_object(payload, "list_project_audit"))

    async def get_billing(self, project_id: str) -> BackendBillingResponse:
        """Enterprise backend: Get billing and quota information for a project (``GET /v1/projects/{id}/billing``)."""
        payload = await self._request_control_json("GET", f"/v1/projects/{_q(project_id)}/billing")
        return BackendBillingResponse.from_dict(_expect_object(payload, "get_billing"))

    async def create_checkout(self, project_id: str) -> BackendCheckoutResponse:
        """Enterprise backend: Create a Stripe Checkout Session for a project (``POST /v1/projects/{id}/billing/checkout``)."""
        payload = await self._request_control_json("POST", f"/v1/projects/{_q(project_id)}/billing/checkout")
        return BackendCheckoutResponse.from_dict(_expect_object(payload, "create_checkout"))

    async def create_portal(self, project_id: str) -> BackendPortalResponse:
        """Enterprise backend: Create a Stripe Customer Portal Session for a project (``POST /v1/projects/{id}/billing/portal``)."""
        payload = await self._request_control_json("POST", f"/v1/projects/{_q(project_id)}/billing/portal")
        return BackendPortalResponse.from_dict(_expect_object(payload, "create_portal"))

    async def backend_list_integrations(
        self, project_id: str, *, limit: int | None = None, offset: int | None = None
    ) -> BackendListIntegrationsResponse:
        """Enterprise backend: List all integrations for a project (``GET /v1/projects/{id}/integrations``)."""
        payload = await self._request_control_json(
            "GET", f"/v1/projects/{_q(project_id)}/integrations", params=_query_params(limit=limit, offset=offset)
        )
        return BackendListIntegrationsResponse.from_dict(_expect_object(payload, "list_integrations"))

    async def backend_create_integration(
        self, project_id: str, body: BackendCreateIntegrationRequest | Mapping[str, Any]
    ) -> BackendIntegrationResponse:
        """Enterprise backend: Create a new integration (``POST /v1/projects/{id}/integrations``)."""
        payload = await self._request_control_json(
            "POST", f"/v1/projects/{_q(project_id)}/integrations", json_body=_coerce_body(body)
        )
        return BackendIntegrationResponse.from_dict(_expect_object(payload, "create_integration"))

    async def backend_get_integration(self, project_id: str, integration_id: str) -> BackendIntegrationResponse:
        """Enterprise backend: Get a specific integration (``GET /v1/projects/{id}/integrations/{iid}``)."""
        payload = await self._request_control_json(
            "GET", f"/v1/projects/{_q(project_id)}/integrations/{_q(integration_id)}"
        )
        return BackendIntegrationResponse.from_dict(_expect_object(payload, "get_integration"))

    async def backend_delete_integration(self, project_id: str, integration_id: str) -> None:
        """Enterprise backend: Delete an integration (``DELETE /v1/projects/{id}/integrations/{iid}``)."""
        await self._request_control_none("DELETE", f"/v1/projects/{_q(project_id)}/integrations/{_q(integration_id)}")

    async def oauth_connect(self, project_id: str, integration_id: str) -> BackendBeginConnectResponse:
        """Enterprise backend: Begin an OAuth authorization flow for an integration (owner-gated). (``POST /v1/projects/{id}/integrations/{iid}/connect``)."""
        payload = await self._request_control_json(
            "POST", f"/v1/projects/{_q(project_id)}/integrations/{_q(integration_id)}/connect"
        )
        return BackendBeginConnectResponse.from_dict(_expect_object(payload, "oauth_connect"))

    async def backend_disconnect_integration(self, project_id: str, integration_id: str) -> None:
        """Enterprise backend: Disconnect an integration (revoke OAuth connection) (``POST /v1/projects/{id}/integrations/{iid}/disconnect``)."""
        await self._request_control_none(
            "POST", f"/v1/projects/{_q(project_id)}/integrations/{_q(integration_id)}/disconnect"
        )

    async def backend_list_integration_documents(
        self,
        project_id: str,
        integration_id: str,
        *,
        mime_types: str | None = None,
        folder_id: str | None = None,
        max_results: int | None = None,
    ) -> BackendListDocumentsResponse:
        """Enterprise backend: List documents in a connected integration (``GET /v1/projects/{id}/integrations/{iid}/documents``)."""
        payload = await self._request_control_json(
            "GET",
            f"/v1/projects/{_q(project_id)}/integrations/{_q(integration_id)}/documents",
            params=_query_params(mime_types=mime_types, folder_id=folder_id, max_results=max_results),
        )
        return BackendListDocumentsResponse.from_dict(_expect_object(payload, "list_integration_documents"))

    async def backend_fetch_integration_document(self, project_id: str, integration_id: str, document_id: str) -> bytes:
        """Enterprise backend: Fetch a single document from a connected integration (``GET /v1/projects/{id}/integrations/{iid}/documents/{doc_id}``)."""
        return await self._request_control_bytes(
            "GET", f"/v1/projects/{_q(project_id)}/integrations/{_q(integration_id)}/documents/{_q(document_id)}"
        )

    async def list_invitations(
        self, project_id: str, *, limit: int | None = None, offset: int | None = None
    ) -> BackendListInvitationsResponse:
        """Enterprise backend: List pending invitations for a project (``GET /v1/projects/{id}/invitations``)."""
        payload = await self._request_control_json(
            "GET", f"/v1/projects/{_q(project_id)}/invitations", params=_query_params(limit=limit, offset=offset)
        )
        return BackendListInvitationsResponse.from_dict(_expect_object(payload, "list_invitations"))

    async def invite_user(
        self, project_id: str, body: BackendCreateInvitationRequest | Mapping[str, Any]
    ) -> BackendCreateInvitationResponse:
        """Enterprise backend: Create a project invitation (sends token for email delivery by frontend) (``POST /v1/projects/{id}/invitations``)."""
        payload = await self._request_control_json(
            "POST", f"/v1/projects/{_q(project_id)}/invitations", json_body=_coerce_body(body)
        )
        return BackendCreateInvitationResponse.from_dict(_expect_object(payload, "invite_user"))

    async def revoke_invitation(self, project_id: str, invitation_id: str) -> None:
        """Enterprise backend: Revoke a pending invitation (``DELETE /v1/projects/{id}/invitations/{inv_id}``)."""
        await self._request_control_none("DELETE", f"/v1/projects/{_q(project_id)}/invitations/{_q(invitation_id)}")

    async def leave_project(self, project_id: str) -> None:
        """Enterprise backend: Self-service: caller leaves a project they belong to (``POST /v1/projects/{id}/leave``)."""
        await self._request_control_none("POST", f"/v1/projects/{_q(project_id)}/leave")

    async def list_members(
        self, project_id: str, *, limit: int | None = None, offset: int | None = None
    ) -> BackendListMembersResponse:
        """Enterprise backend: List all members of a project (``GET /v1/projects/{id}/members``)."""
        payload = await self._request_control_json(
            "GET", f"/v1/projects/{_q(project_id)}/members", params=_query_params(limit=limit, offset=offset)
        )
        return BackendListMembersResponse.from_dict(_expect_object(payload, "list_members"))

    async def remove_member(self, project_id: str, user_id: str) -> None:
        """Enterprise backend: Remove a member from a project (``DELETE /v1/projects/{id}/members/{user_id}``)."""
        await self._request_control_none("DELETE", f"/v1/projects/{_q(project_id)}/members/{_q(user_id)}")

    async def update_member_role(
        self, project_id: str, user_id: str, body: BackendUpdateMemberRoleRequest | Mapping[str, Any]
    ) -> BackendMemberResponse:
        """Enterprise backend: Update a member's role in a project (``PATCH /v1/projects/{id}/members/{user_id}``)."""
        payload = await self._request_control_json(
            "PATCH", f"/v1/projects/{_q(project_id)}/members/{_q(user_id)}", json_body=_coerce_body(body)
        )
        return BackendMemberResponse.from_dict(_expect_object(payload, "update_member_role"))

    async def backend_get_rag_config(self, project_id: str) -> BackendRagConfigResponse:
        """Enterprise backend: Read a project's RAG configuration. (``GET /v1/projects/{id}/rag-config``)."""
        payload = await self._request_control_json("GET", f"/v1/projects/{_q(project_id)}/rag-config")
        return BackendRagConfigResponse.from_dict(_expect_object(payload, "get_rag_config"))

    async def backend_set_rag_config(
        self, project_id: str, body: BackendSetRagConfigRequest | Mapping[str, Any]
    ) -> BackendRagConfigResponse:
        """Enterprise backend: Set a project's RAG configuration. (``PUT /v1/projects/{id}/rag-config``)."""
        payload = await self._request_control_json(
            "PUT", f"/v1/projects/{_q(project_id)}/rag-config", json_body=_coerce_body(body)
        )
        return BackendRagConfigResponse.from_dict(_expect_object(payload, "set_rag_config"))

    async def sandbox_extract(self, project_id: str, file: FileInput) -> BackendSandboxExtractResponse:
        """Enterprise backend: Extract a document in the sandbox (first page only) (``POST /v1/projects/{id}/sandbox/extract``)."""
        payload = await self._request_control_json(
            "POST", f"/v1/projects/{_q(project_id)}/sandbox/extract", files=_multipart_files([file])
        )
        return BackendSandboxExtractResponse.from_dict(_expect_object(payload, "sandbox_extract"))

    async def get_usage(self, project_id: str, *, start_date: str, end_date: str) -> BackendUsageResponse:
        """Enterprise backend: Get usage statistics for a project within a date range (``GET /v1/projects/{id}/usage``)."""
        payload = await self._request_control_json(
            "GET",
            f"/v1/projects/{_q(project_id)}/usage",
            params=_query_params(start_date=start_date, end_date=end_date),
        )
        return BackendUsageResponse.from_dict(_expect_object(payload, "get_usage"))

    async def list_webhooks(
        self, project_id: str, *, limit: int | None = None, offset: int | None = None
    ) -> BackendListWebhooksResponse:
        """Enterprise backend: List all webhooks for a project (``GET /v1/projects/{id}/webhooks``)."""
        payload = await self._request_control_json(
            "GET", f"/v1/projects/{_q(project_id)}/webhooks", params=_query_params(limit=limit, offset=offset)
        )
        return BackendListWebhooksResponse.from_dict(_expect_object(payload, "list_webhooks"))

    async def create_webhook(
        self, project_id: str, body: BackendCreateWebhookRequest | Mapping[str, Any]
    ) -> BackendWebhookResponse:
        """Enterprise backend: Create a new webhook for a project (``POST /v1/projects/{id}/webhooks``)."""
        payload = await self._request_control_json(
            "POST", f"/v1/projects/{_q(project_id)}/webhooks", json_body=_coerce_body(body)
        )
        return BackendWebhookResponse.from_dict(_expect_object(payload, "create_webhook"))

    async def delete_webhook(self, project_id: str, webhook_id: str) -> None:
        """Enterprise backend: Delete a webhook (``DELETE /v1/projects/{id}/webhooks/{wh_id}``)."""
        await self._request_control_none("DELETE", f"/v1/projects/{_q(project_id)}/webhooks/{_q(webhook_id)}")

    async def update_webhook(
        self, project_id: str, webhook_id: str, body: BackendUpdateWebhookRequest | Mapping[str, Any]
    ) -> BackendWebhookResponse:
        """Enterprise backend: Update a webhook's configuration (``PATCH /v1/projects/{id}/webhooks/{wh_id}``)."""
        payload = await self._request_control_json(
            "PATCH", f"/v1/projects/{_q(project_id)}/webhooks/{_q(webhook_id)}", json_body=_coerce_body(body)
        )
        return BackendWebhookResponse.from_dict(_expect_object(payload, "update_webhook"))

    async def list_webhook_deliveries(
        self, project_id: str, webhook_id: str, *, limit: int | None = None, offset: int | None = None
    ) -> BackendListWebhookDeliveriesResponse:
        """Enterprise backend: List delivery attempts recorded for a webhook. (``GET /v1/projects/{id}/webhooks/{wh_id}/deliveries``)."""
        payload = await self._request_control_json(
            "GET",
            f"/v1/projects/{_q(project_id)}/webhooks/{_q(webhook_id)}/deliveries",
            params=_query_params(limit=limit, offset=offset),
        )
        return BackendListWebhookDeliveriesResponse.from_dict(_expect_object(payload, "list_webhook_deliveries"))

    async def retry_webhook_delivery(
        self, project_id: str, webhook_id: str, delivery_id: str
    ) -> BackendRetryWebhookDeliveryResponse:
        """Enterprise backend: Manually retry one past delivery attempt. (``POST /v1/projects/{id}/webhooks/{wh_id}/deliveries/{delivery_id}/retry``)."""
        payload = await self._request_control_json(
            "POST", f"/v1/projects/{_q(project_id)}/webhooks/{_q(webhook_id)}/deliveries/{_q(delivery_id)}/retry"
        )
        return BackendRetryWebhookDeliveryResponse.from_dict(_expect_object(payload, "retry_webhook_delivery"))

    async def test_webhook(self, project_id: str, webhook_id: str) -> BackendWebhookTestResponse:
        """Enterprise backend: Send a test delivery to a webhook endpoint (``POST /v1/projects/{id}/webhooks/{wh_id}/test``)."""
        payload = await self._request_control_json(
            "POST", f"/v1/projects/{_q(project_id)}/webhooks/{_q(webhook_id)}/test"
        )
        return BackendWebhookTestResponse.from_dict(_expect_object(payload, "test_webhook"))

    async def public_sandbox_extract(
        self,
        *,
        file: FileInput | None = None,
        mode: str | None = None,
        preset: str | None = None,
        url: str | None = None,
        sandbox_token: str | None = None,
    ) -> BackendSandboxExtractResponse:
        """Extract in the public sandbox; pass its optional OIDC bearer as ``sandbox_token``."""
        payload = await self._request_control_json(
            "POST",
            "/v1/sandbox/public/extract",
            files=_public_sandbox_files(file, mode=mode, preset=preset, url=url),
            token=sandbox_token,
            public=True,
        )
        return BackendSandboxExtractResponse.from_dict(_expect_object(payload, "public_sandbox_extract"))

    async def versions(self, document_id: str) -> Any:
        """Enterprise only: async equivalent of :meth:`XbergClient.versions`."""
        await self._require_tier("enterprise", "versions")
        return await self._request_json("GET", f"/v1/documents/{_q(document_id)}/versions")

    async def diff(self, document_id: str, *, params: Mapping[str, Any] | None = None) -> Any:
        """Enterprise only: async equivalent of :meth:`XbergClient.diff`."""
        await self._require_tier("enterprise", "diff")
        return await self._request_json("GET", f"/v1/documents/{_q(document_id)}/diff", params=params)

    async def get_diff_job(self, document_id: str, diff_job_id: str) -> Any:
        """Enterprise only: async equivalent of :meth:`XbergClient.get_diff_job`."""
        await self._require_tier("enterprise", "get_diff_job")
        return await self._request_json("GET", f"/v1/documents/{_q(document_id)}/diff/{_q(diff_job_id)}")

    async def presign_upload(self, body: Mapping[str, Any]) -> Any:
        """Enterprise only: async equivalent of :meth:`XbergClient.presign_upload`."""
        await self._require_tier("enterprise", "presign_upload")
        return await self._request_json("POST", "/v1/uploads/presign", json_body=body)

    async def confirm_upload(self, body: Mapping[str, Any]) -> Any:
        """Enterprise only: async equivalent of :meth:`XbergClient.confirm_upload`."""
        await self._require_tier("enterprise", "confirm_upload")
        return await self._request_json("POST", "/v1/uploads/confirm", json_body=body)

    async def usage(self, *, params: Mapping[str, Any] | None = None) -> Any:
        """Enterprise only: async equivalent of :meth:`XbergClient.usage`."""
        await self._require_tier("enterprise", "usage")
        return await self._request_json("GET", "/v1/usage", params=params)

    async def get_document(self, document_id: str) -> Any:
        """Enterprise only: async equivalent of :meth:`XbergClient.get_document`."""
        await self._require_tier("enterprise", "get_document")
        return await self._request_json("GET", f"/v1/documents/{_q(document_id)}")

    async def get_job_page(self, job_id: str, page_number: int) -> bytes:
        """Enterprise only: async equivalent of :meth:`XbergClient.get_job_page`."""
        await self._require_tier("enterprise", "get_job_page")
        return await self._request_bytes("GET", f"/v1/jobs/{_q(job_id)}/pages/{_q(page_number)}")

    async def list_extraction_events(
        self,
        *,
        days: int | None = None,
        limit: int | None = None,
        offset: int | None = None,
    ) -> ListExtractionEventsResponse:
        """Enterprise only: async equivalent of :meth:`XbergClient.list_extraction_events`."""
        await self._require_tier("enterprise", "list_extraction_events")
        params = _query_params(days=days, limit=limit, offset=offset)
        payload = await self._request_json("GET", _EXTRACTIONS_PATH, params=params)
        return ListExtractionEventsResponse.from_dict(_expect_object(payload, "extraction event list"))

    async def submit_enrich(self, body: EnrichTextRequest | Mapping[str, Any]) -> EnrichJobSubmitted:
        """Enterprise only: async equivalent of :meth:`XbergClient.submit_enrich`."""
        await self._require_tier("enterprise", "submit_enrich")
        payload = await self._request_json("POST", _ENRICH_PATH, json_body=_coerce_body(body))
        return EnrichJobSubmitted.from_dict(_expect_object(payload, "enrich submission"))

    async def get_enrich_status(self, job_id: str) -> EnrichJobStatus:
        """Enterprise only: async equivalent of :meth:`XbergClient.get_enrich_status`."""
        await self._require_tier("enterprise", "get_enrich_status")
        return _parse_enrich_status(await self._request_json("GET", f"{_ENRICH_PATH}/{_q(job_id)}"))

    async def stream_crawl_events(self, crawl_job_id: str) -> AsyncIterator[CrawlEvent]:
        """Enterprise only: async equivalent of :meth:`XbergClient.stream_crawl_events`.

        An async generator: consume it with ``async for``. Same guarantees as
        the sync form -- nothing is requested until iteration begins, and the
        response body is closed when iteration ends however it ends.
        """
        await self._require_tier("enterprise", "stream_crawl_events")
        decoder = _SSEDecoder()
        path = f"/v1/crawl-jobs/{_q(crawl_job_id)}/events"
        async with self._request_stream("GET", path, accept=_SSE_ACCEPT) as response:
            async for chunk in response.aiter_bytes():
                for payload in decoder.feed_bytes(chunk):
                    yield _parse_crawl_event(payload)


__all__ = [
    "AsyncXbergClient",
    "BackoffStrategy",
    "BodyInput",
    "CrawlEvent",
    "EnrichJobStatus",
    "FileInput",
    "OptionsInput",
    "Target",
    "XbergClient",
]
