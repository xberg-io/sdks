package xberg_test

import (
	"context"
	"encoding/json"
	"io"
	"net/http"
	"net/http/httptest"
	"reflect"
	"testing"

	xberg "github.com/xberg-io/sdks/packages/go"
)

type releaseCase struct {
	method, path, body, response string
	tier                         xberg.Target
	status                       int
	invoke                       func(*xberg.Client) (any, error)
}

const (
	project      = "11111111-1111-4111-8111-111111111111"
	room         = "22222222-2222-4222-8222-222222222222"
	link         = "33333333-3333-4333-8333-333333333333"
	configPath   = "/v1/projects/" + project + "/extraction-config"
	projectPath  = "/v1/projects/" + project
	linksPath    = "/v1/rooms/" + room + "/links"
	projectJSON  = `{"id":"` + project + `","name":"Renamed"}`
	configJSON   = `{"extraction_config":null}`
	listJSON     = `{"links":[],"limit":2,"offset":1,"total":0}`
	linkJSON     = `{"id":"` + link + `","token":"link-token"}`
	acceptedJSON = `{"project_id":"` + project + `","room_id":"` + room + `","kind":"guest","role":"VIEWER"}`
)

func releaseCases(ctx context.Context) []releaseCase {
	name := "Renamed"
	return []releaseCase{

		{http.MethodGet, configPath, "", configJSON, xberg.TargetEnterprise, 200, func(c *xberg.Client) (any, error) {
			return c.GetProjectExtractionConfig(ctx, project)
		}},
		{http.MethodPut, configPath, "{}", configJSON, xberg.TargetEnterprise, 200, func(c *xberg.Client) (any, error) {
			return c.SetProjectExtractionConfig(ctx, project, xberg.ExtractionConfig{})
		}},
		{http.MethodDelete, configPath, "", "", xberg.TargetEnterprise, 204, func(c *xberg.Client) (any, error) {
			return nil, c.ClearProjectExtractionConfig(ctx, project)
		}},
		{http.MethodGet, linksPath + "?limit=2&offset=1", "", listJSON, xberg.TargetEnterprise, 200, func(c *xberg.Client) (any, error) {
			return c.ListRoomLinks(ctx, room, 2, 1)
		}},
		{http.MethodPost, linksPath, `{"role":"VIEWER"}`, linkJSON, xberg.TargetEnterprise, 201, func(c *xberg.Client) (any, error) {
			return c.CreateRoomLink(ctx, room, xberg.CreateRoomLinkRequest{Role: "VIEWER"})
		}},
		{http.MethodDelete, linksPath + "/" + link, "", "", xberg.TargetEnterprise, 204, func(c *xberg.Client) (any, error) {
			return nil, c.RevokeRoomLink(ctx, room, link)
		}},
		{http.MethodPost, "/v1/room-links/accept", `{"token":"link-token"}`, acceptedJSON, xberg.TargetEnterprise, 200, func(c *xberg.Client) (any, error) {
			return c.AcceptRoomLink(ctx, xberg.RoomAcceptInvitationRequest{Token: "link-token"})
		}},
		{http.MethodGet, projectPath, "", projectJSON, xberg.TargetPro, 200, func(c *xberg.Client) (any, error) {
			return c.ProGetProject(ctx, project)
		}},
		{http.MethodPatch, projectPath, `{"name":"Renamed"}`, projectJSON, xberg.TargetPro, 200, func(c *xberg.Client) (any, error) {
			return c.ProUpdateProject(ctx, project, xberg.UpdateProjectRequest{Name: &name})
		}},
		{http.MethodDelete, projectPath, "", "", xberg.TargetPro, 204, func(c *xberg.Client) (any, error) {
			return nil, c.ProDeleteProject(ctx, project)
		}},
	}
}

func TestReleaseOperations(t *testing.T) {
	cases := releaseCases(context.Background())
	for _, tc := range cases {
		t.Run(tc.method+" "+tc.path, func(t *testing.T) {
			requests := make(chan struct{}, 1)
			srv := httptest.NewServer(http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
				select {
				case requests <- struct{}{}:
				default:
					t.Error("received multiple requests")
				}
				if r.Method != tc.method || r.URL.RequestURI() != tc.path {
					t.Errorf("request = %s %s, want %s %s", r.Method, r.URL.RequestURI(), tc.method, tc.path)
				}
				payload, err := io.ReadAll(r.Body)
				if err != nil || string(payload) != tc.body {
					t.Errorf("request body = %q (%v), want %q", payload, err, tc.body)
				}
				wantProject := ""
				if tc.path == configPath {
					wantProject = project
				}
				if got := r.Header.Get("X-Project-ID"); got != wantProject {
					t.Errorf("X-Project-ID = %q, want %q", got, wantProject)
				}
				if got := r.Header.Get("Authorization"); got != "Bearer synthetic-session" {
					t.Errorf("Authorization = %q", got)
				}
				w.Header().Set("Content-Type", "application/json")
				w.WriteHeader(tc.status)
				_, _ = io.WriteString(w, tc.response)
			}))
			t.Cleanup(srv.Close)
			client := mustClient(t, xberg.WithBaseURL(srv.URL), xberg.WithTarget(tc.tier), xberg.WithAPIKey("synthetic-session"))
			got, err := tc.invoke(client)
			if err != nil {
				t.Fatal(err)
			}
			if len(requests) != 1 {
				t.Fatal("received no request")
			}
			if tc.response == "" {
				if got != nil {
					t.Fatalf("response = %v, want nil", got)
				}
				return
			}
			want := reflect.New(reflect.TypeOf(got).Elem()).Interface()
			if err := json.Unmarshal([]byte(tc.response), want); err != nil {
				t.Fatal(err)
			}
			if !reflect.DeepEqual(got, want) {
				t.Errorf("response = %+v, want %+v", got, want)
			}
		})
	}
}
