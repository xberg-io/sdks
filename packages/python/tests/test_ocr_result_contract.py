"""New OCR fields are typed, and result projections preserve extension JSON."""

from __future__ import annotations

import json
import threading
from http.server import BaseHTTPRequestHandler, ThreadingHTTPServer
from pathlib import Path

import pytest

from xberg_io_sdk import AsyncXbergClient, XbergClient
from xberg_io_sdk._generated_api.models.extraction_config import ExtractionConfig

DOCUMENT = json.loads(
    (Path(__file__).resolve().parents[3] / "spec/fixtures/extraction_result_ocr_recovery.json").read_text()
)
JOB_ID = "aaaaaaaa-0000-4000-8000-000000000001"


@pytest.fixture
def ocr_server():
    paths = []

    class Handler(BaseHTTPRequestHandler):
        def do_GET(self):
            paths.append(self.path)
            payload = (
                {"job_id": JOB_ID, "status": "completed", "cached": False, "results": [DOCUMENT]}
                if self.path.endswith("/result")
                else {
                    "id": JOB_ID,
                    "filename": "synthetic.pdf",
                    "mime_type": "application/pdf",
                    "job_type": "extraction",
                    "status": "completed",
                    "created_at": "2026-10-16T00:00:00Z",
                    "result": DOCUMENT,
                }
            )
            self.send_response(200)
            self.send_header("Content-Type", "application/json")
            self.end_headers()
            self.wfile.write(json.dumps(payload).encode())

        def log_message(self, *args):
            pass

    server = ThreadingHTTPServer(("127.0.0.1", 0), Handler)
    thread = threading.Thread(target=server.serve_forever)
    thread.start()
    try:
        yield f"http://127.0.0.1:{server.server_port}", paths
    finally:
        server.shutdown()
        server.server_close()
        thread.join()


@pytest.mark.parametrize("target", ["pro", "enterprise"])
@pytest.mark.parametrize("asynchronous", [False, True])
async def test_http_job_exposes_typed_ocr_recovery_fields(ocr_server, target, asynchronous):
    base_url, paths = ocr_server
    if asynchronous:
        async with AsyncXbergClient(base_url=base_url, target=target) as client:
            job = await client.get_job(JOB_ID)
            result = await client.get_job_result(JOB_ID)
    else:
        with XbergClient(base_url=base_url, target=target) as client:
            job = client.get_job(JOB_ID)
            result = client.get_job_result(JOB_ID)
    assert job.result.ocr_page_failures[0].page == 1
    assert job.result.ocr_page_failures[0].recovered is True
    assert job.result.pages[0].native_content == "Invoice total 125.50"
    assert job.result.to_dict()["future_opaque"] == {"numbers": [1, 2], "flag": False}
    assert result.results[0].to_dict()["ocr_page_failures"] == DOCUMENT["ocr_page_failures"]
    assert result.results[0].to_dict()["pages"] == DOCUMENT["pages"]
    assert result.results[0].to_dict()["future_opaque"] == DOCUMENT["future_opaque"]
    assert paths == [f"/v1/jobs/{JOB_ID}", f"/v1/jobs/{JOB_ID}/result"]


def test_ocr_request_settings_have_typed_access_and_round_trip():
    raw = {"ocr": {"backend": "paddleocr", "paddle_ocr_settings": {"device": "cpu", "threads": 2}}}
    config = ExtractionConfig.from_dict(raw)
    assert config.ocr.paddle_ocr_settings.to_dict() == {"device": "cpu", "threads": 2}
    assert config.to_dict() == raw
