---
title: Tier capabilities
description: Which client methods use Pro, the Enterprise data plane, or the Enterprise control plane.
---

Pro serves its API from one origin. Enterprise serves its data plane at `base_url` and its
control plane at `control_plane_base_url`. Configure both Enterprise origins explicitly when they differ.
The control-plane origin defaults to the data-plane origin.

## Client surfaces

| Surface | Pro | Enterprise | Client behavior |
| --- | --- | --- | --- |
| Extraction, batches, job polling/results/cancellation | Yes | Yes | Shared methods use `base_url`. |
| Curated and saved presets | Yes | Yes | Both tiers serve saved presets at `/v1/saved_presets`. |
| RAG, auto-tune, tuning profiles | Yes | Yes | Shared methods. On Pro these are operator switches (`PRO_RAG_ENABLED`, `PRO_AUTO_TUNE_ENABLED`), both on by default — not licence entitlements. |
| Inline extraction webhooks | Yes | Yes | Supplied on the extraction request. |
| Projects, API keys, integrations, project RAG configuration | Yes | Yes | Existing Pro methods use `base_url`; Enterprise uses dedicated backend methods. |
| Members, invitations, managed webhook subscriptions, billing, analytics | No | Yes | Dedicated Enterprise backend methods use `control_plane_base_url`. |
| Enrichment, upload staging, page images | Yes | Yes | Data-plane methods use `base_url`. |
| Document lineage and versions, extraction telemetry | No | Yes | Enterprise data-plane methods use `base_url`. |
| Crawl event stream | Yes | Yes | Data-plane stream; supply caller cancellation. |

The vendored specifications carry **53** Enterprise data-plane, **67** Pro, and **49**
Enterprise control-plane operations. The clients reach every one of them except the handful
listed as deliberate exclusions in each package README — infrastructure probes and browser
redirect legs that are not API-client surface.
See the [method references](/reference/api-python/) and [OpenAPI reference](/reference/openapi/)
for request and response schemas.

## Method names and compatibility

A backend operation keeps its operation-derived name unless that name already belongs to a Pro method.
Collisions use `backend_` in Python, `backend` in TypeScript, and `Backend` in Go.
For example, Pro uses `list_projects` / `listProjects` / `ListProjects`;
Enterprise uses `backend_list_projects` / `backendListProjects` / `BackendListProjects`.
Existing Pro signatures remain unchanged. Backend schemas can differ even when the route is identical.

## Tier checks

Existing tier-specific methods use an explicit target or lazily discover the tier through `/healthz`.
Dedicated backend methods reject an explicit or already detected Pro target. They do not contact the
data plane merely to discover the tier: they call the configured backend directly.

The Pro readiness probe, browser OAuth callback, and account-erasure route remain outside the
high-level Pro client. Backend methods with those routes do not provide Pro aliases.

## Credentials

`api_key` / `apiKey` / `WithAPIKey` authenticates data-plane calls.
Use `control_plane_token` / `controlPlaneToken` / `WithControlPlaneToken` for a separate backend bearer.
Omitting it falls back to the API key; setting it to an empty string sends no bearer.
Backend requests omit inherited cookies and do not follow redirects.

Public backend health, authentication configuration, login, and OAuth callback calls omit the client's
bearer credentials. Public sandbox extraction accepts its own explicit sandbox token.
See [the control-plane guide](/guides/control-plane/) for the token exchange.
