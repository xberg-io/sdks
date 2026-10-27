---
title: Errors and retries
description: The error hierarchy, what is retried, and what is not.
---

## The error envelope

Every error response carries the same JSON shape:

```json
{ "error": { "code": "validation", "message": "documents must not be empty" } }
```

`code` is a stable identifier you can branch on; `message` is for humans and may change. Some errors
add a `details` object with structured context; a timeout carries the limit that fired and its
length:

```json
{
  "error": {
    "code": "gateway_timeout",
    "details": { "limit": "handler", "timeout_seconds": 30 },
    "message": "The server did not produce a response in time"
  }
}
```

Older servers send a flat `{ "error": "<code>", "message": "..." }` body instead. All three clients
decode both shapes and use the server's message as the error message:

| Client | Fields on every error |
| --- | --- |
| Python | `status`, `code`, `message`, `details` (a `dict`) |
| TypeScript | `status`, `code`, `message`, `details` |
| Go | `Status`, `Code`, `Message`, `Details` (`json.RawMessage`) |

## The hierarchy

Each client maps status codes onto typed errors:

| Condition | Error |
| --- | --- |
| 401, 403 | authentication error |
| 400 | validation error; Go also maps 422, and TypeScript 422 and every 4xx not listed here |
| 404 | not-found error |
| 408 | `RequestTimeoutError`: the request body stopped arriving; carries the limit and timeout length |
| 410 | `ResultExpiredError`: the stored result has expired |
| 412 | `PreconditionFailedError`: the `If-Match` version is stale |
| 428 | `PreconditionRequiredError`: the request needs `If-Match` |
| 429 | rate-limit error, carrying the retry delay when the server sends one |
| 504 | `GatewayTimeoutError`, a server error; carries the limit and timeout length |
| other 5xx | server error |
| client-side timeout | timeout error |
| method not on this tier | tier error, raised before the request |

All of them descend from one base error, so you can catch broadly or narrowly. The timeout fields
are `limit` and `timeout_seconds` in Python, `limit` and `timeoutSeconds` in TypeScript, and `Limit`
and `TimeoutSeconds` in Go. `GatewayTimeoutError` is a server error in every client, so an existing
server-error check still matches a 504. In TypeScript the 408, 410, 412 and 428 classes extend
`ValidationError`, the class those statuses mapped to before, so `instanceof ValidationError` still
matches them; in Python and Go they derive from the base error.

## What gets retried

Retries are **off by default**; set the retry count to enable them. For ordinary requests,
all three clients retry transport failures and HTTP 429, 502, 503 and 504 by default,
with exponential backoff. Python and TypeScript event streams are not retried.
Python and TypeScript let you replace the status set with `retry_on` and `retryOn` respectively.
Go uses the fixed status set. A server-provided `Retry-After` can override the delay;
Go reads it for 429 responses and caps the delay at 30 seconds.

All three clients filter status retries by HTTP method. A 502, 503 or 504 can arrive after the
server has already accepted the work — a 504 from the handler timeout races a job that was
enqueued — so replaying a `POST` or `PATCH` can submit it twice. The clients therefore retry those
statuses only for `GET`, `HEAD`, `OPTIONS`, `PUT` and `DELETE`, and retry 429 for every method,
because a rate-limited request did no work. To retry `POST` and `PATCH` on the other statuses as
well, opt in:

| Client | Option |
| --- | --- |
| Python | `retry_non_idempotent=True` |
| TypeScript | `retryNonIdempotent: true` |
| Go | `WithRetryNonIdempotent(true)` |

The status set still decides which statuses are considered at all. 408 is not retried by default:
a stalled upload body is not fixed by sending it again unchanged.

Transport failures are still retried for every method, and after one the server may already have
accepted a submission. Keep retries disabled for writes unless repeating the operation is acceptable.

## Waiting for a job is not a retry

Polling a job is a separate loop with its own timeout, and it is not affected by the retry
setting. A job that ends `failed` or `cancelled` raises rather than returning quietly — the wait
promised a result, so not getting one is an error.
