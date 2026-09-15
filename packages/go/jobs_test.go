package xberg_test

import (
	"context"
	"fmt"
	"io"
	"net/http"
	"net/http/httptest"
	"strings"
	"sync"
	"sync/atomic"
	"testing"
	"time"

	xberg "github.com/xberg-io/sdks/packages/go"
)

// jobUUID is a valid UUID used across job fixtures — the generated ExtractionJobResponse
// types its id as a UUID, so non-UUID fixture ids fail to decode.
const jobUUID = "550e8400-e29b-41d4-a716-446655440000"

func TestGetJob_ReturnsParsedJob(t *testing.T) {
	t.Parallel()
	server := httptest.NewServer(http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
		if r.URL.Path != "/v1/jobs/"+jobUUID {
			t.Errorf("path = %q, want /v1/jobs/%s", r.URL.Path, jobUUID)
		}
		fmt.Fprintf(w, `{
			"id":%q,
			"filename":"a.pdf",
			"status":"completed",
			"created_at":"2025-12-21T10:00:00Z",
			"result":{"content":"hello world"}
		}`, jobUUID)
	}))
	defer server.Close()
	client := mustClient(t, xberg.WithBaseURL(server.URL))
	job, err := client.GetJob(context.Background(), jobUUID)
	if err != nil {
		t.Fatalf("GetJob: %v", err)
	}
	if job.Id.String() != jobUUID {
		t.Errorf("Id = %q, want %s", job.Id.String(), jobUUID)
	}
	if job.Status != xberg.JobStatusCompleted {
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
	client := mustClient(t, xberg.WithBaseURL("https://example.test"))
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
	client := mustClient(t, xberg.WithBaseURL(server.URL))
	_, err := client.GetJob(context.Background(), "missing")
	var notFound *xberg.NotFoundError
	if !asError(err, &notFound) {
		t.Fatalf("expected NotFoundError, got %T: %v", err, err)
	}
	if notFound.Status != http.StatusNotFound {
		t.Errorf("Status = %d, want 404", notFound.Status)
	}
}

func TestCancelJob_IssuesDeleteToJobPath(t *testing.T) {
	t.Parallel()
	var gotMethod, gotPath string
	server := httptest.NewServer(http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
		gotMethod = r.Method
		gotPath = r.URL.Path
		w.WriteHeader(http.StatusNoContent)
	}))
	defer server.Close()
	client := mustClient(t, xberg.WithBaseURL(server.URL))
	if err := client.CancelJob(context.Background(), jobUUID); err != nil {
		t.Fatalf("CancelJob: %v", err)
	}
	if gotMethod != http.MethodDelete {
		t.Errorf("method = %q, want DELETE", gotMethod)
	}
	if gotPath != "/v1/jobs/"+jobUUID {
		t.Errorf("path = %q, want /v1/jobs/%s", gotPath, jobUUID)
	}
}

func TestCancelJob_RejectsEmptyID(t *testing.T) {
	t.Parallel()
	client := mustClient(t, xberg.WithBaseURL("https://example.test"))
	if err := client.CancelJob(context.Background(), ""); err == nil {
		t.Errorf("CancelJob(\"\") returned nil error")
	}
}

func TestCancelJob_NotFound(t *testing.T) {
	t.Parallel()
	server := httptest.NewServer(http.HandlerFunc(func(w http.ResponseWriter, _ *http.Request) {
		w.WriteHeader(http.StatusNotFound)
		_, _ = w.Write([]byte(`{"error":"Job not found"}`))
	}))
	defer server.Close()
	client := mustClient(t, xberg.WithBaseURL(server.URL))
	err := client.CancelJob(context.Background(), "missing")
	var notFound *xberg.NotFoundError
	if !asError(err, &notFound) {
		t.Fatalf("expected NotFoundError, got %T: %v", err, err)
	}
}

// jobStatusHandler serves GET /v1/jobs/{id} returning the given status, adding
// a result body on terminal-success statuses.
func jobStatusHandler(status string) http.HandlerFunc {
	return func(w http.ResponseWriter, _ *http.Request) {
		extra := ""
		if status == "completed" || status == "partial_success" {
			extra = `,"result":{"content":"done"}`
		}
		fmt.Fprintf(
			w,
			`{"id":%q,"filename":"a.pdf","status":%q,"created_at":"2025-12-21T10:00:00Z"%s}`,
			jobUUID, status, extra,
		)
	}
}

