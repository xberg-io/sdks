---
targets: ["pro"]
side_effect: "safe"
requires: []
expect_stdout: "Pro health verified"
---

```ts title="TypeScript"
import assert from "node:assert/strict";
import { XbergClient } from "@xberg-io/sdk";

const baseUrl = process.env.XBERG_BASE_URL;
if (!baseUrl) throw new Error("Set XBERG_BASE_URL to your deployment URL");
const client = new XbergClient({ baseUrl, target: "pro", retries: 0 });
const health = await client.proHealthz();
const snapshot = {
  status: health.status,
  tier: health.tier,
  license: { state: health.license.state },
  rag: { enabled: health.rag.enabled },
  auto_tune: { enabled: health.auto_tune.enabled },
};
assert.equal(snapshot.status, "ok", "Pro health status mismatch");
assert.equal(snapshot.tier, "pro");
assert.ok(["licensed", "grace", "expired", "invalid", "unlicensed"].includes(snapshot.license.state));
assert.equal(typeof snapshot.rag.enabled, "boolean");
assert.equal(typeof snapshot.auto_tune.enabled, "boolean");
if (process.env.XBERG_EXPECTED_PRO_HEALTH_JSON) {
  assert.deepEqual(snapshot, JSON.parse(process.env.XBERG_EXPECTED_PRO_HEALTH_JSON));
}
console.log("Pro health verified");
```
