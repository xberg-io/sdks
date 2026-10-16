import assert from "node:assert/strict";
import { createHash, randomUUID } from "node:crypto";
import { execFile } from "node:child_process";
import { mkdir, open, readFile, unlink } from "node:fs/promises";
import { isAbsolute, join } from "node:path";
import { fileURLToPath } from "node:url";
import { promisify } from "node:util";
import { NotFoundError, XbergClient } from "../dist/index.js";
import { appendJournal, assertCaseCensus, assertDocument, journalFetch } from "./contracts.mjs";

const CASES = [
  "auth-disabled",
  "enterprise-tier-guard",
  "single-native",
  "batch-native",
  "jobs-pagination",
  "saved-preset-crud",
  "missing-job",
  "terminal-cancel",
];
const WAIT = { timeoutMs: 120_000, pollIntervalMs: 250, backoff: "constant" };

function required(name) {
  const value = process.env[name];
  assert.ok(value, `${name} is required; deployment tests never silently skip`);
  return value;
}

async function guard(command, journal, phase) {
  assert.ok(Array.isArray(command) && command.length > 0 && command.every((part) => typeof part === "string"));
  await promisify(execFile)(command[0], command.slice(1), { timeout: 120_000, maxBuffer: 65_536 });
  await appendJournal(journal, { event: "runtime_guard_pass", phase });
}

async function savedPresets(client, state) {
  const body = {
    name: `sdk-${state.nonce}`,
    preferred_call_mode: "text_only",
    schema: { type: "object", properties: { invoice: { type: "string" } }, required: ["invoice"] },
  };
  const created = await client.createSavedPreset(body);
  state.presetId = created.id;
  assert.equal(created.success, true);
  assert.equal(typeof created.id, "string");
  const detail = await client.getSavedPreset(created.id);
  assert.equal(detail.name, body.name);
  assert.deepEqual(detail.schema, body.schema);
  const listed = await client.listSavedPresets({ limit: 100, offset: 0 });
  assert.ok(listed.presets.some((preset) => preset.id === created.id));
  await client.updateSavedPreset(created.id, { name: `${body.name}-updated` });
  assert.equal((await client.getSavedPreset(created.id)).name, `${body.name}-updated`);
  await client.deleteSavedPreset(created.id);
  state.presetId = undefined;
  await assert.rejects(
    client.getSavedPreset(created.id),
    (error) => error instanceof NotFoundError && error.status === 404,
  );
}

async function runCases(client, state, journal) {
  const executed = [];
  const scope = { projectId: state.projectId };
  async function check(name, operation) {
    await appendJournal(journal, { event: "case_started", name });
    try {
      await operation();
    } catch (error) {
      await appendJournal(journal, {
        event: "case_failed",
        name,
        code: error.code === "ERR_ASSERTION" ? "ERR_ASSERTION" : "SDK_OPERATION_FAILED",
        message: `Case ${name} failed; inspect its source assertion and preceding request receipts`,
      });
      throw error;
    }
    executed.push(name);
    await appendJournal(journal, { event: "case_pass", name });
  }
  await check("auth-disabled", async () => {
    const config = await client.authConfig();
    assert.equal(config.mode, "disabled");
    assert.deepEqual(config.methods, []);
    assert.equal(config.oidc.enabled, false);
  });
  await check("enterprise-tier-guard", async () => {
    await assert.rejects(client.versions(randomUUID()), /not available on the 'pro' tier/);
  });
  const text = (name) => `SDK deployment ${state.nonce} ${name}\nInvoice 42\nTotal USD 19.50`;
  const file = (name) => ({ name: `${name}.txt`, mimeType: "text/plain", data: new TextEncoder().encode(text(name)) });
  const options = { extraction_config: { use_cache: false, disable_ocr: true } };
  async function verify(job, name) {
    const terminal = await client.waitForJob(job.id, { ...WAIT, ...scope });
    assert.equal(terminal.id, job.id);
    assert.equal(terminal.status, "completed");
    assert.equal(terminal.filename, `${name}.txt`);
    assertDocument(await client.getJobResult(job.id, scope), job.id, text(name));
  }
  await check("single-native", async () => {
    const job = await client.extract({ ...scope, file: file("single"), options });
    state.singleJob = job.id;
    await verify(job, "single");
  });
  await check("batch-native", async () => {
    const names = ["batch-a", "batch-b"];
    const jobs = await client.extractBatch({ ...scope, files: names.map((name) => file(name)), options });
    assert.equal(jobs.length, 2);
    assert.equal(new Set(jobs.map((job) => job.id)).size, 2);
    for (const [index, job] of jobs.entries()) await verify(job, names[index]);
  });
  await check("jobs-pagination", async () => {
    const first = await client.listJobs({ ...scope, limit: 1, offset: 0 });
    const second = await client.listJobs({ ...scope, limit: 1, offset: 1 });
    assert.equal(first.limit, 1);
    assert.equal(second.limit, 1);
    assert.equal(first.offset, 0);
    assert.equal(second.offset, 1);
    assert.equal(first.jobs.length, 1);
    assert.equal(second.jobs.length, 1);
    assert.notEqual(first.jobs[0].id, second.jobs[0].id);
    assert.equal(first.total, second.total);
    assert.ok(first.total >= 3);
  });
  await check("saved-preset-crud", () => savedPresets(client, state));
  await check("missing-job", async () => {
    await assert.rejects(
      client.getJob(randomUUID(), scope),
      (error) => error instanceof NotFoundError && error.status === 404,
    );
  });
  await check("terminal-cancel", async () => {
    await client.cancelJob(state.singleJob, scope);
    assert.equal((await client.getJob(state.singleJob, scope)).status, "completed");
  });
  assertCaseCensus(CASES, executed);
  return executed;
}

