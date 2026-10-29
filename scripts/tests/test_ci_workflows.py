"""Keep schema synchronization and language CI connected to their actual inputs."""

import re
from pathlib import Path

import pytest
from ruamel.yaml import YAML

ROOT = Path(__file__).resolve().parents[2]
GENERATED_GO = tuple(f"packages/go/generated_{name}.go" for name in ("api", "pro", "backend"))
SETUP_MISE = "xberg-io/actions/setup-mise@"
PATCHED_GO = "1.27.3"


def setup_mise_tools(step: dict) -> set[str]:
    return set(step.get("with", {}).get("install-args", "").split())


def toml_value(path: str, key: str) -> str:
    """The raw value of a top-level `key = ...` line; tomllib needs Python 3.11 and this suite runs on 3.10."""
    match = re.search(rf"^{re.escape(key)} = (.+)$", (ROOT / path).read_text(encoding="utf-8"), re.MULTILINE)
    assert match, f"{path} has no {key}"
    return match[1].strip()


def test_go_ci_tracks_shared_contract_tooling() -> None:
    workflow = YAML(typ="safe").load(ROOT / ".github/workflows/ci-go.yml")
    for event in ("push", "pull_request"):
        assert "scripts/**" in workflow["on"][event]["paths"]


def test_spec_sync_regenerates_every_language_before_detecting_drift() -> None:
    workflow = YAML(typ="safe").load(ROOT / ".github/workflows/spec-sync.yml")
    steps = workflow["jobs"]["sync"]["steps"]
    generation = next(index for index, step in enumerate(steps) if step.get("run") == "mise run generate")
    installed = set().union(
        *(setup_mise_tools(step) for step in steps[:generation] if step.get("uses", "").startswith(SETUP_MISE))
    )
    for tool in ("go", "python", "uv", "node", "pnpm", "yq"):
        assert tool in installed, tool
    drift = next(index for index, step in enumerate(steps) if step.get("id") == "diff")
    assert generation < drift
    pull_request = next(step for step in steps if step.get("uses", "").startswith("peter-evans/create-pull-request@"))
    committed = pull_request["with"]["add-paths"].splitlines()
    for path in GENERATED_GO:
        assert path in steps[drift]["run"]
        assert path in committed


def test_spec_sync_records_the_upstream_ref_and_commit_on_a_per_ref_branch() -> None:
    workflow = YAML(typ="safe").load(ROOT / ".github/workflows/spec-sync.yml")
    steps = workflow["jobs"]["sync"]["steps"]
    ids = [step.get("id") for step in steps]
    assert ids.index("ref") < ids.index("upstream") < ids.index("diff")
    pull_request = next(step for step in steps if step.get("uses", "").startswith("peter-evans/create-pull-request@"))
    settings = pull_request["with"]
    assert settings["branch"] == "${{ steps.ref.outputs.branch }}"
    for field in ("commit-message", "title"):
        assert "steps.ref.outputs.ref" in settings[field]
    assert "steps.upstream.outputs.sha" in settings["commit-message"]
    assert "body-path" in settings


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
    job = workflow["jobs"]["test"]
    legs = job["strategy"]["matrix"]["python"]
    assert legs == ["3.10.22", "3.14.10"]
    floor = pyproject_floor()
    assert legs[0].split(".")[:2] == floor.split("."), f"first leg {legs[0]} is not the requires-python floor {floor}"
    assert job["strategy"]["fail-fast"] is False
    assert job["env"]["MISE_ENV"] == "ci"
    assert job["env"]["MISE_PYTHON_VERSION"] == "${{ matrix.python }}"
    assert job["env"]["UV_PYTHON"] == "${{ matrix.python }}"
    assert job["env"]["UV_PYTHON_PREFERENCE"] == "only-system"
    ci_python = re.findall(r'"([^"]+)"', toml_value("mise.ci.toml", "python"))
    for leg in legs:
        assert leg in ci_python, f"{leg} is not locked through mise.ci.toml"


def pyproject_floor() -> str:
    requires = toml_value("packages/python/pyproject.toml", "requires-python").strip('"')
    assert requires.startswith(">="), requires
    return requires.removeprefix(">=").strip()


@pytest.mark.parametrize("filename", ("ci-go.yml", "spec-sync.yml", "publish.yaml"))
def test_go_workflows_use_the_verified_patched_toolchain(filename: str) -> None:
    assert toml_value("mise.toml", "go") == f'"{PATCHED_GO}"'
    workflow = YAML(typ="safe").load(ROOT / ".github/workflows" / filename)
    assert not [
        step
        for job in workflow["jobs"].values()
        for step in job.get("steps", [])
        if step.get("uses", "").startswith("actions/setup-go@")
    ], "Go must come from mise.toml, not a separately pinned setup-go"
    go_jobs = [
        name
        for name, job in workflow["jobs"].items()
        if any(
            step.get("uses", "").startswith(SETUP_MISE) and "go" in setup_mise_tools(step)
            for step in job.get("steps", [])
        )
    ]
    assert go_jobs, f"no job in {filename} installs go through setup-mise"


def test_workflows_run_mise_tasks_and_never_go_task() -> None:
    workflows = sorted((ROOT / ".github/workflows").glob("*.y*ml"))
    assert len(workflows) >= 9, workflows
    mise_runs = 0
    for path in workflows:
        workflow = YAML(typ="safe").load(path)
        for job in workflow["jobs"].values():
            for step in job.get("steps", []):
                assert "task" not in setup_mise_tools(step), f"{path.name} still installs go-task"
                run = step.get("run", "")
                assert not re.search(r"(^|[\s;&|])task\s", run), f"{path.name} still runs go-task: {run}"
                mise_runs += run.count("mise run ")
    assert mise_runs >= 27, mise_runs
