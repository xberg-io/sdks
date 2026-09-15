package xberg_test

import (
	"context"
	"encoding/json"
	"fmt"
	"io"
	"mime"
	"mime/multipart"
	"net/http"
	"net/http/httptest"
	"strings"
	"testing"

	xberg "github.com/xberg-io/sdks/packages/go"
)

// UUID fixtures for extract tests — the generated ExtractionJobResponse types its id as a
// UUID, and Extract fetches each returned job via GetJob.
const (
	extractJobA = "aaaaaaaa-1111-1111-1111-111111111111"
	extractJobB = "bbbbbbbb-2222-2222-2222-222222222222"
	extractJobC = "cccccccc-3333-3333-3333-333333333333"
)

// jobBody renders a minimal terminal GET /v1/jobs/{id} response body.
func jobBody(id, filename, status string) string {
	return fmt.Sprintf(
		`{"id":%q,"filename":%q,"status":%q,"created_at":"2025-12-21T10:00:00Z"}`,
		id, filename, status,
	)
}

func TestExtract_SubmitsSingleFileAndReturnsJob(t *testing.T) {
	t.Parallel()
	server := httptest.NewServer(http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
		switch {
		case r.Method == http.MethodPost && r.URL.Path == "/v1/extract":
			if got := r.Header.Get("Authorization"); got != "Bearer test-key" {
				t.Errorf("Authorization = %q, want %q", got, "Bearer test-key")
			}
			w.WriteHeader(http.StatusAccepted)
			fmt.Fprintf(w, `{"job_ids":[%q],"status":"pending"}`, extractJobA)
		case r.Method == http.MethodGet && r.URL.Path == "/v1/jobs/"+extractJobA:
			_, _ = w.Write([]byte(jobBody(extractJobA, "invoice.pdf", "pending")))
		default:
			t.Errorf("unexpected request %s %s", r.Method, r.URL.Path)
		}
	}))
	defer server.Close()

	client := mustClient(t, xberg.WithBaseURL(server.URL), xberg.WithAPIKey("test-key"))
	job, err := client.Extract(
		context.Background(),
		xberg.FileSource{Name: "invoice.pdf", Reader: strings.NewReader("hello")},
		nil,
	)
	if err != nil {
		t.Fatalf("Extract: %v", err)
	}
	if job.Id.String() != extractJobA {
		t.Errorf("Job.Id = %q, want %s", job.Id.String(), extractJobA)
	}
	if job.Filename != "invoice.pdf" {
		t.Errorf("Job.Filename = %q, want invoice.pdf", job.Filename)
	}
	if job.Status != xberg.JobStatusPending {
		t.Errorf("Job.Status = %q, want pending", job.Status)
	}
}