export async function drain(client, journal, scope = {}) {
  let entries = (await readFile(journal, "utf8"))
    .trim()
    .split("\n")
    .map((line) => JSON.parse(line));
  let started = entries.filter((entry) => entry.event === "request_started" && entry.mutation);
  let responses = entries.filter((entry) => entry.event === "response_received" || entry.event === "transport_failed");
  for (const start of started.filter((entry) => entry.method === "POST" && entry.path === "/v1/saved_presets")) {
    const receipt = responses.find((entry) => entry.request_id === start.request_id);
    if (receipt?.resource_id) {
      const deletion = entries.find(
        (entry) =>
          entry.event === "request_started" &&
          entry.method === "DELETE" &&
          entry.path === `/v1/saved_presets/${encodeURIComponent(receipt.resource_id)}`,
      );
      if (!deletion) await client.deleteSavedPreset(receipt.resource_id);
    }
  }
  entries = (await readFile(journal, "utf8"))
    .trim()
    .split("\n")
    .map((line) => JSON.parse(line));
  started = entries.filter((entry) => entry.event === "request_started" && entry.mutation);
  responses = entries.filter((entry) => entry.event === "response_received" || entry.event === "transport_failed");
  const unresolved = started.filter((start) => {
    const end = responses.find((entry) => entry.request_id === start.request_id);
    return !end || end.admission === "unresolved";
  });
  const jobs = [...new Set(entries.flatMap((entry) => entry.admitted_jobs ?? []))];
  const terminal = [];
  for (const id of jobs) {
    try {
      await client.waitForJob(id, { ...WAIT, ...scope });
    } catch (error) {
      if (!["failed", "cancelled"].includes(error.body?.status)) throw error;
    }
    terminal.push(id);
  }
  await appendJournal(journal, {
    event: "drain",
    acknowledged_jobs: jobs.length,
    terminal_jobs: terminal.length,
    unresolved_writes: unresolved.length,
  });
  assert.equal(unresolved.length, 0, "unresolved admission: preserve journal and reconcile; never replay writes");
  assert.equal(terminal.length, jobs.length);
}

async function main() {
  assert.equal(required("XBERG_SDK_LIVE_APPROVED"), "1", "operator must authorize this bounded write epoch");
  const directory = required("XBERG_SDK_OUTPUT_DIR");
  const lease = required("XBERG_SDK_LIVE_LEASE");
  assert.ok(isAbsolute(directory) && isAbsolute(lease), "output and shared writer lease must be absolute");
  const command = JSON.parse(required("XBERG_SDK_GUARD_COMMAND_JSON"));
  const baseUrl = required("XBERG_BASE_URL");
  const projectId = required("XBERG_PROJECT_ID");
  const leaseHandle = await open(lease, "wx", 0o600);
  let journal;
  try {
    await mkdir(directory, { mode: 0o700 });
    journal = join(directory, "journal.ndjson");
    const bytes = await readFile(fileURLToPath(new URL("../dist/index.js", import.meta.url)));
    await appendJournal(journal, {
      event: "run_started",
      cases: CASES,
      sdk_module_sha256: createHash("sha256").update(bytes).digest("hex"),
    });
    await guard(command, journal, "before");
    const client = new XbergClient({
      baseUrl,
      target: "pro",
      headers: { "x-project-id": projectId },
      retries: 0,
      timeoutMs: 30_000,
      fetch: journalFetch(journal),
    });
    const state = { nonce: randomUUID(), projectId };
    await appendJournal(journal, {
      event: "fixture_manifest",
      project_id: projectId,
      documents: ["single", "batch-a", "batch-b"].map((name) => ({
        filename: `${name}.txt`,
        content: `SDK deployment ${state.nonce} ${name}\nInvoice 42\nTotal USD 19.50`,
      })),
    });
    try {
      const executed = await runCases(client, state, journal);
      await appendJournal(journal, { event: "cases_pass", expected: CASES.length, executed: executed.length });
    } finally {
      try {
        await drain(client, journal, { projectId });
      } finally {
        await guard(command, journal, "after");
      }
    }
    await appendJournal(journal, { event: "run_pass", expected: CASES.length, executed: CASES.length });
    process.stdout.write(`TypeScript deployment contracts: ${CASES.length}/${CASES.length} passed\n`);
  } catch (error) {
    if (journal)
      await appendJournal(journal, {
        event: "run_failed",
        code: error.code === "ERR_ASSERTION" ? "ERR_ASSERTION" : "SDK_RUN_FAILED",
        message: "Deployment SDK run failed; inspect case_failed, admission and runtime guard receipts",
      });
    throw error;
  } finally {
    await leaseHandle.close();
    await unlink(lease);
  }
}

if (process.argv[1] === fileURLToPath(import.meta.url)) {
  main().catch(() => {
    process.stderr.write("TypeScript deployment contracts failed; inspect the private journal before any retry.\n");
    process.exitCode = 1;
  });
}
