package xberg_test

import (
	"bytes"
	"context"
	"errors"
	"io"
	"net/http"
	"net/http/cookiejar"
	"net/http/httptest"
	"net/url"
	"strings"
	"sync"
	"sync/atomic"
	"testing"

	"github.com/google/uuid"

	xberg "github.com/xberg-io/sdks/packages/go"
)

const (
	testRoomID    = "0b6f8c1e-0000-4000-8000-0000000000a1"
	testRoomDocID = "0b6f8c1e-0000-4000-8000-0000000000d1"
	testRoomUser  = "user-7"
	testRoomSlug  = "q3-board-pack"
	testItemRef   = "itm_42"
	testRoomKey   = "kz_room_test_key"
	roomBody      = `{"id":"` + testRoomID + `","project_id":"` + testRoomID + `","name":"Board","version":8,` +
		`"created_by":"u","created_at":"2026-01-01T00:00:00Z","updated_at":"2026-01-01T00:00:00Z",` +
		`"rights":{"role":"OWNER","permissions":["data_room.read"]}}`
	publicationBody = `{"state":"published","mode":"live","download_allowed":true,"generation":3,` +
		`"room_version":9,"slug":"` + testRoomSlug + `"}`
	memberBody = `{"user_id":"` + testRoomUser + `","kind":"member","role":"EDITOR","role_name":"Editor",` +
		`"is_owner":false,"added_by":"u","created_at":"2026-01-01T00:00:00Z"}`
	invitationBody = `{"id":"` + testRoomID + `","email":"a@example.com","role":"VIEWER","role_name":"Viewer",` +
		`"status":"pending","delivery_channel":"email","invited_by":"u","created_at":"2026-01-01T00:00:00Z",` +
		`"expires_at":"2026-01-08T00:00:00Z"}`
	itemBody = `{"document_id":"` + testRoomDocID + `","filename":"a.pdf","mime_type":"application/pdf",` +
		`"position":1,"size_bytes":10,"updated_at":"2026-01-01T00:00:00Z"}`
)

// roomRequest is what the room fixture server saw for one request.
type roomRequest struct {
	method        string
	path          string
	query         string
	body          string
	accept        string
	ifMatch       string
	authorization string
	hasAuth       bool
}

// roomServer answers every request with status and response, recording the
// last request (headers included) in seen. The client carries an API key so
// the anonymous routes can be shown to drop it.
func roomServer(t *testing.T, status int, response []byte, seen *roomRequest) *xberg.Client {
	t.Helper()
	var mu sync.Mutex
	server := httptest.NewServer(http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
		body, err := io.ReadAll(r.Body)
		if err != nil {
			t.Errorf("reading request body: %v", err)
		}
		mu.Lock()
		_, hasAuth := r.Header["Authorization"]
		*seen = roomRequest{
			method:        r.Method,
			path:          r.URL.EscapedPath(),
			query:         r.URL.RawQuery,
			body:          string(body),
			accept:        r.Header.Get("Accept"),
			ifMatch:       r.Header.Get("If-Match"),
			authorization: r.Header.Get("Authorization"),
			hasAuth:       hasAuth,
		}
		mu.Unlock()
		w.WriteHeader(status)
		_, _ = w.Write(response)
	}))
	t.Cleanup(server.Close)
	return mustClient(t,
		xberg.WithBaseURL(server.URL),
		xberg.WithTarget(xberg.TargetEnterprise),
		xberg.WithAPIKey(testRoomKey),
	)
}

func wantRequest(t *testing.T, seen roomRequest, method, path string) {
	t.Helper()
	if seen.method != method || seen.path != path {
		t.Errorf("request = %s %s, want %s %s", seen.method, seen.path, method, path)
	}
}

// roomCase is one wrapper call and the request it must put on the wire.
type roomCase struct {
	name   string
	status int
	body   string
	call   func(*xberg.Client) error
	method string
	path   string
	query  string
	sent   string
}