func TestExtract_MultipartBodyShape(t *testing.T) {
	t.Parallel()
	type capture struct {
		filenames    []string
		contentTypes []string
		options      string
		webhook      string
	}
	var got capture
	server := httptest.NewServer(http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
		if r.Method == http.MethodGet {
			id := strings.TrimPrefix(r.URL.Path, "/v1/jobs/")
			_, _ = w.Write([]byte(jobBody(id, "f.pdf", "pending")))
			return
		}
		mediaType, params, err := mime.ParseMediaType(r.Header.Get("Content-Type"))
		if err != nil || !strings.HasPrefix(mediaType, "multipart/") {
			t.Errorf("content-type = %q, want multipart/...", r.Header.Get("Content-Type"))
		}
		reader := multipart.NewReader(r.Body, params["boundary"])
		for {
			part, err := reader.NextPart()
			if err == io.EOF {
				break
			}
			if err != nil {
				t.Fatalf("multipart read: %v", err)
			}
			body, _ := io.ReadAll(part)
			switch part.FormName() {
			case "file":
				got.filenames = append(got.filenames, part.FileName())
				got.contentTypes = append(got.contentTypes, part.Header.Get("Content-Type"))
			case "options":
				got.options = string(body)
			case "webhook":
				got.webhook = string(body)
			}
		}
		w.WriteHeader(http.StatusAccepted)
		fmt.Fprintf(w, `{"job_ids":[%q,%q],"status":"pending"}`, extractJobA, extractJobB)
	}))
	defer server.Close()

	client := mustClient(t, xberg.WithBaseURL(server.URL))
	_, err := client.ExtractBatch(
		context.Background(),
		[]xberg.FileSource{
			{Name: "a.pdf", Reader: strings.NewReader("aaaa")},
			{Name: "b.png", Reader: strings.NewReader("bbbb")},
		},
		&xberg.ExtractOptions{
			Extraction: &xberg.ExtractionOptions{
				// A pointer now that the spec types the property as an object
				// instead of leaving it untyped.
				ExtractionConfig: &map[string]any{
					"output_format": "markdown",
					"disable_ocr":   false,
				},
			},
		},
	)
	if err != nil {
		t.Fatalf("ExtractBatch: %v", err)
	}
	want := []string{"a.pdf", "b.png"}
	for i, name := range want {
		if got.filenames[i] != name {
			t.Errorf("filenames[%d] = %q, want %q", i, got.filenames[i], name)
		}
	}
	if got.contentTypes[0] != "application/pdf" {
		t.Errorf("contentTypes[0] = %q, want application/pdf", got.contentTypes[0])
	}
	if got.contentTypes[1] != "image/png" {
		t.Errorf("contentTypes[1] = %q, want image/png", got.contentTypes[1])
	}
	if !strings.Contains(got.options, `"output_format":"markdown"`) {
		t.Errorf("options = %q, missing output_format=markdown", got.options)
	}
	if !strings.Contains(got.options, `"disable_ocr":false`) {
		t.Errorf("options = %q, missing disable_ocr=false", got.options)
	}
	if got.webhook != "" {
		t.Errorf("webhook = %q, want no webhook part sent when unset", got.webhook)
	}
}

func TestExtractBatch_SendsWebhookWhenSet(t *testing.T) {
	t.Parallel()
	var webhookBody string
	var sawWebhookPart bool
	server := httptest.NewServer(http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
		if r.Method == http.MethodGet {
			id := strings.TrimPrefix(r.URL.Path, "/v1/jobs/")
			_, _ = w.Write([]byte(jobBody(id, "a.pdf", "pending")))
			return
		}
		_, params, _ := mime.ParseMediaType(r.Header.Get("Content-Type"))
		reader := multipart.NewReader(r.Body, params["boundary"])
		for {
			part, err := reader.NextPart()
			if err == io.EOF {
				break
			}
			if err != nil {
				t.Fatalf("read multipart: %v", err)
			}
			if part.FormName() == "webhook" {
				sawWebhookPart = true
				body, _ := io.ReadAll(part)
				webhookBody = string(body)
			}
		}
		w.WriteHeader(http.StatusAccepted)
		fmt.Fprintf(w, `{"job_ids":[%q],"status":"pending"}`, extractJobA)
	}))
	defer server.Close()

	client := mustClient(t, xberg.WithBaseURL(server.URL))
	_, err := client.Extract(
		context.Background(),
		xberg.FileSource{Name: "a.pdf", Reader: strings.NewReader("a")},
		&xberg.ExtractOptions{
			Webhook: &xberg.WebhookConfig{Url: "https://example.test/webhook"},
		},
	)
	if err != nil {
		t.Fatalf("Extract: %v", err)
	}
	if !sawWebhookPart {
		t.Fatalf("server did not receive a webhook part when one was supplied")
	}
	if !strings.Contains(webhookBody, `"url":"https://example.test/webhook"`) {
		t.Errorf("webhook = %q, want it to carry the supplied URL", webhookBody)
	}
}

