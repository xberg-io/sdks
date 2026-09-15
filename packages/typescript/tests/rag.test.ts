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
    sleep: async () => {},
  });
}

describe("shared RAG surface", () => {
  it("createRagCollection posts a new collection", async () => {
    let receivedBody: unknown;
    server.use(
      http.post(url("/v1/rag/collections"), async ({ request }) => {
        receivedBody = await request.json();
        return HttpResponse.json({ name: "docs" }, { status: 201 });
      }),
    );
    const result = await makeClient().createRagCollection({ name: "docs" });
    expect(result).toEqual({ name: "docs" });
    expect(receivedBody).toEqual({ name: "docs" });
  });

  it("getRagCollection fetches a collection by name", async () => {
    server.use(http.get(url("/v1/rag/collections/docs"), () => HttpResponse.json({ name: "docs" }, { status: 200 })));
    const result = await makeClient().getRagCollection("docs");
    expect(result).toEqual({ name: "docs" });
  });

  it("deleteRagCollection deletes a collection by name", async () => {
    server.use(http.delete(url("/v1/rag/collections/docs"), () => new HttpResponse(null, { status: 204 })));
    const result = await makeClient().deleteRagCollection("docs");
    expect(result).toBeUndefined();
  });

  it("deleteRagDocuments deletes documents by ID list and returns the deleted count", async () => {
    let receivedMethod = "";
    let receivedBody: unknown;
    server.use(
      http.delete(url("/v1/rag/collections/docs/documents"), async ({ request }) => {
        receivedMethod = request.method;
        receivedBody = await request.json();
        return HttpResponse.json({ deleted_count: 2 }, { status: 200 });
      }),
    );
    const result = await makeClient().deleteRagDocuments("docs", { ids: ["d1", "d2"] });
    expect(result).toEqual({ deleted_count: 2 });
    expect(receivedMethod).toBe("DELETE");
    expect(receivedBody).toEqual({ ids: ["d1", "d2"] });
  });

  it("deleteRagDocuments deletes documents by metadata filter", async () => {
    let receivedBody: unknown;
    server.use(
      http.delete(url("/v1/rag/collections/docs/documents"), async ({ request }) => {
        receivedBody = await request.json();
        return HttpResponse.json({ deleted_count: 5 }, { status: 200 });
      }),
    );
    const result = await makeClient().deleteRagDocuments("docs", { filter: { source: "stale" } });
    expect(result).toEqual({ deleted_count: 5 });
    expect(receivedBody).toEqual({ filter: { source: "stale" } });
  });

  it("exposes no listRagDocuments method because no spec declares GET on that path", () => {
    const client = makeClient() as unknown as Record<string, unknown>;
    expect(client["listRagDocuments"]).toBeUndefined();
  });

  it("addRagDocuments posts new documents to a collection", async () => {
    let receivedBody: unknown;
    server.use(
      http.post(url("/v1/rag/collections/docs/documents"), async ({ request }) => {
        receivedBody = await request.json();
        return HttpResponse.json({ added: 1 }, { status: 200 });
      }),
    );
    const result = await makeClient().addRagDocuments("docs", { documents: [{ id: "d1" }] });
    expect(result).toEqual({ added: 1 });
    expect(receivedBody).toEqual({ documents: [{ id: "d1" }] });
  });

  it("reindexRagDocument posts with a body", async () => {
    let receivedBody: unknown;
    server.use(
      http.post(url("/v1/rag/collections/docs/documents/d1/reindex"), async ({ request }) => {
        receivedBody = await request.json();
        return HttpResponse.json({ status: "queued" }, { status: 200 });
      }),
    );
    const result = await makeClient().reindexRagDocument("docs", "d1", { force: true });
    expect(result).toEqual({ status: "queued" });
    expect(receivedBody).toEqual({ force: true });
  });

  it("reindexRagDocument posts without a body", async () => {
    let receivedText = "";
    server.use(
      http.post(url("/v1/rag/collections/docs/documents/d1/reindex"), async ({ request }) => {
        receivedText = await request.text();
        return HttpResponse.json({ status: "queued" }, { status: 200 });
      }),
    );
    const result = await makeClient().reindexRagDocument("docs", "d1");
    expect(result).toEqual({ status: "queued" });
    expect(receivedText).toBe("");
  });

  it("ragRetrieve posts a retrieval query", async () => {
    let receivedBody: unknown;
    server.use(
      http.post(url("/v1/rag/collections/docs/retrieve"), async ({ request }) => {
        receivedBody = await request.json();
        return HttpResponse.json({ chunks: [] }, { status: 200 });
      }),
    );
    const result = await makeClient().ragRetrieve("docs", { query: "hello" });
    expect(result).toEqual({ chunks: [] });
    expect(receivedBody).toEqual({ query: "hello" });
  });

  it("migrateRagEmbeddings kicks off an embedding migration", async () => {
    let receivedBody: unknown;
    server.use(
      http.post(url("/v1/rag/collections/docs/migrate-embeddings"), async ({ request }) => {
        receivedBody = await request.json();
        return HttpResponse.json({ job_id: "mig-1" }, { status: 202 });
      }),
    );
    const result = await makeClient().migrateRagEmbeddings("docs", { target_model: "v2" });
    expect(result).toEqual({ job_id: "mig-1" });
    expect(receivedBody).toEqual({ target_model: "v2" });
  });

  it("getRagMigrationJob polls an embedding-migration job", async () => {
    server.use(
      http.get(url("/v1/rag/collections/docs/migrate-embeddings/mig-1"), () =>
        HttpResponse.json({ status: "completed" }, { status: 200 }),
      ),
    );
    const result = await makeClient().getRagMigrationJob("docs", "mig-1");
    expect(result).toEqual({ status: "completed" });
  });

  it("getRagJob fetches a RAG job's status", async () => {
    server.use(http.get(url("/v1/rag/jobs/job-1"), () => HttpResponse.json({ status: "completed" }, { status: 200 })));
    const result = await makeClient().getRagJob("job-1");
    expect(result).toEqual({ status: "completed" });
  });

  it("listManagedEmbeddingPresets issues GET /v1/rag/embedding-presets", async () => {
    let receivedPath = "";
    server.use(
      http.get(url("/v1/rag/embedding-presets"), ({ request }) => {
        receivedPath = new URL(request.url).pathname;
        return HttpResponse.json({ presets: [{ id: "small", model: "m" }] }, { status: 200 });
      }),
    );
    const result = await makeClient().listManagedEmbeddingPresets();
    expect(result).toEqual({ presets: [{ id: "small", model: "m" }] });
    expect(receivedPath).toBe("/v1/rag/embedding-presets");
  });

  it("listManagedEmbeddingPresets is not tier-gated and reaches a pro instance", async () => {
    const proUrl = "https://pro.example.test";
    server.use(
      http.get(`${proUrl}/v1/rag/embedding-presets`, () => HttpResponse.json({ presets: [] }, { status: 200 })),
    );
    const client = new XbergClient({ apiKey: "k", baseUrl: proUrl, target: "pro", sleep: async () => {} });
    await expect(client.listManagedEmbeddingPresets()).resolves.toEqual({ presets: [] });
  });
});
