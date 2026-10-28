package xberg

import (
	"context"
	"encoding/json"
	"errors"
	"fmt"
	"io"
	"strconv"
)

// This file holds the Enterprise data-room surface: rooms, their items,
// members, invitations and publication, and the anonymous routes of a
// published room. Every method is gated to the Enterprise tier like the rest
// of enterprise.go. A deployment whose plan does not offer data rooms answers
// every room route with 404 `data_room.disabled`, returned as
// [DataRoomsDisabledError] ([EnterpriseHealth.DataRooms] reports it up front).
//
// Writes to a room's name, item order or publication take the room version the
// caller read and send it as If-Match. The server answers a stale version with
// a [PreconditionFailedError] (412) and a missing one with a
// [PreconditionRequiredError] (428). The versioned writes return the next
// version in the response body, not in a header: [RoomResponse.Version],
// [ReorderItemsResponse.Version] and [PublicationResponse.RoomVersion].
// [Client.AddRoomItem] and [Client.RemoveRoomItem] also move the version but
// return none, so read it again ([Client.GetRoom], [ListItemsResponse.Version])
// before the next versioned write.

// ErrCodeDataRoomDisabled is the error code of the 404 a deployment without
// data rooms gives on every room route.
const ErrCodeDataRoomDisabled = "data_room.disabled"

const (
	roomsPath           = "/v1/rooms"
	roomInvitationsPath = "/v1/room-invitations"
	publicRoomsPath     = "/public/rooms"
	acceptPNG           = "image/png"
)

// roomPath renders a room-scoped route, escaping the room ID. suffix is
// appended verbatim and must already start with "/" when non-empty.
func roomPath(roomID, suffix string) string {
	return roomsPath + "/" + escapePathSegment(roomID) + suffix
}

// publicRoomPath renders an anonymous published-room route, escaping the slug.
func publicRoomPath(slug, suffix string) string {
	return publicRoomsPath + "/" + escapePathSegment(slug) + suffix
}

// roomCall is one data-room request: version, when set, is sent as If-Match,
// and anonymous drops the credential.
type roomCall struct {
	method    string
	path      string
	body      any
	version   *int64
	accept    string
	anonymous bool
}

// roomSpec checks the tier and builds the request for call.
func (c *Client) roomSpec(ctx context.Context, operation string, call roomCall) (requestSpec, error) {
	if err := c.requireTier(ctx, TargetEnterprise, operation); err != nil {
		return requestSpec{}, err
	}
	spec := requestSpec{method: call.method, path: call.path, accept: call.accept, anonymous: call.anonymous}
	if call.version != nil {
		spec.ifMatch = `"` + strconv.FormatInt(*call.version, 10) + `"`
	}
	return withJSONBody(spec, call.body)
}

// roomSend issues call and decodes the 2xx JSON answer into out (nil discards it).
func (c *Client) roomSend(ctx context.Context, operation string, call roomCall, out any) error {
	spec, err := c.roomSpec(ctx, operation, call)
	if err != nil {
		return err
	}
	return c.doJSON(ctx, spec, out)
}

// roomJSON issues call and returns the decoded 2xx JSON answer.
func roomJSON[T any](ctx context.Context, c *Client, operation string, call roomCall) (*T, error) {
	var out T
	if err := c.roomSend(ctx, operation, call, &out); err != nil {
		return nil, err
	}
	return &out, nil
}

// roomBytes issues a GET for call and returns the raw 2xx body.
func (c *Client) roomBytes(ctx context.Context, operation string, call roomCall) ([]byte, error) {
	spec, err := c.roomSpec(ctx, operation, call)
	if err != nil {
		return nil, err
	}
	body, err := c.do(ctx, spec)
	if err != nil {
		return nil, err
	}
	defer closeQuietly(body)
	data, err := io.ReadAll(body)
	if err != nil {
		return nil, fmt.Errorf("xberg: reading response body: %w", err)
	}
	return data, nil
}

