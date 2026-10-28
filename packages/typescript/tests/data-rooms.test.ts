import { HttpResponse, http } from "msw";
import { afterAll, afterEach, beforeAll, describe, expect, it } from "vitest";
import { XbergClient } from "../src/client.js";
import {
  DataRoomsDisabledError,
  NotFoundError,
  PreconditionFailedError,
  PreconditionRequiredError,
  ServerError,
  ValidationError,
  XbergError,
} from "../src/errors.js";
import { TEST_BASE_URL, createTestServer, url } from "./_helpers.js";

const server = createTestServer();

beforeAll(() => server.listen({ onUnhandledRequest: "error" }));
afterEach(() => server.resetHandlers());
afterAll(() => server.close());

const ROOM_ID = "0192f0c4-0000-7000-8000-000000000001";
const DOC_ID = "0192f0c4-0000-7000-8000-000000000002";

function makeClient(options: Partial<ConstructorParameters<typeof XbergClient>[0]> = {}): XbergClient {
  return new XbergClient({
    apiKey: "project-key",
    baseUrl: TEST_BASE_URL,
    target: "enterprise",
    sleep: async () => {},
    ...options,
  });
}

interface Seen {
  method: string;
  path: string;
  search: string;
  headers: Headers;
  body: unknown;
}

async function capture(request: Request): Promise<Seen> {
  const parsed = new URL(request.url);
  const text = await request.clone().text();
  return {
    method: request.method,
    path: parsed.pathname,
    search: parsed.search,
    headers: request.headers,
    body: text.length > 0 ? JSON.parse(text) : undefined,
  };
}

const ROOM = {
  id: ROOM_ID,
  project_id: "p",
  name: "Deal room",
  version: 4,
  created_by: "u",
  created_at: "2026-10-01T00:00:00Z",
  updated_at: "2026-10-01T00:00:00Z",
  rights: {},
};

describe("documents", () => {
  it("listDocuments pages through GET /v1/documents", async () => {
    let seen: Seen | undefined;
    server.use(
      http.get(url("/v1/documents"), async ({ request }) => {
        seen = await capture(request);
        return HttpResponse.json({ documents: [{ document_id: DOC_ID }], total: 3, limit: 1, offset: 2 });
      }),
    );
    const page = await makeClient().listDocuments({ limit: 1, offset: 2 });
    expect(page).toEqual({ documents: [{ document_id: DOC_ID }], total: 3, limit: 1, offset: 2 });
    expect(seen?.search).toBe("?limit=1&offset=2");
    expect(seen?.headers.get("authorization")).toBe("Bearer project-key");
  });

  it("listDocuments sends no query string without pagination", async () => {
    let search = "x";
    server.use(
      http.get(url("/v1/documents"), ({ request }) => {
        search = new URL(request.url).search;
        return HttpResponse.json({ documents: [], total: 0, limit: 50, offset: 0 });
      }),
    );
    await makeClient().listDocuments();
    expect(search).toBe("");
  });
});

