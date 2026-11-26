setup() {
  bats_load_library xberg-bats
  xberg_setup
  REPO_ROOT="$(cd "$BATS_TEST_DIRNAME/../.." && pwd -P)"
  UPSTREAM="$XBERG_WORK/upstream"
  mkdir -p "$UPSTREAM/frontend" "$UPSTREAM/services/api/spec" "$UPSTREAM/services/pro/spec" "$XBERG_WORK/spec"/{api,pro,backend}
  # The same document for every set: only the backend set retires the billing routes.
  cat >"$UPSTREAM/frontend/openapi-backend.yaml" <<'YAML'
openapi: 3.1.0
paths:
  /v1/projects/{id}:
    get:
      tags: [projects]
      operationId: get_project
  /v1/projects/{id}/billing:
    get:
      tags: [billing]
      operationId: get_billing
      responses:
        "200":
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/BillingResponse'
  /v1/projects/{id}/billing/checkout:
    post:
      tags: [billing]
      operationId: create_checkout
  /v1/projects/{id}/billing/portal:
    post:
      tags: [billing]
      operationId: create_portal
  /v1/projects/{id}/billing-history:
    get:
      tags: [projects]
      operationId: billing_history
components:
  schemas:
    BillingResponse:
      type: object
tags:
  - name: projects
  - name: billing
YAML
  yq -oj '.' "$UPSTREAM/frontend/openapi-backend.yaml" >"$UPSTREAM/services/api/spec/openapi.json"
  cp "$UPSTREAM/services/api/spec/openapi.json" "$UPSTREAM/services/pro/spec/openapi.json"
}

fetch() {
  (cd "$XBERG_WORK" && MISE_CONFIG_ROOT="$REPO_ROOT" XBERG_ENTERPRISE_DIR="$UPSTREAM" bash "$REPO_ROOT/mise-tasks/spec/fetch.sh")
}

@test "fetch drops the retired billing routes and their tag from the backend set only" {
  run fetch
  xberg_assert_status 0
  run yq -r '.paths | keys | join(" ")' "$XBERG_WORK/spec/backend/openapi.yaml"
  xberg_assert_output "/v1/projects/{id} /v1/projects/{id}/billing-history"
  run yq -r '[.tags[].name] | join(" ")' "$XBERG_WORK/spec/backend/openapi.yaml"
  xberg_assert_output "projects"
  # Kept on purpose: the Go module's published-type contract pins the billing schemas.
  run yq -r '.components.schemas | keys | join(" ")' "$XBERG_WORK/spec/backend/openapi.yaml"
  xberg_assert_output "BillingResponse"
  for set in api pro; do
    run yq -r '.paths | keys | length' "$XBERG_WORK/spec/$set/openapi.yaml"
    xberg_assert_output "5"
  done
}

@test "fetch of an upstream without the retired routes changes nothing else" {
  yq -i 'del(.paths["/v1/projects/{id}/billing", "/v1/projects/{id}/billing/checkout", "/v1/projects/{id}/billing/portal"]) | del(.tags[1])' \
    "$UPSTREAM/frontend/openapi-backend.yaml"
  run fetch
  xberg_assert_status 0
  run diff <(yq -P -oy '.' "$UPSTREAM/frontend/openapi-backend.yaml") "$XBERG_WORK/spec/backend/openapi.yaml"
  xberg_assert_status 0
}
