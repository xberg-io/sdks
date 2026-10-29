#!/usr/bin/env bash
#MISE description="Set a new version, or bump one component, and propagate (usage: mise run version:bump 0.1.0)"
#USAGE arg "<version>" help="The new version, or patch, minor or major to bump that component"
# shellcheck disable=SC2154 # usage_* are set by mise from the #USAGE lines
set -euo pipefail

version_file=VERSION
current=$(cat "$version_file")
case "$usage_version" in
patch | minor | major)
  next=$(
    python3 - "$current" "$usage_version" <<'PY'
import re
import sys

current, part = sys.argv[1], sys.argv[2]
m = re.match(r"^(\d+)\.(\d+)\.(\d+)(.*)$", current)
if m is None:
    raise SystemExit(f"VERSION '{current}' is not X.Y.Z")
major, minor, patch = int(m[1]), int(m[2]), int(m[3])
print({"patch": f"{major}.{minor}.{patch + 1}", "minor": f"{major}.{minor + 1}.0", "major": f"{major + 1}.0.0"}[part])
PY
  )
  ;;
*) next="$usage_version" ;;
esac
echo "$next" >"$version_file"
echo "bumped $current -> $next"
python3 scripts/sync-versions.py