// runRoomCases runs each case against its own fixture and checks the request,
// including that the configured bearer was sent.
func runRoomCases(t *testing.T, cases []roomCase) {
	t.Helper()
	for _, tc := range cases {
		t.Run(tc.name, func(t *testing.T) {
			t.Parallel()
			var seen roomRequest
			client := roomServer(t, tc.status, []byte(tc.body), &seen)
			if err := tc.call(client); err != nil {
				t.Fatalf("%s: %v", tc.name, err)
			}
			wantRequest(t, seen, tc.method, tc.path)
			if seen.query != tc.query {
				t.Errorf("query = %q, want %q", seen.query, tc.query)
			}
			if seen.body != tc.sent {
				t.Errorf("body = %q, want %q", seen.body, tc.sent)
			}
			if seen.authorization != "Bearer "+testRoomKey {
				t.Errorf("Authorization = %q, want the configured bearer", seen.authorization)
			}
			if seen.ifMatch != "" {
				t.Errorf("If-Match = %q, want none on a call that takes no version", seen.ifMatch)
			}
		})
	}
}

// roomLifecycleCases covers the room CRUD routes and the project document list.
func roomLifecycleCases(t *testing.T) []roomCase {
	t.Helper()
	ctx := context.Background()
	roomPath := "/v1/rooms/" + testRoomID
	return []roomCase{
		{
			name: "list", status: http.StatusOK,
			body: `{"rooms":[` + roomBody + `],"total":1,"limit":10,"offset":20}`,
			call: func(c *xberg.Client) error {
				page, err := c.ListRooms(ctx, xberg.ListRoomsParamsStateDeleted, 10, 20)
				if err == nil && (page.Total != 1 || len(page.Rooms) != 1 || page.Rooms[0].Version != 8) {
					t.Errorf("ListRooms page = %+v", page)
				}
				return err
			},
			method: http.MethodGet, path: "/v1/rooms", query: "limit=10&offset=20&state=deleted",
		},
		{
			name: "create", status: http.StatusCreated, body: roomBody,
			call: func(c *xberg.Client) error {
				room, err := c.CreateRoom(ctx, xberg.CreateRoomRequest{Name: "Board"})
				if err == nil && room.Name != "Board" {
					t.Errorf("CreateRoom name = %q", room.Name)
				}
				return err
			},
			method: http.MethodPost, path: "/v1/rooms", sent: `{"name":"Board"}`,
		},
		{
			name: "get", status: http.StatusOK, body: roomBody,
			call: func(c *xberg.Client) error {
				room, err := c.GetRoom(ctx, testRoomID)
				if err == nil && room.Version != 8 {
					t.Errorf("GetRoom version = %d, want 8", room.Version)
				}
				return err
			},
			method: http.MethodGet, path: roomPath,
		},
		{
			name: "delete", status: http.StatusNoContent,
			call:   func(c *xberg.Client) error { return c.DeleteRoom(ctx, testRoomID) },
			method: http.MethodDelete, path: roomPath,
		},
		{
			name: "restore", status: http.StatusOK, body: roomBody,
			call: func(c *xberg.Client) error {
				_, err := c.RestoreRoom(ctx, testRoomID)
				return err
			},
			method: http.MethodPost, path: roomPath + "/restore",
		},
		{
			name: "list documents", status: http.StatusOK,
			body: `{"documents":[],"total":0,"limit":5,"offset":0}`,
			call: func(c *xberg.Client) error {
				page, err := c.ListDocuments(ctx, 5, 0)
				if err == nil && page.Limit != 5 {
					t.Errorf("ListDocuments limit = %d, want 5", page.Limit)
				}
				return err
			},
			method: http.MethodGet, path: "/v1/documents", query: "limit=5",
		},
	}
}

// roomItemCases covers the room item routes that return JSON.
func roomItemCases(t *testing.T) []roomCase {
	t.Helper()
	ctx := context.Background()
	roomPath := "/v1/rooms/" + testRoomID
	docID := uuid.MustParse(testRoomDocID)
	return []roomCase{
		{
			name: "list items", status: http.StatusOK,
			body: `{"items":[` + itemBody + `],"total":1,"limit":50,"offset":0,"version":12}`,
			call: func(c *xberg.Client) error {
				page, err := c.ListRoomItems(ctx, testRoomID, 0, 0)
				if err == nil && page.Version != 12 {
					t.Errorf("ListRoomItems version = %d, want 12", page.Version)
				}
				return err
			},
			method: http.MethodGet, path: roomPath + "/items",
		},
		{
			name: "add item", status: http.StatusCreated, body: itemBody,
			call: func(c *xberg.Client) error {
				_, err := c.AddRoomItem(ctx, testRoomID, xberg.AddItemRequest{DocumentId: docID})
				return err
			},
			method: http.MethodPost, path: roomPath + "/items", sent: `{"document_id":"` + testRoomDocID + `"}`,
		},
		{
			name: "remove item", status: http.StatusNoContent,
			call:   func(c *xberg.Client) error { return c.RemoveRoomItem(ctx, testRoomID, testRoomDocID) },
			method: http.MethodDelete, path: roomPath + "/items/" + testRoomDocID,
		},
		{
			name: "item content", status: http.StatusOK,
			body: `{"document_id":"` + testRoomDocID + `","filename":"a.pdf","mime_type":"application/pdf",` +
				`"status":"completed"}`,
			call: func(c *xberg.Client) error {
				content, err := c.GetRoomItemContent(ctx, testRoomID, testRoomDocID)
				if err == nil && content.Result != nil {
					t.Errorf("GetRoomItemContent result = %+v, want nil before extraction finishes", content.Result)
				}
				return err
			},
			method: http.MethodGet, path: roomPath + "/items/" + testRoomDocID + "/content",
		},
	}
}

