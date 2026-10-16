import assert from "node:assert/strict";
import { mkdtemp, readFile, rm } from "node:fs/promises";
import { tmpdir } from "node:os";
import { join } from "node:path";
import test from "node:test";
import { appendJournal, assertCaseCensus, assertDocument, journalFetch } from "./contracts.mjs";
import { drain } from "./run.mjs";

test("case census rejects zero, duplicate, missing and unexpected cases", () => {
  assertCaseCensus(["native", "batch"], ["native", "batch"]);
  for (const actual of [[], ["native"], ["native", "native"], ["native", "batch", "extra"]]) {
    assert.throws(() => assertCaseCensus(["native", "batch"], actual));
  }
  assert.throws(() => assertCaseCensus([], []));
});

test("document oracle rejects wrong identity, content, cardinality, status and errors", () => {
  const valid = {
    job_id: "j",
    status: "completed",
    cached: false,
    errors: [],
    results: [{ content: "Invoice 42\nTotal 19.50", mime_type: "text/plain" }],
  };
  assertDocument(valid, "j", "Invoice 42\nTotal 19.50");
  for (const changed of [
    { ...valid, job_id: "other" },
    { ...valid, status: "partial_success" },
    { ...valid, errors: [{ message: "dropped page" }] },
    { ...valid, results: [] },
    { ...valid, results: [{ content: "Invoice 42", mime_type: "text/plain" }] },
    { ...valid, results: [...valid.results, ...valid.results] },
  ])
    assert.throws(() => assertDocument(changed, "j", "Invoice 42\nTotal 19.50"));
});

test("journal persists an unexpected 202 admission before caller assertion and records no secrets", async () => {
  const directory = await mkdtemp(join(tmpdir(), "sdk-journal-"));
  try {
    const file = join(directory, "journal.ndjson");
    const request = journalFetch(file, () =>
      Promise.resolve(Response.json({ job_ids: ["11111111-1111-4111-8111-111111111111"] }, { status: 202 })),
    );
    const response = await request("http://127.0.0.1:1/v1/extract?token=SECRET", {
      method: "POST",
      headers: { Authorization: "Bearer SECRET" },
      body: "SECRET",
    });
    assert.equal(response.status, 202);
    const text = await readFile(file, "utf8");
    const events = text
      .trim()
      .split("\n")
      .map((line) => JSON.parse(line));
    assert.deepEqual(
      events.map((event) => event.event),
      ["request_started", "response_received"],
    );
    assert.deepEqual(events[1].admitted_jobs, ["11111111-1111-4111-8111-111111111111"]);
    assert.equal(events[1].admission, "acknowledged");
    assert.equal(text.includes("SECRET"), false);
  } finally {
    await rm(directory, { recursive: true });
  }
});

test("journal retains ambiguous writes after transport loss or invalid successful response", async () => {
  for (const transport of [
    () => Promise.reject(new Error("SECRET")),
    () => Promise.resolve(new Response("bad", { status: 202 })),
  ]) {
    const directory = await mkdtemp(join(tmpdir(), "sdk-journal-"));
    try {
      const file = join(directory, "journal.ndjson");
      const request = journalFetch(file, transport);
      try {
        await request("http://127.0.0.1:1/v1/extract", { method: "POST" });
      } catch {}
      const events = (await readFile(file, "utf8"))
        .trim()
        .split("\n")
        .map((line) => JSON.parse(line));
      assert.equal(events.at(-1).admission, "unresolved");
      assert.equal(JSON.stringify(events).includes("SECRET"), false);
    } finally {
      await rm(directory, { recursive: true });
    }
  }
});

test("drain discovers acknowledged jobs and orphan preset receipts before any caller state exists", async () => {
  const directory = await mkdtemp(join(tmpdir(), "sdk-drain-"));
  try {
    const file = join(directory, "journal.ndjson");
    const events = [
      { event: "request_started", request_id: "job", method: "POST", path: "/v1/extract", mutation: true },
      { event: "response_received", request_id: "job", status: 202, admission: "acknowledged", admitted_jobs: ["j"] },
      { event: "request_started", request_id: "preset", method: "POST", path: "/v1/saved_presets", mutation: true },
      {
        event: "response_received",
        request_id: "preset",
        status: 201,
        admission: "response_received",
        resource_id: "p",
      },
    ];
    for (const event of events) await appendJournal(file, event);
    const calls = [];
    await drain(
      {
        deleteSavedPreset: (id) => Promise.resolve(calls.push(["delete", id])),
        waitForJob: (id) => Promise.resolve(calls.push(["drain", id])),
      },
      file,
    );
    assert.deepEqual(calls, [
      ["delete", "p"],
      ["drain", "j"],
    ]);
    await appendJournal(file, {
      event: "request_started",
      request_id: "lost",
      method: "POST",
      path: "/v1/extract",
      mutation: true,
    });
    await assert.rejects(
      drain({ deleteSavedPreset: () => Promise.resolve(), waitForJob: () => Promise.resolve() }, file),
      /unresolved admission/,
    );
  } finally {
    await rm(directory, { recursive: true });
  }
});

const UUID_A = "11111111-1111-4111-8111-111111111111";
const UUID_B = "22222222-2222-4222-8222-222222222222";

test("journal retains known IDs but rejects contradictory or malformed admission receipts", async () => {
  const variants = [
    { status: 400, body: { job_ids: [UUID_A] }, admission: "unresolved", known: [UUID_A] },
    { status: 202, body: { job_ids: [UUID_A, UUID_A] }, admission: "unresolved", known: [UUID_A] },
    { status: 202, body: { job_ids: [UUID_A, 7] }, admission: "unresolved", known: [UUID_A] },
    {
      status: 202,
      body: { job_ids: ["AAAAAAAA-AAAA-4AAA-8AAA-AAAAAAAAAAAA"] },
      admission: "unresolved",
      known: ["aaaaaaaa-aaaa-4aaa-8aaa-aaaaaaaaaaaa"],
    },
    { status: 202, body: { job_ids: [UUID_A], crawl_job_ids: [UUID_B] }, admission: "unresolved", known: [UUID_A] },
    { status: 500, body: { job_ids: [UUID_A] }, admission: "unresolved", known: [UUID_A] },
    { status: 202, body: { job_ids: [UUID_A, UUID_B] }, admission: "unresolved", known: [UUID_A, UUID_B] },
    { status: 400, body: { error: "invalid request" }, admission: "rejected", known: [] },
  ];
  for (const variant of variants) {
    const directory = await mkdtemp(join(tmpdir(), "sdk-admission-"));
    try {
      const file = join(directory, "journal.ndjson");
      const request = journalFetch(file, () =>
        Promise.resolve(Response.json(variant.body, { status: variant.status })),
      );
      const form = new FormData();
      form.append("file", new Blob(["synthetic"]), "invoice.txt");
      await request("http://127.0.0.1:1/v1/extract", { method: "POST", body: form });
      const receipt = JSON.parse((await readFile(file, "utf8")).trim().split("\n").at(-1));
      assert.equal(receipt.admission, variant.admission, JSON.stringify(variant));
      assert.deepEqual(receipt.admitted_jobs, variant.known);
      if (variant.body.crawl_job_ids) assert.deepEqual(receipt.observed_crawl_jobs, [UUID_B]);
    } finally {
      await rm(directory, { recursive: true });
    }
  }
});
