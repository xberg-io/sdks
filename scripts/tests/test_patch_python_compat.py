"""Generated code must support every Python version advertised by the package."""

from __future__ import annotations

import importlib.util
from pathlib import Path

MODULE_PATH = Path(__file__).resolve().parents[1] / "patch-python-compat.py"
MODULE_SPEC = importlib.util.spec_from_file_location("patch_python_compat", MODULE_PATH)
assert MODULE_SPEC is not None
assert MODULE_SPEC.loader is not None
MODULE = importlib.util.module_from_spec(MODULE_SPEC)
MODULE_SPEC.loader.exec_module(MODULE)


def test_self_backport_preserves_other_imports_and_is_idempotent() -> None:
    source = "from typing import Any, Self\nvalue: Any = None\n"
    patched = MODULE.patch(source)
    assert patched == "from typing import Any\nfrom typing_extensions import Self\nvalue: Any = None\n"
    assert MODULE.patch(patched) == patched


def test_multiline_self_import_is_backported() -> None:
    source = "from typing import (\n    Any,\n    Self,\n)\n"
    assert MODULE.patch(source) == "from typing import Any\nfrom typing_extensions import Self\n"


def test_utc_datetime_parser_is_backported_without_changing_date_parser() -> None:
    source = "from __future__ import annotations\nimport datetime\nvalue = datetime.datetime.fromisoformat(text)\nday = datetime.date.fromisoformat(text)\n"
    patched = MODULE.patch(source)
    assert "from dateutil.parser import isoparse" in patched
    assert "value = isoparse(text)" in patched
    assert "day = datetime.date.fromisoformat(text)" in patched
    assert MODULE.patch(patched) == patched
