import { HttpResponse, http } from "msw";
import { afterAll, afterEach, beforeAll, describe, expect, it } from "vitest";
import { KreuzbergCloud } from "../src/client.js";
import { RateLimitError } from "../src/errors.js";
import { TEST_BASE_URL, createTestServer, url } from "./_helpers.js";

const server = createTestServer();

beforeAll(() => server.listen({ onUnhandledRequest: "error" }));
afterEach(() => server.resetHandlers());
afterAll(() => server.close());

describe("createSandboxKey", () => {
	it("calls POST /v1/sandbox/key and returns the key payload", async () => {
		server.use(
			http.post(url("/v1/sandbox/key"), () =>
				HttpResponse.json({ api_key: "kz_sandbox_abc", expires_at: "2026-05-10T00:00:00Z" }, { status: 200 }),
			),
		);
		const client = new KreuzbergCloud({ baseUrl: TEST_BASE_URL, sleep: async () => {} });
		const key = await client.createSandboxKey();
		expect(key.api_key).toBe("kz_sandbox_abc");
		expect(key.expires_at).toBe("2026-05-10T00:00:00Z");
	});

	it("raises RateLimitError with retryAfter when the sandbox endpoint returns 429", async () => {
		server.use(
			http.post(url("/v1/sandbox/key"), () =>
				HttpResponse.json({ error: "rate limit" }, { status: 429, headers: { "retry-after": "5" } }),
			),
		);
		const client = new KreuzbergCloud({ baseUrl: TEST_BASE_URL, sleep: async () => {} });
		try {
			await client.createSandboxKey();
			throw new Error("expected throw");
		} catch (error) {
			expect(error).toBeInstanceOf(RateLimitError);
			expect((error as RateLimitError).retryAfter).toBe(5);
		}
	});
});

describe("KreuzbergCloud.fromSandbox", () => {
	it("mints a sandbox key and returns a client configured with it", async () => {
		const seenAuth: string[] = [];
		server.use(
			http.post(url("/v1/sandbox/key"), ({ request }) => {
				seenAuth.push(request.headers.get("authorization") ?? "");
				return HttpResponse.json({ api_key: "kz_sandbox_minted" }, { status: 200 });
			}),
			http.get(url("/v1/jobs/job-1"), ({ request }) => {
				seenAuth.push(request.headers.get("authorization") ?? "");
				return HttpResponse.json(
					{
						id: "job-1",
						filename: "x.pdf",
						status: "completed",
						created_at: "2026-05-09T10:00:00Z",
					},
					{ status: 200 },
				);
			}),
		);

		const client = await KreuzbergCloud.fromSandbox({
			baseUrl: TEST_BASE_URL,
		});
		await client.getJob("job-1");

		expect(seenAuth[0]).toBe(""); // bootstrap call has no auth
		expect(seenAuth[1]).toBe("Bearer kz_sandbox_minted");
	});

	it("propagates baseUrl, headers, and timeout config to the returned client", async () => {
		const seenHeaders: Record<string, string | null> = {};
		server.use(
			http.post(url("/v1/sandbox/key"), () => HttpResponse.json({ api_key: "kz_minted" }, { status: 200 })),
			http.get(url("/v1/jobs/x"), ({ request }) => {
				seenHeaders["x-custom"] = request.headers.get("x-custom");
				return HttpResponse.json(
					{
						id: "x",
						filename: "x.pdf",
						status: "completed",
						created_at: "2026-05-09T10:00:00Z",
					},
					{ status: 200 },
				);
			}),
		);

		const client = await KreuzbergCloud.fromSandbox({
			baseUrl: TEST_BASE_URL,
			headers: { "x-custom": "yes" },
		});
		await client.getJob("x");
		expect(seenHeaders["x-custom"]).toBe("yes");
	});

	it("propagates a 401 from the sandbox endpoint as AuthError", async () => {
		server.use(http.post(url("/v1/sandbox/key"), () => HttpResponse.json({ error: "denied" }, { status: 401 })));
		await expect(KreuzbergCloud.fromSandbox({ baseUrl: TEST_BASE_URL })).rejects.toThrow(/denied/);
	});

	it("makeClient (default base URL) constructs without throwing", () => {
		const client = new KreuzbergCloud({ apiKey: "k" });
		expect(client).toBeInstanceOf(KreuzbergCloud);
	});
});
