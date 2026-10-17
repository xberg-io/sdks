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

const proHealthJSON = `{"status":"ok","tier":"pro","license":{"state":"grace"},"rag":{"enabled":false},"auto_tune":{"enabled":true},"future_field":"ignored"}`

func assertProHealth(t *testing.T, result *xberg.ProHealthResponse, err error) {
	t.Helper()
	if err != nil {
		t.Fatal(err)
	}
	if result == nil {
		t.Fatal("nil health response")
	}
	if result.Status != "ok" || result.Tier != "pro" || result.License.State != "grace" ||
		result.Rag.Enabled || !result.AutoTune.Enabled {
		t.Fatalf("incomplete Pro health: %+v", result)
	}
}

func TestProHealthUsesDataOriginAndTypedResponse(t *testing.T) {
	var calls atomic.Int32
	data := httptest.NewServer(http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
		calls.Add(1)
		if r.Method != "GET" || r.RequestURI != "/healthz" || r.Header.Get("Authorization") != "Bearer data-key" {
			t.Errorf("unexpected request: %s %s auth=%q", r.Method, r.RequestURI, r.Header.Get("Authorization"))
		}
		_, _ = w.Write([]byte(proHealthJSON))
	}))
	defer data.Close()
	backend := httptest.NewServer(http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
		t.Error("Pro health reached backend origin")
		w.WriteHeader(http.StatusInternalServerError)
	}))
	defer backend.Close()
	client, err := xberg.New(xberg.WithBaseURL(data.URL), xberg.WithControlPlaneBaseURL(backend.URL),
		xberg.WithAPIKey("data-key"), xberg.WithControlPlaneToken("backend-key"), xberg.WithTarget(xberg.TargetPro))
	if err != nil {
		t.Fatal(err)
	}
	result, err := client.ProHealthz(context.Background())
	assertProHealth(t, result, err)
	if calls.Load() != 1 {
		t.Fatalf("calls = %d; want 1", calls.Load())
	}
}

func TestProHealthAllowsUnauthenticatedRead(t *testing.T) {
	var calls atomic.Int32
	server := httptest.NewServer(http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
		calls.Add(1)
		if r.Header.Get("Authorization") != "" {
			t.Error("backend credential leaked to public Pro health")
		}
		_, _ = w.Write([]byte(proHealthJSON))
	}))
	defer server.Close()
	client, err := xberg.New(xberg.WithBaseURL(server.URL), xberg.WithTarget(xberg.TargetPro),
		xberg.WithControlPlaneToken("backend-key"))
	if err != nil {
		t.Fatal(err)
	}
	result, err := client.ProHealthz(context.Background())
	assertProHealth(t, result, err)
	if calls.Load() != 1 {
		t.Fatalf("calls = %d; want 1", calls.Load())
	}
}

func TestProHealthRejectsEnterpriseWithoutHTTP(t *testing.T) {
	var calls atomic.Int32
	server := httptest.NewServer(http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) { calls.Add(1) }))
	defer server.Close()
	client, err := xberg.New(xberg.WithBaseURL(server.URL), xberg.WithTarget(xberg.TargetEnterprise))
	if err != nil {
		t.Fatal(err)
	}
	_, err = client.ProHealthz(context.Background())
	var tier *xberg.TierError
	if !errors.As(err, &tier) || tier.Required != "pro" || tier.Actual != "enterprise" {
		t.Fatalf("error = %v; want Pro TierError", err)
	}
	if calls.Load() != 0 {
		t.Fatalf("calls = %d; want 0", calls.Load())
	}
}

func TestProHealthAutomaticTargetProbesOnceThenFetchesFresh(t *testing.T) {
	for _, tier := range []string{"pro", "enterprise"} {
		t.Run(tier, func(t *testing.T) {
			var calls atomic.Int32
			server := httptest.NewServer(http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
				calls.Add(1)
				if tier == "pro" {
					_, _ = w.Write([]byte(proHealthJSON))
					return
				}
				_, _ = w.Write([]byte(`{"status":"ok","tier":"enterprise"}`))
			}))
			defer server.Close()
			client, err := xberg.New(xberg.WithBaseURL(server.URL))
			if err != nil {
				t.Fatal(err)
			}
			result, err := client.ProHealthz(context.Background())
			if tier == "enterprise" {
				var mismatch *xberg.TierError
				if !errors.As(err, &mismatch) {
					t.Fatalf("error = %v; want TierError", err)
				}
				if calls.Load() != 1 {
					t.Fatalf("calls = %d; want 1", calls.Load())
				}
				return
			}
			assertProHealth(t, result, err)
			if calls.Load() != 2 {
				t.Fatalf("calls = %d; want probe + health", calls.Load())
			}
			result, err = client.ProHealthz(context.Background())
			assertProHealth(t, result, err)
			if calls.Load() != 3 {
				t.Fatalf("calls = %d; want 3", calls.Load())
			}
		})
	}
}

