import { HttpResponse, http } from "msw";
import { afterAll, afterEach, beforeAll, describe, expect, it } from "vitest";
import { XbergClient } from "../src/client.js";
import { TEST_BASE_URL, createTestServer } from "./_helpers.js";

const server = createTestServer();

beforeAll(() => server.listen({ onUnhandledRequest: "error" }));
afterEach(() => server.resetHandlers());
afterAll(() => server.close());

const PRO_URL = "https://pro.example.test";

function makeClient(): XbergClient {
  return new XbergClient({
    apiKey: "k",
    baseUrl: PRO_URL,
    target: "pro",
    sleep: async () => {},
  });
}

describe("pro-only surface", () => {
  it("authConfig fetches accepted auth methods", async () => {
    server.use(http.get(`${PRO_URL}/auth/config`, () => HttpResponse.json({ methods: ["oidc"] }, { status: 200 })));
    const result = await makeClient().authConfig();
    expect(result).toEqual({ methods: ["oidc"] });
  });

  it("createSavedPreset creates a saved preset", async () => {
    let receivedBody: unknown;
    server.use(
      http.post(`${PRO_URL}/v1/saved_presets`, async ({ request }) => {
        receivedBody = await request.json();
        return HttpResponse.json({ id: "preset-1" }, { status: 201 });
      }),
    );
    const result = await makeClient().createSavedPreset({ name: "My Preset" });
    expect(result).toEqual({ id: "preset-1" });
    expect(receivedBody).toEqual({ name: "My Preset" });
  });

  it("deleteSavedPreset deletes a saved preset by id", async () => {
    let receivedPath = "";
    server.use(
      http.delete(`${PRO_URL}/v1/saved_presets/:id`, ({ request }) => {
        receivedPath = new URL(request.url).pathname;
        return new HttpResponse(null, { status: 204 });
      }),
    );
    const result = await makeClient().deleteSavedPreset("preset-1");
    expect(result).toBeUndefined();
    expect(receivedPath).toBe("/v1/saved_presets/preset-1");
  });

  it("getRagConfig fetches a project's RAG config", async () => {
    server.use(
      http.get(`${PRO_URL}/v1/projects/proj-1/rag-config`, () => HttpResponse.json({ enabled: true }, { status: 200 })),
    );
    const result = await makeClient().getRagConfig("proj-1");
    expect(result).toEqual({ enabled: true });
  });

  it("setRagConfig updates a project's RAG config", async () => {
    let receivedBody: unknown;
    server.use(
      http.put(`${PRO_URL}/v1/projects/proj-1/rag-config`, async ({ request }) => {
        receivedBody = await request.json();
        return HttpResponse.json({ enabled: false }, { status: 200 });
      }),
    );
    const result = await makeClient().setRagConfig("proj-1", { enabled: false });
    expect(result).toEqual({ enabled: false });
    expect(receivedBody).toEqual({ enabled: false });
  });

  it("getLicenseInfo reads the instance's license detail", async () => {
    let receivedPath = "";
    server.use(
      http.get(`${PRO_URL}/v1/license`, ({ request }) => {
        receivedPath = new URL(request.url).pathname;
        return HttpResponse.json({ licensee: "Acme", plan: "pro", days_remaining: 30 }, { status: 200 });
      }),
    );
    const result = await makeClient().getLicenseInfo();
    expect(result).toEqual({ licensee: "Acme", plan: "pro", days_remaining: 30 });
    expect(receivedPath).toBe("/v1/license");
  });

  it("putLocalUpload PUTs raw bytes at the presigned capability path", async () => {
    let receivedPath = "";
    let receivedContentType: string | null = null;
    let receivedBytes = new Uint8Array();
    server.use(
      http.put(`${PRO_URL}/v1/uploads/local/:projectId/:token`, async ({ request }) => {
        receivedPath = new URL(request.url).pathname;
        receivedContentType = request.headers.get("content-type");
        receivedBytes = new Uint8Array(await request.arrayBuffer());
        return new HttpResponse(null, { status: 204 });
      }),
    );
    const result = await makeClient().putLocalUpload("proj 1", "tok/en", new Uint8Array([1, 2, 3]));
    expect(result).toBeUndefined();
    expect(receivedPath).toBe("/v1/uploads/local/proj%201/tok%2Fen");
    expect(receivedContentType).toBe("application/octet-stream");
    expect([...receivedBytes]).toEqual([1, 2, 3]);
  });
});

describe("pro-only tier gating", () => {
  it("rejects each pro-only method on the enterprise tier without an HTTP call", async () => {
    const client = new XbergClient({ apiKey: "k", baseUrl: TEST_BASE_URL, target: "enterprise" });
    await expect(client.getLicenseInfo()).rejects.toThrow(/not available on the 'enterprise' tier/);
    await expect(client.putLocalUpload("p", "t", new Uint8Array([1]))).rejects.toThrow(
      /not available on the 'enterprise' tier/,
    );
  });
});
