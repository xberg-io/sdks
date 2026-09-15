import { HttpResponse, http } from "msw";
import { afterAll, afterEach, beforeAll, describe, expect, it } from "vitest";
import { XbergClient } from "../src/client.js";
import { TEST_BASE_URL, createTestServer } from "./_helpers.js";

const server = createTestServer();

beforeAll(() => server.listen({ onUnhandledRequest: "error" }));
afterEach(() => server.resetHandlers());
afterAll(() => server.close());

const PRO_URL = "https://pro.example.test";
/** ~keep Both specs serve this one spelling; `saved-presets` is a tag name, not a route. */
const COLLECTION = "/v1/saved_presets";

interface TierCase {
  /** Human-readable tier label used in the test title. */
  readonly label: "enterprise" | "pro";
  readonly baseUrl: string;
  /** The collection path this tier is expected to be called on. */
  readonly collection: string;
}

const TIERS: readonly TierCase[] = [
  { label: "enterprise", baseUrl: TEST_BASE_URL, collection: COLLECTION },
  { label: "pro", baseUrl: PRO_URL, collection: COLLECTION },
];

function makeClient(tier: TierCase): XbergClient {
  return new XbergClient({ apiKey: "k", baseUrl: tier.baseUrl, target: tier.label, sleep: async () => {} });
}

/** Records the method and pathname of the single request the handler sees. */
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

describe.each(TIERS)("saved presets on the $label tier", (tier) => {
  it(`listSavedPresets issues GET ${tier.collection}`, async () => {
    const got = seen();
    server.use(
      http.get(`${tier.baseUrl}${tier.collection}`, ({ request }) => {
        record(got, request);
        return HttpResponse.json({ presets: [], total: 0, page: 0, limit: 50 }, { status: 200 });
      }),
    );
    const result = await makeClient(tier).listSavedPresets({ limit: 5, offset: 10 });
    expect(result).toEqual({ presets: [], total: 0, page: 0, limit: 50 });
    expect(got.method).toBe("GET");
    expect(got.path).toBe(tier.collection);
    expect(got.search).toBe("?limit=5&offset=10");
  });

  it(`listSavedPresets omits pagination params when none are given on ${tier.label}`, async () => {
    const got = seen();
    server.use(
      http.get(`${tier.baseUrl}${tier.collection}`, ({ request }) => {
        record(got, request);
        return HttpResponse.json({ presets: [], total: 0, page: 0, limit: 50 }, { status: 200 });
      }),
    );
    await makeClient(tier).listSavedPresets();
    expect(got.search).toBe("");
  });

  it(`createSavedPreset issues POST ${tier.collection}`, async () => {
    const got = seen();
    let receivedBody: unknown;
    server.use(
      http.post(`${tier.baseUrl}${tier.collection}`, async ({ request }) => {
        record(got, request);
        receivedBody = await request.json();
        return HttpResponse.json({ id: "preset-1" }, { status: 201 });
      }),
    );
    const result = await makeClient(tier).createSavedPreset({ name: "My Preset" });
    expect(result).toEqual({ id: "preset-1" });
    expect(receivedBody).toEqual({ name: "My Preset" });
    expect(got.method).toBe("POST");
    expect(got.path).toBe(tier.collection);
  });

  it(`getSavedPreset issues GET ${tier.collection}/{id}`, async () => {
    const got = seen();
    server.use(
      http.get(`${tier.baseUrl}${tier.collection}/:id`, ({ request }) => {
        record(got, request);
        return HttpResponse.json({ id: "preset 1", name: "My Preset" }, { status: 200 });
      }),
    );
    const result = await makeClient(tier).getSavedPreset("preset 1");
    expect(result).toEqual({ id: "preset 1", name: "My Preset" });
    expect(got.method).toBe("GET");
    expect(got.path).toBe(`${tier.collection}/preset%201`);
  });

  it(`updateSavedPreset issues PATCH ${tier.collection}/{id}`, async () => {
    const got = seen();
    let receivedBody: unknown;
    server.use(
      http.patch(`${tier.baseUrl}${tier.collection}/:id`, async ({ request }) => {
        record(got, request);
        receivedBody = await request.json();
        return HttpResponse.json({ id: "preset-1", name: "Renamed" }, { status: 200 });
      }),
    );
    const result = await makeClient(tier).updateSavedPreset("preset-1", { name: "Renamed" });
    expect(result).toEqual({ id: "preset-1", name: "Renamed" });
    expect(receivedBody).toEqual({ name: "Renamed" });
    expect(got.method).toBe("PATCH");
    expect(got.path).toBe(`${tier.collection}/preset-1`);
  });

  it(`deleteSavedPreset issues DELETE ${tier.collection}/{id}`, async () => {
    const got = seen();
    server.use(
      http.delete(`${tier.baseUrl}${tier.collection}/:id`, ({ request }) => {
        record(got, request);
        return new HttpResponse(null, { status: 204 });
      }),
    );
    const result = await makeClient(tier).deleteSavedPreset("preset-1");
    expect(result).toBeUndefined();
    expect(got.method).toBe("DELETE");
    expect(got.path).toBe(`${tier.collection}/preset-1`);
  });
});

describe("saved-preset routing", () => {
  it("uses the underscore spelling on pro without probing the tier at all", async () => {
    const got = seen();
    let healthzCalls = 0;
    server.use(
      http.get(`${PRO_URL}/healthz`, () => {
        healthzCalls += 1;
        return HttpResponse.json({ status: "ok", tier: "pro" });
      }),
      http.get(`${PRO_URL}${COLLECTION}`, ({ request }) => {
        record(got, request);
        return HttpResponse.json({ presets: [], total: 0, page: 0, limit: 50 }, { status: 200 });
      }),
    );
    // target omitted: the path is fixed, so no /healthz round trip is needed to pick it.
    const client = new XbergClient({ apiKey: "k", baseUrl: PRO_URL, sleep: async () => {} });
    await client.listSavedPresets();
    expect(got.path).toBe(COLLECTION);
    expect(healthzCalls).toBe(0);
  });

  it("never calls the hyphenated path, which neither spec serves", async () => {
    const paths: string[] = [];
    const client = new XbergClient({
      apiKey: "k",
      baseUrl: PRO_URL,
      target: "pro",
      fetch: async (input) => {
        paths.push(new URL(String(input)).pathname);
        return Response.json({ presets: [] });
      },
    });
    await client.listSavedPresets();
    await client.getSavedPreset("p1");
    await client.createSavedPreset({ name: "n" });
    await client.updateSavedPreset("p1", { name: "n" });
    await client.deleteSavedPreset("p1");
    expect(paths).toEqual([COLLECTION, `${COLLECTION}/p1`, COLLECTION, `${COLLECTION}/p1`, `${COLLECTION}/p1`]);
  });

  it("is not tier-gated — the enterprise tier reaches the endpoint instead of throwing", async () => {
    server.use(
      http.get(`${TEST_BASE_URL}${COLLECTION}/p1`, () =>
        HttpResponse.json({ id: "p1", name: "Shared" }, { status: 200 }),
      ),
    );
    const client = new XbergClient({ apiKey: "k", baseUrl: TEST_BASE_URL, target: "enterprise" });
    await expect(client.getSavedPreset("p1")).resolves.toEqual({ id: "p1", name: "Shared" });
  });
});
