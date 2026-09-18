package xberg_test

import (
	"context"
	"fmt"
	"net/http"
	"net/http/httptest"
	"strings"
	"sync"
	"sync/atomic"
	"testing"
	"time"

	xberg "github.com/xberg-io/sdks/packages/go"
)

// -- base-url policy ----------------------------------------------------------

func TestNew_EnterpriseRequiresBaseURL(t *testing.T) {
	t.Parallel()
	_, err := xberg.New(xberg.WithTarget(xberg.TargetEnterprise))
	if err == nil {
		t.Fatalf("New(WithTarget(Enterprise)) returned nil error, want a base-URL error")
	}
	if !strings.Contains(err.Error(), "no default base URL") {
		t.Errorf("error = %q, want it to mention 'no default base URL'", err.Error())
	}
}

func TestNew_NoTargetRequiresBaseURL(t *testing.T) {
	t.Parallel()
	_, err := xberg.New()
	if err == nil {
		t.Fatalf("New() returned nil error, want a base-URL error")
	}
	if !strings.Contains(err.Error(), "no default base URL") {
		t.Errorf("error = %q, want it to mention 'no default base URL'", err.Error())
	}
}

func TestNew_ProRequiresBaseURL(t *testing.T) {
	t.Parallel()
	_, err := xberg.New(xberg.WithTarget(xberg.TargetPro))
	if err == nil {
		t.Fatalf("New(WithTarget(Pro)) returned nil error, want a base-URL error")
	}
	if !strings.Contains(err.Error(), "no default base URL") {
		t.Errorf("error = %q, want it to mention 'no default base URL'", err.Error())
	}
}

func TestNew_ProAcceptsExplicitBaseURL(t *testing.T) {
	t.Parallel()
	client, err := xberg.New(xberg.WithTarget(xberg.TargetPro), xberg.WithBaseURL("https://pro.example.test"))
	if err != nil {
		t.Fatalf("New: %v", err)
	}
	if got := client.BaseURL(); got != "https://pro.example.test" {
		t.Errorf("BaseURL = %q, want the explicit Pro URL", got)
	}
}

func TestNew_ControlPlaneBaseURLDefaultsToTheDataPlane(t *testing.T) {
	t.Parallel()
	// Pro serves both planes from one binary, so a Pro client that never heard
	// of this option must keep addressing the control plane at its base URL.
	client, err := xberg.New(xberg.WithTarget(xberg.TargetPro), xberg.WithBaseURL("https://pro.example.test"))
	if err != nil {
		t.Fatalf("New: %v", err)
	}
	if got := client.ControlPlaneBaseURL(); got != client.BaseURL() {
		t.Errorf("ControlPlaneBaseURL = %q, want the data-plane URL %q", got, client.BaseURL())
	}
}

func TestNew_ControlPlaneBaseURLOverride(t *testing.T) {
	t.Parallel()
	// Enterprise splits the planes across two binaries, so the override must
	// move the control plane without disturbing the data plane.
	const controlPlane = "https://control.example.test:8081"
	client, err := xberg.New(
		xberg.WithTarget(xberg.TargetEnterprise),
		xberg.WithBaseURL("https://data.example.test:8080"),
		xberg.WithControlPlaneBaseURL(controlPlane),
	)
	if err != nil {
		t.Fatalf("New: %v", err)
	}
	if got := client.ControlPlaneBaseURL(); got != controlPlane {
		t.Errorf("ControlPlaneBaseURL = %q, want %q", got, controlPlane)
	}
	if got := client.BaseURL(); got != "https://data.example.test:8080" {
		t.Errorf("BaseURL = %q, want the untouched data-plane URL", got)
	}
}

// -- tier gating (explicit target) --------------------------------------------

func TestTierGate_ProOnlyMethodOnEnterpriseTarget(t *testing.T) {
	t.Parallel()
	// The base URL points at a server that fails the test if it is ever hit —
	// the gate must reject before any request is issued.
	server := httptest.NewServer(http.HandlerFunc(func(_ http.ResponseWriter, r *http.Request) {
		t.Errorf("unexpected HTTP call to %s; gate should short-circuit", r.URL.Path)
	}))
	defer server.Close()
	client := mustClient(t, xberg.WithBaseURL(server.URL), xberg.WithTarget(xberg.TargetEnterprise))
	_, err := client.Login(context.Background(), xberg.LoginRequest{IdToken: "x"})
	var tierErr *xberg.TierError
	if !asError(err, &tierErr) {
		t.Fatalf("expected TierError, got %T: %v", err, err)
	}
	if tierErr.Required != "pro" || tierErr.Actual != "enterprise" {
		t.Errorf("TierError = %+v, want required=pro actual=enterprise", tierErr)
	}
	if !strings.Contains(err.Error(), "not available on the \"enterprise\" tier") {
		t.Errorf("error = %q, want it to mention the enterprise tier", err.Error())
	}
}

