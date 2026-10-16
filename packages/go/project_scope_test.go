package xberg_test

import (
	"context"
	"errors"
	"fmt"
	"io"
	"net/http"
	"net/http/httptest"
	"slices"
	"strings"
	"sync"
	"sync/atomic"
	"testing"

	xberg "github.com/xberg-io/sdks/packages/go"
)

const scopeProjectID = "11111111-1111-4111-8111-111111111111"

func TestSelectedProjectExtractKeepsImmediateJobReadInProject(t *testing.T) {
	seen := []string{}
	server := httptest.NewServer(http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
		seen = append(seen, r.Method+" "+r.URL.RequestURI())
		if r.Method == http.MethodPost && r.URL.Path == "/v1/extract" {
			if r.Header.Get("X-Project-ID") != scopeProjectID {
				t.Error("submission project missing")
			}
			w.WriteHeader(http.StatusAccepted)
			fmt.Fprintf(w, `{"job_ids":[%q]}`, extractJobA)
			return
		}
		if r.URL.Query().Get("project_id") != scopeProjectID {
			w.WriteHeader(http.StatusNotFound)
			fmt.Fprint(w, `{"error":{"code":"job_not_found"}}`)
			return
		}
		fmt.Fprint(w, jobBody(extractJobA, "scope.txt", "completed"))
	}))
	defer server.Close()
	transport := http.DefaultTransport.(*http.Transport).Clone()
	defer transport.CloseIdleConnections()
	client := mustClient(t, xberg.WithBaseURL(server.URL), xberg.WithTarget(xberg.TargetPro),
		xberg.WithHTTPClient(&http.Client{Transport: transport}))
	job, err := client.Extract(xberg.WithProProject(context.Background(), scopeProjectID), xberg.FileSource{Name: "scope.txt", Reader: strings.NewReader("scope proof")}, nil)
	if len(seen) != 2 || seen[0] != "POST /v1/extract" {
		t.Fatalf("wrong request trace: %v", seen)
	}
	if err != nil {
		t.Fatalf("Extract after accepted submission: %v; trace=%v", err, seen)
	}
	if job.Id.String() != extractJobA {
		t.Fatalf("wrong job id: %v", job.Id)
	}
	if seen[1] != "GET /v1/jobs/"+extractJobA+"?project_id="+scopeProjectID {
		t.Fatalf("wrong read scope: %v", seen)
	}
}

func jobSurfaceHandler(t *testing.T, probes, operations *int) http.Handler {
	t.Helper()
	return http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
		if r.URL.Path == "/healthz" {
			*probes++
			fmt.Fprint(w, `{"tier":"pro"}`)
			return
		}
		*operations++
		if r.Method == http.MethodPost {
			if r.Header.Get("X-Project-ID") != scopeProjectID || r.URL.RawQuery != "" {
				t.Errorf("bad submit scope: %s %v", r.URL, r.Header)
			}
			w.WriteHeader(http.StatusAccepted)
			fmt.Fprintf(w, `{"job_ids":[%q]}`, extractJobA)
			return
		}
		if r.URL.Query().Get("project_id") != scopeProjectID || r.Header.Get("X-Project-ID") != "" {
			t.Errorf("bad read scope: %s %v", r.URL, r.Header)
		}
		switch {
		case r.Method == http.MethodDelete:
			w.WriteHeader(http.StatusNoContent)
		case strings.HasSuffix(r.URL.Path, "/result"):
			fmt.Fprintf(w, `{"job_id":%q,"status":"completed","cached":false,"results":[],"errors":[],"child_job_ids":[]}`, extractJobA)
		case strings.Contains(r.URL.Path, "/pages/"):
			fmt.Fprint(w, "synthetic-page")
		case r.URL.Path == "/v1/jobs":
			if r.URL.Query().Get("limit") != "1" || r.URL.Query().Get("offset") != "2" {
				t.Errorf("pagination lost: %s", r.URL)
			}
			fmt.Fprint(w, `{"jobs":[],"total":0,"limit":1,"offset":2}`)
		default:
			fmt.Fprint(w, jobBody(extractJobA, "scope.txt", "completed"))
		}
	})
}

