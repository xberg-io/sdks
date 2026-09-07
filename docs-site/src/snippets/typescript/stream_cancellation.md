---
targets: ["enterprise"]
side_effect: "safe"
requires: ["crawl-job"]
expect_stdout: "Subscription canceled"
---

```ts title="TypeScript"
import { XbergClient } from "@xberg-io/sdk";

const client = new XbergClient({
  apiKey: process.env.XBERG_API_KEY,
  baseUrl: process.env.XBERG_BASE_URL,
  target: "enterprise",
  timeoutMs: 500,
});
const crawlJobId = process.env.XBERG_CRAWL_JOB_ID;
if (!crawlJobId) throw new Error("Set XBERG_CRAWL_JOB_ID to an existing crawl job");
const signal = AbortSignal.timeout(Number(process.env.XBERG_STREAM_TIMEOUT_SECONDS ?? "30") * 1000);
try {
  for await (const event of client.streamCrawlEvents(crawlJobId, { signal })) {
    console.log(event.kind);
  }
} catch (error) {
  if (!signal.aborted) throw error;
}
if (signal.aborted) console.log("Subscription canceled");
```
