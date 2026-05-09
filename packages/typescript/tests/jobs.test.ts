import { HttpResponse, http } from "msw";
import { afterAll, afterEach, beforeAll, describe, expect, it } from "vitest";
import { KreuzbergCloud } from "../src/client.js";
import { TimeoutError } from "../src/errors.js";
import type { Job } from "../src/types.js";
import { TEST_BASE_URL, createTestServer, url } from "./_helpers.js";

const server = createTestServer();

beforeAll(() => server.listen({ onUnhandledRequest: "error" }));
afterEach(() => server.resetHandlers());
afterAll(() => server.close());

const FIXED_NOW = "2026-05-09T10:00:00Z";

function makeJob(overrides: Partial<Job> & { id: string; status: Job["status"] }): Job {
  return {
    id: overrides.id,
    filename: overrides.filename ?? "x.pdf",
    status: overrides.status,
    created_at: overrides.created_at ?? FIXED_NOW,
    ...(overrides.result !== undefined ? { result: overrides.result } : {}),
  };
}

function makeClient(sleeps: number[] = []): KreuzbergCloud {
  const recorded = sleeps;
  return new KreuzbergCloud({
    apiKey: "k",
    baseUrl: TEST_BASE_URL,
    sleep: async (ms) => {
      recorded.push(ms);
    },
  });
}

describe("getJob", () => {
  it("fetches and returns the job record", async () => {
    server.use(
      http.get(url("/v1/jobs/job-1"), () =>
        HttpResponse.json(makeJob({ id: "job-1", status: "completed" }), { status: 200 }),
      ),
    );
    const client = makeClient();
    const job = await client.getJob("job-1");
    expect(job.id).toBe("job-1");
    expect(job.status).toBe("completed");
  });

  it("URL-encodes the job ID path segment", async () => {
    let receivedPath: string | null = null;
    server.use(
      http.get(url("/v1/jobs/:id"), ({ params, request }) => {
        receivedPath = new URL(request.url).pathname;
        return HttpResponse.json(makeJob({ id: String(params["id"]), status: "completed" }), {
          status: 200,
        });
      }),
    );
    const client = makeClient();
    await client.getJob("a/b c");
    expect(receivedPath).toBe("/v1/jobs/a%2Fb%20c");
  });
});

describe("waitForJob", () => {
  it("returns immediately when the first poll already shows completed", async () => {
    server.use(
      http.get(url("/v1/jobs/job-1"), () =>
        HttpResponse.json(makeJob({ id: "job-1", status: "completed" }), { status: 200 }),
      ),
    );
    const client = makeClient();
    const result = await client.waitForJob("job-1");
    expect(result.status).toBe("completed");
  });

  it("polls until the job reaches a terminal status", async () => {
    let calls = 0;
    server.use(
      http.get(url("/v1/jobs/job-1"), () => {
        calls += 1;
        const status: Job["status"] = calls < 3 ? "processing" : "completed";
        return HttpResponse.json(makeJob({ id: "job-1", status }), { status: 200 });
      }),
    );
    const client = makeClient();
    const result = await client.waitForJob("job-1", { pollIntervalMs: 5 });
    expect(result.status).toBe("completed");
    expect(calls).toBe(3);
  });

  it("treats partial_success as a successful terminal status", async () => {
    server.use(
      http.get(url("/v1/jobs/job-1"), () =>
        HttpResponse.json(makeJob({ id: "job-1", status: "partial_success" }), { status: 200 }),
      ),
    );
    const client = makeClient();
    const result = await client.waitForJob("job-1");
    expect(result.status).toBe("partial_success");
  });

  it("throws KreuzbergError when the job ends as failed", async () => {
    server.use(
      http.get(url("/v1/jobs/job-1"), () =>
        HttpResponse.json(makeJob({ id: "job-1", status: "failed" }), { status: 200 }),
      ),
    );
    const client = makeClient();
    await expect(client.waitForJob("job-1")).rejects.toThrow(/failed/);
  });

  it("throws KreuzbergError when the job ends as cancelled", async () => {
    server.use(
      http.get(url("/v1/jobs/job-1"), () =>
        HttpResponse.json(makeJob({ id: "job-1", status: "cancelled" }), { status: 200 }),
      ),
    );
    const client = makeClient();
    await expect(client.waitForJob("job-1")).rejects.toThrow(/cancelled/);
  });

  it("throws TimeoutError when the wait deadline is exceeded", async () => {
    server.use(
      http.get(url("/v1/jobs/job-1"), () =>
        HttpResponse.json(makeJob({ id: "job-1", status: "processing" }), { status: 200 }),
      ),
    );
    const client = makeClient();
    await expect(
      client.waitForJob("job-1", { timeoutMs: 1, pollIntervalMs: 1 }),
    ).rejects.toBeInstanceOf(TimeoutError);
  });

  it("uses exponential backoff between polls by default", async () => {
    const recorded: number[] = [];
    let calls = 0;
    server.use(
      http.get(url("/v1/jobs/job-1"), () => {
        calls += 1;
        const status: Job["status"] = calls < 4 ? "processing" : "completed";
        return HttpResponse.json(makeJob({ id: "job-1", status }), { status: 200 });
      }),
    );
    const client = new KreuzbergCloud({
      apiKey: "k",
      baseUrl: TEST_BASE_URL,
      sleep: async (ms) => {
        recorded.push(ms);
      },
    });
    await client.waitForJob("job-1", { pollIntervalMs: 10 });
    // 3 sleeps before the 4th poll returns completed; intervals 10, 20, 40
    expect(recorded).toEqual([10, 20, 40]);
  });

  it("uses constant intervals when backoff: 'constant' is set", async () => {
    const recorded: number[] = [];
    let calls = 0;
    server.use(
      http.get(url("/v1/jobs/job-1"), () => {
        calls += 1;
        const status: Job["status"] = calls < 4 ? "processing" : "completed";
        return HttpResponse.json(makeJob({ id: "job-1", status }), { status: 200 });
      }),
    );
    const client = new KreuzbergCloud({
      apiKey: "k",
      baseUrl: TEST_BASE_URL,
      sleep: async (ms) => {
        recorded.push(ms);
      },
    });
    await client.waitForJob("job-1", { pollIntervalMs: 10, backoff: "constant" });
    expect(recorded).toEqual([10, 10, 10]);
  });

  it("waitForJobs resolves all jobs in parallel", async () => {
    const completedFor = new Set<string>();
    server.use(
      http.get(url("/v1/jobs/:id"), ({ params }) => {
        const id = String(params["id"]);
        completedFor.add(id);
        return HttpResponse.json(makeJob({ id, status: "completed" }), { status: 200 });
      }),
    );
    const client = makeClient();
    const results = await client.waitForJobs(["a", "b", "c"]);
    expect(results.map((r) => r.id).sort()).toEqual(["a", "b", "c"]);
    expect([...completedFor].sort()).toEqual(["a", "b", "c"]);
  });
});
