"""Exercise release publication conditions under failed and skipped upstream jobs."""

from __future__ import annotations

import ast
import re
from pathlib import Path

import pytest
from ruamel.yaml import YAML

ROOT = Path(__file__).resolve().parents[2]
GATES = ("validate-versions", "validate-go", "build-python", "build-typescript")


def release_condition(expression: str, results: dict[str, str]) -> bool:
    expression = expression.replace("always()", "True").replace("cancelled()", "False")
    expression = expression.replace("needs.prepare.outputs.dry_run", repr("false"))
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
