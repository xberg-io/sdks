"""Ensure backend coverage cannot be satisfied by a same-path data-plane call."""

from __future__ import annotations

import shutil
import subprocess
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]


def run_gate(tmp_path: Path, source: str) -> subprocess.CompletedProcess[str]:
    shutil.copytree(ROOT / "spec", tmp_path / "spec")
    (tmp_path / "scripts").mkdir()
    shutil.copy(ROOT / "scripts/spec-coverage.py", tmp_path / "scripts/spec-coverage.py")
    client = tmp_path / "packages/python/src/xberg_io_sdk/client.py"
    client.parent.mkdir(parents=True)
    client.write_text(source)
    return subprocess.run(  # noqa: S603
        [sys.executable, str(tmp_path / "scripts/spec-coverage.py")], capture_output=True, text=True, check=False
    )


def test_gate_counts_every_backend_operation(tmp_path: Path) -> None:
    source = (ROOT / "packages/python/src/xberg_io_sdk/client.py").read_text()
    result = run_gate(tmp_path, source)
    assert result.returncode == 0, result.stdout + result.stderr
    assert "backend     48/48 reached, 0 excluded" in result.stdout


def test_data_plane_and_comments_cannot_hide_missing_backend_operation(tmp_path: Path) -> None:
    source = (ROOT / "packages/python/src/xberg_io_sdk/client.py").read_text()
    start = source.index("    def backend_list_projects(")
    end = source.index("    def backend_create_project(", start)
    original = source[start:end]
    assert original.count('_request_control_json("GET", "/v1/projects"') == 1
    replacement = original.replace("_request_control_json", "_request_json")
    replacement += '    # self._request_control_json("GET", "/v1/projects")\n'
    result = run_gate(tmp_path, source[:start] + replacement + source[end:])
    assert result.returncode == 1, result.stdout + result.stderr
    assert "backend: GET /v1/projects" in result.stderr


def test_backend_methods_do_not_satisfy_pro_coverage(tmp_path: Path) -> None:
    source = (ROOT / "packages/python/src/xberg_io_sdk/client.py").read_text()
    start = source.index("    def list_projects(")
    end = source.index("    def create_project(", start)
    result = run_gate(tmp_path, source[:start] + source[end:])
    assert result.returncode == 1, result.stdout + result.stderr
    assert "pro: GET /v1/projects" in result.stderr