describe("rooms", () => {
  it("listRooms forwards pagination and state", async () => {
    let seen: Seen | undefined;
    server.use(
      http.get(url("/v1/rooms"), async ({ request }) => {
        seen = await capture(request);
        return HttpResponse.json({ rooms: [ROOM], total: 1, limit: 10, offset: 0 });
      }),
    );
    const page = await makeClient().listRooms({ limit: 10, offset: 0, state: "deleted" });
    expect(page.rooms).toEqual([ROOM]);
    expect(seen?.search).toBe("?limit=10&offset=0&state=deleted");
  });

  it("createRoom posts the body and returns the 201 room", async () => {
    let seen: Seen | undefined;
    server.use(
      http.post(url("/v1/rooms"), async ({ request }) => {
        seen = await capture(request);
        return HttpResponse.json(ROOM, { status: 201 });
      }),
    );
    const room = await makeClient().createRoom({ name: "Deal room", description: null });
    expect(room).toEqual(ROOM);
    expect(seen?.body).toEqual({ name: "Deal room", description: null });
    expect(seen?.headers.get("content-type")).toBe("application/json");
  });

  it("getRoom, deleteRoom and restoreRoom address /v1/rooms/{id}", async () => {
    const calls: string[] = [];
    server.use(
      http.get(url(`/v1/rooms/${ROOM_ID}`), () => {
        calls.push("get");
        return HttpResponse.json(ROOM);
      }),
      http.delete(url(`/v1/rooms/${ROOM_ID}`), () => {
        calls.push("delete");
        return new HttpResponse(null, { status: 204 });
      }),
      http.post(url(`/v1/rooms/${ROOM_ID}/restore`), () => {
        calls.push("restore");
        return HttpResponse.json(ROOM);
      }),
    );
    const client = makeClient();
    expect(await client.getRoom(ROOM_ID)).toEqual(ROOM);
    expect(await client.deleteRoom(ROOM_ID)).toBeUndefined();
    expect(await client.restoreRoom(ROOM_ID)).toEqual(ROOM);
    expect(calls).toEqual(["get", "delete", "restore"]);
  });

  it("updateRoom sends the version as a quoted If-Match and returns the new version", async () => {
    let seen: Seen | undefined;
    server.use(
      http.patch(url(`/v1/rooms/${ROOM_ID}`), async ({ request }) => {
        seen = await capture(request);
        return HttpResponse.json({ ...ROOM, name: "Renamed", version: 5 });
      }),
    );
    const room = await makeClient().updateRoom(ROOM_ID, { name: "Renamed" }, 4);
    expect(seen?.headers.get("if-match")).toBe('"4"');
    expect(seen?.body).toEqual({ name: "Renamed" });
    expect(room.version).toBe(5);
  });

  it("updateRoom maps 412 to PreconditionFailedError", async () => {
    server.use(
      http.patch(url(`/v1/rooms/${ROOM_ID}`), () =>
        HttpResponse.json(
          { error: { code: "precondition_failed", message: "The room changed since you read it" } },
          { status: 412 },
        ),
      ),
    );
    const error = await makeClient()
      .updateRoom(ROOM_ID, { name: "x" }, 3)
      .catch((caught: unknown) => caught);
    expect(error).toBeInstanceOf(PreconditionFailedError);
    expect((error as PreconditionFailedError).status).toBe(412);
    expect((error as PreconditionFailedError).code).toBe("precondition_failed");
  });

  it("updateRoom maps 428 to PreconditionRequiredError", async () => {
    server.use(
      http.patch(url(`/v1/rooms/${ROOM_ID}`), () =>
        HttpResponse.json(
          { error: { code: "precondition_required", message: "Send the room version" } },
          { status: 428 },
        ),
      ),
    );
    await expect(makeClient().updateRoom(ROOM_ID, { name: "x" }, 3)).rejects.toBeInstanceOf(PreconditionRequiredError);
  });

  it("rejects a version that is not a non-negative integer before sending anything", async () => {
    const client = makeClient();
    await expect(client.updateRoom(ROOM_ID, { name: "x" }, 1.5)).rejects.toBeInstanceOf(ValidationError);
    await expect(client.reorderRoomItems(ROOM_ID, { document_ids: [] }, -1)).rejects.toBeInstanceOf(ValidationError);
    await expect(client.setRoomPublication(ROOM_ID, { state: "published" }, Number.NaN)).rejects.toBeInstanceOf(
      ValidationError,
    );
  });

  it("percent-encodes room ids and refuses dot segments", async () => {
    let path = "";
    server.use(
      http.get(url("/v1/rooms/a%2Fb"), ({ request }) => {
        path = new URL(request.url).pathname;
        return HttpResponse.json(ROOM);
      }),
    );
    await makeClient().getRoom("a/b");
    expect(path).toBe("/v1/rooms/a%2Fb");
    await expect(makeClient().getRoom("..")).rejects.toBeInstanceOf(XbergError);
  });
});

