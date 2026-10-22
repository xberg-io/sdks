import { createServer } from "node:http";
import { describe, expect, it } from "vitest";
import { XbergClient } from "../src/client.js";

const DATA_URL = "https://data.test";
const CONTROL_URL = "https://control.test";
const PATH_ID = "project /?#";
interface BackendCase {
  name: string;
  method: string;
  path: string;
  query: Record<string, string>;
  body?: unknown;
  status: number;
  public: boolean;
  binary: boolean;
  multipart: boolean;
  call(client: XbergClient): Promise<unknown>;
}

const cases: BackendCase[] = [
  {
    name: "getUserProfile",
    method: "GET",
    path: "/auth/profile",
    query: {},
    status: 200,
    public: false,
    binary: false,
    multipart: false,
    call: (client) => client.getUserProfile(),
  },
  {
    name: "updateUserProfile",
    method: "PATCH",
    path: "/auth/profile",
    query: {},
    body: { display_name: "Updated" },
    status: 200,
    public: false,
    binary: false,
    multipart: false,
    call: (client) => client.updateUserProfile({ display_name: "Updated" }),
  },
  {
    name: "deleteAccount",
    method: "DELETE",
    path: "/auth/account",
    query: {},
    status: 204,
    public: false,
    binary: false,
    multipart: false,
    call: (client) => client.deleteAccount(),
  },
  {
    name: "getAuthConfig",
    method: "GET",
    path: "/auth/config",
    query: {},
    status: 200,
    public: true,
    binary: false,
    multipart: false,
    call: (client) => client.getAuthConfig(),
  },
  {
    name: "backendLogin",
    method: "POST",
    path: "/auth/login",
    query: {},
    status: 200,
    public: true,
    binary: false,
    multipart: false,
    body: {
      id_token: "value",
    },
    call: (client) => client.backendLogin({ id_token: "value" }),
  },
  {
    name: "healthz",
    method: "GET",
    path: "/healthz",
    query: {},
    status: 200,
    public: true,
    binary: false,
    multipart: false,
    call: (client) => client.healthz(),
  },
  {
    name: "readyz",
    method: "GET",
    path: "/readyz",
    query: {},
    status: 200,
    public: true,
    binary: false,
    multipart: false,
    call: (client) => client.readyz(),
  },
  {
    name: "acceptInvitation",
    method: "POST",
    path: "/v1/invitations/accept",
    query: {},
    status: 200,
    public: false,
    binary: false,
    multipart: false,
    body: {
      token: "value",
    },
    call: (client) => client.acceptInvitation({ token: "value" }),
  },
  {
    name: "oauthCallback",
    method: "GET",
    path: "/v1/oauth/callback",
    query: {
      code: "value /?",
      state: "value /?",
    },
    status: 303,
    public: true,
    binary: false,
    multipart: false,
    call: (client) => client.oauthCallback({ code: "value /?", state: "value /?" }),
  },
  {
    name: "backendListProjects",
    method: "GET",
    path: "/v1/projects",
    query: {
      limit: "2",
      offset: "2",
    },
    status: 200,
    public: false,
    binary: false,
    multipart: false,
    call: (client) => client.backendListProjects({ limit: 2, offset: 2 }),
  },
  {
    name: "backendCreateProject",
    method: "POST",
    path: "/v1/projects",
    query: {},
    status: 201,
    public: false,
    binary: false,
    multipart: false,
    body: {
      name: "value",
    },
    call: (client) => client.backendCreateProject({ name: "value" }),
  },
  {
    name: "getProject",
    method: "GET",
    path: "/v1/projects/project%20%2F%3F%23",
    query: {},
    status: 200,
    public: false,
    binary: false,
    multipart: false,
    call: (client) => client.getProject(PATH_ID),
  },
  {
    name: "deleteProject",
    method: "DELETE",
    path: "/v1/projects/project%20%2F%3F%23",
    query: {
      erase: "true",
    },
    status: 204,
    public: false,
    binary: false,
    multipart: false,
    call: (client) => client.deleteProject(PATH_ID, { erase: true }),
  },
  {
    name: "updateProject",
    method: "PATCH",
    path: "/v1/projects/project%20%2F%3F%23",
    query: {},
    status: 200,
    public: false,
    binary: false,
    multipart: false,
    body: {
      name: "updated",
    },
    call: (client) => client.updateProject(PATH_ID, { name: "updated" }),
  },
  {
    name: "getAnalytics",
    method: "GET",
    path: "/v1/projects/project%20%2F%3F%23/analytics",
    query: {
      start_date: "value /?",
      end_date: "value /?",
    },
    status: 200,
    public: false,
    binary: false,
    multipart: false,
    call: (client) => client.getAnalytics(PATH_ID, { startDate: "value /?", endDate: "value /?" }),
  },
  {
    name: "backendListApiKeys",
    method: "GET",
    path: "/v1/projects/project%20%2F%3F%23/api-keys",
    query: {
      limit: "2",
      offset: "2",
    },
    status: 200,
    public: false,
    binary: false,
    multipart: false,
    call: (client) => client.backendListApiKeys(PATH_ID, { limit: 2, offset: 2 }),
  },
  {
    name: "backendCreateApiKey",
    method: "POST",
    path: "/v1/projects/project%20%2F%3F%23/api-keys",
    query: {},
    status: 201,
    public: false,
    binary: false,
    multipart: false,
    body: {
      name: "updated",
    },
    call: (client) => client.backendCreateApiKey(PATH_ID, { name: "updated" }),
  },
  {
    name: "backendRevokeApiKey",
    method: "DELETE",
    path: "/v1/projects/project%20%2F%3F%23/api-keys/project%20%2F%3F%23",
    query: {},
    status: 204,
    public: false,
    binary: false,
    multipart: false,
    call: (client) => client.backendRevokeApiKey(PATH_ID, PATH_ID),
  },
  {
    name: "regenerateApiKey",
    method: "POST",
    path: "/v1/projects/project%20%2F%3F%23/api-keys/project%20%2F%3F%23/regenerate",
    query: {},
    status: 200,
    public: false,
    binary: false,
    multipart: false,
    call: (client) => client.regenerateApiKey(PATH_ID, PATH_ID),
  },
  {
    name: "listProjectAudit",
    method: "GET",
    path: "/v1/projects/project%20%2F%3F%23/audit",
    query: {
      action: "value /?",
      limit: "2",
      offset: "2",
    },
    status: 200,
    public: false,
    binary: false,
    multipart: false,
    call: (client) => client.listProjectAudit(PATH_ID, { action: "value /?", limit: 2, offset: 2 }),
  },
  {
    name: "getBilling",
    method: "GET",
    path: "/v1/projects/project%20%2F%3F%23/billing",
    query: {},
    status: 200,
    public: false,
    binary: false,
    multipart: false,
    call: (client) => client.getBilling(PATH_ID),
  },
  {
    name: "createCheckout",
    method: "POST",
    path: "/v1/projects/project%20%2F%3F%23/billing/checkout",
    query: {},
    status: 200,
    public: false,
    binary: false,
    multipart: false,
    call: (client) => client.createCheckout(PATH_ID),
  },
  {
    name: "createPortal",
    method: "POST",
    path: "/v1/projects/project%20%2F%3F%23/billing/portal",
    query: {},
    status: 200,
    public: false,
    binary: false,
    multipart: false,
    call: (client) => client.createPortal(PATH_ID),
  },
  {
    name: "backendListIntegrations",
    method: "GET",
    path: "/v1/projects/project%20%2F%3F%23/integrations",
    query: {
      limit: "2",
      offset: "2",
    },
    status: 200,
    public: false,
    binary: false,
    multipart: false,
    call: (client) => client.backendListIntegrations(PATH_ID, { limit: 2, offset: 2 }),
  },
  {
    name: "backendCreateIntegration",
    method: "POST",
    path: "/v1/projects/project%20%2F%3F%23/integrations",
    query: {},
    status: 201,
    public: false,
    binary: false,
    multipart: false,
    body: {
      name: "value",
      kind: "value",
      auth_type: "value",
    },
    call: (client) => client.backendCreateIntegration(PATH_ID, { name: "value", kind: "value", auth_type: "value" }),
  },
  {
    name: "backendGetIntegration",
    method: "GET",
    path: "/v1/projects/project%20%2F%3F%23/integrations/project%20%2F%3F%23",
    query: {},
    status: 200,
    public: false,
    binary: false,
    multipart: false,
    call: (client) => client.backendGetIntegration(PATH_ID, PATH_ID),
  },
  {
    name: "backendDeleteIntegration",
    method: "DELETE",
    path: "/v1/projects/project%20%2F%3F%23/integrations/project%20%2F%3F%23",
    query: {},
    status: 204,
    public: false,
    binary: false,
    multipart: false,
    call: (client) => client.backendDeleteIntegration(PATH_ID, PATH_ID),
  },
  {
    name: "oauthConnect",
    method: "POST",
    path: "/v1/projects/project%20%2F%3F%23/integrations/project%20%2F%3F%23/connect",
    query: {},
    status: 200,
    public: false,
    binary: false,
    multipart: false,
    call: (client) => client.oauthConnect(PATH_ID, PATH_ID),
  },
  {
    name: "backendDisconnectIntegration",
    method: "POST",
    path: "/v1/projects/project%20%2F%3F%23/integrations/project%20%2F%3F%23/disconnect",
    query: {},
    status: 204,
    public: false,
    binary: false,
    multipart: false,
    call: (client) => client.backendDisconnectIntegration(PATH_ID, PATH_ID),
  },
  {
    name: "backendListIntegrationDocuments",
    method: "GET",
    path: "/v1/projects/project%20%2F%3F%23/integrations/project%20%2F%3F%23/documents",
    query: {
      mime_types: "value /?",
      folder_id: "value /?",
      limit: "2",
    },
    status: 200,
    public: false,
    binary: false,
    multipart: false,
    call: (client) =>
      client.backendListIntegrationDocuments(PATH_ID, PATH_ID, {
        mimeTypes: "value /?",
        folderId: "value /?",
        limit: 2,
      }),
  },
  {
    name: "backendFetchIntegrationDocument",
    method: "GET",
    path: "/v1/projects/project%20%2F%3F%23/integrations/project%20%2F%3F%23/documents/project%20%2F%3F%23",
    query: {},
    status: 200,
    public: false,
    binary: true,
    multipart: false,
    call: (client) => client.backendFetchIntegrationDocument(PATH_ID, PATH_ID, PATH_ID),
  },
  {
    name: "backendGetIntegrationSync",
    method: "GET",
    path: "/v1/projects/project%20%2F%3F%23/integrations/project%20%2F%3F%23/sync",
    query: {},
    status: 200,
    public: false,
    binary: false,
    multipart: false,
    call: (client) => client.backendGetIntegrationSync(PATH_ID, PATH_ID),
  },
  {
    name: "backendSetIntegrationSync",
    method: "PUT",
    path: "/v1/projects/project%20%2F%3F%23/integrations/project%20%2F%3F%23/sync",
    query: {},
    status: 204,
    public: false,
    binary: false,
    multipart: false,
    body: { enabled: false },
    call: (client) => client.backendSetIntegrationSync(PATH_ID, PATH_ID, { enabled: false }),
  },
  {
    name: "listInvitations",
    method: "GET",
    path: "/v1/projects/project%20%2F%3F%23/invitations",
    query: {
      limit: "2",
      offset: "2",
    },
    status: 200,
    public: false,
    binary: false,
    multipart: false,
    call: (client) => client.listInvitations(PATH_ID, { limit: 2, offset: 2 }),
  },
  {
    name: "inviteUser",
    method: "POST",
    path: "/v1/projects/project%20%2F%3F%23/invitations",
    query: {},
    status: 201,
    public: false,
    binary: false,
    multipart: false,
    body: {
      email: "value",
      role: "value",
    },
    call: (client) => client.inviteUser(PATH_ID, { email: "value", role: "value" }),
  },
  {
    name: "revokeInvitation",
    method: "DELETE",
    path: "/v1/projects/project%20%2F%3F%23/invitations/project%20%2F%3F%23",
    query: {},
    status: 204,
    public: false,
    binary: false,
    multipart: false,
    call: (client) => client.revokeInvitation(PATH_ID, PATH_ID),
  },
  {
    name: "leaveProject",
    method: "POST",
    path: "/v1/projects/project%20%2F%3F%23/leave",
    query: {},
    status: 204,
    public: false,
    binary: false,
    multipart: false,
    call: (client) => client.leaveProject(PATH_ID),
  },
  {
    name: "listMembers",
    method: "GET",
    path: "/v1/projects/project%20%2F%3F%23/members",
    query: {
      limit: "2",
      offset: "2",
    },
    status: 200,
    public: false,
    binary: false,
    multipart: false,
    call: (client) => client.listMembers(PATH_ID, { limit: 2, offset: 2 }),
  },
  {
    name: "removeMember",
    method: "DELETE",
    path: "/v1/projects/project%20%2F%3F%23/members/project%20%2F%3F%23",
    query: {},
    status: 204,
    public: false,
    binary: false,
    multipart: false,
    call: (client) => client.removeMember(PATH_ID, PATH_ID),
  },
  {
    name: "updateMemberRole",
    method: "PATCH",
    path: "/v1/projects/project%20%2F%3F%23/members/project%20%2F%3F%23",
    query: {},
    status: 200,
    public: false,
    binary: false,
    multipart: false,
    body: {
      role: "value",
    },
    call: (client) => client.updateMemberRole(PATH_ID, PATH_ID, { role: "value" }),
  },
  {
    name: "assignProjectRole",
    method: "PATCH",
    path: "/v1/projects/project%20%2F%3F%23/members/project%20%2F%3F%23/custom-role",
    query: {},
    status: 204,
    public: false,
    binary: false,
    multipart: false,
    body: { custom_role_ids: ["22222222-2222-2222-2222-222222222222"] },
    call: (client) =>
      client.assignProjectRole(PATH_ID, PATH_ID, { custom_role_ids: ["22222222-2222-2222-2222-222222222222"] }),
  },
  {
    name: "backendGetRagConfig",
    method: "GET",
    path: "/v1/projects/project%20%2F%3F%23/rag-config",
    query: {},
    status: 200,
    public: false,
    binary: false,
    multipart: false,
    call: (client) => client.backendGetRagConfig(PATH_ID),
  },
  {
    name: "backendSetRagConfig",
    method: "PUT",
    path: "/v1/projects/project%20%2F%3F%23/rag-config",
    query: {},
    status: 200,
    public: false,
    binary: false,
    multipart: false,
    body: {
      enabled: true,
    },
    call: (client) => client.backendSetRagConfig(PATH_ID, { enabled: true }),
  },
  {
    name: "listProjectRoles",
    method: "GET",
    path: "/v1/projects/project%20%2F%3F%23/roles",
    query: { limit: "2", offset: "2" },
    status: 200,
    public: false,
    binary: false,
    multipart: false,
    call: (client) => client.listProjectRoles(PATH_ID, { limit: 2, offset: 2 }),
  },
  {
    name: "createProjectRole",
    method: "POST",
    path: "/v1/projects/project%20%2F%3F%23/roles",
    query: {},
    status: 201,
    public: false,
    binary: false,
    multipart: false,
    body: { name: "Reviewer", permissions: ["job.read"] },
    call: (client) => client.createProjectRole(PATH_ID, { name: "Reviewer", permissions: ["job.read"] }),
  },
  {
    name: "getProjectRole",
    method: "GET",
    path: "/v1/projects/project%20%2F%3F%23/roles/project%20%2F%3F%23",
    query: {},
    status: 200,
    public: false,
    binary: false,
    multipart: false,
    call: (client) => client.getProjectRole(PATH_ID, PATH_ID),
  },
  {
    name: "updateProjectRole",
    method: "PATCH",
    path: "/v1/projects/project%20%2F%3F%23/roles/project%20%2F%3F%23",
    query: {},
    status: 200,
    public: false,
    binary: false,
    multipart: false,
    body: { name: "Reviewer", permissions: ["job.read"] },
    call: (client) => client.updateProjectRole(PATH_ID, PATH_ID, { name: "Reviewer", permissions: ["job.read"] }),
  },
  {
    name: "deleteProjectRole",
    method: "DELETE",
    path: "/v1/projects/project%20%2F%3F%23/roles/project%20%2F%3F%23",
    query: {},
    status: 204,
    public: false,
    binary: false,
    multipart: false,
    call: (client) => client.deleteProjectRole(PATH_ID, PATH_ID),
  },
  {
    name: "listSamlDomains",
    method: "GET",
    path: "/v1/projects/project%20%2F%3F%23/saml/domains",
    query: {},
    status: 200,
    public: false,
    binary: false,
    multipart: false,
    call: (client) => client.listSamlDomains(PATH_ID),
  },
  {
    name: "createSamlDomain",
    method: "POST",
    path: "/v1/projects/project%20%2F%3F%23/saml/domains",
    query: {},
    status: 201,
    public: false,
    binary: false,
    multipart: false,
    body: { provider_id: "22222222-2222-2222-2222-222222222222", domain: "example.test" },
    call: (client) =>
      client.createSamlDomain(PATH_ID, { provider_id: "22222222-2222-2222-2222-222222222222", domain: "example.test" }),
  },
  {
    name: "verifySamlDomain",
    method: "POST",
    path: "/v1/projects/project%20%2F%3F%23/saml/domains/project%20%2F%3F%23/verify",
    query: {},
    status: 204,
    public: false,
    binary: false,
    multipart: false,
    call: (client) => client.verifySamlDomain(PATH_ID, PATH_ID),
  },
  {
    name: "listSamlProviders",
    method: "GET",
    path: "/v1/projects/project%20%2F%3F%23/saml/providers",
    query: {},
    status: 200,
    public: false,
    binary: false,
    multipart: false,
    call: (client) => client.listSamlProviders(PATH_ID),
  },
  {
    name: "createSamlProvider",
    method: "POST",
    path: "/v1/projects/project%20%2F%3F%23/saml/providers",
    query: {},
    status: 201,
    public: false,
    binary: false,
    multipart: false,
    body: { label: "Okta", metadata_xml: "<EntityDescriptor/>" },
    call: (client) => client.createSamlProvider(PATH_ID, { label: "Okta", metadata_xml: "<EntityDescriptor/>" }),
  },
  {
    name: "updateSamlProvider",
    method: "PUT",
    path: "/v1/projects/project%20%2F%3F%23/saml/providers/project%20%2F%3F%23",
    query: {},
    status: 200,
    public: false,
    binary: false,
    multipart: false,
    body: { label: "Okta", metadata_xml: "<EntityDescriptor/>" },
    call: (client) =>
      client.updateSamlProvider(PATH_ID, PATH_ID, { label: "Okta", metadata_xml: "<EntityDescriptor/>" }),
  },
  {
    name: "deleteSamlProvider",
    method: "DELETE",
    path: "/v1/projects/project%20%2F%3F%23/saml/providers/project%20%2F%3F%23",
    query: {},
    status: 204,
    public: false,
    binary: false,
    multipart: false,
    call: (client) => client.deleteSamlProvider(PATH_ID, PATH_ID),
  },
  {
    name: "sandboxExtract",
    method: "POST",
    path: "/v1/projects/project%20%2F%3F%23/sandbox/extract",
    query: {},
    status: 200,
    public: false,
    binary: false,
    multipart: true,
    call: (client) => client.sandboxExtract(PATH_ID, { file: new Uint8Array([65, 66]) }),
  },
  {
    name: "listScimConnections",
    method: "GET",
    path: "/v1/projects/project%20%2F%3F%23/scim/connections",
    query: {},
    status: 200,
    public: false,
    binary: false,
    multipart: false,
    call: (client) => client.listScimConnections(PATH_ID),
  },
  {
    name: "createScimConnection",
    method: "POST",
    path: "/v1/projects/project%20%2F%3F%23/scim/connections",
    query: {},
    status: 201,
    public: false,
    binary: false,
    multipart: false,
    body: { display_name: "Okta SCIM" },
    call: (client) => client.createScimConnection(PATH_ID, { display_name: "Okta SCIM" }),
  },
  {
    name: "listScimAdminGroups",
    method: "GET",
    path: "/v1/projects/project%20%2F%3F%23/scim/connections/project%20%2F%3F%23/groups",
    query: {},
    status: 200,
    public: false,
    binary: false,
    multipart: false,
    call: (client) => client.listScimAdminGroups(PATH_ID, PATH_ID),
  },
  {
    name: "replaceScimGroupRoles",
    method: "PUT",
    path: "/v1/projects/project%20%2F%3F%23/scim/connections/project%20%2F%3F%23/groups/project%20%2F%3F%23/roles",
    query: {},
    status: 204,
    public: false,
    binary: false,
    multipart: false,
    body: { role_ids: ["22222222-2222-2222-2222-222222222222"] },
    call: (client) =>
      client.replaceScimGroupRoles(PATH_ID, PATH_ID, PATH_ID, { role_ids: ["22222222-2222-2222-2222-222222222222"] }),
  },
  {
    name: "rotateScimConnectionSecret",
    method: "POST",
    path: "/v1/projects/project%20%2F%3F%23/scim/connections/project%20%2F%3F%23/rotate",
    query: {},
    status: 200,
    public: false,
    binary: false,
    multipart: false,
    call: (client) => client.rotateScimConnectionSecret(PATH_ID, PATH_ID),
  },
  {
    name: "getUsage",
    method: "GET",
    path: "/v1/projects/project%20%2F%3F%23/usage",
    query: {
      start_date: "value /?",
      end_date: "value /?",
    },
    status: 200,
    public: false,
    binary: false,
    multipart: false,
    call: (client) => client.getUsage(PATH_ID, { startDate: "value /?", endDate: "value /?" }),
  },
  {
    name: "listWebhooks",
    method: "GET",
    path: "/v1/projects/project%20%2F%3F%23/webhooks",
    query: {
      limit: "2",
      offset: "2",
    },
    status: 200,
    public: false,
    binary: false,
    multipart: false,
    call: (client) => client.listWebhooks(PATH_ID, { limit: 2, offset: 2 }),
  },
  {
    name: "createWebhook",
    method: "POST",
    path: "/v1/projects/project%20%2F%3F%23/webhooks",
    query: {},
    status: 201,
    public: false,
    binary: false,
    multipart: false,
    body: {
      name: "value",
      url: "value",
      events: ["event"],
    },
    call: (client) => client.createWebhook(PATH_ID, { name: "value", url: "value", events: ["event"] }),
  },
  {
    name: "deleteWebhook",
    method: "DELETE",
    path: "/v1/projects/project%20%2F%3F%23/webhooks/project%20%2F%3F%23",
    query: {},
    status: 204,
    public: false,
    binary: false,
    multipart: false,
    call: (client) => client.deleteWebhook(PATH_ID, PATH_ID),
  },
  {
    name: "updateWebhook",
    method: "PATCH",
    path: "/v1/projects/project%20%2F%3F%23/webhooks/project%20%2F%3F%23",
    query: {},
    status: 200,
    public: false,
    binary: false,
    multipart: false,
    body: {
      name: "updated",
    },
    call: (client) => client.updateWebhook(PATH_ID, PATH_ID, { name: "updated" }),
  },
  {
    name: "listWebhookDeliveries",
    method: "GET",
    path: "/v1/projects/project%20%2F%3F%23/webhooks/project%20%2F%3F%23/deliveries",
    query: {
      limit: "2",
      offset: "2",
    },
    status: 200,
    public: false,
    binary: false,
    multipart: false,
    call: (client) => client.listWebhookDeliveries(PATH_ID, PATH_ID, { limit: 2, offset: 2 }),
  },
  {
    name: "getWebhookDelivery",
    method: "GET",
    path: "/v1/projects/project%20%2F%3F%23/webhooks/project%20%2F%3F%23/deliveries/project%20%2F%3F%23",
    query: {},
    status: 200,
    public: false,
    binary: false,
    multipart: false,
    call: (client) => client.getWebhookDelivery(PATH_ID, PATH_ID, PATH_ID),
  },
  {
    name: "retryWebhookDelivery",
    method: "POST",
    path: "/v1/projects/project%20%2F%3F%23/webhooks/project%20%2F%3F%23/deliveries/project%20%2F%3F%23/retry",
    query: {},
    status: 202,
    public: false,
    binary: false,
    multipart: false,
    call: (client) => client.retryWebhookDelivery(PATH_ID, PATH_ID, PATH_ID),
  },
  {
    name: "testWebhook",
    method: "POST",
    path: "/v1/projects/project%20%2F%3F%23/webhooks/project%20%2F%3F%23/test",
    query: {},
    status: 200,
    public: false,
    binary: false,
    multipart: false,
    call: (client) => client.testWebhook(PATH_ID, PATH_ID),
  },
  {
    name: "publicSandboxExtract",
    method: "POST",
    path: "/v1/sandbox/public/extract",
    query: {},
    status: 200,
    public: true,
    binary: false,
    multipart: true,
    call: (client) => client.publicSandboxExtract({ file: new Uint8Array([65, 66]) }),
  },
];

