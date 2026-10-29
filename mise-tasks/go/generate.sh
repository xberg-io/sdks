#!/usr/bin/env bash
#MISE description="Regenerate all three Go schema sets (Enterprise + Pro + control plane) via oapi-codegen"
#MISE dir="{{config_root}}/packages/go"
set -euo pipefail

# The Go SDK ships ONE package (`xberg`) with ONE dual-target client, generated from THREE OpenAPI
# specs kept as separate schema sets in the same package (never merged; see xberg-enterprise ADR-0072):
#   - spec/api/openapi.yaml     -> packages/go/generated_api.go     (Xberg Enterprise data plane + shared)
#   - spec/pro/openapi.yaml     -> packages/go/generated_pro.go     (Xberg Pro-only)
#   - spec/backend/openapi.yaml -> packages/go/generated_backend.go (Enterprise control plane)
# No Go identifier may be declared twice in one package, so tools/oapi-schemaset-config splits what a
# later spec shares with an earlier one. An operation, or a schema whose two definitions generate
# IDENTICAL Go, is skipped by the later generation. A schema the specs declare with DIFFERENT
# structures cannot be skipped (that would hand the later set the earlier shape), so it is renamed
# behind a prefix (`Pro`, `Backend`) in a derived copy of that spec (packages/go/spec-{pro,backend}.gen.yaml),
# and oapi-codegen reads that copy. The vendored specs are left untouched so `mise run spec:check`
# still compares them byte-for-byte with upstream. Both the exclusion sets and the renames are DERIVED
# from the specs on every run, never hand-maintained, so a spec sync cannot leave them stale. ~keep
root="$MISE_CONFIG_ROOT"
config_tool=github.com/xberg-io/sdks/tools/oapi-schemaset-config

go tool oapi-codegen --config oapi-codegen-api.yaml "$root/spec/api/openapi.yaml"
go run "$config_tool" \
  -prior "$root/spec/api/openapi.yaml" \
  -spec "$root/spec/pro/openapi.yaml" \
  -prefix Pro \
  -base oapi-codegen-pro.yaml \
  -out oapi-codegen-pro.gen.yaml
# The derived spec, not the vendored one: oapi-schemaset-config renames any schema the two specs
# declare with different shapes, so both can live in one package. Its output path is written beside
# each derived config; see tools/oapi-schemaset-config.
go tool oapi-codegen --config oapi-codegen-pro.gen.yaml spec-pro.gen.yaml
# The control plane is third, so both earlier sets are `-prior`. Pro is passed as its DERIVED copy:
# the names that run moved behind a `Pro` prefix are what the package declares, and the names it
# vacated are free here.
go run "$config_tool" \
  -prior "$root/spec/api/openapi.yaml" \
  -prior spec-pro.gen.yaml \
  -spec "$root/spec/backend/openapi.yaml" \
  -prefix Backend \
  -base oapi-codegen-backend.yaml \
  -out oapi-codegen-backend.gen.yaml
go tool oapi-codegen --config oapi-codegen-backend.gen.yaml spec-backend.gen.yaml
go fmt ./...
