import { describe, expect, it } from "vitest";
import { XbergClient, ValidationError, type GetJobResponse } from "../src/index.js";

const extraction = {
  id: "job-1",
  filename: "fixture.pdf",
  mime_type: "application/pdf",
  created_at: "2026-10-12T10:00:00Z",
  status: "completed",
  future_field: "retained",
};
const crawl = {
  id: "job-1",
  job_type: "crawl",
  created_at: "2026-10-12T10:00:00Z",
  status: "completed",
  output_mode: "markdown",
  seed_urls: ["https://example.test"],
  progress: { documents_discovered: 2, documents_extracted: 1, documents_failed: 0, pages_crawled: 3 },
  jobs: [{ id: "child-1", filename: "page.html", status: "completed", source_url: "https://example.test/page" }],
  pages: [{ url: "https://example.test", status: "fetched", fetched_at: "2026-10-12T10:00:00Z" }],
  future_field: "retained",
};

function clientFor(payload: unknown): XbergClient {
  return new XbergClient({
    baseUrl: "https://api.example.test",
    fetch: async (input, init) => {
      const request = new Request(input, init);
      expect(request.method).toBe("GET");
      expect(request.url).toBe("https://api.example.test/v1/jobs/job-1");
      return Response.json(payload);
    },
  });
}

describe("tagged job detail", () => {
  it.each(["extraction", "legacy"])("parses %s extraction records", async (kind) => {
    const payload = kind === "legacy" ? extraction : { ...extraction, job_type: "extraction" };
    const job: GetJobResponse = await clientFor(payload).getJob("job-1");
    expect(job.job_type).toBe("extraction");
    if (job.job_type !== "extraction") throw new Error("expected extraction");
    expect(job.filename).toBe("fixture.pdf");
    expect(job).toMatchObject({ future_field: "retained" });
  });

  it("preserves the crawl progress, child jobs and raw pages", async () => {
    const job: GetJobResponse = await clientFor(crawl).getJob("job-1");
    expect(job.job_type).toBe("crawl");
    if (job.job_type !== "crawl") throw new Error("expected crawl");
    expect(job.progress.pages_crawled).toBe(3);
    expect(job.jobs?.[0]?.source_url).toBe("https://example.test/page");
    expect(job.pages?.[0]?.url).toBe("https://example.test");
    expect(job).toMatchObject({ future_field: "retained" });
  });

  it.each(["future", null, 42])("rejects discriminator %s", async (job_type) => {
    await expect(clientFor({ ...extraction, job_type }).getJob("job-1")).rejects.toBeInstanceOf(ValidationError);
  });

  it("keeps extraction wait helpers limited to extraction jobs", async () => {
    await expect(clientFor(crawl).waitForJob("job-1")).rejects.toThrow("expected extraction job, received crawl job");
  });
});
