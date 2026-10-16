"""Project selection follows Pro jobs through the real HTTP transport."""

from __future__ import annotations

import asyncio
import json
import threading
from http.server import BaseHTTPRequestHandler, ThreadingHTTPServer
from typing import TYPE_CHECKING
from urllib.parse import parse_qs, urlsplit

if TYPE_CHECKING:
    from collections.abc import Iterator

import pytest

from tests.conftest import make_job_payload, make_job_result_payload
from xberg_io_sdk import AsyncXbergClient, XbergClient, XbergError

PROJECT_ID = "11111111-1111-4111-8111-111111111111"
JOB_ID = "22222222-2222-4222-8222-222222222222"
OTHER_JOB_ID = "33333333-3333-4333-8333-333333333333"


@pytest.fixture
def project_server() -> Iterator[tuple[str, list[tuple[str, str, str | None]]]]:
    seen: list[tuple[str, str, str | None]] = []

    class Handler(BaseHTTPRequestHandler):
        def log_message(self, *_args: object) -> None:
            pass

        def respond(self, status: int, payload: object) -> None:
            self.send_response(status)
            self.end_headers()
            self.wfile.write(payload if isinstance(payload, bytes) else json.dumps(payload).encode())

        def do_POST(self) -> None:
            body = self.rfile.read(int(self.headers["Content-Length"]))
            seen.append(("POST", self.path, self.headers.get("X-Project-ID")))
            ids = [JOB_ID, OTHER_JOB_ID] if body.count(b"filename=") == 2 else [JOB_ID]
            self.respond(202, {"job_ids": ids})

        def do_GET(self) -> None:
            seen.append(("GET", self.path, self.headers.get("X-Project-ID")))
            url = urlsplit(self.path)
            if url.path == "/healthz":
                self.respond(200, {"tier": "pro"})
                return
            query = parse_qs(url.query)
            if not query.get("project_id"):
                self.respond(404, {"error": {"code": "job_not_found"}})
            elif url.path.endswith("/result"):
                self.respond(200, make_job_result_payload(job_id=JOB_ID))
            elif "/pages/" in url.path:
                self.respond(200, b"synthetic-page")
            elif url.path == "/v1/jobs":
                self.respond(200, {"jobs": [], "total": 0, "limit": 1, "offset": 2})
            else:
                self.respond(200, make_job_payload(job_id=url.path.rsplit("/", 1)[1], status="completed"))

        def do_DELETE(self) -> None:
            seen.append(("DELETE", self.path, self.headers.get("X-Project-ID")))
            self.respond(204 if parse_qs(urlsplit(self.path).query).get("project_id") else 404, b"")

    server = ThreadingHTTPServer(("127.0.0.1", 0), Handler)
    thread = threading.Thread(target=server.serve_forever)
    thread.start()
    try:
        yield f"http://127.0.0.1:{server.server_port}", seen
    finally:
        server.shutdown()
        thread.join()
        server.server_close()


def assert_scoped_trace(seen: list[tuple[str, str, str | None]], target: str | None) -> None:
    probes = [row for row in seen if row[1] == "/healthz"]
    assert len(probes) == (1 if target is None else 0)
    operations = [row for row in seen if row[1] != "/healthz"]
    assert len(operations) == 14
    assert [row[0] for row in operations].count("POST") == 2
    for method, path, header in operations:
        if method == "POST":
            assert header == PROJECT_ID
            assert path == "/v1/extract"
        else:
            assert parse_qs(urlsplit(path).query)["project_id"] == [PROJECT_ID]
            assert header is None
    assert ("GET", f"/v1/jobs?limit=1&offset=2&project_id={PROJECT_ID}", None) in operations


@pytest.mark.parametrize("target", ["pro", None])
def test_selected_project_sync_job_surface(project_server, target) -> None:
    base_url, seen = project_server
    with XbergClient(base_url=base_url, target=target) as client:
        assert str(client.extract_and_wait(file=b"scope proof", project_id=PROJECT_ID).id) == JOB_ID
        assert [str(job.id) for job in client.extract_batch([b"one", b"two"], project_id=PROJECT_ID)] == [
            JOB_ID,
            OTHER_JOB_ID,
        ]
        assert str(client.get_job(JOB_ID, project_id=PROJECT_ID).id) == JOB_ID
        assert str(client.get_job_result(JOB_ID, project_id=PROJECT_ID).job_id) == JOB_ID
        assert client.list_jobs(limit=1, offset=2, project_id=PROJECT_ID)["total"] == 0
        assert client.cancel_job(JOB_ID, project_id=PROJECT_ID) is None
        assert client.get_job_page(JOB_ID, 1, project_id=PROJECT_ID) == b"synthetic-page"
        assert str(client.wait_for_job(JOB_ID, project_id=PROJECT_ID).id) == JOB_ID
        assert [str(job.id) for job in client.wait_for_jobs([JOB_ID, OTHER_JOB_ID], project_id=PROJECT_ID)] == [
            JOB_ID,
            OTHER_JOB_ID,
        ]
    assert_scoped_trace(seen, target)


