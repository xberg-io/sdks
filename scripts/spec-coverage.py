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
    ("backend", "POST", "/auth/saml/acs"): "SAML assertion consumer service, posted by the identity provider",
    ("backend", "POST", "/auth/saml/exchange"): "browser half of the SAML login, exchanging the ACS code for a session",
    ("backend", "GET", "/auth/saml/login"): "browser redirect that starts a SAML login",
    ("backend", "GET", "/auth/saml/metadata"): "service-provider metadata an identity provider imports",
    ("backend", "GET", "/scim/v2/{}/Groups"): "SCIM protocol endpoint called by the identity provider",
    ("backend", "POST", "/scim/v2/{}/Groups"): "SCIM protocol endpoint called by the identity provider",
    ("backend", "GET", "/scim/v2/{}/Groups/{}"): "SCIM protocol endpoint called by the identity provider",
    ("backend", "PUT", "/scim/v2/{}/Groups/{}"): "SCIM protocol endpoint called by the identity provider",
    ("backend", "PATCH", "/scim/v2/{}/Groups/{}"): "SCIM protocol endpoint called by the identity provider",
    ("backend", "DELETE", "/scim/v2/{}/Groups/{}"): "SCIM protocol endpoint called by the identity provider",
    ("backend", "GET", "/scim/v2/{}/Users"): "SCIM protocol endpoint called by the identity provider",
    ("backend", "POST", "/scim/v2/{}/Users"): "SCIM protocol endpoint called by the identity provider",
    ("backend", "GET", "/scim/v2/{}/Users/{}"): "SCIM protocol endpoint called by the identity provider",
    ("backend", "PUT", "/scim/v2/{}/Users/{}"): "SCIM protocol endpoint called by the identity provider",
    ("backend", "PATCH", "/scim/v2/{}/Users/{}"): "SCIM protocol endpoint called by the identity provider",
    ("backend", "DELETE", "/scim/v2/{}/Users/{}"): "SCIM protocol endpoint called by the identity provider",
    ("backend", "POST", "/scim/v2/{}/oauth2/token"): "SCIM client-credentials token for the identity provider",
    ("backend", "GET", "/scim/v2/{}/ResourceTypes"): "SCIM discovery endpoint read by the identity provider",
    ("backend", "GET", "/scim/v2/{}/Schemas"): "SCIM discovery endpoint read by the identity provider",
    ("backend", "GET", "/scim/v2/{}/ServiceProviderConfig"): "SCIM discovery endpoint read by the identity provider",
}

# Operations a client will expose but does not yet, each with the issue that
# will close it. Distinct from DELIBERATE_EXCLUSIONS on purpose: an exclusion
# says "never", a tracked gap says "not yet", and collapsing the two is how a
# gap quietly becomes a decision nobody made. Keys include the tier because
# backend and Pro may declare the same route on different destination planes. ~keep
# Empty right now: the last entry
# (#9, the crawl-event SSE stream) was removed by the change that implemented
# it, which is the only way an entry may leave -- `main` fails on a tracked gap
# the client has since started reaching.
TRACKED_GAPS: dict[tuple[str, str, str], str] = {}

# Requests the client builds through a helper rather than a literal, so the
# regex below cannot see them. Keep this list short: every entry is a place the
# check trusts a human instead of the source.
HELPER_BUILT = {
    ("GET", "/v1/saved_presets"),
    ("POST", "/v1/saved_presets"),
    ("GET", "/v1/saved_presets/{}"),
    ("PATCH", "/v1/saved_presets/{}"),
    ("DELETE", "/v1/saved_presets/{}"),
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


def tracked_gap_failures(
    operations: dict[str, set[tuple[str, str]]], coverage: dict[str, set[tuple[str, str]]]
) -> list[str]:
    """Reject obsolete tracking against the same tier that owns the gap."""
    failures = []
    for tier, verb, route in TRACKED_GAPS:
        operation = (verb, erase_parameters(route))
        if tier not in operations:
            failures.append(f"tracked gap names unknown tier: {tier}")
        elif operation not in operations[tier]:
            failures.append(f"tracked gap for {tier}: {verb} {operation[1]} names an operation no spec declares")
        elif operation in coverage[tier]:
            failures.append(f"{tier}: {verb} {operation[1]} is now implemented -- remove it from TRACKED_GAPS")
    return failures


def main() -> int:
    """Print per-tier coverage and fail on any operation that is neither covered nor excluded."""
    data_plane = client_requests()
    control_plane = client_requests(control_plane=True)
    operations_by_tier = {tier: spec_operations(path) for tier, path in SPECS.items()}
    coverage_by_tier = {tier: control_plane if tier == "backend" else data_plane for tier in SPECS}
    failures = tracked_gap_failures(operations_by_tier, coverage_by_tier)

    for tier, operations in operations_by_tier.items():
        covered = coverage_by_tier[tier]
        tracked = {(verb, erase_parameters(route)) for scope, verb, route in TRACKED_GAPS if scope == tier}
        excluded = {(verb, erase_parameters(route)) for scope, verb, route in DELIBERATE_EXCLUSIONS if scope == tier}
        reached = operations & covered
        gaps = sorted(operations - covered - excluded - tracked)
        total = len(operations)
        pending = len(operations & tracked)
        print(  # noqa: T201
            f"{tier:<11} {len(reached)}/{total} reached, "
            f"{len(operations & excluded)} excluded, {pending} tracked as pending"
        )
        if not operations:
            failures.append(f"{tier}: spec declares no operations")
        for verb, route in gaps:
            failures.append(f"{tier}: {verb} {route} is in the spec, in no client, and not excluded")

    for tier, verb, route in DELIBERATE_EXCLUSIONS:
        if (verb, erase_parameters(route)) not in operations_by_tier[tier]:
            failures.append(f"exclusion for {tier}: {verb} {route} names an operation no spec declares")

    if failures:
        sys.stderr.write("spec coverage gaps:\n")
        for line in failures:
            sys.stderr.write(f"  {line}\n")
        return 1
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
