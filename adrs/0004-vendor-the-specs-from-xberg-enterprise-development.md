---
status: accepted
date: 2026-09-05
decision-makers: ["Na'aman Hirschfeld"]
---

# Vendor the specs from xberg-enterprise development

## Context and Problem Statement

The SDKs generate from OpenAPI specs that xberg-enterprise produces. Since the scaffold (99e810a) they are vendored:
committed under `spec/` and refreshed by a scheduled `spec-sync` workflow that opens a pull request. That workflow
defaulted to xberg-enterprise's `main`, a deploy-only promotion target that trails the default branch `development`
by hundreds of commits. It reported zero drift for weeks while the vendored specs went stale, and `main`'s Pro spec
had no control plane, so an SDK generated from it could not mint the API key needed to authenticate against Pro
(1ee961f).

## Considered Options

* Vendor the specs from xberg-enterprise `development`, overridable by a release dispatch's ref
* Vendor the specs from xberg-enterprise `main`

## Decision Outcome

Chosen option: "Vendor the specs from xberg-enterprise `development`, overridable by a release dispatch's ref",
because `development` is where xberg-enterprise's spec work lands, so syncing it finds real drift and yields a Pro
surface that can authenticate.

* `spec/{api,pro,backend}/openapi.yaml` are normalised copies of `services/api/spec/openapi.json`,
  `services/pro/spec/openapi.json` and `frontend/openapi-backend.yaml` in xberg-enterprise.
* `spec-sync.yml` runs on xberg-enterprise's `spec-updated` repository dispatch, weekly as a fallback, and by hand.
  The ref defaults to `development`; a dispatch's `client_payload.ref` overrides it.
* Locally, `mise run spec:fetch` reads the sibling `../xberg-enterprise` as checked out, or `XBERG_ENTERPRISE_DIR`.

### Consequences

* Good, because generation is reproducible from committed files, and every spec change arrives as a reviewable pull
  request.
* Good, because a release can pin the SDKs to the exact upstream tag through the dispatch ref.
* Bad, because between syncs the SDKs can trail an API that `development` already serves.

### Confirmation

* `scripts/spec-sync.sh:23` (`ref="${PAYLOAD_REF:-development}"`).
* `.github/workflows/spec-sync.yml:9` to `spec-sync.yml:12` (dispatch and weekly schedule) and `spec-sync.yml:67`
  to `spec-sync.yml:80` (the `~keep` note on `development` and the ref step).
* `mise-tasks/.lib/spec.sh:12` to `spec.sh:22` map each set to its upstream file.
* `.ai-rulez/context/area-map.md:15`.
