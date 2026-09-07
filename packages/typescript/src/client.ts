/**
 * High-level dual-target client for the Xberg Enterprise and Xberg Pro HTTP APIs.
 *
 * One {@link XbergClient} speaks to either product. The shared surface —
 * extraction, jobs (including job results), audit, curated presets, and the RAG
 * API — is written once and carries no tier gate. Tier-specific methods are
 * capability-gated: they probe the connected instance (`GET /healthz`'s `tier`,
 * or an explicit `target`) and throw a clear error instead of a raw 404 when
 * invoked against the wrong tier.
 *
 * Both products authenticate identically: `Authorization: Bearer {apiKey}`.
 * Enterprise defaults `baseUrl` to `https://api.xberg.io`; Pro has no default
 * (its spec ships no servers block) and requires an explicit one.
 *
 * Enterprise splits into two binaries — the data plane `baseUrl` addresses and a
 * control plane (projects, API keys, integrations) on its own origin — while Pro
 * serves both from one. `controlPlaneBaseUrl` records the origin of the second
 * and defaults to `baseUrl`. The backend methods use that origin and an optional
 * separate `controlPlaneToken`; existing Pro methods retain their data-plane routing.
 */

import createOpenApiClient, { type Client } from "openapi-fetch";
import type { paths } from "./_generated/api.js";
import {
  DEFAULT_BACKOFF_FACTOR,
  DEFAULT_ENTERPRISE_BASE_URL,
  DEFAULT_RETRY_BACKOFF_CAP_MS,
  EventStreamDecoder,
  encodePathSegment,
  buildQueryString,
  defaultSleep,
  describeFile,
  nextBackoffInterval,
  parseRetryAfterHeader,
  resolveBaseUrl,
  resolveControlPlaneBaseUrl,
  toBlob,
} from "./_internal.js";
import type { BackoffStrategy, FileLike, QueryParams, Target } from "./_internal.js";
import { RateLimitError, TimeoutError, XbergError, raiseForStatus } from "./errors.js";
import type {
  AuthConfigResponse,
  BackendAcceptInvitationRequest,
  BackendAnalyticsResponse,
  BackendAuthConfigResponse,
  BackendBeginConnectResponse,
  BackendBillingResponse,
  BackendCheckoutResponse,
  BackendCreateApiKeyRequest,
  BackendCreateApiKeyResponse,
  BackendCreateIntegrationRequest,
  BackendCreateInvitationRequest,
  BackendCreateInvitationResponse,
  BackendCreateProjectRequest,
  BackendCreateWebhookRequest,
  BackendHealthResponse,
  BackendIntegrationResponse,
  BackendListApiKeysResponse,
  BackendListAuditEntriesResponse,
  BackendListDocumentsResponse,
  BackendListIntegrationsResponse,
  BackendListInvitationsResponse,
  BackendListMembersResponse,
  BackendListProjectsResponse,
  BackendListWebhookDeliveriesResponse,
  BackendListWebhooksResponse,
  BackendLoginRequest,
  BackendLoginResponse,
  BackendMemberResponse,
  BackendPortalResponse,
  BackendProjectResponse,
  BackendRagConfigResponse,
  BackendReadinessResponse,
  BackendRetryWebhookDeliveryResponse,
  BackendSandboxExtractResponse,
  BackendSetRagConfigRequest,
  BackendUpdateMemberRoleRequest,
  BackendUpdateProjectRequest,
  BackendUpdateWebhookRequest,
  BackendUsageResponse,
  BackendWebhookResponse,
  BackendWebhookTestResponse,
  AutoTuneCapabilitiesResponse,
  AutoTuneJobStatus,
  AutoTuneResult,
  BeginOAuthResponse,
  ConfirmUploadRequest,
  ConfirmUploadResponse,
  CrawlEvent,
  CreateApiKeyRequest,
  CreateApiKeyResponse,
  CreateAutoTuneJobRequest,
  CreateAutoTuneJobResponse,
  CreateIntegrationRequest,
  CreateProjectRequest,
  CreateSavedPresetRequest,
  CreateSavedPresetResponse,
  DiffAsyncAccepted,
  DiffResponse,
  DiffResult,
  DocumentVersionEntry,
  EnrichJobStatus,
  EnrichJobSubmitted,
  EnrichTextRequest,
  ExtractResponse,
  ExtractionOptions,
  FileExtractionConfig,
  IntegrationResponse,
  Job,
  JobResult,
  ListApiKeysResponse,
  ListAuditEntriesResponse,
  ListAutoTuneJobsResponse,
  ListDocumentsResponse,
  ListExtractionEventsResponse,
  ListIntegrationsResponse,
  ListJobsResponse,
  ListProjectsResponse,
  ListSavedPresetsResponse,
  ListTuningProfilesResponse,
  LoginRequest,
  LoginResponse,
  PresetDetail,
  PresetSummary,
  PresignUploadRequest,
  PresignUploadResponse,
  ProjectResponse,
  PromoteProfileRequest,
  RagConfigResponse,
  SavedPresetDetail,
  SetRagConfigRequest,
  TuningProfileDetail,
  UpdateSavedPresetRequest,
  UpdateSavedPresetResponse,
  UsageResponse,
  WebhookConfig,
} from "./types.js";
import { SUCCESS_JOB_STATUSES, TERMINAL_JOB_STATUSES } from "./types.js";
import { VERSION } from "./version.js";

/**
 * Public types that live in the internal helper module because the helpers
 * there operate on them; re-exported so `./client.js` stays their import site.
 */
export type { BackoffStrategy, FileLike, Target } from "./_internal.js";

const USER_AGENT = `xberg-io-sdk-typescript/${VERSION}`;
const DEFAULT_TIMEOUT_MS = 30_000;
const DEFAULT_POLL_INTERVAL_MS = 1_000;
const DEFAULT_WAIT_TIMEOUT_MS = 5 * 60_000;
const DEFAULT_RETRY_STATUSES: readonly number[] = [429, 502, 503, 504];
const DEFAULT_RETRY_BACKOFF_BASE_MS = 200;

/**
 * Saved presets are the one shared resource whose *path* differs per tier:
 * Enterprise serves `/v1/saved_presets` (underscore), Pro `/v1/saved-presets`
 * (hyphen). The request and response schemas are identical.
 */
const SAVED_PRESETS_PATH_ENTERPRISE = "/v1/saved_presets";
const SAVED_PRESETS_PATH_PRO = "/v1/saved-presets";
const AUTO_TUNE_PATH = "/v1/auto-tune";
const TUNING_PROFILES_PATH = "/v1/tuning-profiles";
const ENRICH_PATH = "/v1/enrich";
const EXTRACTIONS_PATH = "/v1/extractions";
const DOCUMENTS_PATH = "/v1/documents";
const JOBS_PATH = "/v1/jobs";
const CRAWL_JOBS_PATH = "/v1/crawl-jobs";

/** Media type of the crawl-event stream, sent as `Accept` and served as `Content-Type`. */
const EVENT_STREAM_MEDIA_TYPE = "text/event-stream";

/** The `kind` values `CrawlEventV1` declares. A frame carrying anything else is rejected. */
const CRAWL_EVENT_KINDS: ReadonlySet<string> = new Set(["page", "discovered", "complete", "error"]);

export interface XbergClientOptions {
  apiKey?: string;
  baseUrl?: string;
  /**
   * Origin of the Enterprise control plane, which runs as a second binary
   * alongside the data plane. Defaults to `baseUrl` — Pro serves both planes
   * from one binary, so every Pro call keeps working untouched.
   *
   */
  controlPlaneBaseUrl?: string;
  /** Bearer token for protected backend calls; defaults to `apiKey`. */
  controlPlaneToken?: string;
  /** Product for tier-specific data-plane methods; discovered lazily when omitted. */
  target?: Target;
  fetch?: typeof fetch;
  headers?: Record<string, string>;
  timeoutMs?: number;
  retries?: number;
  retryOn?: readonly number[];
  retryBackoff?: BackoffStrategy;
  /** Sleep helper, swappable in tests. Defaults to `setTimeout`. */
  sleep?: (ms: number) => Promise<void>;
}

export interface ExtractParams {
  file: FileLike;
  options?: ExtractionOptions;
  webhook?: WebhookConfig;
  /**
   * Per-file extraction override for this document, sent as the
   * `config-<filename>` part. The server resolves it against
   * `options.extraction_config`, any preset and the project default.
   */
  config?: FileExtractionConfig;
}

export interface ExtractBatchParams {
  files: readonly FileLike[];
  options?: ExtractionOptions;
  webhook?: WebhookConfig;
  /**
   * One optional per-file override per entry of `files`, in the same order —
   * `null` for no override. Must be the same length as `files` when given.
   *
   * The override travels as a `config-<filename>` part, so two documents sharing
   * a filename cannot carry different overrides; that combination throws rather
   * than dropping one silently.
   */
  configs?: readonly (FileExtractionConfig | null)[];
}

export interface WaitOptions {
  /** Total time to wait before throwing TimeoutError. Default 5 minutes. */
  timeoutMs?: number;
  /** Initial poll interval. Default 1000ms. */
  pollIntervalMs?: number;
  /** `exponential` doubles the interval each cycle (capped). Default exponential. */
  backoff?: BackoffStrategy;
}

export interface ExtractAndWaitParams extends ExtractParams, WaitOptions {}

export interface ListJobsParams {
  limit?: number;
  offset?: number;
}

export interface AuditParams {
  action?: string;
  limit?: number;
  offset?: number;
}

/** Offset pagination accepted by the paginated list endpoints. */
export interface PaginationParams {
  limit?: number;
  offset?: number;
}

/** Filters accepted by `listExtractionEvents`. */
export interface ListExtractionEventsParams extends PaginationParams {
  /** How many days to look back. Defaults to 30 server-side, clamped to 1..=365. */
  days?: number;
}

