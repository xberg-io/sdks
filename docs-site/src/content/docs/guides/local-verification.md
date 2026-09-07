---
title: Verify a local deployment
description: Run SDK contracts and documentation examples against isolated Pro and Enterprise stacks.
---

The repository's live checks use the SDK to submit documents, poll jobs, read results and manage
saved presets. Enterprise checks also exercise enrichment, uploads and document versions.
Failures identify a contract mismatch that transport fixtures alone cannot detect.

## Prepare the deployments

Run commands from the SDK repository after `task setup`. Set `XBERG_ENTERPRISE_DIR` to the sibling
Enterprise checkout containing the shipping Compose files, migration scripts and specifications.
The default is `../xberg-enterprise`.

For Enterprise, set `XBERG_ENTERPRISE_BINARY_DIR` to a directory containing Linux release binaries
for `api`, `backend`, `worker`, `rag`, `vector-index-broker`, `vector-index-broker-launcher` and
`vector-index-worker`. Set `XBERG_ENTERPRISE_RUNTIME_IMAGE` to the locally built image providing
those binaries' native runtime libraries. The harness mounts the binaries read-only and runs
services with separate identities.

For Pro, build the shipping `services/pro/Dockerfile` and set `PRO_IMAGE` to that local image tag.
Set `XBERG_PRO_LICENSE_FILE` to a private environment file containing your license assignment.
The harness supplies an explicit administrator key to its own container.

Set `XBERG_ENTERPRISE_STATE_DIR` and `XBERG_PRO_STATE_DIR` to separate private directories. Each
stack gets its own Compose project, random credentials, loopback ports and volumes. Keep these
state directories out of version control; they contain credentials.

## Run the checks

Start the stacks with `task enterprise:up` and `task pro:up`, then run `task enterprise:verify`
and `task pro:verify`. Both commands fail if an expected check is missing or unsuccessful.

`task docs:snippets:test` builds the local Python wheel and TypeScript tarball, then compiles and
executes every declared example against its supported tiers. Go examples use the local module.
Dependencies must already be cached: the runner installs offline and requires local service URLs.
Missing state, unsupported metadata, empty discovery and failed examples fail the gate.

`task validate` includes the snippet gate. `task release:check` additionally checks both live
contracts, version agreement, specification drift and package builds before a release.

Stop only these stacks with `task enterprise:down` and `task pro:down`. Their `reset` counterparts
also remove the corresponding data volumes. Retain the private state directory to reconnect or
inspect a failed run.
