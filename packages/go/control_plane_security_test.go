package xberg

import (
	"context"
	"encoding/json"
	"errors"
	"io"
	"net/http"
	"net/http/httptest"
	"strings"
	"testing"
	"time"
)

func TestControlPlaneTokenFallbackAndExplicitEmpty(t *testing.T) {
	for _, explicit := range []bool{false, true} {
		t.Run(map[bool]string{false: "fallback", true: "empty"}[explicit], func(t *testing.T) {
			control := httptest.NewServer(http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
				want := "Bearer data"
				if explicit {
					want = ""
				}
				if r.Header.Get("Authorization") != want {
					t.Errorf("authorization %q; want %q", r.Header.Get("Authorization"), want)
				}
				_, _ = io.WriteString(w, `{"name":"decoded"}`)
			}))
			defer control.Close()
			options := []Option{WithBaseURL(control.URL), WithAPIKey("data"), WithTarget(TargetEnterprise)}
			if explicit {
				options = append(options, WithControlPlaneToken(""))
			}
			c, _ := New(options...)
			got, err := c.GetProject(context.Background(), "p")
			if err != nil || got.Name != "decoded" {
				t.Fatalf("project %v %v", got, err)
			}
		})
	}
}

func TestBackendIntegrationUsesEnterpriseRequestShape(t *testing.T) {
	control := httptest.NewServer(http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
		var body map[string]any
		if err := json.NewDecoder(r.Body).Decode(&body); err != nil {
			t.Fatal(err)
		}
		if body["client_id"] != "client" || body["auth_type"] != "oauth2" {
			t.Errorf("body %v", body)
		}
		_, _ = io.WriteString(w, `{}`)
	}))
	defer control.Close()
	c, _ := New(WithBaseURL(control.URL), WithTarget(TargetEnterprise))
	clientID := "client"
	_, err := c.BackendCreateIntegration(context.Background(), "p", BackendCreateIntegrationRequest{AuthType: "oauth2", ClientId: &clientID})
	if err != nil {
		t.Fatal(err)
	}
}

func TestControlPlaneReturnsTypedErrors(t *testing.T) {
	control := httptest.NewServer(http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
		w.WriteHeader(http.StatusUnauthorized)
		_, _ = io.WriteString(w, `{"message":"denied"}`)
	}))
	defer control.Close()
	c, _ := New(WithBaseURL(control.URL), WithTarget(TargetEnterprise))
	_, err := c.GetProject(context.Background(), "p")
	var auth *AuthError
	if !errors.As(err, &auth) {
		t.Fatalf("got %T %v; want AuthError", err, err)
	}
}

func TestControlPlaneCancellationAndProGate(t *testing.T) {
	control := httptest.NewServer(http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) { <-r.Context().Done() }))
	defer control.Close()
	c, _ := New(WithBaseURL(control.URL), WithTarget(TargetEnterprise), WithTimeout(10*time.Millisecond))
	_, err := c.GetProject(context.Background(), "p")
	if !errors.Is(err, context.DeadlineExceeded) {
		t.Fatalf("deadline error %v", err)
	}
	pro, _ := New(WithBaseURL(control.URL), WithTarget(TargetPro))
	_, err = pro.GetProject(context.Background(), "p")
	var tier *TierError
	if !errors.As(err, &tier) {
		t.Fatalf("tier error %v", err)
	}
}

func TestOAuthConnectionErrorDoesNotExposeCodeOrState(t *testing.T) {
	c, _ := New(WithBaseURL("http://127.0.0.1:1"), WithTarget(TargetEnterprise))
	_, err := c.OAuthCallback(context.Background(), "private-code", "private-state")
	if err == nil || strings.Contains(err.Error(), "private-") {
		t.Fatalf("unsafe error %v", err)
	}
}

func TestOAuthInvalidOriginDoesNotExposeCodeOrState(t *testing.T) {
	c, _ := New(WithBaseURL(":invalid"), WithTarget(TargetEnterprise))
	_, err := c.OAuthCallback(context.Background(), "private-code", "private-state")
	if err == nil || strings.Contains(err.Error(), "private-") {
		t.Fatalf("unsafe construction error %v", err)
	}
}
