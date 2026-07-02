/**
 * High-level Xberg Enterprise client.
 *
 * Wraps the generated `openapi-fetch` low-level client with ergonomic methods
 * that mirror the Python SDK shape (`extract`, `getJob`, `waitForJob`,
 * `extractAndWait`, `createSandboxKey`, etc.) and strongly-typed error
 * mapping. See {@link KreuzbergCloud} for the public surface.
 */

import createOpenApiClient, { type Client } from "openapi-fetch";
import type { paths } from "./_generated/schema.js";
import { KreuzbergError, RateLimitError, TimeoutError, raiseForStatus } from "./errors.js";
import type { ExtractResponse, ExtractionOptions, Job, JobResult, SandboxKey, WebhookConfig } from "./types.js";
import { SUCCESS_JOB_STATUSES, TERMINAL_JOB_STATUSES } from "./types.js";

const DEFAULT_BASE_URL = "https://api.xberg.io";
const USER_AGENT = "xberg-enterprise-typescript/0.0.1";
const DEFAULT_TIMEOUT_MS = 30_000;
const DEFAULT_POLL_INTERVAL_MS = 1_000;
const DEFAULT_WAIT_TIMEOUT_MS = 5 * 60_000;
const DEFAULT_RETRY_STATUSES: readonly number[] = [429, 502, 503, 504];
const DEFAULT_RETRY_BACKOFF_BASE_MS = 200;
const DEFAULT_RETRY_BACKOFF_CAP_MS = 30_000;
const DEFAULT_BACKOFF_FACTOR = 2;
const SANDBOX_KEY_PATH = "/v1/sandbox/key";

/**
 * Backoff strategy for retries and `waitForJob` polling.
 *
 * - `exponential` — interval doubles after every attempt, capped at 30s.
 * - `constant` — interval stays the same on every attempt.
 */
export type BackoffStrategy = "exponential" | "constant";

export interface KreuzbergCloudOptions {
  apiKey?: string;
  baseUrl?: string;
  fetch?: typeof fetch;
  headers?: Record<string, string>;
  timeoutMs?: number;
  retries?: number;
  retryOn?: readonly number[];
  retryBackoff?: BackoffStrategy;
  /** Sleep helper, swappable in tests. Defaults to `setTimeout`. */
  sleep?: (ms: number) => Promise<void>;
}

export interface FromSandboxOptions {
  baseUrl?: string;
  fetch?: typeof fetch;
  headers?: Record<string, string>;
  timeoutMs?: number;
  retries?: number;
  retryOn?: readonly number[];
  retryBackoff?: BackoffStrategy;
}

export type FileLike = File | Blob | Uint8Array | { name?: string; data: Blob | Uint8Array; mimeType?: string };

export interface ExtractParams {
  file: FileLike;
  options?: ExtractionOptions;
  webhook?: WebhookConfig;
}

export interface ExtractBatchParams {
  files: readonly FileLike[];
  options?: ExtractionOptions;
  webhook?: WebhookConfig;
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

/** Public client. */
export type KreuzbergCloudClient = Client<paths>;

/**
 * High-level client. Construct with `new KreuzbergCloud({ apiKey })`, or use
 * the {@link KreuzbergCloud.fromSandbox} factory for a temporary key.
 */
export class KreuzbergCloud {
  private readonly baseUrl: string;
  private readonly headers: Record<string, string>;
  private readonly fetchImpl: typeof fetch;
  private readonly timeoutMs: number;
  private readonly retries: number;
  private readonly retryOn: readonly number[];
  private readonly retryBackoff: BackoffStrategy;
  private readonly sleep: (ms: number) => Promise<void>;
  /** Underlying `openapi-fetch` client — exposed for advanced use. */
  public readonly raw: KreuzbergCloudClient;

