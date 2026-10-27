package xberg_test

import (
	"crypto/hmac"
	"crypto/sha256"
	"encoding/hex"
	"errors"
	"math"
	"strconv"
	"testing"
	"time"

	xberg "github.com/xberg-io/sdks/packages/go"
)

// Vectors from xberg-enterprise crates/webhook-delivery/src/signature.rs: the
// same secret, body and timestamp. The digests were computed independently
// with Python's hmac module and `openssl dgst -sha256 -hmac`.
const (
	webhookSecret        = "whsec_test"
	webhookBody          = `{"event":"job.completed","job_id":"j1"}`
	webhookTimestamp     = int64(1_700_000_000)
	webhookDigest        = "3a1304cbfa5270ffc0f8e72192b25d803293dc6312d34e40e8b9feea0b574c03"
	webhookRetiredKey    = "retired"
	webhookRetiredDigest = "1ff07f276e8942bbaf1bdf17141006bb2b808f242a067e19a973d17a34ca775f"
)

func webhookClock(unix int64) xberg.WebhookVerifyOption {
	return xberg.WithWebhookClock(func() time.Time { return time.Unix(unix, 0) })
}

func signWebhook(secret string, timestamp int64, body string) string {
	mac := hmac.New(sha256.New, []byte(secret))
	mac.Write([]byte(strconv.FormatInt(timestamp, 10) + "." + body))
	return "t=" + strconv.FormatInt(timestamp, 10) + ",v1=" + hex.EncodeToString(mac.Sum(nil))
}

func TestVerifyWebhookSignature(t *testing.T) {
	t.Parallel()
	valid := "t=1700000000,v1=" + webhookDigest
	cases := []struct {
		name       string
		secret     string
		header     string
		body       string
		now        int64
		opts       []xberg.WebhookVerifyOption
		wantReason error
	}{
		{name: "fixed vector verifies", secret: webhookSecret, header: valid, body: webhookBody, now: webhookTimestamp},
		{name: "fresh within window", secret: webhookSecret, header: valid, body: webhookBody, now: webhookTimestamp + 100},
		{name: "exactly at the tolerance edge", secret: webhookSecret, header: valid, body: webhookBody,
			now: webhookTimestamp + 300},
		{name: "one second past the window", secret: webhookSecret, header: valid, body: webhookBody,
			now: webhookTimestamp + 301, wantReason: xberg.ErrWebhookStale},
		{name: "future timestamp past the window", secret: webhookSecret, header: valid, body: webhookBody,
			now: webhookTimestamp - 301, wantReason: xberg.ErrWebhookStale},
		{name: "custom tolerance", secret: webhookSecret, header: valid, body: webhookBody, now: webhookTimestamp + 11,
			opts: []xberg.WebhookVerifyOption{xberg.WithWebhookTolerance(10 * time.Second)}, wantReason: xberg.ErrWebhookStale},
		{name: "tampered body", secret: webhookSecret, header: valid, body: `{}`, now: webhookTimestamp,
			wantReason: xberg.ErrWebhookMismatch},
		{name: "wrong secret", secret: "other", header: valid, body: webhookBody, now: webhookTimestamp,
			wantReason: xberg.ErrWebhookMismatch},
		{name: "tampered timestamp", secret: webhookSecret, header: "t=1700000001,v1=" + webhookDigest, body: webhookBody,
			now: webhookTimestamp, wantReason: xberg.ErrWebhookMismatch},
		{name: "non-hex signature", secret: webhookSecret, header: "t=1700000000,v1=zz", body: webhookBody,
			now: webhookTimestamp, wantReason: xberg.ErrWebhookMismatch},
		{name: "legacy sha256= format", secret: webhookSecret, header: "sha256=abcd", body: webhookBody,
			now: webhookTimestamp, wantReason: xberg.ErrWebhookMissingTimestamp},
		{name: "unparsable timestamp", secret: webhookSecret, header: "t=soon,v1=" + webhookDigest, body: webhookBody,
			now: webhookTimestamp, wantReason: xberg.ErrWebhookMissingTimestamp},
		{name: "missing v1", secret: webhookSecret, header: "t=1700000000", body: webhookBody, now: webhookTimestamp,
			wantReason: xberg.ErrWebhookMissingSignature},
		{name: "rotation: any matching v1 verifies", secret: webhookSecret,
			header: valid + ",v1=" + webhookRetiredDigest, body: webhookBody, now: webhookTimestamp},
		{name: "rotation: a later v1 matches, whitespace trimmed", secret: webhookRetiredKey,
			header: valid + ", v1=" + webhookRetiredDigest, body: webhookBody, now: webhookTimestamp},
		{name: "int64 min timestamp does not overflow", secret: webhookSecret,
			header: "t=" + strconv.FormatInt(math.MinInt64, 10) + ",v1=abcd", body: webhookBody, now: 0,
			wantReason: xberg.ErrWebhookStale},
		{name: "int64 max timestamp does not overflow", secret: webhookSecret,
			header: "t=" + strconv.FormatInt(math.MaxInt64, 10) + ",v1=abcd", body: webhookBody, now: -1,
			wantReason: xberg.ErrWebhookStale},
		{name: "a correct digest cannot rescue an out-of-range timestamp", secret: webhookSecret,
			header: signWebhook(webhookSecret, math.MinInt64, webhookBody), body: webhookBody, now: 0,
			wantReason: xberg.ErrWebhookStale},
	}
	for _, tc := range cases {
		t.Run(tc.name, func(t *testing.T) {
			t.Parallel()
			opts := append([]xberg.WebhookVerifyOption{webhookClock(tc.now)}, tc.opts...)
			err := xberg.VerifyWebhookSignature([]byte(tc.secret), tc.header, []byte(tc.body), opts...)
			if tc.wantReason == nil {
				if err != nil {
					t.Fatalf("VerifyWebhookSignature = %v, want nil", err)
				}
				return
			}
			if !errors.Is(err, tc.wantReason) {
				t.Fatalf("VerifyWebhookSignature = %v, want errors.Is %v", err, tc.wantReason)
			}
			var sigErr *xberg.WebhookSignatureError
			if !errors.As(err, &sigErr) {
				t.Fatalf("error %T is not *WebhookSignatureError", err)
			}
			var base *xberg.XbergError
			if !errors.As(err, &base) || base.Status != 0 {
				t.Errorf("base catch missed the webhook error or set a status")
			}
		})
	}
}

