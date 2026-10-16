package xberg_test

import (
	"bytes"
	"context"
	"encoding/json"
	"errors"
	"fmt"
	"io"
	"net/http"
	"strings"
	"sync"
	"sync/atomic"
	"testing"

	xberg "github.com/xberg-io/sdks/packages/go"
)

const uploadBatchID = "00000000-0000-4000-8000-000000000003"
const uploadPresignBody = `{"documents":[{"filename":"owned-alpha.txt","mime_type":"text/plain"},{"filename":"owned-beta.txt","mime_type":"text/plain"}],"config":{"use_cache":false,"disable_ocr":true}}`
const uploadConfirmBody = `{"batch_id":"` + uploadBatchID + `"}`
const uploadPresignResponse = `{"batch_id":"` + uploadBatchID + `","uploads":[]}`
const uploadConfirmResponse = `{"job_ids":["` + extractJobA + `","` + extractJobB + `"],"status":"queued"}`

func uploadResponse(status int, body string) *http.Response {
	return &http.Response{StatusCode: status, Header: http.Header{"Content-Type": []string{"application/json"}}, Body: io.NopCloser(strings.NewReader(body))}
}

func callUploadPreparation(t *testing.T, client *xberg.Client, ctx context.Context) {
	t.Helper()
	presign, err := client.PresignUpload(ctx, json.RawMessage(uploadPresignBody))
	if err != nil || string(presign) != uploadPresignResponse {
		t.Fatalf("presign=%s err=%v", presign, err)
	}
	confirm, err := client.ConfirmUpload(ctx, json.RawMessage(uploadConfirmBody))
	if err != nil || string(confirm) != uploadConfirmResponse {
		t.Fatalf("confirm=%s err=%v", confirm, err)
	}
}

func checkUploadPreparation(t *testing.T, r *http.Request, project string) *http.Response {
	t.Helper()
	if r.Method != http.MethodPost || r.URL.RawQuery != "" || r.Header.Get("Content-Type") != "application/json" {
		t.Errorf("request=%s %s content-type=%q", r.Method, r.URL, r.Header.Get("Content-Type"))
	}
	if r.Header.Get("X-Project-ID") != project || r.Header.Get("Authorization") != "Bearer synthetic-upload-owner" {
		t.Errorf("project=%q want=%q authorization preserved=%v", r.Header.Get("X-Project-ID"), project, r.Header.Get("Authorization") == "Bearer synthetic-upload-owner")
	}
	body, err := io.ReadAll(r.Body)
	if err != nil {
		t.Error(err)
		return uploadResponse(http.StatusInternalServerError, `{}`)
	}
	switch r.URL.Path {
	case "/v1/uploads/presign":
		if string(body) != uploadPresignBody {
			t.Errorf("presign body=%s want=%s", body, uploadPresignBody)
		}
		return uploadResponse(http.StatusOK, uploadPresignResponse)
	case "/v1/uploads/confirm":
		if string(body) != uploadConfirmBody {
			t.Errorf("confirm body=%s want=%s", body, uploadConfirmBody)
		}
		return uploadResponse(http.StatusAccepted, uploadConfirmResponse)
	default:
		t.Errorf("unexpected upload path=%s", r.URL.Path)
		return uploadResponse(http.StatusInternalServerError, `{}`)
	}
}

func TestSelectedProjectUploadsUseProHeadersAndPreserveEnterprise(t *testing.T) {
	for _, tc := range []struct {
		name    string
		target  xberg.Target
		tier    string
		project string
	}{
		{"explicit-pro", xberg.TargetPro, "pro", scopeProjectID},
		{"auto-pro", "", "pro", scopeProjectID},
		{"explicit-enterprise", xberg.TargetEnterprise, "enterprise", ""},
		{"auto-enterprise", "", "enterprise", ""},
	} {
		t.Run(tc.name, func(t *testing.T) {
			probes, operations := 0, 0
			transport := jobPollTransport(func(r *http.Request) (*http.Response, error) {
				if r.URL.Path == "/healthz" {
					probes++
					if r.Method != http.MethodGet || r.Header.Get("X-Project-ID") != "" {
						t.Errorf("invalid probe: %s project=%q", r.Method, r.Header.Get("X-Project-ID"))
					}
					return uploadResponse(http.StatusOK, fmt.Sprintf(`{"tier":%q}`, tc.tier)), nil
				}
				operations++
				return checkUploadPreparation(t, r, tc.project), nil
			})
			client := mustClient(t, xberg.WithBaseURL("https://uploads.example.test"), xberg.WithTarget(tc.target), xberg.WithAPIKey("synthetic-upload-owner"), xberg.WithRetries(0), xberg.WithHTTPClient(&http.Client{Transport: transport}))
			callUploadPreparation(t, client, xberg.WithProProject(context.Background(), scopeProjectID))
			wantProbes := 0
			if tc.target == "" {
				wantProbes = 1
			}
			if probes != wantProbes || operations != 2 {
				t.Fatalf("probes=%d operations=%d want=%d/2", probes, operations, wantProbes)
			}
		})
	}
}

