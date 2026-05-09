import { setupServer } from "msw/node";
import type { SetupServer } from "msw/node";

export const TEST_BASE_URL = "https://api.test.kreuzberg.cloud";

export function createTestServer(): SetupServer {
  return setupServer();
}

export function url(path: string): string {
  return `${TEST_BASE_URL}${path}`;
}