func TestSelectedProjectJobSurfaceAndSingleAutoProbe(t *testing.T) {
	for _, target := range []xberg.Target{xberg.TargetPro, ""} {
		t.Run(string(target), func(t *testing.T) {
			probes, operations := 0, 0
			server := httptest.NewServer(jobSurfaceHandler(t, &probes, &operations))
			defer server.Close()
			client := mustClient(t, xberg.WithBaseURL(server.URL), xberg.WithTarget(target))
			ctx := xberg.WithProProject(context.Background(), scopeProjectID)
			if _, err := client.ExtractAndWait(ctx, xberg.FileSource{Name: "scope.txt", Reader: strings.NewReader("proof")}, nil); err != nil {
				t.Fatal(err)
			}
			if _, err := client.GetJob(ctx, extractJobA); err != nil {
				t.Fatal(err)
			}
			if _, err := client.GetJobResult(ctx, extractJobA); err != nil {
				t.Fatal(err)
			}
			if _, err := client.ListJobs(ctx, 1, 2); err != nil {
				t.Fatal(err)
			}
			if err := client.CancelJob(ctx, extractJobA); err != nil {
				t.Fatal(err)
			}
			if data, err := client.GetJobPage(ctx, extractJobA, 1); err != nil || string(data) != "synthetic-page" {
				t.Fatalf("page=%q err=%v", data, err)
			}
			if _, err := client.WaitForJob(ctx, extractJobA, nil); err != nil {
				t.Fatal(err)
			}
			if _, err := client.WaitForJobs(ctx, []string{extractJobA}, nil); err != nil {
				t.Fatal(err)
			}
			wantProbes := 0
			if target == "" {
				wantProbes = 1
			}
			if probes != wantProbes || operations != 10 {
				t.Fatalf("probes=%d operations=%d; want %d/10", probes, operations, wantProbes)
			}
		})
	}
}

func TestSelectedProjectEnterpriseGuardAndUnrelatedRoutes(t *testing.T) {
	client := mustClient(t, xberg.WithBaseURL(newRefusingServer(t)), xberg.WithTarget(xberg.TargetEnterprise))
	ctx := xberg.WithProProject(context.Background(), scopeProjectID)
	_, err := client.GetJob(ctx, extractJobA)
	var tier *xberg.TierError
	if !errors.As(err, &tier) {
		t.Fatalf("expected TierError, got %v", err)
	}
	_, err = client.Extract(ctx, xberg.FileSource{Name: "scope.txt", Reader: strings.NewReader("proof")}, nil)
	if !errors.As(err, &tier) {
		t.Fatalf("expected submit TierError, got %v", err)
	}
	if _, err = client.GetJob(xberg.WithProProject(context.Background(), " "), extractJobA); err == nil || !strings.Contains(err.Error(), "must not be blank") {
		t.Fatalf("blank project: %v", err)
	}
	seen := 0
	server := httptest.NewServer(http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
		seen++
		if r.URL.RequestURI() != "/v1/audit" || r.Header.Get("X-Project-ID") != "" {
			t.Errorf("scope leaked: %s %v", r.URL, r.Header)
		}
		fmt.Fprint(w, `{"entries":[],"total":0,"limit":0,"offset":0}`)
	}))
	defer server.Close()
	other := mustClient(t, xberg.WithBaseURL(server.URL), xberg.WithTarget(xberg.TargetEnterprise))
	if _, err := other.Audit(ctx, "", 0, 0); err != nil {
		t.Fatal(err)
	}
	if seen != 1 {
		t.Fatalf("unrelated calls=%d", seen)
	}
}

func TestSelectedProjectConcurrentContextsAndUnscopedRequestAreIsolated(t *testing.T) {
	var probes atomic.Int32
	server := httptest.NewServer(http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
		if r.URL.Path == "/healthz" {
			probes.Add(1)
			fmt.Fprint(w, `{"tier":"pro"}`)
			return
		}
		if r.Header.Get("X-Project-ID") != "" {
			t.Error("read got submit header")
		}
		filename := r.URL.Query().Get("project_id")
		if filename == "" {
			filename = "unscoped"
			if r.URL.RawQuery != "" {
				t.Errorf("unscoped query: %s", r.URL)
			}
		}
		fmt.Fprint(w, jobBody(extractJobA, filename, "completed"))
	}))
	defer server.Close()
	client := mustClient(t, xberg.WithBaseURL(server.URL))
	var group sync.WaitGroup
	for _, project := range []string{scopeProjectID, extractJobB, ""} {
		group.Go(func() {
			ctx := context.Background()
			want := project
			if project != "" {
				ctx = xberg.WithProProject(ctx, project)
			} else {
				want = "unscoped"
			}
			job, err := client.WaitForJob(ctx, extractJobA, nil)
			if err != nil {
				t.Error(err)
				return
			}
			if job.Filename != want {
				t.Errorf("filename=%q want=%q", job.Filename, want)
			}
		})
	}
	group.Wait()
	if probes.Load() != 1 {
		t.Fatalf("probes=%d", probes.Load())
	}
}