func versionRef(version int64) *int64 { return &version }

// ListRooms lists the project's rooms (GET /v1/rooms, paginated). state picks
// the live rooms ([ListRoomsParamsStateLive], the server default) or the
// deleted ones still inside their restore window
// ([ListRoomsParamsStateDeleted]); an empty state, or a non-positive limit or
// offset, is omitted from the query string. Enterprise only.
func (c *Client) ListRooms(
	ctx context.Context,
	state ListRoomsParamsState,
	limit, offset int,
) (*ListRoomsResponse, error) {
	query := pageValues(limit, offset)
	if state != "" {
		query.Set("state", string(state))
	}
	call := roomCall{method: methodGet, path: roomsPath + querySuffix(query)}
	return roomJSON[ListRoomsResponse](ctx, c, "ListRooms", call)
}

// CreateRoom creates a room in the project (POST /v1/rooms). A project at its
// room limit is refused with 409. Not retried on 502/503/504 unless
// [WithRetryNonIdempotent] is set. Enterprise only.
func (c *Client) CreateRoom(ctx context.Context, body CreateRoomRequest) (*RoomResponse, error) {
	return roomJSON[RoomResponse](ctx, c, "CreateRoom", roomCall{method: methodPost, path: roomsPath, body: body})
}

// GetRoom fetches one live room with the caller's rights on it
// (GET /v1/rooms/{roomID}). Its Version is what [Client.UpdateRoom] sends as
// If-Match. Enterprise only.
func (c *Client) GetRoom(ctx context.Context, roomID string) (*RoomResponse, error) {
	return roomJSON[RoomResponse](ctx, c, "GetRoom", roomCall{method: methodGet, path: roomPath(roomID, "")})
}

// UpdateRoomOption configures [Client.UpdateRoom].
type UpdateRoomOption func(*updateRoomConfig)

type updateRoomConfig struct {
	clearDescription bool
}

// ClearRoomDescription makes [Client.UpdateRoom] send "description": null,
// which the server reads as "clear the description". The generated
// [UpdateRoomRequest] omits a nil Description, which keeps the stored one.
func ClearRoomDescription() UpdateRoomOption {
	return func(c *updateRoomConfig) { c.clearDescription = true }
}

// UpdateRoom renames a room or changes its description
// (PATCH /v1/rooms/{roomID}), sending version as If-Match. A stale version
// returns [PreconditionFailedError]; the answer carries the next version. A
// nil field keeps its stored value; pass [ClearRoomDescription] to clear the
// description. Not retried on 502/503/504 unless [WithRetryNonIdempotent] is
// set. Enterprise only.
func (c *Client) UpdateRoom(
	ctx context.Context,
	roomID string,
	version int64,
	body UpdateRoomRequest,
	opts ...UpdateRoomOption,
) (*RoomResponse, error) {
	var cfg updateRoomConfig
	for _, opt := range opts {
		opt(&cfg)
	}
	payload, err := updateRoomPayload(body, cfg)
	if err != nil {
		return nil, err
	}
	call := roomCall{method: methodPatch, path: roomPath(roomID, ""), body: payload, version: versionRef(version)}
	return roomJSON[RoomResponse](ctx, c, "UpdateRoom", call)
}

// updateRoomPayload returns body, or with [ClearRoomDescription] its JSON
// fields plus an explicit null description. Going through the encoded fields
// keeps any field the generated type gains later.
func updateRoomPayload(body UpdateRoomRequest, cfg updateRoomConfig) (any, error) {
	if !cfg.clearDescription {
		return body, nil
	}
	if body.Description != nil {
		return nil, errors.New("xberg: UpdateRoom: ClearRoomDescription conflicts with a non-nil Description")
	}
	encoded, err := json.Marshal(body)
	if err != nil {
		return nil, fmt.Errorf("xberg: encoding request body: %w", err)
	}
	fields := map[string]json.RawMessage{}
	if err := json.Unmarshal(encoded, &fields); err != nil {
		return nil, fmt.Errorf("xberg: encoding request body: %w", err)
	}
	fields["description"] = json.RawMessage("null")
	return fields, nil
}

