import { HttpResponse, http } from "msw";
import { afterAll, afterEach, beforeAll, describe, expect, it } from "vitest";
import { XbergClient } from "../src/client.js";
import { XbergError } from "../src/errors.js";
import { createTestServer } from "./_helpers.js";

const server = createTestServer();

beforeAll(() => server.listen({ onUnhandledRequest: "error" }));
afterEach(() => server.resetHandlers());
afterAll(() => server.close());

const PRO_URL = "https://pro.example.test";
const ENTERPRISE_URL = "https://api.test.enterprise.xberg.io";

/** A fetch stub that records request URLs and returns a canned JSON body. */
function recordingFetch(): { fetchImpl: typeof fetch; urls: string[] } {
  const urls: string[] = [];
  const fetchImpl = (async (input: RequestInfo | URL): Promise<Response> => {
    urls.push(typeof input === "string" ? input : input.toString());
    return new Response(JSON.stringify({ collections: [] }), {
      status: 200,
      headers: { "content-type": "application/json" },
    });
  }) as typeof fetch;
  return { fetchImpl, urls };
}

// -- base-url policy ----------------------------------------------------------

describe("base-url policy", () => {
  it("defaults the base URL to https://api.xberg.io for the enterprise target", async () => {
    const { fetchImpl, urls } = recordingFetch();
    const client = new XbergClient({ apiKey: "k", target: "enterprise", fetch: fetchImpl });
    await client.listRagCollections();
    expect(urls[0]).toBe("https://api.xberg.io/v1/rag/collections");
  });

  it("defaults to the enterprise base URL when no target is given", async () => {
    const { fetchImpl, urls } = recordingFetch();
    const client = new XbergClient({ apiKey: "k", fetch: fetchImpl });
    await client.listRagCollections();
    expect(urls[0]).toBe("https://api.xberg.io/v1/rag/collections");
  });

  it("throws a clear error when target is pro and no base URL is provided", () => {
    expect(() => new XbergClient({ target: "pro" })).toThrow(XbergError);
    expect(() => new XbergClient({ target: "pro" })).toThrow(/no default base URL/);
  });

  it("accepts an explicit pro base URL and strips a trailing slash", async () => {
    const { fetchImpl, urls } = recordingFetch();
    const client = new XbergClient({ apiKey: "k", target: "pro", baseUrl: `${PRO_URL}/`, fetch: fetchImpl });
    await client.listRagCollections();
    expect(urls[0]).toBe(`${PRO_URL}/v1/rag/collections`);
  });

  it("defaults the control-plane base URL to the data-plane one", () => {
    // Pro serves both planes from one binary, so a Pro client that never heard
    // of this option must keep addressing the control plane at its base URL.
    const client = new XbergClient({ apiKey: "k", target: "pro", baseUrl: PRO_URL });
    expect(client.controlPlaneBaseUrl).toBe(PRO_URL);
  });

  it("moves only the control plane when a control-plane base URL is given", async () => {
    // Enterprise splits the planes across two binaries.
    const { fetchImpl, urls } = recordingFetch();
    const client = new XbergClient({
      apiKey: "k",
      target: "enterprise",
      baseUrl: "https://data.example.test:8080",
      controlPlaneBaseUrl: "https://control.example.test:8081/",
      fetch: fetchImpl,
    });
    expect(client.controlPlaneBaseUrl).toBe("https://control.example.test:8081");
    await client.listRagCollections();
    expect(urls[0]).toBe("https://data.example.test:8080/v1/rag/collections");
  });
});

// -- tier gating (explicit target) --------------------------------------------

describe("tier gating with an explicit target", () => {
  it("rejects a pro-only method on the enterprise tier without an HTTP call", async () => {
    const client = new XbergClient({ apiKey: "k", baseUrl: ENTERPRISE_URL, target: "enterprise" });
    await expect(client.login({ id_token: "x" })).rejects.toThrow(/not available on the 'enterprise' tier/);
  });

  it("rejects an enterprise-only method on the pro tier without an HTTP call", async () => {
    const client = new XbergClient({ apiKey: "k", baseUrl: PRO_URL, target: "pro" });
    await expect(client.listExtractionEvents()).rejects.toThrow(/not available on the 'pro' tier/);
  });

  it("reaches the login endpoint on the pro tier", async () => {
    let called = false;
    server.use(
      http.post(`${PRO_URL}/auth/login`, () => {
        called = true;
        return HttpResponse.json({ token: "session-jwt" }, { status: 200 });
      }),
    );
    const client = new XbergClient({ apiKey: "k", baseUrl: PRO_URL, target: "pro" });
    const result = await client.login({ id_token: "verified" });
    expect(called).toBe(true);
    expect(result).toEqual({ token: "session-jwt" });
  });

  it("lists saved presets on the pro tier", async () => {
    server.use(
      http.get(`${PRO_URL}/v1/saved_presets`, () =>
        HttpResponse.json({ presets: [], total: 0, page: 0, limit: 0 }, { status: 200 }),
      ),
    );
    const client = new XbergClient({ apiKey: "k", baseUrl: PRO_URL, target: "pro" });
    expect(await client.listSavedPresets()).toEqual({ presets: [], total: 0, page: 0, limit: 0 });
  });

  it("fetches usage on the enterprise tier", async () => {
    server.use(http.get(`${ENTERPRISE_URL}/v1/usage`, () => HttpResponse.json({ pages: 42 }, { status: 200 })));
    const client = new XbergClient({ apiKey: "k", baseUrl: ENTERPRISE_URL, target: "enterprise" });
    expect(await client.usage()).toEqual({ pages: 42 });
  });
});

