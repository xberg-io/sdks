"""Regression check that the post-codegen ``Self`` import rewrite stays applied.

``openapi-python-client`` emits an unconditional ``from typing_extensions import Self``
in every generated model. ``tasks/python.yml::generate`` runs
``scripts/postprocess_generated.py`` to rewrite those imports to a guarded
``try/except`` so stdlib ``typing.Self`` is preferred on Python 3.11+. Without
that rewrite, fresh installs on 3.11+ raise ``ModuleNotFoundError`` because the
``typing-extensions`` runtime dependency is gated to ``python_version < '3.11'``.

If this test fails, run ``task python:generate`` so the post-codegen step kicks
in, or check that the script in ``packages/python/scripts/`` still produces the
expected output for the openapi-python-client version in use.
"""

from __future__ import annotations

from pathlib import Path

_GENERATED = Path(__file__).resolve().parents[1] / "src" / "kreuzberg_cloud" / "_generated"


def test_generated_models_use_guarded_self_import() -> None:
    offenders: list[str] = []
    for path in _GENERATED.rglob("*.py"):
        for line in path.read_text().splitlines():
            if line == "from typing_extensions import Self":
                offenders.append(str(path.relative_to(_GENERATED)))
                break
    assert not offenders, (
        "Generated files have an unconditional `from typing_extensions import Self` — "
        "the post-codegen rewrite in tasks/python.yml::generate must run after every "
        "regeneration. Offending files:\n  " + "\n  ".join(offenders)
    )
