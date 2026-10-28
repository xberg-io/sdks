---
title: Data rooms
description: Share curated sets of project documents with members, guests and the public.
---

Data rooms are Enterprise-only. A room holds an ordered set of the project's documents, a list of members and
invitations, and an optional public view addressed by a slug. A deployment whose plan does not offer data rooms
answers every room route with 404 `data_room.disabled`; the Enterprise `/healthz` reports `data_rooms.enabled`
before you call one.

Changes to a room's name, item order and publication take the room version you last read, sent as `If-Match`. A stale
version fails with 412 and a missing one with 428. The new version comes back in the response body, not in an `ETag`
header.

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
keep the version each one returns:

```go
items, err := client.ListRoomItems(ctx, roomID, 0, 0)
if err != nil {
    return err
}
order := []uuid.UUID{ /* every item, each once */ }
reordered, err := client.ReorderRoomItems(ctx, roomID, items.Version, xberg.ReorderItemsRequest{DocumentIds: order})
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
three are the same room version. `UpdateRoom` sends `nil` fields as absent, so it cannot clear a description.

`DownloadRoomItem`, `DownloadPublicRoomItem` and `GetRoomItemPage` (PNG) return the body as `[]byte`. A room that
does not allow downloads answers 403 (`*AuthError`) on the authenticated route and 404 on the public one.

The `/public/rooms/{slug}` methods (`GetPublicRoom`, `ListPublicRoomItems`, `GetPublicRoomItemContent`,
`DownloadPublicRoomItem`) never send the client's credential, so a client built without `WithAPIKey` can read a
published room.

`PreviewRoomInvitation` and `AcceptRoomInvitation` admit only a signed-in user. Build the client with the invitee's
session token as its bearer; an API key is refused with 403:

```go
invitee, err := xberg.New(xberg.WithBaseURL(baseURL), xberg.WithAPIKey(sessionToken))
if err != nil {
    return err
}
preview, err := invitee.PreviewRoomInvitation(ctx, xberg.RoomAcceptInvitationRequest{Token: token})
```

`CreateRoom`, `AddRoomItem`, `CreateRoomInvitation`, `AcceptRoomInvitation` and the other POST and PATCH methods are not
retried on 502, 503 or 504 unless the client sets `WithRetryNonIdempotent(true)`. `ReorderRoomItems` and
`SetRoomPublication` are PUTs and are retried; a retry of an attempt that did apply fails with 412, because the version
moved.
