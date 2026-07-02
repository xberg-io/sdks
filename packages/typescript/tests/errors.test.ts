import { HttpResponse, http } from "msw";
import { afterAll, afterEach, beforeAll, describe, expect, it } from "vitest";
import { KreuzbergCloud } from "../src/client.js";
import {
  AuthError,
  KreuzbergError,
  NotFoundError,
  RateLimitError,
  ServerError,
  TimeoutError,
  ValidationError,
} from "../src/errors.js";
import { TEST_BASE_URL, createTestServer, url } from "./_helpers.js";

const server = createTestServer();

beforeAll(() => server.listen({ onUnhandledRequest: "error" }));
afterEach(() => server.resetHandlers());
afterAll(() => server.close());

function makeClient(): KreuzbergCloud {
  return new KreuzbergCloud({
    apiKey: "k",
    baseUrl: TEST_BASE_URL,
    sleep: async () => {},
  });
}

describe("error mapping", () => {
  it("maps 401 to AuthError", async () => {
    server.use(http.get(url("/v1/jobs/x"), () => HttpResponse.json({ error: "unauthorized" }, { status: 401 })));
    await expect(makeClient().getJob("x")).rejects.toBeInstanceOf(AuthError);
  });

  it("maps 403 to AuthError", async () => {
    server.use(http.get(url("/v1/jobs/x"), () => HttpResponse.json({ error: "forbidden" }, { status: 403 })));
    await expect(makeClient().getJob("x")).rejects.toBeInstanceOf(AuthError);
  });

  it("maps 404 to NotFoundError", async () => {
    server.use(http.get(url("/v1/jobs/x"), () => HttpResponse.json({ error: "not found" }, { status: 404 })));
    await expect(makeClient().getJob("x")).rejects.toBeInstanceOf(NotFoundError);
  });

  it("maps 422 to ValidationError", async () => {
    server.use(http.get(url("/v1/jobs/x"), () => HttpResponse.json({ error: "bad input" }, { status: 422 })));
    await expect(makeClient().getJob("x")).rejects.toBeInstanceOf(ValidationError);
  });

  it("maps 400 to ValidationError", async () => {
    server.use(http.get(url("/v1/jobs/x"), () => HttpResponse.json({ error: "bad request" }, { status: 400 })));
    await expect(makeClient().getJob("x")).rejects.toBeInstanceOf(ValidationError);
  });

  it("maps 429 to RateLimitError with retryAfter parsed from Retry-After", async () => {
    server.use(
      http.get(url("/v1/jobs/x"), () =>
        HttpResponse.json({ error: "slow down" }, { status: 429, headers: { "retry-after": "12" } }),
      ),
    );
    try {
      await makeClient().getJob("x");
      throw new Error("expected throw");
    } catch (error) {
      expect(error).toBeInstanceOf(RateLimitError);
      expect((error as RateLimitError).retryAfter).toBe(12);
    }
  });

  it("treats 429 without Retry-After as RateLimitError with no retryAfter", async () => {
    server.use(http.get(url("/v1/jobs/x"), () => HttpResponse.json({ error: "slow down" }, { status: 429 })));
    try {
      await makeClient().getJob("x");
      throw new Error("expected throw");
    } catch (error) {
      expect(error).toBeInstanceOf(RateLimitError);
      expect((error as RateLimitError).retryAfter).toBeUndefined();
    }
  });

  it("maps 500 to ServerError and surfaces the body", async () => {
    server.use(http.get(url("/v1/jobs/x"), () => HttpResponse.json({ error: "boom" }, { status: 500 })));
    try {
      await makeClient().getJob("x");
      throw new Error("expected throw");
    } catch (error) {
      expect(error).toBeInstanceOf(ServerError);
      expect((error as ServerError).status).toBe(500);
      expect((error as ServerError).body).toEqual({ error: "boom" });
    }
  });

  it("maps 503 to ServerError", async () => {
    server.use(http.get(url("/v1/jobs/x"), () => HttpResponse.json({ error: "down" }, { status: 503 })));
    await expect(makeClient().getJob("x")).rejects.toBeInstanceOf(ServerError);
  });

  it("uses the body's `error` field as the message when present", async () => {
    server.use(http.get(url("/v1/jobs/x"), () => HttpResponse.json({ error: "specific reason" }, { status: 500 })));
    try {
      await makeClient().getJob("x");
      throw new Error("expected throw");
    } catch (error) {
      expect((error as Error).message).toContain("specific reason");
    }
  });

  it("falls back to a generic message when the body has no error/message", async () => {
    server.use(
      http.get(url("/v1/jobs/x"), () =>
        HttpResponse.text("oops", { status: 500, headers: { "content-type": "text/plain" } }),
      ),
    );
    try {
      await makeClient().getJob("x");
      throw new Error("expected throw");
    } catch (error) {
      expect((error as Error).message).toContain("oops");
    }
  });

  it("KreuzbergError preserves status and body fields", () => {
    const e = new KreuzbergError("boom", { status: 418, body: { hint: "teapot" } });
    expect(e.status).toBe(418);
    expect(e.body).toEqual({ hint: "teapot" });
    expect(e).toBeInstanceOf(Error);
  });

  it("TimeoutError is its own subclass and instanceof KreuzbergError", () => {
    const e = new TimeoutError("nope", { status: 408, body: null });
    expect(e).toBeInstanceOf(TimeoutError);
    expect(e).toBeInstanceOf(KreuzbergError);
    expect(e).toBeInstanceOf(Error);
  });
});
