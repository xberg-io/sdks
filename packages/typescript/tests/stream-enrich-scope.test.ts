import { createServer } from "node:http";
import { expect, it } from "vitest";
import { XbergClient } from "../src/client.js";

async function scopeServer(requireScope: boolean) {
  const paths: string[] = [];
  const bodies: unknown[] = [];
  const server = createServer(async (request, response) => {
    paths.push(`${request.method} ${request.url}`);
    const url = new URL(request.url ?? "/", "http://localhost");
    if (requireScope && url.searchParams.get("project_id") !== "owned") {
      response.writeHead(404, { "Content-Type": "application/json" }).end('{"message":"not found"}');
      return;
    }
    if (url.pathname.endsWith("/events")) {
      response
        .writeHead(200, { "Content-Type": "text/event-stream" })
        .end('data: {"kind":"complete","crawl_job_id":"crawl-1","ts":"2026-10-16T00:00:00Z","pages_crawled":2}\n\n');
      return;
    }
    if (request.method === "POST") {
      let body = "";
      for await (const chunk of request) body += String(chunk);
      bodies.push(JSON.parse(body));
      response.writeHead(202, { "Content-Type": "application/json" }).end('{"job_id":"enrich-1"}');
      return;
    }
    response
      .writeHead(200, { "Content-Type": "application/json" })
      .end('{"job_id":"enrich-1","status":"completed","result":{"entities":[]}}');
  });
  await new Promise<void>((resolve) => {
    server.listen(0, "127.0.0.1", resolve);
  });
  const address = server.address();
  if (address === null || typeof address === "string") throw new Error("server has no TCP address");
  return {
    baseUrl: `http://127.0.0.1:${address.port}`,
    paths,
    bodies,
    close: async () => {
      server.closeAllConnections();
      await new Promise<void>((resolve) => {
        server.close(() => resolve());
      });
    },
  };
}

async function consume(client: XbergClient, projectId?: string) {
  const events = [];
  for await (const event of client.streamCrawlEvents("crawl-1", projectId === undefined ? {} : { projectId }))
    events.push(event);
  return events;
}

it("scopes SSE and enrichment requests to the selected Pro project", async () => {
  const server = await scopeServer(true);
  try {
    const client = new XbergClient({ baseUrl: server.baseUrl, target: "pro" });
    await expect(consume(client)).rejects.toMatchObject({ status: 404 });
    expect(await consume(client, "owned")).toMatchObject([{ kind: "complete", pages_crawled: 2 }]);
    expect(await client.submitEnrich({ text: "café", options: { entities: true } }, { projectId: "owned" })).toEqual({
      job_id: "enrich-1",
    });
    expect(await client.getEnrichStatus("enrich-1", { projectId: "owned" })).toMatchObject({
      status: "completed",
      result: { entities: [] },
    });
    await expect(client.getEnrichStatus("enrich-1", { projectId: "other" })).rejects.toMatchObject({ status: 404 });
    expect(server.bodies).toEqual([{ text: "café", options: { entities: true } }]);
    expect(server.paths).toEqual([
      "GET /v1/crawl-jobs/crawl-1/events",
      "GET /v1/crawl-jobs/crawl-1/events?project_id=owned",
      "POST /v1/enrich?project_id=owned",
      "GET /v1/enrich/enrich-1?project_id=owned",
      "GET /v1/enrich/enrich-1?project_id=other",
    ]);
  } finally {
    await server.close();
  }
});

it("rejects Pro scope on Enterprise before opening streams or enrichment requests", async () => {
  const server = await scopeServer(true);
  try {
    const client = new XbergClient({ baseUrl: server.baseUrl, target: "enterprise" });
    await expect(consume(client, "owned")).rejects.toThrow("requires the 'pro' tier");
    await expect(client.submitEnrich({ text: "x" }, { projectId: "owned" })).rejects.toThrow("requires the 'pro' tier");
    await expect(client.getEnrichStatus("enrich-1", { projectId: "owned" })).rejects.toThrow("requires the 'pro' tier");
    for (const operation of [
      () => client.listJobs({ projectId: "owned" }),
      () => client.getJob("job-1", { projectId: "owned" }),
      () => client.cancelJob("job-1", { projectId: "owned" }),
      () => client.getJobResult("job-1", { projectId: "owned" }),
      () => client.getJobPage("job-1", 1, { projectId: "owned" }),
    ])
      await expect(operation()).rejects.toThrow("requires the 'pro' tier");
    expect(server.paths).toEqual([]);
  } finally {
    await server.close();
  }
});

it("keeps unscoped Enterprise stream and enrichment URLs unchanged", async () => {
  const server = await scopeServer(false);
  try {
    const client = new XbergClient({ baseUrl: server.baseUrl, target: "enterprise" });
    expect(await consume(client)).toHaveLength(1);
    await client.submitEnrich({ text: "legacy" });
    await client.getEnrichStatus("enrich-1");
    expect(server.paths).toEqual(["GET /v1/crawl-jobs/crawl-1/events", "POST /v1/enrich", "GET /v1/enrich/enrich-1"]);
  } finally {
    await server.close();
  }
});
