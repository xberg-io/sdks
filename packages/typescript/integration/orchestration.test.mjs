import assert from "node:assert/strict";
import { execFile } from "node:child_process";
import { randomUUID } from "node:crypto";
import { once } from "node:events";
import { mkdtemp, readFile, rm } from "node:fs/promises";
import { createServer } from "node:http";
import { tmpdir } from "node:os";
import { join } from "node:path";
import { fileURLToPath } from "node:url";
import { promisify } from "node:util";
import test from "node:test";

async function body(request) {
  const chunks = [];
  for await (const chunk of request) chunks.push(chunk);
  return Buffer.concat(chunks);
}

async function route(request, state) {
  const path = new URL(request.url, "http://fixture.local").pathname;
  const bytes = await body(request);
  if (path === "/auth/config") return [200, { mode: "disabled", methods: [], oidc: { enabled: false } }];
  if (path === "/v1/extract") {
    const form = await new Request("http://fixture.local", {
      method: "POST",
      headers: request.headers,
      body: bytes,
    }).formData();
    const ids = [];
    for (const file of form.getAll("file")) {
      const id = randomUUID();
      ids.push(id);
      state.jobs.set(id, { id, filename: file.name, content: await file.text() });
    }
    return [202, { status: "pending", job_ids: ids }];
  }
  if (path === "/v1/jobs") {
    const params = new URL(request.url, "http://fixture.local").searchParams;
    const limit = Number(params.get("limit"));
    const offset = Number(params.get("offset"));
    return [
      200,
      { jobs: [...state.jobs.values()].slice(offset, offset + limit), limit, offset, total: state.jobs.size },
    ];
  }
  if (path.startsWith("/v1/jobs/")) {
    const id = path.split("/")[3];
    const job = state.jobs.get(id);
    if (!job) return [404, { error: { code: "job.not_found" } }];
    if (request.method === "DELETE") return [204];
    if (path.endsWith("/result"))
      return [
        200,
        {
          job_id: id,
          status: "completed",
          cached: false,
          errors: [],
          results: [{ content: job.content, mime_type: "text/plain" }],
        },
      ];
    state.polls.push(id);
    return [200, { id, filename: job.filename, job_type: "extraction", status: "completed" }];
  }
  return presetRoute(request, state, path, bytes);
}

function presetRoute(request, state, path, bytes) {
  if (path === "/v1/saved_presets" && request.method === "POST") {
    const id = randomUUID();
    state.presets.set(id, { ...JSON.parse(bytes.toString()), id });
    state.createdPresets.push(id);
    return [201, { success: true, id }];
  }
  if (path === "/v1/saved_presets") return [200, { presets: [...state.presets.values()] }];
  const id = path.split("/")[3];
  if (!state.presets.has(id)) return [404, { error: { code: "preset.not_found" } }];
  if (request.method === "DELETE") {
    state.presets.delete(id);
    state.deletedPresets.push(id);
    return [204];
  }
  if (request.method === "PATCH") {
    state.presets.set(id, { ...state.presets.get(id), ...JSON.parse(bytes.toString()) });
    state.updated = true;
    return [200, { success: true }];
  }
  const preset = state.presets.get(id);
  return [200, state.lateFailure && state.updated ? { ...preset, name: "WRONG-SYNTHETIC-NAME" } : preset];
}

for (const lateFailure of [false, true]) {
  test(`full live runner against loopback SDK fixture: ${lateFailure ? "late assertion fails and cleanup drains" : "eight cases pass"}`, async () => {
    const directory = await mkdtemp(join(tmpdir(), "sdk-orchestration-"));
    const state = {
      jobs: new Map(),
      presets: new Map(),
      polls: [],
      createdPresets: [],
      deletedPresets: [],
      lateFailure,
      updated: false,
    };
    const server = createServer((request, response) => {
      route(request, state)
        .then(([status, result]) => {
          response.statusCode = status;
          response.setHeader("Content-Type", "application/json");
          response.end(result === undefined ? undefined : JSON.stringify(result));
        })
        .catch(() => {
          response.statusCode = 500;
          response.end();
        });
    });
    server.listen(0, "127.0.0.1");
    await once(server, "listening");
    try {
      const operation = promisify(execFile)(process.execPath, [fileURLToPath(new URL("./run.mjs", import.meta.url))], {
        env: {
          ...process.env,
          XBERG_SDK_LIVE_APPROVED: "1",
          XBERG_BASE_URL: `http://127.0.0.1:${server.address().port}`,
          XBERG_PROJECT_ID: randomUUID(),
          XBERG_SDK_OUTPUT_DIR: join(directory, "evidence"),
          XBERG_SDK_LIVE_LEASE: join(directory, "writer.lease"),
          XBERG_SDK_GUARD_COMMAND_JSON: JSON.stringify([process.execPath, "-e", "process.exit(0)"]),
        },
        timeout: 20_000,
      });
      if (lateFailure) await assert.rejects(operation);
      else assert.match((await operation).stdout, /8\/8 passed/);
      const entries = (await readFile(join(directory, "evidence/journal.ndjson"), "utf8"))
        .trim()
        .split("\n")
        .map((line) => JSON.parse(line));
      assert.equal(state.jobs.size, 3);
      assert.equal(state.presets.size, 0);
      assert.deepEqual(state.deletedPresets, state.createdPresets);
      assert.equal(new Set(state.polls).size, 3);
      const drain = entries.find((entry) => entry.event === "drain");
      assert.deepEqual([drain.acknowledged_jobs, drain.terminal_jobs, drain.unresolved_writes], [3, 3, 0]);
      assert.equal(entries.filter((entry) => entry.event === "runtime_guard_pass").length, 2);
      assert.equal(
        entries.some((entry) => entry.event === "run_pass"),
        !lateFailure,
      );
      if (lateFailure) {
        assert.equal(entries.find((entry) => entry.event === "case_failed").name, "saved-preset-crud");
        assert.equal(entries.at(-1).event, "run_failed");
        assert.equal(entries.at(-1).code, "ERR_ASSERTION");
      } else assert.equal(entries.filter((entry) => entry.event === "case_pass").length, 8);
    } finally {
      await new Promise((resolve) => {
        server.close(resolve);
      });
      await rm(directory, { recursive: true });
    }
  });
}
