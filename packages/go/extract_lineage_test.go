package xberg_test

import (
	"context"
	"fmt"
	"io"
	"net/http"
	"net/http/httptest"
	"reflect"
	"strings"
	"testing"

	"github.com/google/uuid"
	xberg "github.com/xberg-io/sdks/packages/go"
)

func TestExtractBatchDocumentLineageMultipart(t *testing.T) {
	id := uuid.MustParse("abcdefab-1234-5678-9012-abcdefabcdef")
	var fields map[string][]string
	server := httptest.NewServer(http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
		if r.Method == http.MethodGet {
			fmt.Fprint(w, jobBody(strings.TrimPrefix(r.URL.Path, "/v1/jobs/"), "a.txt", "completed"))
			return
		}
		reader, err := r.MultipartReader()
		if err != nil {
			t.Error(err)
			return
		}
		fields = map[string][]string{}
		files := 0
		first := true
		for {
			part, err := reader.NextPart()
			if err == io.EOF {
				break
			}
			if err != nil {
				t.Error(err)
				return
			}
			if first && part.FormName() != "document_id-a.txt" {
				t.Error("document ID must precede files")
			}
			first = false
			data, err := io.ReadAll(part)
			if err != nil {
				t.Error(err)
				return
			}
			if part.FileName() != "" {
				files++
			} else {
				fields[part.FormName()] = append(fields[part.FormName()], string(data))
			}
		}
		if files != 3 {
			t.Errorf("files=%d", files)
		}
		fmt.Fprintf(w, `{"job_ids":[%q,%q,%q]}`, extractJobA, extractJobB, extractJobC)
	}))
	defer server.Close()
	client := mustClient(t, xberg.WithBaseURL(server.URL), xberg.WithTarget(xberg.TargetEnterprise))
	_, err := client.ExtractBatch(context.Background(), []xberg.FileSource{
		{Name: "a.txt", Reader: strings.NewReader("a")}, {Name: "a.txt", Reader: strings.NewReader("b")}, {Name: "c.txt", Reader: strings.NewReader("c")},
	}, &xberg.ExtractOptions{DocumentIDs: []*uuid.UUID{&id, &id, nil}})
	if err != nil {
		t.Fatal(err)
	}
	if !reflect.DeepEqual(fields, map[string][]string{"document_id-a.txt": {id.String()}}) {
		t.Fatalf("fields = %#v", fields)
	}
}

type lineageReader struct{ reads int }

func (r *lineageReader) Read([]byte) (int, error) { r.reads++; return 0, io.EOF }

func TestExtractLineageRejectsInvalidOptionsBeforeReading(t *testing.T) {
	id := uuid.New()
	for _, tc := range []struct {
		name   string
		ids    []*uuid.UUID
		target xberg.Target
	}{
		{"empty", []*uuid.UUID{}, xberg.TargetEnterprise},
		{"short", []*uuid.UUID{&id}, xberg.TargetEnterprise},
		{"conflicting", []*uuid.UUID{&id, nil}, xberg.TargetEnterprise},
		{"pro", []*uuid.UUID{&id, &id}, xberg.TargetPro},
	} {
		t.Run(tc.name, func(t *testing.T) {
			reader := &lineageReader{}
			client := mustClient(t, xberg.WithBaseURL("http://127.0.0.1:1"), xberg.WithTarget(tc.target))
			_, err := client.ExtractBatch(context.Background(), []xberg.FileSource{{Name: "a", Reader: reader}, {Name: "a", Reader: reader}}, &xberg.ExtractOptions{DocumentIDs: tc.ids})
			if err == nil {
				t.Fatal("expected validation or tier error")
			}
			if reader.reads != 0 {
				t.Fatalf("reader drained %d times", reader.reads)
			}
		})
	}
}

func TestExtractLineageProProbeDoesNotDrainFile(t *testing.T) {
	calls := 0
	server := httptest.NewServer(http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
		calls++
		if r.URL.Path != "/healthz" {
			t.Errorf("unexpected path %s", r.URL.Path)
		}
		fmt.Fprint(w, `{"tier":"pro"}`)
	}))
	defer server.Close()
	reader := &lineageReader{}
	id := uuid.New()
	client := mustClient(t, xberg.WithBaseURL(server.URL))
	_, err := client.Extract(context.Background(), xberg.FileSource{Name: "a", Reader: reader}, &xberg.ExtractOptions{DocumentIDs: []*uuid.UUID{&id}})
	if err == nil || reader.reads != 0 || calls != 1 {
		t.Fatalf("err=%v reads=%d calls=%d", err, reader.reads, calls)
	}
}

func TestExtractAndWaitForwardsDocumentLineage(t *testing.T) {
	id := uuid.New()
	fields := 0
	server := httptest.NewServer(http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
		if r.Method == http.MethodGet {
			fmt.Fprint(w, jobBody(extractJobA, "a", "completed"))
			return
		}
		if err := r.ParseMultipartForm(1 << 20); err != nil {
			t.Error(err)
			return
		}
		defer r.MultipartForm.RemoveAll()
		if r.FormValue("document_id-a") != id.String() {
			t.Error("missing document ID")
		}
		fields++
		fmt.Fprintf(w, `{"job_ids":[%q]}`, extractJobA)
	}))
	defer server.Close()
	client := mustClient(t, xberg.WithBaseURL(server.URL), xberg.WithTarget(xberg.TargetEnterprise))
	job, err := client.ExtractAndWait(context.Background(), xberg.FileSource{Name: "a", Reader: strings.NewReader("data")}, &xberg.ExtractAndWaitOptions{Extract: &xberg.ExtractOptions{DocumentIDs: []*uuid.UUID{&id}}})
	if err != nil {
		t.Fatal(err)
	}
	if fields != 1 || job.Status != xberg.JobStatusCompleted {
		t.Fatalf("fields=%d status=%s", fields, job.Status)
	}
}

func TestExtractNilLineageDoesNotProbeTier(t *testing.T) {
	var raw string
	server := perFileConfigServer(t, &raw, extractJobA)
	defer server.Close()
	client := mustClient(t, xberg.WithBaseURL(server.URL))
	_, err := client.Extract(context.Background(), xberg.FileSource{Name: "a", Reader: strings.NewReader("data")}, &xberg.ExtractOptions{DocumentIDs: []*uuid.UUID{nil}})
	if err != nil {
		t.Fatal(err)
	}
	if strings.Contains(raw, "document_id-") {
		t.Fatal("unexpected lineage part")
	}
}