describe("Enterprise backend operations", () => {
  it("covers every one of the 71 operations", () => expect(cases).toHaveLength(71));
  for (const scenario of cases) {
    it(`${scenario.name} uses the declared control-plane wire contract`, async () => {
      let calls = 0;
      const client = new XbergClient({
        baseUrl: DATA_URL,
        controlPlaneBaseUrl: CONTROL_URL,
        apiKey: "data-key",
        controlPlaneToken: "control-token",
        headers: {
          authorization: "inherited",
          Cookie: "cookie=value",
          "Proxy-Authorization": "proxy",
          "X-API-Key": "custom-key",
        },
        target: "enterprise",
        fetch: async (input, init) => {
          calls += 1;
          const request = new Request(input, init);
          const url = new URL(request.url);
          expect(url.origin).toBe(CONTROL_URL);
          expect(url.pathname).toBe(scenario.path);
          expect(Object.fromEntries(url.searchParams)).toEqual(scenario.query);
          expect(request.method).toBe(scenario.method);
          expect(request.headers.get("authorization")).toBe(scenario.public ? null : "Bearer control-token");
          for (const header of ["cookie", "proxy-authorization", "x-api-key"])
            expect(request.headers.has(header)).toBe(false);
          expect(request.credentials).toBe("omit");
          expect(request.redirect).toBe("manual");
          if (scenario.multipart) {
            const form = await request.formData();
            const file = form.get("file");
            expect(file).toBeInstanceOf(File);
            if (!(file instanceof File)) throw new Error("file missing");
            expect(await file.text()).toBe("AB");
          } else if (scenario.body !== undefined) {
            expect(await request.json()).toEqual(scenario.body);
          } else {
            expect(await request.text()).toBe("");
          }
          if (scenario.status === 204) return new Response(null, { status: 204 });
          if (scenario.status === 303) return new Response(null, { status: 303, headers: { Location: "/done" } });
          if (scenario.binary) return new Response(new Uint8Array([0, 255, 65]));
          return Response.json({ result: scenario.name }, { status: scenario.status });
        },
      });
      const result = await scenario.call(client);
      expect(calls).toBe(1);
      expect(result).toEqual(
        scenario.status === 204
          ? undefined
          : scenario.status === 303
            ? "/done"
            : scenario.binary
              ? new Uint8Array([0, 255, 65])
              : { result: scenario.name },
      );
    });
  }
});