func TestSelectedProjectBatchReadsEveryAcceptedJob(t *testing.T) {
	seen := []string{}
	server := httptest.NewServer(http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
		seen = append(seen, r.Method+" "+r.URL.RequestURI())
		if r.Method == http.MethodPost {
			if r.Header.Get("X-Project-ID") != scopeProjectID {
				t.Error("missing submission project")
			}
			w.WriteHeader(http.StatusAccepted)
			fmt.Fprintf(w, `{"job_ids":[%q,%q]}`, extractJobA, extractJobB)
			return
		}
		if r.URL.Query().Get("project_id") != scopeProjectID {
			t.Errorf("missing read project: %s", r.URL)
		}
		fmt.Fprint(w, jobBody(strings.TrimPrefix(r.URL.Path, "/v1/jobs/"), "scope.txt", "completed"))
	}))
	defer server.Close()
	client := mustClient(t, xberg.WithBaseURL(server.URL), xberg.WithTarget(xberg.TargetPro))
	ctx := xberg.WithProProject(context.Background(), scopeProjectID)
	jobs, err := client.ExtractBatch(ctx, []xberg.FileSource{
		{Name: "one.txt", Reader: strings.NewReader("one")},
		{Name: "two.txt", Reader: strings.NewReader("two")},
	}, nil)
	if err != nil {
		t.Fatal(err)
	}
	if len(jobs) != 2 || jobs[0].Id.String() != extractJobA || jobs[1].Id.String() != extractJobB {
		t.Fatalf("wrong accepted jobs: %v", jobs)
	}
	want := []string{"POST /v1/extract", "GET /v1/jobs/" + extractJobA + "?project_id=" + scopeProjectID, "GET /v1/jobs/" + extractJobB + "?project_id=" + scopeProjectID}
	if !slices.Equal(seen, want) {
		t.Fatalf("trace=%v want=%v", seen, want)
	}
}

func scopeReadResponse(body string) *http.Response {
	return &http.Response{StatusCode: http.StatusOK, Header: http.Header{"Content-Type": []string{"application/json"}}, Body: io.NopCloser(strings.NewReader(body))}
}

func TestSelectedProjectUsageAndAuditUseProHeadersAndPreserveEnterprise(t *testing.T) {
	for _, tc := range []struct {
		name     string
		target   xberg.Target
		probed   string
		selected bool
	}{
		{"explicit-pro", xberg.TargetPro, "", true}, {"auto-pro", "", "pro", true},
		{"explicit-enterprise", xberg.TargetEnterprise, "", false}, {"auto-enterprise", "", "enterprise", false},
	} {
		t.Run(tc.name, func(t *testing.T) {
			probes, operations := 0, 0
			transport := jobPollTransport(func(r *http.Request) (*http.Response, error) {
				if r.Method != http.MethodGet || r.Header.Get("Authorization") != "Bearer synthetic-owner" {
					t.Error("method or native bearer changed")
				}
				if r.URL.Path == "/healthz" {
					probes++
					if r.Header.Get("X-Project-ID") != "" {
						t.Error("scope leaked to probe")
					}
					return scopeReadResponse(fmt.Sprintf(`{"tier":%q}`, tc.probed)), nil
				}
				operations++
				want := ""
				if tc.selected {
					want = scopeProjectID
				}
				if r.Header.Get("X-Project-ID") != want {
					t.Errorf("project header=%q want=%q", r.Header.Get("X-Project-ID"), want)
				}
				switch r.URL.Path {
				case "/v1/usage":
					if r.URL.Query().Get("start") != "2026-01-01" || r.URL.Query().Get("end") != "2026-01-02" || len(r.URL.Query()) != 2 {
						t.Errorf("usage query=%s", r.URL.RawQuery)
					}
					return scopeReadResponse(`{"total_documents":2}`), nil
				case "/v1/audit":
					if r.URL.Query().Get("action") != "job.submit" || r.URL.Query().Get("limit") != "1" || r.URL.Query().Get("offset") != "2" || len(r.URL.Query()) != 3 {
						t.Errorf("audit query=%s", r.URL.RawQuery)
					}
					return scopeReadResponse(`{"entries":[],"total":2,"limit":1,"offset":2}`), nil
				default:
					t.Fatalf("unexpected path %s", r.URL.Path)
					return nil, nil
				}
			})
			client := mustClient(t, xberg.WithBaseURL("http://127.0.0.1:8080"), xberg.WithTarget(tc.target), xberg.WithAPIKey("synthetic-owner"), xberg.WithRetries(0), xberg.WithHTTPClient(&http.Client{Transport: transport}))
			ctx := xberg.WithProProject(context.Background(), scopeProjectID)
			usage, err := client.Usage(ctx, map[string]string{"start": "2026-01-01", "end": "2026-01-02"})
			if err != nil || string(usage) != `{"total_documents":2}` {
				t.Fatalf("usage=%s err=%v", usage, err)
			}
			audit, err := client.Audit(ctx, "job.submit", 1, 2)
			if err != nil {
				t.Fatal(err)
			}
			if audit.Total != 2 || audit.Limit != 1 || audit.Offset != 2 || len(audit.Entries) != 0 {
				t.Fatalf("audit=%+v", audit)
			}
			wantProbes := 0
			if tc.target == "" {
				wantProbes = 1
			}
			if operations != 2 || probes != wantProbes {
				t.Fatalf("operations=%d probes=%d want2/%d", operations, probes, wantProbes)
			}
		})
	}
}

