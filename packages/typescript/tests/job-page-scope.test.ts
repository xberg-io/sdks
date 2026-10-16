import { createServer } from "node:http";
import { expect, it } from "vitest";
import { XbergClient } from "../src/client.js";

it("downloads byte-exact raster bytes from the selected Pro project", async () => {
  const paths: string[] = [];
  const png = new Uint8Array([137, 80, 78, 71, 13, 10, 26, 10, 0, 255]);
  const server = createServer((request, response) => {
    paths.push(`${request.method} ${request.url}`);
    const url = new URL(request.url ?? "/", "http://localhost");
    if (url.searchParams.get("project_id") !== "project-1") {
      response.writeHead(404, { "Content-Type": "application/json" }).end('{"message":"job not found"}');
      return;
    }
    response.writeHead(200, { "Content-Type": "image/png" }).end(png);
  });
  await new Promise<void>((resolve) => {
    server.listen(0, "127.0.0.1", resolve);
  });
  try {
    const address = server.address();
    if (address === null || typeof address === "string") throw new Error("server has no TCP address");
    const baseUrl = `http://127.0.0.1:${address.port}`;
    const client = new XbergClient({ baseUrl, target: "pro" });
    await expect(client.getJobPage("job-1", 1)).rejects.toMatchObject({ status: 404 });
    expect(await client.getJobPage("job-1", 1, { projectId: "project-1" })).toEqual(png);
    const enterprise = new XbergClient({ baseUrl, target: "enterprise" });
    await expect(enterprise.getJobPage("job-1", 1, { projectId: "project-1" })).rejects.toThrow(
      "requires the 'pro' tier",
    );
    expect(paths).toEqual(["GET /v1/jobs/job-1/pages/1", "GET /v1/jobs/job-1/pages/1?project_id=project-1"]);
  } finally {
    server.closeAllConnections();
    await new Promise<void>((resolve) => {
      server.close(() => resolve());
    });
  }
});
