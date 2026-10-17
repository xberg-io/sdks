import { HttpResponse, http } from "msw";
import { afterAll, afterEach, beforeAll, describe, expect, it } from "vitest";
import { XbergClient } from "../src/client.js";
import { RateLimitError, ServerError, XbergError } from "../src/errors.js";
import { TEST_BASE_URL, createTestServer, url } from "./_helpers.js";

const server = createTestServer();

beforeAll(() => server.listen({ onUnhandledRequest: "error" }));
afterEach(() => server.resetHandlers());
afterAll(() => server.close());

describe("retry/backoff", () => {
  it("retries 503 responses up to the configured limit and succeeds", async () => {
    let attempts = 0;
    server.use(
      http.get(url("/v1/jobs/x"), () => {
        attempts += 1;
        if (attempts < 3) {
          return HttpResponse.json({ error: "down" }, { status: 503 });
        }
        return HttpResponse.json(
          {
            id: "x",
            filename: "x.pdf",
            status: "completed",
            created_at: "2026-05-09T10:00:00Z",
          },
          { status: 200 },
        );
      }),
    );
    const client = new XbergClient({
      apiKey: "k",
      baseUrl: TEST_BASE_URL,
      retries: 5,
      sleep: async () => {},
    });
    const job = await client.getJob("x");
    expect(job.id).toBe("x");
    expect(attempts).toBe(3);
  });

  it("retries 429 responses honoring Retry-After (seconds)", async () => {
    const sleeps: number[] = [];
    let attempts = 0;
    server.use(
      http.get(url("/v1/jobs/x"), () => {
        attempts += 1;
        if (attempts === 1) {
          return HttpResponse.json({ error: "wait" }, { status: 429, headers: { "retry-after": "3" } });
        }
        return HttpResponse.json(
          {
            id: "x",
            filename: "x.pdf",
            status: "completed",
            created_at: "2026-05-09T10:00:00Z",
          },
          { status: 200 },
        );
      }),
    );
    const client = new XbergClient({
      apiKey: "k",
      baseUrl: TEST_BASE_URL,
      retries: 1,
      sleep: async (ms) => {
        sleeps.push(ms);
      },
    });
    await client.getJob("x");
    expect(sleeps).toEqual([3000]);
  });

  it("uses exponential backoff intervals when Retry-After is absent", async () => {
    const sleeps: number[] = [];
    let attempts = 0;
    server.use(
      http.get(url("/v1/jobs/x"), () => {
        attempts += 1;
        if (attempts < 4) {
          return HttpResponse.json({ error: "down" }, { status: 502 });
        }
        return HttpResponse.json(
          {
            id: "x",
            filename: "x.pdf",
            status: "completed",
            created_at: "2026-05-09T10:00:00Z",
          },
          { status: 200 },
        );
      }),
    );
    const client = new XbergClient({
      apiKey: "k",
      baseUrl: TEST_BASE_URL,
      retries: 5,
      retryBackoff: "exponential",
      sleep: async (ms) => {
        sleeps.push(ms);
      },
    });
    await client.getJob("x");
    expect(sleeps).toEqual([200, 400, 800]);
  });

  it("throws when retries are exhausted", async () => {
    let attempts = 0;
    server.use(
      http.get(url("/v1/jobs/x"), () => {
        attempts += 1;
        return HttpResponse.json({ error: "still down" }, { status: 503 });
      }),
    );
    const client = new XbergClient({
      apiKey: "k",
      baseUrl: TEST_BASE_URL,
      retries: 2,
      sleep: async () => {},
    });
    await expect(client.getJob("x")).rejects.toBeInstanceOf(ServerError);
    expect(attempts).toBe(3);
  });

  it("does not retry on 401", async () => {
    let attempts = 0;
    server.use(
      http.get(url("/v1/jobs/x"), () => {
        attempts += 1;
        return HttpResponse.json({ error: "no auth" }, { status: 401 });
      }),
    );
    const client = new XbergClient({
      apiKey: "k",
      baseUrl: TEST_BASE_URL,
      retries: 5,
      sleep: async () => {},
    });
    await expect(client.getJob("x")).rejects.toThrow();
    expect(attempts).toBe(1);
  });

  it("retries on a custom retryOn list", async () => {
    let attempts = 0;
    server.use(
      http.get(url("/v1/jobs/x"), () => {
        attempts += 1;
        if (attempts === 1) {
          return HttpResponse.json({ error: "teapot" }, { status: 418 });
        }
        return HttpResponse.json(
          {
            id: "x",
            filename: "x.pdf",
            status: "completed",
            created_at: "2026-05-09T10:00:00Z",
          },
          { status: 200 },
        );
      }),
    );
    const client = new XbergClient({
      apiKey: "k",
      baseUrl: TEST_BASE_URL,
      retries: 2,
      retryOn: [418],
      sleep: async () => {},
    });
    const job = await client.getJob("x");
    expect(job.id).toBe("x");
    expect(attempts).toBe(2);
  });

  it.each([{ retryOn: [] }, { retryOn: [503] }])(
    "should_not_retry_429_with_retry_after_when_retry_on_is_$retryOn",
    async ({ retryOn }) => {
      let attempts = 0;
      const sleeps: number[] = [];
      server.use(
        http.get(url("/v1/jobs/x"), () => {
          attempts += 1;
          return HttpResponse.json({ error: "wait" }, { status: 429, headers: { "retry-after": "3" } });
        }),
      );
      const client = new XbergClient({
        apiKey: "k",
        baseUrl: TEST_BASE_URL,
        retries: 2,
        retryOn,
        sleep: async (ms) => {
          sleeps.push(ms);
        },
      });

      await expect(client.getJob("x")).rejects.toMatchObject({
        name: "RateLimitError",
        status: 429,
        retryAfter: 3,
        body: { error: "wait" },
      });
      expect(attempts).toBe(1);
      expect(sleeps).toEqual([]);
    },
  );

  it("constant backoff keeps the same delay across attempts", async () => {
    const sleeps: number[] = [];
    let attempts = 0;
    server.use(
      http.get(url("/v1/jobs/x"), () => {
        attempts += 1;
        if (attempts < 4) {
          return HttpResponse.json({ error: "down" }, { status: 502 });
        }
        return HttpResponse.json(
          {
            id: "x",
            filename: "x.pdf",
            status: "completed",
            created_at: "2026-05-09T10:00:00Z",
          },
          { status: 200 },
        );
      }),
    );
    const client = new XbergClient({
      apiKey: "k",
      baseUrl: TEST_BASE_URL,
      retries: 5,
      retryBackoff: "constant",
      sleep: async (ms) => {
        sleeps.push(ms);
      },
    });
    await client.getJob("x");
    expect(sleeps).toEqual([200, 200, 200]);
  });

  it("retries a network error (fetch throws) up to the configured limit then throws XbergError", async () => {
    let calls = 0;
    const client = new XbergClient({
      apiKey: "k",
      baseUrl: TEST_BASE_URL,
      retries: 2,
      sleep: async () => {},
      fetch: (async () => {
        calls += 1;
        throw new Error("network down");
      }) as typeof fetch,
    });
    await expect(client.getJob("x")).rejects.toBeInstanceOf(XbergError);
    expect(calls).toBe(3);
  });

  it("retries a network error and eventually succeeds", async () => {
    let calls = 0;
    const client = new XbergClient({
      apiKey: "k",
      baseUrl: TEST_BASE_URL,
      retries: 2,
      sleep: async () => {},
      fetch: (async (_input: RequestInfo | URL, _init?: RequestInit) => {
        calls += 1;
        if (calls < 2) {
          throw new Error("network down");
        }
        return new Response(
          JSON.stringify({ id: "x", filename: "x.pdf", status: "completed", created_at: "2026-05-09T10:00:00Z" }),
          { status: 200, headers: { "content-type": "application/json" } },
        );
      }) as typeof fetch,
    });
    const job = await client.getJob("x");
    expect(job.id).toBe("x");
    expect(calls).toBe(2);
  });

  it("retries a 429 with an HTTP-date Retry-After header", async () => {
    const sleeps: number[] = [];
    let attempts = 0;
    const future = new Date(Date.now() + 5000).toUTCString();
    server.use(
      http.get(url("/v1/jobs/x"), () => {
        attempts += 1;
        if (attempts === 1) {
          return HttpResponse.json({ error: "wait" }, { status: 429, headers: { "retry-after": future } });
        }
        return HttpResponse.json(
          { id: "x", filename: "x.pdf", status: "completed", created_at: "2026-05-09T10:00:00Z" },
          { status: 200 },
        );
      }),
    );
    const client = new XbergClient({
      apiKey: "k",
      baseUrl: TEST_BASE_URL,
      retries: 1,
      sleep: async (ms) => {
        sleeps.push(ms);
      },
    });
    await client.getJob("x");
    expect(sleeps.length).toBe(1);
    expect(sleeps[0]).toBeGreaterThan(0);
  });

  it("falls back to interval backoff when Retry-After is unparseable", async () => {
    const sleeps: number[] = [];
    let attempts = 0;
    server.use(
      http.get(url("/v1/jobs/x"), () => {
        attempts += 1;
        if (attempts === 1) {
          return HttpResponse.json({ error: "wait" }, { status: 429, headers: { "retry-after": "not-a-value" } });
        }
        return HttpResponse.json(
          { id: "x", filename: "x.pdf", status: "completed", created_at: "2026-05-09T10:00:00Z" },
          { status: 200 },
        );
      }),
    );
    const client = new XbergClient({
      apiKey: "k",
      baseUrl: TEST_BASE_URL,
      retries: 1,
      sleep: async (ms) => {
        sleeps.push(ms);
      },
    });
    await client.getJob("x");
    expect(sleeps).toEqual([200]);
  });

  it("propagates RateLimitError after exhausting retries", async () => {
    let attempts = 0;
    server.use(
      http.get(url("/v1/jobs/x"), () => {
        attempts += 1;
        return HttpResponse.json({ error: "wait" }, { status: 429 });
      }),
    );
    const client = new XbergClient({
      apiKey: "k",
      baseUrl: TEST_BASE_URL,
      retries: 1,
      sleep: async () => {},
    });
    await expect(client.getJob("x")).rejects.toBeInstanceOf(RateLimitError);
    expect(attempts).toBe(2);
  });
});
