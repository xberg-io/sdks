import { HttpResponse, http } from "msw";
import { afterAll, afterEach, beforeAll, describe, expect, it } from "vitest";
import { XbergClient } from "../src/client.js";
import { GatewayTimeoutError, RateLimitError, RequestTimeoutError, ServerError, XbergError } from "../src/errors.js";
import type { PresignUploadRequest, PresignUploadResponse } from "../src/types.js";
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

describe("method-aware retry policy", () => {
  const PRESIGN: PresignUploadRequest = {
    documents: [{ filename: "a.pdf", mime_type: "application/pdf" }],
  };
  const PRESIGNED: PresignUploadResponse = {
    batch_id: "00000000-0000-0000-0000-000000000001",
    uploads: [],
  };
  const JOB = {
    id: "x",
    filename: "x.pdf",
    status: "completed",
    created_at: "2026-05-09T10:00:00Z",
  };

  function client(sleeps: number[], extra: { retryNonIdempotent?: boolean } = {}): XbergClient {
    return new XbergClient({
      apiKey: "k",
      baseUrl: TEST_BASE_URL,
      retries: 3,
      sleep: async (ms) => {
        sleeps.push(ms);
      },
      ...extra,
    });
  }

  it.each([502, 503, 504])("should_not_retry_a_POST_on_%i_by_default", async (status) => {
    let attempts = 0;
    const sleeps: number[] = [];
    server.use(
      http.post(url("/v1/uploads/presign"), () => {
        attempts += 1;
        return HttpResponse.json({ error: { code: "gateway_timeout", message: "late" } }, { status });
      }),
    );
    await expect(client(sleeps).presignUpload(PRESIGN)).rejects.toBeInstanceOf(ServerError);
    expect(attempts).toBe(1);
    expect(sleeps).toEqual([]);
  });

  it("should_surface_a_GatewayTimeoutError_for_an_unretried_POST_504", async () => {
    server.use(
      http.post(url("/v1/uploads/presign"), () =>
        HttpResponse.json(
          {
            error: {
              code: "gateway_timeout",
              message: "late",
              details: { limit: "handler", timeout_seconds: 30 },
            },
          },
          { status: 504 },
        ),
      ),
    );
    await expect(client([]).presignUpload(PRESIGN)).rejects.toMatchObject({
      name: "GatewayTimeoutError",
      status: 504,
      limit: "handler",
      timeoutSeconds: 30,
    });
  });

  it("should_retry_a_GET_on_504", async () => {
    let attempts = 0;
    const sleeps: number[] = [];
    server.use(
      http.get(url("/v1/jobs/x"), () => {
        attempts += 1;
        return attempts === 1
          ? HttpResponse.json({ error: { code: "gateway_timeout", message: "late" } }, { status: 504 })
          : HttpResponse.json(JOB, { status: 200 });
      }),
    );
    expect((await client(sleeps).getJob("x")).id).toBe("x");
    expect(attempts).toBe(2);
    expect(sleeps).toEqual([200]);
  });

  it("should_retry_a_DELETE_on_503", async () => {
    let attempts = 0;
    server.use(
      http.delete(url("/v1/jobs/x"), () => {
        attempts += 1;
        return attempts === 1
          ? HttpResponse.json({ error: "down" }, { status: 503 })
          : new HttpResponse(null, { status: 204 });
      }),
    );
    await client([]).cancelJob("x");
    expect(attempts).toBe(2);
  });

  it("should_retry_a_POST_on_429_honouring_Retry_After", async () => {
    let attempts = 0;
    const sleeps: number[] = [];
    server.use(
      http.post(url("/v1/uploads/presign"), () => {
        attempts += 1;
        return attempts === 1
          ? HttpResponse.json({ error: "slow down" }, { status: 429, headers: { "retry-after": "7" } })
          : HttpResponse.json(PRESIGNED, { status: 200 });
      }),
    );
    expect(await client(sleeps).presignUpload(PRESIGN)).toEqual(PRESIGNED);
    expect(attempts).toBe(2);
    expect(sleeps).toEqual([7000]);
  });

  it("should_retry_a_POST_on_504_when_retryNonIdempotent_is_set", async () => {
    let attempts = 0;
    server.use(
      http.post(url("/v1/uploads/presign"), () => {
        attempts += 1;
        return attempts === 1
          ? HttpResponse.json({ error: "late" }, { status: 504 })
          : HttpResponse.json(PRESIGNED, { status: 200 });
      }),
    );
    expect(await client([], { retryNonIdempotent: true }).presignUpload(PRESIGN)).toEqual(PRESIGNED);
    expect(attempts).toBe(2);
  });

  it("should_not_retry_a_GET_on_408_by_default", async () => {
    let attempts = 0;
    server.use(
      http.get(url("/v1/jobs/x"), () => {
        attempts += 1;
        return HttpResponse.json(
          {
            error: {
              code: "request_timeout",
              message: "stalled",
              details: { limit: "body_idle", timeout_seconds: 60 },
            },
          },
          { status: 408 },
        );
      }),
    );
    await expect(client([]).getJob("x")).rejects.toBeInstanceOf(RequestTimeoutError);
    expect(attempts).toBe(1);
  });

  it("should_exhaust_GET_retries_on_504_then_throw_GatewayTimeoutError", async () => {
    let attempts = 0;
    server.use(
      http.get(url("/v1/jobs/x"), () => {
        attempts += 1;
        return HttpResponse.json({ error: "late" }, { status: 504 });
      }),
    );
    await expect(client([]).getJob("x")).rejects.toBeInstanceOf(GatewayTimeoutError);
    expect(attempts).toBe(4);
  });
});
