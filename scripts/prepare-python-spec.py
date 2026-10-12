#!/usr/bin/env python3
"""Name inline composed union branches for openapi-python-client."""

from __future__ import annotations

import argparse
import copy
import json
from http import HTTPStatus
from pathlib import Path
from typing import Any

from ruamel.yaml import YAML


def prepare(document: dict[str, Any]) -> dict[str, Any]:
    """Preserve each variant's structure while making it referenceable by the generator."""
    result = copy.deepcopy(document)
    schemas = result.get("components", {}).get("schemas", {})
    for name, schema in list(schemas.items()):
        for kind in ("oneOf", "anyOf"):
            for index, variant in enumerate(schema.get(kind, [])):
                if "allOf" not in variant:
                    continue
                variant_name = f"{name}Variant{index}"
                if variant_name in schemas:
                    raise ValueError(f"Derived schema name already exists: {variant_name}")
                schemas[variant_name] = variant
                schema[kind][index] = {"$ref": f"#/components/schemas/{variant_name}"}
    for path_item in result.get("paths", {}).values():
        for verb, operation in path_item.items():
            if verb not in {"get", "put", "post", "delete", "patch", "head", "options", "trace"}:
                continue
            for status, response in operation.get("responses", {}).items():
                if "$ref" in response or "description" in response:
                    continue
                try:
                    response["description"] = HTTPStatus(int(status)).phrase
                except ValueError:
                    response["description"] = f"HTTP {status} response"
    return result


def main() -> None:
    """Write a derived JSON spec without modifying its vendored source."""
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("source", type=Path)
    parser.add_argument("output", type=Path)
    args = parser.parse_args()
    document = YAML(typ="safe").load(args.source)
    args.output.write_text(json.dumps(prepare(document), default=str), encoding="utf-8")


if __name__ == "__main__":
    main()
