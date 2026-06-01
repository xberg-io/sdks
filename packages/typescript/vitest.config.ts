import { defineConfig } from "vitest/config";

export default defineConfig({
	test: {
		globals: false,
		environment: "node",
		include: ["tests/**/*.test.ts"],
		coverage: {
			provider: "v8",
			reporter: ["text", "html", "lcov"],
			include: ["src/**/*.ts"],
			exclude: ["src/_generated/**", "**/*.d.ts"],
			thresholds: {
				lines: 80,
				functions: 80,
				statements: 80,
				branches: 75,
			},
		},
	},
});
