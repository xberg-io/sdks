package xberg

import (
	"encoding/json"
	"errors"
	"fmt"
	"net/http"
	"strconv"
	"time"
)

// XbergError is the base error type returned for any non-2xx HTTP response. It
// carries the HTTP status code, a human-readable message extracted from the
// response body when possible, and the raw body for callers that need
// programmatic access to vendor-specific error fields.
//
// Code and Details come from the nested envelope the services return,
// `{"error":{"code":"...","message":"...","details":{...}}}`: Code is the
// stable identifier to branch on and Details the raw context-specific object
// (nil when absent). The older flat shapes `{"error":"..."}` and
// `{"message":"..."}` still parse into Message, with Code left empty.
//
// [TimeoutError] and [TierError] also embed XbergError (with a zero Status,
// since neither originates from an HTTP response) so that a single
// errors.As(err, &XbergError{}) reaches every error the SDK raises — matching
// the base-class catch used by the Python and TypeScript SDKs
// (`except XbergError`, `instanceof XbergError`).
type XbergError struct {
	Status  int
	Message string
	Body    json.RawMessage
	Code    string
	Details json.RawMessage
}

// Error implements the error interface. A zero Status means no HTTP response
// backs this error (a decode failure on a stream, say), so the status is left
// out rather than rendered as a misleading "HTTP 0".
func (e *XbergError) Error() string {
	if e.Status == 0 {
		if e.Message != "" {
			return "xberg: " + e.Message
		}
		return "xberg: error"
	}
	if e.Message != "" {
		return fmt.Sprintf("xberg: HTTP %d: %s", e.Status, e.Message)
	}
	return fmt.Sprintf("xberg: HTTP %d", e.Status)
}

// AuthError wraps 401 Unauthorized responses.
type AuthError struct{ XbergError }

// Error overrides the embedded XbergError.Error to surface the error type.
func (e *AuthError) Error() string {
	return "xberg: authentication failed: " + e.XbergError.Error()
}

// Unwrap exposes the embedded XbergError so errors.As(err, &xbergErr) works.
func (e *AuthError) Unwrap() error { return &e.XbergError }

// ValidationError wraps 400 Bad Request and 422 Unprocessable Entity responses.
type ValidationError struct{ XbergError }

// Error overrides XbergError.Error for type clarity in stack traces.
func (e *ValidationError) Error() string {
	return "xberg: validation failed: " + e.XbergError.Error()
}

// Unwrap exposes the embedded XbergError.
func (e *ValidationError) Unwrap() error { return &e.XbergError }

// NotFoundError wraps 404 Not Found responses.
type NotFoundError struct{ XbergError }

// Error overrides XbergError.Error.
func (e *NotFoundError) Error() string {
	return "xberg: not found: " + e.XbergError.Error()
}

// Unwrap exposes the embedded XbergError.
func (e *NotFoundError) Unwrap() error { return &e.XbergError }

// RateLimitError wraps 429 Too Many Requests responses. RetryAfter is parsed
// from the Retry-After header when present (zero duration otherwise).
type RateLimitError struct {
	XbergError
	RetryAfter time.Duration
}

// Error overrides XbergError.Error.
func (e *RateLimitError) Error() string {
	if e.RetryAfter > 0 {
		return fmt.Sprintf("xberg: rate limited (retry after %s): %s",
			e.RetryAfter, e.XbergError.Error())
	}
	return "xberg: rate limited: " + e.XbergError.Error()
}

// Unwrap exposes the embedded XbergError.
func (e *RateLimitError) Unwrap() error { return &e.XbergError }

// ServerError wraps 5xx responses.
type ServerError struct{ XbergError }

// Error overrides XbergError.Error.
func (e *ServerError) Error() string {
	return "xberg: server error: " + e.XbergError.Error()
}

// Unwrap exposes the embedded XbergError.
func (e *ServerError) Unwrap() error { return &e.XbergError }

// GatewayTimeoutError wraps 504 Gateway Timeout responses. It embeds
// [ServerError], so errors.As(err, &serverErr) and [IsRetryable] keep matching a
// 504 exactly as before. Limit and TimeoutSeconds come from the envelope's
// [TimeoutErrorDetails] when the server's own request timeout fired (code
// [GatewayTimeout], limit [Handler]); a 504 from a proxy in front of the service
// leaves them zero.
//
// The server may still finish the work it timed out waiting for, so a 504 on a
// submission is not retried by default; see [WithRetryNonIdempotent].
type GatewayTimeoutError struct {
	ServerError
	Limit          TimeoutLimit
	TimeoutSeconds int64
}