func TestSelectedProjectUsageAndAuditRejectBlankBeforeTransport(t *testing.T) {
	for _, op := range []string{"usage", "audit"} {
		t.Run(op, func(t *testing.T) {
			calls := 0
			client := mustClient(t, xberg.WithBaseURL("http://127.0.0.1:8080"), xberg.WithTarget(xberg.TargetPro), xberg.WithHTTPClient(&http.Client{Transport: jobPollTransport(func(*http.Request) (*http.Response, error) { calls++; return scopeReadResponse(`{}`), nil })}))
			ctx := xberg.WithProProject(context.Background(), " ")
			var err error
			if op == "usage" {
				_, err = client.Usage(ctx, nil)
			} else {
				_, err = client.Audit(ctx, "", 0, 0)
			}
			if err == nil || !strings.Contains(err.Error(), "must not be blank") {
				t.Fatalf("blank error=%v", err)
			}
			if calls != 0 {
				t.Fatalf("blank scope reached transport%d times", calls)
			}
		})
	}
}

func TestSelectedProjectUsageAndAuditContextsDoNotLeak(t *testing.T) {
	var calls atomic.Int32
	transport := jobPollTransport(func(r *http.Request) (*http.Response, error) {
		calls.Add(1)
		selector := r.URL.Query().Get("start")
		if r.URL.Path == "/v1/audit" {
			selector = r.URL.Query().Get("offset")
		}
		expected := map[string]string{"2026-01-01": scopeProjectID, "2026-01-02": extractJobB, "2026-01-03": "", "1": scopeProjectID, "2": extractJobB, "3": ""}
		want, ok := expected[selector]
		if !ok || r.Header.Get("X-Project-ID") != want || r.URL.Query().Has("project_id") {
			t.Errorf("scope leak selector=%s header=%q", selector, r.Header.Get("X-Project-ID"))
		}
		return scopeReadResponse(`{"entries":[],"total":0,"limit":1,"offset":0}`), nil
	})
	client := mustClient(t, xberg.WithBaseURL("http://127.0.0.1:8080"), xberg.WithTarget(xberg.TargetPro), xberg.WithRetries(0), xberg.WithHTTPClient(&http.Client{Transport: transport}))
	var wg sync.WaitGroup
	for i, project := range []string{scopeProjectID, extractJobB, ""} {
		wg.Go(func() {
			ctx := context.Background()
			if project != "" {
				ctx = xberg.WithProProject(ctx, project)
			}
			if _, err := client.Usage(ctx, map[string]string{"start": fmt.Sprintf("2026-01-0%d", i+1)}); err != nil {
				t.Error(err)
			}
			if _, err := client.Audit(ctx, "", 1, i+1); err != nil {
				t.Error(err)
			}
		})
	}
	wg.Wait()
	if calls.Load() != 6 {
		t.Fatalf("calls=%d want6", calls.Load())
	}
}
