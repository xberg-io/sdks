// Package xberg is the official Go client for the Xberg Enterprise and Xberg
// Pro document-processing APIs.
//
// One [Client] speaks to either product. The shared surface — extraction,
// jobs (including job results), audit, the curated preset registry, saved
// presets, auto-tune with its tuning-profile registry, and the RAG API — is
// written once and carries no tier gate. Tier-specific methods are
// capability-gated: they probe the connected instance (GET /healthz's tier, or
// an explicit target set via [WithTarget]) and return a clear [TierError]
// instead of a raw 404 when invoked against the wrong tier.
//
// Both products authenticate identically via a Bearer token. Enterprise and
// Pro are self-hosted and require [WithBaseURL].
//
// Enterprise splits into two binaries — the data plane the base URL addresses
// and a control plane (projects, API keys, integrations) on its own origin —
// while Pro serves both from one. [WithControlPlaneBaseURL] records the origin
// of the second and defaults to the data-plane base URL; no method routes there
// yet, so today it is configuration held for the control-plane operations that
// have not landed.
//
// Most users should construct a [Client] via [New] and pass a context.Context
// to each request method.
package xberg
