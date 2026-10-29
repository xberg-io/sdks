"""Exercise Python packaging from tracked sources without pre-generated schemas."""

from __future__ import annotations

import json
import os
import shlex
import shutil
import socket
import subprocess
import sys
from pathlib import Path

import pytest
from ruamel.yaml import YAML

from .mise_tasks import toml_tasks

ROOT = Path(__file__).resolve().parents[2]


def tracked_checkout(directory: Path) -> None:
    result = subprocess.run(
        ["git", "ls-files", "-z"],
        cwd=ROOT,
        capture_output=True,
        text=True,
        check=True,
    )
    paths = [Path(name) for name in result.stdout.split("\0") if name]
    assert Path("mise-tasks/python/generate.sh") in paths
    for path in paths:
        destination = directory / path
        destination.parent.mkdir(parents=True, exist_ok=True)
        shutil.copy2(ROOT / path, destination)
    assert not list((directory / "packages/python/src/xberg_io_sdk").glob("_generated_*"))


def test_python_build_ships_importable_schema_sets_from_a_fresh_checkout(tmp_path: Path) -> None:
    checkout = tmp_path / "checkout"
    tracked_checkout(checkout)
    environment = {key: value for key, value in os.environ.items() if key not in {"PYTHONPATH", "VIRTUAL_ENV"}}
    environment["UV_PROJECT_ENVIRONMENT"] = str(checkout / ".venv")
    environment["UV_PYTHON"] = sys.executable
    # The copy lives outside every trusted path, so mise would refuse its config. ~keep
    environment["MISE_TRUSTED_CONFIG_PATHS"] = str(checkout)
    build = subprocess.run(
        ["mise", "run", "python:build"],
        cwd=checkout,
        env=environment,
        capture_output=True,
        text=True,
        check=False,
    )
    assert build.returncode == 0, build.stdout + build.stderr
    wheels = list((checkout / "dist").glob("*.whl"))
    assert len(wheels) == 1, build.stdout + build.stderr
    code = """
import importlib
import json
import sys
sys.path.insert(0, sys.argv[1])
import xberg_io_sdk
modules = [importlib.import_module('xberg_io_sdk._generated_' + name) for name in ('api', 'pro', 'backend')]
assert xberg_io_sdk.__file__.startswith(sys.argv[1])
assert all(module.__file__.startswith(sys.argv[1]) for module in modules)
print(json.dumps({'version': xberg_io_sdk.__version__, 'schema_sets': len(modules)}))
"""
    imported = subprocess.run(
        [sys.executable, "-I", "-c", code, str(wheels[0])],
        cwd=tmp_path,
        capture_output=True,
        text=True,
        check=False,
    )
    assert imported.returncode == 0, imported.stdout + imported.stderr
    assert json.loads(imported.stdout) == {"version": (ROOT / "VERSION").read_text().strip(), "schema_sets": 3}
    assert_publish_finds_built_distributions(checkout)


def assert_publish_finds_built_distributions(checkout: Path) -> None:
    publish = toml_tasks()["python:publish"]
    command = publish["run"][-1].replace("{{config_root}}", str(checkout))
    with socket.socket() as listener:
        listener.bind(("127.0.0.1", 0))
        listener.listen()
        result = subprocess.run(
            [
                *shlex.split(command),
                "--dry-run",
                "--trusted-publishing",
                "never",
                "--keyring-provider",
                "disabled",
                "--no-config",
                "--publish-url",
                f"http://127.0.0.1:{listener.getsockname()[1]}/",
            ],
            cwd=checkout / "packages/python",
            env={"PATH": os.environ["PATH"], "HOME": str(checkout), "UV_HTTP_TIMEOUT": "1"},
            capture_output=True,
            text=True,
            check=False,
            timeout=15,
        )
        listener.setblocking(False)
        with pytest.raises(BlockingIOError):
            listener.accept()
    assert result.returncode == 0, result.stdout + result.stderr
    output = result.stdout + result.stderr
    assert "Checking 2 files against " in output
    artifacts = [*list((checkout / "dist").glob("*.whl")), *list((checkout / "dist").glob("*.tar.gz"))]
    assert len(artifacts) == 2
    for artifact in artifacts:
        assert f"Checking {artifact.name} " in output


def test_python_publish_reuses_the_verified_build_task() -> None:
    tasks = toml_tasks()
    assert tasks["python:build"]["dir"] == tasks["python:publish"]["dir"] == "{{config_root}}/packages/python"
    assert tasks["python:publish"]["run"][0] == {"task": "python:build"}


def test_python_ci_runs_packaging_regressions_with_their_task_inputs() -> None:
    workflow = YAML(typ="safe").load(ROOT / ".github/workflows/ci-python.yml")
    steps = workflow["jobs"]["test"]["steps"]
    commands = [step.get("run") for step in steps]
    assert commands.count("mise run scripts:test") == 1
    assert commands.index("uv sync") < commands.index("mise run scripts:test")
    assert commands.index("mise run python:generate") < commands.index("mise run scripts:test")
    assert commands.index("mise run scripts:test") < commands.index("mise run python:test:cov")
    for event in ("pull_request", "push"):
        paths = workflow["on"][event]["paths"]
        assert "scripts/**" in paths
        assert "mise.toml" in paths
        assert "mise-tasks/**" in paths
        assert "uv.lock" in paths
        assert ".github/workflows/ci-python.yml" in paths