func TestExtractBatch_RejectsEmptySlice(t *testing.T) {
	t.Parallel()
	client := mustClient(t, xberg.WithBaseURL("https://example.test"))
	if _, err := client.ExtractBatch(context.Background(), nil, nil); err == nil {
		t.Errorf("ExtractBatch(nil) returned nil error")
	}
}

func TestExtractBatch_RejectsMissingFilename(t *testing.T) {
	t.Parallel()
	client := mustClient(t, xberg.WithBaseURL("https://example.test"))
	_, err := client.ExtractBatch(
		context.Background(),
		[]xberg.FileSource{{Name: "", Reader: strings.NewReader("x")}},
		nil,
	)
	if err == nil {
		t.Errorf("ExtractBatch with empty Name returned nil error")
	}
}

func TestExtractBatch_RejectsMissingReader(t *testing.T) {
	t.Parallel()
	client := mustClient(t, xberg.WithBaseURL("https://example.test"))
	_, err := client.ExtractBatch(
		context.Background(),
		[]xberg.FileSource{{Name: "x.pdf", Reader: nil}},
		nil,
	)
	if err == nil {
		t.Errorf("ExtractBatch with nil Reader returned nil error")
	}
}

func TestExtractBatch_ReturnsJobsInOrder(t *testing.T) {
	t.Parallel()
	ids := []string{extractJobA, extractJobB, extractJobC}
	files := []string{"1.pdf", "2.pdf", "3.pdf"}
	server := httptest.NewServer(http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
		if r.Method == http.MethodGet {
			id := strings.TrimPrefix(r.URL.Path, "/v1/jobs/")
			idx := 0
			for i, candidate := range ids {
				if candidate == id {
					idx = i
				}
			}
			_, _ = w.Write([]byte(jobBody(id, files[idx], "pending")))
			return
		}
		w.WriteHeader(http.StatusAccepted)
		fmt.Fprintf(w, `{"job_ids":[%q,%q,%q],"status":"pending"}`, ids[0], ids[1], ids[2])
	}))
	defer server.Close()
	client := mustClient(t, xberg.WithBaseURL(server.URL))
	jobs, err := client.ExtractBatch(
		context.Background(),
		[]xberg.FileSource{
			{Name: "1.pdf", Reader: strings.NewReader("1")},
			{Name: "2.pdf", Reader: strings.NewReader("2")},
			{Name: "3.pdf", Reader: strings.NewReader("3")},
		},
		nil,
	)
	if err != nil {
		t.Fatalf("ExtractBatch: %v", err)
	}
	for i, job := range jobs {
		if job.Id.String() != ids[i] {
			t.Errorf("jobs[%d].Id = %q, want %q", i, job.Id.String(), ids[i])
		}
		if job.Filename != files[i] {
			t.Errorf("jobs[%d].Filename = %q, want %q", i, job.Filename, files[i])
		}
	}
}

func TestExtractBatch_ServerReturnsMismatchedJobCount(t *testing.T) {
	t.Parallel()
	server := httptest.NewServer(http.HandlerFunc(func(w http.ResponseWriter, _ *http.Request) {
		w.WriteHeader(http.StatusAccepted)
		fmt.Fprintf(w, `{"job_ids":[%q],"status":"pending"}`, extractJobA)
	}))
	defer server.Close()
	client := mustClient(t, xberg.WithBaseURL(server.URL))
	_, err := client.ExtractBatch(
		context.Background(),
		[]xberg.FileSource{
			{Name: "a.pdf", Reader: strings.NewReader("aa")},
			{Name: "b.pdf", Reader: strings.NewReader("bb")},
		},
		nil,
	)
	if err == nil {
		t.Errorf("expected error on mismatched job count, got nil")
	}
}

