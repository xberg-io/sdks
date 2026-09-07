package xberg

import (
	"context"
	"encoding/json"
	"io"
	"net/http"
	"net/http/httptest"
	"reflect"
	"testing"
)

type controlPlaneCase struct {
	name, method, path string
	query              map[string]string
	body               bool
	public             bool
	call               func(context.Context, *Client) error
}

func runControlPlaneCase(t *testing.T, test controlPlaneCase) {
	t.Helper()
	count := 0
	control := httptest.NewServer(http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
		count++
		if r.Method != test.method || r.URL.EscapedPath() != test.path {
			t.Errorf("request %s %s; want %s %s", r.Method, r.URL.EscapedPath(), test.method, test.path)
		}
		got := map[string]string{}
		for key := range r.URL.Query() {
			got[key] = r.URL.Query().Get(key)
		}
		if !reflect.DeepEqual(got, test.query) {
			t.Errorf("query %v; want %v", got, test.query)
		}
		token := "Bearer control"
		if test.public {
			token = ""
		}
		if r.Header.Get("Authorization") != token {
			t.Errorf("Authorization = %q", r.Header.Get("Authorization"))
		}
		body, err := io.ReadAll(r.Body)
		if err != nil {
			t.Error(err)
		}
		if test.body {
			if !json.Valid(body) || r.Header.Get("Content-Type") != contentTypeJSON {
				t.Errorf("invalid JSON body %q", body)
			}
		} else if len(body) != 0 {
			t.Errorf("unexpected body %q", body)
		}
		w.Header().Set("Content-Type", contentTypeJSON)
		_, _ = io.WriteString(w, "{}")
	}))
	defer control.Close()
	client, err := New(WithBaseURL("http://127.0.0.1:1"), WithControlPlaneBaseURL(control.URL), WithAPIKey("data"), WithControlPlaneToken("control"), WithTarget(TargetEnterprise))
	if err != nil {
		t.Fatal(err)
	}
	if err := test.call(context.Background(), client); err != nil {
		t.Fatal(err)
	}
	if count != 1 {
		t.Fatalf("got %d requests; want 1", count)
	}
}

func TestControlPlaneDeleteAccount(t *testing.T) {
	runControlPlaneCase(t, controlPlaneCase{
		name: "DeleteAccount", method: "DELETE", path: "/auth/account",
		query: map[string]string{},
		body:  false, public: false,
		call: func(ctx context.Context, c *Client) error { return c.DeleteAccount(ctx) },
	})
}

func TestControlPlaneGetAuthConfig(t *testing.T) {
	runControlPlaneCase(t, controlPlaneCase{
		name: "GetAuthConfig", method: "GET", path: "/auth/config",
		query: map[string]string{},
		body:  false, public: true,
		call: func(ctx context.Context, c *Client) error { _, err := c.GetAuthConfig(ctx); return err },
	})
}

func TestControlPlaneBackendLogin(t *testing.T) {
	runControlPlaneCase(t, controlPlaneCase{
		name: "BackendLogin", method: "POST", path: "/auth/login",
		query: map[string]string{},
		body:  true, public: true,
		call: func(ctx context.Context, c *Client) error { _, err := c.BackendLogin(ctx, LoginRequest{}); return err },
	})
}

func TestControlPlaneHealthz(t *testing.T) {
	runControlPlaneCase(t, controlPlaneCase{
		name: "Healthz", method: "GET", path: "/healthz",
		query: map[string]string{},
		body:  false, public: true,
		call: func(ctx context.Context, c *Client) error { _, err := c.Healthz(ctx); return err },
	})
}

func TestControlPlaneReadyz(t *testing.T) {
	runControlPlaneCase(t, controlPlaneCase{
		name: "Readyz", method: "GET", path: "/readyz",
		query: map[string]string{},
		body:  false, public: true,
		call: func(ctx context.Context, c *Client) error { _, err := c.Readyz(ctx); return err },
	})
}

func TestControlPlaneAcceptInvitation(t *testing.T) {
	runControlPlaneCase(t, controlPlaneCase{
		name: "AcceptInvitation", method: "POST", path: "/v1/invitations/accept",
		query: map[string]string{},
		body:  true, public: false,
		call: func(ctx context.Context, c *Client) error {
			_, err := c.AcceptInvitation(ctx, AcceptInvitationRequest{})
			return err
		},
	})
}

func TestControlPlaneBackendListProjects(t *testing.T) {
	runControlPlaneCase(t, controlPlaneCase{
		name: "BackendListProjects", method: "GET", path: "/v1/projects",
		query: map[string]string{"limit": "7", "offset": "7"},
		body:  false, public: false,
		call: func(ctx context.Context, c *Client) error {
			_, err := c.BackendListProjects(ctx, map[string]string{"limit": "7", "offset": "7"})
			return err
		},
	})
}

func TestControlPlaneBackendCreateProject(t *testing.T) {
	runControlPlaneCase(t, controlPlaneCase{
		name: "BackendCreateProject", method: "POST", path: "/v1/projects",
		query: map[string]string{},
		body:  true, public: false,
		call: func(ctx context.Context, c *Client) error {
			_, err := c.BackendCreateProject(ctx, CreateProjectRequest{})
			return err
		},
	})
}
