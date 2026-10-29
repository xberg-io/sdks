#!/usr/bin/env bash
#MISE description="Create the unified release tag (vX.Y.Z); refuses if the working tree is dirty"
set -euo pipefail

if [ -n "$(git status --porcelain)" ]; then
  echo "working tree is dirty; commit or stash before tagging" >&2
  exit 1
fi
tag="v$(cat VERSION)"
if git rev-parse "$tag" >/dev/null 2>&1; then
  echo "tag $tag already exists locally" >&2
  exit 1
fi
git tag -a "$tag" -m "Release $tag"
echo "created tag $tag; push with: git push origin $tag"
