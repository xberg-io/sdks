# shellcheck shell=bash
# The three vendored schema sets and their upstream sources in a sibling xberg-enterprise checkout.
# Every set is vendored as YAML at spec/<set>/openapi.yaml; the backend source is already YAML upstream
# and is still piped through yq so all three copies carry the same key ordering and quoting. ~keep
SPEC_SETS=(api pro backend)
UPSTREAM_ROOT="${XBERG_ENTERPRISE_DIR:-../xberg-enterprise}"

spec_vendored() {
  printf 'spec/%s/openapi.yaml\n' "$1"
}

spec_upstream() {
  case "$1" in
  api) printf '%s/services/api/spec/openapi.json\n' "$UPSTREAM_ROOT" ;;
  pro) printf '%s/services/pro/spec/openapi.json\n' "$UPSTREAM_ROOT" ;;
  backend) printf '%s/frontend/openapi-backend.yaml\n' "$UPSTREAM_ROOT" ;;
  *)
    echo "unknown spec set '$1' (expected one of: ${SPEC_SETS[*]})" >&2
    return 1
    ;;
  esac
}

# Normalise any OpenAPI document to the vendored YAML form.
spec_normalise() {
  yq -P -oy '.' "$1"
}
