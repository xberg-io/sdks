#!/usr/bin/env bash
#MISE description="Build local packages and execute every documented snippet on both live tiers"
#MISE depends=["docs:snippets:health:test"]
set -euo pipefail

: "${XBERG_PRO_STATE_DIR:?Set XBERG_PRO_STATE_DIR to the private Pro stack directory}"
: "${XBERG_ENTERPRISE_STATE_DIR:?Set XBERG_ENTERPRISE_STATE_DIR to the private Enterprise stack directory}"
mise run enterprise:prepare-idle-crawl
version=$(cat VERSION)
uv run python scripts/test-snippets.py \
  --python-wheel "dist/xberg_io_sdk-$version-py3-none-any.whl" \
  --typescript-tarball "dist/xberg-io-sdk-$version.tgz" \
  --go-source packages/go \
  --pro-state "$XBERG_PRO_STATE_DIR/state.json" \
  --enterprise-state "$XBERG_ENTERPRISE_STATE_DIR/state.json"
