package xberg_test

import (
	"context"
	"errors"
	"fmt"
	"io"
	"mime"
	"mime/multipart"
	"net/http"
	"net/http/httptest"
	"strings"
	"sync/atomic"
	"testing"
	"time"

	xberg "github.com/xberg-io/sdks/packages/go"
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
			"id":"550e8400-e29b-41d4-a716-446655440000","filename":"a.pdf","status":"completed",
			"created_at":"2025-12-21T10:00:00Z","result":{"content":"ok"}
		}`))
	}))
	defer server.Close()
	client := mustClient(t,
		xberg.WithBaseURL(server.URL),
		xberg.WithRetries(5),
	)
	response, err := client.GetJob(context.Background(), "j")
	if err != nil {
		t.Fatalf("GetJob: %v", err)
	}
	job, err := response.AsGetJobResponse0()
	if err != nil {
		t.Fatalf("extraction job variant: %v", err)
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
			"id":"550e8400-e29b-41d4-a716-446655440000","filename":"a.pdf","status":"completed",
			"created_at":"2025-12-21T10:00:00Z","result":{"content":"ok"}
		}`))
	}))
	defer server.Close()
	start := time.Now()
	client := mustClient(t,
		xberg.WithBaseURL(server.URL),
		xberg.WithRetries(3),
	)
	if _, err := client.GetJob(context.Background(), "j"); err != nil {
		t.Fatalf("GetJob: %v", err)
	}
	elapsed := time.Since(start)
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
		xberg.WithBaseURL(server.URL),
		xberg.WithRetries(2),
	)
	_, err := client.GetJob(context.Background(), "j")
	var srv *xberg.ServerError
	if !asError(err, &srv) {
		t.Fatalf("expected ServerError after retries, got %T: %v", err, err)
	}
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
		xberg.WithBaseURL(server.URL),
		xberg.WithRetries(5),
	)
	_, err := client.GetJob(context.Background(), "j")
	if err == nil {
		t.Fatal("expected error")
	}
	if got := calls.Load(); got != 1 {
		t.Errorf("calls = %d, want 1 (no retries on 400)", got)
	}
}

// TestRetry_RewindsMultipartBodyOnRetry proves a retried Extract resends the
// full multipart body: the file part read by the server on the successful
// (second) attempt must carry the complete original content, not an
// already-exhausted or partially-read stream from the failed first attempt.
func TestRetry_RewindsMultipartBodyOnRetry(t *testing.T) {
	t.Parallel()
	var calls atomic.Int32
	var gotContent string
	server := httptest.NewServer(http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
		switch {
		case r.Method == http.MethodPost && r.URL.Path == "/v1/extract":
			if calls.Add(1) == 1 {
				w.WriteHeader(http.StatusServiceUnavailable)
				_, _ = w.Write([]byte(`{"error":"unavailable"}`))
				return
			}
			mediaType, params, err := mime.ParseMediaType(r.Header.Get("Content-Type"))
			if err != nil || !strings.HasPrefix(mediaType, "multipart/") {
				t.Errorf("content-type = %q, want multipart/...", r.Header.Get("Content-Type"))
			}
			reader := multipart.NewReader(r.Body, params["boundary"])
			for {
				part, partErr := reader.NextPart()
				if partErr == io.EOF {
					break
				}
				if partErr != nil {
					t.Fatalf("multipart read: %v", partErr)
				}
				if part.FormName() == "file" {
					body, readErr := io.ReadAll(part)
					if readErr != nil {
						t.Fatalf("reading file part: %v", readErr)
					}
					gotContent = string(body)
				}
			}
			w.WriteHeader(http.StatusAccepted)
			fmt.Fprintf(w, `{"job_ids":[%q],"status":"pending"}`, extractJobA)
		case r.Method == http.MethodGet:
			_, _ = w.Write([]byte(jobBody(extractJobA, "a.pdf", "pending")))
		default:
			t.Errorf("unexpected request %s %s", r.Method, r.URL.Path)
		}
	}))
	defer server.Close()
	client := mustClient(t, xberg.WithBaseURL(server.URL), xberg.WithRetries(2))
	if _, err := client.Extract(
		context.Background(),
		xberg.FileSource{Name: "a.pdf", Reader: strings.NewReader("hello world")},
		nil,
	); err != nil {
		t.Fatalf("Extract: %v", err)
	}
	if got := calls.Load(); got != 2 {
		t.Errorf("calls = %d, want 2 (one failure, one retry)", got)
	}
	if gotContent != "hello world" {
		t.Errorf("file content on retry = %q, want %q", gotContent, "hello world")
	}
}