/** The two multipart parts `submitAutoTune` sends. */
export interface SubmitAutoTuneParams {
  /** JSON-encoded into the required `request` part. */
  request: CreateAutoTuneJobRequest;
  /** One binary `file` part per document referenced by `request.documents[].filename`. */
  files: readonly FileLike[];
}

/** Options accepted by `streamCrawlEvents`. */
export interface StreamCrawlEventsOptions {
  /**
   * Aborts the stream from outside the loop. Breaking out of the `for await`
   * already closes the response body, so this is only needed to hang up from
   * somewhere else — a React effect teardown, a shutdown handler.
   */
  signal?: AbortSignal;
}

/** Filters accepted by `listIntegrationDocuments`. */
export interface ListIntegrationDocumentsParams {
  /** Comma-separated MIME types to restrict the listing to. */
  mimeTypes?: string;
  /** Source-specific folder to list instead of the connection root. */
  folderId?: string;
  /** Upper bound on the number of documents returned. */
  maxResults?: number;
}

export interface BackendDateRange {
  startDate: string;
  endDate: string;
}
export interface BackendOAuthCallbackParams {
  code: string;
  state: string;
}
export interface BackendAuditParams {
  action?: string;
  limit?: number;
  offset?: number;
}
export interface BackendSandboxExtractParams {
  file: FileLike;
}
export interface PublicSandboxExtractParams {
  file?: FileLike;
  mode?: string;
  preset?: string;
  url?: string;
  sandboxToken?: string;
}

/** Underlying `openapi-fetch` client, typed over the Enterprise API schema. */
export type XbergRawClient = Client<paths>;

/**
 * High-level dual-target client. Construct with `new XbergClient({ apiKey })`.
 */
export class XbergClient {
  private readonly baseUrl: string;
  /**
   * Origin used by the Enterprise backend methods. Defaults to `baseUrl`.
   */
  public readonly controlPlaneBaseUrl: string;
  private readonly controlPlaneToken: string | undefined;
  private readonly headers: Record<string, string>;
  private readonly fetchImpl: typeof fetch;
  private readonly timeoutMs: number;
  private readonly retries: number;
  private readonly retryOn: readonly number[];
  private readonly retryBackoff: BackoffStrategy;
  private readonly sleep: (ms: number) => Promise<void>;
  private readonly target?: Target;
  private probedTier: Target | undefined;
  /** In-flight `/healthz` probe, memoised so concurrent callers share one request (single-flight). */
  private tierProbe: Promise<Target> | undefined;
  /** Underlying `openapi-fetch` client — exposed for advanced use. */
  public readonly raw: XbergRawClient;

  public constructor(options: XbergClientOptions = {}) {
    if (options.target !== undefined) {
      this.target = options.target;
    }
    this.baseUrl = resolveBaseUrl(options.baseUrl, options.target);
    this.controlPlaneBaseUrl = resolveControlPlaneBaseUrl(options.controlPlaneBaseUrl, this.baseUrl);
    this.controlPlaneToken = options.controlPlaneToken ?? options.apiKey;
    this.fetchImpl = options.fetch ?? fetch;
    this.timeoutMs = options.timeoutMs ?? DEFAULT_TIMEOUT_MS;
    this.retries = options.retries ?? 0;
    this.retryOn = options.retryOn ?? DEFAULT_RETRY_STATUSES;
    this.retryBackoff = options.retryBackoff ?? "exponential";
    this.sleep = options.sleep ?? defaultSleep;

    this.headers = {
      "User-Agent": USER_AGENT,
      ...options.headers,
    };
    if (options.apiKey !== undefined) {
      this.headers["Authorization"] = `Bearer ${options.apiKey}`;
    }

    this.raw = createOpenApiClient<paths>({
      baseUrl: this.baseUrl,
      headers: this.headers,
      fetch: this.fetchImpl,
    });
  }

