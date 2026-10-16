import { HttpResponse, http } from "msw";
import { afterAll, afterEach, beforeAll, describe, expect, it } from "vitest";
import { XbergClient } from "../src/client.js";
import { createTestServer } from "./_helpers.js";

const server = createTestServer();
const baseUrl = "https://pro.example.test";
const path = `${baseUrl}/v1/projects/project-1/integrations/integration-1/sync`;
beforeAll(() => server.listen({ onUnhandledRequest: "error" }));
afterEach(() => server.resetHandlers());
afterAll(() => server.close());

describe("integration synchronization", () => {
  it("reads the persisted state including the scheduler interval", async () => {
    let calls = 0;
    server.use(
      http.get(path, () => {
        calls++;
        return HttpResponse.json({ enabled: false, interval_seconds: 900 });
      }),
    );
    const client = new XbergClient({ baseUrl, apiKey: "test", target: "pro" });
    expect(await client.getIntegrationSync("project-1", "integration-1")).toEqual({
      enabled: false,
      interval_seconds: 900,
    });
    expect(calls).toBe(1);
  });

  it.each([true, false])("writes enabled=%s and accepts an empty 204", async (enabled) => {
    let received: unknown;
    let contentType: string | null = null;
    server.use(
      http.put(path, async ({ request }) => {
        received = await request.json();
        contentType = request.headers.get("content-type");
        return new HttpResponse(null, { status: 204 });
      }),
    );
    const client = new XbergClient({ baseUrl, apiKey: "test", target: "pro" });
    expect(await client.setIntegrationSync("project-1", "integration-1", { enabled })).toBeUndefined();
    expect(received).toEqual({ enabled });
    expect(contentType).toContain("application/json");
  });

  it.each(["get", "put"])("propagates %s failures with the server status", async (verb) => {
    server.use(
      http[verb](path, () => HttpResponse.json({ error: { message: "Integration not found" } }, { status: 404 })),
    );
    const client = new XbergClient({ baseUrl, apiKey: "test", target: "pro" });
    const result =
      verb === "get"
        ? client.getIntegrationSync("project-1", "integration-1")
        : client.setIntegrationSync("project-1", "integration-1", { enabled: true });
    await expect(result).rejects.toMatchObject({ status: 404 });
  });

  it.each(["get", "put"])("rejects %s on Enterprise before any HTTP request", async (verb) => {
    let calls = 0;
    server.use(
      http.all("*", () => {
        calls++;
        return new HttpResponse(null, { status: 500 });
      }),
    );
    const client = new XbergClient({ baseUrl, apiKey: "test", target: "enterprise" });
    const result =
      verb === "get"
        ? client.getIntegrationSync("project-1", "integration-1")
        : client.setIntegrationSync("project-1", "integration-1", { enabled: true });
    await expect(result).rejects.toThrow(/pro/i);
    expect(calls).toBe(0);
  });
});
