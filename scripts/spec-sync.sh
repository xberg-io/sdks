#!/usr/bin/env bash
# Helpers for .github/workflows/spec-sync.yml. Subcommands:
#   resolve  PAYLOAD_REF / PAYLOAD_VERSION -> ref, version, branch   (before the upstream checkout)
#   sha      UPSTREAM_DIR HEAD -> sha                                (after the upstream checkout)
#   body     COVERAGE_FILE + resolved values -> BODY_FILE            (the PR description)
# Outputs go to $GITHUB_OUTPUT. ~keep Every value that reaches a branch name, commit message or
# PR body is validated against an allowlist here, because it arrives in a repository_dispatch
# payload that any holder of the dispatch credential controls.
set -euo pipefail

: "${GITHUB_OUTPUT:?GITHUB_OUTPUT is required}"

fail() {
  echo "spec-sync: $*" >&2
  exit 1
}

emit() {
  printf '%s=%s\n' "$1" "$2" >>"$GITHUB_OUTPUT"
}

resolve() {
  local ref="${PAYLOAD_REF:-development}" version="${PAYLOAD_VERSION:-latest}"
  [[ "$ref" =~ ^[A-Za-z0-9][A-Za-z0-9._/-]*$ && "$ref" != *..* ]] || fail "invalid ref '$ref'"
  [[ "$version" =~ ^[A-Za-z0-9][A-Za-z0-9._+-]*$ ]] || fail "invalid version '$version'"
  emit ref "$ref"
  emit version "$version"
  emit branch "chore/spec-sync-${ref//[^A-Za-z0-9_-]/-}"
}

sha() {
  local dir="${UPSTREAM_DIR:?UPSTREAM_DIR is required}" sha
  sha=$(git -C "$dir" rev-parse HEAD) || fail "cannot resolve HEAD in $dir"
  [[ "$sha" =~ ^[0-9a-f]{40}$ ]] || fail "unexpected revision '$sha'"
  emit sha "$sha"
}

body() {
  local ref="${REF:?REF is required}" version="${VERSION:?VERSION is required}" sha="${SHA:?SHA is required}"
  local coverage="${COVERAGE_FILE:?COVERAGE_FILE is required}" out="${BODY_FILE:?BODY_FILE is required}"
  [ -f "$coverage" ] || fail "coverage report $coverage does not exist"
  # A crashed coverage run leaves a file with no tier rows; reading it as "no gaps" would hide the crash. ~keep
  grep -q 'reached,' "$coverage" || fail "coverage report $coverage has no tier rows; the check did not run"
  {
    printf '%s\n\n' "Automated sync of the three vendored OpenAPI specs from \`xberg-io/xberg-enterprise\`."
    printf -- '- ref: %s\n- commit: %s\n- version: %s\n\n' "\`$ref\`" "\`$sha\`" "\`$version\`"
    printf 'All three clients (Python, TypeScript, Go) were regenerated. Per-language CI runs the full\n'
    printf 'suites on this PR.\n\n'
    if grep -q 'in no client' "$coverage"; then
      printf 'Spec coverage gaps (reported, not blocking this PR):\n\n%s\n' '```'
      grep -E 'in no client|reached,' "$coverage"
      printf '%s\n' '```'
    else
      printf 'Spec coverage: no gaps.\n'
    fi
  } >"$out"
}

case "${1:-}" in
resolve) resolve ;;
sha) sha ;;
body) body ;;
*) fail "usage: $0 resolve|sha|body" ;;
esac
