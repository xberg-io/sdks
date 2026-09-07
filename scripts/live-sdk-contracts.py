#!/usr/bin/env python3
"""Exercise the installed Python SDK against an actual Pro or Enterprise server."""

from __future__ import annotations

import argparse
import json
import os
import subprocess
import sys
import tempfile
import time
import uuid
from pathlib import Path
from typing import TYPE_CHECKING, Any

import httpx
from ruamel.yaml import YAML

from xberg_io_sdk import XbergClient, XbergError

if TYPE_CHECKING:
    from collections.abc import Callable

POLL_TIMEOUT_SECONDS = 180
POLL_INTERVAL_SECONDS = 0.5


def require(condition: bool, message: str) -> None:
    """Fail explicitly even when Python assertions are disabled."""
    if not condition:
        raise ValueError(message)


def required_environment(name: str) -> str:
    """Read a required credential without sourcing files or inspecting containers."""
    value = os.environ.get(name, "")
    if not value:
        raise ValueError(f"{name} is required")
    return value


def mint_pro_key(base_url: str) -> tuple[str, str, str]:
    """Create a uniquely named Pro project and project key through the SDK."""
    admin_key = required_environment("XBERG_ADMIN_KEY")
    with XbergClient(base_url=base_url, api_key=admin_key, target="pro") as admin:
        project = admin.create_project({"name": "SDK live contract", "slug": f"sdk-{uuid.uuid4().hex}"})
        key = admin.create_api_key(str(project.id), {"name": "SDK live contract", "scope": "write"})
        require(bool(key.key), "Pro did not return a project API key")
        return key.key, str(project.id), str(key.id)


class Checks:
    """Count real checks and retain failures without stopping at the first mismatch."""

    def __init__(self) -> None:
        self.results: list[dict[str, str]] = []

    def run(self, name: str, operation: Callable[[], None]) -> None:
        """Execute one check and report a credential-redacted failure."""
        try:
            operation()
        except (XbergError, httpx.HTTPError, ValueError, KeyError, TypeError, AttributeError) as exc:
            detail = f"{type(exc).__name__}: {exc}"
            for key in ("XBERG_API_KEY", "XBERG_ADMIN_KEY", "XBERG_CONTROL_PLANE_TOKEN"):
                if os.environ.get(key):
                    detail = detail.replace(os.environ[key], "[credential]")
            self.results.append({"name": name, "status": "failed", "detail": detail})
            print(f"FAIL {name}: {detail}", flush=True)  # noqa: T201
        else:
            self.results.append({"name": name, "status": "passed"})
            print(f"PASS {name}", flush=True)  # noqa: T201

    def finish(self, expected: int) -> int:
        """Require the complete check count and return failure for any mismatch."""
        require(len(self.results) == expected, f"expected {expected} checks, executed {len(self.results)}")
        passed = sum(row["status"] == "passed" for row in self.results)
        print(f"Live SDK contracts: {passed}/{expected} passed")  # noqa: T201
        return 0 if passed == expected else 1


def verify_result(client: XbergClient, job_id: str, text: str) -> None:
    """Require the real job and result envelopes to preserve submitted text."""
    job = client.wait_for_job(
        job_id, poll_interval=POLL_INTERVAL_SECONDS, timeout=POLL_TIMEOUT_SECONDS, backoff="constant"
    )
    require(str(job.id) == job_id, "job metadata ID differs from the submitted job")
    result = client.get_job_result(job_id)
    require(str(result.job_id) == job_id, "JobResult envelope ID differs from the submitted job")
    require(result.status in {"completed", "partial_success"}, "JobResult is not successful")
    documents = result.to_dict().get("results", [])
    require(len(documents) == 1, "one text upload must return exactly one extracted document")
    require(text in documents[0].get("content", ""), "extracted content lost the submitted marker")


def verify_single(client: XbergClient, directory: Path) -> None:
    """Submit multipart through the SDK and check its job list and final content."""
    marker = f"Xberg SDK snippet fixture single extraction {uuid.uuid4().hex}"
    file = directory / "single.txt"
    file.write_text(marker)
    job = client.extract(file=file)
    verify_result(client, str(job.id), marker)
    listed = client.list_jobs(limit=100)
    require(str(job.id) in {str(item["id"]) for item in listed["jobs"]}, "submitted job missing from jobs list")


def verify_batch(client: XbergClient, directory: Path) -> None:
    """Require both independently submitted documents to complete with their own markers."""
    markers = [f"SDK batch document {index} {uuid.uuid4().hex}" for index in range(2)]
    files = [directory / f"batch-{index}.txt" for index in range(2)]
    for path, marker in zip(files, markers, strict=True):
        path.write_text(marker)
    jobs = client.extract_batch(files)
    require(len(jobs) == 2 and len({job.id for job in jobs}) == 2, "batch must submit exactly two distinct jobs")
    for job, marker in zip(jobs, markers, strict=True):
        verify_result(client, str(job.id), marker)


