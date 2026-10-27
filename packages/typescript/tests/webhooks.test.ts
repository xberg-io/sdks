import { describe, expect, it } from "vitest";
import { DEFAULT_WEBHOOK_TOLERANCE_SECONDS, verifyWebhookSignature } from "../src/webhooks.js";

// Vectors for xberg-enterprise crates/webhook-delivery/src/signature.rs `sign(SECRET, 1_700_000_000, BODY)`,
// computed independently with `openssl dgst -sha256 -hmac`.
const SECRET = "whsec_test";
const BODY = '{"event":"job.completed","job_id":"j1"}';
const T = 1_700_000_000;
const V1 = "3a1304cbfa5270ffc0f8e72192b25d803293dc6312d34e40e8b9feea0b574c03";
const V1_RETIRED_SECRET = "1ff07f276e8942bbaf1bdf17141006bb2b808f242a067e19a973d17a34ca775f";
const HEADER = `t=${T},v1=${V1}`;

describe("verifyWebhookSignature", () => {
  it("should_accept_the_reference_vector_within_the_window", async () => {
    expect(await verifyWebhookSignature(SECRET, HEADER, BODY, { now: T + 100 })).toBe(true);
  });

  it("should_accept_the_body_as_bytes", async () => {
    expect(await verifyWebhookSignature(SECRET, HEADER, new TextEncoder().encode(BODY), { now: T })).toBe(true);
  });

  it("should_accept_exactly_at_the_tolerance_edge_and_reject_one_second_past_it", async () => {
    expect(DEFAULT_WEBHOOK_TOLERANCE_SECONDS).toBe(300);
    expect(await verifyWebhookSignature(SECRET, HEADER, BODY, { now: T + 300 })).toBe(true);
    expect(await verifyWebhookSignature(SECRET, HEADER, BODY, { now: T + 301 })).toBe(false);
    expect(await verifyWebhookSignature(SECRET, HEADER, BODY, { now: T - 301 })).toBe(false);
  });

  it("should_honour_a_custom_tolerance", async () => {
    expect(await verifyWebhookSignature(SECRET, HEADER, BODY, { now: T + 10, toleranceSeconds: 5 })).toBe(false);
    expect(await verifyWebhookSignature(SECRET, HEADER, BODY, { now: T + 5, toleranceSeconds: 5 })).toBe(true);
  });

  it("should_reject_a_stale_timestamp_by_the_wall_clock_when_now_is_omitted", async () => {
    expect(await verifyWebhookSignature(SECRET, HEADER, BODY)).toBe(false);
  });

  it("should_reject_a_tampered_body_a_wrong_secret_and_a_tampered_timestamp", async () => {
    expect(await verifyWebhookSignature(SECRET, HEADER, "{}", { now: T })).toBe(false);
    expect(await verifyWebhookSignature("other", HEADER, BODY, { now: T })).toBe(false);
    expect(await verifyWebhookSignature(SECRET, `t=${T + 1},v1=${V1}`, BODY, { now: T })).toBe(false);
  });

  it("should_accept_any_matching_v1_during_a_secret_rotation", async () => {
    const header = `t=${T},v1=${V1_RETIRED_SECRET},v1=${V1}`;
    expect(await verifyWebhookSignature(SECRET, header, BODY, { now: T })).toBe(true);
    expect(await verifyWebhookSignature("retired", header, BODY, { now: T })).toBe(true);
  });

  it.each([
    ["legacy sha256= format", "sha256=abcd"],
    ["missing v1", `t=${T}`],
    ["missing t", `v1=${V1}`],
    ["non-numeric t", `t=abc,v1=${V1}`],
    ["non-hex v1", `t=${T},v1=zz${V1.slice(2)}`],
    ["odd-length v1", `t=${T},v1=${V1.slice(1)}`],
    ["out-of-range t", `t=-9223372036854775808,v1=${V1}`],
  ])("should_reject_a_malformed_header_%s", async (_label, header) => {
    expect(await verifyWebhookSignature(SECRET, header, BODY, { now: T })).toBe(false);
  });
});
