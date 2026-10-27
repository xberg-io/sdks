package xberg

import (
	"crypto/hmac"
	"crypto/sha256"
	"encoding/hex"
	"errors"
	"fmt"
	"math"
	"strconv"
	"strings"
	"time"
)

// WebhookSignatureHeader is the request header that carries a delivery's
// signature, `t=<unix seconds>,v1=<hex HMAC-SHA256>`.
const WebhookSignatureHeader = "X-Webhook-Signature"

// DefaultWebhookTolerance is how far a delivery's signed timestamp may sit from
// the receiver's clock before [VerifyWebhookSignature] rejects it as a replay.
// It matches the window the server documents.
const DefaultWebhookTolerance = 300 * time.Second

// Sentinel reasons a webhook signature is rejected. [VerifyWebhookSignature]
// returns a [*WebhookSignatureError] that matches exactly one of them under
// errors.Is.
var (
	// ErrWebhookMissingTimestamp means the header has no `t=<integer>` element.
	ErrWebhookMissingTimestamp = errors.New("signature header has no t=<unix seconds> element")
	// ErrWebhookMissingSignature means the header has no `v1=<hex>` element.
	ErrWebhookMissingSignature = errors.New("signature header has no v1=<hex> element")
	// ErrWebhookStale means the signed timestamp is outside the tolerance window.
	ErrWebhookStale = errors.New("signature timestamp is outside the tolerance window")
	// ErrWebhookMismatch means no v1 element matches the body under the secret.
	ErrWebhookMismatch = errors.New("signature does not match the request body")
)

// WebhookSignatureError is returned by [VerifyWebhookSignature] for a delivery
// that must be rejected. Reason is one of the ErrWebhook* sentinels, reachable
// through errors.Is. Timestamp and Now are set for [ErrWebhookStale]. It embeds
// [XbergError] (Status 0, no HTTP response backs it) so the package's single
// base catch still reaches it.
type WebhookSignatureError struct {
	XbergError
	Reason    error
	Timestamp int64
	Now       int64
}

// Error implements error.
func (e *WebhookSignatureError) Error() string {
	if errors.Is(e.Reason, ErrWebhookStale) {
		return fmt.Sprintf("xberg: webhook signature rejected: signature timestamp %d is outside the tolerance window at %d",
			e.Timestamp, e.Now)
	}
	return "xberg: webhook signature rejected: " + e.Reason.Error()
}

// Unwrap exposes both the embedded [XbergError] and the sentinel Reason.
func (e *WebhookSignatureError) Unwrap() []error { return []error{&e.XbergError, e.Reason} }

// WebhookVerifyOption configures [VerifyWebhookSignature].
type WebhookVerifyOption func(*webhookVerifyConfig)

type webhookVerifyConfig struct {
	tolerance time.Duration
	now       func() time.Time
}

// WithWebhookTolerance sets the replay window. Default: [DefaultWebhookTolerance].
// A negative value is treated as zero.
func WithWebhookTolerance(d time.Duration) WebhookVerifyOption {
	return func(c *webhookVerifyConfig) {
		if d < 0 {
			d = 0
		}
		c.tolerance = d
	}
}

// WithWebhookClock replaces the receiver's clock, for tests or for a receiver
// that verifies a delivery recorded earlier. Default: time.Now.
func WithWebhookClock(now func() time.Time) WebhookVerifyOption {
	return func(c *webhookVerifyConfig) {
		if now != nil {
			c.now = now
		}
	}
}

// VerifyWebhookSignature checks a webhook delivery's [WebhookSignatureHeader]
// value against the raw request body. header is `t=<unix seconds>,v1=<hex>`,
// where the hex is HMAC-SHA256 under secret over `"<t>.<body>"`. The digest is
// compared in constant time, every v1 element is tried (a sender signing with
// two secrets during rotation still verifies), and a timestamp further than
// the tolerance from the clock in either direction is rejected before the
// digest is checked. It returns nil for a valid delivery and a
// [*WebhookSignatureError] otherwise.
//
// Pass body exactly as received: re-encoding parsed JSON changes the bytes and
// breaks the signature.
func VerifyWebhookSignature(secret []byte, header string, body []byte, opts ...WebhookVerifyOption) error {
	cfg := webhookVerifyConfig{tolerance: DefaultWebhookTolerance, now: time.Now}
	for _, opt := range opts {
		opt(&cfg)
	}

	timestamp, timestampOK, candidates := parseWebhookSignatureHeader(header)
	if !timestampOK {
		return &WebhookSignatureError{Reason: ErrWebhookMissingTimestamp}
	}
	if len(candidates) == 0 {
		return &WebhookSignatureError{Reason: ErrWebhookMissingSignature}
	}
	now := cfg.now().Unix()
	if !withinWebhookTolerance(now, timestamp, int64(cfg.tolerance/time.Second)) {
		return &WebhookSignatureError{Reason: ErrWebhookStale, Timestamp: timestamp, Now: now}
	}

	mac := hmac.New(sha256.New, secret)
	mac.Write([]byte(strconv.FormatInt(timestamp, 10)))
	mac.Write([]byte("."))
	mac.Write(body)
	expected := mac.Sum(nil)
	for _, candidate := range candidates {
		decoded, err := hex.DecodeString(candidate)
		if err != nil {
			continue
		}
		if hmac.Equal(decoded, expected) {
			return nil
		}
	}
	return &WebhookSignatureError{Reason: ErrWebhookMismatch}
}

// parseWebhookSignatureHeader splits the header into its timestamp and v1
// candidates. As in the server's verifier, a later `t` element replaces an
// earlier one, and an unparsable `t` leaves no timestamp.
func parseWebhookSignatureHeader(header string) (timestamp int64, ok bool, candidates []string) {
	for _, element := range strings.Split(header, ",") {
		key, value, found := strings.Cut(strings.TrimSpace(element), "=")
		if !found {
			continue
		}
		switch key {
		case "t":
			parsed, err := strconv.ParseInt(value, 10, 64)
			timestamp, ok = parsed, err == nil
		case "v1":
			candidates = append(candidates, value)
		}
	}
	return timestamp, ok, candidates
}

// withinWebhookTolerance reports whether |now - timestamp| <= tolerance. The
// timestamp is attacker-chosen, so a distance that does not fit in an int64
// (either extreme against a nearby clock) is outside every window rather
// than allowed to wrap.
func withinWebhookTolerance(now, timestamp, tolerance int64) bool {
	if (timestamp > 0 && now < math.MinInt64+timestamp) || (timestamp < 0 && now > math.MaxInt64+timestamp) {
		return false
	}
	distance := now - timestamp
	if distance == math.MinInt64 {
		return false
	}
	if distance < 0 {
		distance = -distance
	}
	return distance <= tolerance
}
