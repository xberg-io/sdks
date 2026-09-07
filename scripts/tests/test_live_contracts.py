"""Safety checks for live harness entrypoints; these do not claim server verification."""

from __future__ import annotations

import importlib.util
import os
import subprocess
from pathlib import Path

import pytest

ROOT = Path(__file__).resolve().parents[2]


def test_pro_key_requires_explicit_admin_credential_before_external_commands(tmp_path: Path) -> None:
    environment = dict(os.environ)
    environment.pop("XBERG_ADMIN_KEY", None)
    marker = tmp_path / "docker-was-called"
    docker = tmp_path / "docker"
    docker.write_text(f'#!/bin/sh\ntouch "{marker}"\nexit 1\n')
    docker.chmod(0o700)
    environment["PATH"] = f"{tmp_path}:{environment['PATH']}"
    result = subprocess.run(  # noqa: S603
        [str(ROOT / "scripts/pro-project-key.sh"), "http://127.0.0.1:1"],
        env=environment,
        capture_output=True,
        text=True,
        check=False,
    )
    assert result.returncode != 0
    assert not marker.exists(), "missing admin credentials must not inspect a shared Docker container"
    assert "XBERG_ADMIN_KEY is required" in result.stderr


def test_pro_verify_dispatches_the_sdk_contract_runner(tmp_path: Path) -> None:
    marker = tmp_path / "arguments"
    uv = tmp_path / "uv"
    uv.write_text(f'#!/bin/sh\nprintf "%s\\n" "$@" > "{marker}"\nexit 23\n')
    uv.chmod(0o700)
    environment = {**os.environ, "PATH": f"{tmp_path}:{os.environ['PATH']}"}
    result = subprocess.run(  # noqa: S603
        [str(ROOT / "scripts/pro-contract-check.sh"), "http://127.0.0.1:1"],
        env=environment,
        capture_output=True,
        text=True,
        check=False,
    )
    assert result.returncode == 23
    arguments = marker.read_text().splitlines()
    assert str(ROOT / "scripts/live-sdk-contracts.py") in arguments
    assert arguments[-5:] == ["verify", "--tier", "pro", "--base-url", "http://127.0.0.1:1"]


def test_live_checks_reject_missing_work_and_preserve_failed_status() -> None:
    spec = importlib.util.spec_from_file_location("live_contract_checks", ROOT / "scripts/live-sdk-contracts.py")
    assert spec is not None
    assert spec.loader is not None
    module = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(module)
    checks = module.Checks()
    with pytest.raises(ValueError, match="expected 1 checks, executed 0"):
        checks.finish(1)
    checks.run("deliberate negative control", lambda: module.require(False, "planted failure"))
    assert checks.finish(1) == 1
    assert checks.results == [
        {"name": "deliberate negative control", "status": "failed", "detail": "ValueError: planted failure"}
    ]
