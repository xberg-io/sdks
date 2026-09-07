#!/usr/bin/env python3
"""Check a real `GET /v1/jobs/{id}/result` body against the JobResult schema.

The SDKs typed this route against `GetJobResponse`, the job METADATA schema,
which shares no field with JobResult beyond `status` and `completed_at`. The
mocked fixtures encoded a third shape again, so only the server can settle it.
"""

import json
import sys
from pathlib import Path

import yaml


def main() -> int:
    """Report schema-required fields absent on the wire, and undeclared extras."""
    with Path(sys.argv[1]).open(encoding="utf-8") as handle:
        body = json.load(handle)
    with Path(sys.argv[2]).open(encoding="utf-8") as handle:
        schema = yaml.safe_load(handle)["components"]["schemas"]["JobResult"]

    missing = [field for field in schema["required"] if field not in body]
    undeclared = sorted(set(body) - set(schema["properties"]))

    if missing:
        print(f"    required by the schema, absent on the wire: {missing}")  # noqa: T201 - CLI check output.
    if undeclared:
        print(f"    on the wire, undeclared by the schema: {undeclared}")  # noqa: T201 - CLI check output.
    print(f"    keys on the wire: {sorted(body)}")  # noqa: T201 - CLI check output.
    return 1 if missing or undeclared else 0


if __name__ == "__main__":
    sys.exit(main())
