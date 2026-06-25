package kreuzbergcloud_test

import (
	"context"
	"fmt"
	"net/http"
	"net/http/httptest"
	"strings"
	"sync/atomic"
	"testing"
	"time"

	kreuzbergcloud "github.com/xberg-io/sdks/go/v1"
)

func TestGetJob_ReturnsParsedJob(t *testing.T) {
	t.Parallel()
	server := httptest.NewServer(http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
		if r.URL.Path != "/v1/jobs/job-1" {
			t.Errorf("path = %q, want /v1/jobs/job-1", r.URL.Path)
		}
		_, _ = w.Write([]byte(`{
			"id":"job-1",
			"filename":"a.pdf",
			"status":"completed",
			"created_at":"2025-12-21T10:00:00Z",
			"result":{"content":"hello world"}
		}`))
	}))
	defer server.Close()
	client := mustClient(t, kreuzbergcloud.WithBaseURL(server.URL))
	job, err := client.GetJob(context.Background(), "job-1")
	if err != nil {
		t.Fatalf("GetJob: %v", err)
	}
	if job.ID != "job-1" {
		t.Errorf("ID = %q, want job-1", job.ID)
	}
	if job.Status != "completed" {
		t.Errorf("Status = %q, want completed", job.Status)
	}
	if job.Result == nil || job.Result.Content != "hello world" {
		t.Errorf("Result.Content = %v, want 'hello world'", job.Result)
	}
	if !job.CreatedAt.Equal(time.Date(2025, 12, 21, 10, 0, 0, 0, time.UTC)) {
		t.Errorf("CreatedAt = %v, want 2025-12-21T10:00:00Z", job.CreatedAt)
	}
}

func TestGetJob_RejectsEmptyID(t *testing.T) {
	t.Parallel()
	client := mustClient(t, kreuzbergcloud.WithBaseURL("https://example.test"))
	_, err := client.GetJob(context.Background(), "")
	if err == nil {
		t.Errorf("GetJob(\"\") returned nil error")
	}
}

func TestGetJob_NotFound(t *testing.T) {
	t.Parallel()
	server := httptest.NewServer(http.HandlerFunc(func(w http.ResponseWriter, _ *http.Request) {
		w.WriteHeader(http.StatusNotFound)
		_, _ = w.Write([]byte(`{"error":"Job not found"}`))
	}))
	defer server.Close()
	client := mustClient(t, kreuzbergcloud.WithBaseURL(server.URL))
	_, err := client.GetJob(context.Background(), "missing")
	var notFound *kreuzbergcloud.NotFoundError
	if !asError(err, &notFound) {
		t.Fatalf("expected NotFoundError, got %T: %v", err, err)
	}
	if notFound.Status != http.StatusNotFound {
		t.Errorf("Status = %d, want 404", notFound.Status)
	}
}

func TestWaitForJob_ImmediateCompletion(t *testing.T) {
	t.Parallel()
	server := httptest.NewServer(http.HandlerFunc(func(w http.ResponseWriter, _ *http.Request) {
		_, _ = w.Write([]byte(`{
			"id":"j",
			"filename":"a.pdf",
			"status":"completed",
			"created_at":"2025-12-21T10:00:00Z",
			"result":{"content":"done"}
		}`))
	}))
	defer server.Close()
	client := mustClient(t, kreuzbergcloud.WithBaseURL(server.URL))
	result, err := client.WaitForJob(context.Background(), "j", nil)
	if err != nil {
		t.Fatalf("WaitForJob: %v", err)
	}
	if result.Content != "done" {
		t.Errorf("Content = %q, want done", result.Content)
	}
}

func TestWaitForJob_PollsUntilTerminal(t *testing.T) {
	t.Parallel()
	var calls atomic.Int32
	server := httptest.NewServer(http.HandlerFunc(func(w http.ResponseWriter, _ *http.Request) {
		count := calls.Add(1)
		status := "processing"
		extra := ""
		if count >= 3 {
			status = "completed"
			extra = `,"result":{"content":"finished"}`
		}
		fmt.Fprintf(
			w,
			`{"id":"j","filename":"a.pdf","status":%q,"created_at":"2025-12-21T10:00:00Z"%s}`,
			status, extra,
		)
	}))
	defer server.Close()
	client := mustClient(t, kreuzbergcloud.WithBaseURL(server.URL))
	result, err := client.WaitForJob(context.Background(), "j", &kreuzbergcloud.WaitOptions{
		Timeout:      2 * time.Second,
		PollInterval: 5 * time.Millisecond,
		Backoff:      kreuzbergcloud.BackoffConstant,
	})
	if err != nil {
		t.Fatalf("WaitForJob: %v", err)
	}
	if result.Content != "finished" {
		t.Errorf("Content = %q, want finished", result.Content)
	}
	if got := calls.Load(); got < 3 {
		t.Errorf("server saw %d calls, want >=3", got)
	}
}

func TestWaitForJob_TimesOut(t *testing.T) {
	t.Parallel()
	server := httptest.NewServer(http.HandlerFunc(func(w http.ResponseWriter, _ *http.Request) {
		_, _ = w.Write([]byte(`{
			"id":"j","filename":"a.pdf","status":"processing","created_at":"2025-12-21T10:00:00Z"
		}`))
	}))
	defer server.Close()
	client := mustClient(t, kreuzbergcloud.WithBaseURL(server.URL))
	_, err := client.WaitForJob(context.Background(), "j", &kreuzbergcloud.WaitOptions{
		Timeout:      40 * time.Millisecond,
		PollInterval: 5 * time.Millisecond,
		Backoff:      kreuzbergcloud.BackoffConstant,
	})
	var timeout *kreuzbergcloud.TimeoutError
	if !asError(err, &timeout) {
		t.Fatalf("expected TimeoutError, got %T: %v", err, err)
	}
	if timeout.JobID != "j" {
		t.Errorf("TimeoutError.JobID = %q, want j", timeout.JobID)
	}
}