func TestWaitForJob_ImmediateCompletion(t *testing.T) {
	t.Parallel()
	server := httptest.NewServer(jobStatusHandler("completed"))
	defer server.Close()
	client := mustClient(t, xberg.WithBaseURL(server.URL))
	job, err := client.WaitForJob(context.Background(), jobUUID, nil)
	if err != nil {
		t.Fatalf("WaitForJob: %v", err)
	}
	if job.Result == nil || job.Result.Content != "done" {
		t.Errorf("Result.Content = %v, want done", job.Result)
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
			`{"id":%q,"filename":"a.pdf","status":%q,"created_at":"2025-12-21T10:00:00Z"%s}`,
			jobUUID, status, extra,
		)
	}))
	defer server.Close()
	client := mustClient(t, xberg.WithBaseURL(server.URL))
	job, err := client.WaitForJob(context.Background(), jobUUID, &xberg.WaitOptions{
		Timeout:      2 * time.Second,
		PollInterval: 5 * time.Millisecond,
		Backoff:      xberg.BackoffConstant,
	})
	if err != nil {
		t.Fatalf("WaitForJob: %v", err)
	}
	if job.Result == nil || job.Result.Content != "finished" {
		t.Errorf("Result.Content = %v, want finished", job.Result)
	}
	if got := calls.Load(); got < 3 {
		t.Errorf("server saw %d calls, want >=3", got)
	}
}

func TestWaitForJob_TimesOut(t *testing.T) {
	t.Parallel()
	server := httptest.NewServer(jobStatusHandler("processing"))
	defer server.Close()
	client := mustClient(t, xberg.WithBaseURL(server.URL))
	_, err := client.WaitForJob(context.Background(), jobUUID, &xberg.WaitOptions{
		Timeout:      40 * time.Millisecond,
		PollInterval: 5 * time.Millisecond,
		Backoff:      xberg.BackoffConstant,
	})
	var timeout *xberg.TimeoutError
	if !asError(err, &timeout) {
		t.Fatalf("expected TimeoutError, got %T: %v", err, err)
	}
	if timeout.JobID != jobUUID {
		t.Errorf("TimeoutError.JobID = %q, want %s", timeout.JobID, jobUUID)
	}
}

func TestWaitForJob_FailedStatusReturnsError(t *testing.T) {
	t.Parallel()
	server := httptest.NewServer(http.HandlerFunc(func(w http.ResponseWriter, _ *http.Request) {
		fmt.Fprintf(w, `{
			"id":%q,"filename":"a.pdf","status":"failed","created_at":"2025-12-21T10:00:00Z",
			"result":{"content":"OCR engine crashed"}
		}`, jobUUID)
	}))
	defer server.Close()
	client := mustClient(t, xberg.WithBaseURL(server.URL))
	_, err := client.WaitForJob(context.Background(), jobUUID, nil)
	if err == nil {
		t.Fatalf("expected error for failed job")
	}
	if !strings.Contains(err.Error(), "OCR engine crashed") {
		t.Errorf("error %q does not surface server message", err)
	}
}

