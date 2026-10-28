---
title: Data rooms
description: Share extracted documents in Enterprise data rooms, manage members, and publish a public view.
---

Data rooms are Enterprise-only. A room collects documents from one project, grants members a role on
it, and can publish a read-only public view under a slug. The plan decides whether rooms exist at all:
`GET /healthz` reports `data_rooms.enabled`, and on a plan without rooms every room route answers 404
with the code `data_room.disabled`.

Three rules hold in every language:

- **Versioned writes.** Renaming a room, reordering its items and changing its publication send the room
  version you last read as `If-Match`. A stale version answers 412 and a missing one 428. The server
  returns the new version in the response body (`version`, or `room_version` for publication); it sends
  no `ETag` header on these routes.
- **Invitations need a user.** Previewing and accepting an invitation admit a signed-in dashboard user,
  never an API key, which answers 403.
- **Public routes are anonymous.** The `/public/rooms/...` routes take no credential, and the SDK sends
  none to them.

## TypeScript

Every room method checks the Enterprise tier first, like the other Enterprise-only methods, and a Pro
target throws before any request. Method names follow the spec's operation IDs: `listRooms`,
`createRoom`, `getRoom`, `updateRoom`, `deleteRoom`, `restoreRoom`, the `*RoomItem*`, `*RoomMember*` and
`*RoomInvitation*` families, `getRoomPublication`, `setRoomPublication`, and the four `*PublicRoom*`
methods. `listDocuments` lists the project documents a room can hold.

```ts title="TypeScript"
import { DataRoomsDisabledError, PreconditionFailedError, XbergClient } from "@xberg-io/sdk";

const client = new XbergClient({ baseUrl: process.env.XBERG_BASE_URL!, apiKey: process.env.XBERG_API_KEY! });

const health = await client.enterpriseHealthz();
if (!health.data_rooms.enabled) throw new Error("this plan does not offer data rooms");

const room = await client.createRoom({ name: "Q3 diligence" });
const { documents } = await client.listDocuments({ limit: 10 });
for (const doc of documents) await client.addRoomItem(room.id, { document_id: doc.document_id });

try {
  const renamed = await client.updateRoom(room.id, { name: "Q3 diligence (final)" }, room.version);
  console.log("now at version", renamed.version);
} catch (error) {
  if (error instanceof PreconditionFailedError) {
    // Someone changed the room since it was read: read it again, then retry.
  } else if (error instanceof DataRoomsDisabledError) {
    // The plan stopped offering data rooms.
  } else {
    throw error;
  }
}
```

`updateRoom(roomId, body, version)`, `reorderRoomItems(roomId, body, version)` and
`setRoomPublication(roomId, body, version)` take the version as a number and send it as
`If-Match: "<version>"`. They throw `PreconditionFailedError` on 412 and `PreconditionRequiredError` on
428. Get the version from `getRoom` or the room returned by a write, from `listRoomItems(...).version`,
or from `getRoomPublication(...).room_version`.

A 404 with the code `data_room.disabled` throws `DataRoomsDisabledError`. It extends `NotFoundError`, so
code that already catches `NotFoundError` still matches.

List methods take `{ limit, offset }` and return `total`, `limit` and `offset` beside the page.
`listRooms` also takes `state: "deleted"` to list rooms that `restoreRoom` can still bring back.
`downloadRoomItem`, `getRoomItemPage` and `downloadPublicRoomItem` resolve to a `Uint8Array` of raw bytes,
like `getJobPage`.

`previewRoomInvitation` and `acceptRoomInvitation` take the invitation token in the body and an optional
`{ sessionToken }`. That token replaces the client's bearer for that call only, so a client holding a
project API key can still act for the invitee:

```ts title="TypeScript"
const preview = await client.previewRoomInvitation({ token }, { sessionToken: userSession });
const accepted = await client.acceptRoomInvitation({ token }, { sessionToken: userSession });
```

The public methods (`getPublicRoom`, `listPublicRoomItems`, `getPublicRoomItemContent`,
`downloadPublicRoomItem`) remove `Authorization`, `Proxy-Authorization`, `Cookie` and `X-Api-Key` from the
request and set `credentials: "omit"`, even on a client built with an API key.

Retries follow the client's method-aware policy. With `retries` set, a 502, 503 or 504 retries the `GET`,
`PUT` and `DELETE` room methods. It does not retry `createRoom`, `addRoomItem`, `addRoomMember`,
`createRoomInvitation`, `leaveRoom`, `transferRoomOwnership`, `restoreRoom`, the invitation methods,
`updateRoom` or `changeRoomMemberRole` unless `retryNonIdempotent` is set. A 429 retries for every method.