func TestExtract_OptionsAreOptional(t *testing.T) {
	t.Parallel()
	var receivedOptions bool
	server := httptest.NewServer(http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
		if r.Method == http.MethodGet {
			id := strings.TrimPrefix(r.URL.Path, "/v1/jobs/")
			_, _ = w.Write([]byte(jobBody(id, "a.pdf", "pending")))
			return
		}
		_, params, _ := mime.ParseMediaType(r.Header.Get("Content-Type"))
		reader := multipart.NewReader(r.Body, params["boundary"])
		for {
			part, err := reader.NextPart()
			if err == io.EOF {
				break
			}
			if err != nil {
				t.Fatalf("read multipart: %v", err)
			}
			if part.FormName() == "options" {
				receivedOptions = true
			}
		}
		w.WriteHeader(http.StatusAccepted)
		fmt.Fprintf(w, `{"job_ids":[%q],"status":"pending"}`, extractJobA)
	}))
	defer server.Close()
	client := mustClient(t, xberg.WithBaseURL(server.URL))
	if _, err := client.Extract(
		context.Background(),
		xberg.FileSource{Name: "a.pdf", Reader: strings.NewReader("a")},
		nil,
	); err != nil {
		t.Fatalf("Extract: %v", err)
	}
	if receivedOptions {
		t.Errorf("server received options part when none was passed")
	}
}

func TestExtract_PropagatesValidationError(t *testing.T) {
	t.Parallel()
	server := httptest.NewServer(http.HandlerFunc(func(w http.ResponseWriter, _ *http.Request) {
		w.WriteHeader(http.StatusBadRequest)
		_ = json.NewEncoder(w).Encode(map[string]string{"error": "no document"})
	}))
	defer server.Close()
	client := mustClient(t, xberg.WithBaseURL(server.URL))
	_, err := client.Extract(
		context.Background(),
		xberg.FileSource{Name: "x.pdf", Reader: strings.NewReader("x")},
		nil,
	)
	if err == nil {
		t.Fatalf("expected error, got nil")
	}
	var validation *xberg.ValidationError
	if !asError(err, &validation) {
		t.Fatalf("expected ValidationError, got %T: %v", err, err)
	}
	if !strings.Contains(validation.Message, "no document") {
		t.Errorf("error message = %q, want it to contain 'no document'", validation.Message)
	}
}

// ptrTo returns a pointer to v, so the all-optional [xberg.FileExtractionConfig]
// fields can be set inline in a literal.
func ptrTo[T any](v T) *T { return &v }

// perFileConfigServer stands in for POST /v1/extract, recording the raw request
// body (with the random multipart boundary replaced by a fixed token) and
// answering with jobIDs. GET /v1/jobs/{id} is served too, because ExtractBatch
// fetches every returned job before it returns.
func perFileConfigServer(t *testing.T, raw *string, jobIDs ...string) *httptest.Server {
	t.Helper()
	quoted := make([]string, len(jobIDs))
	for i, id := range jobIDs {
		quoted[i] = fmt.Sprintf("%q", id)
	}
	return httptest.NewServer(http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
		if r.Method == http.MethodGet {
			id := strings.TrimPrefix(r.URL.Path, "/v1/jobs/")
			_, _ = w.Write([]byte(jobBody(id, "f.pdf", "pending")))
			return
		}
		_, params, err := mime.ParseMediaType(r.Header.Get("Content-Type"))
		if err != nil {
			t.Errorf("parse content-type: %v", err)
		}
		body, err := io.ReadAll(r.Body)
		if err != nil {
			t.Errorf("read body: %v", err)
		}
		*raw = strings.ReplaceAll(string(body), params["boundary"], "BOUNDARY")
		w.WriteHeader(http.StatusAccepted)
		fmt.Fprintf(w, `{"job_ids":[%s],"status":"pending"}`, strings.Join(quoted, ","))
	}))
}

