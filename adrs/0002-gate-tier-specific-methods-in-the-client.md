---
status: accepted
date: 2026-07-31
decision-makers: ["Na'aman Hirschfeld"]
---

# Gate tier-specific methods in the client

## Context and Problem Statement

ADR-0001 gives each language one client for both Enterprise and Pro. Some operations exist on only one tier. Sent to
the other tier, such a call reaches a route that was never mounted and comes back as a bare 404, which does not say
that the method belongs to the other product.

## Considered Options

* Gate tier-specific methods in the client, resolving the tier from an explicit `target` or one cached `GET /healthz`
  probe
* Send every call and let the server answer with a 404

## Decision Outcome

Chosen option: "Gate tier-specific methods in the client, resolving the tier from an explicit `target` or one cached
`GET /healthz` probe", because a tier error raised before the request is much easier to read than a 404 from a route
that was never there (`docs-site/src/content/docs/concepts/tiers.md:24`).

* A tier-specific method resolves the tier first: the `target` the caller passed (`WithTarget` in Go), or else the
  `tier` field of `GET /healthz`, probed once, single-flight, and cached for the client's lifetime. A failed probe
  is not cached.
* On a mismatch the client raises before any request goes out: `TierError` in Go, the base error in Python and
  TypeScript.
* Shared methods are never gated and never probe, so a client that only extracts and polls jobs never calls
  `/healthz`.

The gate came with the dual-target rework of all three clients (aca1bf4, 8431d14, 285925f).

### Consequences

* Good, because calling a method on the wrong product fails with a message naming the method and the tier it needs.
* Good, because a caller that passes `target` sends no probe at all.
* Bad, because without `target` the first tier-specific call costs an extra request and depends on `/healthz`
  being reachable.
* Bad, because the gate is a per-method table in each client that must follow the specs; a method gated to the
  wrong tier throws on a tier that serves it, as 4ecacd6 found for the presets endpoints.

### Confirmation

* `packages/python/src/xberg_io_sdk/client.py:1208` (`_resolve_tier`) and `client.py:1225` (`_require_tier`).
* `packages/go/client.go:59` (`WithTarget`) and `packages/go/errors.go:243` (`TierError`).
* `packages/typescript/tests/dual-target.test.ts:79` and `dual-target.test.ts:84` ("without an HTTP call");
  `packages/go/dual_target_test.go:99` and `dual_target_test.go:121` (`TestTierGate_*`).
* `docs-site/src/content/docs/reference/tier-capabilities.md` lists which methods each tier serves.