  /** Enterprise backend `DELETE /auth/account`. */
  public async deleteAccount(): Promise<void> {
    return await this.backendRequest<void>("DELETE", `/auth/account`);
  }
  /** Enterprise backend `GET /auth/config`. */
  public async getAuthConfig(): Promise<BackendAuthConfigResponse> {
    return await this.backendRequest<BackendAuthConfigResponse>("GET", `/auth/config`, { backendPublic: true });
  }
  /** Enterprise backend `POST /auth/login`. */
  public async backendLogin(body: BackendLoginRequest): Promise<BackendLoginResponse> {
    return await this.backendRequest<BackendLoginResponse>("POST", `/auth/login`, { json: body, backendPublic: true });
  }
  /** Enterprise backend `GET /healthz`. */
  public async healthz(): Promise<BackendHealthResponse> {
    return await this.backendRequest<BackendHealthResponse>("GET", `/healthz`, { backendPublic: true });
  }
  /** Enterprise backend `GET /readyz`. */
  public async readyz(): Promise<BackendReadinessResponse> {
    return await this.backendRequest<BackendReadinessResponse>("GET", `/readyz`, { backendPublic: true });
  }
  /** Enterprise backend `POST /v1/invitations/accept`. */
  public async acceptInvitation(body: BackendAcceptInvitationRequest): Promise<BackendMemberResponse> {
    return await this.backendRequest<BackendMemberResponse>("POST", `/v1/invitations/accept`, { json: body });
  }
  /** Enterprise backend `GET /v1/oauth/callback`. */
  public async oauthCallback(params: BackendOAuthCallbackParams): Promise<string> {
    const response = await this.requestWithRetry("GET", "/v1/oauth/callback", {
      controlPlane: true,
      backendPublic: true,
      acceptRedirect: true,
      params: { code: params.code, state: params.state },
    });
    const location = response.headers.get("location");
    await response.body?.cancel();
    if (response.status !== 303 || location === null || location.length === 0) {
      throw new XbergError("OAuth callback did not return a 303 Location", { status: response.status, body: null });
    }
    return location;
  }
  /** Enterprise backend `GET /v1/projects`. */
  public async backendListProjects(params: PaginationParams = {}): Promise<BackendListProjectsResponse> {
    return await this.backendRequest<BackendListProjectsResponse>("GET", `/v1/projects`, {
      params: { limit: params.limit, offset: params.offset },
    });
  }
  /** Enterprise backend `POST /v1/projects`. */
  public async backendCreateProject(body: BackendCreateProjectRequest): Promise<BackendProjectResponse> {
    return await this.backendRequest<BackendProjectResponse>("POST", `/v1/projects`, { json: body });
  }
  /** Enterprise backend `GET /v1/projects/{id}`. */
  public async getProject(projectId: string): Promise<BackendProjectResponse> {
    return await this.backendRequest<BackendProjectResponse>("GET", `/v1/projects/${encodePathSegment(projectId)}`);
  }
  /** Enterprise backend `DELETE /v1/projects/{id}`. */
  public async deleteProject(projectId: string, params: { erase?: boolean } = {}): Promise<void> {
    return await this.backendRequest<void>("DELETE", `/v1/projects/${encodePathSegment(projectId)}`, {
      params: { erase: params.erase === undefined ? undefined : String(params.erase) },
    });
  }
  /** Enterprise backend `PATCH /v1/projects/{id}`. */
  public async updateProject(projectId: string, body: BackendUpdateProjectRequest): Promise<BackendProjectResponse> {
    return await this.backendRequest<BackendProjectResponse>("PATCH", `/v1/projects/${encodePathSegment(projectId)}`, {
      json: body,
    });
  }
  /** Enterprise backend `GET /v1/projects/{id}/analytics`. */
  public async getAnalytics(projectId: string, params: BackendDateRange): Promise<BackendAnalyticsResponse> {
    return await this.backendRequest<BackendAnalyticsResponse>(
      "GET",
      `/v1/projects/${encodePathSegment(projectId)}/analytics`,
      { params: { start_date: params.startDate, end_date: params.endDate } },
    );
  }
  /** Enterprise backend `GET /v1/projects/{id}/api-keys`. */
  public async backendListApiKeys(
    projectId: string,
    params: PaginationParams = {},
  ): Promise<BackendListApiKeysResponse> {
    return await this.backendRequest<BackendListApiKeysResponse>(
      "GET",
      `/v1/projects/${encodePathSegment(projectId)}/api-keys`,
      { params: { limit: params.limit, offset: params.offset } },
    );
  }
  /** Enterprise backend `POST /v1/projects/{id}/api-keys`. */
  public async backendCreateApiKey(
    projectId: string,
    body: BackendCreateApiKeyRequest,
  ): Promise<BackendCreateApiKeyResponse> {
    return await this.backendRequest<BackendCreateApiKeyResponse>(
      "POST",
      `/v1/projects/${encodePathSegment(projectId)}/api-keys`,
      { json: body },
    );
  }
  /** Enterprise backend `DELETE /v1/projects/{id}/api-keys/{key_id}`. */
  public async backendRevokeApiKey(projectId: string, apiKeyId: string): Promise<void> {
    return await this.backendRequest<void>(
      "DELETE",
      `/v1/projects/${encodePathSegment(projectId)}/api-keys/${encodePathSegment(apiKeyId)}`,
    );
  }
  /** Enterprise backend `POST /v1/projects/{id}/api-keys/{key_id}/regenerate`. */
  public async regenerateApiKey(projectId: string, apiKeyId: string): Promise<BackendCreateApiKeyResponse> {
    return await this.backendRequest<BackendCreateApiKeyResponse>(
      "POST",
      `/v1/projects/${encodePathSegment(projectId)}/api-keys/${encodePathSegment(apiKeyId)}/regenerate`,
    );
  }
  /** Enterprise backend `GET /v1/projects/{id}/audit`. */
  public async listProjectAudit(
    projectId: string,
    params: BackendAuditParams = {},
  ): Promise<BackendListAuditEntriesResponse> {
    return await this.backendRequest<BackendListAuditEntriesResponse>(
      "GET",
      `/v1/projects/${encodePathSegment(projectId)}/audit`,
      { params: { action: params.action, limit: params.limit, offset: params.offset } },
    );
  }
  /** Enterprise backend `GET /v1/projects/{id}/billing`. */
  public async getBilling(projectId: string): Promise<BackendBillingResponse> {
    return await this.backendRequest<BackendBillingResponse>(
      "GET",
      `/v1/projects/${encodePathSegment(projectId)}/billing`,
    );
  }
  /** Enterprise backend `POST /v1/projects/{id}/billing/checkout`. */
  public async createCheckout(projectId: string): Promise<BackendCheckoutResponse> {
    return await this.backendRequest<BackendCheckoutResponse>(
      "POST",
      `/v1/projects/${encodePathSegment(projectId)}/billing/checkout`,
    );
  }
  /** Enterprise backend `POST /v1/projects/{id}/billing/portal`. */
  public async createPortal(projectId: string): Promise<BackendPortalResponse> {
    return await this.backendRequest<BackendPortalResponse>(
      "POST",
      `/v1/projects/${encodePathSegment(projectId)}/billing/portal`,
    );
  }
  /** Enterprise backend `GET /v1/projects/{id}/integrations`. */
  public async backendListIntegrations(
    projectId: string,
    params: PaginationParams = {},
  ): Promise<BackendListIntegrationsResponse> {
    return await this.backendRequest<BackendListIntegrationsResponse>(
      "GET",
      `/v1/projects/${encodePathSegment(projectId)}/integrations`,
      { params: { limit: params.limit, offset: params.offset } },
    );
  }
  /** Enterprise backend `POST /v1/projects/{id}/integrations`. */
  public async backendCreateIntegration(
    projectId: string,
    body: BackendCreateIntegrationRequest,
  ): Promise<BackendIntegrationResponse> {
    return await this.backendRequest<BackendIntegrationResponse>(
      "POST",
      `/v1/projects/${encodePathSegment(projectId)}/integrations`,
      { json: body },
    );
  }
  /** Enterprise backend `GET /v1/projects/{id}/integrations/{iid}`. */
  public async backendGetIntegration(projectId: string, integrationId: string): Promise<BackendIntegrationResponse> {
    return await this.backendRequest<BackendIntegrationResponse>(
      "GET",
      `/v1/projects/${encodePathSegment(projectId)}/integrations/${encodePathSegment(integrationId)}`,
    );
  }
  /** Enterprise backend `DELETE /v1/projects/{id}/integrations/{iid}`. */
  public async backendDeleteIntegration(projectId: string, integrationId: string): Promise<void> {
    return await this.backendRequest<void>(
      "DELETE",
      `/v1/projects/${encodePathSegment(projectId)}/integrations/${encodePathSegment(integrationId)}`,
    );
  }
  /** Enterprise backend `POST /v1/projects/{id}/integrations/{iid}/connect`. */
  public async oauthConnect(projectId: string, integrationId: string): Promise<BackendBeginConnectResponse> {
    return await this.backendRequest<BackendBeginConnectResponse>(
      "POST",
      `/v1/projects/${encodePathSegment(projectId)}/integrations/${encodePathSegment(integrationId)}/connect`,
    );
  }
  /** Enterprise backend `POST /v1/projects/{id}/integrations/{iid}/disconnect`. */
  public async backendDisconnectIntegration(projectId: string, integrationId: string): Promise<void> {
    return await this.backendRequest<void>(
      "POST",
      `/v1/projects/${encodePathSegment(projectId)}/integrations/${encodePathSegment(integrationId)}/disconnect`,
    );
  }
  /** Enterprise backend `GET /v1/projects/{id}/integrations/{iid}/documents`. */
  public async backendListIntegrationDocuments(
    projectId: string,
    integrationId: string,
    params: ListIntegrationDocumentsParams = {},
  ): Promise<BackendListDocumentsResponse> {
    return await this.backendRequest<BackendListDocumentsResponse>(
      "GET",
      `/v1/projects/${encodePathSegment(projectId)}/integrations/${encodePathSegment(integrationId)}/documents`,
      { params: { mime_types: params.mimeTypes, folder_id: params.folderId, max_results: params.maxResults } },
    );
  }
  /** Enterprise backend `GET /v1/projects/{id}/integrations/{iid}/documents/{doc_id}`. */
  public async backendFetchIntegrationDocument(
    projectId: string,
    integrationId: string,
    documentId: string,
  ): Promise<Uint8Array> {
    return await this.requestBytes(
      "GET",
      `/v1/projects/${encodePathSegment(projectId)}/integrations/${encodePathSegment(integrationId)}/documents/${encodePathSegment(documentId)}`,
      { controlPlane: true },
    );
  }
  /** Enterprise backend `GET /v1/projects/{id}/invitations`. */
  public async listInvitations(
    projectId: string,
    params: PaginationParams = {},
  ): Promise<BackendListInvitationsResponse> {
    return await this.backendRequest<BackendListInvitationsResponse>(
      "GET",
      `/v1/projects/${encodePathSegment(projectId)}/invitations`,
      { params: { limit: params.limit, offset: params.offset } },
    );
  }
  /** Enterprise backend `POST /v1/projects/{id}/invitations`. */
  public async inviteUser(
    projectId: string,
    body: BackendCreateInvitationRequest,
  ): Promise<BackendCreateInvitationResponse> {
    return await this.backendRequest<BackendCreateInvitationResponse>(
      "POST",
      `/v1/projects/${encodePathSegment(projectId)}/invitations`,
      { json: body },
    );
  }
  /** Enterprise backend `DELETE /v1/projects/{id}/invitations/{inv_id}`. */
  public async revokeInvitation(projectId: string, invitationId: string): Promise<void> {
    return await this.backendRequest<void>(
      "DELETE",
      `/v1/projects/${encodePathSegment(projectId)}/invitations/${encodePathSegment(invitationId)}`,
    );
  }
  /** Enterprise backend `POST /v1/projects/{id}/leave`. */
  public async leaveProject(projectId: string): Promise<void> {
    return await this.backendRequest<void>("POST", `/v1/projects/${encodePathSegment(projectId)}/leave`);
  }
  /** Enterprise backend `GET /v1/projects/{id}/members`. */
  public async listMembers(projectId: string, params: PaginationParams = {}): Promise<BackendListMembersResponse> {
    return await this.backendRequest<BackendListMembersResponse>(
      "GET",
      `/v1/projects/${encodePathSegment(projectId)}/members`,
      { params: { limit: params.limit, offset: params.offset } },
    );
  }
  /** Enterprise backend `DELETE /v1/projects/{id}/members/{user_id}`. */
  public async removeMember(projectId: string, userId: string): Promise<void> {
    return await this.backendRequest<void>(
      "DELETE",
      `/v1/projects/${encodePathSegment(projectId)}/members/${encodePathSegment(userId)}`,
    );
  }
  /** Enterprise backend `PATCH /v1/projects/{id}/members/{user_id}`. */
  public async updateMemberRole(
    projectId: string,
    userId: string,
    body: BackendUpdateMemberRoleRequest,
  ): Promise<BackendMemberResponse> {
    return await this.backendRequest<BackendMemberResponse>(
      "PATCH",
      `/v1/projects/${encodePathSegment(projectId)}/members/${encodePathSegment(userId)}`,
      { json: body },
    );
  }
  /** Enterprise backend `GET /v1/projects/{id}/rag-config`. */
  public async backendGetRagConfig(projectId: string): Promise<BackendRagConfigResponse> {
    return await this.backendRequest<BackendRagConfigResponse>(
      "GET",
      `/v1/projects/${encodePathSegment(projectId)}/rag-config`,
    );
  }
  /** Enterprise backend `PUT /v1/projects/{id}/rag-config`. */
  public async backendSetRagConfig(
    projectId: string,
    body: BackendSetRagConfigRequest,
  ): Promise<BackendRagConfigResponse> {
    return await this.backendRequest<BackendRagConfigResponse>(
      "PUT",
      `/v1/projects/${encodePathSegment(projectId)}/rag-config`,
      { json: body },
    );
  }
  /** Enterprise backend `POST /v1/projects/{id}/sandbox/extract`. */
  public async sandboxExtract(
    projectId: string,
    params: BackendSandboxExtractParams,
  ): Promise<BackendSandboxExtractResponse> {
    return await this.backendRequest<BackendSandboxExtractResponse>(
      "POST",
      `/v1/projects/${encodePathSegment(projectId)}/sandbox/extract`,
      { body: sandboxForm(params) },
    );
  }
  /** Enterprise backend `GET /v1/projects/{id}/usage`. */
  public async getUsage(projectId: string, params: BackendDateRange): Promise<BackendUsageResponse> {
    return await this.backendRequest<BackendUsageResponse>(
      "GET",
      `/v1/projects/${encodePathSegment(projectId)}/usage`,
      { params: { start_date: params.startDate, end_date: params.endDate } },
    );
  }
  /** Enterprise backend `GET /v1/projects/{id}/webhooks`. */
  public async listWebhooks(projectId: string, params: PaginationParams = {}): Promise<BackendListWebhooksResponse> {
    return await this.backendRequest<BackendListWebhooksResponse>(
      "GET",
      `/v1/projects/${encodePathSegment(projectId)}/webhooks`,
      { params: { limit: params.limit, offset: params.offset } },
    );
  }
  /** Enterprise backend `POST /v1/projects/{id}/webhooks`. */
  public async createWebhook(projectId: string, body: BackendCreateWebhookRequest): Promise<BackendWebhookResponse> {
    return await this.backendRequest<BackendWebhookResponse>(
      "POST",
      `/v1/projects/${encodePathSegment(projectId)}/webhooks`,
      { json: body },
    );
  }
  /** Enterprise backend `DELETE /v1/projects/{id}/webhooks/{wh_id}`. */
  public async deleteWebhook(projectId: string, webhookId: string): Promise<void> {
    return await this.backendRequest<void>(
      "DELETE",
      `/v1/projects/${encodePathSegment(projectId)}/webhooks/${encodePathSegment(webhookId)}`,
    );
  }
  /** Enterprise backend `PATCH /v1/projects/{id}/webhooks/{wh_id}`. */
  public async updateWebhook(
    projectId: string,
    webhookId: string,
    body: BackendUpdateWebhookRequest,
  ): Promise<BackendWebhookResponse> {
    return await this.backendRequest<BackendWebhookResponse>(
      "PATCH",
      `/v1/projects/${encodePathSegment(projectId)}/webhooks/${encodePathSegment(webhookId)}`,
      { json: body },
    );
  }
  /** Enterprise backend `GET /v1/projects/{id}/webhooks/{wh_id}/deliveries`. */
  public async listWebhookDeliveries(
    projectId: string,
    webhookId: string,
    params: PaginationParams = {},
  ): Promise<BackendListWebhookDeliveriesResponse> {
    return await this.backendRequest<BackendListWebhookDeliveriesResponse>(
      "GET",
      `/v1/projects/${encodePathSegment(projectId)}/webhooks/${encodePathSegment(webhookId)}/deliveries`,
      { params: { limit: params.limit, offset: params.offset } },
    );
  }
  /** Enterprise backend `POST /v1/projects/{id}/webhooks/{wh_id}/deliveries/{delivery_id}/retry`. */
  public async retryWebhookDelivery(
    projectId: string,
    webhookId: string,
    deliveryId: string,
  ): Promise<BackendRetryWebhookDeliveryResponse> {
    return await this.backendRequest<BackendRetryWebhookDeliveryResponse>(
      "POST",
      `/v1/projects/${encodePathSegment(projectId)}/webhooks/${encodePathSegment(webhookId)}/deliveries/${encodePathSegment(deliveryId)}/retry`,
    );
  }
  /** Enterprise backend `POST /v1/projects/{id}/webhooks/{wh_id}/test`. */
  public async testWebhook(projectId: string, webhookId: string): Promise<BackendWebhookTestResponse> {
    return await this.backendRequest<BackendWebhookTestResponse>(
      "POST",
      `/v1/projects/${encodePathSegment(projectId)}/webhooks/${encodePathSegment(webhookId)}/test`,
    );
  }
  /** Enterprise backend `POST /v1/sandbox/public/extract`. */
  public async publicSandboxExtract(params: PublicSandboxExtractParams): Promise<BackendSandboxExtractResponse> {
    return await this.backendRequest<BackendSandboxExtractResponse>("POST", `/v1/sandbox/public/extract`, {
      body: sandboxForm(params),
      ...(params.sandboxToken !== undefined ? { sandboxToken: params.sandboxToken } : {}),
      backendPublic: true,
    });
  }

