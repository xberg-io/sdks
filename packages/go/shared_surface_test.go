package xberg_test

import (
	"context"
	"net/http"
	"testing"

	xberg "github.com/xberg-io/sdks/packages/go"
)

// Both specs declare these operations, and always have, but the client gated
// them to Enterprise — so a Pro caller got a TierError for endpoints its own
// server serves. Each case below runs against a Pro-targeted client and fails
// if a TierError comes back or the wrong route is reached.
//
// ~keep StreamCrawlEvents is the seventh ungated operation; it needs an SSE
// server rather than this recorder, so it is covered by
// TestStreamCrawlEvents_StreamsOnPro in crawl_test.go.
func TestPreviouslyGatedOperations_ReachProEndpoints(t *testing.T) {
	t.Parallel()
	cases := []struct {
		name     string
		status   int
		response string
		wantPath string
		call     func(*xberg.Client) error
	}{
		{
			name: "Usage", status: http.StatusOK, response: `{"total_pages":7}`,
			wantPath: "/v1/usage",
			call:     func(c *xberg.Client) error { _, err := c.Usage(context.Background(), nil); return err },
		},
		{
			name: "PresignUpload", status: http.StatusOK, response: `{"batch_id":"b1","uploads":[]}`,
			wantPath: "/v1/uploads/presign",
			call: func(c *xberg.Client) error {
				_, err := c.PresignUpload(context.Background(), map[string]any{"files": []any{}})
				return err
			},
		},
		{
			name: "ConfirmUpload", status: http.StatusAccepted, response: `{"job_ids":[],"status":"processing"}`,
			wantPath: "/v1/uploads/confirm",
			call: func(c *xberg.Client) error {
				_, err := c.ConfirmUpload(context.Background(), map[string]any{"batch_id": "b1"})
				return err
			},
		},
		{
			name: "GetJobPage", status: http.StatusOK, response: "\x89PNG\r\n",
			wantPath: "/v1/jobs/" + jobUUID + "/pages/3",
			call:     func(c *xberg.Client) error { _, err := c.GetJobPage(context.Background(), jobUUID, 3); return err },
		},
		{
			name: "SubmitEnrich", status: http.StatusAccepted, response: `{"job_id":"` + testEnrichJobID + `"}`,
			wantPath: "/v1/enrich",
			call: func(c *xberg.Client) error {
				_, err := c.SubmitEnrich(context.Background(), xberg.EnrichTextRequest{Text: "x"})
				return err
			},
		},
		{
			name: "GetEnrichStatus", status: http.StatusOK, response: enrichStatusBody,
			wantPath: "/v1/enrich/" + testEnrichJobID,
			call: func(c *xberg.Client) error {
				_, err := c.GetEnrichStatus(context.Background(), testEnrichJobID)
				return err
			},
		},
	}
	if len(cases) != 6 {
		t.Fatalf("covered %d recorder-testable ungated operations, want all 6", len(cases))
	}
	for _, testCase := range cases {
		t.Run(testCase.name, func(t *testing.T) {
			t.Parallel()
			var seen recordedRequest
			client := targetClient(t, xberg.TargetPro, testCase.status, testCase.response, &seen)

			err := testCase.call(client)
			var tierErr *xberg.TierError
			if asError(err, &tierErr) {
				t.Fatalf("%s is served by Pro and must not be tier-gated, got %v", testCase.name, tierErr)
			}
			if err != nil {
				t.Fatalf("%s on pro: %v", testCase.name, err)
			}
			if seen.path != testCase.wantPath {
				t.Errorf("path = %q, want %q", seen.path, testCase.wantPath)
			}
		})
	}
}

// TestListManagedEmbeddingPresets_ReachesBothTiers covers the shared
// `GET /v1/rag/embedding-presets` operation, which no client method reached.
func TestListManagedEmbeddingPresets_ReachesBothTiers(t *testing.T) {
	t.Parallel()
	for _, target := range []xberg.Target{xberg.TargetEnterprise, xberg.TargetPro} {
		t.Run(string(target), func(t *testing.T) {
			t.Parallel()
			var seen recordedRequest
			client := targetClient(t, target, http.StatusOK,
				`{"presets":[{"id":"small","model":"text-embedding-3-small","dimensions":1536}]}`, &seen)

			presets, err := client.ListManagedEmbeddingPresets(context.Background())
			if err != nil {
				t.Fatalf("ListManagedEmbeddingPresets: %v", err)
			}
			if seen.method != http.MethodGet || seen.path != "/v1/rag/embedding-presets" {
				t.Errorf("request = %s %s, want GET /v1/rag/embedding-presets", seen.method, seen.path)
			}
			if len(presets.Presets) != 1 {
				t.Fatalf("Presets = %+v, want exactly one preset", presets.Presets)
			}
		})
	}
}

// TestStopAutoTuneJob_PostsToTheStopRoute covers the shared
// `POST /v1/auto-tune/{id}/stop` operation, which answers 204 with no body.
func TestStopAutoTuneJob_PostsToTheStopRoute(t *testing.T) {
	t.Parallel()
	for _, target := range []xberg.Target{xberg.TargetEnterprise, xberg.TargetPro} {
		t.Run(string(target), func(t *testing.T) {
			t.Parallel()
			var seen recordedRequest
			client := targetClient(t, target, http.StatusNoContent, "", &seen)

			if err := client.StopAutoTuneJob(context.Background(), autoTuneJobID); err != nil {
				t.Fatalf("StopAutoTuneJob: %v", err)
			}
			want := "/v1/auto-tune/" + autoTuneJobID + "/stop"
			if seen.method != http.MethodPost || seen.path != want {
				t.Errorf("request = %s %s, want POST %s", seen.method, seen.path, want)
			}
		})
	}
}