func TestVerifyWebhookSignature_FixedVectorMatchesLocalSigner(t *testing.T) {
	t.Parallel()
	if got, want := signWebhook(webhookSecret, webhookTimestamp, webhookBody), "t=1700000000,v1="+webhookDigest; got != want {
		t.Fatalf("signWebhook = %q, want %q", got, want)
	}
}

func TestVerifyWebhookSignature_StaleErrorCarriesClockValues(t *testing.T) {
	t.Parallel()
	now := webhookTimestamp + 301
	err := xberg.VerifyWebhookSignature([]byte(webhookSecret), "t=1700000000,v1="+webhookDigest, []byte(webhookBody),
		webhookClock(now))
	var sigErr *xberg.WebhookSignatureError
	if !errors.As(err, &sigErr) {
		t.Fatalf("error = %v, want *WebhookSignatureError", err)
	}
	if sigErr.Timestamp != webhookTimestamp || sigErr.Now != now {
		t.Errorf("Timestamp, Now = %d, %d; want %d, %d", sigErr.Timestamp, sigErr.Now, webhookTimestamp, now)
	}
	want := "xberg: webhook signature rejected: signature timestamp 1700000000 is outside the tolerance window at 1700000301"
	if err.Error() != want {
		t.Errorf("Error() = %q, want %q", err.Error(), want)
	}
}

func TestVerifyWebhookSignature_DefaultClockIsWallTime(t *testing.T) {
	t.Parallel()
	header := signWebhook(webhookSecret, time.Now().Unix(), webhookBody)
	if err := xberg.VerifyWebhookSignature([]byte(webhookSecret), header, []byte(webhookBody)); err != nil {
		t.Fatalf("fresh signature under the default clock: %v", err)
	}
	if err := xberg.VerifyWebhookSignature([]byte(webhookSecret), "t=1700000000,v1="+webhookDigest,
		[]byte(webhookBody)); !errors.Is(err, xberg.ErrWebhookStale) {
		t.Fatalf("2023 signature under the default clock = %v, want ErrWebhookStale", err)
	}
}
