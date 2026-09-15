"""Coverage for the auto-tune and tuning-profile surfaces, which both specs declare ungated.

``POST /v1/auto-tune`` is the one multipart operation outside ``extract``: a JSON ``request``
part plus one repeated ``file`` part per document. Everything else is plain JSON. Each method
is exercised once synchronously and once asynchronously, asserting verb, path, and the model
the body decodes into.
"""

from __future__ import annotations

import json
from typing import TYPE_CHECKING

import httpx
import pytest
import respx

from xberg_io_sdk import AsyncXbergClient, XbergClient, XbergError
from xberg_io_sdk._generated_api.models.promote_profile_request import PromoteProfileRequest

if TYPE_CHECKING:
    from pathlib import Path

PRO_URL = "https://pro.example.test"
AUTO_TUNE_PATH = "/v1/auto-tune"
TUNING_PROFILES_PATH = "/v1/tuning-profiles"
JOB_ID = "66666666-6666-6666-6666-666666666666"
PROFILE_ID = "77777777-7777-7777-7777-777777777777"

JOB_SUMMARY = {
    "auto_tune_job_id": JOB_ID,
    "created_at": "2026-05-01T09:00:00Z",
    "status": "running",
    "trials_completed": 3,
    "trials_total": 12,
    "best_score": 0.82,
}

JOB_STATUS = {
    "auto_tune_job_id": JOB_ID,
    "status": "running",
    "trials_completed": 3,
    "trials_total": 12,
    "best_score": 0.82,
    "budget_spent": 1200,
}

CAPABILITIES = {
    "default_ocr_ladder": ["tesseract", "paddle-ocr"],
    "max_trials": 32,
    "max_wall_clock_secs": 1800,
    "ocr_backends": [{"name": "tesseract", "cost": "local", "in_default_ladder": True}],
    "tunable_knobs": [{"knob": "ocr_backend", "description": "Which OCR backend to run."}],
}

AUTO_TUNE_RESULT = {
    "auto_tune_job_id": JOB_ID,
    "leaderboard": [
        {
            "breakdown": {"invoice.pdf": 0.91},
            "config": {"ocr_backend": "tesseract"},
            "primary_score": 0.91,
            "tied_with_winner": True,
            "variance": 0.01,
        }
    ],
    "profile": {"ocr_backend": "tesseract"},
    "held_out_confidence": 0.88,
}

PROFILE_DETAIL = {
    "id": PROFILE_ID,
    "name": "invoices-tuned",
    "created_at": "2026-05-03T09:00:00Z",
    "profile": {"ocr_backend": "tesseract"},
    "scores": {"primary": 0.91},
}

PROFILE_LIST = {
    "profiles": [{"id": PROFILE_ID, "name": "invoices-tuned", "created_at": "2026-05-03T09:00:00Z"}],
    "total": 1,
}

SUBMIT_REQUEST = {"documents": [{"filename": "invoice.pdf", "ground_truth": {"total": 42}}]}


# -- auto-tune — sync ----------------------------------------------------------


@respx.mock
def test_list_auto_tune_jobs_sync_forwards_pagination(base_url: str, api_key: str) -> None:
    route = respx.get(f"{base_url}{AUTO_TUNE_PATH}").mock(
        return_value=httpx.Response(200, json={"jobs": [JOB_SUMMARY], "total": 1}),
    )
    with XbergClient(api_key=api_key, base_url=base_url) as client:
        response = client.list_auto_tune_jobs(limit=5, offset=10)

    assert response.total == 1
    assert str(response.jobs[0].auto_tune_job_id) == JOB_ID
    assert response.jobs[0].trials_total == 12
    assert route.calls.last.request.method == "GET"
    assert route.calls.last.request.url.path == AUTO_TUNE_PATH
    assert dict(route.calls.last.request.url.params) == {"limit": "5", "offset": "10"}


