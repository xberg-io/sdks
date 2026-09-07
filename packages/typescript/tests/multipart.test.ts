import { createServer } from "node:http";
import { describe, expect, it } from "vitest";
import { toBlob } from "../src/_internal.js";
import { XbergClient } from "../src/client.js";

const BASE_URL = "https://multipart.test";

for (const wrapped of [false, true]) {
  describe(wrapped ? "wrapped multipart bytes" : "bare multipart bytes", () => {
    it("snapshots only the typed-array window, including shared backing stores", async () => {
      for (const buffer of [new ArrayBuffer(6), new SharedArrayBuffer(6)]) {
        const storage = new Uint8Array(buffer);
        storage.set([99, 1, 2, 3, 4, 99]);
        const view = storage.subarray(1, 5);
        const { blob } = toBlob(wrapped ? { data: view, name: "sample.pdf" } : view);
        storage.fill(0);
        expect(Array.from(new Uint8Array(await blob.arrayBuffer()))).toEqual([1, 2, 3, 4]);
        expect(blob.type).toBe(wrapped ? "application/pdf" : "application/octet-stream");
      }
    });
  });
}

it("preserves existing Blob and File snapshots without materializing their bytes", async () => {
  const input = new Uint8Array([5, 6]);
  const blob = new Blob([input], { type: "text/plain" });
  const file = new File([blob], "original.txt", { type: "text/plain" });
  input.fill(0);
  expect(toBlob(blob).blob).toBe(blob);
  expect(toBlob(file)).toEqual({ blob: file, filename: "original.txt" });
  expect(toBlob({ data: blob, name: "alias.pdf", mimeType: "application/pdf" })).toEqual({
    blob,
    filename: "alias.pdf",
  });
  expect(Array.from(new Uint8Array(await blob.arrayBuffer()))).toEqual([5, 6]);
});

it("serializes exact multipart framing and escapes filename header injection", async () => {
  let serialized = "";
  const client = new XbergClient({
    baseUrl: BASE_URL,
    fetch: async (input, init) => {
      const request = new Request(input, init);
      const contentType = request.headers.get("content-type");
      const boundary = contentType?.split("boundary=")[1];
      expect(boundary).toBeTruthy();
      serialized = (await request.text()).replaceAll(boundary ?? "", "BOUNDARY");
      return Response.json({ job_ids: ["first", "second"] });
    },
  });
  await client.extractBatch({
    files: [
      { name: 'unsafe"\r\nX-Injected: yes.txt', data: new Uint8Array([65, 66]) },
      { name: "safe.bin", data: new Blob(["CD"]) },
    ],
  });
  expect(serialized).toBe(
    '--BOUNDARY\r\nContent-Disposition: form-data; name="file"; filename="unsafe%22%0D%0AX-Injected: yes.txt"\r\n' +
      'Content-Type: text/plain\r\n\r\nAB\r\n--BOUNDARY\r\nContent-Disposition: form-data; name="file"; ' +
      'filename="safe.bin"\r\nContent-Type: application/octet-stream\r\n\r\nCD\r\n--BOUNDARY--\r\n',
  );
});

it("closes a timed-out upload connection and permits the following upload", async () => {
  let calls = 0;
  const disconnected = Promise.withResolvers<void>();
  const server = createServer((request, response) => {
    calls += 1;
    request.resume();
    if (calls === 1) {
      request.socket.once("close", () => disconnected.resolve());
      return;
    }
    response.setHeader("Content-Type", "application/json");
    response.end(JSON.stringify({ job_ids: ["recovered"] }));
  });
  await new Promise<void>((resolve) => {
    server.listen(0, "127.0.0.1", resolve);
  });
  try {
    const address = server.address();
    if (address === null || typeof address === "string") throw new Error("server has no TCP address");
    const client = new XbergClient({ baseUrl: `http://127.0.0.1:${address.port}`, timeoutMs: 1000 });
    await expect(client.extract({ file: new Uint8Array([1]) })).rejects.toThrow("Network error");
    await disconnected.promise;
    expect((await client.extract({ file: new Uint8Array([2]) })).id).toBe("recovered");
    expect(calls).toBe(2);
  } finally {
    server.closeAllConnections();
    await new Promise<void>((resolve) => {
      server.close(() => resolve());
    });
  }
});