func TestTierGate_EnterpriseOnlyMethodOnProTarget(t *testing.T) {
	t.Parallel()
	server := httptest.NewServer(http.HandlerFunc(func(_ http.ResponseWriter, r *http.Request) {
		t.Errorf("unexpected HTTP call to %s; gate should short-circuit", r.URL.Path)
	}))
	defer server.Close()
	client := mustClient(t, xberg.WithBaseURL(server.URL), xberg.WithTarget(xberg.TargetPro))
	err := enterpriseOnlyCall(client)
	var tierErr *xberg.TierError
	if !asError(err, &tierErr) {
		t.Fatalf("expected TierError, got %T: %v", err, err)
	}
	if tierErr.Required != "enterprise" || tierErr.Actual != "pro" {
		t.Errorf("TierError = %+v, want required=enterprise actual=pro", tierErr)
	}
}

func TestProMethod_LoginReachesEndpoint(t *testing.T) {
	t.Parallel()
	var called atomic.Bool
	server := httptest.NewServer(http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
		if r.URL.Path != "/auth/login" || r.Method != http.MethodPost {
			t.Errorf("unexpected request %s %s", r.Method, r.URL.Path)
		}
		called.Store(true)
		_, _ = w.Write([]byte(`{"token":"session-jwt","pending_invitations":0,` +
			`"user":{"id":"ffffffff-0000-4000-8000-000000000001","email":"a@b.test"}}`))
	}))
	defer server.Close()
	client := mustClient(t, xberg.WithBaseURL(server.URL), xberg.WithTarget(xberg.TargetPro))
	resp, err := client.Login(context.Background(), xberg.LoginRequest{IdToken: "verified"})
	if err != nil {
		t.Fatalf("Login: %v", err)
	}
	if !called.Load() {
		t.Errorf("server was not called")
	}
	if resp.Token != "session-jwt" {
		t.Errorf("Token = %q, want session-jwt", resp.Token)
	}
}

// TestSharedMethod_UsageReachesEndpointOnBothTiers pins that `/v1/usage` is
// reached on Pro as well as Enterprise. Both specs declare it, so the client
// must not gate it — a Pro caller used to get a TierError for an endpoint its
// own server was serving.
func TestSharedMethod_UsageReachesEndpointOnBothTiers(t *testing.T) {
	t.Parallel()
	for _, target := range []xberg.Target{xberg.TargetEnterprise, xberg.TargetPro} {
		t.Run(string(target), func(t *testing.T) {
			t.Parallel()
			server := httptest.NewServer(http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
				if r.URL.Path != "/v1/usage" {
					t.Errorf("path = %q, want /v1/usage", r.URL.Path)
				}
				_, _ = w.Write([]byte(`{"pages":42}`))
			}))
			defer server.Close()
			client := mustClient(t, xberg.WithBaseURL(server.URL), xberg.WithTarget(target))
			body, err := client.Usage(context.Background(), nil)
			if err != nil {
				t.Fatalf("Usage on %s: %v", target, err)
			}
			if !strings.Contains(string(body), `"pages":42`) {
				t.Errorf("body = %s, want it to contain pages=42", body)
			}
		})
	}
}

// -- tier gating (capability probe via /healthz) ------------------------------

// The tier-probe tests below need SOME Enterprise-only call as a vehicle for the
// gate; what the call does is irrelevant, only that Pro does not serve it.
//
// ~keep Usage used to play this role. Both specs declare `/v1/usage`, so it is
// no longer tier-gated and can no longer prove anything about the gate — every
// probe test built on it would pass vacuously. Versions
// (`/v1/documents/{id}/versions`) is absent from the Pro spec, so it is a sound
// stand-in; keep this vehicle Enterprise-only if it is ever swapped again.
const (
	tierProbeDocumentID   = "550e8400-e29b-41d4-a716-446655440000"
	tierProbeVersionsPath = "/v1/documents/" + tierProbeDocumentID + "/versions"
)

// enterpriseOnlyCall issues the Enterprise-only vehicle described above.
func enterpriseOnlyCall(client *xberg.Client) error {
	_, err := client.Versions(context.Background(), tierProbeDocumentID)
	return err
}

func TestTierProbe_DiscoversTierAndCaches(t *testing.T) {
	t.Parallel()
	var healthzCalls atomic.Int32
	server := httptest.NewServer(http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
		switch r.URL.Path {
		case "/healthz":
			healthzCalls.Add(1)
			_, _ = w.Write([]byte(`{"status":"ok","tier":"enterprise"}`))
		case tierProbeVersionsPath:
			_, _ = w.Write([]byte(`[]`))
		default:
			t.Errorf("unexpected request %s", r.URL.Path)
		}
	}))
	defer server.Close()
	// target omitted -> tier discovered from /healthz, then cached.
	client := mustClient(t, xberg.WithBaseURL(server.URL))
	for i := 0; i < 2; i++ {
		if err := enterpriseOnlyCall(client); err != nil {
			t.Fatalf("enterprise-only call %d: %v", i, err)
		}
	}
	if got := healthzCalls.Load(); got != 1 {
		t.Errorf("healthz probed %d times, want exactly 1 (cached)", got)
	}
}

