#!/usr/bin/env bash
set -euo pipefail
: "${XBERG_ADMIN_KEY:?XBERG_ADMIN_KEY is required; set the operator credential explicitly}"
root="$(cd "$(dirname "$0")/.." && pwd)"
exec uv run --project "$root" python "$root/scripts/live-sdk-contracts.py" pro-key --base-url "${1:-http://127.0.0.1:8080}"