@respx.mock
def test_submit_auto_tune_sync_sends_multipart_request_and_file_parts(
    base_url: str,
    api_key: str,
    tmp_path: Path,
) -> None:
    document = tmp_path / "invoice.pdf"
    document.write_bytes(b"%PDF-1.7 sample")
    route = respx.post(f"{base_url}{AUTO_TUNE_PATH}").mock(
        return_value=httpx.Response(201, json={"auto_tune_job_id": JOB_ID, "status": "queued"}),
    )
    with XbergClient(api_key=api_key, base_url=base_url) as client:
        response = client.submit_auto_tune(SUBMIT_REQUEST, [document])

    assert str(response.auto_tune_job_id) == JOB_ID
    assert response.status == "queued"
    request = route.calls.last.request
    assert request.method == "POST"
    assert request.url.path == AUTO_TUNE_PATH
    assert request.headers["content-type"].startswith("multipart/form-data")
    body = request.content.decode("latin-1")
    assert 'name="request"' in body
    assert json.dumps(SUBMIT_REQUEST) in body
    assert 'name="file"; filename="invoice.pdf"' in body


@respx.mock
def test_submit_auto_tune_sync_sends_one_part_per_file(base_url: str, api_key: str) -> None:
    route = respx.post(f"{base_url}{AUTO_TUNE_PATH}").mock(
        return_value=httpx.Response(201, json={"auto_tune_job_id": JOB_ID, "status": "queued"}),
    )
    with XbergClient(api_key=api_key, base_url=base_url) as client:
        client.submit_auto_tune(SUBMIT_REQUEST, [b"first", b"second"])

    assert route.call_count == 1
    assert route.calls.last.request.content.decode("latin-1").count('name="file"') == 2


def test_submit_auto_tune_sync_rejects_an_empty_file_list(base_url: str, api_key: str) -> None:
    with (
        XbergClient(api_key=api_key, base_url=base_url) as client,
        pytest.raises(XbergError, match="submit_auto_tune called with no files"),
    ):
        client.submit_auto_tune(SUBMIT_REQUEST, [])


@respx.mock
def test_get_auto_tune_capabilities_sync(base_url: str, api_key: str) -> None:
    route = respx.get(f"{base_url}{AUTO_TUNE_PATH}/capabilities").mock(
        return_value=httpx.Response(200, json=CAPABILITIES),
    )
    with XbergClient(api_key=api_key, base_url=base_url) as client:
        response = client.get_auto_tune_capabilities()

    assert response.default_ocr_ladder == ["tesseract", "paddle-ocr"]
    assert response.ocr_backends[0].name == "tesseract"
    assert response.ocr_backends[0].cost == "local"
    assert response.tunable_knobs[0].knob == "ocr_backend"
    assert route.calls.last.request.method == "GET"
    assert route.calls.last.request.url.path == f"{AUTO_TUNE_PATH}/capabilities"


@respx.mock
def test_get_auto_tune_status_sync(base_url: str, api_key: str) -> None:
    route = respx.get(f"{base_url}{AUTO_TUNE_PATH}/{JOB_ID}").mock(return_value=httpx.Response(200, json=JOB_STATUS))
    with XbergClient(api_key=api_key, base_url=base_url) as client:
        status = client.get_auto_tune_status(JOB_ID)

    assert str(status.auto_tune_job_id) == JOB_ID
    assert status.trials_completed == 3
    assert status.budget_spent == 1200
    assert route.calls.last.request.method == "GET"
    assert route.calls.last.request.url.path == f"{AUTO_TUNE_PATH}/{JOB_ID}"


@respx.mock
def test_delete_auto_tune_job_sync_returns_none_on_204(base_url: str, api_key: str) -> None:
    route = respx.delete(f"{base_url}{AUTO_TUNE_PATH}/{JOB_ID}").mock(return_value=httpx.Response(204))
    with XbergClient(api_key=api_key, base_url=base_url) as client:
        assert client.delete_auto_tune_job(JOB_ID) is None

    assert route.calls.last.request.method == "DELETE"
    assert route.calls.last.request.url.path == f"{AUTO_TUNE_PATH}/{JOB_ID}"


@respx.mock
def test_promote_auto_tune_profile_sync(base_url: str, api_key: str) -> None:
    route = respx.post(f"{base_url}{AUTO_TUNE_PATH}/{JOB_ID}/promote").mock(
        return_value=httpx.Response(201, json=PROFILE_DETAIL),
    )
    with XbergClient(api_key=api_key, base_url=base_url) as client:
        profile = client.promote_auto_tune_profile(JOB_ID, PromoteProfileRequest(name="invoices-tuned"))

    assert str(profile.id) == PROFILE_ID
    assert profile.name == "invoices-tuned"
    assert route.calls.last.request.method == "POST"
    assert route.calls.last.request.url.path == f"{AUTO_TUNE_PATH}/{JOB_ID}/promote"
    assert json.loads(route.calls.last.request.content) == {"name": "invoices-tuned"}


