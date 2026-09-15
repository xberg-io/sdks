import { HttpResponse, http } from "msw";
import { afterAll, afterEach, beforeAll, describe, expect, it } from "vitest";
import { XbergClient } from "../src/client.js";
import { NotFoundError, ServerError, XbergError } from "../src/errors.js";
import type { CrawlEvent } from "../src/types.js";
import { EventStreamDecoder } from "../src/_internal.js";
import { TEST_BASE_URL, createTestServer, url } from "./_helpers.js";

/**
 * `GET /v1/crawl-jobs/{id}/events` is the one Enterprise operation that answers
 * `text/event-stream`. The frames below are written as real SSE framing —
 * blank-line terminated, payloads spread over several `data:` lines, heartbeat
 * comments interleaved — because a decoder that splits on newlines and calls
 * `JSON.parse` per line passes a friendly server and fails a real one.
 */

const server = createTestServer();

beforeAll(() => server.listen({ onUnhandledRequest: "error" }));
afterEach(() => server.resetHandlers());
afterAll(() => server.close());

const CRAWL_JOB_ID = "7c9e6679-7425-40de-944b-e07fc1f90ae7";
const EVENTS_PATH = `/v1/crawl-jobs/${CRAWL_JOB_ID}/events`;
const TS = "2026-05-09T10:00:00Z";
const PRO_URL = "https://pro.example.test";

const PAGE_EVENT = {
  kind: "page",
  crawl_job_id: CRAWL_JOB_ID,
  ts: TS,
  url: "https://example.com/docs",
  status_code: 200,
  depth: 1,
};
const DISCOVERED_EVENT = {
  kind: "discovered",
  crawl_job_id: CRAWL_JOB_ID,
  ts: TS,
  url: "https://example.com/docs/api",
  depth: 2,
};
const ERROR_EVENT = {
  kind: "error",
  crawl_job_id: CRAWL_JOB_ID,
  ts: TS,
  url: "https://example.com/gone",
  error: "404 Not Found",
};
const COMPLETE_EVENT = {
  kind: "complete",
  crawl_job_id: CRAWL_JOB_ID,
  ts: TS,
  pages_crawled: 12,
};

function makeClient(): XbergClient {
  return new XbergClient({
    apiKey: "k",
    baseUrl: TEST_BASE_URL,
    target: "enterprise",
    sleep: async () => {},
  });
}

/** Render one compact JSON event as a single-line, blank-line-terminated SSE frame. */
function frame(event: unknown): string {
  return `data: ${JSON.stringify(event)}\n\n`;
}

interface StreamProbe {
  stream: ReadableStream<Uint8Array>;
  /** True once the consumer cancelled the body — the property the leak tests assert. */
  wasCancelled: () => boolean;
}

/**
 * A response body that hands out `chunks` one per pull. Chunks are network
 * chunks, not lines: a test can split one frame across several to prove the
 * decoder reassembles them.
 */
function eventStream(chunks: readonly string[], { repeat = false } = {}): StreamProbe {
  const encoder = new TextEncoder();
  let index = 0;
  let cancelled = false;
  const stream = new ReadableStream<Uint8Array>({
    pull(controller) {
      if (index >= chunks.length) {
        if (!repeat) {
          controller.close();
          return;
        }
        index = 0;
      }
      controller.enqueue(encoder.encode(chunks[index] as string));
      index += 1;
    },
    cancel() {
      cancelled = true;
    },
  });
  return { stream, wasCancelled: () => cancelled };
}

/**
 * A client whose `fetch` answers straight from `probe`, bypassing msw.
 *
 * msw proxies a mocked `ReadableStream` body through its own interceptor and
 * does not forward a downstream `cancel()` back to the source, so a
 * "did the client hang up?" assertion made through msw can only ever time out.
 * These few tests therefore hand the client a `Response` over the very stream
 * they assert on — everything about the client under test is unchanged, only
 * the transport is one hop shorter.
 */
function clientOverStream(probe: StreamProbe, seen: { signal?: AbortSignal | null } = {}): XbergClient {
  return new XbergClient({
    apiKey: "k",
    baseUrl: TEST_BASE_URL,
    target: "enterprise",
    sleep: async () => {},
    fetch: async (_input, init) => {
      seen.signal = init?.signal ?? null;
      return new Response(probe.stream, {
        status: 200,
        headers: { "Content-Type": "text/event-stream" },
      });
    },
  });
}

function respondWith(probe: StreamProbe): void {
  server.use(
    http.get(
      url(EVENTS_PATH),
      () =>
        new HttpResponse(probe.stream, {
          status: 200,
          headers: { "Content-Type": "text/event-stream" },
        }),
    ),
  );
}

async function collect(events: AsyncIterable<CrawlEvent>): Promise<CrawlEvent[]> {
  const collected: CrawlEvent[] = [];
  for await (const event of events) {
    collected.push(event);
  }
  return collected;
}

