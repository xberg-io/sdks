import type { backendComponents, XbergClient } from "../src/index.js";

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
