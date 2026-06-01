/**
 * Friendly re-exports of generated schema types.
 *
 * The generated `components["schemas"][...]` indexed access is verbose; this
 * module provides the named aliases used by the public client API.
 */

import type { components } from "./_generated/schema.js";

export type ExtractionOptions = components["schemas"]["ExtractionOptions"];
export type ExtractionConfig = components["schemas"]["ExtractionConfig"];
export type ExtractionResult = components["schemas"]["ExtractionResult"];
export type Job = components["schemas"]["JobResponse"];
export type JobStatus = components["schemas"]["JobStatus"];
export type WebhookConfig = components["schemas"]["WebhookConfig"];
export type ExtractResponse = components["schemas"]["ExtractResponse"];
export type DocumentInput = components["schemas"]["DocumentInput"];
export type UsageResponse = components["schemas"]["UsageResponse"];

/**
 * A completed (or failed) job, returned by `waitForJob` once the job reaches a
 * terminal status. Adds a non-nullable `result` when the status is
 * `completed`/`partial_success` — callers can rely on `.result` without a
 * runtime null check in the happy path.
 */
export type JobResult = Job;

/**
 * Sandbox API key returned by `POST /v1/sandbox/key`.
 *
 * The sandbox endpoint is not yet part of the OpenAPI spec; this type mirrors
 * the documented response shape.
 */
export interface SandboxKey {
	api_key: string;
	expires_at?: string;
	project_id?: string;
}

/**
 * Terminal job statuses — once observed, polling stops and the job result is
 * returned (or thrown, for `failed`/`cancelled`).
 */
export const TERMINAL_JOB_STATUSES: readonly JobStatus[] = [
	"completed",
	"partial_success",
	"failed",
	"cancelled",
] as const;

/**
 * Job statuses that indicate a successful extraction. Used to distinguish a
 * "completed but check warnings" result from a hard failure.
 */
export const SUCCESS_JOB_STATUSES: readonly JobStatus[] = ["completed", "partial_success"] as const;
