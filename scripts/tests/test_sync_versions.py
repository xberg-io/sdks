"""Contract tests for scripts/sync-versions.py.

The release pre-flight runs the script with ``--check`` to prove every manifest
already agrees with ``VERSION``. That only means something if the flag refuses
to write: a checker that silently repairs the drift it finds reports success on
a tree that was broken, which is what happened before this suite existed.

Each test builds a throwaway repository in ``tmp_path`` and runs the real
command line, because the exit code and the on-disk result are the whole
contract the Taskfile depends on.
"""

from __future__ import annotations

import shutil
import subprocess
import sys
from pathlib import Path

import pytest

REPO_ROOT = Path(__file__).resolve().parent.parent.parent
SCRIPT = REPO_ROOT / "scripts" / "sync-versions.py"

GO_VERSION_RELATIVE = "packages/go/version.go"
PACKAGE_JSON_RELATIVE = "packages/typescript/package.json"
MANIFESTS = {
    "packages/python/pyproject.toml": '[project]\nname = "x"\nversion = "{version}"\n',
    PACKAGE_JSON_RELATIVE: (
        '{{\n  "name": "x",\n  "version": "{version}",\n  "keywords": ["one", "two"],\n  "files": ["dist"]\n}}\n'
    ),
    "packages/typescript/src/version.ts": 'export const VERSION = "{version}";\n',
    "packages/python/src/xberg_io_sdk/__init__.py": '__version__ = "{version}"\n',
    GO_VERSION_RELATIVE: 'package xberg\n\nconst Version = "{version}"\n',
}


def build_repository(root: Path, *, version: str, manifest_version: str) -> None:
    """Write a minimal tree the script recognises, with every manifest at manifest_version."""
    (root / "scripts").mkdir(parents=True)
    shutil.copy(SCRIPT, root / "scripts" / SCRIPT.name)
    (root / "VERSION").write_text(f"{version}\n", encoding="utf-8")
    for relative, template in MANIFESTS.items():
        path = root / relative
        path.parent.mkdir(parents=True, exist_ok=True)
        path.write_text(template.format(version=manifest_version), encoding="utf-8")


def run_script(root: Path, *arguments: str) -> subprocess.CompletedProcess[str]:
    """Invoke the copied script exactly as the Taskfile does."""
    return subprocess.run(  # noqa: S603
        [sys.executable, str(root / "scripts" / SCRIPT.name), *arguments],
        capture_output=True,
        text=True,
        check=False,
    )


def test_check_reports_drift_and_writes_nothing(tmp_path: Path) -> None:
    build_repository(tmp_path, version="1.2.3", manifest_version="0.0.1")
    go_version = tmp_path / GO_VERSION_RELATIVE

    result = run_script(tmp_path, "--check")

    assert result.returncode == 1, result.stdout + result.stderr
    assert GO_VERSION_RELATIVE in result.stderr
    assert '"0.0.1"' in go_version.read_text(encoding="utf-8"), "--check must not repair the drift it reports"


def test_check_passes_when_every_manifest_agrees(tmp_path: Path) -> None:
    build_repository(tmp_path, version="1.2.3", manifest_version="1.2.3")

    result = run_script(tmp_path, "--check")

    assert result.returncode == 0, result.stdout + result.stderr
    assert "already in sync" in result.stdout


def test_bare_invocation_propagates_the_version(tmp_path: Path) -> None:
    build_repository(tmp_path, version="1.2.3", manifest_version="0.0.1")

    result = run_script(tmp_path)

    assert result.returncode == 0, result.stdout + result.stderr
    for relative in MANIFESTS:
        assert '"1.2.3"' in (tmp_path / relative).read_text(encoding="utf-8"), relative


def test_unrecognised_argument_is_refused_before_anything_is_written(tmp_path: Path) -> None:
    build_repository(tmp_path, version="1.2.3", manifest_version="0.0.1")
    go_version = tmp_path / GO_VERSION_RELATIVE

    result = run_script(tmp_path, "--dry-run")

    assert result.returncode != 0
    assert "--dry-run" in result.stderr
    assert '"0.0.1"' in go_version.read_text(encoding="utf-8")


def test_bumping_the_version_leaves_package_json_formatting_alone(tmp_path: Path) -> None:
    """A version bump must not reflow the rest of the document.

    Rewriting the file from ``json.dumps(..., indent=2)`` exploded every array
    onto one element per line, so cutting 0.4.0 reformatted ``keywords`` and
    ``files`` as a side effect and left the repository failing poly fmt.
    """
    build_repository(tmp_path, version="1.2.3", manifest_version="0.0.1")
    package_json = tmp_path / PACKAGE_JSON_RELATIVE

    result = run_script(tmp_path)

    assert result.returncode == 0, result.stdout + result.stderr
    written = package_json.read_text(encoding="utf-8")
    assert '"version": "1.2.3"' in written
    assert '"keywords": ["one", "two"]' in written, "the bump reflowed an array it was not asked to touch"
    assert '"files": ["dist"]' in written


def test_invalid_late_manifest_leaves_every_earlier_manifest_unchanged(tmp_path: Path) -> None:
    build_repository(tmp_path, version="1.2.3", manifest_version="0.0.1")
    (tmp_path / GO_VERSION_RELATIVE).write_text("package xberg\n", encoding="utf-8")
    before = {relative: (tmp_path / relative).read_bytes() for relative in MANIFESTS}

    result = run_script(tmp_path)

    assert result.returncode != 0
    assert "no `const Version` line" in result.stderr
    assert {relative: (tmp_path / relative).read_bytes() for relative in MANIFESTS} == before


@pytest.mark.parametrize("relative", MANIFESTS)
def test_check_rejects_each_individual_manifest_without_repair(tmp_path: Path, relative: str) -> None:
    build_repository(tmp_path, version="1.2.3", manifest_version="1.2.3")
    (tmp_path / relative).write_text(MANIFESTS[relative].format(version="0.0.1"), encoding="utf-8")
    before = {name: (tmp_path / name).read_bytes() for name in MANIFESTS}

    result = run_script(tmp_path, "--check")

    assert result.returncode == 1
    assert relative in result.stderr
    assert {name: (tmp_path / name).read_bytes() for name in MANIFESTS} == before