func assertProHealthHTTPError(t *testing.T, status int, err error) {
	t.Helper()
	var api *xberg.XbergError
	if !errors.As(err, &api) || api.Status != status {
		t.Fatalf("error = %v; want HTTP %d", err, status)
	}
	switch status {
	case 401:
		var typed *xberg.AuthError
		if !errors.As(err, &typed) {
			t.Fatalf("error = %T; want AuthError", err)
		}
	case 404:
		var typed *xberg.NotFoundError
		if !errors.As(err, &typed) {
			t.Fatalf("error = %T; want NotFoundError", err)
		}
	case 503:
		var typed *xberg.ServerError
		if !errors.As(err, &typed) {
			t.Fatalf("error = %T; want ServerError", err)
		}
	}
}

func TestProHealthPreservesHTTPErrorsAndRetryPolicy(t *testing.T) {
	for _, status := range []int{401, 404, 503} {
		t.Run(http.StatusText(status), func(t *testing.T) {
			var calls atomic.Int32
			server := httptest.NewServer(http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
				calls.Add(1)
				w.WriteHeader(status)
				_, _ = w.Write([]byte(`{"message":"unavailable"}`))
			}))
			defer server.Close()
			client, err := xberg.New(xberg.WithBaseURL(server.URL), xberg.WithTarget(xberg.TargetPro), xberg.WithRetries(0))
			if err != nil {
				t.Fatal(err)
			}
			_, err = client.ProHealthz(context.Background())
			assertProHealthHTTPError(t, status, err)
			if calls.Load() != 1 {
				t.Fatalf("calls = %d; want 1", calls.Load())
			}
		})
	}
}

func TestProHealthRetriesTransientFailure(t *testing.T) {
	var calls atomic.Int32
	server := httptest.NewServer(http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
		if calls.Add(1) == 1 {
			w.WriteHeader(503)
			_, _ = w.Write([]byte(`{"message":"unavailable"}`))
			return
		}
		_, _ = w.Write([]byte(proHealthJSON))
	}))
	defer server.Close()
	client, err := xberg.New(xberg.WithBaseURL(server.URL), xberg.WithTarget(xberg.TargetPro), xberg.WithRetries(1))
	if err != nil {
		t.Fatal(err)
	}
	result, err := client.ProHealthz(context.Background())
	assertProHealth(t, result, err)
	if calls.Load() != 2 {
		t.Fatalf("calls = %d; want 2", calls.Load())
	}
}

func TestProHealthPreservesExistingEnterpriseHealthContract(t *testing.T) {
	var dataCalls, backendCalls atomic.Int32
	data := httptest.NewServer(http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) { dataCalls.Add(1) }))
	defer data.Close()
	backend := httptest.NewServer(http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
		backendCalls.Add(1)
		if r.RequestURI != "/healthz" || r.Header.Get("Authorization") != "" {
			t.Error("changed backend health request")
		}
		_, _ = w.Write([]byte(`{"status":"ok","tier":"enterprise"}`))
	}))
	defer backend.Close()
	client, err := xberg.New(xberg.WithBaseURL(data.URL), xberg.WithControlPlaneBaseURL(backend.URL),
		xberg.WithAPIKey("data-key"), xberg.WithControlPlaneToken("backend-key"), xberg.WithTarget(xberg.TargetEnterprise))
	if err != nil {
		t.Fatal(err)
	}
	var result *xberg.BackendHealthResponse
	result, err = client.Healthz(context.Background())
	if err != nil || result == nil || result.Tier != "enterprise" || result.Status != "ok" {
		t.Fatalf("health=%+v err=%v", result, err)
	}
	pro, err := xberg.New(xberg.WithBaseURL(data.URL), xberg.WithTarget(xberg.TargetPro))
	if err != nil {
		t.Fatal(err)
	}
	_, err = pro.Healthz(context.Background())
	var tier *xberg.TierError
	if !errors.As(err, &tier) {
		t.Fatalf("error = %v; want TierError", err)
	}
	if dataCalls.Load() != 0 || backendCalls.Load() != 1 {
		t.Fatalf("data=%d backend=%d", dataCalls.Load(), backendCalls.Load())
	}
}