// TestGetLicenseInfo_IsProOnly covers `GET /v1/license`, which only the Pro
// spec declares.
func TestGetLicenseInfo_IsProOnly(t *testing.T) {
	t.Parallel()
	var seen recordedRequest
	client := targetClient(t, xberg.TargetPro, http.StatusOK,
		`{"state":"licensed","licensee":"Acme","license_id":"lic-1","plan":"pro","days_remaining":90}`, &seen)

	license, err := client.GetLicenseInfo(context.Background())
	if err != nil {
		t.Fatalf("GetLicenseInfo: %v", err)
	}
	if seen.method != http.MethodGet || seen.path != "/v1/license" {
		t.Errorf("request = %s %s, want GET /v1/license", seen.method, seen.path)
	}
	if license.State != "licensed" {
		t.Errorf("State = %q, want licensed", license.State)
	}
	if license.Licensee == nil || *license.Licensee != "Acme" {
		t.Errorf("Licensee = %v, want Acme", license.Licensee)
	}
	if license.DaysRemaining == nil || *license.DaysRemaining != 90 {
		t.Errorf("DaysRemaining = %v, want 90", license.DaysRemaining)
	}
}

func TestGetLicenseInfo_RefusesOnEnterprise(t *testing.T) {
	t.Parallel()
	server := newRefusingServer(t)
	client := mustClient(t, xberg.WithBaseURL(server), xberg.WithTarget(xberg.TargetEnterprise))

	_, err := client.GetLicenseInfo(context.Background())
	var tierErr *xberg.TierError
	if !asError(err, &tierErr) {
		t.Fatalf("expected TierError, got %T: %v", err, err)
	}
	if tierErr.Required != "pro" || tierErr.Method != "GetLicenseInfo" {
		t.Errorf("TierError = %+v, want method=GetLicenseInfo required=pro", tierErr)
	}
}

// TestPutLocalUpload_IsProOnly covers `PUT /v1/uploads/local/{project_id}/{token}`,
// which only the Pro spec declares. The body is raw bytes, not JSON.
func TestPutLocalUpload_IsProOnly(t *testing.T) {
	t.Parallel()
	var seen recordedRequest
	client := targetClient(t, xberg.TargetPro, http.StatusNoContent, "", &seen)

	const token = "cap-token-1"
	if err := client.PutLocalUpload(context.Background(), testProjectID, token, []byte("PDF-BYTES")); err != nil {
		t.Fatalf("PutLocalUpload: %v", err)
	}
	want := "/v1/uploads/local/" + testProjectID + "/" + token
	if seen.method != http.MethodPut || seen.path != want {
		t.Errorf("request = %s %s, want PUT %s", seen.method, seen.path, want)
	}
	if seen.body != "PDF-BYTES" {
		t.Errorf("body = %q, want the raw bytes unmodified", seen.body)
	}
	if seen.contentType != "application/octet-stream" {
		t.Errorf("Content-Type = %q, want application/octet-stream", seen.contentType)
	}
}

func TestPutLocalUpload_RefusesOnEnterprise(t *testing.T) {
	t.Parallel()
	server := newRefusingServer(t)
	client := mustClient(t, xberg.WithBaseURL(server), xberg.WithTarget(xberg.TargetEnterprise))

	err := client.PutLocalUpload(context.Background(), testProjectID, "t", []byte("x"))
	var tierErr *xberg.TierError
	if !asError(err, &tierErr) {
		t.Fatalf("expected TierError, got %T: %v", err, err)
	}
	if tierErr.Required != "pro" || tierErr.Method != "PutLocalUpload" {
		t.Errorf("TierError = %+v, want method=PutLocalUpload required=pro", tierErr)
	}
}

// TestSubscriptionDeliveries_ReachTheDataPlaneRoutes covers the two Enterprise
// data-plane delivery operations, which are distinct from the control plane's
// project-scoped pair.
func TestSubscriptionDeliveries_ReachTheDataPlaneRoutes(t *testing.T) {
	t.Parallel()
	t.Run("list", func(t *testing.T) {
		t.Parallel()
		var seen recordedRequest
		client := targetClient(t, xberg.TargetEnterprise, http.StatusOK,
			`{"deliveries":[],"total":0,"limit":50,"offset":0}`, &seen)

		if _, err := client.ListSubscriptionDeliveries(context.Background(), testWebhookID, 25, 5); err != nil {
			t.Fatalf("ListSubscriptionDeliveries: %v", err)
		}
		want := "/v1/webhooks/" + testWebhookID + "/deliveries"
		if seen.method != http.MethodGet || seen.path != want {
			t.Errorf("request = %s %s, want GET %s", seen.method, seen.path, want)
		}
		if seen.query != "limit=25&offset=5" {
			t.Errorf("query = %q, want limit=25&offset=5", seen.query)
		}
	})
	t.Run("get", func(t *testing.T) {
		t.Parallel()
		var seen recordedRequest
		client := targetClient(t, xberg.TargetEnterprise, http.StatusOK,
			`{"id":"`+testDeliveryID+`","webhook_id":"`+testWebhookID+`","attempt":1}`, &seen)

		if _, err := client.GetSubscriptionDelivery(context.Background(), testWebhookID, testDeliveryID); err != nil {
			t.Fatalf("GetSubscriptionDelivery: %v", err)
		}
		want := "/v1/webhooks/" + testWebhookID + "/deliveries/" + testDeliveryID
		if seen.method != http.MethodGet || seen.path != want {
			t.Errorf("request = %s %s, want GET %s", seen.method, seen.path, want)
		}
	})
}
