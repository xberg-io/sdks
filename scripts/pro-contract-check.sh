#!/usr/bin/env bash
set -euo pipefail
root="$(cd "$(dirname "$0")/.." && pwd)"
exec uv run --project "$root" python "$root/scripts/live-sdk-contracts.py" verify --tier pro --base-url "${1:-http://127.0.0.1:8080}"
