#!/usr/bin/env python3
"""Compare a running Pro instance's served surface with the vendored spec.

A vendored operation the server does not serve means the SDK was generated
against a spec newer than the deployment -- the exact skew that made the
published image unusable for SDK testing.
"""

import json
import sys
from pathlib import Path

import yaml

HTTP_METHODS = ("get", "post", "put", "patch", "delete")


def operations(document: dict) -> set[tuple[str, str]]:
    """Return every (METHOD, path) pair the document declares."""
    return {
        (method.upper(), path) for path, item in document["paths"].items() for method in item if method in HTTP_METHODS
    }


def main() -> int:
    """Report operations that are vendored but unserved, and vice versa."""
    with Path(sys.argv[1]).open(encoding="utf-8") as handle:
        vendored = operations(yaml.safe_load(handle))
    with Path(sys.argv[2]).open(encoding="utf-8") as handle:
        live = operations(json.load(handle))

    missing = sorted(vendored - live)
    for method, path in missing:
        print(f"    vendored but not served: {method} {path}")  # noqa: T201 - CLI check output.
    for method, path in sorted(live - vendored):
        print(f"    served but not vendored: {method} {path}")  # noqa: T201 - CLI check output.
    print(f"    vendored={len(vendored)} live={len(live)}")  # noqa: T201 - CLI check output.
    return 1 if missing else 0


if __name__ == "__main__":
    sys.exit(main())
