#!/usr/bin/env bash
#MISE description="Refresh the Enterprise spec from a running xberg-enterprise API server"
set -euo pipefail
source "$MISE_CONFIG_ROOT/mise-tasks/.lib/spec.sh"

: "${XBERG_ENTERPRISE_URL:?Set XBERG_ENTERPRISE_URL to the base URL of your Enterprise deployment}"
vendored=$(spec_vendored api)
curl -fsSL "$XBERG_ENTERPRISE_URL/api-doc/openapi.json" | yq -P -oy '.' >"$vendored"
git diff --stat -- "$vendored" || true
