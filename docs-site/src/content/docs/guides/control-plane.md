---
title: The control plane
description: Manage projects, keys, integrations, and teams on Pro or Enterprise.
---

Pro uses one origin for extraction and administration. Enterprise uses a separate backend origin.
Configure `control_plane_base_url` (Python), `controlPlaneBaseUrl` (TypeScript), or
`WithControlPlaneBaseURL` (Go) for Enterprise. Set the target to `enterprise` when it is known.

## Choose the method for your deployment

| Operation | Pro Python / TypeScript / Go | Enterprise Python / TypeScript / Go |
| --- | --- | --- |
| List projects | `list_projects` / `listProjects` / `ListProjects` | `backend_list_projects` / `backendListProjects` / `BackendListProjects` |
| Create project | `create_project` / `createProject` / `CreateProject` | `backend_create_project` / `backendCreateProject` / `BackendCreateProject` |
| Create key | `create_api_key` / `createApiKey` / `CreateAPIKey` | `backend_create_api_key` / `backendCreateApiKey` / `BackendCreateAPIKey` |
| Create integration | `create_integration` / `createIntegration` / `CreateIntegration` | `backend_create_integration` / `backendCreateIntegration` / `BackendCreateIntegration` |
| Read project RAG configuration | `get_rag_config` / `getRagConfig` / `GetRagConfig` | `backend_get_rag_config` / `backendGetRagConfig` / `BackendGetRAGConfig` |

Backend methods preserve the backend's generated request and response types. Pro and backend schemas
are not interchangeable merely because their paths match. Use the per-language
[Python](/reference/api-python/), [TypeScript](/reference/api-typescript/), and
[Go](/reference/api-go/) references for the complete method list.

## Authenticate

Set a backend bearer with `control_plane_token`, `controlPlaneToken`, or `WithControlPlaneToken`.
The default is the configured API key. A separate token lets the data plane keep a project key while
the backend uses a session token. An explicit empty token disables the fallback.

`backend_login` / `backendLogin` / `BackendLogin` exchanges an external OIDC ID token for a backend
session token. Its response uses the backend login schema. Use the resulting backend token for later
control-plane calls; an external OIDC ID token is not itself a backend session token.

Public sandbox extraction takes a separate explicit token. No project key or backend session token
is forwarded implicitly to that endpoint. Fileless extraction requires web mode and a URL.

Backend requests omit inherited cookies and do not follow redirects. The OAuth callback method returns
the server's `Location` from a 303 response without navigating to it. Let your application decide
whether and how to open that destination.

## Manage resources

Create a project before creating its API keys. The create-key response contains the plaintext key;
store it in your secret manager and avoid logging it. Key listing does not recover the original secret.

Create an integration to register a document source, then call its connect method to obtain an
authorization URL. The provider's browser consent flow remains an application concern. After connection,
list documents and fetch their original bytes before submitting them for extraction.

Enterprise also exposes project membership, invitations, managed webhooks, analytics, usage, and billing.
These use the dedicated backend origin. Project RAG configuration sets project defaults; individual
RAG collection configuration remains a separate data-plane surface.

The [tier matrix](/reference/tier-capabilities/) distinguishes shared functionality from Enterprise-only
operations. The [OpenAPI reference](/reference/openapi/) shows each deployment's exact schema.
