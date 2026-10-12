"""Derived Python schema variants preserve the vendored wire contract."""

from __future__ import annotations

import copy
import importlib.util
from pathlib import Path

import pytest

MODULE_PATH = Path(__file__).resolve().parents[1] / "prepare-python-spec.py"
MODULE_SPEC = importlib.util.spec_from_file_location("prepare_python_spec", MODULE_PATH)
assert MODULE_SPEC is not None
assert MODULE_SPEC.loader is not None
MODULE = importlib.util.module_from_spec(MODULE_SPEC)
MODULE_SPEC.loader.exec_module(MODULE)


def test_inline_composed_variants_are_named_without_changing_structure() -> None:
    variant = {"allOf": [{"$ref": "#/components/schemas/Job"}, {"type": "object", "required": ["kind"]}]}
    document = {"components": {"schemas": {"Response": {"oneOf": [variant, {"type": "null"}]}}}}
    original = copy.deepcopy(document)
    derived = MODULE.prepare(document)
    schemas = derived["components"]["schemas"]
    assert schemas["Response"]["oneOf"] == [{"$ref": "#/components/schemas/ResponseVariant0"}, {"type": "null"}]
    assert schemas["ResponseVariant0"] == variant
    assert document == original


def test_existing_variant_name_is_rejected() -> None:
    document = {"components": {"schemas": {"Response": {"oneOf": [{"allOf": []}]}, "ResponseVariant0": {}}}}
    with pytest.raises(ValueError, match="Derived schema name already exists"):
        MODULE.prepare(document)


def test_missing_response_description_is_added_without_changing_wire_schema() -> None:
    response = {"content": {"application/json": {"schema": {"type": "object"}}}}
    document = {"paths": {"/roles": {"parameters": [], "post": {"responses": {"201": response}}}}}
    original = copy.deepcopy(document)
    derived = MODULE.prepare(document)
    assert derived["paths"]["/roles"]["post"]["responses"]["201"] == {**response, "description": "Created"}
    assert document == original