it("returns the user profile fields from both profile operations", async () => {
  const profile = { user_id: "user-123", email: "profile@example.test", display_name: "Updated" };
  const client = new XbergClient({
    baseUrl: DATA_URL,
    controlPlaneBaseUrl: CONTROL_URL,
    target: "enterprise",
    fetch: async () => Response.json(profile),
  });
  expect(await client.getUserProfile()).toEqual(profile);
  expect(await client.updateUserProfile({ display_name: "Updated" })).toEqual(profile);
});

it("returns SAML lists as arrays and custom roles with their permissions", async () => {
  const provider = { id: "33333333-3333-3333-3333-333333333333", label: "Okta", enabled: true };
  const role = { id: "22222222-2222-2222-2222-222222222222", name: "Reviewer", permissions: ["job.read"] };
  const client = new XbergClient({
    baseUrl: DATA_URL,
    controlPlaneBaseUrl: CONTROL_URL,
    target: "enterprise",
    fetch: async (input) =>
      Response.json(new URL(String(input)).pathname.endsWith("/saml/providers") ? [provider] : role),
  });
  expect(await client.listSamlProviders("p")).toEqual([provider]);
  expect(await client.getProjectRole("p", role.id)).toEqual(role);
});

for (const scenario of [
  { name: "getProjectRole", call: (client: XbergClient) => client.getProjectRole("p", "missing") },
  {
    name: "replaceScimGroupRoles",
    call: (client: XbergClient) => client.replaceScimGroupRoles("p", "c", "g", { role_ids: [] }),
  },
]) {
  it(`${scenario.name} propagates a control-plane error status`, async () => {
    const client = new XbergClient({
      baseUrl: DATA_URL,
      controlPlaneBaseUrl: CONTROL_URL,
      target: "enterprise",
      fetch: async () => Response.json({ error: { message: "not found" } }, { status: 404 }),
    });
    await expect(scenario.call(client)).rejects.toMatchObject({ status: 404 });
  });
}

