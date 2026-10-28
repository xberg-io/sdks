---
title: Data rooms
description: Share a curated set of project documents with members, guests, or the public on Enterprise.
---

A data room is an ordered set of a project's documents that you share with project members, invited
guests, or, once published, anyone holding its public link. Data rooms are Enterprise-only: a room
method called against Pro fails before sending a request, like every other Enterprise-only method.
Method names follow the spec's operation IDs in each language's casing (`create_room`, `createRoom`,
`CreateRoom`), and `list_documents` lists the project documents a room can hold.

## Check availability

The plan decides whether rooms exist. The Enterprise `GET /healthz` reports `data_rooms.enabled`. On a
plan without rooms, every room route, the public ones included, answers 404 with the code
`data_room.disabled`. Every SDK raises that as `DataRoomsDisabledError`, a subclass of its
`NotFoundError`, so code that already handles a 404 still matches.

## Concurrency: room versions and `If-Match`

Every room carries an integer version. Three writes send the version you last read as `If-Match`, and
the server refuses a stale one with 412 (`PreconditionFailedError`) and a missing one with 428
(`PreconditionRequiredError`):

| Write | Read the version from |
| --- | --- |
| Rename or describe a room | `version` on the room |
| Reorder room items | `version` on the item list |
| Publish or unpublish | `room_version` on the publication settings |

The version travels in response bodies, not in an `ETag` header. Each of the three writes returns the
new version (`version` on the room and on the reorder answer, `room_version` on the publication
settings), so one versioned write can follow another without a read. Adding or removing an item also
moves the version but returns none: after `add_room_item` or `remove_room_item`, read the version again
with `get_room` or `list_room_items` before the next versioned write, or it fails with 412.

## Credentials

Room management uses the client's credential: a project API key or a user session token.
Previewing and accepting an invitation admit only a signed-in user, so a project API key gets a 403
there. The public routes under `/public/rooms` take no credential, and the SDK sends none to them, even
from a client that holds an API key.

## Python

All methods are on `XbergClient`; `AsyncXbergClient` mirrors them. Request bodies accept the
generated request models or plain mappings, and lists take `limit` and `offset`.

### Rooms and items

```python title="Python"
from xberg_io_sdk import PreconditionFailedError, XbergClient

with XbergClient(api_key="kz_...", base_url="https://xberg.example.com", target="enterprise") as client:
    if not client.enterprise_healthz().data_rooms:
        raise SystemExit("data rooms are not part of this plan")

    room = client.create_room({"name": "Board pack", "description": "Q3 materials"})
    room_id = str(room.id)

    # Rename while the version create_room returned is still current.
    try:
        room = client.update_room(room_id, {"name": "Board pack Q3"}, if_match=room.version)
    except PreconditionFailedError:
        room = client.get_room(room_id)  # someone else changed it: re-read and decide

    documents = client.list_documents(limit=100)  # 100 is the largest page the server serves
    for entry in documents.documents:
        client.add_room_item(room_id, {"document_id": str(entry.document_id)})

    # Each add moved the version without returning it, so read the items and their version.
    # A room can hold more items than one page (500 by default), so page through all of them.
    first = client.list_room_items(room_id, limit=100)
    document_ids = [str(item.document_id) for item in first.items]
    while len(document_ids) < first.total:
        page = client.list_room_items(room_id, limit=100, offset=len(document_ids))
        if not page.items:
            break
        document_ids += [str(item.document_id) for item in page.items]

    if document_ids:
        order = list(reversed(document_ids))
        # If the room changed between pages, the first page's version is stale and this answers 412.
        client.reorder_room_items(room_id, {"document_ids": order}, if_match=first.version)

        original = client.download_room_item(room_id, order[0])  # raw bytes
        page_png = client.get_room_item_page(room_id, order[0], 1)
        content = client.get_room_item_content(room_id, order[0])  # result is None until extracted
```

`if_match` takes the integer version, which is sent quoted, or a string holding the room version
number, quoted or bare, which is sent as given.
`delete_room` keeps the room restorable until its `restorable_until`; `list_rooms(state="deleted")`
lists those rooms and `restore_room` brings one back.

### Members and invitations

```python title="Python"
client.add_room_member(room_id, {"user_id": "project-member-sub", "role": "VIEWER"})
client.change_room_member_role(room_id, "project-member-sub", {"role": "EDITOR"})
client.transfer_room_ownership(room_id, {"user_id": "project-member-sub"})

invitation = client.create_room_invitation(room_id, {"email": "guest@example.com", "role": "VIEWER"})
client.list_room_invitations(room_id)
client.revoke_room_invitation(room_id, str(invitation.id))
```