  // -- Shared surface (Enterprise + Pro) ---------------------------------

  /**
   * Submit a single document for extraction. Returns the initial {@link Job}
   * record (still pending — call `waitForJob` to await completion).
   */
  public async extract(params: ExtractParams): Promise<Job> {
    const jobs = await this.extractBatch({
      files: [params.file],
      ...(params.options !== undefined ? { options: params.options } : {}),
      ...(params.webhook !== undefined ? { webhook: params.webhook } : {}),
      ...(params.config !== undefined ? { configs: [params.config] } : {}),
    });
    const first = jobs[0];
    if (first === undefined) {
      throw new XbergError("Server did not return any job IDs", { status: 500, body: { jobs } });
    }
    return first;
  }

  /**
   * Submit multiple documents in a single multipart request. Returns one
   * {@link Job} per file, in the same order.
   */
  public async extractBatch(params: ExtractBatchParams): Promise<Job[]> {
    if (params.files.length === 0) {
      throw new XbergError("extractBatch called with no files", { status: 400, body: null });
    }

    const form = new FormData();
    const filenames: string[] = [];
    for (const file of params.files) {
      const { blob, filename } = toBlob(file);
      form.append("file", blob, filename);
      filenames.push(filename);
    }
    if (params.options !== undefined) {
      form.append("options", JSON.stringify(params.options));
    }
    if (params.webhook !== undefined) {
      form.append("webhook", JSON.stringify(params.webhook));
    }
    appendPerFileConfigs(form, filenames, params.configs);

    const body = await this.requestJson<ExtractResponse>("POST", "/v1/extract", { body: form });
    const jobIds = body.job_ids ?? [];
    const now = new Date().toISOString();
    return params.files.map((file, index) => {
      const id = jobIds[index];
      if (id === undefined) {
        throw new XbergError(`Server returned ${jobIds.length} job IDs for ${params.files.length} files`, {
          status: 500,
          body,
        });
      }
      return { id, filename: describeFile(file), status: "pending", created_at: now };
    });
  }

  /** Fetch the current state of a job. */
  public async getJob(jobId: string): Promise<Job> {
    return await this.requestJson<Job>("GET", `${JOBS_PATH}/${encodePathSegment(jobId)}`);
  }

  /**
   * Fetch a job's stored result document (`GET /v1/jobs/{id}/result`).
   *
   * Declared by both tiers with an identical `JobResult` envelope; the
   * extracted documents live in `results`. Distinct from {@link getJob}, which
   * returns the job's metadata record.
   */
  public async getJobResult(jobId: string): Promise<JobResult> {
    return await this.requestJson<JobResult>("GET", `${JOBS_PATH}/${encodePathSegment(jobId)}/result`);
  }

  /** List jobs (paginated) via `GET /v1/jobs`. */
  public async listJobs(params: ListJobsParams = {}): Promise<ListJobsResponse> {
    return await this.requestJson<ListJobsResponse>("GET", JOBS_PATH, {
      params: { limit: params.limit, offset: params.offset },
    });
  }

  /**
   * Cancel a job (`DELETE /v1/jobs/{id}`). Idempotent: both a successful
   * cancellation and a job that already reached a terminal status answer
   * `204`.
   */
  public async cancelJob(jobId: string): Promise<void> {
    await this.requestJson("DELETE", `${JOBS_PATH}/${encodePathSegment(jobId)}`);
  }

  /**
   * Poll {@link getJob} until the job reaches a terminal status. Throws
   * {@link TimeoutError} if the wait exceeds `timeoutMs`. Throws
   * {@link XbergError} if the terminal status is `failed` or `cancelled`.
   */
  public async waitForJob(jobId: string, options: WaitOptions = {}): Promise<Job> {
    const timeoutMs = options.timeoutMs ?? DEFAULT_WAIT_TIMEOUT_MS;
    const initialInterval = options.pollIntervalMs ?? DEFAULT_POLL_INTERVAL_MS;
    const backoff = options.backoff ?? "exponential";
    const start = Date.now();
    let interval = initialInterval;

    for (;;) {
      const job = await this.getJob(jobId);
      if (TERMINAL_JOB_STATUSES.includes(job.status)) {
        if (SUCCESS_JOB_STATUSES.includes(job.status)) {
          return job;
        }
        throw new XbergError(`Job ${jobId} ended with status ${job.status}`, { status: 200, body: job });
      }

      const elapsed = Date.now() - start;
      const remaining = timeoutMs - elapsed;
      if (remaining <= 0) {
        throw new TimeoutError(`Timed out waiting for job ${jobId} after ${timeoutMs}ms`, { status: 408, body: job });
      }
      const delay = Math.min(interval, remaining);
      await this.sleep(delay);
      if (backoff === "exponential") {
        interval = Math.min(interval * DEFAULT_BACKOFF_FACTOR, DEFAULT_RETRY_BACKOFF_CAP_MS);
      }
    }
  }

  /** Wait for many jobs in parallel. */
  public async waitForJobs(jobIds: readonly string[], options: WaitOptions = {}): Promise<Job[]> {
    return await Promise.all(jobIds.map((id) => this.waitForJob(id, options)));
  }

  /** Convenience: extract one file and await its result. */
  public async extractAndWait(params: ExtractAndWaitParams): Promise<Job> {
    const extractParams: ExtractParams = {
      file: params.file,
      ...(params.options !== undefined ? { options: params.options } : {}),
      ...(params.webhook !== undefined ? { webhook: params.webhook } : {}),
      ...(params.config !== undefined ? { config: params.config } : {}),
    };
    const job = await this.extract(extractParams);
    const waitOptions: WaitOptions = {
      ...(params.timeoutMs !== undefined ? { timeoutMs: params.timeoutMs } : {}),
      ...(params.pollIntervalMs !== undefined ? { pollIntervalMs: params.pollIntervalMs } : {}),
      ...(params.backoff !== undefined ? { backoff: params.backoff } : {}),
    };
    return this.waitForJob(job.id, waitOptions);
  }

  /** Fetch audit-log entries via `GET /v1/audit`. */
  public async audit(params: AuditParams = {}): Promise<ListAuditEntriesResponse> {
    return await this.requestJson<ListAuditEntriesResponse>("GET", "/v1/audit", {
      params: { action: params.action, limit: params.limit, offset: params.offset },
    });
  }

  // -- Shared preset catalogue -------------------------------------------

  /** List the read-only curated presets (`GET /v1/presets`). */
  public async presets(): Promise<PresetSummary[]> {
    return await this.requestJson<PresetSummary[]>("GET", "/v1/presets");
  }

  /** Fetch one curated preset in full (`GET /v1/presets/{id}`). */
  public async getPreset(presetId: string): Promise<PresetDetail> {
    return await this.requestJson<PresetDetail>("GET", `/v1/presets/${encodePathSegment(presetId)}`);
  }

  /**
   * Download a preset's bundled sample file
   * (`GET /v1/presets/{id}/sample/{name}`). The response is raw bytes, not
   * JSON.
   */
  public async getPresetSample(presetId: string, name: string): Promise<Uint8Array> {
    const path = `/v1/presets/${encodePathSegment(presetId)}/sample/${encodePathSegment(name)}`;
    return await this.requestBytes("GET", path);
  }

