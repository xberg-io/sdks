package kreuzbergcloud_test

import (
	"context"
	"net/http"
	"net/http/httptest"
	"sync/atomic"
	"testing"
	"time"

	kreuzbergcloud "github.com/xberg-io/kreuzberg-cloud-sdk/go/v1"
)

func TestRetry_RetriesOn503(t *testing.T) {
	t.Parallel()
	var calls atomic.Int32
	server := httptest.NewServer(http.HandlerFunc(func(w http.ResponseWriter, _ *http.Request) {
		count := calls.Add(1)
		if count < 3 {
			w.WriteHeader(http.StatusServiceUnavailable)
			_, _ = w.Write([]byte(`{"error":"unavailable"}`))
			return
		}
		_, _ = w.Write([]byte(`{
			"id":"j","filename":"a.pdf","status":"completed",
			"created_at":"2025-12-21T10:00:00Z","result":{"content":"ok"}
		}`))
	}))
	defer server.Close()
	client := mustClient(t,
		kreuzbergcloud.WithBaseURL(server.URL),
		kreuzbergcloud.WithRetries(5),
	)
	job, err := client.GetJob(context.Background(), "j")
	if err != nil {
		t.Fatalf("GetJob: %v", err)
	}
	if got := calls.Load(); got != 3 {
		t.Errorf("calls = %d, want 3", got)
	}
	if job.Status != "completed" {
		t.Errorf("Status = %q, want completed", job.Status)
	}
}

func TestRetry_RetriesOn429HonoursRetryAfter(t *testing.T) {
	t.Parallel()
	var calls atomic.Int32
	server := httptest.NewServer(http.HandlerFunc(func(w http.ResponseWriter, _ *http.Request) {
		count := calls.Add(1)
		if count < 2 {
			w.Header().Set("Retry-After", "1")
			w.WriteHeader(http.StatusTooManyRequests)
			_, _ = w.Write([]byte(`{"error":"slow"}`))
			return
		}
		_, _ = w.Write([]byte(`{
			"id":"j","filename":"a.pdf","status":"completed",
			"created_at":"2025-12-21T10:00:00Z","result":{"content":"ok"}
		}`))
	}))
	defer server.Close()
	start := time.Now()
	client := mustClient(t,
		kreuzbergcloud.WithBaseURL(server.URL),
		kreuzbergcloud.WithRetries(3),
	)
	if _, err := client.GetJob(context.Background(), "j"); err != nil {
		t.Fatalf("GetJob: %v", err)
	}
	elapsed := time.Since(start)
	// Retry-After 1s should make total elapsed at least ~900ms.
	if elapsed < 900*time.Millisecond {
		t.Errorf("elapsed = %v, want >= 900ms (Retry-After honored)", elapsed)
	}
}

func TestRetry_GivesUpAfterMaxAttempts(t *testing.T) {
	t.Parallel()
	var calls atomic.Int32
	server := httptest.NewServer(http.HandlerFunc(func(w http.ResponseWriter, _ *http.Request) {
		calls.Add(1)
		w.WriteHeader(http.StatusServiceUnavailable)
		_, _ = w.Write([]byte(`{"error":"down"}`))
	}))
	defer server.Close()
	client := mustClient(t,
		kreuzbergcloud.WithBaseURL(server.URL),
		kreuzbergcloud.WithRetries(2),
	)
	_, err := client.GetJob(context.Background(), "j")
	var srv *kreuzbergcloud.ServerError
	if !asError(err, &srv) {
		t.Fatalf("expected ServerError after retries, got %T: %v", err, err)
	}
	// Original attempt + 2 retries = 3 total.
	if got := calls.Load(); got != 3 {
		t.Errorf("calls = %d, want 3", got)
	}
}

func TestRetry_DoesNotRetryOn400(t *testing.T) {
	t.Parallel()
	var calls atomic.Int32
	server := httptest.NewServer(http.HandlerFunc(func(w http.ResponseWriter, _ *http.Request) {
		calls.Add(1)
		w.WriteHeader(http.StatusBadRequest)
		_, _ = w.Write([]byte(`{"error":"nope"}`))
	}))
	defer server.Close()
	client := mustClient(t,
		kreuzbergcloud.WithBaseURL(server.URL),
		kreuzbergcloud.WithRetries(5),
	)
	_, err := client.GetJob(context.Background(), "j")
	if err == nil {
		t.Fatal("expected error")
	}
	if got := calls.Load(); got != 1 {
		t.Errorf("calls = %d, want 1 (no retries on 400)", got)
	}
}
