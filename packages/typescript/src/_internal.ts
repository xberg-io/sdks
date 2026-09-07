/**
 * Internal helpers for {@link XbergClient}: base-URL resolution, query-string
 * and backoff arithmetic, the file-to-`Blob` conversion the multipart request
 * paths need, and the event-stream frame decoder `streamCrawlEvents` reads its
 * response through. Not part of the public API — of the names here only
 * {@link FileLike} and {@link BackoffStrategy} are re-exported, via `client.ts`,
 * because they appear in public client signatures.
 */

import { XbergError } from "./errors.js";

export const DEFAULT_ENTERPRISE_BASE_URL = "https://api.xberg.io";
export const DEFAULT_RETRY_BACKOFF_CAP_MS = 30_000;
export const DEFAULT_BACKOFF_FACTOR = 2;

/**
 * Caps an event-stream frame. The frames this endpoint sends are a few hundred
 * bytes; the cap exists so a server that never closes a frame cannot grow this
 * decoder without bound.
 *
 * It is applied twice, because one application does not cover the other: to the
 * pending line, so one endless line cannot fill memory, and to the running
 * total of a frame's `data:` fields, so an endless succession of shorter lines
 * never followed by the blank line that would close the frame cannot either.
 */
export const MAX_EVENT_STREAM_FRAME_BYTES = 1 << 20;

/**
 * Backoff strategy for retries and `waitForJob` polling.
 *
 * - `exponential` — interval doubles after every attempt, capped at 30s.
 * - `constant` — interval stays the same on every attempt.
 */
export type BackoffStrategy = "exponential" | "constant";

/** Which product the client targets. */
export type Target = "enterprise" | "pro";

/** Query-string values accepted by the internal request engine. */
export type QueryParams = Record<string, string | number | undefined>;

/** Anything the client accepts as an uploadable file. */
export type FileLike = File | Blob | Uint8Array | { name?: string; data: Blob | Uint8Array; mimeType?: string };

/**
 * Resolve the effective base URL, enforcing that Pro requires an explicit one.
 */
export function resolveBaseUrl(baseUrl: string | undefined, target: Target | undefined): string {
  if (baseUrl !== undefined) {
    return baseUrl.replace(/\/+$/, "");
  }
  if (target === "pro") {
    throw new XbergError(
      "Xberg Pro has no default base URL (its spec ships no servers block); pass baseUrl pointing at your Pro instance.",
      { status: 0, body: null },
    );
  }
  return DEFAULT_ENTERPRISE_BASE_URL;
}

/**
 * Resolve the base URL of the Enterprise control plane, defaulting to the data plane's.
 *
 * Enterprise runs the control plane (projects, API keys, integrations, RAG
 * config, members, invitations, managed webhooks, usage, analytics, billing) as
 * a second binary on its own origin; Pro serves it from the same one. The
 * default therefore has to be `baseUrl`, exactly as the console's
 * `NEXT_PUBLIC_BACKEND_API_URL` is same-origin unless set — anything else would
 * break every Pro control-plane call the moment this option existed.
 */
export function resolveControlPlaneBaseUrl(controlPlaneBaseUrl: string | undefined, baseUrl: string): string {
  if (controlPlaneBaseUrl !== undefined) {
    return controlPlaneBaseUrl.replace(/\/+$/, "");
  }
  return baseUrl;
}

export function defaultSleep(ms: number): Promise<void> {
  return new Promise((resolve) => {
    setTimeout(resolve, ms);
  });
}

export function buildQueryString(params: QueryParams | undefined): string {
  if (params === undefined) {
    return "";
  }
  const search = new URLSearchParams();
  for (const [key, value] of Object.entries(params)) {
    if (value !== undefined) {
      search.append(key, String(value));
    }
  }
  const query = search.toString();
  return query.length > 0 ? `?${query}` : "";
}

export function nextBackoffInterval(current: number, strategy: BackoffStrategy): number {
  if (strategy === "constant") {
    return current;
  }
  return Math.min(current * DEFAULT_BACKOFF_FACTOR, DEFAULT_RETRY_BACKOFF_CAP_MS);
}

