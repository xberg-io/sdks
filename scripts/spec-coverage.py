#!/usr/bin/env python3
"""Report which vendored spec operations the client reaches, and fail on an unplanned gap.

Nothing asserted this before, which is how `cancel_job` and `delete_documents`
stayed missing from every client while sitting outside the READMEs' exclusion
lists -- so they read as covered, in four hand-maintained places that agreed
with each other and with nothing else.

The Python sync client is the reference surface: `scripts/generate-reference.py`
already fails when the three languages diverge, so proving coverage once proves
it everywhere. Requests are matched by the `(verb, path)` pair they put on the
wire, with template parameter names erased -- the same normalisation
`xberg-enterprise`'s own `spec-parity.test.sh` uses, because a parameter's name
is local to the document while the URL a caller builds is not.
"""

from __future__ import annotations

import ast
import re
import sys
from pathlib import Path

from ruamel.yaml import YAML

REPO_ROOT = Path(__file__).resolve().parent.parent
CLIENT = REPO_ROOT / "packages" / "python" / "src" / "xberg_io_sdk" / "client.py"

SPECS = {
    "enterprise": REPO_ROOT / "spec" / "api" / "openapi.yaml",
    "pro": REPO_ROOT / "spec" / "pro" / "openapi.yaml",
    "backend": REPO_ROOT / "spec" / "backend" / "openapi.yaml",
}

VERBS = ("get", "put", "post", "delete", "patch", "head", "options")

# Operations no client exposes, on purpose. Each needs a reason, because an
# entry here is the difference between a decision and an oversight -- which is
# exactly the distinction that went missing when this list lived only in prose.
DELIBERATE_EXCLUSIONS = {
    ("enterprise", "GET", "/readyz"): "infrastructure probe; /healthz is the tier probe",
    ("pro", "GET", "/readyz"): "infrastructure probe; /healthz is the tier probe",
    ("pro", "GET", "/v1/oauth/callback"): "browser redirect target in Pro's login flow",
    ("pro", "DELETE", "/auth/account"): "Pro account erasure, deliberately console-only",
}

# Operations a client will expose but does not yet, each with the issue that
# will close it. Distinct from DELIBERATE_EXCLUSIONS on purpose: an exclusion
# says "never", a tracked gap says "not yet", and collapsing the two is how a
# gap quietly becomes a decision nobody made. Empty right now: the last entry
# (#9, the crawl-event SSE stream) was removed by the change that implemented
# it, which is the only way an entry may leave -- `main` fails on a tracked gap
# the client has since started reaching.
TRACKED_GAPS: dict[tuple[str, str], str] = {}

# Requests the client builds through a helper rather than a literal, so the
# regex below cannot see them. Keep this list short: every entry is a place the
# check trusts a human instead of the source.
HELPER_BUILT = {
    ("GET", "/v1/saved_presets"),
    ("POST", "/v1/saved_presets"),
    ("GET", "/v1/saved_presets/{}"),
    ("PATCH", "/v1/saved_presets/{}"),
    ("DELETE", "/v1/saved_presets/{}"),
    ("GET", "/v1/saved-presets"),
    ("POST", "/v1/saved-presets"),
    ("GET", "/v1/saved-presets/{}"),
    ("PATCH", "/v1/saved-presets/{}"),
    ("DELETE", "/v1/saved-presets/{}"),
}


def erase_parameters(path: str) -> str:
    """Reduce every path template parameter to `{}` so the two sides compare on wire shape."""
    return re.sub(r"\{[^}]*\}", "{}", path)


def request_path(node: ast.expr, constants: dict[str, str]) -> str | None:
    """Resolve literal routes and constant-prefixed f-strings without reading comments."""
    if isinstance(node, ast.Constant) and isinstance(node.value, str):
        return node.value
    if isinstance(node, ast.Name):
        return constants.get(node.id)
    if isinstance(node, ast.JoinedStr):
        return "".join(
            part.value if isinstance(part, ast.Constant) else request_path(part.value, constants) or "{}"
            for part in node.values
        )
    return None


def client_requests(*, control_plane: bool = False) -> set[tuple[str, str]]:
    """Requests issued by the sync reference client, isolated by destination plane."""
    tree = ast.parse(CLIENT.read_text(encoding="utf-8"))
    constants = {
        target.id: node.value.value
        for node in tree.body
        if isinstance(node, ast.Assign) and isinstance(node.value, ast.Constant) and isinstance(node.value.value, str)
        for target in node.targets
        if isinstance(target, ast.Name)
    }
    client = next(node for node in tree.body if isinstance(node, ast.ClassDef) and node.name == "XbergClient")
    prefix = "_request_control_" if control_plane else "_request_"
    names = {prefix + suffix for suffix in ("json", "bytes", "none", "stream", "redirect")}
    found: set[tuple[str, str]] = set()
    for node in ast.walk(client):
        if not isinstance(node, ast.Call) or not isinstance(node.func, ast.Attribute) or node.func.attr not in names:
            continue
        if len(node.args) < 2 or not isinstance(node.args[0], ast.Constant):
            continue
        path = request_path(node.args[1], constants)
        if path is not None and node.args[0].value.lower() in VERBS:
            found.add((node.args[0].value, erase_parameters(path)))
    return found if control_plane else found | HELPER_BUILT


def spec_operations(path: Path) -> set[tuple[str, str]]:
    """Every `(verb, path)` a spec declares."""
    document = YAML(typ="safe").load(path.read_text(encoding="utf-8"))
    return {
        (verb.upper(), erase_parameters(route))
        for route, item in document["paths"].items()
        for verb in item
        if verb in VERBS
    }


def main() -> int:
    """Print per-tier coverage and fail on any operation that is neither covered nor excluded."""
    data_plane = client_requests()
    control_plane = client_requests(control_plane=True)
    tracked = {(verb, erase_parameters(route)) for verb, route in TRACKED_GAPS}
    failures: list[str] = []

    for tier, spec_path in SPECS.items():
        covered = control_plane if tier == "backend" else data_plane
        excluded = {(verb, erase_parameters(route)) for scope, verb, route in DELIBERATE_EXCLUSIONS if scope == tier}
        operations = spec_operations(spec_path)
        reached = operations & covered
        gaps = sorted(operations - covered - excluded - tracked)
        total = len(operations)
        pending = len(operations & tracked)
        print(  # noqa: T201
            f"{tier:<11} {len(reached)}/{total} reached, "
            f"{len(operations & excluded)} excluded, {pending} tracked as pending"
        )
        for verb, route in gaps:
            failures.append(f"{tier}: {verb} {route} is in the spec, in no client, and not excluded")

    for tier, verb, route in DELIBERATE_EXCLUSIONS:
        if (verb, erase_parameters(route)) not in spec_operations(SPECS[tier]):
            failures.append(f"exclusion for {tier}: {verb} {route} names an operation no spec declares")
    for verb, route in sorted(tracked & (data_plane | control_plane)):
        failures.append(f"{verb} {route} is now implemented -- remove it from TRACKED_GAPS")

    if failures:
        sys.stderr.write("spec coverage gaps:\n")
        for line in failures:
            sys.stderr.write(f"  {line}\n")
        return 1
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