// DeleteRoom deletes a live room (DELETE /v1/rooms/{roomID}). It stays
// restorable until its RestorableUntil time; see [Client.RestoreRoom].
// Enterprise only.
func (c *Client) DeleteRoom(ctx context.Context, roomID string) error {
	return c.roomSend(ctx, "DeleteRoom", roomCall{method: methodDelete, path: roomPath(roomID, "")}, nil)
}

// RestoreRoom restores a deleted room inside its restore window
// (POST /v1/rooms/{roomID}/restore). A project at its room limit is refused
// with 409. Enterprise only.
func (c *Client) RestoreRoom(ctx context.Context, roomID string) (*RoomResponse, error) {
	call := roomCall{method: methodPost, path: roomPath(roomID, "/restore")}
	return roomJSON[RoomResponse](ctx, c, "RestoreRoom", call)
}

// ListRoomItems lists a room's documents in room order
// (GET /v1/rooms/{roomID}/items, paginated). The answer's Version is what
// [Client.ReorderRoomItems] sends as If-Match. A non-positive limit or offset
// is omitted from the query string. Enterprise only.
func (c *Client) ListRoomItems(ctx context.Context, roomID string, limit, offset int) (*ListItemsResponse, error) {
	call := roomCall{method: methodGet, path: roomPath(roomID, "/items") + pageQuery(limit, offset)}
	return roomJSON[ListItemsResponse](ctx, c, "ListRoomItems", call)
}

// AddRoomItem adds a project document to the end of a room
// (POST /v1/rooms/{roomID}/items). The document needs a finished version; one
// already in the room, or a full room, is refused with 409. It moves the room
// version without returning it. Enterprise only.
func (c *Client) AddRoomItem(ctx context.Context, roomID string, body AddItemRequest) (*RoomItemResponse, error) {
	call := roomCall{method: methodPost, path: roomPath(roomID, "/items"), body: body}
	return roomJSON[RoomItemResponse](ctx, c, "AddRoomItem", call)
}

// ReorderRoomItems sets the order of every item in a room
// (PUT /v1/rooms/{roomID}/items/order), sending version as If-Match.
// DocumentIds must name each item exactly once. A stale version returns
// [PreconditionFailedError]; the answer carries the next version. Not retried
// on 502/503/504 unless [WithRetryNonIdempotent] is set: a retry of an attempt
// that did apply fails with 412. Enterprise only.
func (c *Client) ReorderRoomItems(
	ctx context.Context,
	roomID string,
	version int64,
	body ReorderItemsRequest,
) (*ReorderItemsResponse, error) {
	call := roomCall{method: methodPut, path: roomPath(roomID, "/items/order"), body: body, version: versionRef(version)}
	return roomJSON[ReorderItemsResponse](ctx, c, "ReorderRoomItems", call)
}

// RemoveRoomItem removes a document from a room
// (DELETE /v1/rooms/{roomID}/items/{documentID}); the document stays in the
// project. It moves the room version without returning it. A retried call
// whose first attempt applied returns [NotFoundError]. Enterprise only.
func (c *Client) RemoveRoomItem(ctx context.Context, roomID, documentID string) error {
	call := roomCall{method: methodDelete, path: roomPath(roomID, "/items/"+escapePathSegment(documentID))}
	return c.roomSend(ctx, "RemoveRoomItem", call, nil)
}

// GetRoomItemContent fetches the extraction result of a room item's newest
// finished version (GET /v1/rooms/{roomID}/items/{documentID}/content). Result
// is nil until the extraction finishes. Enterprise only.
func (c *Client) GetRoomItemContent(ctx context.Context, roomID, documentID string) (*ItemContentResponse, error) {
	call := roomCall{method: methodGet, path: roomPath(roomID, "/items/"+escapePathSegment(documentID)+"/content")}
	return roomJSON[ItemContentResponse](ctx, c, "GetRoomItemContent", call)
}