def verify_saved_presets(client: XbergClient) -> None:
    """Exercise the tier-specific preset collection and clean up the created preset."""
    body = {"name": f"sdk-{uuid.uuid4().hex}", "preferred_call_mode": "text_only", "schema": {"type": "object"}}
    created = client.create_saved_preset(body)
    preset_id = str(created.id)
    try:
        require(created.success is True, "saved preset creation did not report success")
        require(client.get_saved_preset(preset_id).name == body["name"], "saved preset name did not round-trip")
        require(
            preset_id in {str(item.id) for item in client.list_saved_presets(limit=100).presets}, "preset not listed"
        )
        changed = {**body, "name": f"sdk-updated-{uuid.uuid4().hex}", "emit_citations": False}
        client.update_saved_preset(preset_id, changed)
        require(client.get_saved_preset(preset_id).name == changed["name"], "saved preset update did not persist")
    finally:
        client.delete_saved_preset(preset_id)
    expect_status(lambda: client.get_saved_preset(preset_id), 404)


def expect_status(operation: Callable[[], Any], expected: int) -> None:
    """Require a typed SDK error with the expected server status."""
    try:
        operation()
    except XbergError as exc:
        require(exc.status_code == expected, f"expected HTTP {expected}, got {exc.status_code}")
    else:
        raise ValueError(f"expected HTTP {expected}, request succeeded")


def verify_enrichment(client: XbergClient) -> None:
    """Submit and poll the actual Enterprise enrichment pipeline."""
    submitted = client.submit_enrich({"text": "The SDK verifies a real enrichment request."})
    deadline = time.monotonic() + POLL_TIMEOUT_SECONDS
    while time.monotonic() < deadline:
        result = client.get_enrich_status(str(submitted.job_id))
        if result.status == "completed":
            require(isinstance(result.to_dict()["result"], dict), "enrichment result is not an object")
            return
        require(result.status != "failed", "enrichment job failed")
        time.sleep(POLL_INTERVAL_SECONDS)
    raise ValueError("enrichment did not complete before its deadline")


def upload_presigned(url: str, content: bytes) -> None:
    """PUT the unmodified signed URL from its network, outside the SDK's presign/confirm calls."""
    network = os.environ.get("XBERG_UPLOAD_NETWORK")
    if not network:
        with httpx.Client(timeout=30, follow_redirects=False, trust_env=False) as uploader:
            uploaded = uploader.put(url, content=content, headers={"Content-Type": "text/plain"})
            uploaded.raise_for_status()
        return
    image = required_environment("XBERG_UPLOAD_RUNTIME_IMAGE")
    configuration = (
        f"url = {json.dumps(url, ensure_ascii=False)}\n"
        f"data-binary = {json.dumps(content.decode('utf-8'), ensure_ascii=False)}\n"
        'header = "Content-Type: text/plain"\nrequest = "PUT"\nfail\nsilent\nshow-error\nmax-time = 30\nwrite-out = "%{http_code}"\n'
    )
    command = [
        "docker",
        "run",
        "--rm",
        "-i",
        "--network",
        network,
        "--read-only",
        "--user",
        "65532:65532",
        "--cap-drop",
        "ALL",
        "--security-opt",
        "no-new-privileges:true",
        "--entrypoint",
        "/usr/bin/curl",
        image,
        "--noproxy",
        "*",
        "--config",
        "-",
    ]
    result = subprocess.run(
        command,
        input=configuration,
        capture_output=True,
        text=True,
        timeout=60,
        check=False,
    )  # noqa: S603
    require(
        result.returncode == 0,
        f"container upload transport failed (exit {result.returncode}, status {result.stdout[-3:]}); SDK presign succeeded",
    )


def verify_presigned_upload(client: XbergClient) -> None:
    """Exercise the SDK presign and confirm calls around an actual object upload."""
    marker = f"SDK presigned upload {uuid.uuid4().hex}"
    response = client.presign_upload({"documents": [{"filename": "presigned.txt", "mime_type": "text/plain"}]})
    require(len(response["uploads"]) == 1, "presign must return one upload")
    upload = response["uploads"][0]
    require(upload["method"] == "PUT", "presigned upload method must be PUT")
    upload_presigned(upload["upload_url"], marker.encode())
    confirmed = client.confirm_upload({"batch_id": response["batch_id"]})
    require(confirmed["job_ids"] == [upload["job_id"]], "confirm must retain the presigned job ID")
    verify_result(client, upload["job_id"], marker)


