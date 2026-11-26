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

# Upstream routes a set does not vendor, one per line. xberg-enterprise still emits the retired billing
# routes (sdks#55), so deleting them by hand would be undone by the next sync. Only the paths and their
# tag go: the response schemas stay because the Go module's published-type contract
# (packages/go/testdata/public-v0.8.0) pins BillingResponse, CheckoutResponse and PortalResponse. A
# renamed upstream route escapes this filter and then fails `mise run spec:coverage` as an unreached
# operation, so the filter cannot hide a new route. ~keep
spec_retired_paths() {
  case "$1" in
  backend) printf '%s\n' '/v1/projects/{id}/billing' '/v1/projects/{id}/billing/checkout' '/v1/projects/{id}/billing/portal' ;;
  esac
}

spec_retired_tags() {
  case "$1" in
  backend) printf '%s\n' billing ;;
  esac
}

# Normalise an OpenAPI document of set $1 at path $2 to the vendored YAML form, dropping retired routes.
spec_normalise() {
  RETIRED_PATHS="$(spec_retired_paths "$1")" RETIRED_TAGS="$(spec_retired_tags "$1")" yq -P -oy '
    (strenv(RETIRED_PATHS) | split("\n")) as $paths |
    (strenv(RETIRED_TAGS) | split("\n")) as $tags |
    del(.paths[] | select(key as $route | $paths | any_c(. == $route))) |
    del(.tags[]? | select(.name as $name | $tags | any_c(. == $name)))
  ' "$2"
}
