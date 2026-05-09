package kreuzbergcloud

import (
	"encoding/json"
	"errors"
	"fmt"
	"net/http"
	"strconv"
	"time"
)

// APIError is the base error type returned for any non-2xx HTTP response. It
// carries the HTTP status code, a human-readable message extracted from the
// response body when possible, and the raw body for callers that need
// programmatic access to vendor-specific error fields.
type APIError struct {
	Status  int
	Message string
	Body    json.RawMessage
}

// Error implements the error interface.
func (e *APIError) Error() string {
	if e.Message != "" {
		return fmt.Sprintf("kreuzberg-cloud: HTTP %d: %s", e.Status, e.Message)
	}
	return fmt.Sprintf("kreuzberg-cloud: HTTP %d", e.Status)
}

// AuthError wraps 401 Unauthorized responses.
type AuthError struct{ APIError }

// Error overrides the embedded APIError.Error to surface the error type.
func (e *AuthError) Error() string {
	return "kreuzberg-cloud: authentication failed: " + e.APIError.Error()
}

// Unwrap exposes the embedded APIError so errors.As(err, &apiErr) works.
func (e *AuthError) Unwrap() error { return &e.APIError }

// ValidationError wraps 400 Bad Request and 422 Unprocessable Entity responses.
type ValidationError struct{ APIError }

// Error overrides APIError.Error for type clarity in stack traces.
func (e *ValidationError) Error() string {
	return "kreuzberg-cloud: validation failed: " + e.APIError.Error()
}

// Unwrap exposes the embedded APIError.
func (e *ValidationError) Unwrap() error { return &e.APIError }

// NotFoundError wraps 404 Not Found responses.
type NotFoundError struct{ APIError }

// Error overrides APIError.Error.
func (e *NotFoundError) Error() string {
	return "kreuzberg-cloud: not found: " + e.APIError.Error()
}

// Unwrap exposes the embedded APIError.
func (e *NotFoundError) Unwrap() error { return &e.APIError }

// RateLimitError wraps 429 Too Many Requests responses. RetryAfter is parsed
// from the Retry-After header when present (zero duration otherwise).
type RateLimitError struct {
	APIError
	RetryAfter time.Duration
}

// Error overrides APIError.Error.
func (e *RateLimitError) Error() string {
	if e.RetryAfter > 0 {
		return fmt.Sprintf("kreuzberg-cloud: rate limited (retry after %s): %s",
			e.RetryAfter, e.APIError.Error())
	}
	return "kreuzberg-cloud: rate limited: " + e.APIError.Error()
}

// Unwrap exposes the embedded APIError.
func (e *RateLimitError) Unwrap() error { return &e.APIError }

// ServerError wraps 5xx responses.
type ServerError struct{ APIError }

// Error overrides APIError.Error.
func (e *ServerError) Error() string {
	return "kreuzberg-cloud: server error: " + e.APIError.Error()
}

// Unwrap exposes the embedded APIError.
func (e *ServerError) Unwrap() error { return &e.APIError }

// TimeoutError is returned by [Client.WaitForJob] when the configured
// [WaitOptions.Timeout] elapses before the job reaches a terminal status. It
// is distinct from a context cancellation: callers should use errors.Is or
// errors.As to disambiguate.
type TimeoutError struct {
	JobID   string
	Elapsed time.Duration
}

// Error implements error.
func (e *TimeoutError) Error() string {
	return fmt.Sprintf(
		"kreuzberg-cloud: timed out waiting for job %s after %s",
		e.JobID, e.Elapsed,
	)
}

// errorBody is the canonical error envelope used by the API service.
type errorBody struct {
	Error   string `json:"error,omitempty"`
	Message string `json:"message,omitempty"`
}

// classifyHTTPError converts a non-2xx HTTP response into a typed error.
//
// The body has already been read by the caller — we accept it as raw bytes so
// the caller can close the response without re-buffering.
func classifyHTTPError(status int, body []byte, header http.Header) error {
	rawBody := json.RawMessage(body)
	message := extractMessage(body)
	base := APIError{Status: status, Message: message, Body: rawBody}

	switch {
	case status == http.StatusUnauthorized || status == http.StatusForbidden:
		return &AuthError{APIError: base}
	case status == http.StatusBadRequest || status == http.StatusUnprocessableEntity:
		return &ValidationError{APIError: base}
	case status == http.StatusNotFound:
		return &NotFoundError{APIError: base}
	case status == http.StatusTooManyRequests:
		return &RateLimitError{APIError: base, RetryAfter: parseRetryAfter(header)}
	case status >= 500:
		return &ServerError{APIError: base}
	default:
		return &base
	}
}

func extractMessage(body []byte) string {
	if len(body) == 0 {
		return ""
	}
	var envelope errorBody
	if err := json.Unmarshal(body, &envelope); err == nil {
		if envelope.Error != "" {
			return envelope.Error
		}
		if envelope.Message != "" {
			return envelope.Message
		}
	}
	return string(body)
}

func parseRetryAfter(header http.Header) time.Duration {
	value := header.Get("Retry-After")
	if value == "" {
		return 0
	}
	if seconds, err := strconv.Atoi(value); err == nil {
		return time.Duration(seconds) * time.Second
	}
	if when, err := http.ParseTime(value); err == nil {
		delta := time.Until(when)
		if delta > 0 {
			return delta
		}
	}
	return 0
}

// IsRetryable reports whether an error should trigger a transport-level retry.
// 429 and 502/503/504 are retryable; everything else is terminal.
func IsRetryable(err error) bool {
	var rate *RateLimitError
	if errors.As(err, &rate) {
		return true
	}
	var srv *ServerError
	if errors.As(err, &srv) {
		switch srv.Status {
		case http.StatusBadGateway, http.StatusServiceUnavailable, http.StatusGatewayTimeout:
			return true
		}
	}
	return false
}
