import { HttpResponse, http } from "msw";
import { afterAll, afterEach, beforeAll, describe, expect, it } from "vitest";
import { XbergClient } from "../src/client.js";
import { TEST_BASE_URL, createTestServer, url } from "./_helpers.js";

const server = createTestServer();

beforeAll(() => server.listen({ onUnhandledRequest: "error" }));
afterEach(() => server.resetHandlers());
afterAll(() => server.close());

function makeClient(): XbergClient {
  return new XbergClient({
    apiKey: "k",
    baseUrl: TEST_BASE_URL,
    target: "enterprise",
    sleep: async () => {},
  });
}

const PRO_URL = "https://pro.example.test";

function proClient(): XbergClient {
  return new XbergClient({ apiKey: "k", baseUrl: PRO_URL, target: "pro", sleep: async () => {} });
}

/** Records the method and pathname of the request the handler saw. */
interface Seen {
  method: string;
  path: string;
  search: string;
}

function seen(): Seen {
  return { method: "", path: "", search: "" };
}

function record(target: Seen, request: Request): void {
  const parsed = new URL(request.url);
  target.method = request.method;
  target.path = parsed.pathname;
  target.search = parsed.search;
}

describe("enterprise-only surface", () => {
  it("versions lists a document's versions", async () => {
    server.use(
      http.get(url("/v1/documents/doc-1/versions"), () => HttpResponse.json([{ version_id: "v1" }], { status: 200 })),
    );
    const result = await makeClient().versions("doc-1");
    expect(result).toEqual([{ version_id: "v1" }]);
  });

  it("diff fetches a diff without query params, narrowed to the 200 arm", async () => {
    let receivedSearch = "";
    server.use(
      http.get(url("/v1/documents/doc-1/diff"), ({ request }) => {
        receivedSearch = new URL(request.url).search;
        return HttpResponse.json({ diff: "none" }, { status: 200 });
      }),
    );
    const result = await makeClient().diff("doc-1");
    expect(result.status).toBe(200);
    if (result.status !== 200) {
      throw new Error("expected the 200 arm");
    }
    expect(result.body).toEqual({ diff: "none" });
    expect(receivedSearch).toBe("");
  });

  it("diff forwards query params", async () => {
    let receivedSearch = "";
    server.use(
      http.get(url("/v1/documents/doc-1/diff"), ({ request }) => {
        receivedSearch = new URL(request.url).search;
        return HttpResponse.json({ diff: "some" }, { status: 200 });
      }),
    );
    const result = await makeClient().diff("doc-1", { from: "a", to: "b" });
    expect(result).toEqual({ status: 200, body: { diff: "some" } });
    expect(receivedSearch).toBe("?from=a&to=b");
  });

  it("diff narrows to the 202 arm when the server queues the diff for async computation", async () => {
    server.use(
      http.get(url("/v1/documents/doc-1/diff"), () =>
        HttpResponse.json({ diff_job_id: "job-1", status: "pending" }, { status: 202 }),
      ),
    );
    const result = await makeClient().diff("doc-1");
    expect(result.status).toBe(202);
    if (result.status !== 202) {
      throw new Error("expected the 202 arm");
    }
    expect(result.body).toEqual({ diff_job_id: "job-1", status: "pending" });
  });

  it("getDiffJob polls a diff job, narrowed to the 200 arm once it has finished", async () => {
    server.use(
      http.get(url("/v1/documents/doc-1/diff/job-1"), () => HttpResponse.json({ diff: "done" }, { status: 200 })),
    );
    const result = await makeClient().getDiffJob("doc-1", "job-1");
    expect(result).toEqual({ status: 200, body: { diff: "done" } });
  });

  it("getDiffJob narrows to the 202 arm while the job is still pending", async () => {
    server.use(
      http.get(url("/v1/documents/doc-1/diff/job-1"), () =>
        HttpResponse.json({ diff_job_id: "job-1", status: "pending" }, { status: 202 }),
      ),
    );
    const result = await makeClient().getDiffJob("doc-1", "job-1");
    expect(result).toEqual({ status: 202, body: { diff_job_id: "job-1", status: "pending" } });
  });

  it("presignUpload requests a presigned upload URL", async () => {
    let receivedBody: unknown;
    server.use(
      http.post(url("/v1/uploads/presign"), async ({ request }) => {
        receivedBody = await request.json();
        return HttpResponse.json({ upload_url: "https://upload.example.test", upload_id: "u1" }, { status: 200 });
      }),
    );
    const result = await makeClient().presignUpload({ filename: "x.pdf", content_type: "application/pdf" });
    expect(result).toEqual({ upload_url: "https://upload.example.test", upload_id: "u1" });
    expect(receivedBody).toEqual({ filename: "x.pdf", content_type: "application/pdf" });
  });

  it("confirmUpload confirms a presigned upload", async () => {
    let receivedBody: unknown;
    server.use(
      http.post(url("/v1/uploads/confirm"), async ({ request }) => {
        receivedBody = await request.json();
        return HttpResponse.json({ document_id: "doc-9" }, { status: 200 });
      }),
    );
    const result = await makeClient().confirmUpload({ upload_id: "u1" });
    expect(result).toEqual({ document_id: "doc-9" });
    expect(receivedBody).toEqual({ upload_id: "u1" });
  });

  it("usage fetches usage/metering data with query params", async () => {
    let receivedSearch = "";
    server.use(
      http.get(url("/v1/usage"), ({ request }) => {
        receivedSearch = new URL(request.url).search;
        return HttpResponse.json({ pages: 12 }, { status: 200 });
      }),
    );
    const result = await makeClient().usage({ from: "2026-01-01" });
    expect(result).toEqual({ pages: 12 });
    expect(receivedSearch).toBe("?from=2026-01-01");
  });

  it("audit fetches audit-log entries", async () => {
    server.use(http.get(url("/v1/audit"), () => HttpResponse.json({ entries: [], total: 0 }, { status: 200 })));
    const result = await makeClient().audit({ action: "extract", limit: 10, offset: 0 });
    expect(result).toEqual({ entries: [], total: 0 });
  });

  it("listJobs lists jobs with pagination params", async () => {
    server.use(http.get(url("/v1/jobs"), () => HttpResponse.json({ jobs: [], total: 0 }, { status: 200 })));
    const result = await makeClient().listJobs({ limit: 5, offset: 10 });
    expect(result).toEqual({ jobs: [], total: 0 });
  });

  it("getDocument issues GET /v1/documents/{documentId}", async () => {
    const got = seen();
    server.use(
      http.get(url("/v1/documents/:id"), ({ request }) => {
        record(got, request);
        return HttpResponse.json({ document_id: "doc 1", version: 3 }, { status: 200 });
      }),
    );
    const result = await makeClient().getDocument("doc 1");
    expect(result).toEqual({ document_id: "doc 1", version: 3 });
    expect(got.method).toBe("GET");
    expect(got.path).toBe("/v1/documents/doc%201");
  });

  it("listExtractionEvents issues GET /v1/extractions with days and pagination params", async () => {
    const got = seen();
    server.use(
      http.get(url("/v1/extractions"), ({ request }) => {
        record(got, request);
        return HttpResponse.json({ events: [], total: 0, page: 0, limit: 50 }, { status: 200 });
      }),
    );
    const result = await makeClient().listExtractionEvents({ days: 7, limit: 5, offset: 10 });
    expect(result).toEqual({ events: [], total: 0, page: 0, limit: 50 });
    expect(got.method).toBe("GET");
    expect(got.path).toBe("/v1/extractions");
    expect(got.search).toBe("?days=7&limit=5&offset=10");
  });

  it("getJobPage issues GET /v1/jobs/{jobId}/pages/{pageNumber} and returns the raw PNG bytes", async () => {
    const got = seen();
    const png = new Uint8Array([0x89, 0x50, 0x4e, 0x47]);
    server.use(
      http.get(url("/v1/jobs/:jobId/pages/:pageNumber"), ({ request }) => {
        record(got, request);
        return HttpResponse.arrayBuffer(png.buffer, { status: 200, headers: { "content-type": "image/png" } });
      }),
    );
    const bytes = await makeClient().getJobPage("job-1", 3);
    expect(bytes).toBeInstanceOf(Uint8Array);
    expect([...bytes]).toEqual([0x89, 0x50, 0x4e, 0x47]);
    expect(got.method).toBe("GET");
    expect(got.path).toBe("/v1/jobs/job-1/pages/3");
  });

  it("submitEnrich issues POST /v1/enrich", async () => {
    const got = seen();
    let receivedBody: unknown;
    server.use(
      http.post(url("/v1/enrich"), async ({ request }) => {
        record(got, request);
        receivedBody = await request.json();
        return HttpResponse.json({ job_id: "enrich-1" }, { status: 202 });
      }),
    );
    const result = await makeClient().submitEnrich({ text: "hello", options: { entities: true } });
    expect(result).toEqual({ job_id: "enrich-1" });
    expect(receivedBody).toEqual({ text: "hello", options: { entities: true } });
    expect(got.method).toBe("POST");
    expect(got.path).toBe("/v1/enrich");
  });

  it("getEnrichStatus issues GET /v1/enrich/{jobId}", async () => {
    const got = seen();
    server.use(
      http.get(url("/v1/enrich/:jobId"), ({ request }) => {
        record(got, request);
        return HttpResponse.json({ job_id: "enrich-1", status: "completed" }, { status: 200 });
      }),
    );
    const result = await makeClient().getEnrichStatus("enrich-1");
    expect(result).toEqual({ job_id: "enrich-1", status: "completed" });
    expect(got.method).toBe("GET");
    expect(got.path).toBe("/v1/enrich/enrich-1");
  });
});

