"""Real HTTP project selection for SSE subscriptions and enrichment."""

import json
import threading
from http.server import BaseHTTPRequestHandler, ThreadingHTTPServer
from urllib.parse import parse_qs, urlsplit

import pytest

from tests.test_crawl_events import COMPLETE_EVENT
from xberg_io_sdk import AsyncXbergClient, NotFoundError, XbergClient, XbergError


@pytest.fixture
def scoped_server(request):
    paths, bodies = [], []
    require_scope = getattr(request, "param", True)

    class Handler(BaseHTTPRequestHandler):
        def do_GET(self):
            paths.append((self.command, self.path))
            url = urlsplit(self.path)
            if require_scope and parse_qs(url.query).get("project_id") != ["owned"]:
                self.send_response(404)
                self.end_headers()
                return
            self.send_response(200)
            self.send_header(
                "Content-Type", "text/event-stream" if url.path.endswith("/events") else "application/json"
            )
            self.end_headers()
            payload = (
                "data: " + json.dumps(COMPLETE_EVENT) + "\n\n"
                if url.path.endswith("/events")
                else json.dumps({"job_id": "enrich-1", "status": "completed", "result": {"entities": []}})
            )
            self.wfile.write(payload.encode())

        def do_POST(self):
            paths.append((self.command, self.path))
            bodies.append(json.loads(self.rfile.read(int(self.headers["Content-Length"]))))
            if require_scope and parse_qs(urlsplit(self.path).query).get("project_id") != ["owned"]:
                self.send_response(404)
                self.end_headers()
                return
            self.send_response(202)
            self.send_header("Content-Type", "application/json")
            self.end_headers()
            self.wfile.write(b'{"job_id":"enrich-1"}')

        def log_message(self, *args):
            pass

    server = ThreadingHTTPServer(("127.0.0.1", 0), Handler)
    thread = threading.Thread(target=server.serve_forever)
    thread.start()
    try:
        yield f"http://127.0.0.1:{server.server_port}", paths, bodies
    finally:
        server.shutdown()
        server.server_close()
        thread.join()


@pytest.mark.parametrize("asynchronous", [False, True])
async def test_stream_and_enrich_scope_reaches_owned_project(scoped_server, asynchronous):
    url, paths, bodies = scoped_server
    if asynchronous:
        async with AsyncXbergClient(base_url=url, target="pro") as client:
            with pytest.raises(NotFoundError):
                _ = [e async for e in client.stream_crawl_events("crawl-1")]
            events = [e async for e in client.stream_crawl_events("crawl-1", project_id="owned")]
            submitted = await client.submit_enrich({"text": "café"}, project_id="owned")
            status = await client.get_enrich_status("enrich-1", project_id="owned")
            with pytest.raises(NotFoundError):
                await client.get_enrich_status("enrich-1", project_id="other")
    else:
        with XbergClient(base_url=url, target="pro") as client:
            with pytest.raises(NotFoundError):
                list(client.stream_crawl_events("crawl-1"))
            events = list(client.stream_crawl_events("crawl-1", project_id="owned"))
            submitted = client.submit_enrich({"text": "café"}, project_id="owned")
            status = client.get_enrich_status("enrich-1", project_id="owned")
            with pytest.raises(NotFoundError):
                client.get_enrich_status("enrich-1", project_id="other")
    assert [e.pages_crawled for e in events] == [12]
    assert submitted.job_id == "enrich-1"
    assert status.status == "completed"
    assert bodies == [{"text": "café"}]
    assert paths == [
        ("GET", "/v1/crawl-jobs/crawl-1/events"),
        ("GET", "/v1/crawl-jobs/crawl-1/events?project_id=owned"),
        ("POST", "/v1/enrich?project_id=owned"),
        ("GET", "/v1/enrich/enrich-1?project_id=owned"),
        ("GET", "/v1/enrich/enrich-1?project_id=other"),
    ]


@pytest.mark.parametrize("asynchronous", [False, True])
async def test_scope_rejects_enterprise_before_http(scoped_server, asynchronous):
    url, paths, _ = scoped_server
    if asynchronous:
        async with AsyncXbergClient(base_url=url, target="enterprise") as client:
            with pytest.raises(XbergError, match="pro"):
                _ = [e async for e in client.stream_crawl_events("crawl-1", project_id="owned")]
            with pytest.raises(XbergError, match="pro"):
                await client.submit_enrich({"text": "x"}, project_id="owned")
            with pytest.raises(XbergError, match="pro"):
                await client.get_enrich_status("enrich-1", project_id="owned")
            for operation in [
                lambda: client.list_jobs(project_id="owned"),
                lambda: client.get_job("job-1", project_id="owned"),
                lambda: client.cancel_job("job-1", project_id="owned"),
                lambda: client.get_job_result("job-1", project_id="owned"),
                lambda: client.get_job_page("job-1", 1, project_id="owned"),
            ]:
                with pytest.raises(XbergError, match="pro"):
                    await operation()
    else:
        with XbergClient(base_url=url, target="enterprise") as client:
            with pytest.raises(XbergError, match="pro"):
                list(client.stream_crawl_events("crawl-1", project_id="owned"))
            with pytest.raises(XbergError, match="pro"):
                client.submit_enrich({"text": "x"}, project_id="owned")
            with pytest.raises(XbergError, match="pro"):
                client.get_enrich_status("enrich-1", project_id="owned")
            for operation in [
                lambda: client.list_jobs(project_id="owned"),
                lambda: client.get_job("job-1", project_id="owned"),
                lambda: client.cancel_job("job-1", project_id="owned"),
                lambda: client.get_job_result("job-1", project_id="owned"),
                lambda: client.get_job_page("job-1", 1, project_id="owned"),
            ]:
                with pytest.raises(XbergError, match="pro"):
                    operation()
    assert paths == []


@pytest.mark.parametrize("scoped_server", [False], indirect=True)
@pytest.mark.parametrize("asynchronous", [False, True])
async def test_unscoped_enterprise_stream_and_enrichment_remain_compatible(scoped_server, asynchronous):
    url, paths, _ = scoped_server
    if asynchronous:
        async with AsyncXbergClient(base_url=url, target="enterprise") as client:
            assert len([e async for e in client.stream_crawl_events("crawl-1")]) == 1
            await client.submit_enrich({"text": "legacy"})
            await client.get_enrich_status("enrich-1")
    else:
        with XbergClient(base_url=url, target="enterprise") as client:
            assert len(list(client.stream_crawl_events("crawl-1"))) == 1
            client.submit_enrich({"text": "legacy"})
            client.get_enrich_status("enrich-1")
    assert paths == [("GET", "/v1/crawl-jobs/crawl-1/events"), ("POST", "/v1/enrich"), ("GET", "/v1/enrich/enrich-1")]
