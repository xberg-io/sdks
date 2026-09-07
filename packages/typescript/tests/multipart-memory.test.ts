import { execFileSync } from "node:child_process";
import { fileURLToPath } from "node:url";
import { describe, expect, it } from "vitest";

const MAX_ADDITIONAL_PAYLOAD_RATIO = 1.5;

interface MemorySample {
  count: number;
  payloadBytes: number;
  encodedPayloadBytes: number;
  incrementalArrayBuffers: number;
  incrementalRss: number;
}

describe("multipart construction memory", () => {
  for (const form of ["bare", "wrapped"]) {
    it(`keeps ${form} 10x10MiB uploads below 1.5 payloads of additional allocation`, () => {
      const output = execFileSync(
        process.execPath,
        [
          "--expose-gc",
          "--import",
          "tsx",
          fileURLToPath(new URL("./multipart-memory.fixture.ts", import.meta.url)),
          form,
        ],
        { encoding: "utf8", timeout: 30_000 },
      );
      const memory: MemorySample = JSON.parse(output);
      expect(memory.count).toBe(10);
      const payloadBytes = 100 * 1024 * 1024;
      expect(memory.payloadBytes).toBe(payloadBytes);
      expect(memory.encodedPayloadBytes).toBe(payloadBytes);
      expect(memory.incrementalArrayBuffers, output).toBeGreaterThanOrEqual(payloadBytes);
      expect(memory.incrementalRss, output).toBeLessThan(payloadBytes * MAX_ADDITIONAL_PAYLOAD_RATIO);
      expect(memory.incrementalArrayBuffers, output).toBeLessThan(payloadBytes * MAX_ADDITIONAL_PAYLOAD_RATIO);
    });
  }
});
