#!/usr/bin/env bash
#MISE description="Verify four native Pro health examples and their real HTTP negative controls"
#MISE depends=["python:build", "typescript:build"]
set -euo pipefail

pnpm --dir packages/typescript pack --pack-destination ../../dist
version=$(cat VERSION)
uv run python scripts/test-health-snippets.py \
  --python-wheel "dist/xberg_io_sdk-$version-py3-none-any.whl" \
  --typescript-tarball "dist/xberg-io-sdk-$version.tgz" \
  --go-source packages/go
