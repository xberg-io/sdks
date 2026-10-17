#!/usr/bin/env python3
"""Run all four documented native Pro health calls against bounded HTTP controls."""

from __future__ import annotations

import argparse
import importlib.util
import json
import sys
import tempfile
from http.server import BaseHTTPRequestHandler, ThreadingHTTPServer
from pathlib import Path
from threading import Thread
from typing import TYPE_CHECKING, Any

if TYPE_CHECKING:
    from types import ModuleType


def load_runner() -> ModuleType:
    """Reuse package installation, strict compilation and execution from the documentation gate."""
    spec = importlib.util.spec_from_file_location("health_snippet_runner", Path(__file__).with_name("test-snippets.py"))
    module = importlib.util.module_from_spec(spec)
    sys.modules[spec.name] = module
    spec.loader.exec_module(module)
    return module


def handler(payload: dict[str, Any], calls: list[tuple]) -> type[BaseHTTPRequestHandler]:
    """Serve public liveness without credentials and record every request."""

    class Handler(BaseHTTPRequestHandler):
        def log_message(self, *_args: object) -> None:
            return

        def do_GET(self) -> None:  # noqa: N802  # ~keep Standard-library HTTP dispatch name.
            calls.append((self.command, self.path, self.headers.get("Authorization"), self.headers.get("X-Project-ID")))
            data = json.dumps(payload).encode()
            self.send_response(200)
            self.send_header("Content-Type", "application/json")
            self.send_header("Content-Length", str(len(data)))
            self.end_headers()
            self.wfile.write(data)

        do_POST = do_GET  # noqa: N815  # ~keep Record unexpected writes instead of hiding them in a default 501.
        do_PUT = do_GET  # noqa: N815
        do_PATCH = do_GET  # noqa: N815
        do_DELETE = do_GET  # noqa: N815

    return Handler


def exercise(
    runner: ModuleType,
    snippets: list[Any],
    arguments: argparse.Namespace,
    root: Path,
    *,
    directory: Path,
    origin: str,
    payload: dict[str, Any],
) -> None:
    """Require each real native example to accept good data and reject a planted status error."""
    prepared = {}
    passed = rejected = 0
    expected = json.dumps(payload)
    for snippet in snippets:
        if snippet.language not in prepared:
            path = directory / snippet.language
            path.mkdir()
            prepared[snippet.language] = path, runner.prepare_language(snippet.language, path, arguments, root)
        path, command = prepared[snippet.language]
        values = {"XBERG_BASE_URL": origin, "XBERG_TARGET": "pro", "XBERG_EXPECTED_PRO_HEALTH_JSON": expected}
        runner.execute_snippet(snippet, "pro", path, command, values)
        passed += 1
        payload["status"] = "broken"
        try:
            runner.execute_snippet(snippet, "pro", path, command, values)
        except ValueError as error:
            if "Pro health status mismatch" not in str(error):
                raise ValueError("Negative control failed for a different reason") from error
            rejected += 1
        else:
            raise ValueError("Planted Pro health status error was accepted")
        finally:
            payload["status"] = "ok"
    if (passed, rejected) != (4, 4):
        raise ValueError(f"Expected four accepted/four rejected native calls, got {passed}/{rejected}")


def main() -> int:
    """Execute the bounded positive and negative contract on all four built native clients."""
    root = Path(__file__).resolve().parents[1]
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--python-wheel", type=Path)
    parser.add_argument("--typescript-tarball", type=Path)
    parser.add_argument("--go-source", type=Path)
    arguments = parser.parse_args()
    runner = load_runner()
    snippets = [item for item in runner.discover(root / "docs-site/src/snippets") if "/pro_health.md:" in item.name]
    if [(item.language, item.targets) for item in snippets] != [
        ("go", ["pro"]),
        ("python", ["pro"]),
        ("python", ["pro"]),
        ("typescript", ["pro"]),
    ]:
        raise ValueError("Expected exactly four Pro-only native health examples")
    payload = {
        "status": "ok",
        "tier": "pro",
        "license": {"state": "grace"},
        "rag": {"enabled": True},
        "auto_tune": {"enabled": False},
    }
    calls = []
    server = ThreadingHTTPServer(("127.0.0.1", 0), handler(payload, calls))
    thread = Thread(target=server.serve_forever, daemon=True)
    thread.start()
    try:
        with tempfile.TemporaryDirectory(prefix="pro-health-snippets-") as temporary:
            exercise(
                runner,
                snippets,
                arguments,
                root,
                directory=Path(temporary),
                origin=f"http://127.0.0.1:{server.server_port}",
                payload=payload,
            )
    finally:
        server.shutdown()
        server.server_close()
        thread.join(timeout=5)
    if calls != [("GET", "/healthz", None, None)] * 8:
        raise ValueError(f"Expected eight public unscoped GETs and zero writes; observed {calls!r}")
    print("Pro health HTTP controls: 4 accepted, 4 rejected, 8 GETs, 0 writes")  # noqa: T201
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
