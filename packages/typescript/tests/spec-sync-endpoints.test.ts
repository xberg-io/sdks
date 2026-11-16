import { describe, expect, it, vi } from "vitest";
import { type Target, XbergClient } from "../src/index.js";

function fixture(target: Target, result: unknown, status = 200) {
  const requests: Request[] = [];
  const fetch = vi.fn<typeof globalThis.fetch>(async (input, init) => {
    requests.push(new Request(input, init));
    return status === 204 ? new Response(null, { status }) : Response.json(result, { status });
  });
  const client = new XbergClient({
    baseUrl: "https://data.test",
    controlPlaneBaseUrl: "https://control.test",
    apiKey: "data-token",
    controlPlaneToken: "control-token",
    target,
    fetch,
  });
  function request() {
    expect(requests).toHaveLength(1);
    const [first] = requests;
    if (first === undefined) throw new Error("Expected a request");
    return first;
  }
  return { client, fetch, request };
}

describe("endpoints from the development OpenAPI sync", () => {
  it.each(["enterprise", "pro"] as const)("lists RAG documents and encodes pagination on %s", async (target) => {
    const response = { documents: [], limit: 7, next_cursor: "next" };
    const { client, request } = fixture(target, response);
    const params = {
      limit: 7,
      cursor: "cursor+/",
      ...(target === "pro" ? { projectId: "project" } : {}),
    };
    expect(await client.listRagDocuments("group /#", params)).toEqual(response);
    const req = request();
    const url = new URL(req.url);
    expect(req.method).toBe("GET");
    expect(url.origin).toBe("https://data.test");
    expect(url.pathname).toBe("/v1/rag/collections/group%20%2F%23/documents");
    expect(Object.fromEntries(url.searchParams)).toEqual({ limit: "7", cursor: "cursor+/" });
    expect(req.headers.get("x-project-id")).toBe(target === "pro" ? "project" : null);
  });

  it("updates Enterprise room link access with the room version", async () => {
    const response = { enabled: false, room_version: 42 };
    const { client, request } = fixture("enterprise", response);
    expect(await client.setRoomLinkAccess("room/1", { enabled: false }, 41)).toEqual(response);
    const req = request();
    expect([req.method, req.url]).toEqual(["PUT", "https://data.test/v1/rooms/room%2F1/links"]);
    expect(req.headers.get("if-match")).toBe('"41"');
    expect(await req.json()).toEqual({ enabled: false });
  });

  it("lists Pro job pages using the optional project query", async () => {
    const response = { pages: [1, 4] };
    const { client, request } = fixture("pro", response);
    expect(await client.getJobPageInventory("job/1", { projectId: "project/1" })).toEqual(response);
    const req = request();
    const url = new URL(req.url);
    expect([req.method, url.origin, url.pathname]).toEqual(["GET", "https://data.test", "/v1/jobs/job%2F1/pages"]);
    expect(Object.fromEntries(url.searchParams)).toEqual({ project_id: "project/1" });
  });

  it("binds a Pro integration RAG target and accepts a 204 response", async () => {
    const { client, request } = fixture("pro", undefined, 204);
    expect(
      await client.bindIntegrationRagTarget("project/1", "integration/1", {
        collection_id: "collection",
      }),
    ).toBe(undefined);
    const req = request();
    expect([req.method, req.url]).toEqual([
      "PUT",
      "https://data.test/v1/projects/project%2F1/integrations/integration%2F1/sync/rag-target",
    ]);
    expect(await req.json()).toEqual({ collection_id: "collection" });
  });

  it("checks tier-specific operations before making a request", async () => {
    const enterprise = fixture("enterprise", {});
    const pro = fixture("pro", {});
    await expect(enterprise.client.getJobPageInventory("job")).rejects.toThrow("requires the 'pro' tier");
    await expect(enterprise.client.listRagDocuments("rag", { projectId: "project" })).rejects.toThrow(
      "requires the 'pro' tier",
    );
    await expect(
      enterprise.client.bindIntegrationRagTarget("project", "integration", {
        collection_id: "collection",
      }),
    ).rejects.toThrow("requires the 'pro' tier");
    await expect(pro.client.setRoomLinkAccess("room", { enabled: true }, 1)).rejects.toThrow(
      "requires the 'enterprise' tier",
    );
    expect(enterprise.fetch).not.toHaveBeenCalled();
    expect(pro.fetch).not.toHaveBeenCalled();
  });

  const key = { name: "readers", role_id: "role" };
  const mapping = { email_attribute: "mail", display_name_attribute: null };
  const backendCases = [
    {
      method: "POST",
      path: "/v1/projects/project%2F1/api-keys/role-bound",
      status: 201,
      body: key,
      result: { key_id: "key" },
      call: (client: XbergClient) => client.backendCreateRoleBoundApiKey("project/1", key),
    },
    {
      method: "POST",
      path: "/v1/projects/project%2F1/scim/connections/connection%2F1/revoke",
      status: 200,
      result: { id: "connection/1", active: false },
      call: (client: XbergClient) => client.revokeScimConnection("project/1", "connection/1"),
    },
    {
      method: "PATCH",
      path: "/v1/projects/project%2F1/saml/providers/provider%2F1/attribute-mapping",
      status: 200,
      body: mapping,
      result: { id: "provider/1", attribute_mapping: mapping },
      call: (client: XbergClient) => client.updateSamlAttributeMapping("project/1", "provider/1", mapping),
    },
    {
      method: "POST",
      path: "/v1/projects/project%2F1/saml/providers/provider%2F1/test",
      status: 201,
      result: {
        test_id: "test",
        redirect_url: "https://idp.test",
        expires_at: "2027-01-01T00:00:00Z",
      },
      call: (client: XbergClient) => client.startSamlConnectionTest("project/1", "provider/1"),
    },
    {
      method: "GET",
      path: "/v1/projects/project%2F1/saml/providers/provider%2F1/test/test%2F1",
      status: 200,
      result: { status: "pending", expires_at: "2027-01-01T00:00:00Z" },
      call: (client: XbergClient) => client.getSamlConnectionTestStatus("project/1", "provider/1", "test/1"),
    },
  ];
  it.each(backendCases)("routes $method $path to the control plane", async (scenario) => {
    const { client, request } = fixture("enterprise", scenario.result, scenario.status);
    expect(await scenario.call(client)).toEqual(scenario.result);
    const req = request();
    expect([req.method, req.url]).toEqual([scenario.method, `https://control.test${scenario.path}`]);
    expect(req.headers.get("authorization")).toBe("Bearer control-token");
    expect(req.body === null ? undefined : await req.json()).toEqual(scenario.body);
  });
});
