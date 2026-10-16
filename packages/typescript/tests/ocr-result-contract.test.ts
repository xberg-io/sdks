import { readFileSync } from "node:fs";
import { createServer } from "node:http";
import { resolve as resolvePath } from "node:path";
import { expect, it } from "vitest";
import { XbergClient, type ExtractedDocument, type ExtractionConfig } from "../src/index.js";

const document: ExtractedDocument = JSON.parse(
  readFileSync(resolvePath(__dirname, "../../../spec/fixtures/extraction_result_ocr_recovery.json"), "utf8"),
);

it.each(["pro", "enterprise"] as const)(
  "exposes typed OCR recovery fields through the %s HTTP response",
  async (target) => {
    const paths: string[] = [];
    const server = createServer((request, response) => {
      paths.push(request.url ?? "");
      const payload = request.url?.endsWith("/result")
        ? { job_id: "job-1", status: "completed", cached: false, results: [document] }
        : {
            id: "job-1",
            filename: "synthetic.pdf",
            mime_type: "application/pdf",
            job_type: "extraction",
            status: "completed",
            result: document,
          };
      response.writeHead(200, { "Content-Type": "application/json" }).end(JSON.stringify(payload));
    });
    await new Promise<void>((resolve) => {
      server.listen(0, "127.0.0.1", resolve);
    });
    try {
      const address = server.address();
      if (address === null || typeof address === "string") throw new Error("server has no TCP address");
      const client = new XbergClient({ baseUrl: `http://127.0.0.1:${address.port}`, target });
      const job = await client.getJob("job-1");
      if (job.job_type !== "extraction") throw new Error("expected extraction job");
      expect(job.result?.ocr_page_failures?.[0]?.page).toBe(1);
      expect(job.result?.ocr_page_failures?.[0]?.recovered).toBe(true);
      expect(job.result?.pages?.[0]?.native_content).toBe("Invoice total 125.50");
      expect(job.result).toMatchObject({ future_opaque: { numbers: [1, 2], flag: false } });
      const result = await client.getJobResult("job-1");
      expect(result.results?.[0]).toMatchObject({
        ocr_page_failures: document.ocr_page_failures,
        pages: document.pages,
        future_opaque: { numbers: [1, 2], flag: false },
      });
      expect(paths).toEqual(["/v1/jobs/job-1", "/v1/jobs/job-1/result"]);
    } finally {
      server.closeAllConnections();
      await new Promise<void>((resolve) => {
        server.close(() => resolve());
      });
    }
  },
);

it("types PaddleOCR request settings without changing their serialized values", () => {
  const config: ExtractionConfig = {
    ocr: { backend: "paddleocr", paddle_ocr_settings: { device: "cpu", threads: 2 } },
  };
  expect(JSON.parse(JSON.stringify(config))).toEqual({
    ocr: { backend: "paddleocr", paddle_ocr_settings: { device: "cpu", threads: 2 } },
  });
});