// Error overrides ServerError.Error.
func (e *GatewayTimeoutError) Error() string {
	return "xberg: gateway timeout" + timeoutSuffix(e.Limit, e.TimeoutSeconds) + ": " + e.XbergError.Error()
}

// Unwrap exposes the embedded [ServerError], which in turn unwraps to [XbergError].
func (e *GatewayTimeoutError) Unwrap() error { return &e.ServerError }

// RequestTimeoutError wraps 408 Request Timeout responses: the server stopped
// waiting for the request body (code [RequestTimeout], limit [BodyIdle]).
// Limit and TimeoutSeconds come from the envelope's [TimeoutErrorDetails]. It is not retried
// by default, because a stalled upload usually stalls again.
type RequestTimeoutError struct {
	XbergError
	Limit          TimeoutLimit
	TimeoutSeconds int64
}

// Error overrides XbergError.Error.
func (e *RequestTimeoutError) Error() string {
	return "xberg: request timeout" + timeoutSuffix(e.Limit, e.TimeoutSeconds) + ": " + e.XbergError.Error()
}

// Unwrap exposes the embedded XbergError.
func (e *RequestTimeoutError) Unwrap() error { return &e.XbergError }

// ResultExpiredError wraps 410 Gone responses: the job's stored result passed
// its retention window and can no longer be fetched.
type ResultExpiredError struct{ XbergError }

// Error overrides XbergError.Error.
func (e *ResultExpiredError) Error() string {
	return "xberg: result expired: " + e.XbergError.Error()
}

// Unwrap exposes the embedded XbergError.
func (e *ResultExpiredError) Unwrap() error { return &e.XbergError }

// DataRoomsDisabledError wraps the 404 a deployment whose plan does not offer
// data rooms gives on every room route (code [ErrCodeDataRoomDisabled]). It
// embeds [NotFoundError], so errors.As(err, &notFound) keeps matching it.
// [EnterpriseHealth.DataRooms] reports the same state before any room call.
type DataRoomsDisabledError struct{ NotFoundError }

// Error overrides NotFoundError.Error.
func (e *DataRoomsDisabledError) Error() string {
	return "xberg: data rooms are disabled on this deployment: " + e.XbergError.Error()
}

// Unwrap exposes the embedded [NotFoundError], which in turn unwraps to [XbergError].
func (e *DataRoomsDisabledError) Unwrap() error { return &e.NotFoundError }

// PreconditionFailedError wraps 412 Precondition Failed responses: the
// resource changed since the version sent in If-Match was read.
type PreconditionFailedError struct{ XbergError }

// Error overrides XbergError.Error.
func (e *PreconditionFailedError) Error() string {
	return "xberg: precondition failed: " + e.XbergError.Error()
}

// Unwrap exposes the embedded XbergError.
func (e *PreconditionFailedError) Unwrap() error { return &e.XbergError }

// PreconditionRequiredError wraps 428 Precondition Required responses: the
// operation requires an If-Match header and none was sent.
type PreconditionRequiredError struct{ XbergError }

// Error overrides XbergError.Error.
func (e *PreconditionRequiredError) Error() string {
	return "xberg: precondition required: " + e.XbergError.Error()
}

// Unwrap exposes the embedded XbergError.
func (e *PreconditionRequiredError) Unwrap() error { return &e.XbergError }

// timeoutSuffix renders the optional limit/timeout detail of a 408 or 504.
func timeoutSuffix(limit TimeoutLimit, seconds int64) string {
	switch {
	case limit != "" && seconds > 0:
		return fmt.Sprintf(" (%s limit, %ds)", limit, seconds)
	case limit != "":
		return fmt.Sprintf(" (%s limit)", limit)
	case seconds > 0:
		return fmt.Sprintf(" (%ds)", seconds)
	default:
		return ""
	}
}

