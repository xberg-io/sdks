import { HttpResponse, http } from "msw";
import { afterAll, afterEach, beforeAll, describe, expect, it } from "vitest";
import { XbergClient } from "../src/client.js";
import { createTestServer } from "./_helpers.js";

const server = createTestServer();

beforeAll(() => server.listen({ onUnhandledRequest: "error" }));
afterEach(() => server.resetHandlers());
afterAll(() => server.close());

const PRO_URL = "https://pro.example.test";
const ENTERPRISE_URL = "https://api.test.enterprise.xberg.io";
const PROJECT = "proj-1";
const INTEGRATION = "int-1";

function makeClient(): XbergClient {
  return new XbergClient({ apiKey: "k", baseUrl: PRO_URL, target: "pro", sleep: async () => {} });
}

function enterpriseClient(): XbergClient {
  return new XbergClient({
    apiKey: "k",
    baseUrl: ENTERPRISE_URL,
    target: "enterprise",
    sleep: async () => {},
  });
}

describe("pro control plane — projects", () => {
  it("listProjects forwards pagination and returns the project page", async () => {
    let receivedSearch = "";
    server.use(
      http.get(`${PRO_URL}/v1/projects`, ({ request }) => {
        receivedSearch = new URL(request.url).search;
        return HttpResponse.json({ projects: [], total: 0, limit: 5, offset: 10 }, { status: 200 });
      }),
    );
    const result = await makeClient().listProjects({ limit: 5, offset: 10 });
    expect(result).toEqual({ projects: [], total: 0, limit: 5, offset: 10 });
    expect(receivedSearch).toBe("?limit=5&offset=10");
  });

  it("listProjects omits absent pagination params", async () => {
    let receivedSearch = "";
    server.use(
      http.get(`${PRO_URL}/v1/projects`, ({ request }) => {
        receivedSearch = new URL(request.url).search;
        return HttpResponse.json({ projects: [], total: 0, limit: 1000, offset: 0 }, { status: 200 });
      }),
    );
    await makeClient().listProjects();
    expect(receivedSearch).toBe("");
  });

  it("createProject posts the request body and returns the created project", async () => {
    let receivedBody: unknown;
    server.use(
      http.post(`${PRO_URL}/v1/projects`, async ({ request }) => {
        receivedBody = await request.json();
        return HttpResponse.json({ id: PROJECT, name: "Acme", slug: "acme" }, { status: 201 });
      }),
    );
    const result = await makeClient().createProject({ name: "Acme" });
    expect(result).toEqual({ id: PROJECT, name: "Acme", slug: "acme" });
    expect(receivedBody).toEqual({ name: "Acme" });
  });

  it("listProjects is gated to the pro tier", async () => {
    await expect(enterpriseClient().listProjects()).rejects.toThrow(/not available on the 'enterprise' tier/);
  });
});

describe("pro control plane — API keys", () => {
  it("listApiKeys lists a project's keys", async () => {
    let receivedSearch = "";
    server.use(
      http.get(`${PRO_URL}/v1/projects/${PROJECT}/api-keys`, ({ request }) => {
        receivedSearch = new URL(request.url).search;
        return HttpResponse.json({ api_keys: [], total: 0, limit: 2, offset: 0 }, { status: 200 });
      }),
    );
    const result = await makeClient().listApiKeys(PROJECT, { limit: 2, offset: 0 });
    expect(result).toEqual({ api_keys: [], total: 0, limit: 2, offset: 0 });
    expect(receivedSearch).toBe("?limit=2&offset=0");
  });

  it("createApiKey mints a key and returns the one-time secret", async () => {
    let receivedBody: unknown;
    server.use(
      http.post(`${PRO_URL}/v1/projects/${PROJECT}/api-keys`, async ({ request }) => {
        receivedBody = await request.json();
        return HttpResponse.json(
          { id: "key-1", key: "sk-live-abc", key_prefix: "sk-live", scope: "write" },
          {
            status: 201,
          },
        );
      }),
    );
    const result = await makeClient().createApiKey(PROJECT, { name: "CI", scope: "write" });
    expect(result.key).toBe("sk-live-abc");
    expect(result.scope).toBe("write");
    expect(receivedBody).toEqual({ name: "CI", scope: "write" });
  });

  it("revokeApiKey deletes the key and resolves to undefined", async () => {
    let receivedPath = "";
    server.use(
      http.delete(`${PRO_URL}/v1/projects/${PROJECT}/api-keys/:keyId`, ({ request }) => {
        receivedPath = new URL(request.url).pathname;
        return new HttpResponse(null, { status: 204 });
      }),
    );
    const result = await makeClient().revokeApiKey(PROJECT, "key 1");
    expect(result).toBeUndefined();
    expect(receivedPath).toBe(`/v1/projects/${PROJECT}/api-keys/key%201`);
  });

  it("createApiKey is gated to the pro tier", async () => {
    await expect(enterpriseClient().createApiKey(PROJECT, {})).rejects.toThrow(
      /not available on the 'enterprise' tier/,
    );
  });
});