describe("room items", () => {
  it("listRoomItems pages and returns the room version", async () => {
    let search = "";
    server.use(
      http.get(url(`/v1/rooms/${ROOM_ID}/items`), ({ request }) => {
        search = new URL(request.url).search;
        return HttpResponse.json({ items: [], total: 0, limit: 5, offset: 10, version: 7 });
      }),
    );
    const page = await makeClient().listRoomItems(ROOM_ID, { limit: 5, offset: 10 });
    expect(page.version).toBe(7);
    expect(search).toBe("?limit=5&offset=10");
  });

  it("addRoomItem posts the document id", async () => {
    let seen: Seen | undefined;
    const item = {
      document_id: DOC_ID,
      position: 0,
      filename: "a.pdf",
      mime_type: "application/pdf",
      size_bytes: 3,
      updated_at: "2026-10-01T00:00:00Z",
    };
    server.use(
      http.post(url(`/v1/rooms/${ROOM_ID}/items`), async ({ request }) => {
        seen = await capture(request);
        return HttpResponse.json(item, { status: 201 });
      }),
    );
    expect(await makeClient().addRoomItem(ROOM_ID, { document_id: DOC_ID })).toEqual(item);
    expect(seen?.body).toEqual({ document_id: DOC_ID });
  });

  it("reorderRoomItems PUTs the order with If-Match", async () => {
    let seen: Seen | undefined;
    server.use(
      http.put(url(`/v1/rooms/${ROOM_ID}/items/order`), async ({ request }) => {
        seen = await capture(request);
        return HttpResponse.json({ document_ids: [DOC_ID], version: 8 });
      }),
    );
    const result = await makeClient().reorderRoomItems(ROOM_ID, { document_ids: [DOC_ID] }, 7);
    expect(result).toEqual({ document_ids: [DOC_ID], version: 8 });
    expect(seen?.headers.get("if-match")).toBe('"7"');
    expect(seen?.body).toEqual({ document_ids: [DOC_ID] });
  });

  it("reorderRoomItems maps 412 and 428", async () => {
    let status = 412;
    server.use(
      http.put(url(`/v1/rooms/${ROOM_ID}/items/order`), () => HttpResponse.json({ error: "stale" }, { status })),
    );
    const client = makeClient();
    await expect(client.reorderRoomItems(ROOM_ID, { document_ids: [] }, 1)).rejects.toBeInstanceOf(
      PreconditionFailedError,
    );
    status = 428;
    await expect(client.reorderRoomItems(ROOM_ID, { document_ids: [] }, 1)).rejects.toBeInstanceOf(
      PreconditionRequiredError,
    );
  });

  it("removeRoomItem deletes the item", async () => {
    let method = "";
    server.use(
      http.delete(url(`/v1/rooms/${ROOM_ID}/items/${DOC_ID}`), ({ request }) => {
        method = request.method;
        return new HttpResponse(null, { status: 204 });
      }),
    );
    expect(await makeClient().removeRoomItem(ROOM_ID, DOC_ID)).toBeUndefined();
    expect(method).toBe("DELETE");
  });

  it("getRoomItemContent returns the extraction result", async () => {
    const content = { document_id: DOC_ID, filename: "a.pdf", mime_type: "application/pdf", status: "completed" };
    server.use(http.get(url(`/v1/rooms/${ROOM_ID}/items/${DOC_ID}/content`), () => HttpResponse.json(content)));
    expect(await makeClient().getRoomItemContent(ROOM_ID, DOC_ID)).toEqual({ ...content });
  });

  it("downloadRoomItem returns the original bytes", async () => {
    const bytes = new Uint8Array([0x25, 0x50, 0x44, 0x46, 0x00, 0xff]);
    server.use(
      http.get(
        url(`/v1/rooms/${ROOM_ID}/items/${DOC_ID}/download`),
        () =>
          new HttpResponse(bytes, {
            status: 200,
            headers: { "Content-Type": "application/pdf", "Content-Disposition": 'attachment; filename="a.pdf"' },
          }),
      ),
    );
    const downloaded = await makeClient().downloadRoomItem(ROOM_ID, DOC_ID);
    expect(downloaded).toBeInstanceOf(Uint8Array);
    expect(Array.from(downloaded)).toEqual(Array.from(bytes));
  });

  it("getRoomItemPage returns PNG bytes for a 1-indexed page", async () => {
    const png = new Uint8Array([0x89, 0x50, 0x4e, 0x47]);
    server.use(
      http.get(
        url(`/v1/rooms/${ROOM_ID}/items/${DOC_ID}/pages/2`),
        () => new HttpResponse(png, { status: 200, headers: { "Content-Type": "image/png" } }),
      ),
    );
    expect(Array.from(await makeClient().getRoomItemPage(ROOM_ID, DOC_ID, 2))).toEqual(Array.from(png));
  });
});