describe("enterprise-only webhook delivery history", () => {
  it("listSubscriptionDeliveries issues GET /v1/webhooks/{webhookId}/deliveries with pagination", async () => {
    const got = seen();
    server.use(
      http.get(url("/v1/webhooks/:webhookId/deliveries"), ({ request }) => {
        record(got, request);
        return HttpResponse.json({ deliveries: [], total: 0, page: 0, limit: 100 }, { status: 200 });
      }),
    );
    const result = await makeClient().listSubscriptionDeliveries("wh 1", { limit: 5, offset: 10 });
    expect(result).toEqual({ deliveries: [], total: 0, page: 0, limit: 100 });
    expect(got.method).toBe("GET");
    expect(got.path).toBe("/v1/webhooks/wh%201/deliveries");
    expect(got.search).toBe("?limit=5&offset=10");
  });

  it("getSubscriptionDelivery issues GET /v1/webhooks/{webhookId}/deliveries/{deliveryId}", async () => {
    const got = seen();
    server.use(
      http.get(url("/v1/webhooks/:webhookId/deliveries/:deliveryId"), ({ request }) => {
        record(got, request);
        return HttpResponse.json({ id: "d-1", status_code: 200 }, { status: 200 });
      }),
    );
    const result = await makeClient().getSubscriptionDelivery("wh-1", "d 1");
    expect(result).toEqual({ id: "d-1", status_code: 200 });
    expect(got.method).toBe("GET");
    expect(got.path).toBe("/v1/webhooks/wh-1/deliveries/d%201");
  });
});

