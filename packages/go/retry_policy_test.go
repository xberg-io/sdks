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

const retryPolicyJob = `{"id":"550e8400-e29b-41d4-a716-446655440000","filename":"a.pdf","status":"completed",` +
	`"created_at":"2025-12-21T10:00:00Z","result":{"content":"ok"}}`

// TestRetryPolicy_IsMethodAware counts the attempts an httptest server sees.
// The server fails the first `failures` attempts with `status`, then succeeds.
func TestRetryPolicy_IsMethodAware(t *testing.T) {
	t.Parallel()
	get := func(ctx context.Context, c *xberg.Client) error {
		_, err := c.GetJob(ctx, "j")
		return err
	}
	post := func(ctx context.Context, c *xberg.Client) error {
		_, err := c.PresignUpload(ctx, map[string]any{"documents": []any{}})
		return err
	}
	put := func(ctx context.Context, c *xberg.Client) error {
		return c.PutLocalUpload(ctx, "p1", "tok", []byte("bytes"))
	}
	cases := []struct {
		name      string
		call      func(context.Context, *xberg.Client) error
		status    int
		body      string
		failures  int32
		opts      []xberg.Option
		wantCalls int32
		wantErr   bool
	}{
		{name: "POST not retried on 504", call: post, status: http.StatusGatewayTimeout, body: gatewayTimeoutBody,
			failures: 1, wantCalls: 1, wantErr: true},
		{name: "POST not retried on 502", call: post, status: http.StatusBadGateway, failures: 1, wantCalls: 1, wantErr: true},
		{name: "POST not retried on 503", call: post, status: http.StatusServiceUnavailable, failures: 1, wantCalls: 1,
			wantErr: true},
		{name: "POST retried on 504 after opt-in", call: post, status: http.StatusGatewayTimeout, body: gatewayTimeoutBody,
			failures: 1, opts: []xberg.Option{xberg.WithRetryNonIdempotent(true)}, wantCalls: 2},
		{name: "POST retried on 429", call: post, status: http.StatusTooManyRequests, failures: 1, wantCalls: 2},
		{name: "GET retried on 504", call: get, status: http.StatusGatewayTimeout, body: gatewayTimeoutBody,
			failures: 2, wantCalls: 3},
		{name: "GET retried on 429", call: get, status: http.StatusTooManyRequests, failures: 1, wantCalls: 2},
		{name: "GET not retried on 408", call: get, status: http.StatusRequestTimeout, body: requestTimeoutBody,
			failures: 1, wantCalls: 1, wantErr: true},
		{name: "PUT retried on 503", call: put, status: http.StatusServiceUnavailable, failures: 1,
			opts: []xberg.Option{xberg.WithTarget(xberg.TargetPro)}, wantCalls: 2},
		{name: "PUT not retried on 408", call: put, status: http.StatusRequestTimeout, body: requestTimeoutBody,
			failures: 1, opts: []xberg.Option{xberg.WithTarget(xberg.TargetPro)}, wantCalls: 1, wantErr: true},
	}
	for _, tc := range cases {
		t.Run(tc.name, func(t *testing.T) {
			t.Parallel()
			var calls atomic.Int32
			server := httptest.NewServer(http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
				if calls.Add(1) <= tc.failures {
					if tc.status == http.StatusTooManyRequests {
						w.Header().Set("Retry-After", "0")
					}
					w.WriteHeader(tc.status)
					body := tc.body
					if body == "" {
						body = `{"error":{"code":"transient","message":"try again"}}`
					}
					_, _ = w.Write([]byte(body))
					return
				}
				switch r.Method {
				case http.MethodPut:
					w.WriteHeader(http.StatusNoContent)
				case http.MethodPost:
					_, _ = w.Write([]byte(`{"batch_id":"00000000-0000-4000-8000-000000000003","uploads":[]}`))
				default:
					_, _ = w.Write([]byte(retryPolicyJob))
				}
			}))
			defer server.Close()
			opts := append([]xberg.Option{xberg.WithBaseURL(server.URL), xberg.WithRetries(3)}, tc.opts...)
			client := mustClient(t, opts...)
			err := tc.call(context.Background(), client)
			if (err != nil) != tc.wantErr {
				t.Fatalf("err = %v, wantErr %v", err, tc.wantErr)
			}
			if got := calls.Load(); got != tc.wantCalls {
				t.Errorf("attempts = %d, want %d", got, tc.wantCalls)
			}
			if err != nil {
				var base *xberg.XbergError
				if !errors.As(err, &base) || base.Status != tc.status {
					t.Errorf("error %T does not carry status %d: %v", err, tc.status, err)
				}
			}
		})
	}
}
