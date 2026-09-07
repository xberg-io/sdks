"""Fail-closed discovery and subprocess contracts for the documentation gate."""

from __future__ import annotations

import importlib.util
import json
import sys
from pathlib import Path

import pytest

SCRIPT = Path(__file__).resolve().parents[1] / "test-snippets.py"


def runner():
    spec = importlib.util.spec_from_file_location("snippet_runner", SCRIPT)
    assert spec is not None
    assert spec.loader is not None
    module = importlib.util.module_from_spec(spec)
    sys.modules[spec.name] = module
    spec.loader.exec_module(module)
    return module


def write_snippet(root: Path, text: str) -> None:
    (root / "example.md").write_text(text, encoding="utf-8")


def metadata() -> str:
    return '---\ntargets: ["pro", "enterprise"]\nside_effect: "safe"\nrequires: []\n---\n'


def test_discovery_counts_every_fenced_block_and_target(tmp_path: Path) -> None:
    write_snippet(tmp_path, metadata() + '```python title="Python"\nprint(1)\n```\n```ts\nconsole.log(2);\n```\n')
    snippets = runner().discover(tmp_path)
    assert [(item.language, item.code) for item in snippets] == [
        ("python", "print(1)\n"),
        ("typescript", "console.log(2);\n"),
    ]
    assert len(runner().execution_plan(snippets, ["pro", "enterprise"])) == 4


@pytest.mark.parametrize(
    "content",
    [
        "",
        "```python\nprint(1)\n```",
        metadata(),
        metadata() + "```ruby\n1\n```",
        metadata() + "```python\n1",
        metadata() + "```python\n```",
        metadata().replace("requires: []", "ignored: true"),
    ],
)
def test_discovery_rejects_unexamined_or_ambiguous_work(tmp_path: Path, content: str) -> None:
    write_snippet(tmp_path, content)
    with pytest.raises(ValueError, match=r"example\.md"):
        runner().discover(tmp_path)


def test_empty_directory_and_empty_target_selection_fail(tmp_path: Path) -> None:
    with pytest.raises(ValueError, match="No snippets"):
        runner().discover(tmp_path)
    write_snippet(
        tmp_path, metadata().replace('["pro", "enterprise"]', '["enterprise"]') + "```python\nprint(1)\n```\n"
    )
    module = runner()
    with pytest.raises(ValueError, match="No executions"):
        module.execution_plan(module.discover(tmp_path), ["pro"])


@pytest.mark.parametrize(
    "url",
    [
        "https://api.xberg.io",
        "http://localhost.evil.test",
        "http://user:secret@localhost",
        "http://127.0.0.1/path?secret=x",
        "file:///tmp/server",
    ],
)
def test_live_endpoints_must_be_local_without_embedded_credentials(url: str) -> None:
    with pytest.raises(ValueError, match="local"):
        runner().local_url(url)


def test_process_failure_names_snippet_without_exposing_secrets(tmp_path: Path) -> None:
    module = runner()
    with pytest.raises(ValueError, match=r"broken\.md:1") as caught:
        module.run_command(
            [sys.executable, "-c", "import os,sys; print(os.environ['XBERG_API_KEY']); sys.exit(7)"],
            tmp_path,
            {"XBERG_API_KEY": "private-test-key"},
            "broken.md:1",
            timeout=5,
        )
    assert "broken.md:1" in str(caught.value)
    assert "7" in str(caught.value)
    assert "private-test-key" not in str(caught.value)


def test_process_timeout_and_missing_success_marker_fail(tmp_path: Path) -> None:
    module = runner()
    with pytest.raises(ValueError, match="timed out"):
        module.run_command([sys.executable, "-c", "import time; time.sleep(10)"], tmp_path, {}, "idle", timeout=0.05)
    with pytest.raises(ValueError, match="marker"):
        module.run_command(
            [sys.executable, "-c", "print('normal EOF')"],
            tmp_path,
            {},
            "idle",
            timeout=5,
            expect_stdout="Subscription canceled",
        )


