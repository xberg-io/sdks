import createOpenApiClient, { type Client } from "openapi-fetch";
import type { paths } from "./_generated/schema.js";

const DEFAULT_BASE_URL = "https://api.kreuzberg.cloud";
const USER_AGENT = "kreuzberg-cloud-typescript/0.0.1";

export interface CreateClientOptions {
  /** Base URL of the Kreuzberg Cloud API. Defaults to the production endpoint. */
  baseUrl?: string;
  /** API key issued by Kreuzberg Cloud. Sent as `Authorization: Bearer <token>`. */
  apiKey?: string;
  /** Additional request headers merged into every call. */
  headers?: Record<string, string>;
  /** Custom fetch implementation. Defaults to the global `fetch`. */
  fetch?: typeof fetch;
}

export type KreuzbergCloudClient = Client<paths>;

export function createClient(options: CreateClientOptions = {}): KreuzbergCloudClient {
  const headers: Record<string, string> = {
    "User-Agent": USER_AGENT,
    ...options.headers,
  };
  if (options.apiKey !== undefined) {
    headers["Authorization"] = `Bearer ${options.apiKey}`;
  }

  return createOpenApiClient<paths>({
    baseUrl: options.baseUrl ?? DEFAULT_BASE_URL,
    headers,
    ...(options.fetch ? { fetch: options.fetch } : {}),
  });
}