// TimeoutError is returned by [Client.WaitForJob] when the configured
// [WaitOptions.Timeout] elapses before the job reaches a terminal status. It
// is distinct from a context cancellation: callers should use errors.Is or
// errors.As to disambiguate. It embeds [XbergError] (see that type's doc
// comment) purely so errors.As(err, &XbergError{}) also matches it; the
// embedded Status is always 0 since no HTTP response backs this error.
type TimeoutError struct {
	XbergError
	JobID   string
	Elapsed time.Duration
}

// Error implements error.
func (e *TimeoutError) Error() string {
	return fmt.Sprintf(
		"xberg: timed out waiting for job %s after %s",
		e.JobID, e.Elapsed,
	)
}

// Unwrap exposes the embedded XbergError.
func (e *TimeoutError) Unwrap() error { return &e.XbergError }

// TierError is returned when a tier-specific method is invoked against the
// wrong product tier — e.g. calling a Pro-only method on an Enterprise
// instance. It is raised before the underlying request is issued, so callers
// get a clear, typed failure instead of a raw 404. Python and TypeScript have
// no equivalent — they raise their bare base error for a tier mismatch — so
// this type is strictly more specific than either; it embeds [XbergError] (see
// that type's doc comment) for the same errors.As parity, with Status always
// 0 since no HTTP response backs this error either.
type TierError struct {
	XbergError
	// Method is the SDK method that was called (e.g. "Login").
	Method string
	// Required is the tier the method needs ("enterprise" or "pro").
	Required string
	// Actual is the tier the connected instance reports.
	Actual string
}

// Error implements error.
func (e *TierError) Error() string {
	return fmt.Sprintf(
		"xberg: %s() is not available on the %q tier (requires the %q tier)",
		e.Method, e.Actual, e.Required,
	)
}

// Unwrap exposes the embedded XbergError.
func (e *TierError) Unwrap() error { return &e.XbergError }

// ConnectionError is returned when the round-trip never produced an HTTP
// response at all: DNS resolution failed, the connection was refused or reset,
// the TLS handshake failed, or the dial timed out. Status is always 0 because
// there is no response to take one from — matching Python's
// XbergError(status_code=None) and TypeScript's { status: 0 } for the same
// failure. It embeds [XbergError] (see that type's doc comment) so the base
// errors.As catch reaches it.
//
// It is retryable. Python retries httpx.TransportError and TypeScript retries a
// thrown fetch up to the configured attempt budget; without a type the retry
// engine can classify, [WithRetries] would be silently inert in Go for an
// entire class of failure that the other two clients ride out.
type ConnectionError struct {
	XbergError
	// Method and URL identify the request that could not be completed.
	Method string
	URL    string
	// Cause is the underlying transport error from the HTTP client.
	Cause error
}

// Error implements error.
func (e *ConnectionError) Error() string {
	return fmt.Sprintf("xberg: %s %s: %s", e.Method, e.URL, e.Cause)
}

// Unwrap exposes both the embedded [XbergError] — so errors.As(err,
// &XbergError{}) matches, as it does for every other error here — and the
// transport cause, so errors.Is against a net or syscall error still reaches
// through.
func (e *ConnectionError) Unwrap() []error { return []error{&e.XbergError, e.Cause} }

// errorEnvelope accepts both error shapes the services have returned: the
// nested `{"error":{"code","message","details"}}` envelope and the older flat
// `{"error":"..."}` / `{"message":"..."}` bodies. Error stays raw so either a
// JSON object or a JSON string can sit under it.
type errorEnvelope struct {
	Error   json.RawMessage `json:"error,omitempty"`
	Message string          `json:"message,omitempty"`
	Code    string          `json:"code,omitempty"`
	Details json.RawMessage `json:"details,omitempty"`
}

// nestedErrorBody is the object under "error" in the nested envelope.
type nestedErrorBody struct {
	Code    string          `json:"code"`
	Message string          `json:"message"`
	Details json.RawMessage `json:"details,omitempty"`
}

// timeoutDetails is the details object of a 408 or 504 the server's own
// request-timeout layer produced.
// parsedError is what [parseErrorBody] recovers from a response body.
type parsedError struct {
	code    string
	message string
	details json.RawMessage
}