  // -- Shared RAG surface ------------------------------------------------

  /** List RAG collections (`GET /v1/rag/collections`). */
  public async listRagCollections(): Promise<unknown> {
    return await this.requestJson("GET", "/v1/rag/collections");
  }

  /** Create a RAG collection (`POST /v1/rag/collections`). */
  public async createRagCollection(body: Record<string, unknown>): Promise<unknown> {
    return await this.requestJson("POST", "/v1/rag/collections", { json: body });
  }

  /** Fetch a RAG collection (`GET /v1/rag/collections/{name}`). */
  public async getRagCollection(name: string): Promise<unknown> {
    return await this.requestJson("GET", `/v1/rag/collections/${encodePathSegment(name)}`);
  }

  /** Delete a RAG collection (`DELETE /v1/rag/collections/{name}`). The spec documents a 204 with no content. */
  public async deleteRagCollection(name: string): Promise<void> {
    await this.requestJson("DELETE", `/v1/rag/collections/${encodePathSegment(name)}`);
  }

  /** Add documents to a RAG collection (`POST /v1/rag/collections/{name}/documents`). */
  public async addRagDocuments(name: string, body: Record<string, unknown>): Promise<unknown> {
    return await this.requestJson("POST", `/v1/rag/collections/${encodePathSegment(name)}/documents`, { json: body });
  }

  /**
   * Delete documents from a RAG collection, by ID list or metadata filter
   * (`DELETE /v1/rag/collections/{name}/documents`). Unlike
   * {@link deleteRagCollection}, this answers `200` with a body reporting how
   * many documents were removed.
   */
  public async deleteRagDocuments(name: string, body: Record<string, unknown>): Promise<unknown> {
    return await this.requestJson("DELETE", `/v1/rag/collections/${encodePathSegment(name)}/documents`, {
      json: body,
    });
  }

  /** Reindex a RAG document (`POST /v1/rag/collections/{name}/documents/{id}/reindex`). */
  public async reindexRagDocument(name: string, documentId: string, body?: Record<string, unknown>): Promise<unknown> {
    const path = `/v1/rag/collections/${encodePathSegment(name)}/documents/${encodePathSegment(documentId)}/reindex`;
    return await this.requestJson("POST", path, body !== undefined ? { json: body } : {});
  }

  /** Retrieve chunks from a RAG collection (`POST /v1/rag/collections/{name}/retrieve`). */
  public async ragRetrieve(name: string, body: Record<string, unknown>): Promise<unknown> {
    return await this.requestJson("POST", `/v1/rag/collections/${encodePathSegment(name)}/retrieve`, { json: body });
  }

  /** Kick off an embedding migration (`POST /v1/rag/collections/{name}/migrate-embeddings`). */
  public async migrateRagEmbeddings(name: string, body: Record<string, unknown>): Promise<unknown> {
    return await this.requestJson("POST", `/v1/rag/collections/${encodePathSegment(name)}/migrate-embeddings`, {
      json: body,
    });
  }

  /** Poll an embedding-migration job (`GET .../migrate-embeddings/{jobId}`). */
  public async getRagMigrationJob(name: string, jobId: string): Promise<unknown> {
    const path = `/v1/rag/collections/${encodePathSegment(name)}/migrate-embeddings/${encodePathSegment(jobId)}`;
    return await this.requestJson("GET", path);
  }

  /** Fetch a RAG job's status (`GET /v1/rag/jobs/{jobId}`). */
  public async getRagJob(jobId: string): Promise<unknown> {
    return await this.requestJson("GET", `/v1/rag/jobs/${encodePathSegment(jobId)}`);
  }

  // -- Shared saved presets ----------------------------------------------
  //
  // Both tiers serve the same schemas under a different spelling, so every
  // method here resolves the tier and renders its path from it.

  /** List the project's saved presets (`GET /v1/saved_presets`, `/v1/saved-presets` on Pro). */
  public async listSavedPresets(params: PaginationParams = {}): Promise<ListSavedPresetsResponse> {
    const path = await this.savedPresetsPath();
    return await this.requestJson<ListSavedPresetsResponse>("GET", path, {
      params: { limit: params.limit, offset: params.offset },
    });
  }

  /** Create a saved preset (`POST /v1/saved_presets`, `/v1/saved-presets` on Pro). */
  public async createSavedPreset(body: CreateSavedPresetRequest): Promise<CreateSavedPresetResponse> {
    const path = await this.savedPresetsPath();
    return await this.requestJson<CreateSavedPresetResponse>("POST", path, { json: body });
  }

  /** Fetch one saved preset (`GET /v1/saved_presets/{presetId}`, `/v1/saved-presets/{id}` on Pro). */
  public async getSavedPreset(presetId: string): Promise<SavedPresetDetail> {
    const path = await this.savedPresetsPath(presetId);
    return await this.requestJson<SavedPresetDetail>("GET", path);
  }

  /** Update a saved preset (`PATCH /v1/saved_presets/{presetId}`, `/v1/saved-presets/{id}` on Pro). */
  public async updateSavedPreset(presetId: string, body: UpdateSavedPresetRequest): Promise<UpdateSavedPresetResponse> {
    const path = await this.savedPresetsPath(presetId);
    return await this.requestJson<UpdateSavedPresetResponse>("PATCH", path, { json: body });
  }

  /** Delete a saved preset (`DELETE /v1/saved_presets/{presetId}`, `/v1/saved-presets/{id}` on Pro). */
  public async deleteSavedPreset(presetId: string): Promise<void> {
    const path = await this.savedPresetsPath(presetId);
    await this.requestJson("DELETE", path);
  }

  // -- Shared auto-tune surface ------------------------------------------

  /** List the project's auto-tune jobs (`GET /v1/auto-tune`). */
  public async listAutoTuneJobs(params: PaginationParams = {}): Promise<ListAutoTuneJobsResponse> {
    return await this.requestJson<ListAutoTuneJobsResponse>("GET", AUTO_TUNE_PATH, {
      params: { limit: params.limit, offset: params.offset },
    });
  }

  /**
   * Submit an auto-tune job (`POST /v1/auto-tune`). Sent as `multipart/form-data`:
   * a JSON `request` part plus one binary `file` part per document.
   */
  public async submitAutoTune(params: SubmitAutoTuneParams): Promise<CreateAutoTuneJobResponse> {
    if (params.files.length === 0) {
      throw new XbergError("submitAutoTune called with no files", { status: 400, body: null });
    }
    const form = new FormData();
    form.append("request", JSON.stringify(params.request));
    for (const file of params.files) {
      const { blob, filename } = toBlob(file);
      form.append("file", blob, filename);
    }
    return await this.requestJson<CreateAutoTuneJobResponse>("POST", AUTO_TUNE_PATH, { body: form });
  }

  /** Fetch the deployment's tunable knobs and OCR backends (`GET /v1/auto-tune/capabilities`). */
  public async getAutoTuneCapabilities(): Promise<AutoTuneCapabilitiesResponse> {
    return await this.requestJson<AutoTuneCapabilitiesResponse>("GET", `${AUTO_TUNE_PATH}/capabilities`);
  }

  /** Fetch an auto-tune job's status (`GET /v1/auto-tune/{id}`). */
  public async getAutoTuneStatus(autoTuneJobId: string): Promise<AutoTuneJobStatus> {
    return await this.requestJson<AutoTuneJobStatus>("GET", this.autoTunePath(autoTuneJobId));
  }

  /** Delete an auto-tune job (`DELETE /v1/auto-tune/{id}`). */
  public async deleteAutoTuneJob(autoTuneJobId: string): Promise<void> {
    await this.requestJson("DELETE", this.autoTunePath(autoTuneJobId));
  }

  /** Promote an auto-tune result to a named tuning profile (`POST /v1/auto-tune/{id}/promote`). */
  public async promoteAutoTuneProfile(
    autoTuneJobId: string,
    body: PromoteProfileRequest,
  ): Promise<TuningProfileDetail> {
    return await this.requestJson<TuningProfileDetail>("POST", `${this.autoTunePath(autoTuneJobId)}/promote`, {
      json: body,
    });
  }

  /** Fetch a completed auto-tune job's result (`GET /v1/auto-tune/{id}/result`). */
  public async getAutoTuneResult(autoTuneJobId: string): Promise<AutoTuneResult> {
    return await this.requestJson<AutoTuneResult>("GET", `${this.autoTunePath(autoTuneJobId)}/result`);
  }

  // -- Shared tuning profiles --------------------------------------------

  /** List the project's tuning profiles (`GET /v1/tuning-profiles`). */
  public async listTuningProfiles(params: PaginationParams = {}): Promise<ListTuningProfilesResponse> {
    return await this.requestJson<ListTuningProfilesResponse>("GET", TUNING_PROFILES_PATH, {
      params: { limit: params.limit, offset: params.offset },
    });
  }

  /** Fetch one tuning profile (`GET /v1/tuning-profiles/{id}`). */
  public async getTuningProfile(profileId: string): Promise<TuningProfileDetail> {
    return await this.requestJson<TuningProfileDetail>("GET", this.tuningProfilePath(profileId));
  }

  /** Delete a tuning profile (`DELETE /v1/tuning-profiles/{id}`). */
  public async deleteTuningProfile(profileId: string): Promise<void> {
    await this.requestJson("DELETE", this.tuningProfilePath(profileId));
  }

  // -- Pro-only surface --------------------------------------------------

  /** Pro only: fetch the instance's accepted auth methods (`GET /auth/config`). */
  public async authConfig(): Promise<AuthConfigResponse> {
    await this.requireTier("pro", "authConfig");
    return this.requestJson<AuthConfigResponse>("GET", "/auth/config");
  }

  /** Pro only: exchange a verified OIDC ID token for a Pro session JWT (`POST /auth/login`). */
  public async login(body: LoginRequest): Promise<LoginResponse> {
    await this.requireTier("pro", "login");
    return this.requestJson<LoginResponse>("POST", "/auth/login", { json: body });
  }