describe("backend credential and redirect boundaries", () => {
  for (const scenario of cases) {
    it(`${scenario.name} rejects an explicit Pro target before network access`, async () => {
      let calls = 0;
      const client = new XbergClient({
        target: "pro",
        baseUrl: DATA_URL,
        controlPlaneBaseUrl: CONTROL_URL,
        fetch: async () => {
          calls += 1;
          return Response.json({});
        },
      });
      await expect(scenario.call(client)).rejects.toThrow("not available on the 'pro' tier");
      expect(calls).toBe(0);
    });
  }

  it("keeps the backend token off the data plane and falls back to the API key", async () => {
    const requests: [string, string | null][] = [];
    const fetch: typeof globalThis.fetch = async (input, init) => {
      const request = new Request(input, init);
      requests.push([request.url, request.headers.get("authorization")]);
      return Response.json(
        request.url.includes("/v1/jobs/") ? { job_type: "extraction", filename: "fixture.pdf" } : {},
      );
    };
    const client = new XbergClient({
      baseUrl: DATA_URL,
      controlPlaneBaseUrl: CONTROL_URL,
      apiKey: "data-key",
      controlPlaneToken: "control-token",
      fetch,
    });
    await client.getProject("p");
    await client.getJob("j");
    await new XbergClient({ baseUrl: DATA_URL, apiKey: "fallback", fetch }).getProject("p");
    expect(requests).toEqual([
      [`${CONTROL_URL}/v1/projects/p`, "Bearer control-token"],
      [`${DATA_URL}/v1/jobs/j`, "Bearer data-key"],
      [`${DATA_URL}/v1/projects/p`, "Bearer fallback"],
    ]);
  });

  it("uses only an explicit sandbox token and encodes fileless web extraction", async () => {
    let calls = 0;
    const client = new XbergClient({
      baseUrl: DATA_URL,
      controlPlaneBaseUrl: CONTROL_URL,
      apiKey: "data-key",
      controlPlaneToken: "control-token",
      headers: {
        authorization: "inherited",
        Cookie: "cookie=value",
        "Proxy-Authorization": "proxy",
        "X-API-Key": "custom-key",
        "Content-Type": "application/json",
      },
      fetch: async (input, init) => {
        calls += 1;
        const request = new Request(input, init);
        expect(request.headers.get("authorization")).toBe(calls === 1 ? "Bearer sandbox-only" : null);
        for (const name of ["cookie", "proxy-authorization", "x-api-key"])
          expect(request.headers.has(name)).toBe(false);
        expect(request.credentials).toBe("omit");
        const form = await request.formData();
        expect(Object.fromEntries(form)).toEqual({ mode: "web", url: "https://example.test", preset: "preset" });
        return Response.json({});
      },
    });
    await client.publicSandboxExtract({
      mode: "web",
      url: "https://example.test",
      preset: "preset",
      sandboxToken: "sandbox-only",
    });
    await client.publicSandboxExtract({ mode: "web", url: "https://example.test", preset: "preset" });
    expect(calls).toBe(2);
  });

  it("rejects absent public sandbox input before network access", async () => {
    let calls = 0;
    const client = new XbergClient({
      baseUrl: DATA_URL,
      fetch: async () => {
        calls += 1;
        return Response.json({});
      },
    });
    await expect(client.publicSandboxExtract({})).rejects.toThrow("file or web mode with a URL");
    await expect(client.publicSandboxExtract({ mode: "web", url: "" })).rejects.toThrow("file or web mode with a URL");
    expect(calls).toBe(0);
  });

  for (const location of [null, ""]) {
    it(`rejects a 303 callback with ${location === null ? "missing" : "empty"} Location and cancels its body`, async () => {
      let canceled = 0;
      const client = new XbergClient({
        baseUrl: DATA_URL,
        fetch: async () =>
          new Response(
            new ReadableStream({
              cancel() {
                canceled += 1;
              },
            }),
            { status: 303, headers: location === null ? {} : { Location: location } },
          ),
      });
      await expect(client.oauthCallback({ code: "code", state: "state" })).rejects.toThrow("303 Location");
      expect(canceled).toBe(1);
    });
  }

  it("does not expose OAuth code or state from a network exception", async () => {
    const client = new XbergClient({
      baseUrl: DATA_URL,
      controlPlaneBaseUrl: CONTROL_URL,
      fetch: async (input) => {
        throw new Error(`failed request ${input}`);
      },
    });
    try {
      await client.oauthCallback({ code: "sensitive-code", state: "sensitive-state" });
      throw new Error("request unexpectedly succeeded");
    } catch (error) {
      expect(error).toBeInstanceOf(Error);
      expect(String(error)).toBe(
        "XbergError: Network error contacting Enterprise control plane (GET /v1/oauth/callback)",
      );
      expect(JSON.stringify(error)).not.toContain("sensitive-");
      if (error instanceof Error) expect(error.cause).toBeUndefined();
    }
  });
});

