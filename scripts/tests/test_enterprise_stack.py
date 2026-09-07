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
