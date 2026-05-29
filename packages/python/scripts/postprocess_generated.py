# ruff: noqa: INP001  # this directory is a script collection, not an importable package
"""Post-process openapi-python-client output to use stdlib ``typing.Self`` on 3.11+.

openapi-python-client (0.28 at time of writing) emits an unconditional
``from typing_extensions import Self`` in every generated model. ``typing.Self``
is in the stdlib from Python 3.11 onward (PEP 673), and the project declares
``typing-extensions`` as a runtime dep only on ``python_version < '3.11'`` — so
without this rewrite a fresh install on 3.11+ raises ``ModuleNotFoundError`` at
``import kreuzberg_cloud`` time.

The rewrite uses a ``sys.version_info`` guard (PEP 484 version narrowing) so
mypy can statically resolve ``Self`` to the stdlib alias on modern Pythons and
to ``typing_extensions`` on 3.10. The pattern mirrors the one already used by
the handwritten ``client.py``. Safe to run multiple times on the same tree.
"""

from __future__ import annotations

import pathlib
import sys

_OLD = "from typing_extensions import Self"
_NEW = (
    "if sys.version_info >= (3, 11):\n"
    "    from typing import Self\n"
    "else:\n"
    "    from typing_extensions import Self"
)
_ALREADY_PATCHED_MARKER = "if sys.version_info >= (3, 11):\n    from typing import Self"


def _ensure_import_sys(src: str) -> str:
    """Insert ``import sys`` at the top of the import block if absent."""
    if "\nimport sys\n" in src or src.startswith("import sys\n"):
        return src
    lines = src.splitlines(keepends=True)
    insert_at = 0
    for idx, line in enumerate(lines):
        if line.startswith("from __future__"):
            insert_at = idx + 1
            break
    lines.insert(insert_at, "import sys\n")
    return "".join(lines)


def _patch_file(path: pathlib.Path) -> bool:
    """Rewrite one generated file. Returns True if it was modified."""
    src = path.read_text()
    if _ALREADY_PATCHED_MARKER in src:
        return False
    if _OLD not in src:
        return False
    src = _ensure_import_sys(src)
    path.write_text(src.replace(_OLD, _NEW))
    return True


def main(argv: list[str]) -> int:
    """Walk ``argv[1]`` and rewrite every generated model that imports ``Self``."""
    if len(argv) != 2:
        sys.stderr.write(f"usage: {argv[0]} <generated-dir>\n")
        return 2
    root = pathlib.Path(argv[1])
    if not root.is_dir():
        sys.stderr.write(f"error: not a directory: {root}\n")
        return 2
    patched = sum(_patch_file(p) for p in root.rglob("*.py"))
    sys.stderr.write(f"postprocess_generated: patched {patched} file(s) under {root}\n")
    return 0


if __name__ == "__main__":
    raise SystemExit(main(sys.argv))