@respx.mock
def test_get_auto_tune_result_sync(base_url: str, api_key: str) -> None:
    route = respx.get(f"{base_url}{AUTO_TUNE_PATH}/{JOB_ID}/result").mock(
        return_value=httpx.Response(200, json=AUTO_TUNE_RESULT),
    )
    with XbergClient(api_key=api_key, base_url=base_url) as client:
        result = client.get_auto_tune_result(JOB_ID)

    assert str(result.auto_tune_job_id) == JOB_ID
    assert result.held_out_confidence == 0.88
    assert result.leaderboard[0].primary_score == 0.91
    assert result.leaderboard[0].tied_with_winner is True
    assert route.calls.last.request.method == "GET"
    assert route.calls.last.request.url.path == f"{AUTO_TUNE_PATH}/{JOB_ID}/result"


# -- tuning profiles — sync ----------------------------------------------------


@respx.mock
def test_list_tuning_profiles_sync(base_url: str, api_key: str) -> None:
    route = respx.get(f"{base_url}{TUNING_PROFILES_PATH}").mock(return_value=httpx.Response(200, json=PROFILE_LIST))
    with XbergClient(api_key=api_key, base_url=base_url) as client:
        response = client.list_tuning_profiles(limit=25)

    assert response.total == 1
    assert response.profiles[0].name == "invoices-tuned"
    assert route.calls.last.request.method == "GET"
    assert route.calls.last.request.url.path == TUNING_PROFILES_PATH
    assert dict(route.calls.last.request.url.params) == {"limit": "25"}


@respx.mock
def test_get_tuning_profile_sync(base_url: str, api_key: str) -> None:
    route = respx.get(f"{base_url}{TUNING_PROFILES_PATH}/{PROFILE_ID}").mock(
        return_value=httpx.Response(200, json=PROFILE_DETAIL),
    )
    with XbergClient(api_key=api_key, base_url=base_url) as client:
        profile = client.get_tuning_profile(PROFILE_ID)

    assert str(profile.id) == PROFILE_ID
    assert profile.scores.to_dict() == {"primary": 0.91}
    assert route.calls.last.request.method == "GET"
    assert route.calls.last.request.url.path == f"{TUNING_PROFILES_PATH}/{PROFILE_ID}"


@respx.mock
def test_delete_tuning_profile_sync_returns_none_on_204(base_url: str, api_key: str) -> None:
    route = respx.delete(f"{base_url}{TUNING_PROFILES_PATH}/{PROFILE_ID}").mock(return_value=httpx.Response(204))
    with XbergClient(api_key=api_key, base_url=base_url) as client:
        assert client.delete_tuning_profile(PROFILE_ID) is None

    assert route.calls.last.request.method == "DELETE"
    assert route.calls.last.request.url.path == f"{TUNING_PROFILES_PATH}/{PROFILE_ID}"


# -- ungated on both tiers -----------------------------------------------------


@respx.mock
def test_auto_tune_is_not_tier_gated_on_pro(api_key: str) -> None:
    # respx fails any unmocked request, so a stray /healthz probe would break this test.
    route = respx.get(f"{PRO_URL}{AUTO_TUNE_PATH}").mock(
        return_value=httpx.Response(200, json={"jobs": [], "total": 0}),
    )
    with XbergClient(api_key=api_key, base_url=PRO_URL, target="pro") as client:
        assert client.list_auto_tune_jobs().total == 0

    assert route.call_count == 1


@respx.mock
def test_tuning_profiles_are_not_tier_gated_without_a_target(base_url: str, api_key: str) -> None:
    route = respx.get(f"{base_url}{TUNING_PROFILES_PATH}").mock(
        return_value=httpx.Response(200, json={"profiles": [], "total": 0}),
    )
    with XbergClient(api_key=api_key, base_url=base_url) as client:
        assert client.list_tuning_profiles().profiles == []

    assert route.call_count == 1


# -- auto-tune — async ---------------------------------------------------------


