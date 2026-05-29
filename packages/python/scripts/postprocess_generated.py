"""Post-process openapi-python-client output to use stdlib ``typing.Self`` on 3.11+.

openapi-python-client (0.28 at time of writing) emits an unconditional
``from typing_extensions import Self`` in every generated model. ``typing.Self``
is in the stdlib from Python 3.11 onward (PEP 673), and the project declares
``typing-extensions`` as a runtime dep only on ``python_version < '3.11'`` — so
without this rewrite a fresh install on 3.11+ raises ``ModuleNotFoundError`` at
``import kreuzberg_cloud`` time.

The rewrite swaps the bare import for a guarded ``try/except`` block, falling
back to ``typing_extensions`` only when stdlib ``Self`` isn't available. Safe to
run multiple times on the same tree.
"""

from __future__ import annotations

import pathlib
import sys

_OLD = "from typing_extensions import Self"
_NEW = (
    "try:\n"
    "    from typing import Self  # Python 3.11+\n"
    "except ImportError:  # pragma: no cover\n"
    "    from typing_extensions import Self"
)
_ALREADY_PATCHED_MARKER = "try:\n    from typing import Self"


def _patch_file(path: pathlib.Path) -> bool:
    src = path.read_text()
    if _ALREADY_PATCHED_MARKER in src:
        return False
    if _OLD not in src:
        return False
    path.write_text(src.replace(_OLD, _NEW))
    return True


def main(argv: list[str]) -> int:
    if len(argv) != 2:
        print(f"usage: {argv[0]} <generated-dir>", file=sys.stderr)
        return 2
    root = pathlib.Path(argv[1])
    if not root.is_dir():
        print(f"error: not a directory: {root}", file=sys.stderr)
        return 2
    patched = sum(_patch_file(p) for p in root.rglob("*.py"))
    print(f"postprocess_generated: patched {patched} file(s) under {root}", file=sys.stderr)
    return 0


if __name__ == "__main__":
    raise SystemExit(main(sys.argv))