// roomMemberCases covers the room member routes.
func roomMemberCases(t *testing.T) []roomCase {
	t.Helper()
	ctx := context.Background()
	roomPath := "/v1/rooms/" + testRoomID
	return []roomCase{
		{
			name: "list members", status: http.StatusOK,
			body: `{"members":[` + memberBody + `],"total":1,"limit":2,"offset":4}`,
			call: func(c *xberg.Client) error {
				page, err := c.ListRoomMembers(ctx, testRoomID, 2, 4)
				if err == nil && (len(page.Members) != 1 || page.Members[0].UserId != testRoomUser) {
					t.Errorf("ListRoomMembers page = %+v", page)
				}
				return err
			},
			method: http.MethodGet, path: roomPath + "/members", query: "limit=2&offset=4",
		},
		{
			name: "add member", status: http.StatusCreated, body: memberBody,
			call: func(c *xberg.Client) error {
				_, err := c.AddRoomMember(ctx, testRoomID, xberg.AddMemberRequest{Role: "EDITOR", UserId: testRoomUser})
				return err
			},
			method: http.MethodPost, path: roomPath + "/members", sent: `{"role":"EDITOR","user_id":"user-7"}`,
		},
		{
			name: "change member role", status: http.StatusOK, body: memberBody,
			call: func(c *xberg.Client) error {
				_, err := c.ChangeRoomMemberRole(ctx, testRoomID, testRoomUser, xberg.RoomChangeRoleRequest{Role: "VIEWER"})
				return err
			},
			method: http.MethodPatch, path: roomPath + "/members/" + testRoomUser, sent: `{"role":"VIEWER"}`,
		},
		{
			name: "remove member", status: http.StatusNoContent,
			call:   func(c *xberg.Client) error { return c.RemoveRoomMember(ctx, testRoomID, testRoomUser) },
			method: http.MethodDelete, path: roomPath + "/members/" + testRoomUser,
		},
		{
			name: "leave", status: http.StatusNoContent,
			call:   func(c *xberg.Client) error { return c.LeaveRoom(ctx, testRoomID) },
			method: http.MethodPost, path: roomPath + "/leave",
		},
		{
			name: "transfer ownership", status: http.StatusNoContent,
			call: func(c *xberg.Client) error {
				return c.TransferRoomOwnership(ctx, testRoomID, xberg.RoomTransferOwnershipRequest{UserId: testRoomUser})
			},
			method: http.MethodPost, path: roomPath + "/ownership", sent: `{"user_id":"user-7"}`,
		},
	}
}

