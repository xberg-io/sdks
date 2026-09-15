package xberg_test

import (
	"context"
	"net/http"
	"net/http/httptest"
	"strings"
	"testing"

	xberg "github.com/xberg-io/sdks/packages/go"
)

const (
	testDocumentID    = "doc-1"
	testEnrichJobID   = "01JENRICHJOB0000000000000"
	testWebhookID     = "9f8e7d6c-0000-4000-8000-000000000001"
	testDeliveryID    = "9f8e7d6c-0000-4000-8000-000000000002"
	enrichStatusBody  = `{"status":"completed","result":{"keywords":["invoice","acme"]}}`
	extractionsResult = `{"events":[{"job_id":"aaaaaaaa-0000-4000-8000-000000000011","filename":"a.pdf","status":"completed",
		"pages":3,"created_at":"2025-01-01T00:00:00Z"}],"total":1,"limit":50,"page":0}`
)

// enterpriseClient spins up an Enterprise-targeted client whose transport
// records the single request the method under test issues.
func enterpriseClient(t *testing.T, status int, response string, seen *recordedRequest) *xberg.Client {
	t.Helper()
	return targetClient(t, xberg.TargetEnterprise, status, response, seen)
}

func TestGetDocument_ReturnsRawLatestVersion(t *testing.T) {
	t.Parallel()
	var seen recordedRequest
	client := enterpriseClient(t, http.StatusOK, `{"document_id":"doc-1","version":4}`, &seen)

	body, err := client.GetDocument(context.Background(), testDocumentID)
	if err != nil {
		t.Fatalf("GetDocument: %v", err)
	}
	if seen.method != http.MethodGet || seen.path != "/v1/documents/doc-1" {
		t.Errorf("request = %s %s, want GET /v1/documents/doc-1", seen.method, seen.path)
	}
	if !strings.Contains(string(body), `"version":4`) {
		t.Errorf("body = %s, want it to contain version=4", body)
	}
}

func TestListExtractionEvents_EncodesDaysAndPaging(t *testing.T) {
	t.Parallel()
	var seen recordedRequest
	client := enterpriseClient(t, http.StatusOK, extractionsResult, &seen)

	page, err := client.ListExtractionEvents(context.Background(), 7, 25, 50)
	if err != nil {
		t.Fatalf("ListExtractionEvents: %v", err)
	}
	if seen.method != http.MethodGet || seen.path != "/v1/extractions" {
		t.Errorf("request = %s %s, want GET /v1/extractions", seen.method, seen.path)
	}
	if seen.query != "days=7&limit=25&offset=50" {
		t.Errorf("query = %q, want days=7&limit=25&offset=50", seen.query)
	}
	if page.Total != 1 || len(page.Events) != 1 {
		t.Fatalf("page = %+v, want one extraction event", page)
	}
}

func TestListExtractionEvents_OmitsNonPositiveFilters(t *testing.T) {
	t.Parallel()
	var seen recordedRequest
	client := enterpriseClient(t, http.StatusOK, extractionsResult, &seen)

	if _, err := client.ListExtractionEvents(context.Background(), 0, 0, 0); err != nil {
		t.Fatalf("ListExtractionEvents: %v", err)
	}
	if seen.query != "" {
		t.Errorf("query = %q, want empty when days, limit and offset are unset", seen.query)
	}
}

func TestSubmitEnrich_PostsTextRequest(t *testing.T) {
	t.Parallel()
	var seen recordedRequest
	client := enterpriseClient(t, http.StatusAccepted, `{"job_id":"`+testEnrichJobID+`"}`, &seen)

	keywords := true
	submitted, err := client.SubmitEnrich(context.Background(), xberg.EnrichTextRequest{
		Text:    "Acme Corp invoice",
		Options: &xberg.EnrichRequestOptions{Keywords: &keywords},
	})
	if err != nil {
		t.Fatalf("SubmitEnrich: %v", err)
	}
	if seen.method != http.MethodPost || seen.path != "/v1/enrich" {
		t.Errorf("request = %s %s, want POST /v1/enrich", seen.method, seen.path)
	}
	if seen.body != `{"options":{"keywords":true},"text":"Acme Corp invoice"}` {
		t.Errorf("body = %s, want the text+options payload", seen.body)
	}
	if submitted.JobId != testEnrichJobID {
		t.Errorf("JobId = %q, want %s", submitted.JobId, testEnrichJobID)
	}
}

func TestGetEnrichStatus_DecodesCompletedUnion(t *testing.T) {
	t.Parallel()
	var seen recordedRequest
	client := enterpriseClient(t, http.StatusOK, enrichStatusBody, &seen)

	status, err := client.GetEnrichStatus(context.Background(), testEnrichJobID)
	if err != nil {
		t.Fatalf("GetEnrichStatus: %v", err)
	}
	if seen.method != http.MethodGet || seen.path != "/v1/enrich/"+testEnrichJobID {
		t.Errorf("request = %s %s, want GET /v1/enrich/%s", seen.method, seen.path, testEnrichJobID)
	}
	completed, err := status.AsEnrichJobStatus1()
	if err != nil {
		t.Fatalf("AsEnrichJobStatus1: %v", err)
	}
	if completed.Result.Keywords == nil || len(*completed.Result.Keywords) != 2 {
		t.Errorf("Keywords = %v, want two extracted keywords", completed.Result.Keywords)
	}
}

// TestEnterpriseAdditions_AreGatedToEnterprise pins the tier gate on the
// operations only the Enterprise spec declares: they must fail before issuing a
// request that would 404 on Pro.
func TestEnterpriseAdditions_AreGatedToEnterprise(t *testing.T) {
	t.Parallel()
	server := httptest.NewServer(http.HandlerFunc(func(_ http.ResponseWriter, r *http.Request) {
		t.Errorf("unexpected HTTP call to %s; gate should short-circuit", r.URL.Path)
	}))
	defer server.Close()
	client := mustClient(t, xberg.WithBaseURL(server.URL), xberg.WithTarget(xberg.TargetPro))
	ctx := context.Background()

	calls := map[string]func() error{
		"GetDocument": func() error { _, err := client.GetDocument(ctx, testDocumentID); return err },
		"ListExtractionEvents": func() error {
			_, err := client.ListExtractionEvents(ctx, 0, 0, 0)
			return err
		},
		"Versions": func() error { _, err := client.Versions(ctx, testDocumentID); return err },
		"ListSubscriptionDeliveries": func() error {
			_, err := client.ListSubscriptionDeliveries(ctx, testWebhookID, 0, 0)
			return err
		},
		"GetSubscriptionDelivery": func() error {
			_, err := client.GetSubscriptionDelivery(ctx, testWebhookID, testDeliveryID)
			return err
		},
	}
	if len(calls) != 5 {
		t.Fatalf("covered %d Enterprise-only additions, want all 5", len(calls))
	}
	for name, call := range calls {
		t.Run(name, func(t *testing.T) {
			t.Parallel()
			err := call()
			var tierErr *xberg.TierError
			if !asError(err, &tierErr) {
				t.Fatalf("expected TierError, got %T: %v", err, err)
			}
			if tierErr.Required != "enterprise" || tierErr.Method != name {
				t.Errorf("TierError = %+v, want method=%s required=enterprise", tierErr, name)
			}
		})
	}
}
