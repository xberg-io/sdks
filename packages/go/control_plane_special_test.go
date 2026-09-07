package xberg

import (
	"context"
	"io"
	"net/http"
	"net/http/httptest"
	"strings"
	"testing"
)

func TestOAuthCallbackDoesNotFollowRedirectOrSendCredentials(t *testing.T) {
	landing := httptest.NewServer(http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) { t.Error("followed OAuth redirect") }))
	defer landing.Close()
	control := httptest.NewServer(http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
		if r.URL.Query().Get("code") != "code /&" || r.URL.Query().Get("state") != "state /&" {
			t.Errorf("query %v", r.URL.Query())
		}
		if r.Header.Get("Authorization") != "" {
			t.Error("sent credential to OAuth callback")
		}
		http.Redirect(w, r, landing.URL+"/done", http.StatusSeeOther)
	}))
	defer control.Close()
	c, err := New(WithBaseURL("http://127.0.0.1:1"), WithControlPlaneBaseURL(control.URL), WithAPIKey("data"), WithControlPlaneToken("control"), WithTarget(TargetEnterprise))
	if err != nil {
		t.Fatal(err)
	}
	got, err := c.OAuthCallback(context.Background(), "code /&", "state /&")
	if err != nil || got != landing.URL+"/done" {
		t.Fatalf("redirect %q %v", got, err)
	}
}

func TestBackendFetchIntegrationDocumentPreservesBinary(t *testing.T) {
	control := httptest.NewServer(http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
		if r.Method != http.MethodGet || r.URL.EscapedPath() != "/v1/projects/p%2Fa/integrations/i%2Fa/documents/d%2Fa" {
			t.Errorf("request %s %s", r.Method, r.URL.EscapedPath())
		}
		if r.Header.Get("Authorization") != "Bearer control" {
			t.Error("missing control credential")
		}
		_, _ = w.Write([]byte{0, 255, 1})
	}))
	defer control.Close()
	c, _ := New(WithBaseURL("http://127.0.0.1:1"), WithControlPlaneBaseURL(control.URL), WithControlPlaneToken("control"), WithTarget(TargetEnterprise))
	got, err := c.BackendFetchIntegrationDocument(context.Background(), "p/a", "i/a", "d/a")
	if err != nil || string(got) != string([]byte{0, 255, 1}) {
		t.Fatalf("binary %v %v", got, err)
	}
}

func TestSandboxExtractMultipartAndSeparatePublicToken(t *testing.T) {
	for _, public := range []bool{false, true} {
		t.Run(map[bool]string{false: "project", true: "public"}[public], func(t *testing.T) {
			control := httptest.NewServer(http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
				token, path := "Bearer control", "/v1/projects/p%2Fa/sandbox/extract"
				if public {
					token, path = "Bearer sandbox", "/v1/sandbox/public/extract"
				}
				if r.Method != http.MethodPost || r.URL.EscapedPath() != path || r.Header.Get("Authorization") != token {
					t.Errorf("request %s %s auth %q", r.Method, r.URL.EscapedPath(), r.Header.Get("Authorization"))
				}
				if err := r.ParseMultipartForm(4096); err != nil {
					t.Fatal(err)
				}
				defer r.MultipartForm.RemoveAll()
				file, header, err := r.FormFile("file")
				if err != nil {
					t.Fatal(err)
				}
				defer file.Close()
				data, _ := io.ReadAll(file)
				if header.Filename != "hello.txt" || string(data) != "hello" {
					t.Errorf("file %q %q", header.Filename, data)
				}
				if public && (r.FormValue("mode") != "idp" || r.FormValue("preset") != "invoice") {
					t.Error("missing public fields")
				}
				_, _ = io.WriteString(w, `{"id":"sandbox"}`)
			}))
			defer control.Close()
			c, _ := New(WithBaseURL("http://127.0.0.1:1"), WithControlPlaneBaseURL(control.URL), WithAPIKey("data"), WithControlPlaneToken("control"), WithTarget(TargetEnterprise))
			file := FileSource{Name: "hello.txt", Reader: strings.NewReader("hello")}
			var got *SandboxExtractResponse
			var err error
			if public {
				got, err = c.PublicSandboxExtract(context.Background(), &file, &PublicSandboxOptions{Mode: "idp", Preset: "invoice", Token: "sandbox"})
			} else {
				got, err = c.SandboxExtract(context.Background(), "p/a", file)
			}
			if err != nil || got.Id != "sandbox" {
				t.Fatalf("sandbox %v %v", got, err)
			}
		})
	}
}