func TestExtract_SendsPerFileConfigAsConfigFilenamePart(t *testing.T) {
	t.Parallel()
	var raw string
	server := perFileConfigServer(t, &raw, extractJobA)
	defer server.Close()

	client := mustClient(t, xberg.WithBaseURL(server.URL))
	_, err := client.Extract(
		context.Background(),
		xberg.FileSource{Name: "invoice.pdf", Reader: strings.NewReader("body-0")},
		&xberg.ExtractOptions{
			Extraction: &xberg.ExtractionOptions{
				ExtractionConfig: &map[string]any{"disable_ocr": true},
			},
			Configs: []*xberg.FileExtractionConfig{{ForceOcr: ptrTo(true)}},
		},
	)
	if err != nil {
		t.Fatalf("Extract: %v", err)
	}
	want := "Content-Disposition: form-data; name=\"config-invoice.pdf\"\r\n\r\n{\"force_ocr\":true}"
	if !strings.Contains(raw, want) {
		t.Errorf("body did not carry the per-file config part:\n%s", raw)
	}
	// The batch-level part is sent untouched alongside it: resolving the
	// precedence between the two is the server's job, not the client's.
	if !strings.Contains(raw, `{"extraction_config":{"disable_ocr":true}}`) {
		t.Errorf("body did not carry the batch-level options part:\n%s", raw)
	}
}

func TestExtractBatch_SendsOneConfigPartPerFileKeyedOnItsFilename(t *testing.T) {
	t.Parallel()
	var raw string
	server := perFileConfigServer(t, &raw, extractJobA, extractJobB)
	defer server.Close()

	client := mustClient(t, xberg.WithBaseURL(server.URL))
	_, err := client.ExtractBatch(
		context.Background(),
		[]xberg.FileSource{
			{Name: "scanned.pdf", Reader: strings.NewReader("body-0")},
			{Name: "digital.pdf", Reader: strings.NewReader("body-1")},
		},
		&xberg.ExtractOptions{
			Configs: []*xberg.FileExtractionConfig{
				{ForceOcr: ptrTo(true)},
				{DisableOcr: ptrTo(true)},
			},
		},
	)
	if err != nil {
		t.Fatalf("ExtractBatch: %v", err)
	}
	for _, want := range []string{
		"name=\"config-scanned.pdf\"\r\n\r\n{\"force_ocr\":true}",
		"name=\"config-digital.pdf\"\r\n\r\n{\"disable_ocr\":true}",
	} {
		if !strings.Contains(raw, want) {
			t.Errorf("body missing %q:\n%s", want, raw)
		}
	}
}

func TestExtractBatch_OmitsTheConfigPartForAFileWithoutAnOverride(t *testing.T) {
	t.Parallel()
	var raw string
	server := perFileConfigServer(t, &raw, extractJobA, extractJobB)
	defer server.Close()

	client := mustClient(t, xberg.WithBaseURL(server.URL))
	_, err := client.ExtractBatch(
		context.Background(),
		[]xberg.FileSource{
			{Name: "scanned.pdf", Reader: strings.NewReader("body-0")},
			{Name: "digital.pdf", Reader: strings.NewReader("body-1")},
		},
		&xberg.ExtractOptions{
			Configs: []*xberg.FileExtractionConfig{{ForceOcr: ptrTo(true)}, nil},
		},
	)
	if err != nil {
		t.Fatalf("ExtractBatch: %v", err)
	}
	if !strings.Contains(raw, `name="config-scanned.pdf"`) {
		t.Errorf("body missing config-scanned.pdf:\n%s", raw)
	}
	if strings.Contains(raw, `name="config-digital.pdf"`) {
		t.Errorf("body carried a config part for a file with no override:\n%s", raw)
	}
}