// DownloadRoomItem returns the original bytes of a room item
// (GET /v1/rooms/{roomID}/items/{documentID}/download). A room that does not
// allow downloads answers 403 ([AuthError]); a file over the document limit
// answers 413. Enterprise only.
func (c *Client) DownloadRoomItem(ctx context.Context, roomID, documentID string) ([]byte, error) {
	call := roomCall{
		method: methodGet,
		path:   roomPath(roomID, "/items/"+escapePathSegment(documentID)+"/download"),
		accept: acceptAny,
	}
	return c.roomBytes(ctx, "DownloadRoomItem", call)
}

// GetRoomItemPage returns one 1-indexed page of a room item as PNG bytes
// (GET /v1/rooms/{roomID}/items/{documentID}/pages/{pageNumber}), whatever the
// room's download setting. An expired job result answers 410
// ([ResultExpiredError]). Enterprise only.
func (c *Client) GetRoomItemPage(ctx context.Context, roomID, documentID string, pageNumber int) ([]byte, error) {
	suffix := "/items/" + escapePathSegment(documentID) + "/pages/" + strconv.Itoa(pageNumber)
	call := roomCall{method: methodGet, path: roomPath(roomID, suffix), accept: acceptPNG}
	return c.roomBytes(ctx, "GetRoomItemPage", call)
}

// ListRoomMembers lists the users holding a grant on a room
// (GET /v1/rooms/{roomID}/members, paginated). A non-positive limit or offset
// is omitted from the query string. Enterprise only.
func (c *Client) ListRoomMembers(
	ctx context.Context,
	roomID string,
	limit, offset int,
) (*ListRoomMembersResponse, error) {
	call := roomCall{method: methodGet, path: roomPath(roomID, "/members") + pageQuery(limit, offset)}
	return roomJSON[ListRoomMembersResponse](ctx, c, "ListRoomMembers", call)
}

// AddRoomMember gives a project member a grant on a room
// (POST /v1/rooms/{roomID}/members). Anyone outside the project joins through
// [Client.CreateRoomInvitation] instead. Enterprise only.
func (c *Client) AddRoomMember(ctx context.Context, roomID string, body AddMemberRequest) (*RoomMemberResponse, error) {
	call := roomCall{method: methodPost, path: roomPath(roomID, "/members"), body: body}
	return roomJSON[RoomMemberResponse](ctx, c, "AddRoomMember", call)
}

// ChangeRoomMemberRole changes a member's role to an editor or a viewer
// (PATCH /v1/rooms/{roomID}/members/{userID}). The owner's role moves only by
// [Client.TransferRoomOwnership]. Enterprise only.
func (c *Client) ChangeRoomMemberRole(
	ctx context.Context,
	roomID, userID string,
	body RoomChangeRoleRequest,
) (*RoomMemberResponse, error) {
	call := roomCall{method: methodPatch, path: roomPath(roomID, "/members/"+escapePathSegment(userID)), body: body}
	return roomJSON[RoomMemberResponse](ctx, c, "ChangeRoomMemberRole", call)
}

// RemoveRoomMember removes a member's grant on a room
// (DELETE /v1/rooms/{roomID}/members/{userID}). The owner cannot be removed.
// Enterprise only.
func (c *Client) RemoveRoomMember(ctx context.Context, roomID, userID string) error {
	call := roomCall{method: methodDelete, path: roomPath(roomID, "/members/"+escapePathSegment(userID))}
	return c.roomSend(ctx, "RemoveRoomMember", call, nil)
}

// LeaveRoom removes the caller's own grant on a room
// (POST /v1/rooms/{roomID}/leave). The owner cannot leave. Enterprise only.
func (c *Client) LeaveRoom(ctx context.Context, roomID string) error {
	return c.roomSend(ctx, "LeaveRoom", roomCall{method: methodPost, path: roomPath(roomID, "/leave")}, nil)
}