  public constructor(options: KreuzbergCloudOptions = {}) {
    this.baseUrl = (options.baseUrl ?? DEFAULT_BASE_URL).replace(/\/+$/, "");
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

  /**
   * Submit a single document for extraction. Returns the initial {@link Job}
   * record (still pending — call `waitForJob` to await completion).
   */
  public async extract(params: ExtractParams): Promise<Job> {
    const jobs = await this.extractBatch({
      files: [params.file],
      ...(params.options !== undefined ? { options: params.options } : {}),
      ...(params.webhook !== undefined ? { webhook: params.webhook } : {}),
    });
    const first = jobs[0];
    if (first === undefined) {
      throw new KreuzbergError("Server did not return any job IDs", {
        status: 500,
        body: { jobs },
      });
    }
    return first;
  }

  /**
   * Submit multiple documents in a single multipart request. Returns one
   * {@link Job} per file, in the same order.
   */
  public async extractBatch(params: ExtractBatchParams): Promise<Job[]> {
    if (params.files.length === 0) {
      throw new KreuzbergError("extractBatch called with no files", { status: 400, body: null });
    }

    const form = new FormData();
    for (const file of params.files) {
      const { blob, filename } = toBlob(file);
      form.append("file", blob, filename);
    }
    if (params.options !== undefined) {
      form.append("options", JSON.stringify(params.options));
    }
    const webhookPayload: WebhookConfig = params.webhook ?? { url: "" };
    form.append("webhook", JSON.stringify(webhookPayload));

    const response = await this.requestWithRetry("POST", "/v1/extract", { body: form });
    const body = (await response.json()) as ExtractResponse;
    const jobIds = body.job_ids ?? [];
    const now = new Date().toISOString();
    return params.files.map((file, index) => {
      const id = jobIds[index];
      if (id === undefined) {
        throw new KreuzbergError(`Server returned ${jobIds.length} job IDs for ${params.files.length} files`, {
          status: 500,
          body,
        });
      }
      const filename = describeFile(file);
      return {
        id,
        filename,
        status: "pending",
        created_at: now,
      };
    });
  }

  /** Fetch the current state of a job. */
  public async getJob(jobId: string): Promise<Job> {
    const response = await this.requestWithRetry("GET", `/v1/jobs/${encodeURIComponent(jobId)}`);
    return (await response.json()) as Job;
  }

  /**
   * Poll {@link getJob} until the job reaches a terminal status. Throws
   * {@link TimeoutError} if the wait exceeds `timeoutMs`. Throws
   * {@link KreuzbergError} if the terminal status is `failed` or `cancelled`.
   */
  public async waitForJob(jobId: string, options: WaitOptions = {}): Promise<JobResult> {
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
        throw new KreuzbergError(`Job ${jobId} ended with status ${job.status}`, {
          status: 200,
          body: job,
        });
      }

      const elapsed = Date.now() - start;
      const remaining = timeoutMs - elapsed;
      if (remaining <= 0) {
        throw new TimeoutError(`Timed out waiting for job ${jobId} after ${timeoutMs}ms`, {
          status: 408,
          body: job,
        });
      }
      const delay = Math.min(interval, remaining);
      await this.sleep(delay);
      if (backoff === "exponential") {
        interval = Math.min(interval * DEFAULT_BACKOFF_FACTOR, DEFAULT_RETRY_BACKOFF_CAP_MS);
      }
    }
  }

  /** Wait for many jobs in parallel. */
  public async waitForJobs(jobIds: readonly string[], options: WaitOptions = {}): Promise<JobResult[]> {
    return Promise.all(jobIds.map((id) => this.waitForJob(id, options)));
  }

  /** Convenience: extract one file and await its result. */
  public async extractAndWait(params: ExtractAndWaitParams): Promise<JobResult> {
    const extractParams: ExtractParams = {
      file: params.file,
      ...(params.options !== undefined ? { options: params.options } : {}),
      ...(params.webhook !== undefined ? { webhook: params.webhook } : {}),
    };
    const job = await this.extract(extractParams);
    const waitOptions: WaitOptions = {
      ...(params.timeoutMs !== undefined ? { timeoutMs: params.timeoutMs } : {}),
      ...(params.pollIntervalMs !== undefined ? { pollIntervalMs: params.pollIntervalMs } : {}),
      ...(params.backoff !== undefined ? { backoff: params.backoff } : {}),
    };
    return this.waitForJob(job.id, waitOptions);
  }

  /**
   * Mint a temporary sandbox API key. Calls `POST /v1/sandbox/key` (raw
   * fetch, not in the generated paths yet).
   */
  public async createSandboxKey(): Promise<SandboxKey> {
    const response = await this.requestWithRetry("POST", SANDBOX_KEY_PATH);
    return (await response.json()) as SandboxKey;
  }

  /**
   * Construct a client authenticated with a fresh sandbox key. Issues an
   * unauthenticated request to `POST /v1/sandbox/key`, then returns a new
   * `KreuzbergCloud` configured with the returned key.
   */
  public static async fromSandbox(options: FromSandboxOptions = {}): Promise<KreuzbergCloud> {
    const bootstrap = new KreuzbergCloud(options);
    const key = await bootstrap.createSandboxKey();
    return new KreuzbergCloud({ ...options, apiKey: key.api_key });
  }

