#!/usr/bin/env python3
"""Generate the per-language API reference for docs-site from the client sources.

The reference is generated, not hand-written, for the same reason the specs are
vendored rather than retyped: a hand-maintained list of 60-odd methods drifts
the first time one is added. `.textlintignore` excludes `reference/**` because
of this.

Run via `task docs:reference`.
"""

from __future__ import annotations

import argparse
import re
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
OUT = ROOT / "docs-site/src/content/docs/reference"

# Method name -> the area it belongs to. Ordering here is the ordering on the page.
GROUPS: list[tuple[str, str, list[str]]] = [
    ("Extraction", "Submit documents and wait for results.", ["extract", "extract_batch", "extract_and_wait"]),
    (
        "Jobs",
        "Poll, read, page through and cancel extraction jobs.",
        [
            "list_jobs",
            "get_job",
            "get_job_result",
            "get_job_page",
            "cancel_job",
            "wait_for_job",
            "wait_for_jobs",
            "audit",
        ],
    ),
    (
        "Crawl",
        "Enterprise-only crawl job event stream.",
        ["stream_crawl_events"],
    ),
    ("Presets", "The curated preset registry, served by both tiers.", ["presets", "get_preset", "get_preset_sample"]),
    (
        "Saved presets",
        "Project-scoped presets you create and update.",
        ["list_saved_presets", "create_saved_preset", "get_saved_preset", "update_saved_preset", "delete_saved_preset"],
    ),
    (
        "RAG",
        "Collections, documents and retrieval.",
        [
            "list_rag_collections",
            "create_rag_collection",
            "get_rag_collection",
            "delete_rag_collection",
            "add_rag_documents",
            "delete_rag_documents",
            "reindex_rag_document",
            "rag_retrieve",
            "migrate_rag_embeddings",
            "get_rag_migration_job",
            "get_rag_job",
            "get_rag_config",
            "set_rag_config",
        ],
    ),
    (
        "Auto-tune",
        "Tuning jobs and their results.",
        [
            "submit_auto_tune",
            "list_auto_tune_jobs",
            "get_auto_tune_status",
            "get_auto_tune_result",
            "get_auto_tune_capabilities",
            "promote_auto_tune_profile",
            "delete_auto_tune_job",
        ],
    ),
    (
        "Tuning profiles",
        "Profiles promoted from auto-tune runs.",
        ["list_tuning_profiles", "get_tuning_profile", "delete_tuning_profile"],
    ),
    (
        "Documents and lineage",
        "Enterprise-only document history.",
        ["get_document", "versions", "diff", "get_diff_job"],
    ),
    ("Enrich", "Enterprise-only text enrichment.", ["submit_enrich", "get_enrich_status"]),
    (
        "Uploads and usage",
        "Enterprise-only upload staging and metering.",
        ["presign_upload", "confirm_upload", "usage", "list_extraction_events"],
    ),
    (
        "Control plane",
        "Pro-only projects, keys and integrations.",
        [
            "list_projects",
            "create_project",
            "list_api_keys",
            "create_api_key",
            "revoke_api_key",
            "list_integrations",
            "create_integration",
            "get_integration",
            "delete_integration",
            "connect_integration",
            "disconnect_integration",
            "list_integration_documents",
            "fetch_integration_document",
        ],
    ),
    (
        "Enterprise control plane",
        "All backend operations use the configured control-plane origin and credential.",
        [
            "delete_account",
            "get_auth_config",
            "backend_login",
            "healthz",
            "readyz",
            "accept_invitation",
            "oauth_callback",
            "backend_list_projects",
            "backend_create_project",
            "get_project",
            "delete_project",
            "update_project",
            "get_analytics",
            "backend_list_api_keys",
            "backend_create_api_key",
            "backend_revoke_api_key",
            "regenerate_api_key",
            "list_project_audit",
            "get_billing",
            "create_checkout",
            "create_portal",
            "backend_list_integrations",
            "backend_create_integration",
            "backend_get_integration",
            "backend_delete_integration",
            "oauth_connect",
            "backend_disconnect_integration",
            "backend_list_integration_documents",
            "backend_fetch_integration_document",
            "list_invitations",
            "invite_user",
            "revoke_invitation",
            "leave_project",
            "list_members",
            "remove_member",
            "update_member_role",
            "backend_get_rag_config",
            "backend_set_rag_config",
            "sandbox_extract",
            "get_usage",
            "list_webhooks",
            "create_webhook",
            "delete_webhook",
            "update_webhook",
            "list_webhook_deliveries",
            "retry_webhook_delivery",
            "test_webhook",
            "public_sandbox_extract",
        ],
    ),
    ("Auth", "Pro-only session and configuration reads.", ["auth_config", "login"]),
    (
        "Client accessors",
        "Read back what the client was configured with. Go only; the other two expose these as properties.",
        ["base_url", "control_plane_base_url", "http_client", "target"],
    ),
]

