package xberg_test

import (
	"context"
	"errors"
	"net/http"
	"testing"

	xberg "github.com/xberg-io/sdks/packages/go"
)

func TestGetIntegrationSyncReadsPersistedState(t *testing.T) {
	var seen recordedRequest
	c := proClient(t, http.StatusOK, `{"enabled":false,"interval_seconds":900}`, &seen)
	out, err := c.GetIntegrationSync(context.Background(), testProjectID, testIntegrationID)
	if err != nil {
		t.Fatal(err)
	}
	if out.Enabled || out.IntervalSeconds != 900 {
		t.Fatalf("state=%+v", out)
	}
	want := "/v1/projects/" + testProjectID + "/integrations/" + testIntegrationID + "/sync"
	if seen.method != "GET" || seen.path != want || seen.query != "" {
		t.Fatalf("request=%+v", seen)
	}
}

func TestSetIntegrationSyncSendsPreferenceAndAcceptsEmpty204(t *testing.T) {
	for _, enabled := range []bool{true, false} {
		t.Run(map[bool]string{true: "enabled", false: "disabled"}[enabled], func(t *testing.T) {
			var seen recordedRequest
			c := proClient(t, http.StatusNoContent, "", &seen)
			err := c.SetIntegrationSync(context.Background(), testProjectID, testIntegrationID, xberg.SetIntegrationSyncRequest{Enabled: enabled})
			if err != nil {
				t.Fatal(err)
			}
			want := `{"enabled":false}`
			if enabled {
				want = `{"enabled":true}`
			}
			if seen.method != "PUT" || seen.body != want || seen.contentType != "application/json" {
				t.Fatalf("request=%+v", seen)
			}
		})
	}
}

func TestIntegrationSyncPropagatesNotFound(t *testing.T) {
	for _, method := range []string{"get", "set"} {
		t.Run(method, func(t *testing.T) {
			var seen recordedRequest
			c := proClient(t, http.StatusNotFound, `{"message":"missing"}`, &seen)
			var err error
			if method == "get" {
				_, err = c.GetIntegrationSync(context.Background(), testProjectID, testIntegrationID)
			} else {
				err = c.SetIntegrationSync(context.Background(), testProjectID, testIntegrationID, xberg.SetIntegrationSyncRequest{Enabled: true})
			}
			var notFound *xberg.NotFoundError
			if !errors.As(err, &notFound) || notFound.Status != 404 {
				t.Fatalf("error=%v", err)
			}
		})
	}
}

func TestIntegrationSyncRefusesEnterpriseBeforeHTTP(t *testing.T) {
	c := mustClient(t, xberg.WithBaseURL(newRefusingServer(t)), xberg.WithTarget(xberg.TargetEnterprise))
	_, getErr := c.GetIntegrationSync(context.Background(), testProjectID, testIntegrationID)
	setErr := c.SetIntegrationSync(context.Background(), testProjectID, testIntegrationID, xberg.SetIntegrationSyncRequest{Enabled: true})
	for _, err := range []error{getErr, setErr} {
		var tier *xberg.TierError
		if !errors.As(err, &tier) {
			t.Fatalf("error=%v", err)
		}
	}
}