  /** Pro only: fetch a project's RAG config (`GET /v1/projects/{projectId}/rag-config`). */
  public async getRagConfig(projectId: string): Promise<RagConfigResponse> {
    await this.requireTier("pro", "getRagConfig");
    return this.requestJson<RagConfigResponse>("GET", `/v1/projects/${encodePathSegment(projectId)}/rag-config`);
  }

  /** Pro only: update a project's RAG config (`PUT /v1/projects/{projectId}/rag-config`). */
  public async setRagConfig(projectId: string, body: SetRagConfigRequest): Promise<RagConfigResponse> {
    await this.requireTier("pro", "setRagConfig");
    return this.requestJson<RagConfigResponse>("PUT", `/v1/projects/${encodePathSegment(projectId)}/rag-config`, {
      json: body,
    });
  }

  // -- Pro-only control plane (projects, API keys, integrations) ---------

  /** Pro only: list the caller's projects (`GET /v1/projects`). */
  public async listProjects(params: PaginationParams = {}): Promise<ListProjectsResponse> {
    await this.requireTier("pro", "listProjects");
    return this.requestJson<ListProjectsResponse>("GET", "/v1/projects", {
      params: { limit: params.limit, offset: params.offset },
    });
  }

  /** Pro only: create a project owned by the caller (`POST /v1/projects`). */
  public async createProject(body: CreateProjectRequest): Promise<ProjectResponse> {
    await this.requireTier("pro", "createProject");
    return this.requestJson<ProjectResponse>("POST", "/v1/projects", { json: body });
  }

  /** Pro only: list a project's API keys (`GET /v1/projects/{projectId}/api-keys`). */
  public async listApiKeys(projectId: string, params: PaginationParams = {}): Promise<ListApiKeysResponse> {
    await this.requireTier("pro", "listApiKeys");
    return this.requestJson<ListApiKeysResponse>("GET", `${this.projectPath(projectId)}/api-keys`, {
      params: { limit: params.limit, offset: params.offset },
    });
  }

  /** Pro only: mint an API key for a project (`POST /v1/projects/{projectId}/api-keys`). */
  public async createApiKey(projectId: string, body: CreateApiKeyRequest): Promise<CreateApiKeyResponse> {
    await this.requireTier("pro", "createApiKey");
    return this.requestJson<CreateApiKeyResponse>("POST", `${this.projectPath(projectId)}/api-keys`, { json: body });
  }

  /** Pro only: revoke an API key (`DELETE /v1/projects/{projectId}/api-keys/{keyId}`). */
  public async revokeApiKey(projectId: string, keyId: string): Promise<void> {
    await this.requireTier("pro", "revokeApiKey");
    await this.requestJson("DELETE", `${this.projectPath(projectId)}/api-keys/${encodePathSegment(keyId)}`);
  }

  /** Pro only: list a project's integrations (`GET /v1/projects/{projectId}/integrations`). */
  public async listIntegrations(projectId: string, params: PaginationParams = {}): Promise<ListIntegrationsResponse> {
    await this.requireTier("pro", "listIntegrations");
    return this.requestJson<ListIntegrationsResponse>("GET", `${this.projectPath(projectId)}/integrations`, {
      params: { limit: params.limit, offset: params.offset },
    });
  }

  /** Pro only: create an integration (`POST /v1/projects/{projectId}/integrations`). */
  public async createIntegration(projectId: string, body: CreateIntegrationRequest): Promise<IntegrationResponse> {
    await this.requireTier("pro", "createIntegration");
    return this.requestJson<IntegrationResponse>("POST", `${this.projectPath(projectId)}/integrations`, {
      json: body,
    });
  }

  /** Pro only: fetch one integration (`GET .../integrations/{integrationId}`). */
  public async getIntegration(projectId: string, integrationId: string): Promise<IntegrationResponse> {
    await this.requireTier("pro", "getIntegration");
    return this.requestJson<IntegrationResponse>("GET", this.integrationPath(projectId, integrationId));
  }

  /** Pro only: delete an integration (`DELETE .../integrations/{integrationId}`). */
  public async deleteIntegration(projectId: string, integrationId: string): Promise<void> {
    await this.requireTier("pro", "deleteIntegration");
    await this.requestJson("DELETE", this.integrationPath(projectId, integrationId));
  }

  /**
   * Pro only: begin the OAuth flow for an integration
   * (`POST .../integrations/{integrationId}/connect`). Returns the provider
   * authorize URL to redirect the user to.
   */
  public async connectIntegration(projectId: string, integrationId: string): Promise<BeginOAuthResponse> {
    await this.requireTier("pro", "connectIntegration");
    return this.requestJson<BeginOAuthResponse>("POST", `${this.integrationPath(projectId, integrationId)}/connect`);
  }

  /** Pro only: revoke an integration's OAuth connection (`POST .../disconnect`). */
  public async disconnectIntegration(projectId: string, integrationId: string): Promise<void> {
    await this.requireTier("pro", "disconnectIntegration");
    await this.requestJson("POST", `${this.integrationPath(projectId, integrationId)}/disconnect`);
  }

  /** Pro only: list the documents an integration exposes (`GET .../documents`). */
  public async listIntegrationDocuments(
    projectId: string,
    integrationId: string,
    params: ListIntegrationDocumentsParams = {},
  ): Promise<ListDocumentsResponse> {
    await this.requireTier("pro", "listIntegrationDocuments");
    return this.requestJson<ListDocumentsResponse>(
      "GET",
      `${this.integrationPath(projectId, integrationId)}/documents`,
      {
        params: {
          mime_types: params.mimeTypes,
          folder_id: params.folderId,
          max_results: params.maxResults,
        },
      },
    );
  }

  /**
   * Pro only: download one document from an integration
   * (`GET .../documents/{documentId}`). The response is raw bytes, not JSON.
   */
  public async fetchIntegrationDocument(
    projectId: string,
    integrationId: string,
    documentId: string,
  ): Promise<Uint8Array> {
    await this.requireTier("pro", "fetchIntegrationDocument");
    const path = `${this.integrationPath(projectId, integrationId)}/documents/${encodePathSegment(documentId)}`;
    return this.requestBytes("GET", path);
  }

  // -- Enterprise-only surface ------------------------------------------

  /**
   * Enterprise only: fetch a document's latest version with its extraction
   * result (`GET /v1/documents/{documentId}`). The spec declares an inline
   * schema, so the body is returned untyped.
   */
  public async getDocument(documentId: string): Promise<unknown> {
    await this.requireTier("enterprise", "getDocument");
    return this.requestJson("GET", this.documentPath(documentId));
  }

  /** Enterprise only: list a document's versions (`GET /v1/documents/{id}/versions`). */
  public async versions(documentId: string): Promise<DocumentVersionEntry[]> {
    await this.requireTier("enterprise", "versions");
    return this.requestJson<DocumentVersionEntry[]>("GET", `${this.documentPath(documentId)}/versions`);
  }

  /**
   * Enterprise only: diff document versions (`GET /v1/documents/{id}/diff`).
   *
   * Computed inline when the server can afford it (`200`, {@link DiffResponse}
   * in `result.body`), or queued for async computation when it can't (`202`,
   * a {@link DiffAsyncAccepted} job envelope in `result.body`) — the same
   * fallback {@link getDiffJob} polls. Narrow on `result.status`:
   *
   * ```ts
   * const result = await client.diff(documentId);
   * if (result.status === 200) {
   *   // result.body: DiffResponse
   * } else {
   *   // result.body: DiffAsyncAccepted — poll getDiffJob(documentId, result.body.diff_job_id)
   * }
   * ```
   */
  public async diff(documentId: string, params?: QueryParams): Promise<DiffResult> {
    await this.requireTier("enterprise", "diff");
    const init: RequestParts = params !== undefined ? { params } : {};
    const { status, body } = await this.requestJsonWithStatus<DiffResponse | DiffAsyncAccepted>(
      "GET",
      `${this.documentPath(documentId)}/diff`,
      init,
    );
    return toDiffResult(status, body);
  }

  /**
   * Enterprise only: poll a diff job (`GET /v1/documents/{id}/diff/{diffJobId}`).
   *
   * Returns the same {@link DiffResult} union as {@link diff}: `200` once the
   * job has finished (`result.body`: {@link DiffResponse}), `202` while it is
   * still pending (`result.body`: {@link DiffAsyncAccepted}). Narrow on
   * `result.status` as shown in {@link diff}'s TSDoc.
   */
  public async getDiffJob(documentId: string, diffJobId: string): Promise<DiffResult> {
    await this.requireTier("enterprise", "getDiffJob");
    const path = `${this.documentPath(documentId)}/diff/${encodePathSegment(diffJobId)}`;
    const { status, body } = await this.requestJsonWithStatus<DiffResponse | DiffAsyncAccepted>("GET", path);
    return toDiffResult(status, body);
  }

  /** Enterprise only: list the project's extraction events (`GET /v1/extractions`). */
  public async listExtractionEvents(params: ListExtractionEventsParams = {}): Promise<ListExtractionEventsResponse> {
    await this.requireTier("enterprise", "listExtractionEvents");
    return this.requestJson<ListExtractionEventsResponse>("GET", EXTRACTIONS_PATH, {
      params: { days: params.days, limit: params.limit, offset: params.offset },
    });
  }

  /**
   * Enterprise only: download one rendered page of an extraction job
   * (`GET /v1/jobs/{jobId}/pages/{pageNumber}`). The response is a PNG image —
   * raw bytes, not JSON. `pageNumber` is 1-indexed.
   */
  public async getJobPage(jobId: string, pageNumber: number): Promise<Uint8Array> {
    await this.requireTier("enterprise", "getJobPage");
    const path = `${JOBS_PATH}/${encodePathSegment(jobId)}/pages/${encodePathSegment(String(pageNumber))}`;
    return this.requestBytes("GET", path);
  }

