package kreuzbergcloud_test

import (
	"context"
	"encoding/json"
	"io"
	"mime"
	"mime/multipart"
	"net/http"
	"net/http/httptest"
	"strings"
	"testing"

	kreuzbergcloud "github.com/xberg-io/sdks/go"
)

func TestExtract_SubmitsSingleFileAndReturnsJob(t *testing.T) {
	t.Parallel()
	server := httptest.NewServer(http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
		if r.URL.Path != "/v1/extract" {
			t.Errorf("path = %q, want /v1/extract", r.URL.Path)
		}
		if r.Method != http.MethodPost {
			t.Errorf("method = %q, want POST", r.Method)
		}
		if got := r.Header.Get("Authorization"); got != "Bearer test-key" {
			t.Errorf("Authorization = %q, want %q", got, "Bearer test-key")
		}
		w.WriteHeader(http.StatusAccepted)
		_, _ = w.Write([]byte(`{"job_ids":["job-1"],"status":"pending"}`))
	}))
	defer server.Close()

	client := mustClient(t, kreuzbergcloud.WithBaseURL(server.URL), kreuzbergcloud.WithAPIKey("test-key"))
	job, err := client.Extract(
		context.Background(),
		kreuzbergcloud.FileSource{Name: "invoice.pdf", Reader: strings.NewReader("hello")},
		nil,
	)
	if err != nil {
		t.Fatalf("Extract: %v", err)
	}
	if job.ID != "job-1" {
		t.Errorf("Job.ID = %q, want job-1", job.ID)
	}
	if job.Filename != "invoice.pdf" {
		t.Errorf("Job.Filename = %q, want invoice.pdf", job.Filename)
	}
	if job.Status != "pending" {
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
		_, _ = w.Write([]byte(`{"job_ids":["a","b"],"status":"pending"}`))
	}))
	defer server.Close()

	client := mustClient(t, kreuzbergcloud.WithBaseURL(server.URL))
	disable := false
	_, err := client.ExtractBatch(
		context.Background(),
		[]kreuzbergcloud.FileSource{
			{Name: "a.pdf", Reader: strings.NewReader("aaaa")},
			{Name: "b.png", Reader: strings.NewReader("bbbb")},
		},
		&kreuzbergcloud.ExtractionOptions{
			ExtractionConfig: &kreuzbergcloud.ExtractionConfig{
				OutputFormat: "markdown",
				DisableOCR:   &disable,
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
	if got.webhook != `{"url":""}` {
		t.Errorf("webhook = %q, want empty webhook stub", got.webhook)
	}
}

func TestExtractBatch_RejectsEmptySlice(t *testing.T) {
	t.Parallel()
	client := mustClient(t, kreuzbergcloud.WithBaseURL("https://example.test"))
	if _, err := client.ExtractBatch(context.Background(), nil, nil); err == nil {
		t.Errorf("ExtractBatch(nil) returned nil error")
	}
}

func TestExtractBatch_RejectsMissingFilename(t *testing.T) {
	t.Parallel()
	client := mustClient(t, kreuzbergcloud.WithBaseURL("https://example.test"))
	_, err := client.ExtractBatch(
		context.Background(),
		[]kreuzbergcloud.FileSource{{Name: "", Reader: strings.NewReader("x")}},
		nil,
	)
	if err == nil {
		t.Errorf("ExtractBatch with empty Name returned nil error")
	}
}

func TestExtractBatch_RejectsMissingReader(t *testing.T) {
	t.Parallel()
	client := mustClient(t, kreuzbergcloud.WithBaseURL("https://example.test"))
	_, err := client.ExtractBatch(
		context.Background(),
		[]kreuzbergcloud.FileSource{{Name: "x.pdf", Reader: nil}},
		nil,
	)
	if err == nil {
		t.Errorf("ExtractBatch with nil Reader returned nil error")
	}
}

func TestExtractBatch_ReturnsJobIDsInOrder(t *testing.T) {
	t.Parallel()
	server := httptest.NewServer(http.HandlerFunc(func(w http.ResponseWriter, _ *http.Request) {
		w.WriteHeader(http.StatusAccepted)
		_, _ = w.Write([]byte(`{"job_ids":["x","y","z"],"status":"pending"}`))
	}))
	defer server.Close()
	client := mustClient(t, kreuzbergcloud.WithBaseURL(server.URL))
	jobs, err := client.ExtractBatch(
		context.Background(),
		[]kreuzbergcloud.FileSource{
			{Name: "1.pdf", Reader: strings.NewReader("1")},
			{Name: "2.pdf", Reader: strings.NewReader("2")},
			{Name: "3.pdf", Reader: strings.NewReader("3")},
		},
		nil,
	)
	if err != nil {
		t.Fatalf("ExtractBatch: %v", err)
	}
	want := []string{"x", "y", "z"}
	wantFiles := []string{"1.pdf", "2.pdf", "3.pdf"}
	for i, job := range jobs {
		if job.ID != want[i] {
			t.Errorf("jobs[%d].ID = %q, want %q", i, job.ID, want[i])
		}
		if job.Filename != wantFiles[i] {
			t.Errorf("jobs[%d].Filename = %q, want %q", i, job.Filename, wantFiles[i])
		}
	}
}

func TestExtractBatch_ServerReturnsMismatchedJobCount(t *testing.T) {
	t.Parallel()
	server := httptest.NewServer(http.HandlerFunc(func(w http.ResponseWriter, _ *http.Request) {
		w.WriteHeader(http.StatusAccepted)
		_, _ = w.Write([]byte(`{"job_ids":["only-one"],"status":"pending"}`))
	}))
	defer server.Close()
	client := mustClient(t, kreuzbergcloud.WithBaseURL(server.URL))
	_, err := client.ExtractBatch(
		context.Background(),
		[]kreuzbergcloud.FileSource{
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
		_, _ = w.Write([]byte(`{"job_ids":["nooptions"],"status":"pending"}`))
	}))
	defer server.Close()
	client := mustClient(t, kreuzbergcloud.WithBaseURL(server.URL))
	if _, err := client.Extract(
		context.Background(),
		kreuzbergcloud.FileSource{Name: "a.pdf", Reader: strings.NewReader("a")},
		nil,
	); err != nil {
		t.Fatalf("Extract: %v", err)
	}
	if receivedOptions {
		t.Errorf("server received options part when none was passed")
	}
}

func TestExtract_PropagatesAPIError(t *testing.T) {
	t.Parallel()
	server := httptest.NewServer(http.HandlerFunc(func(w http.ResponseWriter, _ *http.Request) {
		w.WriteHeader(http.StatusBadRequest)
		_ = json.NewEncoder(w).Encode(map[string]string{"error": "no document"})
	}))
	defer server.Close()
	client := mustClient(t, kreuzbergcloud.WithBaseURL(server.URL))
	_, err := client.Extract(
		context.Background(),
		kreuzbergcloud.FileSource{Name: "x.pdf", Reader: strings.NewReader("x")},
		nil,
	)
	if err == nil {
		t.Fatalf("expected error, got nil")
	}
	var validation *kreuzbergcloud.ValidationError
	if !asError(err, &validation) {
		t.Fatalf("expected ValidationError, got %T: %v", err, err)
	}
	if !strings.Contains(validation.Message, "no document") {
		t.Errorf("error message = %q, want it to contain 'no document'", validation.Message)
	}
}