func TestWaitForJob_ExponentialBackoffIncreases(t *testing.T) {
	t.Parallel()
	// ~keep The handler goroutine records poll timestamps concurrently with the
	// test goroutine's read, so guard the slice with a mutex to stay -race clean.
	var (
		mu         sync.Mutex
		timestamps []time.Time
	)
	server := httptest.NewServer(http.HandlerFunc(func(w http.ResponseWriter, _ *http.Request) {
		mu.Lock()
		timestamps = append(timestamps, time.Now())
		count := len(timestamps)
		mu.Unlock()
		status := "processing"
		extra := ""
		if count >= 4 {
			status = "completed"
			extra = `,"result":{"content":"done"}`
		}
		fmt.Fprintf(
			w,
			`{"id":%q,"filename":"a.pdf","status":%q,"created_at":"2025-12-21T10:00:00Z"%s}`,
			jobUUID, status, extra,
		)
	}))
	defer server.Close()
	client := mustClient(t, xberg.WithBaseURL(server.URL))
	// ~keep Base interval is 50ms so the exponential step (50ms -> 100ms) dwarfs
	// scheduling jitter under `go test -race`; a 10ms base flaked when jitter
	// exceeded the tiny gap difference.
	if _, err := client.WaitForJob(context.Background(), jobUUID, &xberg.WaitOptions{
		Timeout:      5 * time.Second,
		PollInterval: 50 * time.Millisecond,
		Backoff:      xberg.BackoffExponential,
	}); err != nil {
		t.Fatalf("WaitForJob: %v", err)
	}
	mu.Lock()
	defer mu.Unlock()
	if len(timestamps) < 4 {
		t.Fatalf("got %d polls, want >=4", len(timestamps))
	}
	gap1 := timestamps[1].Sub(timestamps[0])
	gap2 := timestamps[2].Sub(timestamps[1])
	if gap2 <= gap1 {
		t.Errorf("expected exponential growth, gap1=%v gap2=%v", gap1, gap2)
	}
}

func TestWaitForJobs_ParallelCompletion(t *testing.T) {
	t.Parallel()
	ids := []string{
		"11111111-1111-1111-1111-111111111111",
		"22222222-2222-2222-2222-222222222222",
		"33333333-3333-3333-3333-333333333333",
	}
	server := httptest.NewServer(http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
		id := strings.TrimPrefix(r.URL.Path, "/v1/jobs/")
		fmt.Fprintf(
			w,
			`{"id":%q,"filename":"a.pdf","status":"completed","created_at":"2025-12-21T10:00:00Z","result":{"content":%q}}`,
			id, "result-"+id,
		)
	}))
	defer server.Close()
	client := mustClient(t, xberg.WithBaseURL(server.URL))
	results, err := client.WaitForJobs(context.Background(), ids, nil)
	if err != nil {
		t.Fatalf("WaitForJobs: %v", err)
	}
	for i, result := range results {
		want := "result-" + ids[i]
		if result.Result == nil || result.Result.Content != want {
			t.Errorf("results[%d].Result = %v, want content %q", i, result.Result, want)
		}
	}
}

func TestExtractAndWait_HappyPath(t *testing.T) {
	t.Parallel()
	server := httptest.NewServer(http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
		switch {
		case r.Method == http.MethodPost && r.URL.Path == "/v1/extract":
			w.WriteHeader(http.StatusAccepted)
			fmt.Fprintf(w, `{"job_ids":[%q],"status":"pending"}`, jobUUID)
		case r.Method == http.MethodGet && r.URL.Path == "/v1/jobs/"+jobUUID:
			fmt.Fprintf(w, `{
				"id":%q,"filename":"a.pdf","status":"completed",
				"created_at":"2025-12-21T10:00:00Z","result":{"content":"the text"}
			}`, jobUUID)
		default:
			t.Errorf("unexpected request %s %s", r.Method, r.URL.Path)
		}
	}))
	defer server.Close()
	client := mustClient(t, xberg.WithBaseURL(server.URL))
	job, err := client.ExtractAndWait(
		context.Background(),
		xberg.FileSource{Name: "a.pdf", Reader: strings.NewReader("hello")},
		nil,
	)
	if err != nil {
		t.Fatalf("ExtractAndWait: %v", err)
	}
	if job.Result == nil || job.Result.Content != "the text" {
		t.Errorf("Result.Content = %v, want 'the text'", job.Result)
	}
}

func TestExtractAndWait_PropagatesExtractError(t *testing.T) {
	t.Parallel()
	server := httptest.NewServer(http.HandlerFunc(func(w http.ResponseWriter, _ *http.Request) {
		w.WriteHeader(http.StatusBadRequest)
		_, _ = w.Write([]byte(`{"error":"bad input"}`))
	}))
	defer server.Close()
	client := mustClient(t, xberg.WithBaseURL(server.URL))
	_, err := client.ExtractAndWait(
		context.Background(),
		xberg.FileSource{Name: "a.pdf", Reader: strings.NewReader("hello")},
		nil,
	)
	var validation *xberg.ValidationError
	if !asError(err, &validation) {
		t.Fatalf("expected ValidationError, got %T: %v", err, err)
	}
}

