package kreuzbergcloud

import (
	"context"
	"net/http"
	"net/http/httptest"
	"testing"
)

func TestNew_DefaultsApply(t *testing.T) {
	t.Parallel()
	c, err := New()
	if err != nil {
		t.Fatalf("New() returned error: %v", err)
	}
	if got, want := c.BaseURL(), DefaultBaseURL; got != want {
		t.Errorf("BaseURL = %q, want %q", got, want)
	}
	if c.HTTPClient() == nil {
		t.Errorf("HTTPClient() = nil, want non-nil")
	}
}

func TestNew_WithBaseURL(t *testing.T) {
	t.Parallel()
	c, err := New(WithBaseURL("https://api.example.test"))
	if err != nil {
		t.Fatalf("New() returned error: %v", err)
	}
	if got, want := c.BaseURL(), "https://api.example.test"; got != want {
		t.Errorf("BaseURL = %q, want %q", got, want)
	}
}

func TestNew_RejectsEmptyBaseURL(t *testing.T) {
	t.Parallel()
	_, err := New(WithBaseURL(""))
	if err == nil {
		t.Errorf("New(WithBaseURL(\"\")) returned nil error, want non-nil")
	}
}

func TestAuthorize_SetsAuthorizationHeader(t *testing.T) {
	t.Parallel()
	c, err := New(WithAPIKey("secret"))
	if err != nil {
		t.Fatalf("New() returned error: %v", err)
	}
	req := httptest.NewRequest(http.MethodGet, "/healthz", nil)
	if err := c.authorize(context.Background(), req); err != nil {
		t.Fatalf("authorize() returned error: %v", err)
	}
	if got, want := req.Header.Get("Authorization"), "Bearer secret"; got != want {
		t.Errorf("Authorization header = %q, want %q", got, want)
	}
	if req.Header.Get("User-Agent") == "" {
		t.Errorf("User-Agent header was not set")
	}
}

func TestAuthorize_OmitsAuthorizationWhenNoKey(t *testing.T) {
	t.Parallel()
	c, err := New()
	if err != nil {
		t.Fatalf("New() returned error: %v", err)
	}
	req := httptest.NewRequest(http.MethodGet, "/healthz", nil)
	if err := c.authorize(context.Background(), req); err != nil {
		t.Fatalf("authorize() returned error: %v", err)
	}
	if got := req.Header.Get("Authorization"); got != "" {
		t.Errorf("Authorization header = %q, want empty", got)
	}
}

func TestWithHTTPClient_OverridesDefault(t *testing.T) {
	t.Parallel()
	custom := &http.Client{}
	c, err := New(WithHTTPClient(custom))
	if err != nil {
		t.Fatalf("New() returned error: %v", err)
	}
	if c.HTTPClient() != custom {
		t.Errorf("HTTPClient() did not return the custom *http.Client")
	}
}

func TestWithUserAgent_OverridesDefault(t *testing.T) {
	t.Parallel()
	c, err := New(WithUserAgent("custom-ua/1.0"))
	if err != nil {
		t.Fatalf("New() returned error: %v", err)
	}
	req := httptest.NewRequest(http.MethodGet, "/healthz", nil)
	if err := c.authorize(context.Background(), req); err != nil {
		t.Fatalf("authorize() returned error: %v", err)
	}
	if got, want := req.Header.Get("User-Agent"), "custom-ua/1.0"; got != want {
		t.Errorf("User-Agent header = %q, want %q", got, want)
	}
}