func TestWaitForJob_FailedStatusReturnsError(t *testing.T) {
	t.Parallel()
	server := httptest.NewServer(http.HandlerFunc(func(w http.ResponseWriter, _ *http.Request) {
		_, _ = w.Write([]byte(`{
			"id":"j","filename":"a.pdf","status":"failed","created_at":"2025-12-21T10:00:00Z",
			"result":{"content":"OCR engine crashed"}
		}`))
	}))
	defer server.Close()
	client := mustClient(t, kreuzbergcloud.WithBaseURL(server.URL))
	_, err := client.WaitForJob(context.Background(), "j", nil)
	if err == nil {
		t.Fatalf("expected error for failed job")
	}
	if !strings.Contains(err.Error(), "OCR engine crashed") {
		t.Errorf("error %q does not surface server message", err)
	}
}

func TestWaitForJob_ExponentialBackoffIncreases(t *testing.T) {
	t.Parallel()
	var timestamps []time.Time
	server := httptest.NewServer(http.HandlerFunc(func(w http.ResponseWriter, _ *http.Request) {
		timestamps = append(timestamps, time.Now())
		status := "processing"
		extra := ""
		if len(timestamps) >= 4 {
			status = "completed"
			extra = `,"result":{"content":"done"}`
		}
		fmt.Fprintf(
			w,
			`{"id":"j","filename":"a.pdf","status":%q,"created_at":"2025-12-21T10:00:00Z"%s}`,
			status, extra,
		)
	}))
	defer server.Close()
	client := mustClient(t, kreuzbergcloud.WithBaseURL(server.URL))
	if _, err := client.WaitForJob(context.Background(), "j", &kreuzbergcloud.WaitOptions{
		Timeout:      2 * time.Second,
		PollInterval: 10 * time.Millisecond,
		Backoff:      kreuzbergcloud.BackoffExponential,
	}); err != nil {
		t.Fatalf("WaitForJob: %v", err)
	}
	if len(timestamps) < 4 {
		t.Fatalf("got %d polls, want >=4", len(timestamps))
	}
	gap1 := timestamps[1].Sub(timestamps[0])
	gap2 := timestamps[2].Sub(timestamps[1])
	if gap2 < gap1 {
		t.Errorf("expected exponential growth, gap1=%v gap2=%v", gap1, gap2)
	}
}

func TestWaitForJobs_ParallelCompletion(t *testing.T) {
	t.Parallel()
	server := httptest.NewServer(http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
		id := strings.TrimPrefix(r.URL.Path, "/v1/jobs/")
		fmt.Fprintf(
			w,
			`{"id":%q,"filename":"a.pdf","status":"completed","created_at":"2025-12-21T10:00:00Z","result":{"content":%q}}`,
			id, "result-"+id,
		)
	}))
	defer server.Close()
	client := mustClient(t, kreuzbergcloud.WithBaseURL(server.URL))
	results, err := client.WaitForJobs(context.Background(), []string{"a", "b", "c"}, nil)
	if err != nil {
		t.Fatalf("WaitForJobs: %v", err)
	}
	want := []string{"result-a", "result-b", "result-c"}
	for i, result := range results {
		if result.Content != want[i] {
			t.Errorf("results[%d].Content = %q, want %q", i, result.Content, want[i])
		}
	}
}

func TestExtractAndWait_HappyPath(t *testing.T) {
	t.Parallel()
	server := httptest.NewServer(http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
		switch {
		case r.Method == http.MethodPost && r.URL.Path == "/v1/extract":
			w.WriteHeader(http.StatusAccepted)
			_, _ = w.Write([]byte(`{"job_ids":["jobxyz"],"status":"pending"}`))
		case r.Method == http.MethodGet && r.URL.Path == "/v1/jobs/jobxyz":
			_, _ = w.Write([]byte(`{
				"id":"jobxyz","filename":"a.pdf","status":"completed",
				"created_at":"2025-12-21T10:00:00Z","result":{"content":"the text"}
			}`))
		default:
			t.Errorf("unexpected request %s %s", r.Method, r.URL.Path)
		}
	}))
	defer server.Close()
	client := mustClient(t, kreuzbergcloud.WithBaseURL(server.URL))
	result, err := client.ExtractAndWait(
		context.Background(),
		kreuzbergcloud.FileSource{Name: "a.pdf", Reader: strings.NewReader("hello")},
		nil,
	)
	if err != nil {
		t.Fatalf("ExtractAndWait: %v", err)
	}
	if result.Content != "the text" {
		t.Errorf("Content = %q, want 'the text'", result.Content)
	}
}

func TestExtractAndWait_PropagatesExtractError(t *testing.T) {
	t.Parallel()
	server := httptest.NewServer(http.HandlerFunc(func(w http.ResponseWriter, _ *http.Request) {
		w.WriteHeader(http.StatusBadRequest)
		_, _ = w.Write([]byte(`{"error":"bad input"}`))
	}))
	defer server.Close()
	client := mustClient(t, kreuzbergcloud.WithBaseURL(server.URL))
	_, err := client.ExtractAndWait(
		context.Background(),
		kreuzbergcloud.FileSource{Name: "a.pdf", Reader: strings.NewReader("hello")},
		nil,
	)
	var validation *kreuzbergcloud.ValidationError
	if !asError(err, &validation) {
		t.Fatalf("expected ValidationError, got %T: %v", err, err)
	}
}