// roomInvitationCases covers invitations and the publication read.
func roomInvitationCases(t *testing.T) []roomCase {
	t.Helper()
	ctx := context.Background()
	roomPath := "/v1/rooms/" + testRoomID
	return []roomCase{
		{
			name: "list invitations", status: http.StatusOK,
			body: `{"invitations":[` + invitationBody + `],"total":1,"limit":50,"offset":0}`,
			call: func(c *xberg.Client) error {
				_, err := c.ListRoomInvitations(ctx, testRoomID, 0, 3)
				return err
			},
			method: http.MethodGet, path: roomPath + "/invitations", query: "offset=3",
		},
		{
			name: "create invitation", status: http.StatusCreated, body: invitationBody,
			call: func(c *xberg.Client) error {
				inv, err := c.CreateRoomInvitation(ctx, testRoomID,
					xberg.RoomInviteRequest{Email: "a@example.com", Role: "VIEWER"})
				if err == nil && inv.Token != nil {
					t.Errorf("CreateRoomInvitation token = %v, want nil when the channel keeps it", *inv.Token)
				}
				return err
			},
			method: http.MethodPost, path: roomPath + "/invitations", sent: `{"email":"a@example.com","role":"VIEWER"}`,
		},
		{
			name: "revoke invitation", status: http.StatusNoContent,
			call:   func(c *xberg.Client) error { return c.RevokeRoomInvitation(ctx, testRoomID, "inv-1") },
			method: http.MethodDelete, path: roomPath + "/invitations/inv-1",
		},
		{
			name: "get publication", status: http.StatusOK, body: publicationBody,
			call: func(c *xberg.Client) error {
				pub, err := c.GetRoomPublication(ctx, testRoomID)
				if err == nil && pub.RoomVersion != 9 {
					t.Errorf("GetRoomPublication room_version = %d, want 9", pub.RoomVersion)
				}
				return err
			},
			method: http.MethodGet, path: roomPath + "/publication",
		},
		{
			name: "preview invitation", status: http.StatusOK,
			body: `{"room_name":"Board","item_count":3}`,
			call: func(c *xberg.Client) error {
				preview, err := c.PreviewRoomInvitation(ctx, xberg.RoomAcceptInvitationRequest{Token: "tok"})
				if err == nil && preview.ItemCount != 3 {
					t.Errorf("PreviewRoomInvitation item_count = %d, want 3", preview.ItemCount)
				}
				return err
			},
			method: http.MethodPost, path: "/v1/room-invitations/preview", sent: `{"token":"tok"}`,
		},
		{
			name: "accept invitation", status: http.StatusOK,
			body: `{"kind":"guest","role":"VIEWER","room_id":"` + testRoomID + `","project_id":"` + testRoomID + `"}`,
			call: func(c *xberg.Client) error {
				accepted, err := c.AcceptRoomInvitation(ctx, xberg.RoomAcceptInvitationRequest{Token: "tok"})
				if err == nil && accepted.RoomId.String() != testRoomID {
					t.Errorf("AcceptRoomInvitation room_id = %s", accepted.RoomId)
				}
				return err
			},
			method: http.MethodPost, path: "/v1/room-invitations/accept", sent: `{"token":"tok"}`,
		},
	}
}

func TestRooms_LifecycleRoutes(t *testing.T) {
	t.Parallel()
	runRoomCases(t, roomLifecycleCases(t))
}

func TestRooms_ItemRoutes(t *testing.T) {
	t.Parallel()
	runRoomCases(t, roomItemCases(t))
}

func TestRooms_MemberRoutes(t *testing.T) {
	t.Parallel()
	runRoomCases(t, roomMemberCases(t))
}

func TestRooms_InvitationAndPublicationRoutes(t *testing.T) {
	t.Parallel()
	runRoomCases(t, roomInvitationCases(t))
}

// versionedCalls are the three writes that send the room version as If-Match.
func versionedCalls() map[string]func(context.Context, *xberg.Client, int64) error {
	return map[string]func(context.Context, *xberg.Client, int64) error{
		"UpdateRoom": func(ctx context.Context, c *xberg.Client, v int64) error {
			name := "Renamed"
			_, err := c.UpdateRoom(ctx, testRoomID, v, xberg.UpdateRoomRequest{Name: &name})
			return err
		},
		"ReorderRoomItems": func(ctx context.Context, c *xberg.Client, v int64) error {
			ids := []uuid.UUID{uuid.MustParse(testRoomDocID)}
			_, err := c.ReorderRoomItems(ctx, testRoomID, v, xberg.ReorderItemsRequest{DocumentIds: ids})
			return err
		},
		"SetRoomPublication": func(ctx context.Context, c *xberg.Client, v int64) error {
			_, err := c.SetRoomPublication(ctx, testRoomID, v, xberg.SetPublicationRequest{State: "published"})
			return err
		},
	}
}