// classifyHTTPError converts a non-2xx HTTP response into a typed error.
//
// The body has already been read by the caller — we accept it as raw bytes so
// the caller can close the response without re-buffering.
func classifyHTTPError(status int, body []byte, header http.Header) error {
	parsed := parseErrorBody(body)
	base := XbergError{
		Status:  status,
		Message: parsed.message,
		Body:    json.RawMessage(body),
		Code:    parsed.code,
		Details: parsed.details,
	}

	switch {
	case status == http.StatusUnauthorized || status == http.StatusForbidden:
		return &AuthError{XbergError: base}
	case status == http.StatusBadRequest || status == http.StatusUnprocessableEntity:
		return &ValidationError{XbergError: base}
	case status == http.StatusNotFound && parsed.code == ErrCodeDataRoomDisabled:
		return &DataRoomsDisabledError{NotFoundError: NotFoundError{XbergError: base}}
	case status == http.StatusNotFound:
		return &NotFoundError{XbergError: base}
	case status == http.StatusRequestTimeout:
		limit, seconds := parseTimeoutDetails(parsed.details)
		return &RequestTimeoutError{XbergError: base, Limit: limit, TimeoutSeconds: seconds}
	case status == http.StatusGone:
		return &ResultExpiredError{XbergError: base}
	case status == http.StatusPreconditionFailed:
		return &PreconditionFailedError{XbergError: base}
	case status == http.StatusPreconditionRequired:
		return &PreconditionRequiredError{XbergError: base}
	case status == http.StatusTooManyRequests:
		return &RateLimitError{XbergError: base, RetryAfter: parseRetryAfter(header)}
	case status == http.StatusGatewayTimeout:
		limit, seconds := parseTimeoutDetails(parsed.details)
		return &GatewayTimeoutError{ServerError: ServerError{XbergError: base}, Limit: limit, TimeoutSeconds: seconds}
	case status >= 500:
		return &ServerError{XbergError: base}
	default:
		return &base
	}
}

// parseErrorBody extracts code, message and details from either envelope
// shape. A body that is not a recognized JSON envelope becomes the message
// verbatim, as before.
func parseErrorBody(body []byte) parsedError {
	if len(body) == 0 {
		return parsedError{}
	}
	var envelope errorEnvelope
	if err := json.Unmarshal(body, &envelope); err != nil {
		return parsedError{message: string(body)}
	}
	var nested nestedErrorBody
	if len(envelope.Error) > 0 && envelope.Error[0] == '{' && json.Unmarshal(envelope.Error, &nested) == nil {
		message := nested.Message
		if message == "" {
			message = nested.Code
		}
		if message == "" {
			message = string(body)
		}
		return parsedError{code: nested.Code, message: message, details: nonNullDetails(nested.Details)}
	}
	var flat string
	if len(envelope.Error) > 0 && json.Unmarshal(envelope.Error, &flat) == nil && flat != "" {
		return parsedError{code: envelope.Code, message: flat, details: nonNullDetails(envelope.Details)}
	}
	if envelope.Message != "" {
		return parsedError{code: envelope.Code, message: envelope.Message, details: nonNullDetails(envelope.Details)}
	}
	return parsedError{code: envelope.Code, message: string(body), details: nonNullDetails(envelope.Details)}
}

// jsonNull is the literal JSON null.
const jsonNull = "null"

// nonNullDetails drops an explicit JSON null so Details is nil whenever the
// server sent no details object.
func nonNullDetails(raw json.RawMessage) json.RawMessage {
	if len(raw) == 0 || string(raw) == jsonNull {
		return nil
	}
	return raw
}

// parseTimeoutDetails reads limit and timeout_seconds from a timeout error's
// details, returning zero values when they are absent or malformed.
func parseTimeoutDetails(details json.RawMessage) (limit TimeoutLimit, seconds int64) {
	if len(details) == 0 {
		return "", 0
	}
	var parsed TimeoutErrorDetails
	if err := json.Unmarshal(details, &parsed); err != nil {
		return "", 0
	}
	return parsed.Limit, parsed.TimeoutSeconds
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

// IsRetryable reports whether an error is in the retryable class, without
// regard to the request method: a [ConnectionError] (no response at all), 429,
// and 502/503/504. Everything else, including 408, is terminal.
//
// The client's own retry loop is narrower than this: it retries 502/503/504
// only for GET, HEAD, OPTIONS, PUT and DELETE without If-Match unless
// [WithRetryNonIdempotent] is set, because a POST, PATCH or If-Match write the
// server timed out on may still have taken effect.
func IsRetryable(err error) bool {
	var conn *ConnectionError
	if errors.As(err, &conn) {
		return true
	}
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