// TestExtractBatch_WithoutConfigsSendsTheBodyItAlwaysSent pins the exact bytes of
// a request with no per-file overrides, so adding them provably moved nothing for
// existing callers. The whole body is asserted rather than just the absence of a
// "config-" part: a reordered, duplicated or re-encoded part would be as much of
// a regression as a spurious one.
func TestExtractBatch_WithoutConfigsSendsTheBodyItAlwaysSent(t *testing.T) {
	t.Parallel()
	var raw string
	server := perFileConfigServer(t, &raw, extractJobA, extractJobB)
	defer server.Close()

	client := mustClient(t, xberg.WithBaseURL(server.URL))
	_, err := client.ExtractBatch(
		context.Background(),
		[]xberg.FileSource{
			{Name: "scanned.pdf", Reader: strings.NewReader("body-0")},
			{Name: "digital.pdf", Reader: strings.NewReader("body-1")},
		},
		&xberg.ExtractOptions{
			Extraction: &xberg.ExtractionOptions{
				ExtractionConfig: &map[string]any{"disable_ocr": true},
			},
		},
	)
	if err != nil {
		t.Fatalf("ExtractBatch: %v", err)
	}
	want := "--BOUNDARY\r\n" +
		"Content-Disposition: form-data; name=\"file\"; filename=\"scanned.pdf\"\r\n" +
		"Content-Type: application/pdf\r\n\r\n" +
		"body-0\r\n" +
		"--BOUNDARY\r\n" +
		"Content-Disposition: form-data; name=\"file\"; filename=\"digital.pdf\"\r\n" +
		"Content-Type: application/pdf\r\n\r\n" +
		"body-1\r\n" +
		"--BOUNDARY\r\n" +
		"Content-Disposition: form-data; name=\"options\"\r\n\r\n" +
		"{\"extraction_config\":{\"disable_ocr\":true}}\r\n" +
		"--BOUNDARY--\r\n"
	if raw != want {
		t.Errorf("body changed for a request with no per-file configs\ngot:\n%s\nwant:\n%s", raw, want)
	}
}

// TestExtractBatch_RejectsTheSameFilenameCarryingDifferentConfigs covers the one
// case this transport cannot express: the multipart form has a single
// "config-<filename>" slot per name, so two different overrides under one name
// have no representation. Erroring is the point — writing whichever came last
// would drop the other with nothing the caller could observe.
func TestExtractBatch_RejectsTheSameFilenameCarryingDifferentConfigs(t *testing.T) {
	t.Parallel()
	var reached bool
	server := httptest.NewServer(http.HandlerFunc(func(w http.ResponseWriter, _ *http.Request) {
		reached = true
		w.WriteHeader(http.StatusAccepted)
	}))
	defer server.Close()

	client := mustClient(t, xberg.WithBaseURL(server.URL))
	_, err := client.ExtractBatch(
		context.Background(),
		[]xberg.FileSource{
			{Name: "invoice.pdf", Reader: strings.NewReader("one")},
			{Name: "invoice.pdf", Reader: strings.NewReader("two")},
		},
		&xberg.ExtractOptions{
			Configs: []*xberg.FileExtractionConfig{
				{ForceOcr: ptrTo(true)},
				{DisableOcr: ptrTo(true)},
			},
		},
	)
	if err == nil {
		t.Fatal("ExtractBatch accepted two different configs under one filename")
	}
	if !strings.Contains(err.Error(), `per-file config conflict for "invoice.pdf"`) {
		t.Errorf("error = %v, want it to name the conflicting filename", err)
	}
	if reached {
		t.Error("request was sent despite the conflict")
	}
}

func TestExtractBatch_AllowsTheSameFilenameWhenTheConfigsMatch(t *testing.T) {
	t.Parallel()
	var raw string
	server := perFileConfigServer(t, &raw, extractJobA, extractJobB)
	defer server.Close()

	client := mustClient(t, xberg.WithBaseURL(server.URL))
	_, err := client.ExtractBatch(
		context.Background(),
		[]xberg.FileSource{
			{Name: "invoice.pdf", Reader: strings.NewReader("one")},
			{Name: "invoice.pdf", Reader: strings.NewReader("two")},
		},
		&xberg.ExtractOptions{
			Configs: []*xberg.FileExtractionConfig{
				{ForceOcr: ptrTo(true)},
				{ForceOcr: ptrTo(true)},
			},
		},
	)
	if err != nil {
		t.Fatalf("ExtractBatch: %v", err)
	}
	if got := strings.Count(raw, `name="config-invoice.pdf"`); got != 1 {
		t.Errorf("config-invoice.pdf part count = %d, want 1:\n%s", got, raw)
	}
}

