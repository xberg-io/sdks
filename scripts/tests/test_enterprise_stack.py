"""Safety and configuration tests for the isolated Docker-backed live stack."""

from __future__ import annotations

import importlib.util
import json
import os
import stat
from pathlib import Path

import pytest

ROOT = Path(__file__).resolve().parents[2]


def load_stack():
    path = ROOT / "scripts/enterprise-stack.py"
    specification = importlib.util.spec_from_file_location("enterprise_stack", path)
    module = importlib.util.module_from_spec(specification)
    specification.loader.exec_module(module)
    return module


def test_private_state_rejects_symlinks_and_foreign_content(tmp_path: Path) -> None:
    stack = load_stack()
    outside = tmp_path / "outside"
    outside.mkdir()
    link = tmp_path / "link"
    link.symlink_to(outside, target_is_directory=True)
    with pytest.raises(ValueError, match="symlink"):
        stack.private_directory(link)
    require_marker = tmp_path / "existing"
    require_marker.mkdir()
    (require_marker / "keep.txt").write_text("user data")
    with pytest.raises(ValueError, match="unrecognized"):
        stack.initialize_state(require_marker, "enterprise")
    assert (require_marker / "keep.txt").read_text() == "user data"


def test_state_is_private_and_unique_to_each_instance(tmp_path: Path) -> None:
    stack = load_stack()
    first = stack.initialize_state(tmp_path / "first", "enterprise")
    second = stack.initialize_state(tmp_path / "second", "enterprise")
    assert first["project"] != second["project"]
    assert first["jwt_secret"] != second["jwt_secret"]
    assert all(value.startswith("sdk_") for value in first["nats_passwords"].values())
    assert first["ports"]["api"] != first["ports"]["postgres"]
    for name in ("first", "second"):
        state = tmp_path / name / "state.json"
        assert stat.S_IMODE(state.stat().st_mode) == 0o600
        assert stat.S_IMODE(state.parent.stat().st_mode) == 0o700
        assert json.loads(state.read_text())["tier"] == "enterprise"


def test_vector_worker_receives_no_database_credentials(tmp_path: Path) -> None:
    stack = load_stack()
    state = stack.initialize_state(tmp_path / "state", "enterprise")
    environment = {
        "DATABASE_URL": "postgresql://app:application@localhost:5432/db",
        "MAINTENANCE_DATABASE_URL": "postgresql://maintenance:maintenance@localhost:5432/db",
        "VECTOR_INDEX_BROKER_DATABASE_URL": "postgresql://broker:broker@localhost:5432/db",
        "VECTOR_INDEX_QUEUE_DATABASE_URL": "postgresql://queue:queue@localhost:5432/db",
    }
    services = stack.runtime_services(state, environment, tmp_path, "runtime:test")
    worker = services["sdk-vector-worker"]
    assert all("DATABASE" not in key and "PASSWORD" not in key for key in worker["environment"])
    assert worker["environment"]["VECTOR_INDEX_BROKER_SOCKET"] == "/broker/runtime/broker.sock"
    broker = services["sdk-vector-broker"]
    assert broker["environment"]["VECTOR_INDEX_QUEUE_DATABASE_URL"] == "postgresql://queue:queue@postgres:5432/db"
    assert broker["user"] == worker["user"]
    assert worker["volumes"][0]["read_only"] is True
    assert services["sdk-api"]["ports"][0]["host_ip"] == "127.0.0.1"
    assert services["sdk-rag"]["environment"]["NATS_USER"] == "rag"
    assert services["sdk-rag"]["environment"]["NATS_PASSWORD"] == state["nats_passwords"]["rag"]


def test_scope_mismatch_cannot_run_docker(tmp_path: Path) -> None:
    stack = load_stack()
    state = stack.initialize_state(tmp_path / "state", "enterprise")
    state["project"] = "someone-elses-stack"
    with pytest.raises(ValueError, match="scope"):
        stack.validate_state(state, "enterprise")
    assert os.getuid() == state["uid"]


def test_idle_crawl_fixture_is_terminal_and_scoped_to_exact_project() -> None:
    stack = load_stack()
    project = "11111111-1111-1111-1111-111111111111"
    crawl = "22222222-2222-2222-2222-222222222222"
    sql = stack.crawl_fixture_sql(project, crawl)
    assert "'COMPLETED'" in sql
    assert "ARRAY[]::text[]" in sql
    assert project in sql
    assert crawl in sql
    assert "app.current_project_id" in sql
    with pytest.raises(ValueError, match="badly formed hexadecimal UUID"):
        stack.crawl_fixture_sql("invalid'project", crawl)


def test_gcs_fixture_uses_distinct_ephemeral_signing_keys() -> None:
    import base64
    import subprocess

    stack = load_stack()
    first = json.loads(base64.b64decode(stack.gcs_signing_credential()))
    second = json.loads(base64.b64decode(stack.gcs_signing_credential()))
    assert first["type"] == "service_account"
    assert first["client_email"] == "sdk-live@fixture.invalid"
    assert first["private_key"] != second["private_key"]
    checked = subprocess.run(  # noqa: S603
        ["openssl", "pkey", "-check", "-noout"],
        input=first["private_key"],
        text=True,
        capture_output=True,
        check=False,
    )
    assert checked.returncode == 0


@pytest.mark.parametrize("operation", ["mint", "execute"])
def test_cached_fixture_refreshes_expired_control_token_without_recreating_project(
    tmp_path: Path, monkeypatch: pytest.MonkeyPatch, operation: str
) -> None:
    import base64
    import sys

    stack = load_stack()
    directory = tmp_path / "state"
    state = stack.initialize_state(directory, "enterprise")
    monkeypatch.setattr(stack.time, "time", lambda: 1)
    expired = stack.session_token(state)
    state.update(
        api_key="fixture-key",
        project_id="fixture-project",
        key_id="fixture-key-id",
        control_plane_token=expired,
        api_url="http://127.0.0.1:1",
        control_plane_url="http://127.0.0.1:1",
    )
    stack.write_private(directory / "state.json", state)
    monkeypatch.setattr(stack.time, "time", lambda: 100000)
    if operation == "mint":
        stack.mint_fixture(directory, state)
    else:
        command = [
            sys.executable,
            "-c",
            "import os; assert os.environ['XBERG_CONTROL_PLANE_TOKEN'] != os.environ['EXPIRED_FIXTURE_TOKEN']",
        ]
        monkeypatch.setenv("EXPIRED_FIXTURE_TOKEN", expired)
        assert stack.execute(directory, state, command) == 0
    persisted = json.loads((directory / "state.json").read_text())
    assert persisted["api_key"] == "fixture-key"
    assert persisted["project_id"] == "fixture-project"
    assert persisted["key_id"] == "fixture-key-id"
    assert persisted["control_plane_token"] == state["control_plane_token"]
    claims = state["control_plane_token"].split(".")[1]
    decoded = json.loads(base64.urlsafe_b64decode(claims + "=" * (-len(claims) % 4)))
    assert decoded["iat"] == 100000
    assert decoded["exp"] == 186400