// -- tier gating (capability probe) -------------------------------------------

describe("tier gating via the /healthz capability probe", () => {
  it("discovers the tier from /healthz and caches it across calls", async () => {
    let healthzCalls = 0;
    server.use(
      http.get(`${ENTERPRISE_URL}/healthz`, () => {
        healthzCalls += 1;
        return HttpResponse.json({ status: "ok", tier: "enterprise" }, { status: 200 });
      }),
      http.get(`${ENTERPRISE_URL}/v1/extractions`, () => HttpResponse.json({ events: [] }, { status: 200 })),
    );
    // target omitted -> tier is discovered from /healthz, then cached.
    const client = new XbergClient({ apiKey: "k", baseUrl: ENTERPRISE_URL });
    expect(await client.listExtractionEvents()).toEqual({ events: [] });
    expect(await client.listExtractionEvents()).toEqual({ events: [] });
    expect(healthzCalls).toBe(1);
  });

  it("gates a method when the probed tier does not match", async () => {
    server.use(
      http.get(`${ENTERPRISE_URL}/healthz`, () => HttpResponse.json({ status: "ok", tier: "pro" }, { status: 200 })),
    );
    const client = new XbergClient({ apiKey: "k", baseUrl: ENTERPRISE_URL });
    await expect(client.listExtractionEvents()).rejects.toThrow(/not available on the 'pro' tier/);
  });
});

// -- tier probe hardening (missing/unrecognised tier, single-flight) ---------

describe("tier probe hardening", () => {
  it("throws instead of caching a permanent '' when /healthz omits tier, and a later call retries", async () => {
    let healthzCalls = 0;
    server.use(
      http.get(`${ENTERPRISE_URL}/healthz`, () => {
        healthzCalls += 1;
        const body = healthzCalls === 1 ? { status: "ok" } : { status: "ok", tier: "enterprise" };
        return HttpResponse.json(body, { status: 200 });
      }),
      http.get(`${ENTERPRISE_URL}/v1/extractions`, () => HttpResponse.json({ events: [1] }, { status: 200 })),
    );
    const client = new XbergClient({ apiKey: "k", baseUrl: ENTERPRISE_URL });
    await expect(client.listExtractionEvents()).rejects.toThrow(XbergError);
    expect(await client.listExtractionEvents()).toEqual({ events: [1] });
    expect(healthzCalls).toBe(2);
  });

  it("throws when /healthz returns tier: null, and a later call retries", async () => {
    let healthzCalls = 0;
    server.use(
      http.get(`${ENTERPRISE_URL}/healthz`, () => {
        healthzCalls += 1;
        const body = healthzCalls === 1 ? { status: "ok", tier: null } : { status: "ok", tier: "enterprise" };
        return HttpResponse.json(body, { status: 200 });
      }),
      http.get(`${ENTERPRISE_URL}/v1/extractions`, () => HttpResponse.json({ events: [2] }, { status: 200 })),
    );
    const client = new XbergClient({ apiKey: "k", baseUrl: ENTERPRISE_URL });
    await expect(client.listExtractionEvents()).rejects.toThrow(XbergError);
    expect(await client.listExtractionEvents()).toEqual({ events: [2] });
    expect(healthzCalls).toBe(2);
  });

  it("throws when /healthz returns an unrecognised tier value, and a later call retries", async () => {
    let healthzCalls = 0;
    server.use(
      http.get(`${ENTERPRISE_URL}/healthz`, () => {
        healthzCalls += 1;
        const body = healthzCalls === 1 ? { status: "ok", tier: "trial" } : { status: "ok", tier: "enterprise" };
        return HttpResponse.json(body, { status: 200 });
      }),
      http.get(`${ENTERPRISE_URL}/v1/extractions`, () => HttpResponse.json({ events: [3] }, { status: 200 })),
    );
    const client = new XbergClient({ apiKey: "k", baseUrl: ENTERPRISE_URL });
    await expect(client.listExtractionEvents()).rejects.toThrow(XbergError);
    expect(await client.listExtractionEvents()).toEqual({ events: [3] });
    expect(healthzCalls).toBe(2);
  });

  it("single-flights concurrent probes into exactly one /healthz request", async () => {
    let healthzCalls = 0;
    server.use(
      http.get(`${ENTERPRISE_URL}/healthz`, () => {
        healthzCalls += 1;
        return HttpResponse.json({ status: "ok", tier: "enterprise" }, { status: 200 });
      }),
      http.get(`${ENTERPRISE_URL}/v1/extractions`, () => HttpResponse.json({ events: [4] }, { status: 200 })),
    );
    const client = new XbergClient({ apiKey: "k", baseUrl: ENTERPRISE_URL });
    const results = await Promise.all([
      client.listExtractionEvents(),
      client.listExtractionEvents(),
      client.listExtractionEvents(),
    ]);
    expect(results).toEqual([{ events: [4] }, { events: [4] }, { events: [4] }]);
    expect(healthzCalls).toBe(1);
  });
});
