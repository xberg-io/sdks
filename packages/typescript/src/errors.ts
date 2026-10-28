/**
 * Error class hierarchy for the Xberg SDK (Enterprise + Pro).
 *
 * Every non-2xx HTTP response is mapped to a subclass of {@link XbergError}.
 * `TimeoutError` is also raised when {@link XbergClient.waitForJob} exceeds its
 * configured deadline (distinct from a network/fetch timeout).
 */

export interface XbergErrorOptions {
  status: number;
  body: unknown;
  cause?: unknown;
  /** Stable machine-readable error code from the response envelope, e.g. `gateway_timeout`. */
  code?: string;
  /** Context-specific detail object from the response envelope. */
  details?: Record<string, unknown>;
}

export class XbergError extends Error {
  public readonly status: number;
  public readonly body: unknown;
  /** Stable error code from the response envelope; branch on this, not on `message`. */
  public readonly code?: string;
  /** The envelope's `details` object, when the server sent one. */
  public readonly details?: Record<string, unknown>;

  public constructor(message: string, options: XbergErrorOptions) {
    const errorInit: ErrorOptions = options.cause === undefined ? {} : { cause: options.cause };
    super(message, errorInit);
    this.name = "XbergError";
    this.status = options.status;
    this.body = options.body;
    if (options.code !== undefined) {
      this.code = options.code;
    }
    if (options.details !== undefined) {
      this.details = options.details;
    }
  }
}

export class AuthError extends XbergError {
  public constructor(message: string, options: XbergErrorOptions) {
    super(message, options);
    this.name = "AuthError";
  }
}

export interface RateLimitErrorOptions extends XbergErrorOptions {
  retryAfter?: number;
}

export class RateLimitError extends XbergError {
  public readonly retryAfter?: number;

  public constructor(message: string, options: RateLimitErrorOptions) {
    super(message, options);
    this.name = "RateLimitError";
    if (options.retryAfter !== undefined) {
      this.retryAfter = options.retryAfter;
    }
  }
}

export class ValidationError extends XbergError {
  public constructor(message: string, options: XbergErrorOptions) {
    super(message, options);
    this.name = "ValidationError";
  }
}

export class NotFoundError extends XbergError {
  public constructor(message: string, options: XbergErrorOptions) {
    super(message, options);
    this.name = "NotFoundError";
  }
}

/**
 * HTTP 404 with code `data_room.disabled`: the deployment's plan does not offer
 * data rooms, so every room route answers this before any other check.
 * `enterpriseHealthz()` reports the same state ahead of time as
 * `data_rooms.enabled === false`. Extends {@link NotFoundError}, which this
 * response mapped to before.
 */
export class DataRoomsDisabledError extends NotFoundError {
  public constructor(message: string, options: XbergErrorOptions) {
    super(message, options);
    this.name = "DataRoomsDisabledError";
  }
}

/** Envelope code of the 404 every data-room route answers on a plan without data rooms. */
const DATA_ROOM_DISABLED_CODE = "data_room.disabled";

export class ServerError extends XbergError {
  public constructor(message: string, options: XbergErrorOptions) {
    super(message, options);
    this.name = "ServerError";
  }
}

/**
 * HTTP 408: the request body stopped arriving before the upload completed
 * (`details.limit` is `body_idle`). Not retried by default — the body must be
 * sent again. Extends {@link ValidationError}, which every 4xx mapped to before.
 */
export class RequestTimeoutError extends ValidationError {
  /** Which server limit fired (`body_idle`), from `details.limit`. */
  public readonly limit?: string;
  /** The limit that was exceeded, in seconds, from `details.timeout_seconds`. */
  public readonly timeoutSeconds?: number;

  public constructor(message: string, options: XbergErrorOptions) {
    super(message, options);
    this.name = "RequestTimeoutError";
    const limits = timeoutLimits(options.details);
    if (limits.limit !== undefined) {
      this.limit = limits.limit;
    }
    if (limits.timeoutSeconds !== undefined) {
      this.timeoutSeconds = limits.timeoutSeconds;
    }
  }
}

/** HTTP 410: the job's stored result has expired and can no longer be fetched. */
export class ResultExpiredError extends ValidationError {
  public constructor(message: string, options: XbergErrorOptions) {
    super(message, options);
    this.name = "ResultExpiredError";
  }
}

/** HTTP 412: the `If-Match` precondition did not match the resource's current version. */
export class PreconditionFailedError extends ValidationError {
  public constructor(message: string, options: XbergErrorOptions) {
    super(message, options);
    this.name = "PreconditionFailedError";
  }
}

/** HTTP 428: the endpoint requires an `If-Match` header and none was sent. */
export class PreconditionRequiredError extends ValidationError {
  public constructor(message: string, options: XbergErrorOptions) {
    super(message, options);
    this.name = "PreconditionRequiredError";
  }
}

/**
 * HTTP 504: the server did not produce a response in time (`details.limit` is
 * `handler`). The work may still have happened server-side, which is why a
 * POST is not retried on 504 unless the client opts in. Extends
 * {@link ServerError}, which 504 mapped to before.
 */
