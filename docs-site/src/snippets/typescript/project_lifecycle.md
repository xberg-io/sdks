---
targets: ["enterprise"]
side_effect: "scratch-project"
requires: []
expect_stdout: "Project lifecycle verified"
---

```ts title="TypeScript"
import { randomUUID } from "node:crypto";
import { XbergClient } from "@xberg-io/sdk";

const client = new XbergClient({
  apiKey: process.env.XBERG_API_KEY,
  baseUrl: process.env.XBERG_BASE_URL,
  controlPlaneBaseUrl: process.env.XBERG_CONTROL_PLANE_URL,
  controlPlaneToken: process.env.XBERG_CONTROL_PLANE_TOKEN,
  target: "enterprise",
});
const project = await client.backendCreateProject({ name: `sdk-snippet-${randomUUID()}` });
try {
  const key = await client.backendCreateApiKey(project.id, { name: "snippet-key", scope: "write" });
  try {
    if (!key.key) throw new Error("API key creation returned no credential");
    const fetched = await client.getProject(project.id);
    if (fetched.id !== project.id) throw new Error("The fetched project did not match the created project");
  } finally {
    await client.backendRevokeApiKey(project.id, key.id);
  }
} finally {
  await client.deleteProject(project.id, { erase: true });
}
console.log("Project lifecycle verified");
```
