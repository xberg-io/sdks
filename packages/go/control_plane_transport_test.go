package xberg

import (
	"context"
	"net/http"
	"net/http/httptest"
	"testing"
)

func TestControlPlaneUsesSeparateOriginAndToken(t *testing.T) {
	data := httptest.NewServer(http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
		t.Error("control request reached data plane")
		w.WriteHeader(http.StatusInternalServerError)
	}))
	defer data.Close()
	control := httptest.NewServer(http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
		if got := r.Header.Get("Authorization"); got != "Bearer control" {
			t.Errorf("authorization = %q", got)
		}
		if r.URL.Path != "/auth/account" || r.Method != http.MethodDelete {
			t.Errorf("request = %s %s", r.Method, r.URL.Path)
		}
		w.WriteHeader(http.StatusNoContent)
	}))
	defer control.Close()
	client, err := New(WithBaseURL(data.URL), WithControlPlaneBaseURL(control.URL), WithAPIKey("data"), WithControlPlaneToken("control"), WithTarget(TargetEnterprise))
	if err != nil {
		t.Fatal(err)
	}
	if err = client.DeleteAccount(context.Background()); err != nil {
		t.Fatal(err)
	}
}
