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
add a `details` object with structured context — a request timeout, for example:

```json
{
  "error": {
    "code": "gateway_timeout",
    "details": { "limit": "handler", "timeout_seconds": 30 },
    "message": "The server did not produce a response in time"
  }
}
```

Older servers send a flat `{ "error": "<code>", "message": "..." }` body instead. The Python client
decodes both shapes onto the error it raises: `message` (also its `str()`) is the server's message,
and `status`, `code` and `details` are set when the server sent them.

## The hierarchy

Each client maps status codes onto typed errors rather than making you inspect numbers:

| Condition | Error |
| --- | --- |
| 401, 403 | authentication error |
| 400, 422 | validation error |
| 404 | not-found error |
| 408 | request-timeout error (`RequestTimeoutError`), carrying `limit` and `timeout_seconds` |
| 410 | result-expired error (`ResultExpiredError`) |
| 412 | precondition-failed error (`PreconditionFailedError`): the `If-Match` version is stale |
| 428 | precondition-required error (`PreconditionRequiredError`): the request needs `If-Match` |
| 429 | rate-limit error, carrying the retry delay when the server sends one |
| 504 | gateway-timeout error (`GatewayTimeoutError`), a server error carrying `limit` and `timeout_seconds` |
| other 5xx | server error |
| client-side timeout | timeout error |
| method not on this tier | tier error, raised before the request |

All of them descend from one base error, so you can catch broadly or narrowly. The class names in
the table are the Python ones.

## What gets retried

Retries are **off by default**; set the retry count to enable them. For ordinary requests,
all three clients retry transport failures and HTTP 429, 502, 503 and 504 by default,
with exponential backoff. Python and TypeScript event streams are not retried.
Python and TypeScript let you replace the status set with `retry_on` and `retryOn` respectively.
Go uses the fixed status set. A server-provided `Retry-After` can override the delay;
Go reads it for 429 responses and caps the delay at 30 seconds.

The Python client filters status retries by HTTP method. A 502, 503 or 504 can arrive after the
server has already accepted the work — a 504 from the handler timeout races a job that was
enqueued — so replaying a `POST` or `PATCH` can submit it twice. Python therefore retries those
statuses only for `GET`, `HEAD`, `OPTIONS`, `PUT` and `DELETE`, and retries 429 for every method,
because a rate-limited request did no work. Pass `retry_non_idempotent=True` to the client
constructor to retry `POST` and `PATCH` on the other statuses as well; `retry_on` still decides which
statuses are considered at all. 408 is not in the default set: a stalled upload body is not fixed by
sending it again unchanged.

Transport failures are still retried for every method, and after one the server may already have
accepted a submission. Keep retries disabled for writes unless repeating the operation is acceptable.

## Waiting for a job is not a retry

Polling a job is a separate loop with its own timeout, and it is not affected by the retry
setting. A job that ends `failed` or `cancelled` raises rather than returning quietly — the wait
promised a result, so not getting one is an error.