@pytest.mark.asyncio
@respx.mock
async def test_list_auto_tune_jobs_async(base_url: str, api_key: str) -> None:
    route = respx.get(f"{base_url}{AUTO_TUNE_PATH}").mock(
        return_value=httpx.Response(200, json={"jobs": [JOB_SUMMARY], "total": 1}),
    )
    async with AsyncXbergClient(api_key=api_key, base_url=base_url) as client:
        response = await client.list_auto_tune_jobs(offset=4)

    assert response.jobs[0].status == "running"
    assert route.calls.last.request.url.path == AUTO_TUNE_PATH
    assert dict(route.calls.last.request.url.params) == {"offset": "4"}


@pytest.mark.asyncio
@respx.mock
async def test_submit_auto_tune_async_sends_multipart(base_url: str, api_key: str) -> None:
    route = respx.post(f"{base_url}{AUTO_TUNE_PATH}").mock(
        return_value=httpx.Response(201, json={"auto_tune_job_id": JOB_ID, "status": "queued"}),
    )
    async with AsyncXbergClient(api_key=api_key, base_url=base_url) as client:
        response = await client.submit_auto_tune(SUBMIT_REQUEST, [b"payload"])

    assert str(response.auto_tune_job_id) == JOB_ID
    request = route.calls.last.request
    assert request.method == "POST"
    assert request.headers["content-type"].startswith("multipart/form-data")
    assert 'name="request"' in request.content.decode("latin-1")


@pytest.mark.asyncio
async def test_submit_auto_tune_async_rejects_an_empty_file_list(base_url: str, api_key: str) -> None:
    async with AsyncXbergClient(api_key=api_key, base_url=base_url) as client:
        with pytest.raises(XbergError, match="submit_auto_tune called with no files"):
            await client.submit_auto_tune(SUBMIT_REQUEST, [])


@pytest.mark.asyncio
@respx.mock
async def test_get_auto_tune_capabilities_async(base_url: str, api_key: str) -> None:
    route = respx.get(f"{base_url}{AUTO_TUNE_PATH}/capabilities").mock(
        return_value=httpx.Response(200, json=CAPABILITIES),
    )
    async with AsyncXbergClient(api_key=api_key, base_url=base_url) as client:
        response = await client.get_auto_tune_capabilities()

    assert response.tunable_knobs[0].description == "Which OCR backend to run."
    assert route.calls.last.request.url.path == f"{AUTO_TUNE_PATH}/capabilities"


@pytest.mark.asyncio
@respx.mock
async def test_get_auto_tune_status_async(base_url: str, api_key: str) -> None:
    route = respx.get(f"{base_url}{AUTO_TUNE_PATH}/{JOB_ID}").mock(return_value=httpx.Response(200, json=JOB_STATUS))
    async with AsyncXbergClient(api_key=api_key, base_url=base_url) as client:
        status = await client.get_auto_tune_status(JOB_ID)

    assert status.best_score == 0.82
    assert route.calls.last.request.url.path == f"{AUTO_TUNE_PATH}/{JOB_ID}"


@pytest.mark.asyncio
@respx.mock
async def test_delete_auto_tune_job_async(base_url: str, api_key: str) -> None:
    route = respx.delete(f"{base_url}{AUTO_TUNE_PATH}/{JOB_ID}").mock(return_value=httpx.Response(204))
    async with AsyncXbergClient(api_key=api_key, base_url=base_url) as client:
        assert await client.delete_auto_tune_job(JOB_ID) is None

    assert route.calls.last.request.method == "DELETE"


@pytest.mark.asyncio
@respx.mock
async def test_promote_auto_tune_profile_async(base_url: str, api_key: str) -> None:
    route = respx.post(f"{base_url}{AUTO_TUNE_PATH}/{JOB_ID}/promote").mock(
        return_value=httpx.Response(201, json=PROFILE_DETAIL),
    )
    async with AsyncXbergClient(api_key=api_key, base_url=base_url) as client:
        profile = await client.promote_auto_tune_profile(JOB_ID, {"name": "invoices-tuned"})

    assert profile.name == "invoices-tuned"
    assert route.calls.last.request.url.path == f"{AUTO_TUNE_PATH}/{JOB_ID}/promote"
    assert json.loads(route.calls.last.request.content) == {"name": "invoices-tuned"}


@pytest.mark.asyncio
@respx.mock
async def test_get_auto_tune_result_async(base_url: str, api_key: str) -> None:
    route = respx.get(f"{base_url}{AUTO_TUNE_PATH}/{JOB_ID}/result").mock(
        return_value=httpx.Response(200, json=AUTO_TUNE_RESULT),
    )
    async with AsyncXbergClient(api_key=api_key, base_url=base_url) as client:
        result = await client.get_auto_tune_result(JOB_ID)

    assert result.profile.to_dict() == {"ocr_backend": "tesseract"}
    assert route.calls.last.request.url.path == f"{AUTO_TUNE_PATH}/{JOB_ID}/result"


