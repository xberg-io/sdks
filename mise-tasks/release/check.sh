#!/usr/bin/env bash
#MISE description="Pre-flight: version consistency, spec + reference drift, lint, test, build"
set -euo pipefail

version=$(cat VERSION)
python3 - "$version" <<'PY' || {
import re
import sys

sys.exit(0 if re.match(r"^\d+\.\d+\.\d+([-+][\w.+-]+)?$", sys.argv[1]) else 1)
PY
  echo "VERSION '$version' is not valid semver" >&2
  exit 1
}
echo "version: $version"
# A bump that half-applies is what broke the last release: four manifests were written and the fifth
# raised, so the tag push failed validate-versions. Check every manifest agrees before anything else runs.
python3 scripts/sync-versions.py --check
for task in spec:check spec:coverage docs:reference:check lint test build go:test:package \
  enterprise:verify pro:verify docs:snippets:test; do
  mise run "$task"
done
echo "ready to tag v$version"
