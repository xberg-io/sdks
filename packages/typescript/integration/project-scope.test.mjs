import assert from "node:assert/strict";
import { once } from "node:events";
import { createServer } from "node:http";
import test from "node:test";
import { XbergClient } from "../dist/index.js";

const PROJECT = "11111111-1111-4111-8111-111111111111";
const JOB = "22222222-2222-4222-8222-222222222222";
const job = { id: JOB, job_type: "extraction", filename: "invoice.txt", status: "completed" };

async function fixture(tier, scoped, operation) {
  const calls = [];
  const server = createServer((request, response) => {
    const url = new URL(request.url, "http://fixture.local");
    calls.push({
      method: request.method,
      path: url.pathname,
      query: url.search,
      projectHeader: request.headers["x-project-id"],
    });
    response.setHeader("Content-Type", "application/json");
    if (url.pathname === "/healthz") {
      response.end(JSON.stringify({ tier }));
      return;
    }
    if (url.pathname === "/v1/extract") {
      if (scoped && request.headers["x-project-id"] !== PROJECT) {
        response.statusCode = 400;
        response.end("{}");
        return;
      }
      response.statusCode = 202;
      response.end(JSON.stringify({ job_ids: [JOB] }));
      return;
    }
    if (scoped && url.searchParams.get("project_id") !== PROJECT) {
      response.statusCode = 404;
      response.end(JSON.stringify({ error: { code: "job_not_found" } }));
      return;
    }
    if (request.method === "DELETE") {
      response.statusCode = 204;
      response.end();
      return;
    }
    if (url.pathname === "/v1/jobs") response.end(JSON.stringify({ jobs: [job], limit: 1, offset: 0, total: 1 }));
    else if (url.pathname.endsWith("/result"))
      response.end(
        JSON.stringify({ job_id: JOB, status: "completed", cached: false, results: [{ content: "Invoice 42" }] }),
      );
    else response.end(JSON.stringify(job));
  });
  server.listen(0, "127.0.0.1");
  await once(server, "listening");
  try {
    await operation(`http://127.0.0.1:${server.address().port}`, calls);
  } finally {
    await new Promise((resolve) => {
      server.close(resolve);
    });
  }
}

test("scoped Pro extraction, reads, pagination, cancellation and polling stay in the same selected project", async () => {
  await fixture("pro", true, async (baseUrl, calls) => {
    const client = new XbergClient({ baseUrl, target: "pro", retries: 0, headers: { "X-Project-ID": PROJECT } });
    const scope = { projectId: PROJECT };
    assert.equal((await client.getJob(JOB, scope)).id, JOB);
    assert.equal((await client.listJobs({ ...scope, limit: 1, offset: 0 })).jobs[0].id, JOB);
    assert.equal((await client.getJobResult(JOB, scope)).job_id, JOB);
    await client.cancelJob(JOB, scope);
    assert.equal((await client.waitForJob(JOB, scope)).id, JOB);
    assert.equal((await client.waitForJobs([JOB], scope))[0].id, JOB);
    const withoutDefaultHeader = new XbergClient({ baseUrl, target: "pro", retries: 0 });
    assert.equal(
      (
        await withoutDefaultHeader.extractAndWait({
          ...scope,
          file: { name: "invoice.txt", data: new TextEncoder().encode("Invoice 42") },
        })
      ).id,
      JOB,
    );
    assert.equal(calls.length, 8);
    for (const call of calls) {
      if (call.path === "/v1/extract") {
        assert.equal(call.projectHeader, PROJECT);
        assert.equal(call.query, "");
      } else assert.equal(new URLSearchParams(call.query).get("project_id"), PROJECT);
    }
  });
});

test("unscoped Pro and Enterprise retain their original request URLs without discovery", async () => {
  for (const tier of ["pro", "enterprise"])
    await fixture(tier, false, async (baseUrl, calls) => {
      const client = new XbergClient({ baseUrl, target: tier, retries: 0 });
      await client.getJob(JOB);
      await client.getJobResult(JOB);
      await client.listJobs({ limit: 1, offset: 0 });
      await client.cancelJob(JOB);
      assert.deepEqual(
        calls.map(({ method, path, query }) => ({ method, path, query })),
        [
          { method: "GET", path: `/v1/jobs/${JOB}`, query: "" },
          { method: "GET", path: `/v1/jobs/${JOB}/result`, query: "" },
          { method: "GET", path: "/v1/jobs", query: "?limit=1&offset=0" },
          { method: "DELETE", path: `/v1/jobs/${JOB}`, query: "" },
        ],
      );
    });
});

test("explicit Enterprise rejects Pro project selection before any product request", async () => {
  await fixture("enterprise", false, async (baseUrl, calls) => {
    const client = new XbergClient({ baseUrl, target: "enterprise", retries: 0 });
    const scope = { projectId: PROJECT };
    for (const operation of [
      () => client.getJob(JOB, scope),
      () => client.getJobResult(JOB, scope),
      () => client.cancelJob(JOB, scope),
      () => client.listJobs(scope),
      () => client.waitForJob(JOB, scope),
      () => client.extractAndWait({ ...scope, file: new Uint8Array([1]) }),
    ]) {
      await assert.rejects(operation(), /requires the 'pro' tier/);
    }
    assert.deepEqual(calls, []);
  });
});

test("automatic tier selection probes once and never sends a Pro scope to Enterprise", async () => {
  for (const tier of ["pro", "enterprise"])
    await fixture(tier, true, async (baseUrl, calls) => {
      const client = new XbergClient({ baseUrl, retries: 0 });
      if (tier === "enterprise") {
        await assert.rejects(client.getJob(JOB, { projectId: PROJECT }), /requires the 'pro' tier/);
        assert.deepEqual(
          calls.map((call) => call.path),
          ["/healthz"],
        );
      } else {
        await client.getJob(JOB, { projectId: PROJECT });
        await client.getJobResult(JOB, { projectId: PROJECT });
        assert.deepEqual(
          calls.map((call) => call.path),
          ["/healthz", `/v1/jobs/${JOB}`, `/v1/jobs/${JOB}/result`],
        );
      }
    });
});
