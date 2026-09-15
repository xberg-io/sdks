import { HttpResponse, http } from "msw";
import { afterAll, afterEach, beforeAll, describe, expect, it } from "vitest";
import { XbergClient } from "../src/client.js";
import { XbergError } from "../src/errors.js";
import { TEST_BASE_URL, createTestServer, url } from "./_helpers.js";

const server = createTestServer();

beforeAll(() => server.listen({ onUnhandledRequest: "error" }));
afterEach(() => server.resetHandlers());
afterAll(() => server.close());

const PRO_URL = "https://pro.example.test";

function enterpriseClient(): XbergClient {
  return new XbergClient({ apiKey: "k", baseUrl: TEST_BASE_URL, target: "enterprise", sleep: async () => {} });
}

function proClient(): XbergClient {
  return new XbergClient({ apiKey: "k", baseUrl: PRO_URL, target: "pro", sleep: async () => {} });
}

interface Seen {
  method: string;
  path: string;
  search: string;
}

function seen(): Seen {
  return { method: "", path: "", search: "" };
}

function record(target: Seen, request: Request): void {
  const parsed = new URL(request.url);
  target.method = request.method;
  target.path = parsed.pathname;
  target.search = parsed.search;
}

describe("auto-tune surface", () => {
  it("listAutoTuneJobs issues GET /v1/auto-tune with pagination params", async () => {
    const got = seen();
    server.use(
      http.get(url("/v1/auto-tune"), ({ request }) => {
        record(got, request);
        return HttpResponse.json({ jobs: [], total: 0 }, { status: 200 });
      }),
    );
    const result = await enterpriseClient().listAutoTuneJobs({ limit: 20, offset: 40 });
    expect(result).toEqual({ jobs: [], total: 0 });
    expect(got.method).toBe("GET");
    expect(got.path).toBe("/v1/auto-tune");
    expect(got.search).toBe("?limit=20&offset=40");
  });

  it("listAutoTuneJobs is ungated and works against the pro target", async () => {
    server.use(http.get(`${PRO_URL}/v1/auto-tune`, () => HttpResponse.json({ jobs: [], total: 0 }, { status: 200 })));
    expect(await proClient().listAutoTuneJobs()).toEqual({ jobs: [], total: 0 });
  });

  it("submitAutoTune issues POST /v1/auto-tune as multipart with a request part and one file part each", async () => {
    const got = seen();
    let requestPart = "";
    let filenames: string[] = [];
    server.use(
      http.post(url("/v1/auto-tune"), async ({ request }) => {
        record(got, request);
        const form = await request.formData();
        requestPart = String(form.get("request"));
        filenames = form.getAll("file").map((part) => (part instanceof File ? part.name : "not-a-file"));
        return HttpResponse.json({ auto_tune_job_id: "at-1" }, { status: 201 });
      }),
    );
    const result = await enterpriseClient().submitAutoTune({
      request: { documents: [{ filename: "a.pdf", ground_truth: "A" }] },
      files: [
        { name: "a.pdf", data: new Uint8Array([1, 2, 3]) },
        { name: "b.pdf", data: new Uint8Array([4]) },
      ],
    });
    expect(result).toEqual({ auto_tune_job_id: "at-1" });
    expect(got.method).toBe("POST");
    expect(got.path).toBe("/v1/auto-tune");
    expect(JSON.parse(requestPart)).toEqual({ documents: [{ filename: "a.pdf", ground_truth: "A" }] });
    expect(filenames).toEqual(["a.pdf", "b.pdf"]);
  });

  it("submitAutoTune rejects an empty file list without issuing a request", async () => {
    const client = enterpriseClient();
    await expect(client.submitAutoTune({ request: { documents: [] }, files: [] })).rejects.toThrow(XbergError);
    await expect(client.submitAutoTune({ request: { documents: [] }, files: [] })).rejects.toThrow(/no files/);
  });

  it("getAutoTuneCapabilities issues GET /v1/auto-tune/capabilities", async () => {
    const got = seen();
    server.use(
      http.get(url("/v1/auto-tune/capabilities"), ({ request }) => {
        record(got, request);
        return HttpResponse.json({ ocr_backends: ["tesseract"] }, { status: 200 });
      }),
    );
    const result = await enterpriseClient().getAutoTuneCapabilities();
    expect(result).toEqual({ ocr_backends: ["tesseract"] });
    expect(got.method).toBe("GET");
    expect(got.path).toBe("/v1/auto-tune/capabilities");
  });

  it("getAutoTuneStatus issues GET /v1/auto-tune/{id}", async () => {
    const got = seen();
    server.use(
      http.get(url("/v1/auto-tune/:id"), ({ request }) => {
        record(got, request);
        return HttpResponse.json({ auto_tune_job_id: "at 1", status: "running" }, { status: 200 });
      }),
    );
    const result = await enterpriseClient().getAutoTuneStatus("at 1");
    expect(result).toEqual({ auto_tune_job_id: "at 1", status: "running" });
    expect(got.method).toBe("GET");
    expect(got.path).toBe("/v1/auto-tune/at%201");
  });

  it("deleteAutoTuneJob issues DELETE /v1/auto-tune/{id} and returns nothing on 204", async () => {
    const got = seen();
    server.use(
      http.delete(url("/v1/auto-tune/:id"), ({ request }) => {
        record(got, request);
        return new HttpResponse(null, { status: 204 });
      }),
    );
    const result = await enterpriseClient().deleteAutoTuneJob("at-1");
    expect(result).toBeUndefined();
    expect(got.method).toBe("DELETE");
    expect(got.path).toBe("/v1/auto-tune/at-1");
  });

  it("promoteAutoTuneProfile issues POST /v1/auto-tune/{id}/promote", async () => {
    const got = seen();
    let receivedBody: unknown;
    server.use(
      http.post(url("/v1/auto-tune/:id/promote"), async ({ request }) => {
        record(got, request);
        receivedBody = await request.json();
        return HttpResponse.json({ id: "tp-1", name: "Invoices" }, { status: 201 });
      }),
    );
    const result = await enterpriseClient().promoteAutoTuneProfile("at-1", { name: "Invoices" });
    expect(result).toEqual({ id: "tp-1", name: "Invoices" });
    expect(receivedBody).toEqual({ name: "Invoices" });
    expect(got.method).toBe("POST");
    expect(got.path).toBe("/v1/auto-tune/at-1/promote");
  });

  it("getAutoTuneResult issues GET /v1/auto-tune/{id}/result", async () => {
    const got = seen();
    server.use(
      http.get(url("/v1/auto-tune/:id/result"), ({ request }) => {
        record(got, request);
        return HttpResponse.json({ auto_tune_job_id: "at-1" }, { status: 200 });
      }),
    );
    const result = await enterpriseClient().getAutoTuneResult("at-1");
    expect(result).toEqual({ auto_tune_job_id: "at-1" });
    expect(got.method).toBe("GET");
    expect(got.path).toBe("/v1/auto-tune/at-1/result");
  });
});

