import assert from "node:assert/strict";
import { open } from "node:fs/promises";
import { randomUUID } from "node:crypto";

export function assertCaseCensus(expected, actual) {
  assert.ok(expected.length > 0, "case manifest must not be empty");
  assert.equal(new Set(expected).size, expected.length, "duplicate manifest case");
  assert.equal(new Set(actual).size, actual.length, "duplicate executed case");
  assert.deepEqual([...actual].sort(), [...expected].sort(), "executed case census differs");
}

export function assertDocument(result, jobId, expectedContent) {
  assert.equal(result.job_id, jobId, "result belongs to another job");
  assert.equal(result.status, "completed", "job did not complete without partial failures");
  assert.equal(result.cached, false, "cache-disabled fixture must not be cached");
  assert.deepEqual(result.errors ?? [], [], "result contains extraction errors");
  assert.equal(result.results?.length, 1, "expected exactly one extracted document");
  assert.equal(result.results[0].mime_type, "text/plain");
  assert.equal(result.results[0].content.trim(), expectedContent.trim(), "native content changed");
}

export async function appendJournal(file, event) {
  const handle = await open(file, "a", 0o600);
  try {
    await handle.writeFile(`${JSON.stringify({ time: new Date().toISOString(), ...event })}\n`);
    await handle.sync();
  } finally {
    await handle.close();
  }
}

const CANONICAL_UUID = /^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$/;

function values(value) {
  return Array.isArray(value) ? value : value === undefined || value === null ? [] : [value];
}

function knownUUIDs(candidates) {
  return [
    ...new Set(
      candidates
        .filter((id) => typeof id === "string" && CANONICAL_UUID.test(id.toLowerCase()))
        .map((id) => id.toLowerCase()),
    ),
  ];
}

function cleanIDs(ids) {
  return (
    Array.isArray(ids) &&
    ids.length > 0 &&
    ids.every((id) => typeof id === "string" && CANONICAL_UUID.test(id)) &&
    new Set(ids).size === ids.length
  );
}

function jobAcknowledged(body, path, jobs, expectedCount) {
  if (path === "/v1/enrich") return cleanIDs([body?.job_id]);
  if (!["/v1/extract", "/v1/uploads/confirm"].includes(path)) return false;
  if (!cleanIDs(body?.job_ids) || jobs.length !== body.job_ids.length) return false;
  return expectedCount === undefined || expectedCount === body.job_ids.length;
}

function resourceAcknowledged(body, status, path, method) {
  if (path === "/v1/saved_presets" && method === "POST") {
    return status === 201 && CANONICAL_UUID.test(body?.id ?? "") && body?.success === true;
  }
  if (path.startsWith("/v1/saved_presets/") && method === "PATCH") return status === 200 && body?.success === true;
  const deletable = path.startsWith("/v1/saved_presets/") || path.startsWith("/v1/jobs/");
  return method === "DELETE" && status === 204 && deletable;
}

function receipt(body, status, path, method, expectedCount) {
  const claims = [
    ...values(body?.job_ids),
    ...values(body?.job_id),
    ...values(body?.documents).flatMap((entry) => values(entry?.job_id)),
  ];
  const crawls = [...values(body?.crawl_job_ids), ...values(body?.crawl_job_id)];
  const jobs = knownUUIDs(claims);
  const noClaims = claims.length === 0 && crawls.length === 0;
  let admission = "unresolved";
  if (status >= 400 && status < 500 && noClaims) admission = "rejected";
  else if (status === 202 && crawls.length === 0 && jobAcknowledged(body, path, jobs, expectedCount))
    admission = "acknowledged";
  else if (noClaims && resourceAcknowledged(body, status, path, method)) admission = "response_received";
  return { admission, admitted_jobs: jobs, observed_crawl_jobs: knownUUIDs(crawls) };
}

export function journalFetch(file, transport = fetch) {
  return async (input, init = {}) => {
    const url = new URL(typeof input === "string" || input instanceof URL ? input : input.url);
    const method = (init.method ?? (input instanceof Request ? input.method : "GET")).toUpperCase();
    const mutation = !["GET", "HEAD"].includes(method);
    const requestId = randomUUID();
    await appendJournal(file, {
      event: "request_started",
      request_id: requestId,
      method,
      path: url.pathname,
      mutation,
    });
    let response;
    try {
      response = await transport(input, init);
    } catch (error) {
      await appendJournal(file, {
        event: "transport_failed",
        request_id: requestId,
        admission: mutation ? "unresolved" : "read_only",
      });
      throw error;
    }
    let body;
    if (mutation) {
      try {
        body = await response.clone().json();
      } catch {}
    }
    const expectedCount =
      init.body instanceof FormData && url.pathname === "/v1/extract" ? init.body.getAll("file").length : undefined;
    const result = mutation
      ? receipt(body, response.status, url.pathname, method, expectedCount)
      : { admission: "read_only", admitted_jobs: [], observed_crawl_jobs: [] };
    await appendJournal(file, {
      event: "response_received",
      request_id: requestId,
      status: response.status,
      ...result,
      ...(expectedCount === undefined ? {} : { expected_job_count: expectedCount }),
      ...(typeof body?.id === "string" ? { resource_id: body.id } : {}),
    });
    return response;
  };
}
