#!/usr/bin/env python3
"""Backport generated typing.Self and UTC timestamp parsing for Python 3.10."""

from __future__ import annotations

import argparse
import ast
from pathlib import Path


def patch(source: str) -> str:
    """Replace every generated typing.Self import while preserving its other names."""
    lines = source.splitlines(keepends=True)
    for node in reversed(ast.parse(source).body):
        if not isinstance(node, ast.ImportFrom) or node.module != "typing":
            continue
        if not any(name.name == "Self" for name in node.names):
            continue
        others = [name.name for name in node.names if name.name != "Self"]
        replacement = f"from typing import {', '.join(others)}\n" if others else ""
        replacement += "from typing_extensions import Self\n"
        lines[node.lineno - 1 : node.end_lineno] = [replacement]
    updated = "".join(lines)
    if "datetime.datetime.fromisoformat(" in updated:
        updated = updated.replace("datetime.datetime.fromisoformat(", "isoparse(")
        updated = (
            updated.replace(
                "from __future__ import annotations\n",
                "from __future__ import annotations\n\nfrom dateutil.parser import isoparse\n",
                1,
            )
            if "from __future__ import annotations\n" in updated
            else "from dateutil.parser import isoparse\n" + updated
        )
    return updated


def main() -> None:
    """Patch one complete generated schema set."""
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("directory", type=Path)
    args = parser.parse_args()
    for path in args.directory.rglob("*.py"):
        source = path.read_text(encoding="utf-8")
        updated = patch(source)
        if updated != source:
            path.write_text(updated, encoding="utf-8")


if __name__ == "__main__":
    main()
