"""Fail-closed discovery and subprocess contracts for the documentation gate."""

from __future__ import annotations

import importlib.util
import json
import os
import subprocess
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


def test_success_marker_cannot_hide_events_in_an_expected_idle_subscription(tmp_path: Path) -> None:
    with pytest.raises(ValueError, match="stdout"):
        runner().run_command(
            [sys.executable, "-c", "print('page'); print('Subscription canceled')"],
            tmp_path,
            {},
            "idle-cancellation",
            expect_stdout="Subscription canceled",
        )


def test_execution_plan_runs_all_ordinary_examples_before_idle_cancellation(tmp_path: Path) -> None:
    (tmp_path / "a-idle.md").write_text(
        metadata().replace("requires: []", 'requires: ["crawl-job"]') + "```go\npackage main\n```\n",
        encoding="utf-8",
    )
    (tmp_path / "z-ordinary.md").write_text(metadata() + "```python\nprint(1)\n```\n", encoding="utf-8")
    module = runner()
    plan = module.execution_plan(module.discover(tmp_path), ["enterprise"])
    assert [snippet.name for snippet, _ in plan] == ["z-ordinary.md:1", "a-idle.md:1"]


@pytest.mark.skipif(not hasattr(os, "mkfifo"), reason="Named pipes are a POSIX filesystem feature")
def test_nonregular_state_is_rejected_without_blocking_on_a_named_pipe(tmp_path: Path) -> None:
    snippets = tmp_path / "snippets"
    snippets.mkdir()
    write_snippet(snippets, metadata() + "```python\nprint(1)\n```\n")
    pipe = tmp_path / "state.pipe"
    os.mkfifo(pipe, 0o600)
    result = subprocess.run(
        [
            sys.executable,
            str(SCRIPT),
            "--snippets-root",
            str(snippets),
            "--target",
            "enterprise",
            "--enterprise-state",
            str(pipe),
        ],
        capture_output=True,
        text=True,
        timeout=1,
        check=False,
    )
    assert result.returncode == 1
    assert "regular file" in result.stderr


@pytest.mark.parametrize("failed", [False, True])
def test_pro_run_mints_fresh_keys_and_always_revokes(tmp_path: Path, failed: bool) -> None:
    from http.server import BaseHTTPRequestHandler, ThreadingHTTPServer
    from threading import Thread

    calls = []

    class Handler(BaseHTTPRequestHandler):
        def log_message(self, *_args):
            return

        def do_POST(self):
            body = json.loads(self.rfile.read(int(self.headers["Content-Length"])))
            calls.append(("POST", self.path, self.headers["Authorization"], body))
            number = sum(item[0] == "POST" for item in calls)
            payload = json.dumps(
                {
                    "id": f"00000000-0000-0000-0000-{number:012d}",
                    "created_at": "2026-09-07T00:00:00Z",
                    "key_prefix": "temporary",
                    "key": f"temporary-{number}",
                    "name": body["name"],
                    "scope": "write",
                }
            ).encode()
            self.send_response(200)
            self.send_header("Content-Type", "application/json")
            self.send_header("Content-Length", str(len(payload)))
            self.end_headers()
            self.wfile.write(payload)

        def do_DELETE(self):
            calls.append(("DELETE", self.path, self.headers["Authorization"], None))
            self.send_response(204)
            self.end_headers()

    server = ThreadingHTTPServer(("127.0.0.1", 0), Handler)
    thread = Thread(target=server.serve_forever, daemon=True)
    thread.start()
    state = tmp_path / "state.json"
    state.write_text(json.dumps({"admin_key": "fixture-admin"}))
    state.chmod(0o600)
    original = state.read_bytes()
    values = {
        "XBERG_BASE_URL": f"http://127.0.0.1:{server.server_port}",
        "XBERG_PROJECT_ID": "fixture-project",
        "XBERG_API_KEY": "fixture-key",
        "XBERG_CONTROL_PLANE_TOKEN": "fixture-admin",
    }
    try:
        for number in (1, 2):
            try:
                with runner().temporary_pro_key(state, values) as scoped:
                    assert scoped["XBERG_API_KEY"] == f"temporary-{number}"
                    assert "XBERG_ADMIN_KEY" not in scoped
                    assert scoped["XBERG_CONTROL_PLANE_TOKEN"] == ""
                    if failed:
                        raise ValueError("failed snippet")
            except ValueError as error:  # noqa: PERF203
                assert failed
                assert str(error) == "failed snippet"
        assert [item[:3] for item in calls] == [
            ("POST", "/v1/projects/fixture-project/api-keys", "Bearer fixture-admin"),
            (
                "DELETE",
                "/v1/projects/fixture-project/api-keys/00000000-0000-0000-0000-000000000001",
                "Bearer fixture-admin",
            ),
            ("POST", "/v1/projects/fixture-project/api-keys", "Bearer fixture-admin"),
            (
                "DELETE",
                "/v1/projects/fixture-project/api-keys/00000000-0000-0000-0000-000000000002",
                "Bearer fixture-admin",
            ),
        ]
        assert state.read_bytes() == original
        assert values["XBERG_API_KEY"] == "fixture-key"
    finally:
        server.shutdown()
        server.server_close()
        thread.join()