// TransferRoomOwnership makes another member the room's owner
// (POST /v1/rooms/{roomID}/ownership). The new owner must be a project member
// who already holds a grant on the room. Enterprise only.
func (c *Client) TransferRoomOwnership(ctx context.Context, roomID string, body RoomTransferOwnershipRequest) error {
	call := roomCall{method: methodPost, path: roomPath(roomID, "/ownership"), body: body}
	return c.roomSend(ctx, "TransferRoomOwnership", call, nil)
}

// ListRoomInvitations lists a room's invitations with status, role and expiry
// (GET /v1/rooms/{roomID}/invitations, paginated); never their tokens. A
// non-positive limit or offset is omitted from the query string. Enterprise
// only.
func (c *Client) ListRoomInvitations(
	ctx context.Context,
	roomID string,
	limit, offset int,
) (*ListRoomInvitationsResponse, error) {
	call := roomCall{method: methodGet, path: roomPath(roomID, "/invitations") + pageQuery(limit, offset)}
	return roomJSON[ListRoomInvitationsResponse](ctx, c, "ListRoomInvitations", call)
}

// CreateRoomInvitation invites an email address to a room with a role
// (POST /v1/rooms/{roomID}/invitations). Token is set only when the delivery
// channel returns it. Not retried on 502/503/504 unless
// [WithRetryNonIdempotent] is set. Enterprise only.
func (c *Client) CreateRoomInvitation(
	ctx context.Context,
	roomID string,
	body RoomInviteRequest,
) (*RoomInvitationResponse, error) {
	call := roomCall{method: methodPost, path: roomPath(roomID, "/invitations"), body: body}
	return roomJSON[RoomInvitationResponse](ctx, c, "CreateRoomInvitation", call)
}

// RevokeRoomInvitation revokes a pending invitation
// (DELETE /v1/rooms/{roomID}/invitations/{invitationID}). Enterprise only.
func (c *Client) RevokeRoomInvitation(ctx context.Context, roomID, invitationID string) error {
	call := roomCall{method: methodDelete, path: roomPath(roomID, "/invitations/"+escapePathSegment(invitationID))}
	return c.roomSend(ctx, "RevokeRoomInvitation", call, nil)
}

// PreviewRoomInvitation shows the room an invitation token opens before it is
// accepted (POST /v1/room-invitations/preview). The server admits only a
// signed-in user: configure the client's bearer with a user session token
// ([WithAPIKey]); an API key is refused with 403 ([AuthError]). A token that
// cannot be accepted answers 404. Enterprise only.
func (c *Client) PreviewRoomInvitation(
	ctx context.Context,
	body RoomAcceptInvitationRequest,
) (*InvitationPreviewResponse, error) {
	call := roomCall{method: methodPost, path: roomInvitationsPath + "/preview", body: body}
	return roomJSON[InvitationPreviewResponse](ctx, c, "PreviewRoomInvitation", call)
}

// AcceptRoomInvitation accepts an invitation token for the signed-in user and
// grants them the room (POST /v1/room-invitations/accept). Like
// [Client.PreviewRoomInvitation] it needs a user session token as the bearer;
// an API key is refused with 403. Not retried on 502/503/504 unless
// [WithRetryNonIdempotent] is set. Enterprise only.
func (c *Client) AcceptRoomInvitation(
	ctx context.Context,
	body RoomAcceptInvitationRequest,
) (*AcceptedInvitationResponse, error) {
	call := roomCall{method: methodPost, path: roomInvitationsPath + "/accept", body: body}
	return roomJSON[AcceptedInvitationResponse](ctx, c, "AcceptRoomInvitation", call)
}

// GetRoomPublication reads a room's public-view settings
// (GET /v1/rooms/{roomID}/publication). RoomVersion is what
// [Client.SetRoomPublication] sends as If-Match. Enterprise only.
func (c *Client) GetRoomPublication(ctx context.Context, roomID string) (*PublicationResponse, error) {
	call := roomCall{method: methodGet, path: roomPath(roomID, "/publication")}
	return roomJSON[PublicationResponse](ctx, c, "GetRoomPublication", call)
}