def test_environment_excludes_unrelated_credentials_and_proxies(monkeypatch: pytest.MonkeyPatch) -> None:
    monkeypatch.setenv("AWS_SECRET_ACCESS_KEY", "unrelated-secret")
    monkeypatch.setenv("HTTPS_PROXY", "http://proxy.test")
    environment = runner().child_environment({"XBERG_API_KEY": "fixture-key"})
    assert environment["XBERG_API_KEY"] == "fixture-key"
    assert "AWS_SECRET_ACCESS_KEY" not in environment
    assert "HTTPS_PROXY" not in environment


def test_explicit_state_never_falls_back_to_unrelated_environment(
    tmp_path: Path, monkeypatch: pytest.MonkeyPatch
) -> None:
    monkeypatch.setenv("XBERG_API_KEY", "unrelated-project-key")
    state = tmp_path / "state.json"
    state.write_text(
        '{"tier":"enterprise","api_url":"http://127.0.0.1:1234", "project_id":"fixture"}', encoding="utf-8"
    )
    state.chmod(0o600)
    with pytest.raises(ValueError, match="missing live service state"):
        runner().state_environment(state, "enterprise", tmp_path)


def test_invalid_state_types_fail_instead_of_turning_null_into_a_credential(tmp_path: Path) -> None:
    state = tmp_path / "state.json"
    state.write_text(
        '{"tier":"enterprise","api_url":"http://127.0.0.1:1234", "project_id":"fixture", "api_key":null}',
        encoding="utf-8",
    )
    state.chmod(0o600)
    with pytest.raises(ValueError, match="must be strings"):
        runner().state_environment(state, "enterprise", tmp_path)


def test_cached_runtime_closure_uses_local_packages_without_registry_resolution(tmp_path: Path) -> None:
    root = tmp_path / "packages/typescript"
    dependency = root / "node_modules/runtime"
    dependency.mkdir(parents=True)
    (root / "package.json").write_text('{"dependencies":{"runtime":"^1.0"}}', encoding="utf-8")
    (dependency / "package.json").write_text('{"name":"runtime","version":"1.2.3"}', encoding="utf-8")
    assert runner().cached_runtime_packages(tmp_path) == {"runtime": f"file:{dependency}"}


def test_ambiguous_artifacts_fail_before_selecting_a_stale_build(tmp_path: Path) -> None:
    (tmp_path / "dist").mkdir()
    for name in ["old.whl", "new.whl"]:
        (tmp_path / "dist" / name).touch()
    with pytest.raises(ValueError, match="exactly one"):
        runner().artifact(None, tmp_path, "*.whl")


def private_state(path: Path, tier: str = "enterprise") -> None:
    path.write_text(
        json.dumps(
            {
                "tier": tier,
                "api_url": "http://127.0.0.1:1234",
                "api_key": "fixture-key",
                "project_id": "fixture-project",
            }
        ),
        encoding="utf-8",
    )
    path.chmod(0o600)


def test_wrong_tier_state_cannot_count_enterprise_twice(tmp_path: Path) -> None:
    state = tmp_path / "state.json"
    private_state(state)
    with pytest.raises(ValueError, match="tier"):
        runner().state_environment(state, "pro", tmp_path)


def test_environment_must_explicitly_match_the_selected_tier(tmp_path: Path, monkeypatch: pytest.MonkeyPatch) -> None:
    monkeypatch.setenv("XBERG_BASE_URL", "http://127.0.0.1:1234")
    monkeypatch.setenv("XBERG_API_KEY", "fixture-key")
    monkeypatch.setenv("XBERG_PROJECT_ID", "fixture-project")
    monkeypatch.setenv("XBERG_TARGET", "enterprise")
    with pytest.raises(ValueError, match="tier"):
        runner().state_environment(None, "pro", tmp_path)


def test_public_or_symlinked_state_files_are_rejected(tmp_path: Path) -> None:
    state = tmp_path / "state.json"
    private_state(state)
    state.chmod(0o644)
    with pytest.raises(ValueError, match="private"):
        runner().state_environment(state, "enterprise", tmp_path)
    state.chmod(0o600)
    link = tmp_path / "link.json"
    link.symlink_to(state)
    with pytest.raises(ValueError, match="regular"):
        runner().state_environment(link, "enterprise", tmp_path)
