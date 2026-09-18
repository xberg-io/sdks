---
title: Tiers and capability gating
description: How one client serves both Xberg Enterprise and Xberg Pro.
---

Xberg ships as two products over one overlapping API. Rather than two packages per language, each
package carries one client that works against either.

## Resolving the tier

The client learns what it is talking to in one of two ways.

**Explicitly.** Pass `target` — `"enterprise"` or `"pro"`. No probe is issued.

**By probing.** Omit `target` and the first tier-specific call reads `GET /healthz`, which reports
the tier. The answer is cached for the client's lifetime, so the probe happens at most once.

Prefer passing `target` when you know it: it removes a request from your first call and removes a
dependency on `/healthz` being reachable.

## What gating does

A method the connected tier does not serve raises a tier error *before* any request goes out. That
is deliberate — the alternative is a 404 from a route that was never there, which is much harder to
read. See [Tier capabilities](/reference/tier-capabilities/) for the full matrix.

Shared methods are never gated and never trigger a probe, so a client used only for extraction and
jobs will not call `/healthz` at all.

## Base URLs

Enterprise and Pro are self-hosted, so the deployment base URL must be supplied.