it("rejects dot member identifiers before WHATWG URL normalization can target the project", async () => {
  const requests: string[] = [];
  const server = createServer((request, response) => {
    requests.push(`${request.method} ${request.url}`);
    response.writeHead(204).end();
  });
  await new Promise<void>((resolve) => {
    server.listen(0, "127.0.0.1", resolve);
  });
  try {
    const address = server.address();
    if (address === null || typeof address === "string") throw new Error("server has no TCP address");
    const client = new XbergClient({
      baseUrl: "http://127.0.0.1:1",
      controlPlaneBaseUrl: `http://127.0.0.1:${address.port}`,
    });
    for (const userId of [".", ".."]) {
      const result = await client.removeMember("project", userId).then(
        () => "accepted",
        (error: unknown) => error,
      );
      expect(requests).toEqual([]);
      expect(result).toBeInstanceOf(Error);
    }
    await client.removeMember("project", "%2E%2E");
    expect(requests).toEqual(["DELETE /v1/projects/project/members/%252E%252E"]);
  } finally {
    server.closeAllConnections();
    await new Promise<void>((resolve) => {
      server.close(() => resolve());
    });
  }
});

it("keeps credentials in a configured origin out of backend network errors", async () => {
  const client = new XbergClient({
    baseUrl: DATA_URL,
    controlPlaneBaseUrl: "https://private-user:private-password@control.test",
    fetch: async () => {
      throw new Error("connection rejected");
    },
  });
  await expect(client.getProject("p")).rejects.not.toThrow("private-");
});

