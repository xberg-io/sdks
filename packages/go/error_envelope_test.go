package xberg_test

import (
	"context"
	"encoding/json"
	"errors"
	"net/http"
	"testing"

	xberg "github.com/xberg-io/sdks/packages/go"
)

// Byte-for-byte the bodies xberg-enterprise's request-timeout layer writes
// (crates/observability/src/request_timeout.rs, timeout_response).
const (
	gatewayTimeoutBody = `{"error":{"code":"gateway_timeout","message":"The server did not produce a response in time",` +
		`"details":{"limit":"handler","timeout_seconds":30}}}`
	requestTimeoutBody = `{"error":{"code":"request_timeout",` +
		`"message":"The request body stopped arriving before the upload completed",` +
		`"details":{"limit":"body_idle","timeout_seconds":60}}}`
)

// TestErrorEnvelope_DecodesTheGeneratedTimeoutSchema ties the hand-written timeout errors to the
// spec's TimeoutErrorResponse: a body marshaled from the generated type must populate them.
func TestErrorEnvelope_DecodesTheGeneratedTimeoutSchema(t *testing.T) {
	t.Parallel()
	body := func(code xberg.TimeoutErrorCode, limit xberg.TimeoutLimit, seconds int64) string {
		raw, err := json.Marshal(xberg.TimeoutErrorResponse{Error: xberg.TimeoutErrorBody{
			Code: code, Message: "m", Details: xberg.TimeoutErrorDetails{Limit: limit, TimeoutSeconds: seconds},
		}})
		if err != nil {
			t.Fatal(err)
		}
		return string(raw)
	}

	var gateway *xberg.GatewayTimeoutError
	err := getJobError(t, http.StatusGatewayTimeout, body(xberg.GatewayTimeout, xberg.Handler, 30))
	if !errors.As(err, &gateway) || gateway.Code != string(xberg.GatewayTimeout) ||
		gateway.Limit != xberg.Handler || gateway.TimeoutSeconds != 30 {
		t.Fatalf("504 from TimeoutErrorResponse decoded as %T %+v", err, err)
	}

	var request *xberg.RequestTimeoutError
	err = getJobError(t, http.StatusRequestTimeout, body(xberg.RequestTimeout, xberg.BodyIdle, 60))
	if !errors.As(err, &request) || request.Code != string(xberg.RequestTimeout) ||
		request.Limit != xberg.BodyIdle || request.TimeoutSeconds != 60 {
		t.Fatalf("408 from TimeoutErrorResponse decoded as %T %+v", err, err)
	}
}

func getJobError(t *testing.T, status int, body string) error {
	t.Helper()
	server := newStatusServer(status, body, nil)
	t.Cleanup(server.Close)
	client := mustClient(t, xberg.WithBaseURL(server.URL))
	_, err := client.GetJob(context.Background(), "j")
	if err == nil {
		t.Fatalf("GetJob against HTTP %d returned nil error", status)
	}
	return err
}

func TestErrorEnvelope_ParsesNestedAndFlatShapes(t *testing.T) {
	t.Parallel()
	cases := []struct {
		name        string
		status      int
		body        string
		wantCode    string
		wantMessage string
		wantDetails string
	}{
		{
			name: "nested 504 gateway timeout", status: http.StatusGatewayTimeout, body: gatewayTimeoutBody,
			wantCode: "gateway_timeout", wantMessage: "The server did not produce a response in time",
			wantDetails: `{"limit":"handler","timeout_seconds":30}`,
		},
		{
			name: "nested 408 request timeout", status: http.StatusRequestTimeout, body: requestTimeoutBody,
			wantCode:    "request_timeout",
			wantMessage: "The request body stopped arriving before the upload completed",
			wantDetails: `{"limit":"body_idle","timeout_seconds":60}`,
		},
		{
			name: "nested without details", status: http.StatusConflict,
			body:     `{"error":{"code":"quota_exceeded","message":"monthly page quota exhausted"}}`,
			wantCode: "quota_exceeded", wantMessage: "monthly page quota exhausted",
		},
		{
			name: "nested with null details", status: http.StatusNotFound,
			body:     `{"error":{"code":"data_room.disabled","message":"data rooms are not enabled","details":null}}`,
			wantCode: "data_room.disabled", wantMessage: "data rooms are not enabled",
		},
		{
			name: "flat error string", status: http.StatusUnauthorized, body: `{"error":"missing token"}`,
			wantMessage: "missing token",
		},
		{
			name: "flat message string", status: http.StatusBadRequest, body: `{"message":"documents must not be empty"}`,
			wantMessage: "documents must not be empty",
		},
		{
			name: "flat error wins over message", status: http.StatusBadRequest,
			body: `{"error":"bad input","message":"ignored"}`, wantMessage: "bad input",
		},
		{
			name: "non-JSON body becomes the message", status: http.StatusBadGateway, body: `upstream exploded`,
			wantMessage: "upstream exploded",
		},
	}
	for _, tc := range cases {
		t.Run(tc.name, func(t *testing.T) {
			t.Parallel()
			err := getJobError(t, tc.status, tc.body)
			var base *xberg.XbergError
			if !errors.As(err, &base) {
				t.Fatalf("errors.As(%T, *XbergError) = false", err)
			}
			if base.Status != tc.status {
				t.Errorf("Status = %d, want %d", base.Status, tc.status)
			}
			if base.Code != tc.wantCode {
				t.Errorf("Code = %q, want %q", base.Code, tc.wantCode)
			}
			if base.Message != tc.wantMessage {
				t.Errorf("Message = %q, want %q", base.Message, tc.wantMessage)
			}
			if string(base.Details) != tc.wantDetails {
				t.Errorf("Details = %q, want %q", base.Details, tc.wantDetails)
			}
			if string(base.Body) != tc.body {
				t.Errorf("Body = %q, want the raw response body %q", base.Body, tc.body)
			}
		})
	}
}