def verify_document_lineage(client: XbergClient, directory: Path) -> None:
    """Create two actual versions and compare their latest metadata and computed diff."""
    document_id = str(uuid.uuid4())
    file = directory / "lineage.txt"
    job_ids = []
    marker = ""
    for version in (1, 2):
        marker = f"Xberg SDK snippet fixture {document_id} version {version}"
        file.write_text(marker)
        job = client.extract(file=file, document_id=document_id)
        job_ids.append(str(job.id))
        verify_result(client, str(job.id), marker)
    versions = client.versions(document_id)
    require([item["job_id"] for item in versions] == list(reversed(job_ids)), "document versions lost ordering")
    require([item["version_sequence"] for item in versions] == [2, 1], "document version sequence is incorrect")
    latest = client.get_document(document_id)
    require(latest["document_id"] == document_id and latest["id"] == job_ids[-1], "latest document identity differs")
    require(marker in latest["result"]["content"], "latest document content differs")
    result = client.diff(document_id, params={"from": job_ids[0], "to": job_ids[1]})
    deadline = time.monotonic() + POLL_TIMEOUT_SECONDS
    while "diff_job_id" in result:
        require(time.monotonic() < deadline, "document diff deadline exceeded")
        require(result["status"] != "failed", "document diff job failed")
        time.sleep(POLL_INTERVAL_SECONDS)
        result = client.get_diff_job(document_id, result["diff_job_id"])
    require(result["document_id"] == document_id, "diff document ID differs")
    require(result["from_job_id"] == job_ids[0] and result["to_job_id"] == job_ids[1], "diff version IDs differ")
    require(isinstance(result["diff"], dict) and len(result["diff"]) > 0, "diff result is empty")


def verify_tier(base_url: str, tier: str) -> None:
    """Check the live server identifies the requested deployment tier."""
    with httpx.Client(timeout=10, trust_env=False) as client:
        response = client.get(base_url + "/healthz")
        response.raise_for_status()
        require(response.json()["tier"] == tier, "live server tier differs from the requested SDK target")


def verify_surface(base_url: str, tier: str) -> None:
    """Require every vendored operation to exist in the actual served OpenAPI document."""
    spec = Path(__file__).resolve().parents[1] / "spec" / ("pro" if tier == "pro" else "api") / "openapi.yaml"
    with spec.open() as handle:
        vendored = YAML(typ="safe").load(handle)
    with httpx.Client(timeout=10, trust_env=False) as client:
        response = client.get(base_url + "/api-doc/openapi.json")
        response.raise_for_status()
        live = response.json()
    methods = {"get", "post", "put", "patch", "delete"}
    expected = {(method, path) for path, item in vendored["paths"].items() for method in item if method in methods}
    actual = {(method, path) for path, item in live["paths"].items() for method in item if method in methods}
    require(len(expected) > 0, "vendored OpenAPI declares no operations")
    require(not expected - actual, f"vendored operations missing from live server: {sorted(expected - actual)}")


def verify(args: argparse.Namespace) -> int:
    """Run the requested live contract set and revoke a transient Pro key."""
    key = os.environ.get("XBERG_API_KEY", "")
    minted: tuple[str, str, str] | None = None
    if not key and args.tier == "pro":
        minted = mint_pro_key(args.base_url)
        key = minted[0]
    require(bool(key), "XBERG_API_KEY is required")
    checks = Checks()
    checks.run("live server tier", lambda: verify_tier(args.base_url, args.tier))
    checks.run("served OpenAPI includes vendored operations", lambda: verify_surface(args.base_url, args.tier))
    try:
        with (
            XbergClient(base_url=args.base_url, api_key=key, target=args.tier) as client,
            tempfile.TemporaryDirectory(prefix="xberg-sdk-live-") as directory,
        ):
            checks.run("single multipart extraction and jobs", lambda: verify_single(client, Path(directory)))
            checks.run("two-file SDK batch and results", lambda: verify_batch(client, Path(directory)))
            checks.run("saved presets create/list/get/update/delete", lambda: verify_saved_presets(client))
            checks.run("managed preset catalog", lambda: require(len(client.presets()) > 0, "empty preset catalog"))
            checks.run("missing job typed error", lambda: expect_status(lambda: client.get_job(str(uuid.uuid4())), 404))
            if args.tier == "enterprise":
                checks.run(
                    "Enterprise usage", lambda: require(isinstance(client.usage(), dict), "usage is not an object")
                )
                checks.run(
                    "Enterprise extraction events",
                    lambda: require(client.list_extraction_events(limit=1).limit == 1, "events pagination ignored"),
                )
                checks.run(
                    "Enterprise document lineage/latest/versions/diff",
                    lambda: verify_document_lineage(client, Path(directory)),
                )
                checks.run("Enterprise enrichment submit/poll", lambda: verify_enrichment(client))
                checks.run(
                    "Enterprise SDK presign/confirm and real upload transport", lambda: verify_presigned_upload(client)
                )
        return checks.finish(12 if args.tier == "enterprise" else 7)
    finally:
        if minted is not None:
            with XbergClient(
                base_url=args.base_url, api_key=required_environment("XBERG_ADMIN_KEY"), target="pro"
            ) as admin:
                admin.revoke_api_key(minted[1], minted[2])


def main() -> int:
    """Dispatch the explicit key-minting or live verification command."""
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("command", choices=["verify", "pro-key"])
    parser.add_argument("--tier", choices=["pro", "enterprise"], default="pro")
    parser.add_argument("--base-url", required=True)
    args = parser.parse_args()
    try:
        if args.command == "pro-key":
            print(mint_pro_key(args.base_url)[0])  # noqa: T201
            return 0
        return verify(args)
    except (ValueError, XbergError, httpx.HTTPError) as exc:
        print(f"live SDK contract startup failed: {type(exc).__name__}", file=sys.stderr)  # noqa: T201
        return 1


if __name__ == "__main__":
    raise SystemExit(main())
