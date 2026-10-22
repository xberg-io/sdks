"""Keep schema synchronization and language CI connected to their actual inputs."""

from pathlib import Path

import pytest
from ruamel.yaml import YAML

ROOT = Path(__file__).resolve().parents[2]
GENERATED_GO = tuple(f"packages/go/generated_{name}.go" for name in ("api", "pro", "backend"))


def test_go_ci_tracks_shared_contract_tooling() -> None:
    workflow = YAML(typ="safe").load(ROOT / ".github/workflows/ci-go.yml")
    for event in ("push", "pull_request"):
        assert "scripts/**" in workflow["on"][event]["paths"]


def test_spec_sync_regenerates_and_commits_go_clients_before_detecting_drift() -> None:
    workflow = YAML(typ="safe").load(ROOT / ".github/workflows/spec-sync.yml")
    steps = workflow["jobs"]["sync"]["steps"]
    generation = next(index for index, step in enumerate(steps) if step.get("run") == "task go:generate")
    for action in ("actions/setup-go@", "arduino/setup-task@"):
        assert any(step.get("uses", "").startswith(action) for step in steps[:generation]), action
    drift = next(index for index, step in enumerate(steps) if step.get("id") == "diff")
    assert generation < drift
    pull_request = next(step for step in steps if step.get("uses", "").startswith("peter-evans/create-pull-request@"))
    committed = pull_request["with"]["add-paths"].splitlines()
    for path in GENERATED_GO:
        assert path in steps[drift]["run"]
        assert path in committed


@pytest.mark.parametrize("language", ("python", "typescript", "go"))
def test_language_ci_can_be_dispatched_on_release_preparation_branches(language: str) -> None:
    workflow = YAML(typ="safe").load(ROOT / f".github/workflows/ci-{language}.yml")
    assert "workflow_dispatch" in workflow["on"]


def test_typescript_ci_tracks_lockfile_and_workflow_changes() -> None:
    workflow = YAML(typ="safe").load(ROOT / ".github/workflows/ci-typescript.yml")
    for event in ("pull_request", "push"):
        assert "pnpm-lock.yaml" in workflow["on"][event]["paths"]
        assert ".github/workflows/ci-typescript.yml" in workflow["on"][event]["paths"]


def test_python_ci_executes_every_step_with_the_minimum_supported_interpreter() -> None:
    workflow = YAML(typ="safe").load(ROOT / ".github/workflows/ci-python.yml")
    assert workflow["jobs"]["test"]["env"]["UV_PYTHON"] == "3.10"


@pytest.mark.parametrize("filename", ("ci-go.yml", "spec-sync.yml", "publish.yaml"))
def test_go_workflows_use_the_verified_patched_toolchain(filename: str) -> None:
    workflow = YAML(typ="safe").load(ROOT / ".github/workflows" / filename)
    setups = [
        step
        for job in workflow["jobs"].values()
        for step in job.get("steps", [])
        if step.get("uses", "").startswith("actions/setup-go@")
    ]
    assert setups
    assert all(step["with"]["go-version"] == "1.27.3" for step in setups)