describe("streamCrawlEvents", () => {
  it("parses each of the four event kinds", async () => {
    let accept = "";
    server.use(
      http.get(url(EVENTS_PATH), ({ request }) => {
        accept = request.headers.get("accept") ?? "";
        return new HttpResponse(
          eventStream([frame(PAGE_EVENT), frame(DISCOVERED_EVENT), frame(ERROR_EVENT), frame(COMPLETE_EVENT)]).stream,
          { status: 200, headers: { "Content-Type": "text/event-stream" } },
        );
      }),
    );

    const events = await collect(makeClient().streamCrawlEvents(CRAWL_JOB_ID));

    expect(events.map((event) => event.kind)).toEqual(["page", "discovered", "error", "complete"]);
    expect(events[0]).toEqual(PAGE_EVENT);
    expect(events[1]).toEqual(DISCOVERED_EVENT);
    expect(events[2]).toEqual(ERROR_EVENT);
    expect(events[3]).toEqual(COMPLETE_EVENT);
    expect(accept).toBe("text/event-stream");
  });

  it("narrows on kind without an assertion", async () => {
    respondWith(eventStream([frame(PAGE_EVENT), frame(COMPLETE_EVENT)]));

    const seen: string[] = [];
    for await (const event of makeClient().streamCrawlEvents(CRAWL_JOB_ID)) {
      if (event.kind === "page") {
        seen.push(`${event.url}:${event.status_code}:${event.depth}`);
      } else if (event.kind === "complete") {
        seen.push(`complete:${event.pages_crawled}`);
      }
    }

    expect(seen).toEqual(["https://example.com/docs:200:1", "complete:12"]);
  });

  it("joins a payload spread over several data: lines and ignores comment lines", async () => {
    const multiline = [
      ": heartbeat",
      "event: message",
      "id: 42",
      "data: {",
      `data:   "kind": "page", "crawl_job_id": "${CRAWL_JOB_ID}",`,
      `data:   "ts": "${TS}", "url": "https://example.com/split",`,
      'data:   "status_code": 201, "depth": 3',
      "data: }",
      "",
      ": heartbeat",
      "",
      "",
    ].join("\n");
    respondWith(eventStream([multiline, frame(COMPLETE_EVENT)]));

    const events = await collect(makeClient().streamCrawlEvents(CRAWL_JOB_ID));

    expect(events.map((event) => event.kind)).toEqual(["page", "complete"]);
    const page = events[0];
    if (page?.kind !== "page") {
      throw new Error("expected the page arm");
    }
    expect(page.url).toBe("https://example.com/split");
    expect(page.status_code).toBe(201);
    expect(page.depth).toBe(3);
  });

  it("reassembles a frame split across network chunks, including a \\r\\n cut in half", async () => {
    const payload = JSON.stringify(PAGE_EVENT);
    respondWith(
      eventStream(["data: " + payload.slice(0, 10), payload.slice(10) + "\r", "\n\r\n", frame(COMPLETE_EVENT)]),
    );

    const events = await collect(makeClient().streamCrawlEvents(CRAWL_JOB_ID));

    expect(events.map((event) => event.kind)).toEqual(["page", "complete"]);
    expect(events[0]).toEqual(PAGE_EVENT);
  });

  it("treats data:{...} and data: {...} as the same frame", async () => {
    respondWith(eventStream([`data:${JSON.stringify(COMPLETE_EVENT)}\n\n`]));

    const events = await collect(makeClient().streamCrawlEvents(CRAWL_JOB_ID));

    expect(events).toEqual([COMPLETE_EVENT]);
  });

  it("discards a trailing frame the stream ended before terminating", async () => {
    respondWith(eventStream([frame(PAGE_EVENT), `data: ${JSON.stringify(COMPLETE_EVENT)}\n`]));

    const events = await collect(makeClient().streamCrawlEvents(CRAWL_JOB_ID));

    expect(events.map((event) => event.kind)).toEqual(["page"]);
  });

  it("rejects a frame carrying an unrecognised kind", async () => {
    respondWith(eventStream([frame({ ...PAGE_EVENT, kind: "teleported" })]));

    await expect(collect(makeClient().streamCrawlEvents(CRAWL_JOB_ID))).rejects.toThrow(/unrecognised kind/);
  });

  it("rejects a frame that is not JSON", async () => {
    respondWith(eventStream(["data: not json at all\n\n"]));

    await expect(collect(makeClient().streamCrawlEvents(CRAWL_JOB_ID))).rejects.toThrow(/non-JSON frame/);
  });

  it("cancels the response body when the caller breaks out of the loop", async () => {
    // A stream that never ends: if breaking out did not cancel the body the
    // connection would stay open for as long as the process lives.
    const probe = eventStream([frame(PAGE_EVENT)], { repeat: true });

    let received = 0;
    for await (const event of clientOverStream(probe).streamCrawlEvents(CRAWL_JOB_ID)) {
      expect(event.kind).toBe("page");
      received += 1;
      break;
    }

    expect(received).toBe(1);
    expect(probe.wasCancelled()).toBe(true);
  });

  it("cancels the response body when the caller returns early from the loop", async () => {
    const probe = eventStream([frame(PAGE_EVENT)], { repeat: true });
    const client = clientOverStream(probe);

    const firstUrl = await (async (): Promise<string | undefined> => {
      for await (const event of client.streamCrawlEvents(CRAWL_JOB_ID)) {
        if (event.kind === "page") {
          return event.url;
        }
      }
      return undefined;
    })();

    expect(firstUrl).toBe("https://example.com/docs");
    expect(probe.wasCancelled()).toBe(true);
  });

  it("cancels the response body when a frame fails to parse", async () => {
    const probe = eventStream([frame({ ...PAGE_EVENT, kind: "teleported" }), frame(COMPLETE_EVENT)]);

    await expect(collect(clientOverStream(probe).streamCrawlEvents(CRAWL_JOB_ID))).rejects.toThrow(XbergError);
    expect(probe.wasCancelled()).toBe(true);
  });

  it("forwards an external AbortSignal to the underlying request", async () => {
    const probe = eventStream([frame(COMPLETE_EVENT)]);
    const seen: { signal?: AbortSignal | null } = {};
    const controller = new AbortController();

    await collect(clientOverStream(probe, seen).streamCrawlEvents(CRAWL_JOB_ID, { signal: controller.signal }));

    expect(seen.signal).toBe(controller.signal);
  });

  it("attaches no timeout signal of its own — a subscription is idle between events by design", async () => {
    const probe = eventStream([frame(COMPLETE_EVENT)]);
    const seen: { signal?: AbortSignal | null } = {};

    await collect(clientOverStream(probe, seen).streamCrawlEvents(CRAWL_JOB_ID));

    expect(seen.signal).toBeNull();
  });

  it("does not retry a retryable status: a replayed stream would redeliver events", async () => {
    let attempts = 0;
    server.use(
      http.get(url(EVENTS_PATH), () => {
        attempts += 1;
        return HttpResponse.json({ error: "no NATS" }, { status: 503 });
      }),
    );
    const client = new XbergClient({
      apiKey: "k",
      baseUrl: TEST_BASE_URL,
      target: "enterprise",
      retries: 3,
      sleep: async () => {},
    });

    await expect(collect(client.streamCrawlEvents(CRAWL_JOB_ID))).rejects.toThrow(ServerError);
    expect(attempts).toBe(1);
  });

  it("maps a 404 to the typed error", async () => {
    server.use(http.get(url(EVENTS_PATH), () => HttpResponse.json({ error: "no such crawl job" }, { status: 404 })));

    await expect(collect(makeClient().streamCrawlEvents(CRAWL_JOB_ID))).rejects.toThrow(NotFoundError);
  });

  // ~keep Pro declares this operation too; the client used to refuse it outright.
  it("streams on the pro tier instead of refusing", async () => {
    let requested = false;
    server.use(
      http.get(`${PRO_URL}${EVENTS_PATH}`, () => {
        requested = true;
        return new HttpResponse(eventStream([frame(COMPLETE_EVENT)]).stream, {
          status: 200,
          headers: { "Content-Type": "text/event-stream" },
        });
      }),
    );
    const client = new XbergClient({
      apiKey: "k",
      baseUrl: PRO_URL,
      target: "pro",
      sleep: async () => {},
    });

    expect(await collect(client.streamCrawlEvents(CRAWL_JOB_ID))).toEqual([COMPLETE_EVENT]);
    expect(requested).toBe(true);
  });

  it("requests nothing until iteration begins", async () => {
    let requested = false;
    server.use(
      http.get(url(EVENTS_PATH), () => {
        requested = true;
        return new HttpResponse(eventStream([frame(COMPLETE_EVENT)]).stream, {
          status: 200,
          headers: { "Content-Type": "text/event-stream" },
        });
      }),
    );

    const events = makeClient().streamCrawlEvents(CRAWL_JOB_ID);
    expect(requested).toBe(false);

    await collect(events);
    expect(requested).toBe(true);
  });
  // Driven against the decoder rather than through `msw`: a body large enough
  // to trip the cap is large enough to make the mock server the slow part of
  // the test, and the guard being proved lives entirely in the decoder.
  it("caps a frame whose data lines never reach a blank line", () => {
    const decoder = new EventStreamDecoder();
    // 64 KiB per line stays well under the per-line cap, so this is the other
    // shape — an endless succession of ordinary lines with no frame terminator.
    const line = `data: ${"x".repeat(64 * 1024)}\n`;
    expect(() => {
      for (let index = 0; index < 20; index += 1) {
        decoder.push(line);
      }
    }).toThrow(XbergError);
  });

  it("caps a single line that never ends", () => {
    const decoder = new EventStreamDecoder();
    expect(() => {
      for (let index = 0; index < 20; index += 1) {
        decoder.push("x".repeat(64 * 1024)); // no terminator, ever
      }
    }).toThrow(/longer than/);
  });
});
