import { HttpResponse, http } from "msw";
import { afterAll, afterEach, beforeAll, expect, it } from "vitest";
import { XbergClient } from "../src/client.js";
import { TEST_BASE_URL, createTestServer, url } from "./_helpers.js";

const server = createTestServer();
beforeAll(() => server.listen({ onUnhandledRequest: "error" }));
afterEach(() => server.resetHandlers());
afterAll(() => server.close());

const PROJECT = "11111111-1111-4111-8111-111111111111";
const ROOM = "22222222-2222-4222-8222-222222222222";
const LINK = "33333333-3333-4333-8333-333333333333";
const NOW = "2026-11-01T09:00:00Z";
const CONFIG = `/v1/projects/${PROJECT}/extraction-config`;
const PROJECT_PATH = `/v1/projects/${PROJECT}`;
const LINKS = `/v1/rooms/${ROOM}/links`;
const LINK_DATA = {
  id: LINK,
  role: "VIEWER",
  role_name: "data_room.viewer",
  status: "ACTIVE",
  created_at: NOW,
  created_by: "owner",
  token: "link-token",
};
const PROJECT_DATA = {
  id: PROJECT,
  name: "Renamed",
  slug: "project",
  status: "active",
  owner_user_id: "owner",
  created_at: NOW,
  updated_at: NOW,
  api_key_count: 0,
  webhook_count: 0,
  total_pages_extracted: 0,
};
const ACCEPTED = { room_id: ROOM, project_id: PROJECT, kind: "guest", role: "VIEWER" };
const LINKS_PAGE = { links: [], total: 0, limit: 2, offset: 1 };
const NULL_CONFIG = { extraction_config: null };
const EMPTY_CONFIG = { extraction_config: {} };

interface Operation {
  method: "get" | "put" | "post" | "patch" | "delete";
  path: string;
  invoke: (client: XbergClient) => Promise<unknown>;
  expected?: object;
  body?: object;
  status?: number;
  query?: string;
  pro?: boolean;
  token?: string;
}

const operations: Operation[] = [
  {
    method: "get",
    path: CONFIG,
    invoke: (c) => c.getProjectExtractionConfig(PROJECT),
    expected: NULL_CONFIG,
  },
  {
    method: "put",
    path: CONFIG,
    invoke: (c) => c.setProjectExtractionConfig(PROJECT, {}),
    expected: EMPTY_CONFIG,
    body: {},
  },
  { method: "delete", path: CONFIG, invoke: (c) => c.clearProjectExtractionConfig(PROJECT) },
  {
    method: "get",
    path: LINKS,
    invoke: (c) => c.listRoomLinks(ROOM, { limit: 2, offset: 1 }),
    expected: LINKS_PAGE,
    query: "?limit=2&offset=1",
  },
  {
    method: "post",
    path: LINKS,
    invoke: (c) => c.createRoomLink(ROOM, { role: "VIEWER" }),
    expected: LINK_DATA,
    body: { role: "VIEWER" },
    status: 201,
  },
  { method: "delete", path: `${LINKS}/${LINK}`, invoke: (c) => c.revokeRoomLink(ROOM, LINK) },
  {
    method: "post",
    path: "/v1/room-links/accept",
    invoke: (c) => c.acceptRoomLink({ token: "link-token" }, { sessionToken: "session" }),
    expected: ACCEPTED,
    body: { token: "link-token" },
    token: "session",
  },
  {
    method: "get",
    path: PROJECT_PATH,
    invoke: (c) => c.proGetProject(PROJECT),
    expected: PROJECT_DATA,
    pro: true,
  },
  {
    method: "patch",
    path: PROJECT_PATH,
    invoke: (c) => c.proUpdateProject(PROJECT, { name: "Renamed" }),
    expected: PROJECT_DATA,
    body: { name: "Renamed" },
    pro: true,
  },
  { method: "delete", path: PROJECT_PATH, invoke: (c) => c.proDeleteProject(PROJECT), pro: true },
];

it.each(operations)("sends $method $path with the documented request and response", async (operation) => {
  const client = new XbergClient({
    apiKey: "project-key",
    baseUrl: TEST_BASE_URL,
    target: operation.pro ? "pro" : "enterprise",
  });
  const seen: unknown[] = [];
  server.use(
    http[operation.method](url(operation.path), async ({ request }) => {
      const text = await request.text();
      const headers = request.headers;
      seen.push({
        body: text ? JSON.parse(text) : undefined,
        project: headers.get("x-project-id"),
        authorization: headers.get("authorization"),
        query: new URL(request.url).search,
      });
      return operation.expected
        ? HttpResponse.json(operation.expected, { status: operation.status ?? 200 })
        : new HttpResponse(null, { status: 204 });
    }),
  );
  await expect(operation.invoke(client)).resolves.toEqual(operation.expected);
  expect(seen).toEqual([
    {
      body: operation.body,
      project: operation.path === CONFIG ? PROJECT : null,
      authorization: `Bearer ${operation.token ?? "project-key"}`,
      query: operation.query ?? "",
    },
  ]);
});