export class GatewayTimeoutError extends ServerError {
  /** Which server limit fired (`handler`), from `details.limit`. */
  public readonly limit?: string;
  /** The limit that was exceeded, in seconds, from `details.timeout_seconds`. */
  public readonly timeoutSeconds?: number;

  public constructor(message: string, options: XbergErrorOptions) {
    super(message, options);
    this.name = "GatewayTimeoutError";
    const limits = timeoutLimits(options.details);
    if (limits.limit !== undefined) {
      this.limit = limits.limit;
    }
    if (limits.timeoutSeconds !== undefined) {
      this.timeoutSeconds = limits.timeoutSeconds;
    }
  }
}

export class TimeoutError extends XbergError {
  public constructor(message: string, options: XbergErrorOptions) {
    super(message, options);
    this.name = "TimeoutError";
  }
}

/**
 * Map an HTTP response status to the matching error subclass and throw it.
 *
 * Always throws — call as `throw await raiseForStatus(response)` if you want
 * the type system to see the unreachable code, otherwise just `await`. Both
 * 401 and 403 map to {@link AuthError} — the API uses 403 for a
 * valid-but-forbidden principal.
 */
export async function raiseForStatus(response: Response): Promise<never> {
  const body = await readBody(response);
  const envelope = parseErrorEnvelope(body);
  const message = envelope.message ?? `Request failed with status ${response.status}`;
  const options: XbergErrorOptions = { status: response.status, body };
  if (envelope.code !== undefined) {
    options.code = envelope.code;
  }
  if (envelope.details !== undefined) {
    options.details = envelope.details;
  }

  if (response.status === 401 || response.status === 403) {
    throw new AuthError(message, options);
  }
  if (response.status === 404) {
    if (options.code === DATA_ROOM_DISABLED_CODE) {
      throw new DataRoomsDisabledError(message, options);
    }
    throw new NotFoundError(message, options);
  }
  if (response.status === 429) {
    const retryAfterRaw = response.headers.get("retry-after");
    const retryAfter = parseRetryAfter(retryAfterRaw);
    const opts: RateLimitErrorOptions = retryAfter === undefined ? options : { ...options, retryAfter };
    throw new RateLimitError(message, opts);
  }
  const specific = STATUS_ERRORS[response.status];
  if (specific !== undefined) {
    throw new specific(message, options);
  }
  if (response.status >= 400 && response.status < 500) {
    throw new ValidationError(message, options);
  }
  if (response.status >= 500) {
    throw new ServerError(message, options);
  }
  throw new XbergError(message, options);
}

async function readBody(response: Response): Promise<unknown> {
  const contentType = response.headers.get("content-type") ?? "";
  if (contentType.includes("application/json")) {
    try {
      return await response.json();
    } catch {
      return undefined;
    }
  }
  try {
    const text = await response.text();
    return text === "" ? undefined : text;
  } catch {
    return undefined;
  }
}

const STATUS_ERRORS: Readonly<Record<number, new (message: string, options: XbergErrorOptions) => XbergError>> = {
  408: RequestTimeoutError,
  410: ResultExpiredError,
  412: PreconditionFailedError,
  428: PreconditionRequiredError,
  504: GatewayTimeoutError,
};

/** The parts of an error body the SDK understands. */
interface ErrorEnvelope {
  message?: string;
  code?: string;
  details?: Record<string, unknown>;
}

/**
 * Read an error body in any shape the servers send: the canonical nested
 * envelope `{"error":{"code","message","details"}}`, the older flat
 * `{"error":"..."}` / `{"message":"...","code":"..."}`, or plain text.
 */
function parseErrorEnvelope(body: unknown): ErrorEnvelope {
  if (typeof body === "string") {
    return body.length > 0 ? { message: body } : {};
  }
  if (!isRecord(body)) {
    return {};
  }
  const error = body["error"];
  const source = isRecord(error) ? error : body;
  const envelope: ErrorEnvelope = {};
  const message =
    nonEmptyString(source === body && typeof error === "string" ? error : undefined) ??
    nonEmptyString(source["message"]);
  if (message !== undefined) {
    envelope.message = message;
  }
  const code = nonEmptyString(source["code"]);
  if (code !== undefined) {
    envelope.code = code;
  }
  const details = source["details"];
  if (isRecord(details)) {
    envelope.details = details;
  }
  return envelope;
}

function timeoutLimits(details: Record<string, unknown> | undefined): {
  limit?: string;
  timeoutSeconds?: number;
} {
  const out: { limit?: string; timeoutSeconds?: number } = {};
  const limit = details?.["limit"];
  if (typeof limit === "string") {
    out.limit = limit;
  }
  const seconds = details?.["timeout_seconds"];
  if (typeof seconds === "number" && Number.isFinite(seconds)) {
    out.timeoutSeconds = seconds;
  }
  return out;
}

function isRecord(value: unknown): value is Record<string, unknown> {
  return value !== null && typeof value === "object" && !Array.isArray(value);
}

function nonEmptyString(value: unknown): string | undefined {
  return typeof value === "string" && value.length > 0 ? value : undefined;
}

function parseRetryAfter(value: string | null): number | undefined {
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
  const delta = Math.max(0, Math.ceil((parsed - Date.now()) / 1000));
  return delta;
}
