import { XbergClient } from "../src/client.js";

const FILE_COUNT = 10;
const FILE_BYTES = 10 * 1024 * 1024;
const PAYLOAD_BYTES = FILE_COUNT * FILE_BYTES;
let encodedPayloadBytes = 0;
const client = new XbergClient({
  baseUrl: "https://multipart.test",
  fetch: async (_input, init) => {
    if (!(init?.body instanceof FormData)) throw new Error("multipart body is missing");
    const parts = init.body.getAll("file");
    encodedPayloadBytes = parts.reduce((total, part) => {
      if (typeof part === "string") throw new Error("file part is not a Blob");
      return total + part.size;
    }, 0);
    return Response.json({ job_ids: parts.map((_part, index) => String(index)) });
  },
});
await client.extract({ file: new Uint8Array([1]) });
const files = Array.from({ length: FILE_COUNT }, () => new Uint8Array(FILE_BYTES).fill(42));
if (!globalThis.gc) throw new Error("memory fixture requires --expose-gc");
globalThis.gc();
// ~keep The budget covers FormData construction above caller-owned input, before fetch serialization or transport.
const baseline = process.memoryUsage();
let peakArrayBuffers = baseline.arrayBuffers;
let peakRss = baseline.rss;
function sample() {
  const memory = process.memoryUsage();
  peakArrayBuffers = Math.max(peakArrayBuffers, memory.arrayBuffers);
  peakRss = Math.max(peakRss, memory.rss);
}
// ~keep Native Blob still snapshots every input; samples bracket construction without retaining its parts.
const NativeBlob = Blob;
globalThis.Blob = class extends NativeBlob {
  constructor(parts?: BlobPart[], options?: BlobPropertyBag) {
    sample();
    super(parts, options);
    sample();
  }
};
try {
  const jobs = await client.extractBatch({
    files: process.argv[2] === "wrapped" ? files.map((data) => ({ data, name: "sample.bin" })) : files,
  });
  sample();
  peakRss = Math.max(peakRss, process.resourceUsage().maxRSS * 1024);
  process.stdout.write(
    JSON.stringify({
      node: process.version,
      count: jobs.length,
      payloadBytes: PAYLOAD_BYTES,
      encodedPayloadBytes,
      baselineRss: baseline.rss,
      peakRss,
      incrementalRss: peakRss - baseline.rss,
      incrementalArrayBuffers: peakArrayBuffers - baseline.arrayBuffers,
    }) + "\n",
  );
} finally {
  globalThis.Blob = NativeBlob;
}
