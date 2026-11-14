"""Read the mise task definitions the contract tests assert on."""

from __future__ import annotations

import tomllib
from pathlib import Path
from typing import Any

ROOT = Path(__file__).resolve().parents[2]


def toml_tasks(root: Path = ROOT) -> dict[str, Any]:
    """The `[tasks]` table of the repository mise.toml."""
    return tomllib.loads((root / "mise.toml").read_text(encoding="utf-8"))["tasks"]


def file_task(name: str, root: Path = ROOT) -> tuple[dict[str, Any], str]:
    """The `#MISE` header keys and the full text of the file task `name`."""
    path = root / "mise-tasks" / f"{name.replace(':', '/')}.sh"
    text = path.read_text(encoding="utf-8")
    headers: dict[str, Any] = {}
    for line in text.splitlines():
        if line.startswith("#MISE "):
            key, _, value = line.removeprefix("#MISE ").partition("=")
            headers[key] = tomllib.loads(f"value = {value}")["value"]
    return headers, text
