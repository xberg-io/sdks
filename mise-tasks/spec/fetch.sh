#!/usr/bin/env bash
#MISE description="Refresh all three vendored specs (or one set) from the sibling xberg-enterprise repo"
#USAGE arg "[set]" help="Only this schema set" {
#USAGE   choices "api" "pro" "backend"
#USAGE }
# shellcheck disable=SC2154 # usage_* are set by mise from the #USAGE lines
set -euo pipefail
source "$MISE_CONFIG_ROOT/mise-tasks/.lib/spec.sh"

if [ -n "${usage_set:-}" ]; then
  sets=("$usage_set")
else
  sets=("${SPEC_SETS[@]}")
fi
vendored=()
for set in "${sets[@]}"; do
  upstream=$(spec_upstream "$set")
  target=$(spec_vendored "$set")
  # A missing or unparsable upstream must not leave a truncated vendored spec behind. ~keep
  spec_normalise "$upstream" >"$target.tmp" || {
    rm -f "$target.tmp"
    exit 1
  }
  mv "$target.tmp" "$target"
  vendored+=("$target")
done
git diff --stat -- "${vendored[@]}" || true