  /**
   * Issue a raw HTTP request with auth, timeout, and retry handling. Used
   * internally for endpoints that require multipart bodies or aren't yet in
   * the generated schema.
   */
  private async requestWithRetry(
    method: string,
    path: string,
    init: { body?: FormData | string | Uint8Array; headers?: Record<string, string> } = {},
  ): Promise<Response> {
    const url = `${this.baseUrl}${path}`;
    let attempt = 0;
    let interval = DEFAULT_RETRY_BACKOFF_BASE_MS;
    for (;;) {
      const headers = { ...this.headers, ...init.headers };
      const requestInit: RequestInit = {
        method,
        headers,
        signal: AbortSignal.timeout(this.timeoutMs),
      };
      if (init.body !== undefined) {
        requestInit.body = init.body;
      }

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
        throw new KreuzbergError(`Network error contacting ${url}`, {
          status: 0,
          body: null,
          cause,
        });
      }

      if (response.ok) {
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
      // raiseForStatus always throws; this line is unreachable but satisfies TS.
      throw new KreuzbergError("Unreachable", { status: response.status, body: null });
    }
  }
}

/** Backwards-compatible factory matching the original low-level API. */
export interface CreateClientOptions {
  baseUrl?: string;
  apiKey?: string;
  headers?: Record<string, string>;
  fetch?: typeof fetch;
}

export function createClient(options: CreateClientOptions = {}): KreuzbergCloudClient {
  const headers: Record<string, string> = {
    "User-Agent": USER_AGENT,
    ...options.headers,
  };
  if (options.apiKey !== undefined) {
    headers["Authorization"] = `Bearer ${options.apiKey}`;
  }
  return createOpenApiClient<paths>({
    baseUrl: options.baseUrl ?? DEFAULT_BASE_URL,
    headers,
    ...(options.fetch !== undefined ? { fetch: options.fetch } : {}),
  });
}

function defaultSleep(ms: number): Promise<void> {
  return new Promise((resolve) => {
    setTimeout(resolve, ms);
  });
}

function nextBackoffInterval(current: number, strategy: BackoffStrategy): number {
  if (strategy === "constant") {
    return current;
  }
  return Math.min(current * DEFAULT_BACKOFF_FACTOR, DEFAULT_RETRY_BACKOFF_CAP_MS);
}

function parseRetryAfterHeader(value: string | null): number | undefined {
  if (value === null) {
    return undefined;
  }
  const seconds = Number(value);
  if (Number.isFinite(seconds) && seconds >= 0) {
    return seconds;
  }
  const parsed = Date.parse(value);
  if (Number.isNaN(parsed)) {
    return undefined;
  }
  return Math.max(0, Math.ceil((parsed - Date.now()) / 1000));
}

/** Convert a {@link FileLike} input into a `Blob` plus best-guess filename. */
function toBlob(file: FileLike): { blob: Blob; filename: string } {
  if (typeof File !== "undefined" && file instanceof File) {
    return { blob: file, filename: file.name };
  }
  if (file instanceof Blob) {
    return { blob: file, filename: "upload.bin" };
  }
  if (file instanceof Uint8Array) {
    return {
      blob: new Blob([new Uint8Array(file)], { type: "application/octet-stream" }),
      filename: "upload.bin",
    };
  }
  const wrapper = file;
  const name = wrapper.name ?? "upload.bin";
  const mimeType = wrapper.mimeType ?? guessMimeType(name);
  if (wrapper.data instanceof Blob) {
    return { blob: wrapper.data, filename: name };
  }
  return {
    blob: new Blob([new Uint8Array(wrapper.data)], { type: mimeType }),
    filename: name,
  };
}

function guessMimeType(filename: string): string {
  const lower = filename.toLowerCase();
  if (lower.endsWith(".csv")) {
    return "text/csv";
  }
  if (lower.endsWith(".md")) {
    return "text/markdown";
  }
  if (lower.endsWith(".pdf")) {
    return "application/pdf";
  }
  if (lower.endsWith(".txt")) {
    return "text/plain";
  }
  if (lower.endsWith(".docx")) {
    return "application/vnd.openxmlformats-officedocument.wordprocessingml.document";
  }
  return "application/octet-stream";
}

/** Guess a display name for a file (used to populate `Job.filename`). */
function describeFile(file: FileLike): string {
  if (typeof File !== "undefined" && file instanceof File) {
    return file.name;
  }
  if (file instanceof Blob || file instanceof Uint8Array) {
    return "upload.bin";
  }
  return file.name ?? "upload.bin";
}
