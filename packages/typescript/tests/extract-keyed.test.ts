import { HttpResponse, http } from "msw";
import { afterAll, afterEach, beforeAll, describe, expect, it } from "vitest";
import { XbergClient } from "../src/client.js";
import { ValidationError, XbergError } from "../src/errors.js";
import { TEST_BASE_URL, createTestServer, url } from "./_helpers.js";

const server = createTestServer();
const PROJECT = "11111111-1111-4111-8111-111111111111";
const KEY = "retry-key-0001";

beforeAll(() => server.listen({ onUnhandledRequest: "error" }));
afterEach(() => server.resetHandlers());
afterAll(() => server.close());

function makeClient(target: "pro" | "enterprise" = "pro"): XbergClient {
  return new XbergClient({ apiKey: "test-key", baseUrl: TEST_BASE_URL, target, sleep: async () => {} });
}

function captureKeyed(): { requests: Request[]; forms: FormData[] } {
  const captured = { requests: [] as Request[], forms: [] as FormData[] };
  server.use(
    http.post(url("/v1/extract/keyed"), async ({ request }) => {
      captured.requests.push(request.clone());
      captured.forms.push(await request.formData());
      return HttpResponse.json({ job_ids: ["job-keyed"], status: "pending" }, { status: 202 });
    }),
  );
  return captured;
}

describe("extractKeyed", () => {
  it("sends the Idempotency-Key header with a multipart file body", async () => {
    const captured = captureKeyed();
    const file = new File([new Uint8Array([1, 2, 3])], "invoice.pdf", { type: "application/pdf" });

    const jobs = await makeClient().extractKeyed({
      files: [file],
      idempotencyKey: KEY,
      options: { output_format: "markdown" },
      configs: [{ force_ocr: true }],
    });

    expect(jobs.map((job) => [job.id, job.filename, job.mime_type, job.status])).toEqual([
      ["job-keyed", "invoice.pdf", "application/pdf", "pending"],
    ]);
    expect(captured.requests).toHaveLength(1);
    const [request] = captured.requests;
    expect(request?.headers.get("idempotency-key")).toBe(KEY);
    expect(request?.headers.get("content-type")).toMatch(/^multipart\/form-data/);
    expect(request?.headers.get("x-project-id")).toBeNull();
    const form = captured.forms[0];
    expect(
      form
        ?.getAll("file")
        .filter((v): v is File => v instanceof File)
        .map((f) => f.name),
    ).toEqual(["invoice.pdf"]);
    expect(form?.get("options")).toBe(JSON.stringify({ output_format: "markdown" }));
    expect(form?.get("config-invoice.pdf")).toBe(JSON.stringify({ force_ocr: true }));
    expect(form?.has("webhook")).toBe(false);
  });

  it("selects the Pro project with the X-Project-ID header", async () => {
    const captured = captureKeyed();

    await makeClient().extractKeyed({ files: [new Uint8Array([1])], idempotencyKey: KEY, projectId: PROJECT });

    const [request] = captured.requests;
    expect(request?.headers.get("x-project-id")).toBe(PROJECT);
    expect(request?.headers.get("idempotency-key")).toBe(KEY);
    expect(new URL(request?.url ?? "").search).toBe("");
  });

  it("rejects a blank key or an empty batch before any request", async () => {
    const captured = captureKeyed();
    const client = makeClient();

    await expect(client.extractKeyed({ files: [new Uint8Array([1])], idempotencyKey: " " })).rejects.toBeInstanceOf(
      ValidationError,
    );
    await expect(client.extractKeyed({ files: [], idempotencyKey: KEY })).rejects.toBeInstanceOf(XbergError);
    expect(captured.requests).toHaveLength(0);
  });

  it("is refused on Enterprise before any request", async () => {
    const captured = captureKeyed();

    await expect(
      makeClient("enterprise").extractKeyed({ files: [new Uint8Array([1])], idempotencyKey: KEY }),
    ).rejects.toThrow(/extractKeyed/);
    expect(captured.requests).toHaveLength(0);
  });
});
