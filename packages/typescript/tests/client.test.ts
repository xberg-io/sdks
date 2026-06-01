import { describe, expect, it } from "vitest";
import { createClient } from "../src/client.js";

describe("createClient", () => {
	it("returns a client object with HTTP method functions", () => {
		const client = createClient({ apiKey: "test-key" });
		expect(typeof client.GET).toBe("function");
		expect(typeof client.POST).toBe("function");
	});

	it("accepts a custom base URL", () => {
		const client = createClient({ baseUrl: "https://api.example.test", apiKey: "k" });
		expect(client).toBeDefined();
	});

	it("accepts a custom fetch implementation", () => {
		let called = false;
		const customFetch: typeof fetch = async () => {
			called = true;
			return new Response("{}", { status: 200, headers: { "content-type": "application/json" } });
		};
		const client = createClient({ apiKey: "k", fetch: customFetch });
		expect(client).toBeDefined();
		expect(called).toBe(false); // not called until a request is issued
	});

	it("works without an API key", () => {
		const client = createClient();
		expect(typeof client.GET).toBe("function");
	});
});