describe("enterprise-only tier gating", () => {
  it("rejects each enterprise-only method on the pro tier without an HTTP call", async () => {
    const client = proClient();
    await expect(client.getDocument("doc-1")).rejects.toThrow(/not available on the 'pro' tier/);
    await expect(client.versions("doc-1")).rejects.toThrow(/not available on the 'pro' tier/);
    await expect(client.diff("doc-1")).rejects.toThrow(/not available on the 'pro' tier/);
    await expect(client.getDiffJob("doc-1", "job-1")).rejects.toThrow(/not available on the 'pro' tier/);
    await expect(client.listExtractionEvents()).rejects.toThrow(/not available on the 'pro' tier/);
    await expect(client.listSubscriptionDeliveries("wh-1")).rejects.toThrow(/not available on the 'pro' tier/);
    await expect(client.getSubscriptionDelivery("wh-1", "d-1")).rejects.toThrow(/not available on the 'pro' tier/);
  });
});

/**
 * ~keep These seven are declared by `spec/pro/openapi.yaml` and always were; the
 * client used to gate them to Enterprise, so Pro callers got a thrown tier error
 * instead of a working endpoint. Assert reachability, not just the absence of a throw.
 */
describe("routes Pro serves that were wrongly gated to enterprise", () => {
  it("reaches each one on the pro tier", async () => {
    const paths: string[] = [];
    const pngBytes = new Uint8Array([0x89, 0x50, 0x4e, 0x47]);
    server.use(
      http.get(`${PRO_URL}/v1/usage`, ({ request }) => {
        paths.push(new URL(request.url).pathname);
        return HttpResponse.json({ total_pages: 3 }, { status: 200 });
      }),
      http.post(`${PRO_URL}/v1/uploads/presign`, ({ request }) => {
        paths.push(new URL(request.url).pathname);
        return HttpResponse.json({ batch_id: "b-1", uploads: [] }, { status: 200 });
      }),
      http.post(`${PRO_URL}/v1/uploads/confirm`, ({ request }) => {
        paths.push(new URL(request.url).pathname);
        return HttpResponse.json({ job_ids: ["j-1"], status: "processing" }, { status: 200 });
      }),
      http.get(`${PRO_URL}/v1/jobs/:jobId/pages/:pageNumber`, ({ request }) => {
        paths.push(new URL(request.url).pathname);
        return HttpResponse.arrayBuffer(pngBytes.buffer, { status: 200 });
      }),
      http.post(`${PRO_URL}/v1/enrich`, ({ request }) => {
        paths.push(new URL(request.url).pathname);
        return HttpResponse.json({ job_id: "e-1" }, { status: 202 });
      }),
      http.get(`${PRO_URL}/v1/enrich/:jobId`, ({ request }) => {
        paths.push(new URL(request.url).pathname);
        return HttpResponse.json({ job_id: "e-1", status: "completed" }, { status: 200 });
      }),
      http.get(`${PRO_URL}/v1/crawl-jobs/:crawlJobId/events`, ({ request }) => {
        paths.push(new URL(request.url).pathname);
        return new HttpResponse(`data: ${JSON.stringify({ kind: "complete", crawl_job_id: "c-1" })}\n\n`, {
          status: 200,
          headers: { "content-type": "text/event-stream" },
        });
      }),
    );

    const client = proClient();
    expect(await client.usage()).toEqual({ total_pages: 3 });
    expect(await client.presignUpload({ documents: [] })).toEqual({ batch_id: "b-1", uploads: [] });
    expect(await client.confirmUpload({ batch_id: "b-1" })).toEqual({ job_ids: ["j-1"], status: "processing" });
    expect([...(await client.getJobPage("job-1", 2))]).toEqual([0x89, 0x50, 0x4e, 0x47]);
    expect(await client.submitEnrich({ text: "hello" })).toEqual({ job_id: "e-1" });
    expect(await client.getEnrichStatus("e-1")).toEqual({ job_id: "e-1", status: "completed" });

    const events = [];
    for await (const event of client.streamCrawlEvents("c-1")) {
      events.push(event.kind);
    }
    expect(events).toEqual(["complete"]);

    expect(paths).toEqual([
      "/v1/usage",
      "/v1/uploads/presign",
      "/v1/uploads/confirm",
      "/v1/jobs/job-1/pages/2",
      "/v1/enrich",
      "/v1/enrich/e-1",
      "/v1/crawl-jobs/c-1/events",
    ]);
  });
});