The invitee previews and accepts with their own session, which you pass as `session_token`. It
replaces the client's credential for that one call:

```python title="Python"
preview = client.preview_room_invitation({"token": invitation_token}, session_token=user_session_jwt)
accepted = client.accept_room_invitation({"token": invitation_token}, session_token=user_session_jwt)
```

A blank `session_token` raises `ValueError` before any request. A token that cannot be accepted answers
404 whatever the reason, and a caller who is already in the room gets 409.

### Publication and the public view

```python title="Python"
settings = client.get_room_publication(room_id)
settings = client.set_room_publication(
    room_id, {"state": "published", "mode": "live", "download_allowed": True}, if_match=settings.room_version
)

anonymous = XbergClient(base_url="https://xberg.example.com", target="enterprise")
public_room = anonymous.get_public_room(settings.slug)
public_items = anonymous.list_public_room_items(settings.slug, limit=20)
if public_items.items:
    item_ref = public_items.items[0].item_ref
    anonymous.get_public_room_item_content(settings.slug, item_ref)
    anonymous.download_public_room_item(settings.slug, item_ref)  # 404 when downloads are off
```

### Retries

With `retries` set, room reads and `DELETE` writes are retried on 502, 503 and 504. The `POST` and
`PATCH` writes (create, restore, add, invite, accept, transfer, leave, rename, role change) and the
writes that send `if_match` (`update_room`, `reorder_room_items`, `set_room_publication`) are not,
unless the client was built with `retry_non_idempotent=True`: a versioned write whose first attempt
applied moved the version, so its replay raises `PreconditionFailedError`. A retried `DELETE` whose
first attempt applied raises `NotFoundError`; after a retried delete, read that 404 as already gone.
429 is retried for every method.

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
  // Each addRoomItem moved the room version without returning it: read it again first.
  const { version } = await client.getRoom(room.id);
  const renamed = await client.updateRoom(room.id, { name: "Q3 diligence (final)" }, version);
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
428. Get the version from `getRoom` or the room returned by a versioned write, from
`listRoomItems(...).version`, or from `getRoomPublication(...).room_version`. `addRoomItem` and
`removeRoomItem` move the version without returning it, so read it again after them.

A 404 with the code `data_room.disabled` throws `DataRoomsDisabledError`. It extends `NotFoundError`, so
code that already catches `NotFoundError` still matches.

List methods take `{ limit, offset }` and return `total`, `limit` and `offset` beside the page.
`listRooms` also takes `state: "deleted"` to list rooms that `restoreRoom` can still bring back.
`downloadRoomItem`, `getRoomItemPage` and `downloadPublicRoomItem` resolve to a `Uint8Array` of raw bytes,
like `getJobPage`.

`previewRoomInvitation` and `acceptRoomInvitation` take the invitation token in the body and an optional
`{ sessionToken }`. That token replaces the client's bearer for that call only, so a client holding a
project API key can still act for the invitee. An empty or whitespace `sessionToken` throws
`ValidationError` before any request:

```ts title="TypeScript"
const preview = await client.previewRoomInvitation({ token }, { sessionToken: userSession });
const accepted = await client.acceptRoomInvitation({ token }, { sessionToken: userSession });
```

The public methods (`getPublicRoom`, `listPublicRoomItems`, `getPublicRoomItemContent`,
`downloadPublicRoomItem`) remove `Authorization`, `Proxy-Authorization`, `Cookie` and `X-Api-Key` from the
request and set `credentials: "omit"`, even on a client built with an API key.

Retries follow the client's method-aware policy. With `retries` set, a 502, 503 or 504 retries the `GET`
and `DELETE` room methods. It does not retry `createRoom`, `addRoomItem`, `addRoomMember`,
`createRoomInvitation`, `leaveRoom`, `transferRoomOwnership`, `restoreRoom`, the invitation methods,
`changeRoomMemberRole`, or the methods that send `If-Match` (`updateRoom`, `reorderRoomItems`,
`setRoomPublication`) unless `retryNonIdempotent` is set: a versioned write whose first attempt applied
moved the version, so its replay throws `PreconditionFailedError`. A retried `DELETE` whose first attempt
applied throws `NotFoundError`, which then means the resource is already gone. A 429 retries for every
method.