func TestRooms_VersionedWritesSendIfMatch(t *testing.T) {
	t.Parallel()
	want := map[string]struct{ method, path, body, response string }{
		"UpdateRoom": {http.MethodPatch, "/v1/rooms/" + testRoomID, `{"name":"Renamed"}`, roomBody},
		"ReorderRoomItems": {
			http.MethodPut, "/v1/rooms/" + testRoomID + "/items/order",
			`{"document_ids":["` + testRoomDocID + `"]}`, `{"document_ids":["` + testRoomDocID + `"],"version":42}`,
		},
		"SetRoomPublication": {
			http.MethodPut, "/v1/rooms/" + testRoomID + "/publication", `{"state":"published"}`, publicationBody,
		},
	}
	calls := versionedCalls()
	if len(calls) != len(want) {
		t.Fatalf("versioned calls = %d, want %d", len(calls), len(want))
	}
	for name, call := range calls {
		t.Run(name, func(t *testing.T) {
			t.Parallel()
			expected := want[name]
			var seen roomRequest
			client := roomServer(t, http.StatusOK, []byte(expected.response), &seen)
			if err := call(context.Background(), client, 41); err != nil {
				t.Fatalf("%s: %v", name, err)
			}
			wantRequest(t, seen, expected.method, expected.path)
			if seen.ifMatch != `"41"` {
				t.Errorf("If-Match = %q, want \"41\"", seen.ifMatch)
			}
			if seen.body != expected.body {
				t.Errorf("body = %q, want %q", seen.body, expected.body)
			}
		})
	}
}

func TestRooms_ReorderReturnsNextVersion(t *testing.T) {
	t.Parallel()
	var seen roomRequest
	client := roomServer(t, http.StatusOK, []byte(`{"document_ids":[],"version":42}`), &seen)
	out, err := client.ReorderRoomItems(context.Background(), testRoomID, 41, xberg.ReorderItemsRequest{})
	if err != nil {
		t.Fatalf("ReorderRoomItems: %v", err)
	}
	if out.Version != 42 {
		t.Errorf("Version = %d, want 42", out.Version)
	}
}

func TestRooms_PreconditionStatusesAreTyped(t *testing.T) {
	t.Parallel()
	for name, call := range versionedCalls() {
		t.Run(name+"/412", func(t *testing.T) {
			t.Parallel()
			var seen roomRequest
			body := []byte(`{"error":{"code":"precondition_failed","message":"The room changed since you read it"}}`)
			client := roomServer(t, http.StatusPreconditionFailed, body, &seen)
			err := call(context.Background(), client, 1)
			var failed *xberg.PreconditionFailedError
			if !errors.As(err, &failed) || failed.Code != "precondition_failed" {
				t.Fatalf("err = %v, want PreconditionFailedError with code precondition_failed", err)
			}
		})
		t.Run(name+"/428", func(t *testing.T) {
			t.Parallel()
			var seen roomRequest
			body := []byte(`{"error":{"code":"precondition_required","message":"Send the room version"}}`)
			client := roomServer(t, http.StatusPreconditionRequired, body, &seen)
			err := call(context.Background(), client, 1)
			var required *xberg.PreconditionRequiredError
			if !errors.As(err, &required) || required.Code != "precondition_required" {
				t.Fatalf("err = %v, want PreconditionRequiredError with code precondition_required", err)
			}
		})
	}
}

func TestRooms_PublicRoutesSendNoCredential(t *testing.T) {
	t.Parallel()
	ctx := context.Background()
	base := "/public/rooms/" + testRoomSlug
	cases := []struct {
		name string
		body string
		call func(*xberg.Client) error
		path string
		want string
	}{
		{
			name: "room", body: `{"name":"Board"}`,
			call: func(c *xberg.Client) error {
				room, err := c.GetPublicRoom(ctx, testRoomSlug)
				if err == nil && room.Name != "Board" {
					t.Errorf("GetPublicRoom name = %q", room.Name)
				}
				return err
			},
			path: base,
		},
		{
			name: "items", body: `{"items":[],"total":0,"limit":10,"offset":0}`,
			call: func(c *xberg.Client) error {
				_, err := c.ListPublicRoomItems(ctx, testRoomSlug, 10, 0)
				return err
			},
			path: base + "/items", want: "limit=10",
		},
		{
			name: "content", body: `{"item_ref":"itm_42","filename":"a.pdf","mime_type":"application/pdf"}`,
			call: func(c *xberg.Client) error {
				_, err := c.GetPublicRoomItemContent(ctx, testRoomSlug, testItemRef)
				return err
			},
			path: base + "/items/" + testItemRef + "/content",
		},
		{
			name: "download", body: "%PDF-1.7",
			call: func(c *xberg.Client) error {
				data, err := c.DownloadPublicRoomItem(ctx, testRoomSlug, testItemRef)
				if err == nil && string(data) != "%PDF-1.7" {
					t.Errorf("DownloadPublicRoomItem = %q", data)
				}
				return err
			},
			path: base + "/items/" + testItemRef + "/download",
		},
	}
	for _, tc := range cases {
		t.Run(tc.name, func(t *testing.T) {
			t.Parallel()
			var seen roomRequest
			client := roomServer(t, http.StatusOK, []byte(tc.body), &seen)
			if err := tc.call(client); err != nil {
				t.Fatalf("%s: %v", tc.name, err)
			}
			wantRequest(t, seen, http.MethodGet, tc.path)
			if seen.query != tc.want {
				t.Errorf("query = %q, want %q", seen.query, tc.want)
			}
			if seen.hasAuth {
				t.Errorf("Authorization = %q, want no header on an anonymous route", seen.authorization)
			}
		})
	}
}

