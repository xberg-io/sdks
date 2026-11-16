package xberg

import (
	"context"
	"fmt"
	"io"
	"net/http"
	"net/http/httptest"
	"testing"

	"github.com/google/uuid"
)

type specSyncDataPlaneCase struct {
	name, method, path, query, projectHeader, ifMatch, body, response string
	target                                                            Target
	status                                                            int
	call                                                              func(*Client) error
}

func TestSpecSyncDataPlaneEndpoints(t *testing.T) {
	cursor := uuid.MustParse("a95ea25a-e318-4f29-b856-cb23f980a770")
	limit := int64(2)
	proCtx := WithProProject(context.Background(), "selected")
	tests := []specSyncDataPlaneCase{
		{
			name: "Enterprise RAG page", target: TargetEnterprise, method: http.MethodGet,
			path: "/v1/rag/collections/name%2Fspace/documents", query: "cursor=" + cursor.String() + "&limit=2",
			response: `{"documents":[],"limit":2,"next_cursor":"` + cursor.String() + `"}`,
			call: func(c *Client) error {
				page, err := c.ListRagDocuments(proCtx, "name/space", &ListRagDocumentsParams{Cursor: &cursor, Limit: &limit})
				if err == nil && (page.NextCursor == nil || *page.NextCursor != cursor || page.Limit != 2) {
					return fmt.Errorf("unexpected continuation: %+v", page)
				}
				return err
			},
		},
		{
			name: "Pro RAG page", target: TargetPro, method: http.MethodGet,
			path: "/v1/rag/collections/name%2Fspace/documents", projectHeader: "selected",
			response: `{"documents":[],"limit":50}`,
			call:     func(c *Client) error { _, err := c.ListRagDocuments(proCtx, "name/space", nil); return err },
		},
		{
			name: "Room links disabled", target: TargetEnterprise, method: http.MethodPut,
			path: "/v1/rooms/id%2Fspace/links", ifMatch: `"42"`, body: `{"enabled":false}`,
			response: `{"enabled":false,"room_version":43}`,
			call: func(c *Client) error {
				response, err := c.SetRoomLinkAccess(context.Background(), "id/space", 42, SetRoomLinkAccessRequest{Enabled: false})
				if err == nil && (response.Enabled || response.RoomVersion != 43) {
					return fmt.Errorf("unexpected link access: %+v", response)
				}
				return err
			},
		},
		{
			name: "Pro job page inventory", target: TargetPro, method: http.MethodGet,
			path: "/v1/jobs/id%2Fspace/pages", query: "project_id=selected", response: `{"pages":[1,3]}`,
			call: func(c *Client) error {
				inventory, err := c.GetJobPageInventory(proCtx, "id/space")
				if err == nil && (len(inventory.Pages) != 2 || inventory.Pages[0] != 1 || inventory.Pages[1] != 3) {
					return fmt.Errorf("unexpected inventory: %+v", inventory)
				}
				return err
			},
		},
		{
			name: "Pro integration binding", target: TargetPro, method: http.MethodPut,
			path: "/v1/projects/project%2Fspace/integrations/integration%2Fspace/sync/rag-target",
			body: `{"collection_id":"` + cursor.String() + `"}`, status: http.StatusNoContent,
			call: func(c *Client) error {
				return c.BindIntegrationRagTarget(proCtx, "project/space", "integration/space", BindIntegrationRagTargetRequest{CollectionId: cursor})
			},
		},
	}
	for _, tc := range tests {
		t.Run(tc.name, func(t *testing.T) { runSpecSyncDataPlaneCase(t, tc) })
	}
}

func runSpecSyncDataPlaneCase(t *testing.T, tc specSyncDataPlaneCase) {
	t.Helper()
	count := 0
	server := httptest.NewServer(http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
		count++
		if r.Method != tc.method || r.URL.EscapedPath() != tc.path || r.URL.RawQuery != tc.query {
			t.Errorf("request = %s %s; want %s %s?%s", r.Method, r.URL.RequestURI(), tc.method, tc.path, tc.query)
		}
		if r.Header.Get("X-Project-ID") != tc.projectHeader || r.Header.Get("If-Match") != tc.ifMatch {
			t.Errorf("project and If-Match = %q %q; want %q %q", r.Header.Get("X-Project-ID"), r.Header.Get("If-Match"), tc.projectHeader, tc.ifMatch)
		}
		body, err := io.ReadAll(r.Body)
		if err != nil || string(body) != tc.body {
			t.Errorf("body = %q, err = %v; want %q", body, err, tc.body)
		}
		if tc.status != 0 {
			w.WriteHeader(tc.status)
		}
		_, _ = io.WriteString(w, tc.response)
	}))
	defer server.Close()
	client, err := New(WithBaseURL(server.URL), WithTarget(tc.target))
	if err != nil {
		t.Fatal(err)
	}
	if err := tc.call(client); err != nil {
		t.Fatal(err)
	}
	if count != 1 {
		t.Fatalf("got %d requests; want 1", count)
	}
}