describe("room members and invitations", () => {
  const MEMBER = {
    user_id: "user-2",
    kind: "project_member",
    role: "VIEWER",
    role_name: "Viewer",
    is_owner: false,
    added_by: "u",
    created_at: "2026-10-01T00:00:00Z",
  };

  it("lists, adds, changes and removes members", async () => {
    const calls: string[] = [];
    let addBody: unknown;
    let changeBody: unknown;
    server.use(
      http.get(url(`/v1/rooms/${ROOM_ID}/members`), ({ request }) => {
        calls.push(`list${new URL(request.url).search}`);
        return HttpResponse.json({ members: [MEMBER], total: 1, limit: 1, offset: 0 });
      }),
      http.post(url(`/v1/rooms/${ROOM_ID}/members`), async ({ request }) => {
        calls.push("add");
        addBody = await request.json();
        return HttpResponse.json(MEMBER, { status: 201 });
      }),
      http.patch(url(`/v1/rooms/${ROOM_ID}/members/user-2`), async ({ request }) => {
        calls.push("change");
        changeBody = await request.json();
        return HttpResponse.json({ ...MEMBER, role: "EDITOR" });
      }),
      http.delete(url(`/v1/rooms/${ROOM_ID}/members/user-2`), () => {
        calls.push("remove");
        return new HttpResponse(null, { status: 204 });
      }),
    );
    const client = makeClient();
    expect((await client.listRoomMembers(ROOM_ID, { limit: 1, offset: 0 })).members).toEqual([MEMBER]);
    expect(await client.addRoomMember(ROOM_ID, { user_id: "user-2", role: "VIEWER" })).toEqual(MEMBER);
    expect((await client.changeRoomMemberRole(ROOM_ID, "user-2", { role: "EDITOR" })).role).toBe("EDITOR");
    expect(await client.removeRoomMember(ROOM_ID, "user-2")).toBeUndefined();
    expect(calls).toEqual(["list?limit=1&offset=0", "add", "change", "remove"]);
    expect(addBody).toEqual({ user_id: "user-2", role: "VIEWER" });
    expect(changeBody).toEqual({ role: "EDITOR" });
  });

  it("leaveRoom and transferRoomOwnership post to their routes", async () => {
    let transferBody: unknown;
    let left = false;
    server.use(
      http.post(url(`/v1/rooms/${ROOM_ID}/leave`), () => {
        left = true;
        return new HttpResponse(null, { status: 204 });
      }),
      http.post(url(`/v1/rooms/${ROOM_ID}/ownership`), async ({ request }) => {
        transferBody = await request.json();
        return new HttpResponse(null, { status: 204 });
      }),
    );
    const client = makeClient();
    expect(await client.leaveRoom(ROOM_ID)).toBeUndefined();
    expect(await client.transferRoomOwnership(ROOM_ID, { user_id: "user-2" })).toBeUndefined();
    expect(left).toBe(true);
    expect(transferBody).toEqual({ user_id: "user-2" });
  });

  it("lists, creates and revokes room invitations", async () => {
    const invitation = {
      id: "inv-1",
      email: "guest@example.com",
      role: "VIEWER",
      role_name: "Viewer",
      status: "pending",
      invited_by: "u",
      delivery_channel: "email",
      expires_at: "2026-11-01T00:00:00Z",
      created_at: "2026-10-01T00:00:00Z",
    };
    let createBody: unknown;
    let revoked = "";
    let listSearch = "";
    server.use(
      http.get(url(`/v1/rooms/${ROOM_ID}/invitations`), ({ request }) => {
        listSearch = new URL(request.url).search;
        return HttpResponse.json({ invitations: [invitation], total: 1, limit: 50, offset: 0 });
      }),
      http.post(url(`/v1/rooms/${ROOM_ID}/invitations`), async ({ request }) => {
        createBody = await request.json();
        return HttpResponse.json(invitation, { status: 201 });
      }),
      http.delete(url(`/v1/rooms/${ROOM_ID}/invitations/inv-1`), ({ request }) => {
        revoked = new URL(request.url).pathname;
        return new HttpResponse(null, { status: 204 });
      }),
    );
    const client = makeClient();
    expect((await client.listRoomInvitations(ROOM_ID, { offset: 50 })).invitations).toEqual([invitation]);
    expect(listSearch).toBe("?offset=50");
    expect(await client.createRoomInvitation(ROOM_ID, { email: "guest@example.com", role: "VIEWER" })).toEqual(
      invitation,
    );
    expect(createBody).toEqual({ email: "guest@example.com", role: "VIEWER" });
    await client.revokeRoomInvitation(ROOM_ID, "inv-1");
    expect(revoked).toBe(`/v1/rooms/${ROOM_ID}/invitations/inv-1`);
  });

  it("previewRoomInvitation and acceptRoomInvitation send the session token as the bearer", async () => {
    const seen: Seen[] = [];
    server.use(
      http.post(url("/v1/room-invitations/preview"), async ({ request }) => {
        seen.push(await capture(request));
        return HttpResponse.json({ room_name: "Deal room", item_count: 2, invited_by_name: null });
      }),
      http.post(url("/v1/room-invitations/accept"), async ({ request }) => {
        seen.push(await capture(request));
        return HttpResponse.json({ room_id: ROOM_ID, project_id: "p", kind: "guest", role: "VIEWER" });
      }),
    );
    const client = makeClient();
    const preview = await client.previewRoomInvitation({ token: "tok" }, { sessionToken: "user-session" });
    const accepted = await client.acceptRoomInvitation({ token: "tok" }, { sessionToken: "user-session" });
    expect(preview.room_name).toBe("Deal room");
    expect(accepted.room_id).toBe(ROOM_ID);
    expect(seen.map((request) => request.headers.get("authorization"))).toEqual([
      "Bearer user-session",
      "Bearer user-session",
    ]);
    expect(seen.map((request) => request.body)).toEqual([{ token: "tok" }, { token: "tok" }]);
  });

  it("acceptRoomInvitation falls back to the client credential and refuses an empty session token", async () => {
    let authorization: string | null = null;
    server.use(
      http.post(url("/v1/room-invitations/accept"), ({ request }) => {
        authorization = request.headers.get("authorization");
        return HttpResponse.json({ room_id: ROOM_ID, project_id: "p", kind: "guest", role: "VIEWER" });
      }),
    );
    const client = makeClient({ apiKey: "session-as-api-key" });
    await client.acceptRoomInvitation({ token: "tok" });
    expect(authorization).toBe("Bearer session-as-api-key");
    await expect(client.acceptRoomInvitation({ token: "tok" }, { sessionToken: "" })).rejects.toBeInstanceOf(
      ValidationError,
    );
  });

  it.each(["", "  \t"])(
    "both invitation methods refuse the blank session token %j without a request",
    async (blank) => {
      let requests = 0;
      server.use(
        http.post(url("/v1/room-invitations/:action"), () => {
          requests += 1;
          return HttpResponse.json({});
        }),
      );
      const client = makeClient();
      await expect(client.previewRoomInvitation({ token: "tok" }, { sessionToken: blank })).rejects.toBeInstanceOf(
        ValidationError,
      );
      await expect(client.acceptRoomInvitation({ token: "tok" }, { sessionToken: blank })).rejects.toBeInstanceOf(
        ValidationError,
      );
      expect(requests).toBe(0);
    },
  );
});

