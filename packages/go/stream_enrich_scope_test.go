package xberg_test

import (
	"context"
	"encoding/json"
	"errors"
	"io"
	"net/http"
	"net/http/httptest"
	"strings"
	"testing"

	xberg "github.com/xberg-io/sdks/packages/go"
)

func scopeStreamServer(t *testing.T, requireScope bool, paths, bodies *[]string) string {
	t.Helper()
	server := httptest.NewServer(http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
		*paths = append(*paths, r.Method+" "+r.URL.String())
		if requireScope && r.URL.Query().Get("project_id") != "owned" {
			w.WriteHeader(404)
			return
		}
		if strings.HasSuffix(r.URL.Path, "/events") {
			w.Header().Set("Content-Type", "text/event-stream")
			_, _ = io.WriteString(w, completeFrame())
			return
		}
		w.Header().Set("Content-Type", "application/json")
		if r.Method == "POST" {
			raw, _ := io.ReadAll(r.Body)
			*bodies = append(*bodies, string(raw))
			w.WriteHeader(202)
			_, _ = io.WriteString(w, `{"job_id":"`+testEnrichJobID+`"}`)
			return
		}
		_, _ = io.WriteString(w, `{"job_id":"`+testEnrichJobID+`","status":"completed","result":{"entities":[]}}`)
	}))
	t.Cleanup(server.Close)
	return server.URL
}

func consumeScopedEvents(ctx context.Context, c *xberg.Client) ([]xberg.CrawlEvent, error) {
	seq, err := c.StreamCrawlEvents(ctx, testCrawlJobID)
	if err != nil {
		return nil, err
	}
	var events []xberg.CrawlEvent
	for event, err := range seq {
		if err != nil {
			return nil, err
		}
		events = append(events, event)
	}
	return events, nil
}

func TestStreamAndEnrichmentReachSelectedProProject(t *testing.T) {
	var paths, bodies []string
	c := mustClient(t, xberg.WithBaseURL(scopeStreamServer(t, true, &paths, &bodies)), xberg.WithTarget(xberg.TargetPro))
	if _, err := consumeScopedEvents(context.Background(), c); err == nil {
		t.Fatal("unscoped subscription accepted")
	}
	ctx := xberg.WithProProject(context.Background(), "owned")
	events, err := consumeScopedEvents(ctx, c)
	if err != nil {
		t.Fatal(err)
	}
	if len(events) != 1 || events[0].Kind != xberg.CrawlEventKindComplete {
		t.Fatalf("events=%+v", events)
	}
	submitted, err := c.SubmitEnrich(ctx, xberg.EnrichTextRequest{Text: "café"})
	if err != nil {
		t.Fatal(err)
	}
	if submitted.JobId != testEnrichJobID {
		t.Fatalf("submission=%+v", submitted)
	}
	status, err := c.GetEnrichStatus(ctx, testEnrichJobID)
	if err != nil {
		t.Fatal(err)
	}
	assertCompletedScopeEnrichment(t, status)
	if _, err = c.GetEnrichStatus(xberg.WithProProject(ctx, "other"), testEnrichJobID); err == nil {
		t.Fatal("other project accepted")
	}
	want := []string{"GET " + crawlEventsPath, "GET " + crawlEventsPath + "?project_id=owned", "POST /v1/enrich?project_id=owned", "GET /v1/enrich/" + testEnrichJobID + "?project_id=owned", "GET /v1/enrich/" + testEnrichJobID + "?project_id=other"}
	if strings.Join(paths, "\n") != strings.Join(want, "\n") || len(bodies) != 1 || bodies[0] != `{"text":"café"}` {
		t.Fatalf("paths=%v bodies=%v", paths, bodies)
	}
}

func assertCompletedScopeEnrichment(t *testing.T, status *xberg.EnrichJobStatus) {
	t.Helper()
	if status == nil {
		t.Fatal("nil enrichment status")
	}
	complete, err := status.AsEnrichJobStatus1()
	if err != nil {
		t.Fatal(err)
	}
	if string(complete.Status) != "completed" || complete.Result.Entities == nil || len(*complete.Result.Entities) != 0 {
		t.Fatalf("completed enrichment=%+v", complete)
	}
	encoded, err := json.Marshal(status)
	if err != nil {
		t.Fatal(err)
	}
	var object map[string]interface{}
	if err = json.Unmarshal(encoded, &object); err != nil {
		t.Fatal(err)
	}
	if object["job_id"] != testEnrichJobID {
		t.Fatalf("status lost job ID: %s", encoded)
	}
}

func TestStreamAndEnrichmentScopeRefuseEnterpriseBeforeHTTP(t *testing.T) {
	c := mustClient(t, xberg.WithBaseURL(newRefusingServer(t)), xberg.WithTarget(xberg.TargetEnterprise))
	ctx := xberg.WithProProject(context.Background(), "owned")
	_, streamErr := consumeScopedEvents(ctx, c)
	_, submitErr := c.SubmitEnrich(ctx, xberg.EnrichTextRequest{Text: "x"})
	_, statusErr := c.GetEnrichStatus(ctx, testEnrichJobID)
	_, listErr := c.ListJobs(ctx, 1, 0)
	_, jobErr := c.GetJob(ctx, testEnrichJobID)
	cancelErr := c.CancelJob(ctx, testEnrichJobID)
	_, resultErr := c.GetJobResult(ctx, testEnrichJobID)
	_, pageErr := c.GetJobPage(ctx, testEnrichJobID, 1)
	for _, err := range []error{streamErr, submitErr, statusErr, listErr, jobErr, cancelErr, resultErr, pageErr} {
		var tier *xberg.TierError
		if !errors.As(err, &tier) {
			t.Fatalf("error=%v", err)
		}
	}
}

func TestUnscopedEnterpriseStreamAndEnrichmentRemainCompatible(t *testing.T) {
	var paths, bodies []string
	c := mustClient(t, xberg.WithBaseURL(scopeStreamServer(t, false, &paths, &bodies)), xberg.WithTarget(xberg.TargetEnterprise))
	if _, err := consumeScopedEvents(context.Background(), c); err != nil {
		t.Fatal(err)
	}
	if _, err := c.SubmitEnrich(context.Background(), xberg.EnrichTextRequest{Text: "legacy"}); err != nil {
		t.Fatal(err)
	}
	if _, err := c.GetEnrichStatus(context.Background(), testEnrichJobID); err != nil {
		t.Fatal(err)
	}
	want := []string{"GET " + crawlEventsPath, "POST /v1/enrich", "GET /v1/enrich/" + testEnrichJobID}
	if strings.Join(paths, "\n") != strings.Join(want, "\n") {
		t.Fatalf("paths=%v", paths)
	}
}
