#!/usr/bin/env python3
"""Sync the version from the root VERSION file into all package manifests.

Single source of truth: ``VERSION`` at the repo root. Run this script (or
``task version:sync``) after bumping it to propagate to every language package.
Pass ``--check`` to report drift and exit non-zero without writing anything,
which is what the release pre-flight wants.

Affected files:
  - packages/python/pyproject.toml                          (``project.version``)
  - packages/typescript/package.json                        (``version``)
  - packages/typescript/src/version.ts                      (``export const VERSION``)
  - packages/python/src/xberg_io_sdk/__init__.py            (``__version__``)
  - packages/go/version.go                                  (``const Version``)
Go module versions for the module path itself live in git tags only.
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
TYPESCRIPT_VERSION_TS = REPO_ROOT / "packages" / "typescript" / "src" / "version.ts"
PYTHON_INIT = REPO_ROOT / "packages" / "python" / "src" / "xberg_io_sdk" / "__init__.py"
GO_VERSION = REPO_ROOT / "packages" / "go" / "version.go"

VERSION_PATTERN = re.compile(r"^\d+\.\d+\.\d+(?:[-+][\w.+-]+)?$")
CHECK_FLAG = "--check"


def read_version() -> str:
    """Return the canonical version string from the repo-root VERSION file."""
    raw = VERSION_FILE.read_text(encoding="utf-8").strip()
    if not VERSION_PATTERN.match(raw):
        sys.exit(f"VERSION file contains invalid semver: {raw!r}")
    return raw


def update_pyproject(path: Path, version: str, *, write: bool) -> bool:
    """Rewrite the ``project.version`` line in a pyproject.toml; return True if it differs from ``version``."""
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
    if write:
        path.write_text(new_text, encoding="utf-8")
    return True


def update_package_json(path: Path, version: str, *, write: bool) -> bool:
    """Point a package.json ``version`` at ``version``; return True if it differs.

    The value is substituted in place rather than by re-serialising the parsed
    document. A ``json.dumps(..., indent=2)`` round-trip rewrote every array in
    the file onto one element per line, so cutting 0.4.0 reformatted
    ``keywords`` and ``files`` as a side effect of the version bump and left
    ``main`` failing ``poly fmt --check``. The document is still parsed, but
    only to read the current value.
    """
    text = path.read_text(encoding="utf-8")
    if json.loads(text).get("version") == version:
        return False
    new_text, count = re.subn(
        r'(?m)^(  "version": ")[^"]+(")',
        rf"\g<1>{version}\g<2>",
        text,
        count=1,
    )
    if count == 0:
        sys.exit(f'no top-level "version" field found in {path}')
    if write:
        path.write_text(new_text, encoding="utf-8")
    return True


def update_typescript_version(path: Path, version: str, *, write: bool) -> bool:
    """Rewrite the ``export const VERSION`` literal in the TS version.ts; return True if it differs from ``version``."""
    text = path.read_text(encoding="utf-8")
    new_text, count = re.subn(
        r'(?m)^(export const VERSION\s*=\s*")[^"]+(")',
        rf"\g<1>{version}\g<2>",
        text,
        count=1,
    )
    if count == 0:
        sys.exit(f"no `export const VERSION` line found in {path}")
    if new_text == text:
        return False
    if write:
        path.write_text(new_text, encoding="utf-8")
    return True


def update_python_init(path: Path, version: str, *, write: bool) -> bool:
    """Rewrite the ``__version__`` literal in the Python package __init__.py; return True if it differs from ``version``."""
    text = path.read_text(encoding="utf-8")
    new_text, count = re.subn(
        r'(?m)^(__version__\s*=\s*")[^"]+(")',
        rf"\g<1>{version}\g<2>",
        text,
        count=1,
    )
    if count == 0:
        sys.exit(f"no __version__ line found in {path}")
    if new_text == text:
        return False
    if write:
        path.write_text(new_text, encoding="utf-8")
    return True


def update_go_version(path: Path, version: str, *, write: bool) -> bool:
    """Rewrite the ``const Version`` literal in the Go version.go; return True if it differs from ``version``."""
    text = path.read_text(encoding="utf-8")
    new_text, count = re.subn(
        r'(?m)^(const Version\s*=\s*")[^"]+(")',
        rf"\g<1>{version}\g<2>",
        text,
        count=1,
    )
    if count == 0:
        sys.exit(f"no `const Version` line found in {path}")
    if new_text == text:
        return False
    if write:
        path.write_text(new_text, encoding="utf-8")
    return True


def require_all_targets_exist(paths: list[Path]) -> None:
    """Abort before writing anything if a target file is missing.

    Every updater does a bare ``read_text``, so a stale path raised
    ``FileNotFoundError`` only once the earlier files had already been
    rewritten. A bump then half-applied: the Python and TypeScript manifests
    moved, the Go constant did not, and the next tag push failed
    ``validate-versions`` in CI rather than here. Checking up front makes a
    renamed package a loud no-op instead of a silent partial write.
    """
    missing = [str(path.relative_to(REPO_ROOT)) for path in paths if not path.is_file()]
    if missing:
        sys.exit(f"version target(s) missing: {', '.join(missing)}")


def parse_arguments(argv: list[str]) -> bool:
    """Return True when the caller asked for a read-only drift check."""
    unrecognised = [argument for argument in argv if argument != CHECK_FLAG]
    if unrecognised:
        sys.exit(f"unrecognised argument(s): {' '.join(unrecognised)} (only {CHECK_FLAG} is accepted)")
    return CHECK_FLAG in argv


def update_targets(version: str, *, write: bool) -> list[str]:
    """Validate or update all manifests and return the paths with version drift."""
    drifted: list[str] = []
    if update_pyproject(PYTHON_PYPROJECT, version, write=write):
        drifted.append(str(PYTHON_PYPROJECT.relative_to(REPO_ROOT)))
    if update_package_json(TYPESCRIPT_PACKAGE, version, write=write):
        drifted.append(str(TYPESCRIPT_PACKAGE.relative_to(REPO_ROOT)))
    if update_typescript_version(TYPESCRIPT_VERSION_TS, version, write=write):
        drifted.append(str(TYPESCRIPT_VERSION_TS.relative_to(REPO_ROOT)))
    if update_python_init(PYTHON_INIT, version, write=write):
        drifted.append(str(PYTHON_INIT.relative_to(REPO_ROOT)))
    if update_go_version(GO_VERSION, version, write=write):
        drifted.append(str(GO_VERSION.relative_to(REPO_ROOT)))

    return drifted


def main(argv: list[str]) -> int:
    """Propagate the root VERSION to every manifest, or under ``--check`` report drift without writing."""
    check_only = parse_arguments(argv)
    version = read_version()
    require_all_targets_exist([PYTHON_PYPROJECT, TYPESCRIPT_PACKAGE, TYPESCRIPT_VERSION_TS, PYTHON_INIT, GO_VERSION])
    drifted = update_targets(version, write=False)
    if drifted and not check_only:
        update_targets(version, write=True)

    if not drifted:
        print(f"version {version} already in sync")  # noqa: T201
        return 0
    if check_only:
        sys.stderr.write(f"VERSION says {version}, but it is not applied to:\n")
        for name in drifted:
            sys.stderr.write(f"  {name}\n")
        sys.stderr.write("run `task version:sync` to propagate it\n")
        return 1
    print(f"synced version {version} -> {', '.join(drifted)}")  # noqa: T201
    return 0


if __name__ == "__main__":
    sys.exit(main(sys.argv[1:]))
