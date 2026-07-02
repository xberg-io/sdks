import { HttpResponse, http } from "msw";
import { afterAll, afterEach, beforeAll, describe, expect, it } from "vitest";
import { KreuzbergCloud } from "../src/client.js";
import { TimeoutError } from "../src/errors.js";
import { TEST_BASE_URL, createTestServer, url } from "./_helpers.js";

const server = createTestServer();

beforeAll(() => server.listen({ onUnhandledRequest: "error" }));
afterEach(() => server.resetHandlers());
afterAll(() => server.close());

function makeClient(): KreuzbergCloud {
  return new KreuzbergCloud({
    apiKey: "k",
    baseUrl: TEST_BASE_URL,
    sleep: async () => {},
  });
}

describe("extractAndWait", () => {
  it("submits, polls, and returns the completed result", async () => {
    let polls = 0;
    server.use(
      http.post(url("/v1/extract"), () =>
        HttpResponse.json({ job_ids: ["job-9"], status: "pending" }, { status: 202 }),
      ),
      http.get(url("/v1/jobs/job-9"), () => {
        polls += 1;
        const status = polls < 2 ? "processing" : "completed";
        return HttpResponse.json(
          {
            id: "job-9",
            filename: "x.pdf",
            status,
            created_at: "2026-05-09T10:00:00Z",
            ...(status === "completed" ? { result: { content: "Hello world", mime_type: "text/plain" } } : {}),
          },
          { status: 200 },
        );
      }),
    );

    const client = makeClient();
    const result = await client.extractAndWait({
      file: new Blob(["data"]),
      pollIntervalMs: 1,
    });
    expect(result.status).toBe("completed");
    expect(result.result?.content).toBe("Hello world");
  });

  it("forwards extraction options through to the extract call", async () => {
    let optionsField: string | null = null;
    server.use(
      http.post(url("/v1/extract"), async ({ request }) => {
        const form = await request.formData();
        const value = form.get("options");
        optionsField = typeof value === "string" ? value : null;
        return HttpResponse.json({ job_ids: ["job-1"], status: "pending" }, { status: 202 });
      }),
      http.get(url("/v1/jobs/job-1"), () =>
        HttpResponse.json(
          {
            id: "job-1",
            filename: "x.pdf",
            status: "completed",
            created_at: "2026-05-09T10:00:00Z",
          },
          { status: 200 },
        ),
      ),
    );
    const client = makeClient();
    await client.extractAndWait({
      file: new Blob(["data"]),
      options: { extraction_config: { output_format: "markdown" } },
    });
    expect(optionsField).not.toBeNull();
    expect(JSON.parse(optionsField as unknown as string)).toEqual({
      extraction_config: { output_format: "markdown" },
    });
  });

  it("throws KreuzbergError when the polled job ends as failed", async () => {
    server.use(
      http.post(url("/v1/extract"), () =>
        HttpResponse.json({ job_ids: ["job-f"], status: "pending" }, { status: 202 }),
      ),
      http.get(url("/v1/jobs/job-f"), () =>
        HttpResponse.json(
          {
            id: "job-f",
            filename: "x.pdf",
            status: "failed",
            created_at: "2026-05-09T10:00:00Z",
          },
          { status: 200 },
        ),
      ),
    );
    const client = makeClient();
    await expect(client.extractAndWait({ file: new Blob(["data"]) })).rejects.toThrow(/failed/);
  });

  it("propagates TimeoutError when waitForJob deadline is exceeded", async () => {
    server.use(
      http.post(url("/v1/extract"), () =>
        HttpResponse.json({ job_ids: ["job-t"], status: "pending" }, { status: 202 }),
      ),
      http.get(url("/v1/jobs/job-t"), () =>
        HttpResponse.json(
          {
            id: "job-t",
            filename: "x.pdf",
            status: "processing",
            created_at: "2026-05-09T10:00:00Z",
          },
          { status: 200 },
        ),
      ),
    );
    const client = makeClient();
    await expect(
      client.extractAndWait({
        file: new Blob(["data"]),
        timeoutMs: 1,
        pollIntervalMs: 1,
      }),
    ).rejects.toBeInstanceOf(TimeoutError);
  });

  it("propagates AuthError surfaced from the extract submission", async () => {
    server.use(http.post(url("/v1/extract"), () => HttpResponse.json({ error: "no auth" }, { status: 401 })));
    const client = makeClient();
    await expect(client.extractAndWait({ file: new Blob(["data"]) })).rejects.toThrow(/no auth/);
  });
});