export function parseRetryAfterHeader(value: string | null): number | undefined {
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
export function toBlob(file: FileLike): { blob: Blob; filename: string } {
  if (typeof File !== "undefined" && file instanceof File) {
    return { blob: file, filename: file.name };
  }
  if (file instanceof Blob) {
    return { blob: file, filename: "upload.bin" };
  }
  if (file instanceof Uint8Array) {
    return {
      blob: new Blob([blobBytes(file)], { type: "application/octet-stream" }),
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
    blob: new Blob([blobBytes(wrapper.data)], { type: mimeType }),
    filename: name,
  };
}

function blobBytes(bytes: Uint8Array): Uint8Array<ArrayBuffer> {
  // ~keep Blob snapshots its input. A view avoids a second payload copy; shared backing requires an ordinary buffer.
  return bytes.buffer instanceof ArrayBuffer
    ? new Uint8Array(bytes.buffer, bytes.byteOffset, bytes.byteLength)
    : new Uint8Array(bytes);
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
export function describeFile(file: FileLike): string {
  if (typeof File !== "undefined" && file instanceof File) {
    return file.name;
  }
  if (file instanceof Blob || file instanceof Uint8Array) {
    return "upload.bin";
  }
  return file.name ?? "upload.bin";
}

/**
 * Incremental decoder for a `text/event-stream` body, fed the decoded text of
 * each network chunk.
 *
 * Implements the parts of the WHATWG event-stream parser this endpoint can
 * exercise. A frame is terminated by a *blank line*, not by a newline: its
 * payload is every `data:` field it carried, joined with `\n`. Lines opening
 * with `:` are comments — the endpoint's 15s heartbeat is one — and
 * `event:`/`id:`/`retry:` fields are accepted and ignored. A single space
 * after a field's colon is framing, not value, so it is stripped.
 *
 * All of which is why this exists instead of `JSON.parse` per line: against a
 * server that happens to emit one compact frame per line the naive version
 * passes every test, then silently drops every multi-line payload and throws
 * on the first heartbeat against a real one. Chunk boundaries fall wherever
 * the network puts them, so lines are also reassembled here rather than
 * assumed to arrive whole.
 */
export class EventStreamDecoder {
  private buffer = "";
  private data: string[] = [];
  /** Running length of the frame being assembled, reset with `data` on dispatch. */
  private size = 0;

  /** Consume one chunk of decoded text, returning the payload of every frame it completed. */
  public push(chunk: string): string[] {
    this.buffer += chunk;
    const payloads: string[] = [];
    for (;;) {
      const boundary = this.nextLineBoundary();
      if (boundary === undefined) {
        if (this.buffer.length > MAX_EVENT_STREAM_FRAME_BYTES) {
          throw new XbergError(`Crawl event stream sent a line longer than ${MAX_EVENT_STREAM_FRAME_BYTES} bytes`, {
            status: 0,
            body: null,
          });
        }
        return payloads;
      }
      const line = this.buffer.slice(0, boundary.index);
      this.buffer = this.buffer.slice(boundary.index + boundary.width);
      const payload = this.feed(line);
      if (payload !== undefined) {
        payloads.push(payload);
      }
    }
  }

  /**
   * Locate the next `\n`, `\r\n` or `\r` in the buffer. A trailing `\r` is
   * reported as "no boundary yet": it may be the first half of a `\r\n` the
   * network split across two chunks, and treating it as a terminator there
   * would dispatch a frame one line early.
   */
  private nextLineBoundary(): { index: number; width: number } | undefined {
    for (let index = 0; index < this.buffer.length; index += 1) {
      const character = this.buffer[index];
      if (character === "\n") {
        return { index, width: 1 };
      }
      if (character === "\r") {
        if (index === this.buffer.length - 1) {
          return undefined;
        }
        return { index, width: this.buffer[index + 1] === "\n" ? 2 : 1 };
      }
    }
    return undefined;
  }

  /** Consume one terminator-stripped line, returning a payload if it completed a frame. */
  private feed(line: string): string | undefined {
    if (line === "") {
      return this.dispatch();
    }
    if (line.startsWith(":")) {
      return undefined;
    }
    const colon = line.indexOf(":");
    const field = colon === -1 ? line : line.slice(0, colon);
    let value = colon === -1 ? "" : line.slice(colon + 1);
    if (value.startsWith(" ")) {
      value = value.slice(1);
    }
    if (field === "data") {
      this.size += value.length + 1; // +1 for the "\n" dispatch joins with
      if (this.size > MAX_EVENT_STREAM_FRAME_BYTES) {
        throw new XbergError(
          `Crawl event frame exceeded ${MAX_EVENT_STREAM_FRAME_BYTES} bytes before the stream closed it`,
          { status: 0, body: null },
        );
      }
      this.data.push(value);
    }
    return undefined;
  }

  /** Emit the buffered `data` payload, or nothing when the blank line closed no frame. */
  private dispatch(): string | undefined {
    if (this.data.length === 0) {
      return undefined;
    }
    const payload = this.data.join("\n");
    this.data = [];
    this.size = 0;
    return payload;
  }
}

/** Encode a path identifier without allowing the HTTP client to change its route. */
export function encodePathSegment(value: string): string {
  // ~keep WHATWG URL normalizes even percent-encoded dot segments, so encoding alone is insufficient.
  if (value === "." || value === "..") {
    throw new XbergError("Path identifiers must not be '.' or '..'", { status: 400, body: null });
  }
  return encodeURIComponent(value);
}
