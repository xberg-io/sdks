package xberg

import (
	"context"
	"encoding/json"
	"io"
	"net/http"
	"net/http/httptest"
	"testing"
)

func TestControlPlaneUserProfile(t *testing.T) {
	for _, method := range []string{http.MethodGet, http.MethodPatch} {
		t.Run(method, func(t *testing.T) {
			requests := 0
			control := httptest.NewServer(http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
				requests++
				if r.Method != method || r.URL.Path != "/auth/profile" {
					t.Errorf("request = %s %s", r.Method, r.URL.Path)
				}
				if r.Header.Get("Authorization") != "Bearer control-token" {
					t.Errorf("Authorization = %q", r.Header.Get("Authorization"))
				}
				if method == http.MethodPatch {
					var body map[string]string
					if err := json.NewDecoder(r.Body).Decode(&body); err != nil {
						t.Error(err)
						return
					}
					if len(body) != 1 || body["display_name"] != "Updated" {
						t.Errorf("body = %v", body)
					}
				} else if body, err := io.ReadAll(r.Body); err != nil || len(body) != 0 {
					t.Errorf("GET body = %q, error = %v", body, err)
				}
				w.Header().Set("Content-Type", "application/json")
				_, _ = io.WriteString(w, `{"user_id":"user-123","email":"profile@example.test","display_name":"Updated"}`)
			}))
			defer control.Close()
			client, err := New(WithBaseURL("http://127.0.0.1:1"), WithControlPlaneBaseURL(control.URL), WithAPIKey("data-key"), WithControlPlaneToken("control-token"), WithTarget(TargetEnterprise))
			if err != nil {
				t.Fatal(err)
			}
			var profile *UserProfileResponse
			if method == http.MethodGet {
				profile, err = client.GetUserProfile(context.Background())
			} else {
				profile, err = client.UpdateUserProfile(context.Background(), UpdateUserProfileRequest{DisplayName: "Updated"})
			}
			if err != nil {
				t.Fatal(err)
			}
			if requests != 1 || profile.UserId != "user-123" || profile.Email == nil || *profile.Email != "profile@example.test" || profile.DisplayName == nil || *profile.DisplayName != "Updated" {
				t.Fatalf("requests = %d; profile = %+v", requests, profile)
			}
		})
	}
}
