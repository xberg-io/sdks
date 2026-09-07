import { HttpResponse, http } from "msw";
import { afterAll, afterEach, beforeAll, describe, expect, it } from "vitest";
import { XbergClient } from "../src/client.js";
import { TEST_BASE_URL, createTestServer, url } from "./_helpers.js";

const server = createTestServer();
beforeAll(() => server.listen({ onUnhandledRequest: "error" }));
afterEach(() => server.resetHandlers());
afterAll(() => server.close());
const documentId = "abcdefab-1234-5678-9012-abcdefabcdef";
const file = { name: "a.txt", data: new Uint8Array([1, 2]) };

describe("extraction document lineage", () => {
  it("emits one canonical ID per filename before the file parts", async () => {
    let parts: [string, FormDataEntryValue][] = [];
    server.use(
      http.post(url("/v1/extract"), async ({ request }) => {
        parts = [...(await request.formData()).entries()];
        return HttpResponse.json({ job_ids: ["a", "b", "c"] });
      }),
    );
    const client = new XbergClient({ baseUrl: TEST_BASE_URL, target: "enterprise" });
    await client.extractBatch({
      files: [file, file, { ...file, name: "c.txt" }],
      documentIds: [documentId.toUpperCase(), documentId, null],
    });
    expect(parts.map(([name]) => name)).toEqual(["document_id-a.txt", "file", "file", "file"]);
    expect(parts[0]?.[1]).toBe(documentId);
  });

  it.each([
    { name: "empty", ids: [] },
    { name: "short", ids: [documentId] },
    { name: "malformed", ids: ["invalid", null] },
    { name: "trailing newline", ids: [documentId + "\n", null] },
    { name: "conflicting", ids: [documentId, null] },
  ])("rejects $name IDs before reading file data or requesting", async ({ ids, name }) => {
    let reads = 0;
    const source = {
      name: "a.txt",
      get data() {
        reads++;
        return new Uint8Array([1]);
      },
    };
    const client = new XbergClient({ baseUrl: TEST_BASE_URL, target: "enterprise" });
    const second =
      name === "conflicting"
        ? source
        : {
            name: "b.txt",
            get data() {
              reads++;
              return new Uint8Array([1]);
            },
          };
    await expect(client.extractBatch({ files: [source, second], documentIds: ids })).rejects.toThrow();
    expect(reads).toBe(0);
  });

  it.each([true, false])("rejects Pro before reading data (explicit=%s)", async (explicit) => {
    let reads = 0;
    let probes = 0;
    const source = {
      name: "a.txt",
      get data() {
        reads++;
        return new Uint8Array([1]);
      },
    };
    server.use(
      http.get(url("/healthz"), () => {
        probes++;
        return HttpResponse.json({ tier: "pro" });
      }),
    );
    const client = new XbergClient({ baseUrl: TEST_BASE_URL, ...(explicit ? { target: "pro" } : {}) });
    await expect(client.extract({ file: source, documentId })).rejects.toThrow();
    expect(reads).toBe(0);
    expect(probes).toBe(explicit ? 0 : 1);
  });

  it("does not probe or send fields for all-null IDs", async () => {
    let keys: string[] = [];
    server.use(
      http.post(url("/v1/extract"), async ({ request }) => {
        keys = [...(await request.formData()).keys()];
        return HttpResponse.json({ job_ids: ["a"] });
      }),
    );
    await new XbergClient({ baseUrl: TEST_BASE_URL }).extractBatch({ files: [file], documentIds: [null] });
    expect(keys).toEqual(["file"]);
  });

  it("forwards documentId through extractAndWait", async () => {
    let value: FormDataEntryValue | null = null;
    server.use(
      http.post(url("/v1/extract"), async ({ request }) => {
        value = (await request.formData()).get("document_id-a.txt");
        return HttpResponse.json({ job_ids: ["a"] });
      }),
      http.get(url("/v1/jobs/a"), () => HttpResponse.json({ id: "a", status: "completed" })),
    );
    const result = await new XbergClient({ baseUrl: TEST_BASE_URL, target: "enterprise" }).extractAndWait({
      file,
      documentId,
    });
    expect(result.status).toBe("completed");
    expect(value).toBe(documentId);
  });
});
