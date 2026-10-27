---
title: Webhooks and inline callbacks
description: Async result delivery, signature verification, and when to poll instead.
---

Both tiers accept an inline `webhook` on an extract request and deliver job-completion events to it
durably, with retry and replay protection. It is part of the shared surface — the same shape works
identically against Enterprise and Pro.

## Attaching a webhook

```python title="Python"
from pathlib import Path

job = client.extract(
    file=Path("invoice.pdf"),
    webhook={"url": "https://example.com/hooks/xberg", "secret": "whsec_...", "metadata": {"batch": "2026-09"}},
)
```

```ts title="TypeScript"
const job = await client.extract({
  file: { name: "invoice.pdf", data, mimeType: "application/pdf" },
  webhook: { url: "https://example.com/hooks/xberg", secret: "whsec_...", metadata: { batch: "2026-09" } },
});
```

```go title="Go"
secret := "whsec_..."
job, err := client.Extract(ctx, xberg.FileSource{Name: "invoice.pdf", Reader: file}, &xberg.ExtractOptions{
    Webhook: &xberg.WebhookConfig{
        Url:      "https://example.com/hooks/xberg",
        Secret:   &secret,
        Metadata: &map[string]string{"batch": "2026-09"},
    },
})
```

`url` is the only required field. `secret` enables HMAC-SHA256 signing of the delivered payload;
`metadata` (at most 100 entries, keys up to 255 characters, values up to 1024 characters, 8192
bytes JSON-encoded total) is echoed back on the delivered event unchanged, so it is where you carry
your own correlation id.

## The delivered event

The event body is the exact JSON `WebhookEvent` posted to your URL — not something you fetch
separately. It always carries `event` (`job.completed`, `job.failed`, …), `event_id` (stable across
retries of the *same* event — dedupe on it), `job_id` and `timestamp`. `results` is present only on
`job.completed`, and only when the result fits in 100 KiB — otherwise fetch it with
`get_job_result`/`getJobResult`/`GetJobResult`. `error` is present only on `job.failed`.

## Verifying the signature

When `secret` is set, deliveries carry an `X-Webhook-Signature` header shaped
`t=<unix seconds>,v1=<hex HMAC-SHA256>`, computed over `"<t>.<body>"`. Reject anything where `t` is
older than five minutes — that is the replay window the server itself enforces.

```python title="Python"
from xberg_io_sdk import WEBHOOK_SIGNATURE_HEADER, verify_webhook_signature

def handle(headers: dict[str, str], body: bytes) -> bool:
    # `body` must be the raw bytes received; re-serialized JSON will not verify.
    return verify_webhook_signature("whsec_...", headers[WEBHOOK_SIGNATURE_HEADER], body)
```

`verify_webhook_signature(secret, header, body, tolerance=300, now=None)` returns `False` for a
missing element, a stale timestamp or a mismatched digest; `verify_webhook_signature_or_raise`
raises a `WebhookSignatureError` whose `reason` says which. Both accept every `v1` element in the
header, so a delivery signed with two secrets during a rotation still verifies.

```ts title="TypeScript"
import { createHmac, timingSafeEqual } from "node:crypto";

function verifyWebhook(body: string, header: string, secret: string): boolean {
  const parts = Object.fromEntries(header.split(",").map((part) => part.split("=")));
  const timestamp = Number(parts.t);
  if (Math.abs(Date.now() / 1000 - timestamp) > 300) return false;
  const expected = createHmac("sha256", secret).update(`${timestamp}.${body}`).digest("hex");
  return timingSafeEqual(Buffer.from(expected), Buffer.from(parts.v1));
}
```

```go title="Go"
func verifyWebhook(body []byte, header, secret string) bool {
    parts := map[string]string{}
    for _, part := range strings.Split(header, ",") {
        kv := strings.SplitN(part, "=", 2)
        parts[kv[0]] = kv[1]
    }
    ts, err := strconv.ParseInt(parts["t"], 10, 64)
    if err != nil {
        return false
    }
    delta := time.Now().Unix() - ts
    if delta < 0 {
        delta = -delta
    }
    if delta > 300 {
        return false
    }
    mac := hmac.New(sha256.New, []byte(secret))
    mac.Write([]byte(parts["t"] + "." + string(body)))
    expected := hex.EncodeToString(mac.Sum(nil))
    return hmac.Equal([]byte(expected), []byte(parts["v1"]))
}
```

The Python client ships the helper above. The TypeScript and Go recipes use only the standard
library.

## Webhooks versus polling

A webhook removes the poll loop but does not remove the need to handle a job that never completes
(a dropped delivery, an unreachable endpoint) — treat it as a fast path and still poll or fetch the
job on your own timeout as a fallback for jobs your webhook handler has not seen close.

Managed webhook *subscriptions* — a standing registration independent of any single extract call —
are an Enterprise control-plane feature; the inline `webhook` documented here is the only way to
request a delivery on either tier.

Delivery history for a managed subscription is readable on Enterprise:
`list_subscription_deliveries` / `get_subscription_delivery` on the data plane, and
`get_webhook_delivery` for a single delivery through the control plane. See
[Tier capabilities](/reference/tier-capabilities/).
