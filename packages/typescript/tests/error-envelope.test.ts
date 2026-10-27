import { describe, expect, it } from "vitest";
import type { components } from "../src/_generated/api.js";
import { XbergClient } from "../src/client.js";
import {
  GatewayTimeoutError,
  PreconditionFailedError,
  PreconditionRequiredError,
  RequestTimeoutError,
  ResultExpiredError,
  ServerError,
  ValidationError,
  XbergError,
} from "../src/errors.js";

const BASE_URL = "https://data.example.test";

// Byte-for-byte what xberg-enterprise crates/observability/src/request_timeout.rs
// `timeout_response` serialises (serde_json with preserve_order) for limits 30/60.
const GATEWAY_TIMEOUT_BODY =
  '{"error":{"code":"gateway_timeout","message":"The server did not produce a response in time",' +
  '"details":{"limit":"handler","timeout_seconds":30}}}';
const REQUEST_TIMEOUT_BODY =
  '{"error":{"code":"request_timeout","message":"The request body stopped arriving before the upload completed",' +
  '"details":{"limit":"body_idle","timeout_seconds":60}}}';

function respondingWith(status: number, body: string, contentType = "application/json"): XbergClient {
  const fetchImpl: typeof fetch = async () => new Response(body, { status, headers: { "content-type": contentType } });
  return new XbergClient({ baseUrl: BASE_URL, apiKey: "k", fetch: fetchImpl, retries: 0 });
}

async function caught(client: XbergClient): Promise<XbergError> {
  try {
    await client.getJob("x");
  } catch (error) {
    if (error instanceof XbergError) {
      return error;
    }
    throw error;
  }
  throw new Error("expected getJob to throw");
}

describe("generated TimeoutErrorResponse", () => {
  const bodyFor = (
    code: components["schemas"]["TimeoutErrorCode"],
    limit: components["schemas"]["TimeoutLimit"],
    seconds: number,
  ): string => {
    const body: components["schemas"]["TimeoutErrorResponse"] = {
      error: { code, message: "timed out", details: { limit, timeout_seconds: seconds } },
    };
    return JSON.stringify(body);
  };

  it("should_decode_a_504_built_from_the_generated_schema_onto_GatewayTimeoutError", async () => {
    const error = await caught(respondingWith(504, bodyFor("gateway_timeout", "handler", 30)));
    expect(error).toBeInstanceOf(GatewayTimeoutError);
    expect(error.code).toBe("gateway_timeout");
    expect((error as GatewayTimeoutError).limit).toBe("handler");
    expect((error as GatewayTimeoutError).timeoutSeconds).toBe(30);
  });

  it("should_decode_a_408_built_from_the_generated_schema_onto_RequestTimeoutError", async () => {
    const error = await caught(respondingWith(408, bodyFor("request_timeout", "body_idle", 60)));
    expect(error).toBeInstanceOf(RequestTimeoutError);
    expect(error.code).toBe("request_timeout");
    expect((error as RequestTimeoutError).limit).toBe("body_idle");
    expect((error as RequestTimeoutError).timeoutSeconds).toBe(60);
  });
});

