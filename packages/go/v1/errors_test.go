package kreuzbergcloud_test

import (
	"context"
	"net/http"
	"net/http/httptest"
	"strings"
	"testing"
	"time"

	kreuzbergcloud "github.com/xberg-io/kreuzberg-cloud-sdk/go/v1"
)

func TestError_AuthErrorOn401(t *testing.T) {
	t.Parallel()
	server := newStatusServer(http.StatusUnauthorized, `{"error":"missing token"}`, nil)
	defer server.Close()
	client := mustClient(t, kreuzbergcloud.WithBaseURL(server.URL))
	_, err := client.GetJob(context.Background(), "any")
	var auth *kreuzbergcloud.AuthError
	if !asError(err, &auth) {
		t.Fatalf("expected AuthError, got %T: %v", err, err)
	}
	if !strings.Contains(auth.Message, "missing token") {
		t.Errorf("Message = %q, want it to contain 'missing token'", auth.Message)
	}
}

func TestError_AuthErrorOn403(t *testing.T) {
	t.Parallel()
	server := newStatusServer(http.StatusForbidden, `{"error":"forbidden"}`, nil)
	defer server.Close()
	client := mustClient(t, kreuzbergcloud.WithBaseURL(server.URL))
	_, err := client.GetJob(context.Background(), "any")
	var auth *kreuzbergcloud.AuthError
	if !asError(err, &auth) {
		t.Fatalf("expected AuthError, got %T: %v", err, err)
	}
}

func TestError_ValidationErrorOn400(t *testing.T) {
	t.Parallel()
	server := newStatusServer(http.StatusBadRequest, `{"error":"bad"}`, nil)
	defer server.Close()
	client := mustClient(t, kreuzbergcloud.WithBaseURL(server.URL))
	_, err := client.GetJob(context.Background(), "any")
	var validation *kreuzbergcloud.ValidationError
	if !asError(err, &validation) {
		t.Fatalf("expected ValidationError, got %T: %v", err, err)
	}
}

func TestError_ValidationErrorOn422(t *testing.T) {
	t.Parallel()
	server := newStatusServer(http.StatusUnprocessableEntity, `{"error":"unprocessable"}`, nil)
	defer server.Close()
	client := mustClient(t, kreuzbergcloud.WithBaseURL(server.URL))
	_, err := client.GetJob(context.Background(), "any")
	var validation *kreuzbergcloud.ValidationError
	if !asError(err, &validation) {
		t.Fatalf("expected ValidationError, got %T: %v", err, err)
	}
}

func TestError_NotFoundErrorOn404(t *testing.T) {
	t.Parallel()
	server := newStatusServer(http.StatusNotFound, `{"error":"missing"}`, nil)
	defer server.Close()
	client := mustClient(t, kreuzbergcloud.WithBaseURL(server.URL))
	_, err := client.GetJob(context.Background(), "any")
	var notFound *kreuzbergcloud.NotFoundError
	if !asError(err, &notFound) {
		t.Fatalf("expected NotFoundError, got %T: %v", err, err)
	}
}

func TestError_RateLimitErrorOn429WithRetryAfter(t *testing.T) {
	t.Parallel()
	server := newStatusServer(
		http.StatusTooManyRequests,
		`{"error":"slow down"}`,
		http.Header{"Retry-After": []string{"3"}},
	)
	defer server.Close()
	client := mustClient(t, kreuzbergcloud.WithBaseURL(server.URL))
	_, err := client.GetJob(context.Background(), "any")
	var rate *kreuzbergcloud.RateLimitError
	if !asError(err, &rate) {
		t.Fatalf("expected RateLimitError, got %T: %v", err, err)
	}
	if rate.RetryAfter != 3*time.Second {
		t.Errorf("RetryAfter = %v, want 3s", rate.RetryAfter)
	}
}

func TestError_ServerErrorOn500(t *testing.T) {
	t.Parallel()
	server := newStatusServer(http.StatusInternalServerError, `{"error":"oops"}`, nil)
	defer server.Close()
	client := mustClient(t, kreuzbergcloud.WithBaseURL(server.URL))
	_, err := client.GetJob(context.Background(), "any")
	var srv *kreuzbergcloud.ServerError
	if !asError(err, &srv) {
		t.Fatalf("expected ServerError, got %T: %v", err, err)
	}
}

func TestError_BasePropertiesAccessibleViaUnwrap(t *testing.T) {
	t.Parallel()
	server := newStatusServer(http.StatusBadRequest, `{"error":"bad"}`, nil)
	defer server.Close()
	client := mustClient(t, kreuzbergcloud.WithBaseURL(server.URL))
	_, err := client.GetJob(context.Background(), "any")
	var apiErr *kreuzbergcloud.APIError
	if !asError(err, &apiErr) {
		t.Fatalf("errors.As to *APIError failed: %v", err)
	}
	if apiErr.Status != 400 {
		t.Errorf("Status = %d, want 400", apiErr.Status)
	}
	if !strings.Contains(string(apiErr.Body), "bad") {
		t.Errorf("Body = %s, want to contain 'bad'", apiErr.Body)
	}
}

func TestError_TimeoutErrorIsDistinctFromContextCancel(t *testing.T) {
	t.Parallel()
	timeoutErr := &kreuzbergcloud.TimeoutError{JobID: "j", Elapsed: time.Second}
	if !strings.Contains(timeoutErr.Error(), "timed out") {
		t.Errorf("TimeoutError.Error() = %q, want to mention 'timed out'", timeoutErr.Error())
	}
	if asError(timeoutErr, new(*kreuzbergcloud.APIError)) {
		t.Errorf("TimeoutError should not unwrap to *APIError")
	}
}

// newStatusServer returns an *httptest.Server that always responds with the
// given status code, body, and (optional) headers — handy for stamping out
// error-class tests without per-test boilerplate.
func newStatusServer(status int, body string, header http.Header) *httptest.Server {
	return httptest.NewServer(http.HandlerFunc(func(w http.ResponseWriter, _ *http.Request) {
		for key, values := range header {
			for _, value := range values {
				w.Header().Add(key, value)
			}
		}
		w.WriteHeader(status)
		_, _ = w.Write([]byte(body))
	}))
}