describe("pro control plane — integrations", () => {
  const base = `${PRO_URL}/v1/projects/${PROJECT}/integrations`;

  it("listIntegrations lists a project's integrations", async () => {
    server.use(http.get(base, () => HttpResponse.json({ integrations: [], total: 0, limit: 0, offset: 0 })));
    const result = await makeClient().listIntegrations(PROJECT);
    expect(result).toEqual({ integrations: [], total: 0, limit: 0, offset: 0 });
  });

  it("createIntegration posts the request body", async () => {
    let receivedBody: unknown;
    server.use(
      http.post(base, async ({ request }) => {
        receivedBody = await request.json();
        return HttpResponse.json({ id: INTEGRATION, kind: "gdrive", name: "Drive" }, { status: 201 });
      }),
    );
    const result = await makeClient().createIntegration(PROJECT, {
      kind: "gdrive",
      name: "Drive",
      auth_type: "oauth2",
    });
    expect(result).toEqual({ id: INTEGRATION, kind: "gdrive", name: "Drive" });
    expect(receivedBody).toEqual({ kind: "gdrive", name: "Drive", auth_type: "oauth2" });
  });

  it("getIntegration fetches one integration", async () => {
    server.use(
      http.get(`${base}/${INTEGRATION}`, () => HttpResponse.json({ id: INTEGRATION, kind: "gdrive", name: "Drive" })),
    );
    const result = await makeClient().getIntegration(PROJECT, INTEGRATION);
    expect(result).toEqual({ id: INTEGRATION, kind: "gdrive", name: "Drive" });
  });

  it("deleteIntegration deletes one integration", async () => {
    let receivedPath = "";
    server.use(
      http.delete(`${base}/:integrationId`, ({ request }) => {
        receivedPath = new URL(request.url).pathname;
        return new HttpResponse(null, { status: 204 });
      }),
    );
    const result = await makeClient().deleteIntegration(PROJECT, INTEGRATION);
    expect(result).toBeUndefined();
    expect(receivedPath).toBe(`/v1/projects/${PROJECT}/integrations/${INTEGRATION}`);
  });

  it("connectIntegration returns the provider authorize URL", async () => {
    server.use(
      http.post(`${base}/${INTEGRATION}/connect`, () =>
        HttpResponse.json({ authorize_url: "https://accounts.example.test/o/oauth2/auth?state=x" }, { status: 200 }),
      ),
    );
    const result = await makeClient().connectIntegration(PROJECT, INTEGRATION);
    expect(result.authorize_url).toBe("https://accounts.example.test/o/oauth2/auth?state=x");
  });

  it("disconnectIntegration revokes the connection", async () => {
    let called = false;
    server.use(
      http.post(`${base}/${INTEGRATION}/disconnect`, () => {
        called = true;
        return new HttpResponse(null, { status: 204 });
      }),
    );
    const result = await makeClient().disconnectIntegration(PROJECT, INTEGRATION);
    expect(result).toBeUndefined();
    expect(called).toBe(true);
  });

  it("listIntegrationDocuments maps camelCase filters onto the wire query params", async () => {
    let receivedSearch = "";
    server.use(
      http.get(`${base}/${INTEGRATION}/documents`, ({ request }) => {
        receivedSearch = new URL(request.url).search;
        return HttpResponse.json({ documents: [{ id: "d1", name: "Report.pdf" }] }, { status: 200 });
      }),
    );
    const result = await makeClient().listIntegrationDocuments(PROJECT, INTEGRATION, {
      mimeTypes: "application/pdf",
      folderId: "folder-9",
      limit: 25,
      offset: 5,
    });
    expect(result.documents).toEqual([{ id: "d1", name: "Report.pdf" }]);
    expect(receivedSearch).toBe("?mime_types=application%2Fpdf&folder_id=folder-9&limit=25&offset=5");
  });

  it("fetchIntegrationDocument returns the raw document bytes", async () => {
    let receivedPath = "";
    server.use(
      http.get(`${base}/${INTEGRATION}/documents/:documentId`, ({ request }) => {
        receivedPath = new URL(request.url).pathname;
        return HttpResponse.arrayBuffer(new Uint8Array([0x25, 0x50, 0x44, 0x46]).buffer, {
          status: 200,
          headers: { "content-type": "application/pdf" },
        });
      }),
    );
    const bytes = await makeClient().fetchIntegrationDocument(PROJECT, INTEGRATION, "doc/1");
    expect(bytes).toBeInstanceOf(Uint8Array);
    expect([...bytes]).toEqual([0x25, 0x50, 0x44, 0x46]);
    expect(receivedPath).toBe(`/v1/projects/${PROJECT}/integrations/${INTEGRATION}/documents/doc%2F1`);
  });

  it("every integration method is gated to the pro tier", async () => {
    const client = enterpriseClient();
    await expect(client.listIntegrations(PROJECT)).rejects.toThrow(/not available on the 'enterprise' tier/);
    await expect(client.createIntegration(PROJECT, { kind: "gdrive", name: "n", auth_type: "oauth2" })).rejects.toThrow(
      /not available/,
    );
    await expect(client.getIntegration(PROJECT, INTEGRATION)).rejects.toThrow(/not available/);
    await expect(client.deleteIntegration(PROJECT, INTEGRATION)).rejects.toThrow(/not available/);
    await expect(client.connectIntegration(PROJECT, INTEGRATION)).rejects.toThrow(/not available/);
    await expect(client.disconnectIntegration(PROJECT, INTEGRATION)).rejects.toThrow(/not available/);
    await expect(client.listIntegrationDocuments(PROJECT, INTEGRATION)).rejects.toThrow(/not available/);
    await expect(client.fetchIntegrationDocument(PROJECT, INTEGRATION, "d1")).rejects.toThrow(/not available/);
    await expect(client.listApiKeys(PROJECT)).rejects.toThrow(/not available/);
    await expect(client.revokeApiKey(PROJECT, "k1")).rejects.toThrow(/not available/);
    await expect(client.createProject({ name: "x" })).rejects.toThrow(/not available/);
  });
});
