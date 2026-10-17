import { describe, expect, it } from "vitest";
import { XbergClient } from "../src/client.js";
import { AuthError, NotFoundError, ServerError, XbergError } from "../src/errors.js";

const BASE_URL = "https://data.example.test";
const BACKEND_URL = "https://backend.example.test";
const HEALTH = {
  status: "ok",
  tier: "pro",
  license: { state: "grace" },
  rag: { enabled: false },
  auto_tune: { enabled: true },
  future_field: "retained",
};

function transport(statuses: number[] = [200], body: unknown = HEALTH) {
  const requests: Array<{ url: string; authorization: string | null }> = [];
  const fetchImpl: typeof fetch = async (input, init) => {
    requests.push({ url: String(input), authorization: new Headers(init?.headers).get("Authorization") });
    const status = statuses[Math.min(requests.length - 1, statuses.length - 1)];
    return new Response(JSON.stringify(status === 200 ? body : { message: "health unavailable" }), { status });
  };
  return { fetchImpl, requests };
}

describe("typed Pro health", () => {
  it("decodes all five fields on the data origin with its credential", async () => {
    const wire = transport();
    const client = new XbergClient({
      baseUrl: BASE_URL,
      controlPlaneBaseUrl: BACKEND_URL,
      apiKey: "data-key",
      controlPlaneToken: "backend-key",
      target: "pro",
      retries: 0,
      fetch: wire.fetchImpl,
    });
    const result = await client.proHealthz();
    expect(result.status).toBe("ok");
    expect(result.tier).toBe("pro");
    expect(result.license.state).toBe("grace");
    expect(result.rag.enabled).toBe(false);
    expect(result.auto_tune.enabled).toBe(true);
    expect(result).toEqual(HEALTH);
    expect(wire.requests).toEqual([{ url: `${BASE_URL}/healthz`, authorization: "Bearer data-key" }]);
  });

  it("permits an unauthenticated probe without selecting backend credentials", async () => {
    const wire = transport();
    const client = new XbergClient({
      baseUrl: BASE_URL,
      target: "pro",
      controlPlaneToken: "backend-key",
      fetch: wire.fetchImpl,
      retries: 0,
    });
    expect((await client.proHealthz()).license.state).toBe("grace");
    expect(wire.requests).toEqual([{ url: `${BASE_URL}/healthz`, authorization: null }]);
  });

  it("rejects an explicit Enterprise target before sending a request", async () => {
    const wire = transport();
    const client = new XbergClient({ baseUrl: BASE_URL, target: "enterprise", fetch: wire.fetchImpl });
    await expect(client.proHealthz()).rejects.toThrow(/requires the 'pro' tier/);
    expect(wire.requests).toEqual([]);
  });

  it("probes an automatic target once and fetches fresh health on each call", async () => {
    const wire = transport();
    const client = new XbergClient({ baseUrl: BASE_URL, fetch: wire.fetchImpl });
    expect((await client.proHealthz()).tier).toBe("pro");
    expect(wire.requests).toHaveLength(2);
    expect((await client.proHealthz()).license.state).toBe("grace");
    expect(wire.requests.map((request) => request.url)).toEqual(Array(3).fill(`${BASE_URL}/healthz`));
  });

  it("rejects an automatically discovered Enterprise target after only its probe", async () => {
    const wire = transport([200], { status: "ok", tier: "enterprise" });
    const client = new XbergClient({ baseUrl: BASE_URL, fetch: wire.fetchImpl });
    await expect(client.proHealthz()).rejects.toThrow(/requires the 'pro' tier/);
    expect(wire.requests).toHaveLength(1);
  });

  it.each([
    [401, AuthError],
    [404, NotFoundError],
    [503, ServerError],
  ] as const)("maps HTTP %i without retrying when retries are disabled", async (status, errorType) => {
    const wire = transport([status]);
    const client = new XbergClient({ baseUrl: BASE_URL, target: "pro", retries: 0, fetch: wire.fetchImpl });
    await expect(client.proHealthz()).rejects.toMatchObject({ status });
    expect(wire.requests).toHaveLength(1);
    await expect(client.proHealthz()).rejects.toBeInstanceOf(errorType);
    expect(wire.requests).toHaveLength(2);
  });

  it("uses the existing retry engine for a transient server failure", async () => {
    const wire = transport([503, 200]);
    const client = new XbergClient({
      baseUrl: BASE_URL,
      target: "pro",
      retries: 1,
      fetch: wire.fetchImpl,
      sleep: async () => {},
    });
    expect((await client.proHealthz()).license.state).toBe("grace");
    expect(wire.requests).toHaveLength(2);
  });

  it("preserves existing Enterprise health origin, public auth and Pro rejection", async () => {
    const wire = transport([200], { status: "ok", tier: "enterprise" });
    const client = new XbergClient({
      baseUrl: BASE_URL,
      controlPlaneBaseUrl: BACKEND_URL,
      apiKey: "data-key",
      controlPlaneToken: "backend-key",
      target: "enterprise",
      fetch: wire.fetchImpl,
    });
    expect(await client.healthz()).toEqual({ status: "ok", tier: "enterprise" });
    expect(wire.requests).toEqual([{ url: `${BACKEND_URL}/healthz`, authorization: null }]);
    const pro = new XbergClient({ baseUrl: BASE_URL, target: "pro", fetch: wire.fetchImpl });
    await expect(pro.healthz()).rejects.toBeInstanceOf(XbergError);
    expect(wire.requests).toHaveLength(1);
  });
});