// SetRoomPublication publishes or unpublishes a room and optionally sets its
// mode and download setting (PUT /v1/rooms/{roomID}/publication), sending
// version as If-Match; a nil field keeps its stored value. A stale version
// returns [PreconditionFailedError]. Not retried on 502/503/504 unless
// [WithRetryNonIdempotent] is set: a retry of an attempt that did apply fails
// with 412. Enterprise only.
func (c *Client) SetRoomPublication(
	ctx context.Context,
	roomID string,
	version int64,
	body SetPublicationRequest,
) (*PublicationResponse, error) {
	call := roomCall{method: methodPut, path: roomPath(roomID, "/publication"), body: body, version: versionRef(version)}
	return roomJSON[PublicationResponse](ctx, c, "SetRoomPublication", call)
}

// GetPublicRoom reads a published room by its slug (GET /public/rooms/{slug}).
// The route takes no credential, so none is sent. A room that is not published
// answers 404. Enterprise only.
func (c *Client) GetPublicRoom(ctx context.Context, slug string) (*PublicRoomResponse, error) {
	call := roomCall{method: methodGet, path: publicRoomPath(slug, ""), anonymous: true}
	return roomJSON[PublicRoomResponse](ctx, c, "GetPublicRoom", call)
}

// ListPublicRoomItems lists a published room's items in room order
// (GET /public/rooms/{slug}/items, paginated) without sending a credential.
// Each item's ItemRef addresses its content and download. A non-positive limit
// or offset is omitted from the query string. Enterprise only.
func (c *Client) ListPublicRoomItems(
	ctx context.Context,
	slug string,
	limit, offset int,
) (*PublicItemsResponse, error) {
	call := roomCall{method: methodGet, path: publicRoomPath(slug, "/items") + pageQuery(limit, offset), anonymous: true}
	return roomJSON[PublicItemsResponse](ctx, c, "ListPublicRoomItems", call)
}

// GetPublicRoomItemContent fetches the extraction result of a published room's
// item (GET /public/rooms/{slug}/items/{itemRef}/content) without sending a
// credential. Result is nil until the extraction finishes. Enterprise only.
func (c *Client) GetPublicRoomItemContent(
	ctx context.Context,
	slug, itemRef string,
) (*PublicItemContentResponse, error) {
	call := roomCall{
		method:    methodGet,
		path:      publicRoomPath(slug, "/items/"+escapePathSegment(itemRef)+"/content"),
		anonymous: true,
	}
	return roomJSON[PublicItemContentResponse](ctx, c, "GetPublicRoomItemContent", call)
}

// DownloadPublicRoomItem returns the original bytes of a published room's item
// (GET /public/rooms/{slug}/items/{itemRef}/download) without sending a
// credential. A room that does not allow downloads answers 404. Enterprise
// only.
func (c *Client) DownloadPublicRoomItem(ctx context.Context, slug, itemRef string) ([]byte, error) {
	call := roomCall{
		method:    methodGet,
		path:      publicRoomPath(slug, "/items/"+escapePathSegment(itemRef)+"/download"),
		accept:    acceptAny,
		anonymous: true,
	}
	return c.roomBytes(ctx, "DownloadPublicRoomItem", call)
}

// ListDocuments lists the documents of the caller's project
// (GET /v1/documents, paginated): the IDs [Client.AddRoomItem] takes. A
// non-positive limit or offset is omitted from the query string. Enterprise
// only.
func (c *Client) ListDocuments(ctx context.Context, limit, offset int) (*ListProjectDocumentsResponse, error) {
	call := roomCall{method: methodGet, path: documentsPath + pageQuery(limit, offset)}
	return roomJSON[ListProjectDocumentsResponse](ctx, c, "ListDocuments", call)
}
