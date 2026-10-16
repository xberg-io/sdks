import { HttpResponse, http } from "msw";
import { afterAll, afterEach, beforeAll, describe, expect, it } from "vitest";
import { XbergClient } from "../src/client.js";
import { createTestServer, TEST_BASE_URL } from "./_helpers.js";

const server = createTestServer();
const projectId = "11111111-1111-4111-8111-111111111111";
const jobId = "22222222-2222-4222-8222-222222222222";
const scope = { projectId };
const job = { id: jobId, job_type: "extraction", filename: "invoice.txt", status: "completed" };

beforeAll(() => server.listen({ onUnhandledRequest: "error" }));
afterEach(() => server.resetHandlers());
afterAll(() => server.close());

describe("Pro job project selection", () => {
  it("keeps reads, results, cancellation and polling in the explicitly selected project", async () => {
    const calls: string[] = [];
    server.use(
      http.all(`${TEST_BASE_URL}/v1/jobs*`, ({ request }) => {
        const url = new URL(request.url);
        calls.push(`${request.method} ${url.pathname}`);
        if (url.searchParams.get("project_id") !== projectId) {
          return HttpResponse.json({ error: { code: "job_not_found" } }, { status: 404 });
        }
        if (request.method === "DELETE") return new HttpResponse(null, { status: 204 });
        if (url.pathname.endsWith("/result"))
          return HttpResponse.json({ job_id: jobId, status: "completed", cached: false });
        if (url.pathname === "/v1/jobs") return HttpResponse.json({ jobs: [job], total: 1, limit: 1, offset: 0 });
        return HttpResponse.json(job);
      }),
    );
    const client = new XbergClient({ baseUrl: TEST_BASE_URL, target: "pro" });
    expect((await client.getJob(jobId, scope)).id).toBe(jobId);
    expect((await client.getJobResult(jobId, scope)).job_id).toBe(jobId);
    expect((await client.listJobs({ ...scope, limit: 1, offset: 0 })).jobs[0]?.id).toBe(jobId);
    await client.cancelJob(jobId, scope);
    expect((await client.waitForJob(jobId, scope)).id).toBe(jobId);
    expect((await client.waitForJobs([jobId], scope))[0]?.id).toBe(jobId);
    expect(calls).toHaveLength(6);
  });

  it("applies one project selection to both submission and extractAndWait polling", async () => {
    const calls: string[] = [];
    server.use(
      http.post(`${TEST_BASE_URL}/v1/extract`, ({ request }) => {
        calls.push("extract");
        expect(request.headers.get("x-project-id")).toBe(projectId);
        return HttpResponse.json({ job_ids: [jobId] }, { status: 202 });
      }),
      http.get(`${TEST_BASE_URL}/v1/jobs/${jobId}`, ({ request }) => {
        calls.push("poll");
        expect(new URL(request.url).searchParams.get("project_id")).toBe(projectId);
        return HttpResponse.json(job);
      }),
    );
    const client = new XbergClient({ baseUrl: TEST_BASE_URL, target: "pro", headers: { "x-project-id": "other" } });
    expect((await client.extractAndWait({ ...scope, file: new Uint8Array([1]) })).id).toBe(jobId);
    expect(calls).toEqual(["extract", "poll"]);
  });

  it("rejects Pro project selection on Enterprise before submitting or reading", async () => {
    const client = new XbergClient({ baseUrl: TEST_BASE_URL, target: "enterprise" });
    await expect(client.getJob(jobId, scope)).rejects.toThrow("requires the 'pro' tier");
    await expect(client.extractAndWait({ ...scope, file: new Uint8Array([1]) })).rejects.toThrow(
      "requires the 'pro' tier",
    );
  });
});
