"""Ensure backend coverage cannot be satisfied by a same-path data-plane call."""

from __future__ import annotations

import re
import shutil
import subprocess
import sys
from pathlib import Path

import pytest
from ruamel.yaml import YAML

ROOT = Path(__file__).resolve().parents[2]

VERBS = ("get", "put", "post", "delete", "patch", "head", "options")
SYNC_ROUTE = "/v1/projects/{project_id}/integrations/{integration_id}/sync"
NORMALIZED_SYNC = "/v1/projects/{}/integrations/{}/sync"


def backend_operation_count() -> int:
    """Count the control-plane spec's operations.

    Derived rather than hard-coded: this assertion carried a stale `48` through a spec sync that
    took the control plane to 49, so a real coverage gain rendered as a test failure.
    """
    document = YAML(typ="safe").load(ROOT / "spec" / "backend" / "openapi.yaml")
    return sum(1 for item in document["paths"].values() for verb in item if verb.lower() in VERBS)


def run_gate(
    tmp_path: Path,
    source: str,
    *,
    tracked_gaps: dict[tuple[str, str, str], str] | None = None,
    backend_sync: bool = False,
    empty_tier: str | None = None,
) -> subprocess.CompletedProcess[str]:
    shutil.copytree(ROOT / "spec", tmp_path / "spec")
    (tmp_path / "scripts").mkdir()
    gate = (ROOT / "scripts/spec-coverage.py").read_text()
    if tracked_gaps is not None:
        gate, count = re.subn(r"^TRACKED_GAPS:.*$", f"TRACKED_GAPS = {tracked_gaps!r}", gate, flags=re.MULTILINE)
        assert count == 1
    (tmp_path / "scripts/spec-coverage.py").write_text(gate)
    if backend_sync:
        spec = tmp_path / "spec/backend/openapi.yaml"
        document = YAML(typ="safe").load(spec)
        document["paths"]["/v1/projects/{project_id}/integrations/{integration_id}/sync"] = {"get": {}, "put": {}}
        with spec.open("w") as stream:
            YAML().dump(document, stream)
    if empty_tier is not None:
        spec = tmp_path / "spec" / empty_tier / "openapi.yaml"
        spec.write_text("paths: {}\n")
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
    total = backend_operation_count()
    assert total > 0, "no backend operations parsed -- the gate would pass on an empty spec"
    assert f"{'backend':<12}{total}/{total} reached, 0 excluded" in result.stdout


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


def test_should_keep_backend_gaps_pending_when_only_pro_implements_the_route(tmp_path: Path) -> None:
    source = (ROOT / "packages/python/src/xberg_io_sdk/client.py").read_text()
    tracked = {("backend", verb, SYNC_ROUTE): "https://github.com/xberg-io/sdks/issues/1" for verb in ("GET", "PUT")}
    result = run_gate(tmp_path, source, tracked_gaps=tracked, backend_sync=True)
    assert result.returncode == 0, result.stdout + result.stderr
    assert result.stdout.splitlines() == [
        "enterprise  52/53 reached, 1 excluded, 0 tracked as pending",
        "pro         66/69 reached, 3 excluded, 0 tracked as pending",
        "backend     51/53 reached, 0 excluded, 2 tracked as pending",
    ]
    assert result.stderr == ""


def test_should_reject_untracked_backend_gaps_even_when_pro_implements_the_route(tmp_path: Path) -> None:
    source = (ROOT / "packages/python/src/xberg_io_sdk/client.py").read_text()
    result = run_gate(tmp_path, source, backend_sync=True)
    assert result.returncode == 1
    for verb in ("GET", "PUT"):
        assert f"backend: {verb} {NORMALIZED_SYNC} is in the spec, in no client, and not excluded" in result.stderr


def test_should_not_apply_a_tracked_gap_to_another_tier(tmp_path: Path) -> None:
    source = (ROOT / "packages/python/src/xberg_io_sdk/client.py").read_text()
    tracked = {("pro", "GET", SYNC_ROUTE): "https://github.com/xberg-io/sdks/issues/1"}
    result = run_gate(tmp_path, source, tracked_gaps=tracked, backend_sync=True)
    assert result.returncode == 1
    assert f"backend: GET {NORMALIZED_SYNC} is in the spec, in no client, and not excluded" in result.stderr
    assert "backend     51/53 reached, 0 excluded, 0 tracked as pending" in result.stdout
    assert f"pro: GET {NORMALIZED_SYNC} is now implemented -- remove it from TRACKED_GAPS" in result.stderr


def test_should_reject_a_tracked_gap_whose_tier_has_no_such_operation(tmp_path: Path) -> None:
    source = (ROOT / "packages/python/src/xberg_io_sdk/client.py").read_text()
    tracked = {("backend", "GET", SYNC_ROUTE): "https://github.com/xberg-io/sdks/issues/1"}
    result = run_gate(tmp_path, source, tracked_gaps=tracked)
    assert result.returncode == 1
    assert f"tracked gap for backend: GET {NORMALIZED_SYNC} names an operation no spec declares" in result.stderr


def test_should_reject_a_tracked_gap_for_an_unknown_tier(tmp_path: Path) -> None:
    source = (ROOT / "packages/python/src/xberg_io_sdk/client.py").read_text()
    tracked = {("unknown", "GET", SYNC_ROUTE): "https://github.com/xberg-io/sdks/issues/1"}
    result = run_gate(tmp_path, source, tracked_gaps=tracked)
    assert result.returncode == 1
    assert "tracked gap names unknown tier: unknown" in result.stderr


@pytest.mark.parametrize("tier", ["api", "pro", "backend"])
def test_should_reject_specs_with_no_operations(tmp_path: Path, tier: str) -> None:
    source = (ROOT / "packages/python/src/xberg_io_sdk/client.py").read_text()
    result = run_gate(tmp_path, source, empty_tier=tier)
    assert result.returncode == 1
    expected_tier = "enterprise" if tier == "api" else tier
    assert f"{expected_tier}: spec declares no operations" in result.stderr