describe("room publication", () => {
  const PUBLICATION = {
    room_version: 4,
    state: "unpublished",
    mode: "live",
    download_allowed: false,
    generation: 0,
  };

  it("getRoomPublication reads the settings", async () => {
    server.use(http.get(url(`/v1/rooms/${ROOM_ID}/publication`), () => HttpResponse.json(PUBLICATION)));
    expect(await makeClient().getRoomPublication(ROOM_ID)).toEqual(PUBLICATION);
  });

  it("setRoomPublication PUTs with If-Match and returns the new room version", async () => {
    let seen: Seen | undefined;
    server.use(
      http.put(url(`/v1/rooms/${ROOM_ID}/publication`), async ({ request }) => {
        seen = await capture(request);
        return HttpResponse.json({ ...PUBLICATION, state: "published", room_version: 5, slug: "deal-room" });
      }),
    );
    const result = await makeClient().setRoomPublication(ROOM_ID, { state: "published", download_allowed: true }, 4);
    expect(seen?.headers.get("if-match")).toBe('"4"');
    expect(seen?.body).toEqual({ state: "published", download_allowed: true });
    expect(result.room_version).toBe(5);
    expect(result.slug).toBe("deal-room");
  });

  it("setRoomPublication maps 412 and 428", async () => {
    let status = 412;
    server.use(http.put(url(`/v1/rooms/${ROOM_ID}/publication`), () => HttpResponse.json({}, { status })));
    const client = makeClient();
    await expect(client.setRoomPublication(ROOM_ID, { state: "published" }, 1)).rejects.toBeInstanceOf(
      PreconditionFailedError,
    );
    status = 428;
    await expect(client.setRoomPublication(ROOM_ID, { state: "published" }, 1)).rejects.toBeInstanceOf(
      PreconditionRequiredError,
    );
  });
});

