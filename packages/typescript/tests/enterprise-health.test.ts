import { describe, expect, it } from "vitest";
import { XbergClient } from "../src/client.js";
import { ValidationError } from "../src/errors.js";

const BASE_URL = "https://data.example.test";
const BACKEND_URL = "https://backend.example.test";

function transport(body: unknown) {
  const requests: Array<{ url: string; authorization: string | null }> = [];
  const fetchImpl: typeof fetch = async (input, init) => {
    requests.push({
      url: String(input),
      authorization: new Headers(init?.headers).get("Authorization"),
    });
    return new Response(JSON.stringify(body), {
      status: 200,
      headers: { "content-type": "application/json" },
    });
  };
  return { fetchImpl, requests };
}

describe("typed Enterprise health", () => {
  it("should_decode_every_feature_on_the_data_origin", async () => {
    const wire = transport({
      status: "ok",
      tier: "enterprise",
      rag: { enabled: true },
      auto_tune: { enabled: true },
      data_rooms: { enabled: false },
      future_field: "retained",
    });
    const client = new XbergClient({
      baseUrl: BASE_URL,
      controlPlaneBaseUrl: BACKEND_URL,
      apiKey: "data-key",
      target: "enterprise",
      fetch: wire.fetchImpl,
    });
    expect(await client.enterpriseHealthz()).toEqual({
      status: "ok",
      tier: "enterprise",
      rag: { enabled: true },
      auto_tune: { enabled: true },
      data_rooms: { enabled: false },
      future_field: "retained",
    });
    expect(wire.requests).toEqual([{ url: `${BASE_URL}/healthz`, authorization: "Bearer data-key" }]);
  });

  it("should_read_missing_or_malformed_features_as_disabled", async () => {
    const wire = transport({
      status: "ok",
      tier: "enterprise",
      rag: { enabled: "yes" },
      auto_tune: null,
    });
    const client = new XbergClient({
      baseUrl: BASE_URL,
      target: "enterprise",
      fetch: wire.fetchImpl,
    });
    expect(await client.enterpriseHealthz()).toEqual({
      status: "ok",
      tier: "enterprise",
      rag: { enabled: false },
      auto_tune: { enabled: false },
      data_rooms: { enabled: false },
    });
  });

  it("should_reject_a_non_object_body", async () => {
    const wire = transport(["ok"]);
    const client = new XbergClient({
      baseUrl: BASE_URL,
      target: "enterprise",
      fetch: wire.fetchImpl,
    });
    await expect(client.enterpriseHealthz()).rejects.toBeInstanceOf(ValidationError);
  });

  it("should_reject_the_pro_tier_before_sending_a_request", async () => {
    const wire = transport({});
    const client = new XbergClient({ baseUrl: BASE_URL, target: "pro", fetch: wire.fetchImpl });
    await expect(client.enterpriseHealthz()).rejects.toThrow(/requires the 'enterprise' tier/);
    expect(wire.requests).toEqual([]);
  });
});