ACCESSOR_BLURB = "Read back what the client was configured with. Go only; the other two expose these as properties."

TS_NOT_METHODS = frozenset({"constructor", "if", "for", "while", "switch", "catch", "return"})

PY_CLIENT = ROOT / "packages/python/src/xberg_io_sdk/client.py"
TS_CLIENT = ROOT / "packages/typescript/src/client.ts"
GO_DIR = ROOT / "packages/go"


def python_methods() -> dict[str, str]:
    """Public sync-class method -> first docstring line."""
    text = PY_CLIENT.read_text()
    start = text.index("class XbergClient")
    end = text.index("class AsyncXbergClient")
    body = text[start:end]
    out: dict[str, str] = {}
    for match in re.finditer(r"^    def ([a-z][a-z0-9_]*)\(", body, re.MULTILINE):
        name = match.group(1)
        if name.startswith("_"):
            continue
        doc = re.search(r'"""(.+?)(?:\n|""")', body[match.end() :], re.DOTALL)
        out[name] = doc.group(1).strip() if doc else ""
    return out


def ts_methods() -> dict[str, str]:
    """Public TypeScript client method -> its first JSDoc line."""
    text = TS_CLIENT.read_text()
    private = set(re.findall(r"^  private (?:async )?([a-z][A-Za-z0-9]*)", text, re.MULTILINE))
    out: dict[str, str] = {}
    for match in re.finditer(r"^  (?:public )?(?:async )?([a-z][A-Za-z0-9]*)\s*(?:<[^>]*>)?\(", text, re.MULTILINE):
        name = match.group(1)
        # `if (`, `for (` and friends match the same shape as a method header at
        # this indent, so they have to be excluded by name.
        if name in private or name in TS_NOT_METHODS:
            continue
        preceding = text[: match.start()].rstrip()
        doc = ""
        if preceding.endswith("*/"):
            block = preceding[preceding.rindex("/**") :]
            lines = [ln.strip().lstrip("*").strip() for ln in block.splitlines()[1:-1]]
            doc = next((ln for ln in lines if ln), "")
        out[name] = doc
    return out


def go_methods() -> dict[str, str]:
    """Exported Go `*Client` method -> its first doc-comment sentence."""
    out: dict[str, str] = {}
    for path in sorted(GO_DIR.glob("*.go")):
        if path.name.endswith("_test.go") or path.name.startswith("generated_"):
            continue
        text = path.read_text()
        for match in re.finditer(r"^func \(c \*Client\) ([A-Z][A-Za-z0-9]*)\(", text, re.MULTILINE):
            name = match.group(1)
            preceding = text[: match.start()].rstrip().splitlines()
            doc = ""
            comment: list[str] = []
            for line in reversed(preceding):
                if line.startswith("//"):
                    comment.append(line[2:].strip())
                else:
                    break
            if comment:
                doc = " ".join(reversed(comment)).split(". ")[0]
            out[name] = doc
    return out


def snake_to_camel(name: str) -> str:
    """`get_job_result` -> `getJobResult`, the TypeScript spelling."""
    head, *rest = name.split("_")
    return head + "".join(p.title() for p in rest)


def snake_to_pascal(name: str) -> str:
    """`get_job_result` -> `GetJobResult`, the Go spelling, honouring Go initialisms."""
    special = {"oauth": "OAuth", "api": "API", "id": "ID", "json": "JSON", "rag": "Rag", "url": "URL", "http": "HTTP"}
    if name.startswith("backend_"):
        special["rag"] = "RAG"
    parts = [special.get(p, p.title()) for p in name.split("_")]
    return "".join(parts)


LANGS = {
    "python": ("Python", "xberg_io_sdk", python_methods, lambda n: n),
    "typescript": ("TypeScript", "@xberg-io/sdk", ts_methods, snake_to_camel),
    "go": ("Go", "github.com/xberg-io/sdks/packages/go", go_methods, snake_to_pascal),
}