func TestErrorEnvelope_TypedErrorsByStatus(t *testing.T) {
	t.Parallel()
	nested := func(code string) string { return `{"error":{"code":"` + code + `","message":"m"}}` }
	cases := []struct {
		name   string
		status int
		body   string
		match  func(error) bool
	}{
		{"408 RequestTimeoutError", http.StatusRequestTimeout, requestTimeoutBody, func(err error) bool {
			var target *xberg.RequestTimeoutError
			return errors.As(err, &target) && target.Limit == "body_idle" && target.TimeoutSeconds == 60
		}},
		{"504 GatewayTimeoutError", http.StatusGatewayTimeout, gatewayTimeoutBody, func(err error) bool {
			var target *xberg.GatewayTimeoutError
			return errors.As(err, &target) && target.Limit == "handler" && target.TimeoutSeconds == 30
		}},
		{"504 from a proxy has no timeout details", http.StatusGatewayTimeout, `<html>504</html>`, func(err error) bool {
			var target *xberg.GatewayTimeoutError
			return errors.As(err, &target) && target.Limit == "" && target.TimeoutSeconds == 0
		}},
		{"410 ResultExpiredError", http.StatusGone, nested("result_expired"), func(err error) bool {
			var target *xberg.ResultExpiredError
			return errors.As(err, &target) && target.Code == "result_expired"
		}},
		{"412 PreconditionFailedError", http.StatusPreconditionFailed, nested("precondition_failed"), func(err error) bool {
			var target *xberg.PreconditionFailedError
			return errors.As(err, &target) && target.Status == http.StatusPreconditionFailed
		}},
		{"428 PreconditionRequiredError", http.StatusPreconditionRequired, nested("precondition_required"),
			func(err error) bool {
				var target *xberg.PreconditionRequiredError
				return errors.As(err, &target) && target.Status == http.StatusPreconditionRequired
			}},
	}
	for _, tc := range cases {
		t.Run(tc.name, func(t *testing.T) {
			t.Parallel()
			err := getJobError(t, tc.status, tc.body)
			if !tc.match(err) {
				t.Fatalf("error %T (%v) did not match the expected typed error and fields", err, err)
			}
		})
	}
}

// TestErrorEnvelope_ExistingChecksStillMatch pins compatibility: a 504 is still
// a *ServerError and still retryable, and the new 4xx types still reach the
// base catch, so no caller check written against 0.9.0 changes its answer.
func TestErrorEnvelope_ExistingChecksStillMatch(t *testing.T) {
	t.Parallel()
	cases := []struct {
		name          string
		status        int
		body          string
		wantServerErr bool
		wantRetryable bool
	}{
		{"504 nested", http.StatusGatewayTimeout, gatewayTimeoutBody, true, true},
		{"503 nested", http.StatusServiceUnavailable, `{"error":{"code":"unavailable","message":"m"}}`, true, true},
		{"408 nested", http.StatusRequestTimeout, requestTimeoutBody, false, false},
		{"410 nested", http.StatusGone, `{"error":{"code":"result_expired","message":"m"}}`, false, false},
		{"412 nested", http.StatusPreconditionFailed, `{"error":{"code":"precondition_failed","message":"m"}}`, false, false},
		{"428 nested", http.StatusPreconditionRequired, `{"error":{"code":"precondition_required","message":"m"}}`,
			false, false},
	}
	for _, tc := range cases {
		t.Run(tc.name, func(t *testing.T) {
			t.Parallel()
			err := getJobError(t, tc.status, tc.body)
			var srv *xberg.ServerError
			if got := errors.As(err, &srv); got != tc.wantServerErr {
				t.Errorf("errors.As(*ServerError) = %v, want %v", got, tc.wantServerErr)
			}
			if tc.wantServerErr && srv.Status != tc.status {
				t.Errorf("ServerError.Status = %d, want %d", srv.Status, tc.status)
			}
			if got := xberg.IsRetryable(err); got != tc.wantRetryable {
				t.Errorf("IsRetryable = %v, want %v", got, tc.wantRetryable)
			}
			var base *xberg.XbergError
			if !errors.As(err, &base) || base.Status != tc.status {
				t.Errorf("base catch missed %T or carried the wrong status", err)
			}
		})
	}
}

func TestErrorEnvelope_ErrorStringsCarryTimeoutDetail(t *testing.T) {
	t.Parallel()
	cases := []struct {
		status int
		body   string
		want   string
	}{
		{http.StatusGatewayTimeout, gatewayTimeoutBody,
			"xberg: gateway timeout (handler limit, 30s): xberg: HTTP 504: The server did not produce a response in time"},
		{http.StatusRequestTimeout, requestTimeoutBody,
			"xberg: request timeout (body_idle limit, 60s): xberg: HTTP 408: " +
				"The request body stopped arriving before the upload completed"},
		{http.StatusGone, `{"error":{"code":"result_expired","message":"gone"}}`, "xberg: result expired: xberg: HTTP 410: gone"},
	}
	for _, tc := range cases {
		err := getJobError(t, tc.status, tc.body)
		if err.Error() != tc.want {
			t.Errorf("HTTP %d Error() = %q, want %q", tc.status, err.Error(), tc.want)
		}
	}
}