// -- GET /v1/jobs/{id}/result -------------------------------------------------

// jobResultBody is the canonical JobResult envelope both tiers serve on
// GET /v1/jobs/{id}/result. It is deliberately *not* the GET /v1/jobs/{id}
// metadata shape: `results`, `child_job_ids` and `errors` only exist here.
const jobResultBody = `{
	"job_id":"` + jobUUID + `",
	"status":"partial_success",
	"results":[
		{"content":"page one","structured_output":{"invoice_total":42}},
		{"content":"page two"}
	],
	"child_job_ids":["child-1","child-2"],
	"completed_at":"2025-12-21T10:05:00Z",
	"errors":[
		{"error_type":"unsupported_mime_type","message":"cannot parse","code":7,"index":2,"source":"ocr"}
	]
}`

func TestGetJobResult_ParsesJobResultEnvelope(t *testing.T) {
	t.Parallel()
	server := httptest.NewServer(http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
		if r.URL.Path != "/v1/jobs/"+jobUUID+"/result" {
			t.Errorf("path = %q, want /v1/jobs/%s/result", r.URL.Path, jobUUID)
		}
		if r.Method != http.MethodGet {
			t.Errorf("method = %q, want GET", r.Method)
		}
		_, _ = io.WriteString(w, jobResultBody)
	}))
	defer server.Close()
	client := mustClient(t, xberg.WithBaseURL(server.URL), xberg.WithTarget(xberg.TargetEnterprise))

	// The declared return type is the spec's JobResult, not the job-metadata
	// GetJobResponse: this assignment is the compile-time half of the assertion.
	var result *xberg.JobResult
	result, err := client.GetJobResult(context.Background(), jobUUID)
	if err != nil {
		t.Fatalf("GetJobResult: %v", err)
	}
	if result.JobId.String() != jobUUID {
		t.Errorf("JobId = %q, want %s", result.JobId.String(), jobUUID)
	}
	if result.Status != xberg.JobStatusPartialSuccess {
		t.Errorf("Status = %q, want partial_success", result.Status)
	}
	if result.Results == nil {
		t.Fatalf("Results = nil, want two extracted documents")
	}
	if got := len(*result.Results); got != 2 {
		t.Fatalf("len(Results) = %d, want 2", got)
	}
	// JobResultDocument is a generated struct now that the spec declares it;
	// it used to reach callers as an untyped map because the schema was absent.
	first := (*result.Results)[0]
	if first.Content != "page one" {
		t.Errorf("Results[0].Content = %v, want 'page one'", first.Content)
	}
	// The structured pipeline's output must still survive decoding.
	if first.StructuredOutput == nil {
		t.Errorf("Results[0] lost the structured_output field: %+v", first)
	}
	if result.ChildJobIds == nil || len(*result.ChildJobIds) != 2 {
		t.Fatalf("ChildJobIds = %v, want two entries", result.ChildJobIds)
	}
	if (*result.ChildJobIds)[0] != "child-1" {
		t.Errorf("ChildJobIds[0] = %q, want child-1", (*result.ChildJobIds)[0])
	}
	if result.CompletedAt == nil || *result.CompletedAt != "2025-12-21T10:05:00Z" {
		t.Errorf("CompletedAt = %v, want 2025-12-21T10:05:00Z", result.CompletedAt)
	}
	if result.Errors == nil || len(*result.Errors) != 1 {
		t.Fatalf("Errors = %v, want one entry", result.Errors)
	}
	jobErr := (*result.Errors)[0]
	if jobErr.ErrorType != "unsupported_mime_type" || jobErr.Message != "cannot parse" {
		t.Errorf("Errors[0] = %+v, want unsupported_mime_type/'cannot parse'", jobErr)
	}
	if jobErr.Code == nil || *jobErr.Code != 7 {
		t.Errorf("Errors[0].Code = %v, want 7", jobErr.Code)
	}
	if jobErr.Index == nil || *jobErr.Index != 2 {
		t.Errorf("Errors[0].Index = %v, want 2", jobErr.Index)
	}
	if jobErr.Source == nil || *jobErr.Source != "ocr" {
		t.Errorf("Errors[0].Source = %v, want ocr", jobErr.Source)
	}
}

