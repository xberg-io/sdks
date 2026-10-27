/**
 * Verification of the `X-Webhook-Signature` header on webhook deliveries.
 *
 * The header is `t=<unix seconds>,v1=<hex HMAC-SHA256(secret, "<t>.<body>")>`.
 * Uses WebCrypto (`globalThis.crypto.subtle`) rather than `node:crypto`, so the
 * same code runs on Node, Deno, Bun, edge runtimes and browsers.
 */

/** The request header that carries the signature. */
export const WEBHOOK_SIGNATURE_HEADER = "X-Webhook-Signature";

/** Default replay window, in seconds, matching the server's. */
export const DEFAULT_WEBHOOK_TOLERANCE_SECONDS = 300;

export interface VerifyWebhookSignatureOptions {
  /** How far `t` may sit from `now` before the delivery is rejected. Default 300. */
  toleranceSeconds?: number;
  /** The receiver's clock in unix seconds. Defaults to the current time. */
  now?: number;
}

const encoder = new TextEncoder();

/**
 * Verify a webhook delivery's `X-Webhook-Signature` header against its raw body.
 *
 * Resolves `true` only when `t` is within `toleranceSeconds` of `now` and some
 * `v1` element is the HMAC-SHA256 of `"<t>.<body>"` under `secret`. Every `v1`
 * element is tried, so a sender signing with two secrets during a rotation
 * still verifies. The digest comparison is constant-time (`crypto.subtle.verify`).
 *
 * Pass the body exactly as received — re-serialising parsed JSON changes the
 * bytes and fails verification.
 */
export async function verifyWebhookSignature(
  secret: string,
  header: string,
  body: string | Uint8Array,
  options: VerifyWebhookSignatureOptions = {},
): Promise<boolean> {
  const tolerance = options.toleranceSeconds ?? DEFAULT_WEBHOOK_TOLERANCE_SECONDS;
  const now = options.now ?? Math.floor(Date.now() / 1000);

  let timestamp: number | undefined;
  const candidates: string[] = [];
  for (const element of header.split(",")) {
    const trimmed = element.trim();
    const eq = trimmed.indexOf("=");
    if (eq === -1) {
      continue;
    }
    const key = trimmed.slice(0, eq);
    const value = trimmed.slice(eq + 1);
    if (key === "t") {
      timestamp = /^[+-]?\d+$/.test(value) ? Number(value) : undefined;
    } else if (key === "v1") {
      candidates.push(value);
    }
  }

  if (timestamp === undefined || !Number.isSafeInteger(timestamp) || candidates.length === 0) {
    return false;
  }
  if (!(Math.abs(now - timestamp) <= tolerance)) {
    return false;
  }

  const key = await crypto.subtle.importKey("raw", encoder.encode(secret), { name: "HMAC", hash: "SHA-256" }, false, [
    "verify",
  ]);
  const prefix = encoder.encode(`${timestamp}.`);
  const bodyBytes = typeof body === "string" ? encoder.encode(body) : body;
  const signed = new Uint8Array(prefix.length + bodyBytes.length);
  signed.set(prefix, 0);
  signed.set(bodyBytes, prefix.length);

  for (const candidate of candidates) {
    const expected = decodeHex(candidate);
    if (expected !== undefined && (await crypto.subtle.verify("HMAC", key, expected, signed))) {
      return true;
    }
  }
  return false;
}

function decodeHex(value: string): Uint8Array<ArrayBuffer> | undefined {
  if (value.length === 0 || value.length % 2 !== 0 || !/^[0-9a-fA-F]+$/.test(value)) {
    return undefined;
  }
  const bytes = new Uint8Array(value.length / 2);
  for (let index = 0; index < bytes.length; index += 1) {
    bytes[index] = Number.parseInt(value.slice(index * 2, index * 2 + 2), 16);
  }
  return bytes;
}
