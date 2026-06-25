package kreuzbergcloud_test

import (
	"context"
	"fmt"
	"net/http"
	"net/http/httptest"
	"strings"
	"testing"
	"time"

	kreuzbergcloud "github.com/xberg-io/sdks/go"
)

func TestCreateSandboxKey_ReturnsParsedKey(t *testing.T) {
	t.Parallel()
	server := httptest.NewServer(http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
		if r.URL.Path != "/v1/sandbox/key" {
			t.Errorf("path = %q, want /v1/sandbox/key", r.URL.Path)
		}
		if r.Method != http.MethodPost {
			t.Errorf("method = %q, want POST", r.Method)
		}
		if got := r.Header.Get("Authorization"); got != "" {
			t.Errorf("Authorization = %q, want empty (anonymous)", got)
		}
		_, _ = w.Write([]byte(`{
			"api_key":"sandbox-abc",
			"expires_at":"2025-12-21T11:00:00Z",
			"pages_remaining":50
		}`))
	}))
	defer server.Close()
	client := mustClient(t, kreuzbergcloud.WithBaseURL(server.URL))
	key, err := client.CreateSandboxKey(context.Background())
	if err != nil {
		t.Fatalf("CreateSandboxKey: %v", err)
	}
	if key.APIKey != "sandbox-abc" {
		t.Errorf("APIKey = %q, want sandbox-abc", key.APIKey)
	}
	if key.PagesRemaining != 50 {
		t.Errorf("PagesRemaining = %d, want 50", key.PagesRemaining)
	}
	want := time.Date(2025, 12, 21, 11, 0, 0, 0, time.UTC)
	if !key.ExpiresAt.Equal(want) {
		t.Errorf("ExpiresAt = %v, want %v", key.ExpiresAt, want)
	}
}

func TestFromSandbox_ReturnsClientWithKey(t *testing.T) {
	t.Parallel()
	var seen []string
	server := httptest.NewServer(http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
		seen = append(seen, r.URL.Path+"|"+r.Header.Get("Authorization"))
		switch r.URL.Path {
		case "/v1/sandbox/key":
			_, _ = w.Write([]byte(`{
				"api_key":"sb-xyz","expires_at":"2025-12-21T11:00:00Z","pages_remaining":10
			}`))
		case "/v1/jobs/some-id":
			_, _ = w.Write([]byte(`{
				"id":"some-id","filename":"a.pdf","status":"completed",
				"created_at":"2025-12-21T10:00:00Z","result":{"content":"ok"}
			}`))
		default:
			t.Errorf("unexpected request: %s", r.URL.Path)
		}
	}))
	defer server.Close()
	client, err := kreuzbergcloud.FromSandbox(context.Background(), kreuzbergcloud.WithBaseURL(server.URL))
	if err != nil {
		t.Fatalf("FromSandbox: %v", err)
	}
	if _, err := client.GetJob(context.Background(), "some-id"); err != nil {
		t.Fatalf("GetJob: %v", err)
	}
	if len(seen) != 2 {
		t.Fatalf("server saw %d calls, want 2", len(seen))
	}
	if !strings.HasPrefix(seen[0], "/v1/sandbox/key|") {
		t.Errorf("first call = %q, want /v1/sandbox/key with empty auth", seen[0])
	}
	if !strings.HasSuffix(seen[0], "|") {
		t.Errorf("first call %q should be anonymous", seen[0])
	}
	if seen[1] != "/v1/jobs/some-id|Bearer sb-xyz" {
		t.Errorf("second call = %q, want bearer sb-xyz", seen[1])
	}
}

func TestCreateSandboxKey_RateLimitedReturnsRateLimitError(t *testing.T) {
	t.Parallel()
	server := httptest.NewServer(http.HandlerFunc(func(w http.ResponseWriter, _ *http.Request) {
		w.Header().Set("Retry-After", "5")
		w.WriteHeader(http.StatusTooManyRequests)
		_, _ = fmt.Fprintf(w, `{"error":"too fast"}`)
	}))
	defer server.Close()
	client := mustClient(t, kreuzbergcloud.WithBaseURL(server.URL))
	_, err := client.CreateSandboxKey(context.Background())
	var rate *kreuzbergcloud.RateLimitError
	if !asError(err, &rate) {
		t.Fatalf("expected RateLimitError, got %T: %v", err, err)
	}
	if rate.RetryAfter != 5*time.Second {
		t.Errorf("RetryAfter = %v, want 5s", rate.RetryAfter)
	}
}

func TestCreateSandboxKey_RejectsEmptyAPIKey(t *testing.T) {
	t.Parallel()
	server := httptest.NewServer(http.HandlerFunc(func(w http.ResponseWriter, _ *http.Request) {
		_, _ = w.Write([]byte(`{"api_key":"","expires_at":"2025-12-21T11:00:00Z","pages_remaining":0}`))
	}))
	defer server.Close()
	client := mustClient(t, kreuzbergcloud.WithBaseURL(server.URL))
	_, err := client.CreateSandboxKey(context.Background())
	if err == nil {
		t.Errorf("expected error for empty api_key, got nil")
	}
}
