import { createServer } from "node:http";
import { expect, it } from "vitest";
import { XbergClient } from "../src/client.js";

it("rejects dot segments on existing destructive Pro and shared routes before sending requests", async () => {
  const paths: string[] = [];
  const server = createServer((request, response) => {
    paths.push(`${request.method} ${request.url}`);
    response.writeHead(204).end();
  });
  await new Promise<void>((resolve) => {
    server.listen(0, "127.0.0.1", resolve);
  });
  try {
    const address = server.address();
    if (address === null || typeof address === "string") throw new Error("server has no TCP address");
    const client = new XbergClient({ baseUrl: `http://127.0.0.1:${address.port}`, target: "pro" });
    for (const id of ["..", "."]) {
      for (const remove of [
        () => client.deleteIntegration("project", id),
        () => client.cancelJob(id),
        () => client.deleteRagCollection(id),
      ]) {
        const result = await remove().then(
          () => "accepted",
          (error: unknown) => error,
        );
        expect(paths).toEqual([]);
        expect(result).toBeInstanceOf(Error);
      }
    }
    await client.deleteIntegration("project", "%2e%2e");
    await client.cancelJob("job /?#");
    expect(paths).toEqual(["DELETE /v1/projects/project/integrations/%252e%252e", "DELETE /v1/jobs/job%20%2F%3F%23"]);
  } finally {
    server.closeAllConnections();
    await new Promise<void>((resolve) => {
      server.close(() => resolve());
    });
  }
});
