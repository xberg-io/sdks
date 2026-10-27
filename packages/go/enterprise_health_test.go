package xberg_test

import (
	"context"
	"errors"
	"net/http"
	"net/http/httptest"
	"sync/atomic"
	"testing"

	xberg "github.com/xberg-io/sdks/packages/go"
)

func feature(enabled bool) *xberg.EnterpriseFeature {
	return &xberg.EnterpriseFeature{Enabled: enabled}
}

func TestEnterpriseHealthz_DecodesLeniently(t *testing.T) {
	t.Parallel()
	cases := []struct {
		name          string
		body          string
		wantStatus    string
		wantTier      string
		wantRag       *xberg.EnterpriseFeature
		wantAutoTune  *xberg.EnterpriseFeature
		wantDataRooms *xberg.EnterpriseFeature
	}{
		{
			name: "current server",
			body: `{"status":"ok","tier":"enterprise","rag":{"enabled":true},"auto_tune":{"enabled":true},` +
				`"data_rooms":{"enabled":false}}`,
			wantStatus: "ok", wantTier: "enterprise",
			wantRag: feature(true), wantAutoTune: feature(true), wantDataRooms: feature(false),
		},
		{
			name:       "server older than data rooms",
			body:       `{"status":"ok","tier":"enterprise","rag":{"enabled":true},"auto_tune":{"enabled":true}}`,
			wantStatus: "ok", wantTier: "enterprise", wantRag: feature(true), wantAutoTune: feature(true),
		},
		{
			name: "malformed and null features are dropped, unknown fields ignored",
			body: `{"status":"ok","tier":"enterprise","rag":true,"auto_tune":null,"data_rooms":{"enabled":true},` +
				`"future":{"x":1}}`,
			wantStatus: "ok", wantTier: "enterprise", wantDataRooms: feature(true),
		},
	}
	for _, tc := range cases {
		t.Run(tc.name, func(t *testing.T) {
			t.Parallel()
			server := httptest.NewServer(http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
				if r.Method != http.MethodGet || r.URL.Path != "/healthz" {
					t.Errorf("request = %s %s, want GET /healthz", r.Method, r.URL.Path)
				}
				_, _ = w.Write([]byte(tc.body))
			}))
			defer server.Close()
			client := mustClient(t, xberg.WithBaseURL(server.URL), xberg.WithTarget(xberg.TargetEnterprise))
			health, err := client.EnterpriseHealthz(context.Background())
			if err != nil {
				t.Fatalf("EnterpriseHealthz: %v", err)
			}
			if health.Status != tc.wantStatus || health.Tier != tc.wantTier {
				t.Errorf("Status, Tier = %q, %q; want %q, %q", health.Status, health.Tier, tc.wantStatus, tc.wantTier)
			}
			assertFeature(t, "Rag", health.Rag, tc.wantRag)
			assertFeature(t, "AutoTune", health.AutoTune, tc.wantAutoTune)
			assertFeature(t, "DataRooms", health.DataRooms, tc.wantDataRooms)
			if string(health.Raw) != tc.body {
				t.Errorf("Raw = %s, want the response body", health.Raw)
			}
		})
	}
}

func assertFeature(t *testing.T, name string, got, want *xberg.EnterpriseFeature) {
	t.Helper()
	switch {
	case want == nil && got != nil:
		t.Errorf("%s = %+v, want nil", name, *got)
	case want != nil && got == nil:
		t.Errorf("%s = nil, want %+v", name, *want)
	case want != nil && got.Enabled != want.Enabled:
		t.Errorf("%s.Enabled = %v, want %v", name, got.Enabled, want.Enabled)
	}
}

func TestEnterpriseHealthz_RejectsProBeforeRequest(t *testing.T) {
	t.Parallel()
	var calls atomic.Int32
	server := httptest.NewServer(http.HandlerFunc(func(http.ResponseWriter, *http.Request) { calls.Add(1) }))
	defer server.Close()
	client := mustClient(t, xberg.WithBaseURL(server.URL), xberg.WithTarget(xberg.TargetPro))
	_, err := client.EnterpriseHealthz(context.Background())
	var tier *xberg.TierError
	if !errors.As(err, &tier) || tier.Method != "EnterpriseHealthz" || tier.Required != "enterprise" {
		t.Fatalf("error = %v, want TierError for EnterpriseHealthz requiring enterprise", err)
	}
	if calls.Load() != 0 {
		t.Errorf("server saw %d requests, want 0", calls.Load())
	}
}

func TestTypedUploads_DecodeGeneratedModels(t *testing.T) {
	t.Parallel()
	const presign = `{"batch_id":"00000000-0000-4000-8000-000000000003","uploads":[{"job_id":` +
		`"550e8400-e29b-41d4-a716-446655440000","upload_url":"https://storage.example/u","object_key":"k/a.pdf",` +
		`"method":"PUT","expires_in_secs":900}]}`
	const confirm = `{"job_ids":["550e8400-e29b-41d4-a716-446655440000"],"status":"queued"}`
	server := httptest.NewServer(http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
		switch {
		case r.Method == http.MethodPost && r.URL.Path == "/v1/uploads/presign":
			_, _ = w.Write([]byte(presign))
		case r.Method == http.MethodPost && r.URL.Path == "/v1/uploads/confirm":
			w.WriteHeader(http.StatusAccepted)
			_, _ = w.Write([]byte(confirm))
		default:
			t.Errorf("unexpected request %s %s", r.Method, r.URL.Path)
		}
	}))
	defer server.Close()
	client := mustClient(t, xberg.WithBaseURL(server.URL))
	ctx := context.Background()

	presigned, err := client.PresignUploadTyped(ctx, xberg.PresignUploadRequest{
		Documents: []xberg.PresignDocumentInput{{Filename: "a.pdf", MimeType: "application/pdf"}},
	})
	if err != nil {
		t.Fatalf("PresignUploadTyped: %v", err)
	}
	if presigned.BatchId.String() != "00000000-0000-4000-8000-000000000003" || len(presigned.Uploads) != 1 {
		t.Fatalf("presign = %+v", presigned)
	}
	upload := presigned.Uploads[0]
	if upload.JobId.String() != "550e8400-e29b-41d4-a716-446655440000" || upload.UploadUrl != "https://storage.example/u" ||
		upload.ObjectKey != "k/a.pdf" || upload.Method != "PUT" || upload.ExpiresInSecs != 900 {
		t.Errorf("upload = %+v", upload)
	}

	confirmed, err := client.ConfirmUploadTyped(ctx, xberg.ConfirmUploadRequest{BatchId: presigned.BatchId})
	if err != nil {
		t.Fatalf("ConfirmUploadTyped: %v", err)
	}
	if len(confirmed.JobIds) != 1 || confirmed.JobIds[0] != "550e8400-e29b-41d4-a716-446655440000" ||
		confirmed.Status != "queued" {
		t.Errorf("confirm = %+v", confirmed)
	}
}
