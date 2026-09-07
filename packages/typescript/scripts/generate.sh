#!/usr/bin/env bash
#
# Generate the three TypeScript schema sets from the vendored OpenAPI specs:
# the Enterprise data plane, Pro, and the Enterprise control plane. Emits
# src/_generated/{api,pro,backend}.d.ts via openapi-typescript.
#
# The schema sets are generated separately and never merged — mirrors
# xberg-enterprise ADR-0072 (operationId collisions + topology honesty). Each
# lands in its own module, so a name several specs share needs no renaming here.
set -euo pipefail

PKG_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
REPO_ROOT="$(cd "${PKG_DIR}/../.." && pwd)"
API_SPEC="${REPO_ROOT}/spec/api/openapi.yaml"
PRO_SPEC="${REPO_ROOT}/spec/pro/openapi.yaml"
BACKEND_SPEC="${REPO_ROOT}/spec/backend/openapi.yaml"
OUT_DIR="${PKG_DIR}/src/_generated"

mkdir -p "${OUT_DIR}"

cd "${PKG_DIR}"
# ~keep Unconstrained object schemas carry user JSON, such as preset schemas and integration credentials.
pnpm exec openapi-typescript "${API_SPEC}" -o "${OUT_DIR}/api.d.ts" --empty-objects-unknown
pnpm exec openapi-typescript "${PRO_SPEC}" -o "${OUT_DIR}/pro.d.ts" --empty-objects-unknown
pnpm exec openapi-typescript "${BACKEND_SPEC}" -o "${OUT_DIR}/backend.d.ts" --empty-objects-unknown