func TestGetJobResult_IsNotTierGated(t *testing.T) {
	t.Parallel()
	// Declared in both specs, so neither target may short-circuit with a
	// TierError, and neither may probe /healthz to decide.
	for _, target := range []xberg.Target{xberg.TargetEnterprise, xberg.TargetPro} {
		t.Run(string(target), func(t *testing.T) {
			t.Parallel()
			var called atomic.Bool
			server := httptest.NewServer(http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
				if r.URL.Path == "/healthz" {
					t.Errorf("an ungated method must not probe /healthz")
				}
				called.Store(true)
				_, _ = io.WriteString(w, jobResultBody)
			}))
			defer server.Close()
			client := mustClient(t, xberg.WithBaseURL(server.URL), xberg.WithTarget(target))
			result, err := client.GetJobResult(context.Background(), jobUUID)
			if err != nil {
				t.Fatalf("GetJobResult on %s: %v", target, err)
			}
			if !called.Load() {
				t.Errorf("server was never called on target %s", target)
			}
			if result.JobId.String() != jobUUID {
				t.Errorf("JobId = %q, want %s", result.JobId.String(), jobUUID)
			}
		})
	}
}

func TestGetJobResult_RejectsEmptyID(t *testing.T) {
	t.Parallel()
	client := mustClient(t, xberg.WithBaseURL("https://example.test"))
	_, err := client.GetJobResult(context.Background(), "")
	if err == nil {
		t.Errorf("GetJobResult(\"\") returned nil error")
	}
}

func TestGetJobResult_SurfacesNotReadyConflict(t *testing.T) {
	t.Parallel()
	server := httptest.NewServer(http.HandlerFunc(func(w http.ResponseWriter, _ *http.Request) {
		w.WriteHeader(http.StatusConflict)
		_, _ = io.WriteString(w, `{"error":"job is not in a terminal successful state"}`)
	}))
	defer server.Close()
	client := mustClient(t, xberg.WithBaseURL(server.URL), xberg.WithTarget(xberg.TargetPro))
	_, err := client.GetJobResult(context.Background(), jobUUID)
	var apiErr *xberg.XbergError
	if !asError(err, &apiErr) {
		t.Fatalf("expected XbergError, got %T: %v", err, err)
	}
	if apiErr.Status != http.StatusConflict {
		t.Errorf("Status = %d, want 409", apiErr.Status)
	}
	if !strings.Contains(apiErr.Message, "terminal successful state") {
		t.Errorf("Message = %q, want the server-supplied reason", apiErr.Message)
	}
}

func TestGetJobPage_ReturnsRawPNGBytes(t *testing.T) {
	t.Parallel()
	page := []byte("\x89PNG\r\n\x1a\npage raster")
	server := httptest.NewServer(http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
		if r.URL.Path != "/v1/jobs/"+jobUUID+"/pages/3" {
			t.Errorf("path = %q, want /v1/jobs/%s/pages/3", r.URL.Path, jobUUID)
		}
		if r.Method != http.MethodGet {
			t.Errorf("method = %q, want GET", r.Method)
		}
		// The route serves image/png, so the SDK must not insist on JSON.
		if accept := r.Header.Get("Accept"); accept != "*/*" {
			t.Errorf("Accept = %q, want */*", accept)
		}
		w.Header().Set("Content-Type", "image/png")
		_, _ = w.Write(page)
	}))
	defer server.Close()
	client := mustClient(t, xberg.WithBaseURL(server.URL), xberg.WithTarget(xberg.TargetEnterprise))

	got, err := client.GetJobPage(context.Background(), jobUUID, 3)
	if err != nil {
		t.Fatalf("GetJobPage: %v", err)
	}
	if string(got) != string(page) {
		t.Errorf("bytes = %q, want the raw PNG payload", got)
	}
}

func TestGetJobPage_RejectsEmptyID(t *testing.T) {
	t.Parallel()
	client := mustClient(t, xberg.WithBaseURL("https://example.test"), xberg.WithTarget(xberg.TargetEnterprise))
	_, err := client.GetJobPage(context.Background(), "", 1)
	if err == nil || !strings.Contains(err.Error(), "non-empty jobID") {
		t.Fatalf("error = %v, want it to reject an empty jobID", err)
	}
}