describe("public rooms", () => {
  function clientWithCredentials(): XbergClient {
    return makeClient({
      apiKey: "project-key",
      headers: { Cookie: "session=1", "X-Api-Key": "other", "X-Trace": "kept" },
    });
  }

  it("getPublicRoom sends no credential, no cookie and omits browser credentials", async () => {
    const requests: Request[] = [];
    const client = makeClient({
      apiKey: "project-key",
      headers: { Cookie: "session=1", "Proxy-Authorization": "proxy", "X-Api-Key": "other", "X-Trace": "kept" },
      fetch: async (input, init) => {
        requests.push(new Request(input, init));
        return Response.json({ name: "Deal room", description: null }, { headers: { ETag: '"3"' } });
      },
    });
    expect(await client.getPublicRoom("deal-room")).toEqual({ name: "Deal room", description: null });
    expect(requests).toHaveLength(1);
    const [request] = requests;
    expect(new URL(request?.url ?? "").pathname).toBe("/public/rooms/deal-room");
    for (const header of ["authorization", "cookie", "proxy-authorization", "x-api-key"]) {
      expect(request?.headers.has(header)).toBe(false);
    }
    expect(request?.headers.get("x-trace")).toBe("kept");
    expect(request?.headers.get("user-agent")).toMatch(/^xberg-io-sdk-typescript\//);
    expect(request?.credentials).toBe("omit");
  });

  it("listPublicRoomItems pages without a credential", async () => {
    let seen: Seen | undefined;
    server.use(
      http.get(url("/public/rooms/deal-room/items"), async ({ request }) => {
        seen = await capture(request);
        return HttpResponse.json({ items: [{ item_ref: "r1" }], total: 1, limit: 1, offset: 0 });
      }),
    );
    const page = await clientWithCredentials().listPublicRoomItems("deal-room", { limit: 1, offset: 0 });
    expect(page.items).toEqual([{ item_ref: "r1" }]);
    expect(seen?.search).toBe("?limit=1&offset=0");
    expect(seen?.headers.get("authorization")).toBeNull();
  });

  it("getPublicRoomItemContent and downloadPublicRoomItem send no credential", async () => {
    const authorizations: (string | null)[] = [];
    const bytes = new Uint8Array([1, 2, 3, 250]);
    server.use(
      http.get(url("/public/rooms/deal-room/items/r1/content"), ({ request }) => {
        authorizations.push(request.headers.get("authorization"));
        return HttpResponse.json({ item_ref: "r1", filename: "a.pdf", mime_type: "application/pdf", result: null });
      }),
      http.get(url("/public/rooms/deal-room/items/r1/download"), ({ request }) => {
        authorizations.push(request.headers.get("authorization"));
        return new HttpResponse(bytes, { headers: { "Content-Type": "application/pdf" } });
      }),
    );
    const client = clientWithCredentials();
    expect((await client.getPublicRoomItemContent("deal-room", "r1")).result).toBeNull();
    expect(Array.from(await client.downloadPublicRoomItem("deal-room", "r1"))).toEqual(Array.from(bytes));
    expect(authorizations).toEqual([null, null]);
  });

  it("an authenticated room route still sends the API key after a public call", async () => {
    const authorizations: (string | null)[] = [];
    server.use(
      http.get(url("/public/rooms/deal-room"), ({ request }) => {
        authorizations.push(request.headers.get("authorization"));
        return HttpResponse.json({ name: "Deal room" });
      }),
      http.get(url(`/v1/rooms/${ROOM_ID}`), ({ request }) => {
        authorizations.push(request.headers.get("authorization"));
        return HttpResponse.json(ROOM);
      }),
    );
    const client = makeClient();
    await client.getPublicRoom("deal-room");
    await client.getRoom(ROOM_ID);
    expect(authorizations).toEqual([null, "Bearer project-key"]);
  });
});

describe("tier gating and plan gating", () => {
  it("404 data_room.disabled surfaces as DataRoomsDisabledError, still a NotFoundError", async () => {
    server.use(
      http.get(url("/v1/rooms"), () =>
        HttpResponse.json(
          { error: { code: "data_room.disabled", message: "This plan does not offer data rooms" } },
          { status: 404 },
        ),
      ),
    );
    const error = await makeClient()
      .listRooms()
      .catch((caught: unknown) => caught);
    expect(error).toBeInstanceOf(DataRoomsDisabledError);
    expect(error).toBeInstanceOf(NotFoundError);
    expect((error as DataRoomsDisabledError).code).toBe("data_room.disabled");
    expect((error as DataRoomsDisabledError).name).toBe("DataRoomsDisabledError");
  });

  it("an ordinary 404 on a room route stays a plain NotFoundError", async () => {
    server.use(
      http.get(url(`/v1/rooms/${ROOM_ID}`), () =>
        HttpResponse.json({ error: { code: "not_found", message: "No such room" } }, { status: 404 }),
      ),
    );
    const error = await makeClient()
      .getRoom(ROOM_ID)
      .catch((caught: unknown) => caught);
    expect(error).toBeInstanceOf(NotFoundError);
    expect(error).not.toBeInstanceOf(DataRoomsDisabledError);
  });

  it("room methods refuse a Pro target without a request", async () => {
    const client = new XbergClient({ apiKey: "k", baseUrl: "https://pro.example.test", target: "pro" });
    await expect(client.listRooms()).rejects.toThrow("listRooms() is not available on the 'pro' tier");
    await expect(client.getPublicRoom("s")).rejects.toThrow("getPublicRoom() is not available on the 'pro' tier");
    await expect(client.listDocuments()).rejects.toThrow("listDocuments() is not available on the 'pro' tier");
  });
});

describe("retry policy on room writes", () => {
  it("does not retry a POST on 503 by default", async () => {
    let attempts = 0;
    server.use(
      http.post(url("/v1/rooms"), () => {
        attempts += 1;
        return HttpResponse.json({ error: "unavailable" }, { status: 503 });
      }),
    );
    await expect(makeClient({ retries: 3 }).createRoom({ name: "x" })).rejects.toBeInstanceOf(ServerError);
    expect(attempts).toBe(1);
  });

  it("does not retry a PATCH on 503 by default", async () => {
    let attempts = 0;
    server.use(
      http.patch(url(`/v1/rooms/${ROOM_ID}`), () => {
        attempts += 1;
        return HttpResponse.json({ error: "unavailable" }, { status: 503 });
      }),
    );
    await expect(makeClient({ retries: 3 }).updateRoom(ROOM_ID, { name: "x" }, 1)).rejects.toBeInstanceOf(ServerError);
    expect(attempts).toBe(1);
  });

  it("retries a POST on 503 when retryNonIdempotent is set", async () => {
    let attempts = 0;
    server.use(
      http.post(url("/v1/rooms"), () => {
        attempts += 1;
        return attempts < 2
          ? HttpResponse.json({ error: "unavailable" }, { status: 503 })
          : HttpResponse.json(ROOM, { status: 201 });
      }),
    );
    expect(await makeClient({ retries: 3, retryNonIdempotent: true }).createRoom({ name: "x" })).toEqual(ROOM);
    expect(attempts).toBe(2);
  });

  it.each([
    ["reorderRoomItems", `/v1/rooms/${ROOM_ID}/items/order`],
    ["setRoomPublication", `/v1/rooms/${ROOM_ID}/publication`],
  ] as const)("does not retry the If-Match PUT %s on 503 by default", async (name, path) => {
    let attempts = 0;
    server.use(
      http.put(url(path), () => {
        attempts += 1;
        return HttpResponse.json({ error: "unavailable" }, { status: 503 });
      }),
    );
    const client = makeClient({ retries: 3 });
    const call =
      name === "reorderRoomItems"
        ? client.reorderRoomItems(ROOM_ID, { document_ids: [] }, 7)
        : client.setRoomPublication(ROOM_ID, { state: "published" }, 7);
    await expect(call).rejects.toBeInstanceOf(ServerError);
    expect(attempts).toBe(1);
  });

  it("retries an If-Match PUT on 503 when retryNonIdempotent is set", async () => {
    let attempts = 0;
    server.use(
      http.put(url(`/v1/rooms/${ROOM_ID}/items/order`), ({ request }) => {
        attempts += 1;
        expect(request.headers.get("if-match")).toBe('"7"');
        return attempts < 2
          ? HttpResponse.json({ error: "unavailable" }, { status: 503 })
          : HttpResponse.json({ document_ids: [], version: 8 });
      }),
    );
    const client = makeClient({ retries: 3, retryNonIdempotent: true });
    expect(await client.reorderRoomItems(ROOM_ID, { document_ids: [] }, 7)).toEqual({ document_ids: [], version: 8 });
    expect(attempts).toBe(2);
  });

  it("retries an If-Match PUT on 429", async () => {
    let attempts = 0;
    server.use(
      http.put(url(`/v1/rooms/${ROOM_ID}/items/order`), () => {
        attempts += 1;
        return attempts < 2
          ? HttpResponse.json({ error: "slow down" }, { status: 429 })
          : HttpResponse.json({ document_ids: [], version: 8 });
      }),
    );
    await makeClient({ retries: 3 }).reorderRoomItems(ROOM_ID, { document_ids: [] }, 7);
    expect(attempts).toBe(2);
  });

  it("retries a room item DELETE on 503", async () => {
    let attempts = 0;
    server.use(
      http.delete(url(`/v1/rooms/${ROOM_ID}/items/${DOC_ID}`), () => {
        attempts += 1;
        return attempts < 2
          ? HttpResponse.json({ error: "unavailable" }, { status: 503 })
          : new HttpResponse(null, { status: 204 });
      }),
    );
    await makeClient({ retries: 3 }).removeRoomItem(ROOM_ID, DOC_ID);
    expect(attempts).toBe(2);
  });

  it("retries an idempotent GET on 503", async () => {
    let attempts = 0;
    server.use(
      http.get(url("/public/rooms/deal-room"), ({ request }) => {
        attempts += 1;
        expect(request.headers.get("authorization")).toBeNull();
        return attempts < 3
          ? HttpResponse.json({ error: "unavailable" }, { status: 503 })
          : HttpResponse.json({ name: "Deal room" });
      }),
    );
    expect(await makeClient({ retries: 3 }).getPublicRoom("deal-room")).toEqual({ name: "Deal room" });
    expect(attempts).toBe(3);
  });
});