// TestRetry_RetriesOnConnectionError pins the transport-failure half of the
// retry contract. Python retries httpx.TransportError and TypeScript retries a
// thrown fetch; before ConnectionError existed, Go classified a refused
// connection as terminal and WithRetries was inert for every failure that never
// reached a response.
func TestRetry_RetriesOnConnectionError(t *testing.T) {
	t.Parallel()
	var calls atomic.Int32
	// A server that hangs up mid-response on the first two attempts produces a
	// transport error with no status code, which is the case under test; a real
	// refused connection would never let the third attempt succeed.
	server := httptest.NewServer(http.HandlerFunc(func(w http.ResponseWriter, _ *http.Request) {
		if calls.Add(1) < 3 {
			hijacker, ok := w.(http.Hijacker)
			if !ok {
				t.Error("test server does not support hijacking")
				return
			}
			conn, _, err := hijacker.Hijack()
			if err != nil {
				t.Errorf("hijack: %v", err)
				return
			}
			_ = conn.Close()
			return
		}
		_, _ = w.Write([]byte(`{
			"id":"550e8400-e29b-41d4-a716-446655440000","filename":"a.pdf","status":"completed",
			"created_at":"2025-12-21T10:00:00Z","result":{"content":"ok"}
		}`))
	}))
	defer server.Close()
	client := mustClient(t, xberg.WithBaseURL(server.URL), xberg.WithRetries(5))

	response, err := client.GetJob(context.Background(), "j")
	if err != nil {
		t.Fatalf("GetJob: %v", err)
	}
	job, err := response.AsGetJobResponse0()
	if err != nil {
		t.Fatalf("extraction job variant: %v", err)
	}
	if got := calls.Load(); got != 3 {
		t.Errorf("calls = %d, want 3 (the connection failures were not retried)", got)
	}
	if job.Status != "completed" {
		t.Errorf("Status = %q, want completed", job.Status)
	}
}

// TestRetry_ConnectionErrorIsTypedAndExhausts checks the error a caller
// actually sees once the budget is spent: a *ConnectionError that the
// documented base catch still reaches.
func TestRetry_ConnectionErrorIsTypedAndExhausts(t *testing.T) {
	t.Parallel()
	server := httptest.NewServer(http.HandlerFunc(func(_ http.ResponseWriter, _ *http.Request) {}))
	url := server.URL
	server.Close() // nothing is listening, so every attempt is refused

	client := mustClient(t, xberg.WithBaseURL(url), xberg.WithRetries(1))
	_, err := client.GetJob(context.Background(), "j")
	if err == nil {
		t.Fatal("GetJob succeeded against a closed port")
	}
	var connErr *xberg.ConnectionError
	if !errors.As(err, &connErr) {
		t.Fatalf("error is %T, want *xberg.ConnectionError: %v", err, err)
	}
	if connErr.Status != 0 {
		t.Errorf("Status = %d, want 0 — no response backs a connection failure", connErr.Status)
	}
	var base *xberg.XbergError
	if !errors.As(err, &base) {
		t.Error("errors.As(err, &XbergError{}) missed a ConnectionError, breaking the documented base catch")
	}
	if !xberg.IsRetryable(err) {
		t.Error("IsRetryable(ConnectionError) = false, want true")
	}
}
