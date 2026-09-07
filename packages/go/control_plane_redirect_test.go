package xberg

import (
	"context"
	"io"
	"net/http"
	"net/http/cookiejar"
	"net/http/httptest"
	"net/url"
	"testing"
)

func TestControlPlaneProtectedRedirectDoesNotForwardToken(t *testing.T) {
	landing := httptest.NewServer(http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) { t.Error("followed protected redirect") }))
	defer landing.Close()
	control := httptest.NewServer(http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
		http.Redirect(w, r, landing.URL, http.StatusTemporaryRedirect)
	}))
	defer control.Close()
	c, _ := New(WithBaseURL(control.URL), WithControlPlaneToken("control"), WithTarget(TargetEnterprise))
	if _, err := c.GetProject(context.Background(), "p"); err == nil {
		t.Fatal("accepted redirect as project")
	}
}

func TestPublicControlPlaneOmitsCookieJar(t *testing.T) {
	control := httptest.NewServer(http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
		if r.Header.Get("Cookie") != "" || r.Header.Get("Authorization") != "" {
			t.Error("public request carried credentials")
		}
		_, _ = io.WriteString(w, `{}`)
	}))
	defer control.Close()
	jar, err := cookiejar.New(nil)
	if err != nil {
		t.Fatal(err)
	}
	endpoint, err := url.Parse(control.URL)
	if err != nil {
		t.Fatal(err)
	}
	jar.SetCookies(endpoint, []*http.Cookie{{Name: "session", Value: "session-value"}})
	c, _ := New(WithBaseURL(control.URL), WithAPIKey("data"), WithControlPlaneToken("control"), WithHTTPClient(&http.Client{Jar: jar}), WithTarget(TargetEnterprise))
	if _, err := c.GetAuthConfig(context.Background()); err != nil {
		t.Fatal(err)
	}
	if len(jar.Cookies(endpoint)) != 1 {
		t.Fatal("mutated caller's cookie jar")
	}
}

func TestPublicSandboxWebModeOmitsFileAndUsesNoImplicitCredentials(t *testing.T) {
	control := httptest.NewServer(http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
		if r.Header.Get("Authorization") != "" {
			t.Error("leaked default credential")
		}
		if err := r.ParseMultipartForm(4096); err != nil {
			t.Fatal(err)
		}
		defer r.MultipartForm.RemoveAll()
		if len(r.MultipartForm.File) != 0 || r.FormValue("mode") != "web" || r.FormValue("url") != "https://example.com" {
			t.Errorf("form %v", r.MultipartForm)
		}
		_, _ = io.WriteString(w, `{}`)
	}))
	defer control.Close()
	c, _ := New(WithBaseURL(control.URL), WithAPIKey("data"), WithControlPlaneToken("control"), WithTarget(TargetEnterprise))
	if _, err := c.PublicSandboxExtract(context.Background(), nil, &PublicSandboxOptions{Mode: "web", URL: "https://example.com"}); err != nil {
		t.Fatal(err)
	}
}
