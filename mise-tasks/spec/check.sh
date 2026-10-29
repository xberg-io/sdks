#!/usr/bin/env bash
#MISE description="Fail if a vendored spec drifted from the sibling xberg-enterprise copy"
set -euo pipefail
source "$MISE_CONFIG_ROOT/mise-tasks/.lib/spec.sh"

for set in "${SPEC_SETS[@]}"; do
  upstream=$(spec_upstream "$set")
  diff -q <(spec_normalise "$upstream") "$(spec_vendored "$set")"
done
