import { HttpResponse, http } from "msw";
import { afterAll, afterEach, beforeAll, describe, expect, it } from "vitest";
import { KreuzbergCloud } from "../src/client.js";
import { RateLimitError, ServerError } from "../src/errors.js";
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
    const client = new KreuzbergCloud({
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
          return HttpResponse.json(
            { error: "wait" },
            { status: 429, headers: { "retry-after": "3" } },
          );
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
    const client = new KreuzbergCloud({
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
    const client = new KreuzbergCloud({
      apiKey: "k",
      baseUrl: TEST_BASE_URL,
      retries: 5,
      retryBackoff: "exponential",
      sleep: async (ms) => {
        sleeps.push(ms);
      },
    });
    await client.getJob("x");
    // Three retries: 200, 400, 800 (base 200 doubling)
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
    const client = new KreuzbergCloud({
      apiKey: "k",
      baseUrl: TEST_BASE_URL,
      retries: 2,
      sleep: async () => {},
    });
    await expect(client.getJob("x")).rejects.toBeInstanceOf(ServerError);
    expect(attempts).toBe(3); // initial + 2 retries
  });

  it("does not retry on 401", async () => {
    let attempts = 0;
    server.use(
      http.get(url("/v1/jobs/x"), () => {
        attempts += 1;
        return HttpResponse.json({ error: "no auth" }, { status: 401 });
      }),
    );
    const client = new KreuzbergCloud({
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
    const client = new KreuzbergCloud({
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
    const client = new KreuzbergCloud({
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

  it("propagates RateLimitError after exhausting retries", async () => {
    let attempts = 0;
    server.use(
      http.get(url("/v1/jobs/x"), () => {
        attempts += 1;
        return HttpResponse.json({ error: "wait" }, { status: 429 });
      }),
    );
    const client = new KreuzbergCloud({
      apiKey: "k",
      baseUrl: TEST_BASE_URL,
      retries: 1,
      sleep: async () => {},
    });
    await expect(client.getJob("x")).rejects.toBeInstanceOf(RateLimitError);
    expect(attempts).toBe(2);
  });
});
