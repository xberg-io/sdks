"""Exercise release publication conditions under failed and skipped upstream jobs."""

from __future__ import annotations

import ast
import os
import re
import subprocess
from pathlib import Path

import pytest
from ruamel.yaml import YAML

ROOT = Path(__file__).resolve().parents[2]
GATES = ("validate-versions", "validate-go", "check-pypi", "check-npm", "build-python", "build-typescript")


def release_condition(expression: str, results: dict[str, str], *, dry_run: bool = False) -> bool:
    expression = expression.replace("always()", "True").replace("cancelled()", "False")
    expression = expression.replace("needs.prepare.outputs.dry_run", repr("true" if dry_run else "false"))
    expression = re.sub(r"needs\.([\w-]+)\.result", lambda match: repr(results[match[1]]), expression)
    expression = expression.replace("&&", " and ").replace("||", " or ")
    expression = re.sub(r"!(?!=)", " not ", expression)
    tree = ast.parse(" ".join(expression.split()), mode="eval")

    def evaluate(node: ast.AST) -> bool | str:
        if isinstance(node, ast.Expression):
            return evaluate(node.body)
        if isinstance(node, ast.Constant):
            return node.value
        if isinstance(node, ast.BoolOp):
            values = [bool(evaluate(value)) for value in node.values]
            return all(values) if isinstance(node.op, ast.And) else any(values)
        if isinstance(node, ast.UnaryOp) and isinstance(node.op, ast.Not):
            return not evaluate(node.operand)
        if isinstance(node, ast.Compare) and len(node.ops) == 1:
            equal = evaluate(node.left) == evaluate(node.comparators[0])
            return equal if isinstance(node.ops[0], ast.Eq) else not equal
        raise AssertionError(f"unsupported release expression: {ast.dump(node)}")

    return bool(evaluate(tree))


@pytest.mark.parametrize("gate", GATES)
@pytest.mark.parametrize("outcome", ("failure", "cancelled", "skipped"))
def test_failed_preflight_cannot_publish_a_github_release(gate: str, outcome: str) -> None:
    workflow = YAML(typ="safe").load(ROOT / ".github/workflows/publish.yaml")
    release = workflow["jobs"]["github-release"]
    results = dict.fromkeys(release["needs"], "success")
    assert release_condition(release["if"], results)
    results[gate] = outcome
    results["publish-pypi"] = results["publish-npm"] = "skipped"
    assert not release_condition(release["if"], results), f"release accepted {gate}={outcome}"
    for publisher in ("publish-pypi", "publish-npm"):
        assert gate in workflow["jobs"][publisher]["needs"]


def test_existing_registry_versions_still_allow_a_verified_github_release() -> None:
    workflow = YAML(typ="safe").load(ROOT / ".github/workflows/publish.yaml")
    release = workflow["jobs"]["github-release"]
    results = dict.fromkeys(release["needs"], "success")
    results["publish-pypi"] = results["publish-npm"] = "skipped"
    assert release_condition(release["if"], results)


@pytest.mark.parametrize("dry_run", (False, True))
@pytest.mark.parametrize("gate", GATES)
@pytest.mark.parametrize("outcome", ("failure", "cancelled", "skipped"))
def test_failed_preflight_cannot_finalize_go_tag(gate: str, outcome: str, dry_run: bool) -> None:
    workflow = YAML(typ="safe").load(ROOT / ".github/workflows/publish.yaml")
    finalize = workflow["jobs"]["tag-go"]
    expression = finalize["if"].replace("needs.prepare.outputs.release_go", repr("true"))
    results = dict.fromkeys(finalize["needs"], "success")
    if dry_run:
        results["github-release"] = "skipped"
    assert release_condition(expression, results, dry_run=dry_run)
    results[gate] = outcome
    results["github-release"] = "skipped"
    assert not release_condition(expression, results, dry_run=dry_run), f"Go tag accepted {gate}={outcome}"
    assert gate in finalize["needs"]


def test_dispatch_builds_and_validates_the_requested_release_tag() -> None:
    workflow = YAML(typ="safe").load(ROOT / ".github/workflows/publish.yaml")
    checkouts = {
        name: [step for step in job["steps"] if step.get("uses", "").startswith("actions/checkout@")]
        for name, job in workflow["jobs"].items()
        if any(step.get("uses", "").startswith("actions/checkout@") for step in job["steps"])
    }
    assert set(checkouts) == {
        "validate-versions",
        "build-python",
        "build-typescript",
        "validate-go",
        "tag-go",
        "github-release",
    }
    for name, steps in checkouts.items():
        assert len(steps) == 1, name
        assert steps[0].get("with", {}).get("ref") == "${{ needs.prepare.outputs.tag }}", name


@pytest.mark.parametrize(
    ("job_name", "test_task", "build_task"),
    (
        ("build-python", "python:test:cov", "python:build"),
        ("build-typescript", "typescript:test:cov", "typescript:build"),
    ),
)
def test_language_tests_block_artifact_builds_and_every_publisher(
    job_name: str, test_task: str, build_task: str
) -> None:
    workflow = YAML(typ="safe").load(ROOT / ".github/workflows/publish.yaml")
    jobs = workflow["jobs"]
    steps = jobs[job_name]["steps"]
    test_steps = [step for step in steps if step.get("run") == f"task {test_task}"]
    assert len(test_steps) == 1, f"{job_name} must execute its coverage test task exactly once"
    test_step = test_steps[0]
    assert "if" not in test_step
    assert test_step.get("continue-on-error", False) is False
    build_step = next(step for step in steps if step.get("run") == f"task {build_task}")
    assert steps.index(test_step) < steps.index(build_step)
    for publisher in ("publish-pypi", "publish-npm", "github-release", "tag-go"):
        assert job_name in jobs[publisher]["needs"], publisher


@pytest.mark.parametrize("job_name", ("check-pypi", "check-npm"))
@pytest.mark.parametrize(("status", "exists"), (("200", "true"), ("404", "false"), ("403", None), ("500", None)))
def test_registry_probe_distinguishes_absence_from_failure(
    tmp_path: Path, job_name: str, status: str, exists: str | None
) -> None:
    workflow = YAML(typ="safe").load(ROOT / ".github/workflows/publish.yaml")
    script = workflow["jobs"][job_name]["steps"][0]["run"]
    curl = tmp_path / "curl"
    curl.write_text(f"#!/bin/sh\nprintf '%s' '{status}'\n", encoding="utf-8")
    curl.chmod(0o755)
    output = tmp_path / "output"
    result = subprocess.run(
        ["bash", "-c", script],
        check=False,
        capture_output=True,
        text=True,
        env={
            **os.environ,
            "PATH": f"{tmp_path}:{os.environ['PATH']}",
            "GITHUB_OUTPUT": str(output),
            "VERSION": "0.5.0",
        },
    )
    if exists is None:
        assert result.returncode != 0, f"HTTP {status} was treated as package absence"
        assert not output.exists()
    else:
        assert result.returncode == 0, result.stderr
        assert output.read_text(encoding="utf-8") == f"exists={exists}\n"