func TestTierProbe_GatesWhenProbedTierMismatches(t *testing.T) {
	t.Parallel()
	server := httptest.NewServer(http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
		if r.URL.Path == tierProbeVersionsPath {
			t.Errorf("the enterprise-only endpoint must not be hit when the probed tier is pro")
		}
		_, _ = w.Write([]byte(`{"status":"ok","tier":"pro"}`))
	}))
	defer server.Close()
	client := mustClient(t, xberg.WithBaseURL(server.URL))
	err := enterpriseOnlyCall(client)
	var tierErr *xberg.TierError
	if !asError(err, &tierErr) {
		t.Fatalf("expected TierError, got %T: %v", err, err)
	}
	if tierErr.Actual != "pro" {
		t.Errorf("TierError.Actual = %q, want pro", tierErr.Actual)
	}
}

// TestTierProbe_MissingTierIsRetryable proves a /healthz response that omits
// (or empties) the tier field is treated as a failed probe rather than being
// cached as an unusable "" tier: the first call errors, and the probe is
// retried (and succeeds) once /healthz starts reporting a real tier.
func TestTierProbe_MissingTierIsRetryable(t *testing.T) {
	t.Parallel()
	var reportedTier atomic.Value
	reportedTier.Store("")
	server := httptest.NewServer(http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
		switch r.URL.Path {
		case "/healthz":
			fmt.Fprintf(w, `{"status":"ok","tier":%q}`, reportedTier.Load().(string))
		case tierProbeVersionsPath:
			_, _ = w.Write([]byte(`[]`))
		default:
			t.Errorf("unexpected request %s", r.URL.Path)
		}
	}))
	defer server.Close()
	client := mustClient(t, xberg.WithBaseURL(server.URL))

	if err := enterpriseOnlyCall(client); err == nil {
		t.Fatalf("enterprise-only call with no tier in /healthz returned nil error, want an error")
	}
	reportedTier.Store("enterprise")
	if err := enterpriseOnlyCall(client); err != nil {
		t.Fatalf("enterprise-only call after /healthz reports a tier: %v, want the probe to retry and succeed", err)
	}
}

// TestTierProbe_UnknownTierIsRetryable is the same shape as
// TestTierProbe_MissingTierIsRetryable but for a /healthz response reporting a
// tier value the specs do not define.
func TestTierProbe_UnknownTierIsRetryable(t *testing.T) {
	t.Parallel()
	var reportedTier atomic.Value
	reportedTier.Store("quantum")
	server := httptest.NewServer(http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
		switch r.URL.Path {
		case "/healthz":
			fmt.Fprintf(w, `{"status":"ok","tier":%q}`, reportedTier.Load().(string))
		case tierProbeVersionsPath:
			_, _ = w.Write([]byte(`[]`))
		default:
			t.Errorf("unexpected request %s", r.URL.Path)
		}
	}))
	defer server.Close()
	client := mustClient(t, xberg.WithBaseURL(server.URL))

	if err := enterpriseOnlyCall(client); err == nil {
		t.Fatalf("enterprise-only call with an unrecognized tier returned nil error, want an error")
	}
	reportedTier.Store("enterprise")
	if err := enterpriseOnlyCall(client); err != nil {
		t.Fatalf("enterprise-only call after /healthz reports a recognized tier: %v, want the probe to retry and succeed", err)
	}
}

// TestTierProbe_ConcurrentCallersIssueOneRequest proves concurrent resolveTier
// callers racing an unset target share one in-flight /healthz probe instead of
// each issuing their own request.
func TestTierProbe_ConcurrentCallersIssueOneRequest(t *testing.T) {
	t.Parallel()
	var healthzCalls atomic.Int32
	release := make(chan struct{})
	server := httptest.NewServer(http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
		switch r.URL.Path {
		case "/healthz":
			healthzCalls.Add(1)
			<-release // hold the single request open so racing callers pile up
			_, _ = w.Write([]byte(`{"status":"ok","tier":"enterprise"}`))
		case tierProbeVersionsPath:
			_, _ = w.Write([]byte(`[]`))
		default:
			t.Errorf("unexpected request %s", r.URL.Path)
		}
	}))
	defer server.Close()
	client := mustClient(t, xberg.WithBaseURL(server.URL))

	const goroutines = 20
	start := make(chan struct{})
	var waitGroup sync.WaitGroup
	errs := make([]error, goroutines)
	for i := 0; i < goroutines; i++ {
		waitGroup.Add(1)
		go func(idx int) {
			defer waitGroup.Done()
			<-start
			errs[idx] = enterpriseOnlyCall(client)
		}(i)
	}
	close(start)
	// Give every goroutine a chance to reach resolveTier before the single
	// in-flight /healthz request is released, so the race window is real.
	time.Sleep(50 * time.Millisecond)
	close(release)
	waitGroup.Wait()

	for i, err := range errs {
		if err != nil {
			t.Errorf("goroutine %d: enterprise-only call returned error: %v", i, err)
		}
	}
	if got := healthzCalls.Load(); got != 1 {
		t.Errorf("/healthz called %d times under concurrent callers, want exactly 1", got)
	}
}
