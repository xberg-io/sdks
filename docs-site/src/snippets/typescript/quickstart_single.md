---
targets: ["pro", "enterprise"]
side_effect: "safe"
requires: ["document"]
expect_stdout: "Extraction verified"
---

```ts title="TypeScript"
import { readFile } from "node:fs/promises";
import { XbergClient } from "@xberg-io/sdk";

const client = new XbergClient({
  apiKey: process.env.XBERG_API_KEY,
  baseUrl: process.env.XBERG_BASE_URL,
  target: process.env.XBERG_TARGET === "pro" ? "pro" : "enterprise",
});
const document = process.env.XBERG_DOCUMENT;
if (!document) throw new Error("Set XBERG_DOCUMENT to a local document path");
const data = await readFile(document);
const job = await client.extractAndWait({ file: { name: "snippet.txt", data, mimeType: "text/plain" } });
const result = await client.getJobResult(job.id);
if (!result.results?.[0]?.content?.includes("Xberg SDK snippet fixture")) {
  throw new Error("The extracted document did not contain the expected text");
}
console.log("Extraction verified");
```
