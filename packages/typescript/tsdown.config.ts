import { defineConfig } from "tsdown";

export default defineConfig({
	entry: ["src/index.ts"],
	format: ["esm"],
	target: "node20",
	platform: "neutral",
	dts: true,
	clean: true,
	sourcemap: true,
	treeshake: true,
});