it("sets one JSON content type even when custom headers use different casing", async () => {
  let contentType: string | null = null;
  let body: unknown;
  const client = new XbergClient({
    baseUrl: DATA_URL,
    headers: { "cOnTeNt-TyPe": "text/plain" },
    fetch: async (input, init) => {
      const request = new Request(input, init);
      contentType = request.headers.get("content-type");
      body = await request.json();
      return Response.json({});
    },
  });
  await client.backendLogin({ id_token: "id-token" });
  expect(contentType).toBe("application/json");
  expect(body).toEqual({ id_token: "id-token" });
});

it("omits explicitly empty backend and public sandbox tokens", async () => {
  const authorizations: (string | null)[] = [];
  const client = new XbergClient({
    baseUrl: DATA_URL,
    apiKey: "data-key",
    controlPlaneToken: "",
    fetch: async (input, init) => {
      authorizations.push(new Request(input, init).headers.get("authorization"));
      return Response.json({});
    },
  });
  await client.getProject("p");
  await client.publicSandboxExtract({ file: new Uint8Array([1]), sandboxToken: "" });
  expect(authorizations).toEqual([null, null]);
});

it("rejects every backend operation after the data plane is discovered to be Pro", async () => {
  const paths: string[] = [];
  const client = new XbergClient({
    baseUrl: DATA_URL,
    controlPlaneBaseUrl: CONTROL_URL,
    fetch: async (input) => {
      const path = String(input);
      paths.push(path);
      return Response.json(path.endsWith("/healthz") ? { tier: "pro" } : { projects: [] });
    },
  });
  await client.listProjects();
  for (const scenario of cases) {
    await expect(scenario.call(client)).rejects.toThrow("not available on the 'pro' tier");
  }
  expect(paths).toEqual([`${DATA_URL}/healthz`, `${DATA_URL}/v1/projects`]);
});
