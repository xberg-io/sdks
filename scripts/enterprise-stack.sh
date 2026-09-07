#!/usr/bin/env bash
set -euo pipefail
root="$(cd "$(dirname "$0")/.." && pwd)"
exec uv run --project "$root" python "$root/scripts/enterprise-stack.py" "$@"
