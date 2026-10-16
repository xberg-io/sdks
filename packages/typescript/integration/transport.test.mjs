import assert from "node:assert/strict";
import { createServer } from "node:http";
import { once } from "node:events";
import test from "node:test";
import { NotFoundError, XbergClient } from "../dist/index.js";

async function localServer(handler, run) {
  const server = createServer(handler);
  server.listen(0, "127.0.0.1");
  await once(server, "listening");
  try {
    await run(`http://127.0.0.1:${server.address().port}`);
  } finally {
    await new Promise((resolve) => {
      server.close(resolve);
    });
  }
}

test("real SDK serializes structured context/per-file override and preserves unknown structured results", async () => {
  const calls = [];
  const schema = { type: "object", properties: { invoice: { type: "string" } }, required: ["invoice"] };
  const options = {
    saved_preset_id: "preset-fixture",
    context: { department: "Parks" },
    extraction_config: { structured_extraction: { model: "openai/gpt-4o-mini" } },
  };
  await localServer(
    async (request, response) => {
      calls.push(`${request.method} ${request.url}`);
      response.setHeader("Content-Type", "application/json");
      if (request.method === "POST") {
        const chunks = [];
        for await (const chunk of request) chunks.push(chunk);
        const decoded = new Request("http://fixture.local", {
          method: "POST",
          headers: request.headers,
          body: Buffer.concat(chunks),
        });
        const form = await decoded.formData();
        assert.equal(await form.get("file").text(), "Invoice 42");
        assert.deepEqual(JSON.parse(form.get("options")), options);
        assert.deepEqual(JSON.parse(form.get("config-invoice.txt")), {
          extraction_config: { structured_extraction: { schema } },
        });
        response.statusCode = 202;
        response.end(JSON.stringify({ job_ids: ["j1"] }));
      } else {
        response.end(
          JSON.stringify({
            job_id: "j1",
            status: "completed",
            cached: false,
            results: [{ content: "Invoice 42", structured_output: { invoice: "42" } }],
          }),
        );
      }
    },
    async (baseUrl) => {
      const client = new XbergClient({ baseUrl, target: "pro", retries: 0 });
      const job = await client.extract({
        file: { name: "invoice.txt", data: new TextEncoder().encode("Invoice 42") },
        options,
        config: { extraction_config: { structured_extraction: { schema } } },
      });
      assert.equal(job.id, "j1");
      assert.deepEqual((await client.getJobResult(job.id)).results[0].structured_output, { invoice: "42" });
    },
  );
  assert.deepEqual(calls, ["POST /v1/extract", "GET /v1/jobs/j1/result"]);
});

test("real SDK transmits opaque RAG/enrichment bodies and pagination and maps HTTP404", async () => {
  const received = [];
  await localServer(
    async (request, response) => {
      const chunks = [];
      for await (const chunk of request) chunks.push(chunk);
      received.push({ method: request.method, path: request.url, body: Buffer.concat(chunks).toString() });
      response.setHeader("Content-Type", "application/json");
      response.statusCode = request.url.includes("/jobs/missing") ? 404 : 200;
      response.end(
        JSON.stringify(
          response.statusCode === 404 ? { error: { code: "job.not_found" } } : { receipt: received.length },
        ),
      );
    },
    async (baseUrl) => {
      const client = new XbergClient({ baseUrl, target: "pro", retries: 0 });
      assert.deepEqual(await client.ragRetrieve("park reports", { query: "invoice", mode: "hybrid", limit: 2 }), {
        receipt: 1,
      });
      assert.deepEqual(await client.submitEnrich({ text: "Parks invoice", options: { keywords: true } }), {
        receipt: 2,
      });
      await client.listJobs({ limit: 2, offset: 3 });
      await assert.rejects(
        client.getJob("missing"),
        (error) => error instanceof NotFoundError && error.status === 404 && error.body.error.code === "job.not_found",
      );
    },
  );
  assert.deepEqual(received, [
    {
      method: "POST",
      path: "/v1/rag/collections/park%20reports/retrieve",
      body: '{"query":"invoice","mode":"hybrid","limit":2}',
    },
    { method: "POST", path: "/v1/enrich", body: '{"text":"Parks invoice","options":{"keywords":true}}' },
    { method: "GET", path: "/v1/jobs?limit=2&offset=3", body: "" },
    { method: "GET", path: "/v1/jobs/missing", body: "" },
  ]);
});

test("real SDK rejects unavailable base URL instead of reporting a passing deployment", async () => {
  const server = createServer();
  server.listen(0, "127.0.0.1");
  await once(server, "listening");
  const port = server.address().port;
  await new Promise((resolve) => {
    server.close(resolve);
  });
  const client = new XbergClient({ baseUrl: `http://127.0.0.1:${port}`, target: "pro", retries: 0, timeoutMs: 500 });
  await assert.rejects(client.authConfig(), /Network error/);
});