func TestRooms_PublicSlugIsEscaped(t *testing.T) {
	t.Parallel()
	var seen roomRequest
	client := roomServer(t, http.StatusOK, []byte(`{"name":"x"}`), &seen)
	if _, err := client.GetPublicRoom(context.Background(), "../v1/rooms"); err != nil {
		t.Fatalf("GetPublicRoom: %v", err)
	}
	wantRequest(t, seen, http.MethodGet, "/public/rooms/..%2Fv1%2Frooms")
}

func TestRooms_BinaryDownloads(t *testing.T) {
	t.Parallel()
	payload := []byte{0x89, 'P', 'N', 'G', 0x00, 0xff, 0x10}
	t.Run("item", func(t *testing.T) {
		t.Parallel()
		var seen roomRequest
		client := roomServer(t, http.StatusOK, payload, &seen)
		data, err := client.DownloadRoomItem(context.Background(), testRoomID, testRoomDocID)
		if err != nil {
			t.Fatalf("DownloadRoomItem: %v", err)
		}
		wantRequest(t, seen, http.MethodGet, "/v1/rooms/"+testRoomID+"/items/"+testRoomDocID+"/download")
		if !bytes.Equal(data, payload) {
			t.Errorf("bytes = %v, want %v", data, payload)
		}
		if seen.accept != "*/*" || !seen.hasAuth {
			t.Errorf("Accept = %q, auth sent = %v; want */* with the credential", seen.accept, seen.hasAuth)
		}
	})
	t.Run("page", func(t *testing.T) {
		t.Parallel()
		var seen roomRequest
		client := roomServer(t, http.StatusOK, payload, &seen)
		data, err := client.GetRoomItemPage(context.Background(), testRoomID, testRoomDocID, 3)
		if err != nil {
			t.Fatalf("GetRoomItemPage: %v", err)
		}
		wantRequest(t, seen, http.MethodGet, "/v1/rooms/"+testRoomID+"/items/"+testRoomDocID+"/pages/3")
		if !bytes.Equal(data, payload) || seen.accept != "image/png" {
			t.Errorf("bytes = %v accept = %q, want the PNG bytes with Accept image/png", data, seen.accept)
		}
	})
	t.Run("forbidden download", func(t *testing.T) {
		t.Parallel()
		var seen roomRequest
		body := []byte(`{"error":{"code":"forbidden","message":"The room does not allow downloads"}}`)
		client := roomServer(t, http.StatusForbidden, body, &seen)
		_, err := client.DownloadRoomItem(context.Background(), testRoomID, testRoomDocID)
		var auth *xberg.AuthError
		if !errors.As(err, &auth) {
			t.Fatalf("err = %v, want AuthError", err)
		}
	})
}

func TestRooms_DisabledPlanIsTyped(t *testing.T) {
	t.Parallel()
	var seen roomRequest
	body := []byte(`{"error":{"code":"data_room.disabled","message":"Data rooms are not part of the plan"}}`)
	client := roomServer(t, http.StatusNotFound, body, &seen)
	_, err := client.ListRooms(context.Background(), "", 0, 0)
	var disabled *xberg.DataRoomsDisabledError
	if !errors.As(err, &disabled) || disabled.Code != xberg.ErrCodeDataRoomDisabled {
		t.Fatalf("err = %v, want DataRoomsDisabledError", err)
	}
	var notFound *xberg.NotFoundError
	if !errors.As(err, &notFound) {
		t.Errorf("errors.As(NotFoundError) = false, want the disabled error to stay a NotFoundError")
	}
	var base *xberg.XbergError
	if !errors.As(err, &base) || base.Status != http.StatusNotFound {
		t.Errorf("errors.As(XbergError) = %v, want status 404", base)
	}
	if seen.query != "" {
		t.Errorf("query = %q, want empty when state, limit and offset are unset", seen.query)
	}
}