# -- tuning profiles — async ---------------------------------------------------


@pytest.mark.asyncio
@respx.mock
async def test_list_tuning_profiles_async(base_url: str, api_key: str) -> None:
    route = respx.get(f"{base_url}{TUNING_PROFILES_PATH}").mock(return_value=httpx.Response(200, json=PROFILE_LIST))
    async with AsyncXbergClient(api_key=api_key, base_url=base_url) as client:
        response = await client.list_tuning_profiles()

    assert str(response.profiles[0].id) == PROFILE_ID
    assert route.calls.last.request.url.path == TUNING_PROFILES_PATH


@pytest.mark.asyncio
@respx.mock
async def test_get_tuning_profile_async(base_url: str, api_key: str) -> None:
    route = respx.get(f"{base_url}{TUNING_PROFILES_PATH}/{PROFILE_ID}").mock(
        return_value=httpx.Response(200, json=PROFILE_DETAIL),
    )
    async with AsyncXbergClient(api_key=api_key, base_url=base_url) as client:
        profile = await client.get_tuning_profile(PROFILE_ID)

    assert profile.created_at.isoformat() == "2026-05-03T09:00:00+00:00"
    assert route.calls.last.request.url.path == f"{TUNING_PROFILES_PATH}/{PROFILE_ID}"


@pytest.mark.asyncio
@respx.mock
async def test_delete_tuning_profile_async(base_url: str, api_key: str) -> None:
    route = respx.delete(f"{base_url}{TUNING_PROFILES_PATH}/{PROFILE_ID}").mock(return_value=httpx.Response(204))
    async with AsyncXbergClient(api_key=api_key, base_url=base_url) as client:
        assert await client.delete_tuning_profile(PROFILE_ID) is None

    assert route.calls.last.request.method == "DELETE"


# -- POST /v1/auto-tune/{id}/stop ----------------------------------------------


@respx.mock
def test_stop_auto_tune_job_sync_returns_none_on_204(base_url: str, api_key: str) -> None:
    route = respx.post(f"{base_url}{AUTO_TUNE_PATH}/{JOB_ID}/stop").mock(return_value=httpx.Response(204))
    with XbergClient(api_key=api_key, base_url=base_url) as client:
        assert client.stop_auto_tune_job(JOB_ID) is None

    assert route.calls.last.request.method == "POST"
    assert route.calls.last.request.url.path == f"{AUTO_TUNE_PATH}/{JOB_ID}/stop"


@respx.mock
def test_stop_auto_tune_job_sync_is_ungated_on_pro(api_key: str) -> None:
    route = respx.post(f"{PRO_URL}{AUTO_TUNE_PATH}/{JOB_ID}/stop").mock(return_value=httpx.Response(204))
    with XbergClient(api_key=api_key, base_url=PRO_URL, target="pro") as client:
        assert client.stop_auto_tune_job(JOB_ID) is None

    assert route.call_count == 1


@respx.mock
def test_stop_auto_tune_job_sync_propagates_a_conflict(base_url: str, api_key: str) -> None:
    respx.post(f"{base_url}{AUTO_TUNE_PATH}/{JOB_ID}/stop").mock(
        return_value=httpx.Response(409, json={"error": "job already finished"}),
    )
    with (
        XbergClient(api_key=api_key, base_url=base_url) as client,
        pytest.raises(XbergError) as error,
    ):
        client.stop_auto_tune_job(JOB_ID)

    assert error.value.status_code == 409


@pytest.mark.asyncio
@respx.mock
async def test_stop_auto_tune_job_async_returns_none_on_204(base_url: str, api_key: str) -> None:
    route = respx.post(f"{base_url}{AUTO_TUNE_PATH}/{JOB_ID}/stop").mock(return_value=httpx.Response(204))
    async with AsyncXbergClient(api_key=api_key, base_url=base_url) as client:
        assert await client.stop_auto_tune_job(JOB_ID) is None

    assert route.calls.last.request.url.path == f"{AUTO_TUNE_PATH}/{JOB_ID}/stop"
