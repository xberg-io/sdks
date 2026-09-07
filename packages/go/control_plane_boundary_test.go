package xberg

import (
	"context"
	"errors"
	"net/http"
	"net/http/cookiejar"
	"net/http/httptest"
	"net/url"
	"testing"
)

func TestBackendDoesNotRequireDataPlaneProbe(t *testing.T) {
	calls := 0
	server := httptest.NewServer(http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
		calls++
		if r.URL.Path != "/auth/account" {
			t.Errorf("unexpected path %s", r.URL.Path)
		}
		w.WriteHeader(http.StatusNoContent)
	}))
	defer server.Close()
	client, _ := New(WithBaseURL("http://127.0.0.1:1"), WithControlPlaneBaseURL(server.URL))
	if err := client.DeleteAccount(context.Background()); err != nil {
		t.Fatal(err)
	}
	if calls != 1 {
		t.Fatalf("calls = %d; want 1", calls)
	}
}

func TestBackendRejectsPreviouslyDetectedPro(t *testing.T) {
	server := httptest.NewServer(http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
		if r.URL.Path != "/healthz" {
			t.Errorf("unexpected backend request %s", r.URL.Path)
		}
		_, _ = w.Write([]byte(`{"tier":"pro"}`))
	}))
	defer server.Close()
	client, _ := New(WithBaseURL(server.URL))
	if _, err := client.resolveTier(context.Background()); err != nil {
		t.Fatal(err)
	}
	var tier *TierError
	if err := client.DeleteAccount(context.Background()); !errors.As(err, &tier) {
		t.Fatalf("error = %v; want TierError", err)
	}
}

func TestProtectedBackendDoesNotInheritCookieJar(t *testing.T) {
	server := httptest.NewServer(http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
		if got := r.Header.Get("Cookie"); got != "" {
			t.Errorf("leaked cookie %q", got)
		}
		if got := r.Header.Get("Authorization"); got != "Bearer control" {
			t.Errorf("authorization %q", got)
		}
		w.WriteHeader(http.StatusNoContent)
	}))
	defer server.Close()
	jar, _ := cookiejar.New(nil)
	endpoint, _ := url.Parse(server.URL)
	jar.SetCookies(endpoint, []*http.Cookie{{Name: "session", Value: "data"}})
	client, _ := New(WithBaseURL(server.URL), WithTarget(TargetEnterprise), WithControlPlaneToken("control"), WithHTTPClient(&http.Client{Jar: jar}))
	if err := client.DeleteAccount(context.Background()); err != nil {
		t.Fatal(err)
	}
	if len(jar.Cookies(endpoint)) != 1 {
		t.Fatal("mutated caller jar")
	}
}

func TestBackendMemberDotSegmentsStayEncoded(t *testing.T) {
	for _, item := range []struct{ value, encoded string }{{".", "%2E"}, {"..", "%2E%2E"}} {
		t.Run(item.value, func(t *testing.T) {
			server := httptest.NewServer(http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
				want := "/v1/projects/project/members/" + item.encoded
				if r.RequestURI != want {
					t.Errorf("request URI = %s; want %s", r.RequestURI, want)
				}
				w.WriteHeader(http.StatusNoContent)
			}))
			defer server.Close()
			client, _ := New(WithBaseURL(server.URL), WithTarget(TargetEnterprise))
			if err := client.RemoveMember(context.Background(), "project", item.value); err != nil {
				t.Fatal(err)
			}
		})
	}
}

func TestPublicSandboxRequiresFileUnlessWebURL(t *testing.T) {
	server := httptest.NewServer(http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
		t.Error("invalid sandbox request reached server")
		_, _ = w.Write([]byte(`{}`))
	}))
	defer server.Close()
	client, _ := New(WithBaseURL(server.URL), WithTarget(TargetEnterprise))
	for _, options := range []*PublicSandboxOptions{nil, {}, {Mode: "web"}, {Mode: "file", URL: "https://example.com"}} {
		if _, err := client.PublicSandboxExtract(context.Background(), nil, options); err == nil {
			t.Errorf("accepted missing file with options %v", options)
		}
	}
}