func TestSelectedProjectUploadsRejectBlankBeforeDispatch(t *testing.T) {
	for _, target := range []xberg.Target{xberg.TargetPro, "", xberg.TargetEnterprise} {
		for _, operation := range []string{"presign", "confirm"} {
			t.Run(string(target)+"/"+operation, func(t *testing.T) {
				probes, operations := 0, 0
				transport := jobPollTransport(func(r *http.Request) (*http.Response, error) {
					if r.URL.Path == "/healthz" {
						probes++
						return uploadResponse(http.StatusOK, `{"tier":"pro"}`), nil
					}
					operations++
					return checkUploadPreparation(t, r, ""), nil
				})
				client := mustClient(t, xberg.WithBaseURL("https://uploads.example.test"), xberg.WithTarget(target), xberg.WithAPIKey("synthetic-upload-owner"), xberg.WithRetries(0), xberg.WithHTTPClient(&http.Client{Transport: transport}))
				ctx := xberg.WithProProject(context.Background(), " \t ")
				var err error
				if operation == "presign" {
					_, err = client.PresignUpload(ctx, json.RawMessage(uploadPresignBody))
				} else {
					_, err = client.ConfirmUpload(ctx, json.RawMessage(uploadConfirmBody))
				}
				wantOperations, wantProbes := 0, 0
				if target == xberg.TargetEnterprise {
					wantOperations = 1
					if err != nil {
						t.Fatalf("Enterprise must ignore selection: %v", err)
					}
				} else if err == nil || err.Error() != "xberg: Pro project ID must not be blank" {
					t.Fatalf("blank project error=%v", err)
				}
				if target == "" {
					wantProbes = 1
				}
				if probes != wantProbes || operations != wantOperations {
					t.Fatalf("probes=%d operations=%d want=%d/%d", probes, operations, wantProbes, wantOperations)
				}
			})
		}
	}
}

func TestSelectedProjectUploadsContextsDoNotLeak(t *testing.T) {
	type expectedProjectKey struct{}
	var calls atomic.Int32
	transport := jobPollTransport(func(r *http.Request) (*http.Response, error) {
		calls.Add(1)
		want, ok := r.Context().Value(expectedProjectKey{}).(string)
		if !ok {
			t.Error("request lost caller context")
		}
		return checkUploadPreparation(t, r, want), nil
	})
	client := mustClient(t, xberg.WithBaseURL("https://uploads.example.test"), xberg.WithTarget(xberg.TargetPro), xberg.WithAPIKey("synthetic-upload-owner"), xberg.WithRetries(0), xberg.WithHTTPClient(&http.Client{Transport: transport}))
	var group sync.WaitGroup
	for _, project := range []string{scopeProjectID, extractJobB, ""} {
		group.Go(func() {
			ctx := context.WithValue(context.Background(), expectedProjectKey{}, project)
			if project != "" {
				ctx = xberg.WithProProject(ctx, project)
			}
			presign, err := client.PresignUpload(ctx, json.RawMessage(uploadPresignBody))
			if err != nil || string(presign) != uploadPresignResponse {
				t.Errorf("presign=%s err=%v", presign, err)
			}
			confirm, err := client.ConfirmUpload(ctx, json.RawMessage(uploadConfirmBody))
			if err != nil || string(confirm) != uploadConfirmResponse {
				t.Errorf("confirm=%s err=%v", confirm, err)
			}
		})
	}
	group.Wait()
	if calls.Load() != 6 {
		t.Fatalf("calls=%d want=6", calls.Load())
	}
}

func TestUnscopedUploadsPreserveSharedSurfaceWithoutProbe(t *testing.T) {
	for _, target := range []xberg.Target{xberg.TargetPro, xberg.TargetEnterprise, ""} {
		t.Run(string(target), func(t *testing.T) {
			calls := 0
			transport := jobPollTransport(func(r *http.Request) (*http.Response, error) {
				calls++
				return checkUploadPreparation(t, r, ""), nil
			})
			client := mustClient(t, xberg.WithBaseURL("https://uploads.example.test"), xberg.WithTarget(target), xberg.WithAPIKey("synthetic-upload-owner"), xberg.WithRetries(0), xberg.WithHTTPClient(&http.Client{Transport: transport}))
			callUploadPreparation(t, client, context.Background())
			if calls != 2 {
				t.Fatalf("calls=%d want=2 without a probe", calls)
			}
		})
	}
}

func TestSelectedProjectLocalUploadKeepsCapabilityAndRawBytes(t *testing.T) {
	for _, target := range []xberg.Target{xberg.TargetPro, xberg.TargetEnterprise} {
		t.Run(string(target), func(t *testing.T) {
			calls := 0
			content := []byte{'T', 'X', 'T', 0, 255, '\n'}
			transport := jobPollTransport(func(r *http.Request) (*http.Response, error) {
				calls++
				wantPath := "/v1/uploads/local/" + scopeProjectID + "/synthetic-capability"
				if r.Method != http.MethodPut || r.URL.Path != wantPath || r.URL.RawQuery != "" || r.Header.Get("X-Project-ID") != "" {
					t.Errorf("capability request=%s %s project=%q", r.Method, r.URL, r.Header.Get("X-Project-ID"))
				}
				body, err := io.ReadAll(r.Body)
				if err != nil || !bytes.Equal(body, content) || r.Header.Get("Content-Type") != "application/octet-stream" {
					t.Errorf("raw body=%v content-type=%q err=%v", body, r.Header.Get("Content-Type"), err)
				}
				return uploadResponse(http.StatusNoContent, ""), nil
			})
			client := mustClient(t, xberg.WithBaseURL("https://uploads.example.test"), xberg.WithTarget(target), xberg.WithRetries(0), xberg.WithHTTPClient(&http.Client{Transport: transport}))
			err := client.PutLocalUpload(xberg.WithProProject(context.Background(), extractJobB), scopeProjectID, "synthetic-capability", content)
			wantCalls := 1
			if target == xberg.TargetEnterprise {
				wantCalls = 0
				var tierErr *xberg.TierError
				if !errors.As(err, &tierErr) || tierErr.Method != "PutLocalUpload" || tierErr.Required != "pro" {
					t.Fatalf("Enterprise error=%v", err)
				}
			} else if err != nil {
				t.Fatal(err)
			}
			if calls != wantCalls {
				t.Fatalf("calls=%d want=%d", calls, wantCalls)
			}
		})
	}
}