  /** Enterprise only: submit text for enrichment (`POST /v1/enrich`). */
  public async submitEnrich(body: EnrichTextRequest): Promise<EnrichJobSubmitted> {
    await this.requireTier("enterprise", "submitEnrich");
    return this.requestJson<EnrichJobSubmitted>("POST", ENRICH_PATH, { json: body });
  }

  /** Enterprise only: fetch an enrichment job's status (`GET /v1/enrich/{jobId}`). */
  public async getEnrichStatus(jobId: string): Promise<EnrichJobStatus> {
    await this.requireTier("enterprise", "getEnrichStatus");
    return this.requestJson<EnrichJobStatus>("GET", `${ENRICH_PATH}/${encodePathSegment(jobId)}`);
  }

  /**
   * Enterprise only: stream a crawl job's events
   * (`GET /v1/crawl-jobs/{crawlJobId}/events`, Server-Sent Events).
   *
   * Returns an `AsyncIterable` of the `kind`-discriminated {@link CrawlEvent}
   * union; the server closes the stream after the `complete` event.
   *
   * ```ts
   * for await (const event of client.streamCrawlEvents(crawlJobId)) {
   *   if (event.kind === "page") {
   *     console.log(event.url, event.status_code);
   *   }
   * }
   * ```
   *
   * Nothing is requested — not even the `/healthz` tier probe — until
   * iteration begins, and the response body is cancelled when iteration ends:
   * on `complete`, on `break`/`return` out of the loop, on a thrown error, or
   * when `options.signal` aborts. A stream is idle between events by design,
   * so unlike every other method here it carries no request timeout and is not
   * routed through the retry engine — a retried subscription would redeliver
   * every event the caller had already handled.
   */
  public streamCrawlEvents(crawlJobId: string, options: StreamCrawlEventsOptions = {}): AsyncIterable<CrawlEvent> {
    const path = `${CRAWL_JOBS_PATH}/${encodePathSegment(crawlJobId)}/events`;
    const open = async (): Promise<Response> => {
      await this.requireTier("enterprise", "streamCrawlEvents");
      return this.openEventStream(path, options.signal);
    };
    return { [Symbol.asyncIterator]: (): AsyncIterator<CrawlEvent> => iterateCrawlEvents(open) };
  }

  /** Enterprise only: request a presigned upload URL (`POST /v1/uploads/presign`). */
  public async presignUpload(body: PresignUploadRequest): Promise<PresignUploadResponse> {
    await this.requireTier("enterprise", "presignUpload");
    return this.requestJson<PresignUploadResponse>("POST", "/v1/uploads/presign", { json: body });
  }

  /** Enterprise only: confirm a presigned upload (`POST /v1/uploads/confirm`). */
  public async confirmUpload(body: ConfirmUploadRequest): Promise<ConfirmUploadResponse> {
    await this.requireTier("enterprise", "confirmUpload");
    return this.requestJson<ConfirmUploadResponse>("POST", "/v1/uploads/confirm", { json: body });
  }

  /** Enterprise only: fetch usage/metering data (`GET /v1/usage`). */
  public async usage(params?: QueryParams): Promise<UsageResponse> {
    await this.requireTier("enterprise", "usage");
    const init: RequestParts = params !== undefined ? { params } : {};
    return this.requestJson<UsageResponse>("GET", "/v1/usage", init);
  }

  // -- Internals ---------------------------------------------------------

  /** Build `/v1/projects/{projectId}` with the id percent-encoded. */
  private projectPath(projectId: string): string {
    return `/v1/projects/${encodePathSegment(projectId)}`;
  }

  /** Build `/v1/projects/{projectId}/integrations/{integrationId}`. */
  private integrationPath(projectId: string, integrationId: string): string {
    return `${this.projectPath(projectId)}/integrations/${encodePathSegment(integrationId)}`;
  }

  /** Build `/v1/documents/{documentId}` with the id percent-encoded. */
  private documentPath(documentId: string): string {
    return `${DOCUMENTS_PATH}/${encodePathSegment(documentId)}`;
  }

  /** Build `/v1/auto-tune/{id}` with the id percent-encoded. */
  private autoTunePath(autoTuneJobId: string): string {
    return `${AUTO_TUNE_PATH}/${encodePathSegment(autoTuneJobId)}`;
  }

  /** Build `/v1/tuning-profiles/{id}` with the id percent-encoded. */
  private tuningProfilePath(profileId: string): string {
    return `${TUNING_PROFILES_PATH}/${encodePathSegment(profileId)}`;
  }

  /**
   * Resolve the tier and render the saved-preset path in that tier's spelling:
   * `/v1/saved-presets` on Pro, `/v1/saved_presets` everywhere else. Pass a
   * `presetId` for the single-preset routes.
   */
  private async savedPresetsPath(presetId?: string): Promise<string> {
    const tier = await this.resolveTier();
    const base = tier === "pro" ? SAVED_PRESETS_PATH_PRO : SAVED_PRESETS_PATH_ENTERPRISE;
    return presetId === undefined ? base : `${base}/${encodePathSegment(presetId)}`;
  }

  /**
   * Return the effective tier — an explicit `target` if set, else probed from
   * `/healthz` and cached after the first *successful* probe. A probe that
   * fails (missing, `null`, or unrecognised `tier`) is not cached, so the
   * next call retries instead of being stuck with a poisoned result for the
   * client's lifetime. Concurrent callers share a single in-flight probe.
   */
  private async resolveTier(): Promise<Target> {
    if (this.target !== undefined) {
      return this.target;
    }
    if (this.probedTier !== undefined) {
      return this.probedTier;
    }
    if (this.tierProbe === undefined) {
      this.tierProbe = this.probeTier();
    }
    try {
      const tier = await this.tierProbe;
      this.probedTier = tier;
      return tier;
    } finally {
      this.tierProbe = undefined;
    }
  }

  /**
   * Issue the `/healthz` capability probe. Only `"enterprise"` and `"pro"` —
   * the tier values the specs actually declare — are accepted; anything else
   * (missing `tier`, `null`, or an unrecognised string) throws instead of
   * being treated as a usable result.
   */
  private async probeTier(): Promise<Target> {
    const body = await this.requestJson<{ tier?: unknown }>("GET", "/healthz");
    const tier = body?.tier;
    if (tier === "enterprise" || tier === "pro") {
      return tier;
    }
    throw new XbergError(
      `/healthz returned an unrecognised tier (${JSON.stringify(tier ?? null)}); expected "enterprise" or "pro"`,
      { status: 0, body },
    );
  }

  /** Throw a clear error when the connected tier does not match the required one. */
  private async requireTier(required: Target, methodName: string): Promise<void> {
    const tier = await this.resolveTier();
    if (tier !== required) {
      throw new XbergError(`${methodName}() is not available on the '${tier}' tier (requires the '${required}' tier)`, {
        status: 0,
        body: null,
      });
    }
  }

  private backendRequest<T>(method: string, path: string, init: RequestParts = {}): Promise<T> {
    return this.requestJson<T>(method, path, { ...init, controlPlane: true });
  }

  private backendHeaders(init: RequestParts): Record<string, string> {
    const headers = new Headers({ ...this.headers, ...init.headers });
    for (const name of ["authorization", "proxy-authorization", "cookie", "x-api-key"]) headers.delete(name);
    const token = init.backendPublic ? init.sandboxToken : this.controlPlaneToken;
    if (token !== undefined && token.length > 0) headers.set("Authorization", `Bearer ${token}`);
    if (init.body instanceof FormData || init.json !== undefined) headers.delete("content-type");
    return Object.fromEntries(headers);
  }

  /** Issue a request, raise on non-2xx, and decode the JSON body (undefined for empty bodies). */
  private async requestJson<T = unknown>(method: string, path: string, init: RequestParts = {}): Promise<T> {
    const { body } = await this.requestJsonWithStatus<T>(method, path, init);
    return body;
  }

  /**
   * Like {@link requestJson}, but also returns the response's status code.
   * Used by endpoints whose 2xx responses carry different schemas per status
   * (currently only `diff`/`getDiffJob`'s `200`/`202` split).
   */
  private async requestJsonWithStatus<T = unknown>(
    method: string,
    path: string,
    init: RequestParts = {},
  ): Promise<{ status: number; body: T }> {
    const response = await this.requestWithRetry(method, path, init);
    if (response.status === 204) {
      return { status: response.status, body: undefined as T };
    }
    const text = await response.text();
    const body = (text.length > 0 ? JSON.parse(text) : undefined) as T;
    return { status: response.status, body };
  }

  /**
   * Open a `text/event-stream` response, deliberately bypassing
   * {@link requestWithRetry}.
   *
   * Two of that method's behaviours are wrong for a subscription. Its retry
   * loop would re-open a partly-consumed stream and redeliver every event the
   * caller already handled — indistinguishable, from the caller's side, from
   * the server sending them twice. And its `AbortSignal.timeout(timeoutMs)`
   * bounds a request/response round trip, while this response stays open for
   * the length of a crawl and is idle between events by design; the caller's
   * own `signal` is the only deadline.
   */
  private async openEventStream(path: string, signal?: AbortSignal): Promise<Response> {
    const url = `${this.baseUrl}${path}`;
    const requestInit: RequestInit = {
      method: "GET",
      headers: { ...this.headers, Accept: EVENT_STREAM_MEDIA_TYPE },
    };
    if (signal !== undefined) {
      requestInit.signal = signal;
    }

    let response: Response;
    try {
      response = await this.fetchImpl(url, requestInit);
    } catch (cause) {
      throw new XbergError(`Network error contacting ${url}`, { status: 0, body: null, cause });
    }
    if (!response.ok) {
      await raiseForStatus(response);
      throw new XbergError("Unreachable", { status: response.status, body: null });
    }
    return response;
  }