func TestExtractBatch_RejectsAConfigsSliceThatDoesNotMatchTheFiles(t *testing.T) {
	t.Parallel()
	var reached bool
	server := httptest.NewServer(http.HandlerFunc(func(w http.ResponseWriter, _ *http.Request) {
		reached = true
		w.WriteHeader(http.StatusAccepted)
	}))
	defer server.Close()

	client := mustClient(t, xberg.WithBaseURL(server.URL))
	_, err := client.ExtractBatch(
		context.Background(),
		[]xberg.FileSource{
			{Name: "scanned.pdf", Reader: strings.NewReader("body-0")},
			{Name: "digital.pdf", Reader: strings.NewReader("body-1")},
		},
		&xberg.ExtractOptions{
			Configs: []*xberg.FileExtractionConfig{{ForceOcr: ptrTo(true)}},
		},
	)
	if err == nil {
		t.Fatal("ExtractBatch accepted a Configs slice shorter than files")
	}
	if !strings.Contains(err.Error(), "has 1 entries but 2 files were supplied") {
		t.Errorf("error = %v, want it to report the length mismatch", err)
	}
	if reached {
		t.Error("request was sent despite the length mismatch")
	}
}

// TestExtractBatch_RejectsAnExplicitlyEmptyConfigsSlice pins the nil/empty
// distinction. Python skips only on None and TypeScript only on undefined, so
// an emptied slice is a length mismatch there; treating it as "no overrides"
// in Go alone would turn the same caller mistake into a silent no-op.
func TestExtractBatch_RejectsAnExplicitlyEmptyConfigsSlice(t *testing.T) {
	t.Parallel()
	var reached bool
	server := httptest.NewServer(http.HandlerFunc(func(w http.ResponseWriter, _ *http.Request) {
		reached = true
		w.WriteHeader(http.StatusAccepted)
	}))
	defer server.Close()

	client := mustClient(t, xberg.WithBaseURL(server.URL))
	_, err := client.ExtractBatch(
		context.Background(),
		[]xberg.FileSource{
			{Name: "scanned.pdf", Reader: strings.NewReader("body-0")},
			{Name: "digital.pdf", Reader: strings.NewReader("body-1")},
		},
		&xberg.ExtractOptions{Configs: []*xberg.FileExtractionConfig{}},
	)
	if err == nil {
		t.Fatal("ExtractBatch accepted an explicitly empty Configs slice alongside two files")
	}
	if !strings.Contains(err.Error(), "has 0 entries but 2 files were supplied") {
		t.Errorf("error = %v, want it to report the length mismatch", err)
	}
	if reached {
		t.Error("request was sent despite the length mismatch")
	}
}

// TestExtractBatch_NilConfigsMeansNoOverrides is the other half: nil still
// means "no per-file configs", so the common call site keeps working.
func TestExtractBatch_NilConfigsMeansNoOverrides(t *testing.T) {
	t.Parallel()
	server := httptest.NewServer(http.HandlerFunc(func(w http.ResponseWriter, _ *http.Request) {
		w.WriteHeader(http.StatusAccepted)
		_, _ = w.Write([]byte(`{"job_ids":["550e8400-e29b-41d4-a716-446655440000"]}`))
	}))
	defer server.Close()

	client := mustClient(t, xberg.WithBaseURL(server.URL))
	ids, err := client.ExtractBatch(
		context.Background(),
		[]xberg.FileSource{{Name: "scanned.pdf", Reader: strings.NewReader("body-0")}},
		&xberg.ExtractOptions{Configs: nil},
	)
	if err != nil {
		t.Fatalf("ExtractBatch with nil Configs: %v", err)
	}
	if len(ids) != 1 {
		t.Errorf("job ids = %v, want one", ids)
	}
}
