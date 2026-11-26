package xberg_test

import (
	"context"
	"fmt"
	"io"
	"mime"
	"mime/multipart"
	"net/http"
	"net/http/httptest"
	"strings"
	"sync"
	"testing"

	xberg "github.com/xberg-io/sdks/packages/go"
)

const (
	keyedJob     = "dddddddd-4444-4444-8444-444444444444"
	keyedProject = "11111111-1111-4111-8111-111111111111"
	keyedKey     = "retry-key-0001"
)

// keyedSubmission is what the keyed extraction fixture saw on its POST.
type keyedSubmission struct {
	mu             sync.Mutex
	posts          int
	idempotencyKey string
	projectHeader  string
	rawQuery       string
	jobQuery       string
	filenames      []string
	fields         map[string]string
}

func keyedServer(t *testing.T, seen *keyedSubmission) string {
	t.Helper()
	server := httptest.NewServer(http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
		seen.mu.Lock()
		defer seen.mu.Unlock()
		switch {
		case r.Method == http.MethodPost && r.URL.Path == "/v1/extract/keyed":
			seen.posts++
			seen.idempotencyKey = r.Header.Get("Idempotency-Key")
			seen.projectHeader = r.Header.Get("X-Project-ID")
			seen.rawQuery = r.URL.RawQuery
			readKeyedForm(t, r, seen)
			w.WriteHeader(http.StatusAccepted)
			fmt.Fprintf(w, `{"job_ids":[%q],"status":"pending"}`, keyedJob)
		case r.Method == http.MethodGet && r.URL.Path == "/v1/jobs/"+keyedJob:
			seen.jobQuery = r.URL.RawQuery
			_, _ = w.Write([]byte(jobBody(keyedJob, "invoice.pdf", "pending")))
		default:
			t.Errorf("unexpected request %s %s", r.Method, r.URL.Path)
		}
	}))
	t.Cleanup(server.Close)
	return server.URL
}

func readKeyedForm(t *testing.T, r *http.Request, seen *keyedSubmission) {
	t.Helper()
	mediaType, params, err := mime.ParseMediaType(r.Header.Get("Content-Type"))
	if err != nil || mediaType != "multipart/form-data" {
		t.Errorf("content-type = %q, want multipart/form-data", r.Header.Get("Content-Type"))
		return
	}
	seen.fields = map[string]string{}
	reader := multipart.NewReader(r.Body, params["boundary"])
	for {
		part, err := reader.NextPart()
		if err == io.EOF {
			return
		}
		if err != nil {
			t.Errorf("reading multipart: %v", err)
			return
		}
		value, _ := io.ReadAll(part)
		if part.FormName() == "file" {
			seen.filenames = append(seen.filenames, part.FileName())
			continue
		}
		seen.fields[part.FormName()] = string(value)
	}
}

func TestExtractKeyed_SendsIdempotencyKeyWithMultipartBody(t *testing.T) {
	t.Parallel()
	var seen keyedSubmission
	client := mustClient(t, xberg.WithBaseURL(keyedServer(t, &seen)), xberg.WithTarget(xberg.TargetPro))
	preset := "invoice"
	forceOCR := true

	jobs, err := client.ExtractKeyed(
		context.Background(),
		keyedKey,
		[]xberg.FileSource{{Name: "invoice.pdf", Reader: strings.NewReader("%PDF-1.4")}},
		&xberg.ExtractKeyedOptions{
			Extraction: &xberg.ExtractionOptions{Preset: &preset},
			Configs:    []*xberg.FileExtractionConfig{{ForceOcr: &forceOCR}},
		},
	)
	if err != nil {
		t.Fatalf("ExtractKeyed: %v", err)
	}
	if len(jobs) != 1 || jobs[0].Id.String() != keyedJob {
		t.Fatalf("jobs = %+v, want one job %s", jobs, keyedJob)
	}
	if seen.posts != 1 {
		t.Errorf("POST count = %d, want 1", seen.posts)
	}
	if seen.idempotencyKey != keyedKey {
		t.Errorf("Idempotency-Key = %q, want %q", seen.idempotencyKey, keyedKey)
	}
	if seen.projectHeader != "" {
		t.Errorf("X-Project-ID = %q, want none", seen.projectHeader)
	}
	if got := strings.Join(seen.filenames, ","); got != "invoice.pdf" {
		t.Errorf("file parts = %q, want invoice.pdf", got)
	}
	if got := seen.fields["options"]; got != `{"preset":"invoice"}` {
		t.Errorf("options part = %q", got)
	}
	if got := seen.fields["config-invoice.pdf"]; got != `{"force_ocr":true}` {
		t.Errorf("config-invoice.pdf part = %q", got)
	}
	if _, ok := seen.fields["webhook"]; ok {
		t.Error("keyed submission sent a webhook part")
	}
}

func TestExtractKeyed_SelectsProProjectByHeader(t *testing.T) {
	t.Parallel()
	var seen keyedSubmission
	client := mustClient(t, xberg.WithBaseURL(keyedServer(t, &seen)), xberg.WithTarget(xberg.TargetPro))

	ctx := xberg.WithProProject(context.Background(), keyedProject)
	_, err := client.ExtractKeyed(ctx, keyedKey, []xberg.FileSource{{Name: "invoice.pdf", Reader: strings.NewReader("x")}}, nil)
	if err != nil {
		t.Fatalf("ExtractKeyed: %v", err)
	}
	if seen.projectHeader != keyedProject {
		t.Errorf("X-Project-ID = %q, want %q", seen.projectHeader, keyedProject)
	}
	if seen.rawQuery != "" {
		t.Errorf("keyed POST query = %q, want none", seen.rawQuery)
	}
	if seen.jobQuery != "project_id="+keyedProject {
		t.Errorf("job read query = %q, want project_id=%s", seen.jobQuery, keyedProject)
	}
}

func TestExtractKeyed_RejectsBlankKeyOrNoFilesBeforeAnyRequest(t *testing.T) {
	t.Parallel()
	client := mustClient(t, xberg.WithBaseURL(newRefusingServer(t)), xberg.WithTarget(xberg.TargetPro))
	file := []xberg.FileSource{{Name: "a.pdf", Reader: strings.NewReader("x")}}

	if _, err := client.ExtractKeyed(context.Background(), "  ", file, nil); err == nil {
		t.Error("blank idempotency key: want error")
	}
	if _, err := client.ExtractKeyed(context.Background(), keyedKey, nil, nil); err == nil {
		t.Error("no files: want error")
	}
}

func TestExtractKeyed_RefusedOnEnterpriseBeforeAnyRequest(t *testing.T) {
	t.Parallel()
	client := mustClient(t, xberg.WithBaseURL(newRefusingServer(t)), xberg.WithTarget(xberg.TargetEnterprise))

	_, err := client.ExtractKeyed(
		context.Background(), keyedKey, []xberg.FileSource{{Name: "a.pdf", Reader: strings.NewReader("x")}}, nil,
	)
	var tierErr *xberg.TierError
	if !asError(err, &tierErr) || tierErr.Method != "ExtractKeyed" {
		t.Fatalf("err = %v, want *TierError for ExtractKeyed", err)
	}
}