## Go

Every room method returns a `*TierError` before any request when the client targets Pro. Check availability first,
and branch on `*xberg.DataRoomsDisabledError` (a `*NotFoundError`) when a deployment turns the feature off:

```go
health, err := client.EnterpriseHealthz(ctx)
if err != nil {
    return err
}
if health.DataRooms == nil || !health.DataRooms.Enabled {
    return errors.New("data rooms are not enabled on this deployment")
}

docs, err := client.ListDocuments(ctx, 50, 0)
if err != nil {
    return err
}
room, err := client.CreateRoom(ctx, xberg.CreateRoomRequest{Name: "Q3 board pack"})
if err != nil {
    return err
}
for _, doc := range docs.Documents {
    if _, err := client.AddRoomItem(ctx, room.Id.String(), xberg.AddItemRequest{DocumentId: doc.DocumentId}); err != nil {
        return err
    }
}
```

Pass the version you read to the three versioned writes (`UpdateRoom`, `ReorderRoomItems`, `SetRoomPublication`) and
keep the version each one returns. `AddRoomItem` and `RemoveRoomItem` move the version without returning it, so read
it again after them. A reorder must name every item, and one page holds at most 100, so page through the items:

```go
first, err := client.ListRoomItems(ctx, roomID, 100, 0)
if err != nil {
    return err
}
var order []uuid.UUID
for _, item := range first.Items {
    order = append(order, item.DocumentId)
}
for int64(len(order)) < first.Total {
    page, err := client.ListRoomItems(ctx, roomID, 100, len(order))
    if err != nil {
        return err
    }
    if len(page.Items) == 0 {
        break
    }
    for _, item := range page.Items {
        order = append(order, item.DocumentId)
    }
}
slices.Reverse(order)
// A change between pages leaves first.Version stale, and the reorder then fails with 412.
reordered, err := client.ReorderRoomItems(ctx, roomID, first.Version, xberg.ReorderItemsRequest{DocumentIds: order})
var stale *xberg.PreconditionFailedError
if errors.As(err, &stale) {
    // Someone changed the room since ListRoomItems: read it again and retry.
}
if err != nil {
    return err
}
nextVersion := reordered.Version
```

`GetRoom` returns `Version`, `ListRoomItems` returns `Version`, and `GetRoomPublication` returns `RoomVersion`; all
three are the same room version. `UpdateRoom` sends `nil` fields as absent, which keeps their stored
values; pass `xberg.ClearRoomDescription()` to send `"description": null` and clear the description.

`DownloadRoomItem`, `DownloadPublicRoomItem` and `GetRoomItemPage` (PNG) return the body as `[]byte`. A room that
does not allow downloads answers 403 (`*AuthError`) on the authenticated route and 404 on the public one.

The `/public/rooms/{slug}` methods (`GetPublicRoom`, `ListPublicRoomItems`, `GetPublicRoomItemContent`,
`DownloadPublicRoomItem`) remove the SDK's own credential headers (`Authorization`, `Proxy-Authorization`, `Cookie`,
`X-Api-Key`) from the request and bypass the `http.Client`'s cookie jar, also on a client built with `WithAPIKey`. A
custom `http.Client` whose `Transport` adds credentials in `RoundTrip` is not affected: those headers are set after the
SDK built the request and still reach the server. A client built without `WithAPIKey` can read a published room.

`PreviewRoomInvitation` and `AcceptRoomInvitation` admit only a signed-in user. Build the client with the invitee's
session token as its bearer; an API key is refused with 403:

```go
invitee, err := xberg.New(xberg.WithBaseURL(baseURL), xberg.WithAPIKey(sessionToken))
if err != nil {
    return err
}
preview, err := invitee.PreviewRoomInvitation(ctx, xberg.RoomAcceptInvitationRequest{Token: token})
```

`CreateRoom`, `AddRoomItem`, `CreateRoomInvitation`, `AcceptRoomInvitation` and the other POST and PATCH methods, and the
methods that send `If-Match` (`UpdateRoom`, `ReorderRoomItems`, `SetRoomPublication`), are not retried on 502, 503 or 504
unless the client sets `WithRetryNonIdempotent(true)`. With it, a retry of a versioned write whose first attempt applied
fails with `*PreconditionFailedError`, because the version moved. The `DELETE` methods are retried; a retry whose first
attempt applied returns `*NotFoundError`, which then means the resource is already gone.
