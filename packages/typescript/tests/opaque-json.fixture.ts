import type { Client } from "openapi-fetch";
import type { backendComponents, proPaths, XbergClient } from "../src/index.js";

export function acceptsCurrentProPaths(client: Client<proPaths>): void {
  const path = { project_id: "project", iid: "integration" };
  void client.GET("/v1/projects/{project_id}/integrations/{iid}", { params: { path } });
  void client.POST("/v1/projects/{project_id}/integrations/{iid}/connect", { params: { path } });
  void client.POST("/v1/projects/{project_id}/integrations/{iid}/disconnect", { params: { path } });
  void client.GET("/v1/projects/{project_id}/integrations/{iid}/documents", { params: { path } });
  void client.GET("/v1/projects/{project_id}/integrations/{iid}/documents/{doc_id}", {
    params: { path: { ...path, doc_id: "document" } },
  });
}

export function acceptsOpaqueJson(client: XbergClient): void {
  void client.createSavedPreset({
    name: "structured",
    preferred_call_mode: "text_only",
    schema: { type: "object", properties: { title: { type: "string" } }, required: ["title"] },
  });
  void client.createIntegration("project", {
    name: "fixture",
    kind: "google_drive",
    auth_type: "oauth2",
    credentials: { client_id: "fixture", options: { enabled: true } },
    config: { folders: ["fixture"] },
  });
  const backendBody: backendComponents["schemas"]["CreateIntegrationRequest"] = {
    name: "fixture",
    kind: "google_drive",
    auth_type: "oauth2",
    credentials: { client_id: "fixture", options: { enabled: true } },
    config: { folders: ["fixture"] },
  };
  void client.backendCreateIntegration("project", backendBody);
  void client.createSavedPreset({
    // @ts-expect-error -- ~keep Opaque JSON must not loosen declared string fields.
    name: 42,
    preferred_call_mode: "text_only",
    schema: {},
  });
}
