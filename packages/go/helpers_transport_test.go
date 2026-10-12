package xberg_test

import (
	"context"
	"net/http"
	"net/http/httptest"
	"testing"
	"time"

	xberg "github.com/xberg-io/sdks/packages/go"
)

func TestMustClient_OwnsItsTransport(t *testing.T) {
	t.Parallel()
	first := mustClient(t, xberg.WithBaseURL("https://example.test"))
	second := mustClient(t, xberg.WithBaseURL("https://example.test"))
	firstTransport, ok := first.HTTPClient().Transport.(*http.Transport)
	if !ok {
		t.Fatalf("first transport = %T, want owned *http.Transport", first.HTTPClient().Transport)
	}
	secondTransport, ok := second.HTTPClient().Transport.(*http.Transport)
	if !ok {
		t.Fatalf("second transport = %T, want owned *http.Transport", second.HTTPClient().Transport)
	}
	if firstTransport == secondTransport || firstTransport == http.DefaultTransport || secondTransport == http.DefaultTransport {
		t.Fatal("test clients share a transport with each other or http.DefaultTransport")
	}
	if first.HTTPClient().Timeout != 30*time.Second {
		t.Fatalf("timeout = %v, want SDK default 30s", first.HTTPClient().Timeout)
	}
}

func TestMustClient_PreservesHTTPOptions(t *testing.T) {
	t.Parallel()
	custom := &http.Client{Timeout: time.Minute}
	client := mustClient(t, xberg.WithBaseURL("https://example.test"), xberg.WithHTTPClient(custom))
	if client.HTTPClient() != custom || client.HTTPClient().Timeout != time.Minute {
		t.Fatal("fixture transport defaults override explicit HTTP options")
	}
}

func TestMustClient_ConnectionSurvivesUnrelatedServerClosure(t *testing.T) {
	t.Parallel()
	var remoteAddresses []string
	server := httptest.NewServer(http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
		remoteAddresses = append(remoteAddresses, r.RemoteAddr)
		w.WriteHeader(http.StatusNoContent)
	}))
	defer server.Close()
	client := mustClient(t, xberg.WithBaseURL(server.URL))
	if err := client.DeleteRagCollection(context.Background(), "fixture"); err != nil {
		t.Fatal(err)
	}
	unrelated := httptest.NewServer(http.NotFoundHandler())
	unrelated.Close()
	if err := client.DeleteRagCollection(context.Background(), "fixture"); err != nil {
		t.Fatal(err)
	}
	if len(remoteAddresses) != 2 || remoteAddresses[0] != remoteAddresses[1] {
		t.Fatalf("fixture connection changed after unrelated server closure: %v", remoteAddresses)
	}
}