func TestRooms_OrdinaryNotFoundIsNotDisabled(t *testing.T) {
	t.Parallel()
	var seen roomRequest
	body := []byte(`{"error":{"code":"not_found","message":"The room does not exist"}}`)
	client := roomServer(t, http.StatusNotFound, body, &seen)
	_, err := client.GetRoom(context.Background(), testRoomID)
	var disabled *xberg.DataRoomsDisabledError
	if errors.As(err, &disabled) {
		t.Fatalf("err = %v, want a plain NotFoundError for a missing room", err)
	}
	var notFound *xberg.NotFoundError
	if !errors.As(err, &notFound) {
		t.Fatalf("err = %v, want NotFoundError", err)
	}
}

func TestRooms_ProTargetIsRefusedBeforeRequest(t *testing.T) {
	t.Parallel()
	client := mustClient(t, xberg.WithBaseURL(newRefusingServer(t)), xberg.WithTarget(xberg.TargetPro))
	_, err := client.GetPublicRoom(context.Background(), testRoomSlug)
	var tier *xberg.TierError
	if !errors.As(err, &tier) || tier.Method != "GetPublicRoom" || tier.Required != "enterprise" {
		t.Fatalf("err = %v, want TierError for GetPublicRoom requiring enterprise", err)
	}
}

// retryCounting answers status on every attempt and counts them.
func retryCounting(t *testing.T, status int, attempts *atomic.Int32, opts ...xberg.Option) *xberg.Client {
	t.Helper()
	server := httptest.NewServer(http.HandlerFunc(func(w http.ResponseWriter, _ *http.Request) {
		attempts.Add(1)
		w.WriteHeader(status)
	}))
	t.Cleanup(server.Close)
	base := []xberg.Option{
		xberg.WithBaseURL(server.URL),
		xberg.WithTarget(xberg.TargetEnterprise),
		xberg.WithRetries(1),
	}
	return mustClient(t, append(base, opts...)...)
}

func TestRooms_NonIdempotentWritesAreNotRetried(t *testing.T) {
	t.Parallel()
	ctx := context.Background()
	t.Run("POST create not retried", func(t *testing.T) {
		t.Parallel()
		var attempts atomic.Int32
		client := retryCounting(t, http.StatusServiceUnavailable, &attempts)
		if _, err := client.CreateRoom(ctx, xberg.CreateRoomRequest{Name: "x"}); err == nil {
			t.Fatal("CreateRoom: want an error from 503")
		}
		if got := attempts.Load(); got != 1 {
			t.Errorf("attempts = %d, want 1", got)
		}
	})
	t.Run("PATCH update not retried", func(t *testing.T) {
		t.Parallel()
		var attempts atomic.Int32
		client := retryCounting(t, http.StatusServiceUnavailable, &attempts)
		if _, err := client.UpdateRoom(ctx, testRoomID, 1, xberg.UpdateRoomRequest{}); err == nil {
			t.Fatal("UpdateRoom: want an error from 503")
		}
		if got := attempts.Load(); got != 1 {
			t.Errorf("attempts = %d, want 1", got)
		}
	})
	t.Run("POST create retried on opt-in", func(t *testing.T) {
		t.Parallel()
		var attempts atomic.Int32
		client := retryCounting(t, http.StatusServiceUnavailable, &attempts, xberg.WithRetryNonIdempotent(true))
		if _, err := client.CreateRoom(ctx, xberg.CreateRoomRequest{Name: "x"}); err == nil {
			t.Fatal("CreateRoom: want an error from 503")
		}
		if got := attempts.Load(); got != 2 {
			t.Errorf("attempts = %d, want 2", got)
		}
	})
	t.Run("GET retried", func(t *testing.T) {
		t.Parallel()
		var attempts atomic.Int32
		client := retryCounting(t, http.StatusServiceUnavailable, &attempts)
		if _, err := client.GetRoom(ctx, testRoomID); err == nil {
			t.Fatal("GetRoom: want an error from 503")
		}
		if got := attempts.Load(); got != 2 {
			t.Errorf("attempts = %d, want 2", got)
		}
	})
}