@pytest.mark.parametrize("target", ["pro", None])
async def test_selected_project_async_job_surface(project_server, target) -> None:
    base_url, seen = project_server
    async with AsyncXbergClient(base_url=base_url, target=target) as client:
        assert str((await client.extract_and_wait(file=b"scope proof", project_id=PROJECT_ID)).id) == JOB_ID
        assert [str(job.id) for job in await client.extract_batch([b"one", b"two"], project_id=PROJECT_ID)] == [
            JOB_ID,
            OTHER_JOB_ID,
        ]
        assert str((await client.get_job(JOB_ID, project_id=PROJECT_ID)).id) == JOB_ID
        assert str((await client.get_job_result(JOB_ID, project_id=PROJECT_ID)).job_id) == JOB_ID
        assert (await client.list_jobs(limit=1, offset=2, project_id=PROJECT_ID))["total"] == 0
        assert await client.cancel_job(JOB_ID, project_id=PROJECT_ID) is None
        assert await client.get_job_page(JOB_ID, 1, project_id=PROJECT_ID) == b"synthetic-page"
        assert str((await client.wait_for_job(JOB_ID, project_id=PROJECT_ID)).id) == JOB_ID
        assert [str(job.id) for job in await client.wait_for_jobs([JOB_ID, OTHER_JOB_ID], project_id=PROJECT_ID)] == [
            JOB_ID,
            OTHER_JOB_ID,
        ]
    assert_scoped_trace(seen, target)


def test_enterprise_and_blank_scope_fail_before_operation_http(project_server) -> None:
    base_url, seen = project_server
    with XbergClient(base_url=base_url, target="enterprise") as client:
        with pytest.raises(XbergError, match=r"requires.*pro"):
            client.extract(file=b"scope proof", project_id=PROJECT_ID)
        with pytest.raises(XbergError, match=r"requires.*pro"):
            client.get_job(JOB_ID, project_id=PROJECT_ID)
        with pytest.raises(ValueError, match="must not be blank"):
            client.get_job(JOB_ID, project_id=" ")
    assert seen == []


async def test_async_scope_isolation_and_enterprise_guard(project_server) -> None:
    base_url, seen = project_server
    async with AsyncXbergClient(base_url=base_url, target="enterprise") as client:
        with pytest.raises(XbergError, match=r"requires.*pro"):
            await client.get_job(JOB_ID, project_id=PROJECT_ID)
        with pytest.raises(ValueError, match="must not be blank"):
            await client.get_job(JOB_ID, project_id="")
    assert seen == []
    async with AsyncXbergClient(base_url=base_url) as client:
        jobs = await asyncio.gather(*(client.get_job(JOB_ID, project_id=p) for p in [PROJECT_ID, OTHER_JOB_ID]))
        assert [str(job.id) for job in jobs] == [JOB_ID, JOB_ID]
    assert len([row for row in seen if row[1] == "/healthz"]) == 1
    assert sorted(parse_qs(urlsplit(row[1]).query)["project_id"][0] for row in seen if row[1] != "/healthz") == [
        PROJECT_ID,
        OTHER_JOB_ID,
    ]


def test_scoped_call_does_not_change_client_headers_or_later_unscoped_url(project_server) -> None:
    base_url, seen = project_server
    with XbergClient(base_url=base_url, target="pro", headers={"X-Project-ID": "default-project"}) as client:
        assert str(client.extract(file=b"proof", project_id=PROJECT_ID).id) == JOB_ID
        with pytest.raises(XbergError) as missing:
            client.get_job(JOB_ID)
        assert missing.value.status_code == 404
    assert seen == [
        ("POST", "/v1/extract", PROJECT_ID),
        ("GET", f"/v1/jobs/{JOB_ID}?project_id={PROJECT_ID}", "default-project"),
        ("GET", f"/v1/jobs/{JOB_ID}", "default-project"),
    ]