describe("tuning-profile surface", () => {
  it("listTuningProfiles issues GET /v1/tuning-profiles with pagination params", async () => {
    const got = seen();
    server.use(
      http.get(url("/v1/tuning-profiles"), ({ request }) => {
        record(got, request);
        return HttpResponse.json({ profiles: [], total: 0 }, { status: 200 });
      }),
    );
    const result = await enterpriseClient().listTuningProfiles({ limit: 1, offset: 2 });
    expect(result).toEqual({ profiles: [], total: 0 });
    expect(got.method).toBe("GET");
    expect(got.path).toBe("/v1/tuning-profiles");
    expect(got.search).toBe("?limit=1&offset=2");
  });

  it("listTuningProfiles is ungated and works against the pro target", async () => {
    server.use(
      http.get(`${PRO_URL}/v1/tuning-profiles`, () => HttpResponse.json({ profiles: [], total: 0 }, { status: 200 })),
    );
    expect(await proClient().listTuningProfiles()).toEqual({ profiles: [], total: 0 });
  });

  it("getTuningProfile issues GET /v1/tuning-profiles/{id}", async () => {
    const got = seen();
    server.use(
      http.get(url("/v1/tuning-profiles/:id"), ({ request }) => {
        record(got, request);
        return HttpResponse.json({ id: "tp-1", name: "Invoices" }, { status: 200 });
      }),
    );
    const result = await enterpriseClient().getTuningProfile("tp-1");
    expect(result).toEqual({ id: "tp-1", name: "Invoices" });
    expect(got.method).toBe("GET");
    expect(got.path).toBe("/v1/tuning-profiles/tp-1");
  });

  it("deleteTuningProfile issues DELETE /v1/tuning-profiles/{id} and returns nothing on 204", async () => {
    const got = seen();
    server.use(
      http.delete(url("/v1/tuning-profiles/:id"), ({ request }) => {
        record(got, request);
        return new HttpResponse(null, { status: 204 });
      }),
    );
    const result = await enterpriseClient().deleteTuningProfile("tp-1");
    expect(result).toBeUndefined();
    expect(got.method).toBe("DELETE");
    expect(got.path).toBe("/v1/tuning-profiles/tp-1");
  });

  it("stopAutoTuneJob issues POST /v1/auto-tune/{id}/stop and returns nothing on 204", async () => {
    const got = seen();
    server.use(
      http.post(url("/v1/auto-tune/:id/stop"), ({ request }) => {
        record(got, request);
        return new HttpResponse(null, { status: 204 });
      }),
    );
    const result = await enterpriseClient().stopAutoTuneJob("at 1");
    expect(result).toBeUndefined();
    expect(got.method).toBe("POST");
    expect(got.path).toBe("/v1/auto-tune/at%201/stop");
  });

  it("stopAutoTuneJob is not tier-gated and reaches a pro instance", async () => {
    let receivedPath = "";
    server.use(
      http.post(`${PRO_URL}/v1/auto-tune/:id/stop`, ({ request }) => {
        receivedPath = new URL(request.url).pathname;
        return new HttpResponse(null, { status: 204 });
      }),
    );
    await expect(proClient().stopAutoTuneJob("at-1")).resolves.toBeUndefined();
    expect(receivedPath).toBe("/v1/auto-tune/at-1/stop");
  });
});