# Python alone needs an explicit teardown: httpx holds a connection pool, while
# `fetch` and `http.Client` need none. Go alone reads its configuration back
# through methods, where Python and TypeScript expose plain attributes. Every
# other name must exist in all three.
LANGUAGE_LOCAL = {
    "python": {"close", "aclose"},
    "typescript": set(),
    "go": {"BaseURL", "ControlPlaneBaseURL", "HTTPClient", "Target"},
}


def parity_failures() -> list[str]:
    """Report every public method that is not present in all three languages.

    `render` skips a canonical name it cannot find, so a method dropped from one
    language used to vanish from that page with no error — divergence recorded as
    documentation instead of caught as a defect. It happened: Go shipped
    `DeleteDocuments` while Python and TypeScript shipped `delete_rag_documents`,
    and all three pages rendered cleanly.
    """
    sets = {lang: set(collect()) - LANGUAGE_LOCAL[lang] for lang, (_, _, collect, _) in LANGS.items()}
    canonical = sets["python"]
    problems: list[str] = []
    for lang, (_, _, _, transform) in LANGS.items():
        if lang == "python":
            continue
        expected = {transform(name) for name in canonical}
        problems.extend(f"{lang}: missing {name}" for name in sorted(expected - sets[lang]))
        problems.extend(f"{lang}: has {name}, absent from Python" for name in sorted(sets[lang] - expected))
    return problems


def render(lang: str) -> str:
    """Render one language's reference page."""
    label, package, collect, transform = LANGS[lang]
    found = collect()
    # Only Python ships a second, mirrored client; saying so on the TypeScript
    # and Go pages was Python boilerplate leaking across all three.
    mirror_note = (
        " Every method below is on the client; the async client mirrors the sync one method for method."
        if lang == "python"
        else " Every method below is on the client."
    )
    lines = [
        "---",
        f"title: {label} API reference",
        f"description: Every public method on the {label} client, grouped by area.",
        "---",
        "",
        "<!-- Generated by scripts/generate-reference.py — do not edit. -->",
        "<!-- Regenerate with `task docs:reference`. -->",
        "",
        f"Package `{package}`.{mirror_note}",
        "",
    ]
    covered: set[str] = set()
    for title, blurb, members in GROUPS:
        rows = []
        for canonical in members:
            name = transform(canonical)
            if name not in found:
                continue
            covered.add(name)
            doc = found[name].replace("|", "\\|")
            rows.append(f"| `{name}` | {doc} |")
        if not rows:
            continue
        lines += [f"## {title}", "", blurb, "", "| Method | Description |", "| --- | --- |", *rows, ""]
    leftover = sorted(set(found) - covered - {"close", "aclose", "to_dict"})
    if leftover:
        lines += ["## Other", "", "| Method | Description |", "| --- | --- |"]
        lines += [f"| `{n}` | {found[n]} |" for n in leftover]
        lines.append("")
    return "\n".join(lines)


def main() -> None:
    """Write every language's reference page."""
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--check", action="store_true", help="Check reference content without writing")
    args = parser.parse_args()
    failures = parity_failures()
    if failures:
        sys.stderr.write("cross-language method sets diverge:\n")
        for line in failures:
            sys.stderr.write(f"  {line}\n")
        sys.exit(1)
    rendered = {OUT / f"api-{lang}.md": render(lang) for lang in LANGS}
    changelog = (ROOT / "CHANGELOG.md").read_text().removeprefix("# Changelog\n")
    rendered[OUT.parent / "changelog.md"] = (
        "---\ntitle: Changelog\ndescription: Changes to the Python, TypeScript and Go SDKs.\n---\n" + changelog
    )
    if args.check:
        stale = [path for path, content in rendered.items() if not path.exists() or path.read_text() != content]
        for path in stale:
            print(f"stale reference: {path}", file=sys.stderr)
        if stale:
            sys.exit(1)
        print(f"reference: {len(rendered)} files checked")
        return
    OUT.mkdir(parents=True, exist_ok=True)
    for target, content in rendered.items():
        target.write_text(content)
        count = content.count("| `")
        print(f"  {target.relative_to(ROOT)}: {count} methods")


if __name__ == "__main__":
    main()