// TestRooms_PublicRoutesIgnoreTheCookieJar proves an anonymous route sends
// none of the caller's cookies even when the supplied http.Client carries a
// jar, while an authenticated route on the same client still does.
func TestRooms_PublicRoutesIgnoreTheCookieJar(t *testing.T) {
	t.Parallel()
	var mu sync.Mutex
	cookies := map[string]string{}
	server := httptest.NewServer(http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
		mu.Lock()
		cookies[r.URL.Path] = r.Header.Get("Cookie")
		mu.Unlock()
		if r.URL.Path == "/v1/rooms/"+testRoomID {
			_, _ = w.Write([]byte(roomBody))
			return
		}
		_, _ = w.Write([]byte(`{"name":"Board"}`))
	}))
	t.Cleanup(server.Close)
	jar, err := cookiejar.New(nil)
	if err != nil {
		t.Fatalf("cookiejar.New: %v", err)
	}
	serverURL, err := url.Parse(server.URL)
	if err != nil {
		t.Fatalf("url.Parse: %v", err)
	}
	jar.SetCookies(serverURL, []*http.Cookie{{Name: "session", Value: "dashboard-session"}})
	transport := http.DefaultTransport.(*http.Transport).Clone()
	t.Cleanup(transport.CloseIdleConnections)
	client := mustClient(t,
		xberg.WithBaseURL(server.URL),
		xberg.WithTarget(xberg.TargetEnterprise),
		xberg.WithAPIKey(testRoomKey),
		xberg.WithHTTPClient(&http.Client{Transport: transport, Jar: jar}),
	)
	ctx := context.Background()
	if _, err := client.GetPublicRoom(ctx, testRoomSlug); err != nil {
		t.Fatalf("GetPublicRoom: %v", err)
	}
	if _, err := client.GetRoom(ctx, testRoomID); err != nil {
		t.Fatalf("GetRoom: %v", err)
	}
	mu.Lock()
	defer mu.Unlock()
	if got := cookies["/public/rooms/"+testRoomSlug]; got != "" {
		t.Errorf("public route Cookie = %q, want none", got)
	}
	if got := cookies["/v1/rooms/"+testRoomID]; got != "session=dashboard-session" {
		t.Errorf("authenticated route Cookie = %q, want the jar's cookie", got)
	}
}

func TestRooms_UpdateRoomCanClearTheDescription(t *testing.T) {
	t.Parallel()
	ctx := context.Background()
	t.Run("explicit null", func(t *testing.T) {
		t.Parallel()
		var seen roomRequest
		client := roomServer(t, http.StatusOK, []byte(roomBody), &seen)
		name := "Renamed"
		body := xberg.UpdateRoomRequest{Name: &name}
		if _, err := client.UpdateRoom(ctx, testRoomID, 41, body, xberg.ClearRoomDescription()); err != nil {
			t.Fatalf("UpdateRoom: %v", err)
		}
		if want := `{"description":null,"name":"Renamed"}`; seen.body != want {
			t.Errorf("body = %q, want %q", seen.body, want)
		}
	})
	t.Run("absent without the option", func(t *testing.T) {
		t.Parallel()
		var seen roomRequest
		client := roomServer(t, http.StatusOK, []byte(roomBody), &seen)
		if _, err := client.UpdateRoom(ctx, testRoomID, 41, xberg.UpdateRoomRequest{}); err != nil {
			t.Fatalf("UpdateRoom: %v", err)
		}
		if seen.body != `{}` {
			t.Errorf("body = %q, want {} so the stored description is kept", seen.body)
		}
	})
	t.Run("conflicts with a description", func(t *testing.T) {
		t.Parallel()
		client := mustClient(t,
			xberg.WithBaseURL(newRefusingServer(t)),
			xberg.WithTarget(xberg.TargetEnterprise),
		)
		description := "kept"
		body := xberg.UpdateRoomRequest{Description: &description}
		_, err := client.UpdateRoom(ctx, testRoomID, 41, body, xberg.ClearRoomDescription())
		if err == nil || !strings.Contains(err.Error(), "ClearRoomDescription") {
			t.Fatalf("err = %v, want the ClearRoomDescription conflict", err)
		}
	})
}