describe("error envelope parsing", () => {
  it("should_expose_code_message_and_details_when_the_body_is_the_nested_envelope", async () => {
    const error = await caught(respondingWith(504, GATEWAY_TIMEOUT_BODY));
    expect(error.status).toBe(504);
    expect(error.code).toBe("gateway_timeout");
    expect(error.message).toBe("The server did not produce a response in time");
    expect(error.details).toEqual({ limit: "handler", timeout_seconds: 30 });
    expect(error.body).toEqual(JSON.parse(GATEWAY_TIMEOUT_BODY));
  });

  it("should_read_the_message_from_a_flat_error_string", async () => {
    const error = await caught(respondingWith(500, '{"error":"boom"}'));
    expect(error.message).toBe("boom");
    expect(error.code).toBeUndefined();
    expect(error.details).toBeUndefined();
  });

  it("should_read_code_message_and_details_from_a_flat_body", async () => {
    const error = await caught(
      respondingWith(409, '{"code":"quota_exceeded","message":"Quota exhausted","details":{"limit":10}}'),
    );
    expect(error.message).toBe("Quota exhausted");
    expect(error.code).toBe("quota_exceeded");
    expect(error.details).toEqual({ limit: 10 });
  });

  it("should_fall_back_to_the_status_message_when_the_nested_envelope_has_no_message", async () => {
    const error = await caught(respondingWith(500, '{"error":{"code":"internal","details":["not","an","object"]}}'));
    expect(error.message).toBe("Request failed with status 500");
    expect(error.code).toBe("internal");
    expect(error.details).toBeUndefined();
  });

  it("should_use_a_plain_text_body_as_the_message", async () => {
    const error = await caught(respondingWith(502, "bad gateway", "text/plain"));
    expect(error.message).toBe("bad gateway");
    expect(error.code).toBeUndefined();
  });
});

describe("status-specific error classes", () => {
  it("should_map_504_to_GatewayTimeoutError_that_is_still_a_ServerError", async () => {
    const error = await caught(respondingWith(504, GATEWAY_TIMEOUT_BODY));
    expect(error).toBeInstanceOf(GatewayTimeoutError);
    expect(error).toBeInstanceOf(ServerError);
    expect(error).toBeInstanceOf(XbergError);
    expect(error.name).toBe("GatewayTimeoutError");
    expect((error as GatewayTimeoutError).limit).toBe("handler");
    expect((error as GatewayTimeoutError).timeoutSeconds).toBe(30);
  });

  it("should_map_408_to_RequestTimeoutError_that_is_still_a_ValidationError", async () => {
    const error = await caught(respondingWith(408, REQUEST_TIMEOUT_BODY));
    expect(error).toBeInstanceOf(RequestTimeoutError);
    expect(error).toBeInstanceOf(ValidationError);
    expect(error.name).toBe("RequestTimeoutError");
    expect(error.code).toBe("request_timeout");
    expect(error.message).toBe("The request body stopped arriving before the upload completed");
    expect((error as RequestTimeoutError).limit).toBe("body_idle");
    expect((error as RequestTimeoutError).timeoutSeconds).toBe(60);
  });

  it("should_leave_limit_and_timeoutSeconds_unset_when_a_504_carries_no_details", async () => {
    const error = await caught(respondingWith(504, '{"error":"upstream timed out"}'));
    expect(error).toBeInstanceOf(GatewayTimeoutError);
    expect((error as GatewayTimeoutError).limit).toBeUndefined();
    expect((error as GatewayTimeoutError).timeoutSeconds).toBeUndefined();
  });

  it.each([
    [410, ResultExpiredError, "ResultExpiredError", "result_expired"],
    [412, PreconditionFailedError, "PreconditionFailedError", "precondition_failed"],
    [428, PreconditionRequiredError, "PreconditionRequiredError", "precondition_required"],
  ] as const)("should_map_%i_to_%s_extending_ValidationError", async (status, errorType, name, code) => {
    const error = await caught(respondingWith(status, `{"error":{"code":"${code}","message":"m${status}"}}`));
    expect(error).toBeInstanceOf(errorType);
    expect(error).toBeInstanceOf(ValidationError);
    expect(error.name).toBe(name);
    expect(error.status).toBe(status);
    expect(error.code).toBe(code);
    expect(error.message).toBe(`m${status}`);
  });

  it.each([400, 409, 422])("should_keep_mapping_%i_to_plain_ValidationError", async (status) => {
    const error = await caught(respondingWith(status, '{"error":"bad"}'));
    expect(error.constructor).toBe(ValidationError);
  });

  it.each([500, 502, 503])("should_keep_mapping_%i_to_plain_ServerError", async (status) => {
    const error = await caught(respondingWith(status, '{"error":"down"}'));
    expect(error.constructor).toBe(ServerError);
  });
});
