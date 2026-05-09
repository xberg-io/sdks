#!/usr/bin/env python3
"""Sync the version from the root VERSION file into all package manifests.

Single source of truth: ``VERSION`` at the repo root. Run this script (or
``task version:sync``) after bumping it to propagate to every language package.

Affected files:
  - packages/python/pyproject.toml      (``project.version``)
  - packages/typescript/package.json    (``version``)
Go module versions live in git tags only and are intentionally not touched.
"""

from __future__ import annotations

import json
import re
import sys
from pathlib import Path

REPO_ROOT = Path(__file__).resolve().parent.parent
VERSION_FILE = REPO_ROOT / "VERSION"
PYTHON_PYPROJECT = REPO_ROOT / "packages" / "python" / "pyproject.toml"
TYPESCRIPT_PACKAGE = REPO_ROOT / "packages" / "typescript" / "package.json"

VERSION_PATTERN = re.compile(r"^\d+\.\d+\.\d+(?:[-+][\w.+-]+)?$")


def read_version() -> str:
    """Return the canonical version string from the repo-root VERSION file."""
    raw = VERSION_FILE.read_text(encoding="utf-8").strip()
    if not VERSION_PATTERN.match(raw):
        sys.exit(f"VERSION file contains invalid semver: {raw!r}")
    return raw


def update_pyproject(path: Path, version: str) -> bool:
    """Rewrite the ``project.version`` line in a pyproject.toml; return True if changed."""
    text = path.read_text(encoding="utf-8")
    new_text, count = re.subn(
        r'(?m)^(version\s*=\s*")[^"]+(")',
        rf"\g<1>{version}\g<2>",
        text,
        count=1,
    )
    if count == 0:
        sys.exit(f"no version line found in {path}")
    if new_text == text:
        return False
    path.write_text(new_text, encoding="utf-8")
    return True


def update_package_json(path: Path, version: str) -> bool:
    """Rewrite the ``version`` field in a package.json; return True if changed."""
    raw = path.read_text(encoding="utf-8")
    data = json.loads(raw)
    if data.get("version") == version:
        return False
    data["version"] = version
    path.write_text(json.dumps(data, indent=2) + "\n", encoding="utf-8")
    return True


def main() -> int:
    """Propagate the root VERSION value to every per-package manifest."""
    version = read_version()
    changed: list[str] = []
    if update_pyproject(PYTHON_PYPROJECT, version):
        changed.append(str(PYTHON_PYPROJECT.relative_to(REPO_ROOT)))
    if update_package_json(TYPESCRIPT_PACKAGE, version):
        changed.append(str(TYPESCRIPT_PACKAGE.relative_to(REPO_ROOT)))
    if changed:
        print(f"synced version {version} -> {', '.join(changed)}")  # noqa: T201
    else:
        print(f"version {version} already in sync")  # noqa: T201
    return 0


if __name__ == "__main__":
    sys.exit(main())
