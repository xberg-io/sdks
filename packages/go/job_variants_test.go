package xberg_test

import (
	"context"
	"encoding/json"
	"errors"
	"fmt"
	"io"
	"net/http"
	"net/http/httptest"
	"sync/atomic"
	"testing"

	xberg "github.com/xberg-io/sdks/packages/go"
)

const crawlJobFixture = `{"id":"550e8400-e29b-41d4-a716-446655440000","job_type":"crawl","created_at":"2026-10-12T10:00:00Z","status":"completed","output_mode":"markdown","seed_urls":["https://example.test"],"progress":{"documents_discovered":2,"documents_extracted":1,"documents_failed":0,"pages_crawled":3},"jobs":[{"id":"550e8400-e29b-41d4-a716-446655440000","filename":"page.html","status":"completed","source_url":"https://example.test/page"}],"pages":[{"url":"https://example.test","status":"fetched","fetched_at":"2026-10-12T10:00:00Z"}],"future_field":"retained"}`

func TestGetJobTaggedVariantsAndLegacyExtraction(t *testing.T) {
	for _, target := range []xberg.Target{xberg.TargetEnterprise, xberg.TargetPro} {
		for _, kind := range []string{"extraction", "crawl", "legacy"} {
			t.Run(string(target)+"/"+kind, func(t *testing.T) {
				payload := fmt.Sprintf(`{"id":%q,"filename":"fixture.pdf","mime_type":"application/pdf","created_at":"2026-10-12T10:00:00Z","status":"completed","future_field":"retained"}`, jobUUID)
				if kind == "crawl" {
					payload = crawlJobFixture
				}
				if kind == "extraction" {
					payload = payload[:len(payload)-1] + `,"job_type":"extraction"}`
				}
				server := httptest.NewServer(http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
					if r.Method != http.MethodGet || r.URL.Path != "/v1/jobs/"+jobUUID {
						t.Errorf("request = %s %s", r.Method, r.URL.Path)
					}
					_, _ = io.WriteString(w, payload)
				}))
				defer server.Close()
				client := mustClient(t, xberg.WithBaseURL(server.URL), xberg.WithTarget(target))
				job, err := client.GetJob(context.Background(), jobUUID)
				if err != nil {
					t.Fatal(err)
				}
				wire, err := json.Marshal(job)
				if err != nil {
					t.Fatal(err)
				}
				var object map[string]any
				if err := json.Unmarshal(wire, &object); err != nil {
					t.Fatal(err)
				}
				if object["future_field"] != "retained" {
					t.Fatalf("unknown wire fields lost: %s", wire)
				}
				if kind == "crawl" {
					crawl, err := job.AsGetJobResponse1()
					if err != nil {
						t.Fatal(err)
					}
					if crawl.JobType != "crawl" || crawl.Progress.PagesCrawled != 3 || crawl.Jobs == nil || (*crawl.Jobs)[0].SourceUrl == nil || *(*crawl.Jobs)[0].SourceUrl != "https://example.test/page" || crawl.Pages == nil || (*crawl.Pages)[0].Url != "https://example.test" {
						t.Fatalf("crawl record = %#v", crawl)
					}
				} else {
					extraction, err := job.AsGetJobResponse0()
					if err != nil {
						t.Fatal(err)
					}
					if extraction.JobType != "extraction" || extraction.Filename != "fixture.pdf" || extraction.Id.String() != jobUUID {
						t.Fatalf("extraction record = %#v", extraction)
					}
				}
			})
		}
	}
}

func TestGetJobUnknownDiscriminator(t *testing.T) {
	for _, discriminator := range []string{`"future"`, "null", "42"} {
		t.Run(discriminator, func(t *testing.T) {
			server := httptest.NewServer(http.HandlerFunc(func(w http.ResponseWriter, _ *http.Request) {
				fmt.Fprintf(w, `{"filename":"fixture.pdf","job_type":%s}`, discriminator)
			}))
			defer server.Close()
			client := mustClient(t, xberg.WithBaseURL(server.URL))
			_, err := client.GetJob(context.Background(), jobUUID)
			var validation *xberg.ValidationError
			if !errors.As(err, &validation) || validation.Status != http.StatusOK {
				t.Fatalf("error = %v, want validation error for invalid job_type", err)
			}
		})
	}
}

func TestWaitForJobRejectsCrawlRecord(t *testing.T) {
	var requests atomic.Int32
	server := httptest.NewServer(http.HandlerFunc(func(w http.ResponseWriter, _ *http.Request) {
		requests.Add(1)
		_, _ = io.WriteString(w, crawlJobFixture)
	}))
	defer server.Close()
	client := mustClient(t, xberg.WithBaseURL(server.URL))
	_, err := client.WaitForJob(context.Background(), jobUUID, nil)
	var validation *xberg.ValidationError
	if !errors.As(err, &validation) || requests.Load() != 1 {
		t.Fatalf("error = %v, requests = %d", err, requests.Load())
	}
	if validation.Message != "expected extraction job, received crawl job" {
		t.Fatalf("validation = %v", validation)
	}
}