  /** Issue a request, raise on non-2xx, and return the response body as raw bytes. */
  private async requestBytes(method: string, path: string, init: RequestParts = {}): Promise<Uint8Array> {
    const response = await this.requestWithRetry(method, path, init);
    return new Uint8Array(await response.arrayBuffer());
  }

  /**
   * Issue a raw HTTP request with auth, timeout, query params, and retry
   * handling. Returns the raw (2xx) {@link Response}; non-2xx responses are
   * mapped to a thrown {@link XbergError} subclass.
   */
  private prepareRequest(method: string, init: RequestParts): RequestInit {
    const headers = init.controlPlane ? this.backendHeaders(init) : { ...this.headers, ...init.headers };
    let body: FormData | string | Uint8Array | undefined = init.body;
    if (init.json !== undefined) {
      headers["Content-Type"] = "application/json";
      body = JSON.stringify(init.json);
    }
    const requestInit: RequestInit = {
      method,
      headers,
      signal: AbortSignal.timeout(this.timeoutMs),
      ...(init.controlPlane ? ({ credentials: "omit", redirect: "manual" } as const) : {}),
    };
    if (body !== undefined) {
      requestInit.body = body;
    }
    return requestInit;
  }

  private async requestWithRetry(method: string, path: string, init: RequestParts = {}): Promise<Response> {
    if (init.controlPlane && (this.target ?? this.probedTier) === "pro") {
      throw new XbergError("Enterprise backend methods are not available on the 'pro' tier", { status: 0, body: null });
    }
    const origin = init.controlPlane ? this.controlPlaneBaseUrl : this.baseUrl;
    const url = `${origin}${path}${buildQueryString(init.params)}`;
    let attempt = 0;
    let interval = DEFAULT_RETRY_BACKOFF_BASE_MS;
    for (;;) {
      const requestInit = this.prepareRequest(method, init);

      let response: Response;
      try {
        response = await this.fetchImpl(url, requestInit);
      } catch (cause) {
        if (attempt < this.retries) {
          attempt += 1;
          await this.sleep(interval);
          interval = nextBackoffInterval(interval, this.retryBackoff);
          continue;
        }
        if (init.controlPlane) {
          throw new XbergError(`Network error contacting Enterprise control plane (${method} ${path})`, {
            status: 0,
            body: null,
          });
        }
        throw new XbergError(`Network error contacting ${url}`, { status: 0, body: null, cause });
      }

      if (response.ok || (init.acceptRedirect && response.status === 303)) {
        return response;
      }

      if (this.retryOn.includes(response.status) && attempt < this.retries) {
        attempt += 1;
        const retryAfter = parseRetryAfterHeader(response.headers.get("retry-after"));
        const wait = retryAfter !== undefined ? retryAfter * 1000 : interval;
        await this.sleep(wait);
        interval = nextBackoffInterval(interval, this.retryBackoff);
        continue;
      }

      try {
        await raiseForStatus(response);
      } catch (error) {
        if (error instanceof RateLimitError && error.retryAfter !== undefined && attempt < this.retries) {
          attempt += 1;
          await this.sleep(error.retryAfter * 1000);
          interval = nextBackoffInterval(interval, this.retryBackoff);
          continue;
        }
        throw error;
      }
      throw new XbergError("Unreachable", { status: response.status, body: null });
    }
  }
}

/** Parts accepted by the internal request engine. */
interface RequestParts {
  controlPlane?: boolean;
  backendPublic?: boolean;
  sandboxToken?: string;
  acceptRedirect?: boolean;
  body?: FormData | string | Uint8Array;
  json?: unknown;
  headers?: Record<string, string>;
  params?: QueryParams;
}

/**
 * Pair a diff response's status code with its body to build the
 * {@link DiffResult} union `diff`/`getDiffJob` return. `202` is the only
 * status carrying {@link DiffAsyncAccepted}; everything else (in practice
 * only `200`) carries the computed {@link DiffResponse}.
 */
function toDiffResult(status: number, body: DiffResponse | DiffAsyncAccepted): DiffResult {
  if (status === 202) {
    return { status: 202, body: body as DiffAsyncAccepted };
  }
  return { status: 200, body: body as DiffResponse };
}

/**
 * Serialize a value with object keys sorted, so two configs that differ only in
 * key order compare equal when {@link appendPerFileConfigs} looks for a conflict.
 * Only ever used for that comparison — the value actually appended to the form is
 * a plain `JSON.stringify`, matching the `options` and `webhook` parts.
 */
function canonicalJson(value: unknown): string {
  if (Array.isArray(value)) {
    return `[${value.map((entry) => canonicalJson(entry)).join(",")}]`;
  }
  if (typeof value === "object" && value !== null) {
    const entries = Object.entries(value as Record<string, unknown>)
      .filter(([, entry]) => entry !== undefined)
      .sort(([left], [right]) => (left < right ? -1 : left > right ? 1 : 0));
    return `{${entries.map(([key, entry]) => `${JSON.stringify(key)}:${canonicalJson(entry)}`).join(",")}}`;
  }
  return JSON.stringify(value) ?? "null";
}

/**
 * Append one `config-<filename>` part per document carrying a per-file override.
 *
 * Appended after the `file`, `options` and `webhook` parts, and skipped entirely
 * when `configs` is undefined, so a request without overrides is byte-identical
 * to one built before this existed.
 *
 * The part is keyed on the filename, mirroring the `document_id-<filename>`
 * convention. Two documents submitted under the same filename therefore have one
 * slot for two overrides: rather than let the later `append` win and lose the
 * other with no signal, that case throws and names the file.
 */
function appendPerFileConfigs(
  form: FormData,
  filenames: readonly string[],
  configs: readonly (FileExtractionConfig | null)[] | undefined,
): void {
  if (configs === undefined) {
    return;
  }
  if (configs.length !== filenames.length) {
    throw new XbergError(
      `configs has ${configs.length} entries but ${filenames.length} files were supplied; ` +
        "pass exactly one entry per file (null for no override)",
      { status: 400, body: null },
    );
  }
  const seen = new Map<string, string>();
  filenames.forEach((filename, index) => {
    const config = configs[index] ?? null;
    const canonical = canonicalJson(config);
    const prior = seen.get(filename);
    if (prior !== undefined && prior !== canonical) {
      throw new XbergError(
        `per-file config conflict for "${filename}": the same filename appears more than once in ` +
          "this batch with different configs, but a multipart request carries at most one config " +
          "part per filename. Give the copies distinct filenames.",
        { status: 400, body: null },
      );
    }
    if (prior === undefined && config !== null) {
      form.append(`config-${filename}`, JSON.stringify(config));
    }
    seen.set(filename, canonical);
  });
}

/** Parse one SSE frame payload into the `kind`-discriminated {@link CrawlEvent} it names. */
function parseCrawlEvent(payload: string): CrawlEvent {
  let body: unknown;
  try {
    body = JSON.parse(payload);
  } catch (cause) {
    throw new XbergError(`Crawl event stream sent a non-JSON frame: ${payload}`, {
      status: 0,
      body: payload,
      cause,
    });
  }
  const kind = (body as { kind?: unknown } | null)?.kind;
  if (typeof kind !== "string" || !CRAWL_EVENT_KINDS.has(kind)) {
    throw new XbergError(`Crawl event stream sent an unrecognised kind (${JSON.stringify(kind ?? null)})`, {
      status: 0,
      body,
    });
  }
  return body as CrawlEvent;
}

/**
 * Drive one crawl-event subscription: open it, decode its frames, and cancel
 * the response body on every exit path.
 *
 * `open` is a thunk rather than an already-opened `Response` so that a caller
 * who never iterates opens nothing — the tier gate and the request both live
 * inside the generator. The `finally` runs when the consumer `break`s or
 * `return`s out of its `for await` as much as when the stream ends, which is
 * what makes the subscription cancellable without a separate handle.
 */
async function* iterateCrawlEvents(open: () => Promise<Response>): AsyncGenerator<CrawlEvent> {
  const response = await open();
  if (response.body === null) {
    throw new XbergError("Crawl event stream response carried no body", {
      status: response.status,
      body: null,
    });
  }
  const reader = response.body.getReader();
  const text = new TextDecoder();
  const frames = new EventStreamDecoder();
  try {
    for (;;) {
      const { done, value } = await reader.read();
      if (done) {
        return;
      }
      for (const payload of frames.push(text.decode(value, { stream: true }))) {
        yield parseCrawlEvent(payload);
      }
    }
  } finally {
    // Never let a teardown failure mask the error that caused the teardown.
    await reader.cancel().catch(() => undefined);
  }
}

/** Backwards-compatible factory returning the low-level `openapi-fetch` client. */
export interface CreateClientOptions {
  baseUrl?: string;
  apiKey?: string;
  headers?: Record<string, string>;
  fetch?: typeof fetch;
}

export function createClient(options: CreateClientOptions = {}): XbergRawClient {
  const headers: Record<string, string> = {
    "User-Agent": USER_AGENT,
    ...options.headers,
  };
  if (options.apiKey !== undefined) {
    headers["Authorization"] = `Bearer ${options.apiKey}`;
  }
  return createOpenApiClient<paths>({
    baseUrl: options.baseUrl ?? DEFAULT_ENTERPRISE_BASE_URL,
    headers,
    ...(options.fetch !== undefined ? { fetch: options.fetch } : {}),
  });
}

function sandboxForm(params: PublicSandboxExtractParams): FormData {
  if (params.file === undefined && !(params.mode === "web" && params.url !== undefined && params.url.length > 0)) {
    throw new XbergError("Sandbox extraction requires a file or web mode with a URL", { status: 400, body: null });
  }
  const form = new FormData();
  if (params.file !== undefined) {
    const { blob, filename } = toBlob(params.file);
    form.append("file", blob, filename);
  }
  for (const name of ["mode", "preset", "url"] as const) {
    const value = params[name];
    if (value !== undefined) form.append(name, value);
  }
  return form;
}
