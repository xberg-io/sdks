package xberg

import (
	"context"
	"net/url"
	"strconv"
)

// This file holds the Pro-only surface — authentication and the control plane
// (projects, API keys, integrations, per-project RAG configuration). Every
// method is capability-gated: it verifies the connected instance is the Pro
// tier (an explicit [WithTarget], or probed from GET /healthz) and returns a
// [TierError] rather than issuing a request that would 404 on Enterprise.
//
// Saved presets used to live here. They are declared by both specs — only the
// route spelling differs — so they moved to saved_presets.go and are no longer
// tier-gated.

// projectsPath is the root of the Pro control plane. Projects own API keys,
// integrations and RAG configuration, so every control-plane route below is
// nested under it.
const projectsPath = "/v1/projects"

// projectPath renders a project-scoped route, escaping the project ID. suffix
// is appended verbatim and must already start with "/" when non-empty.
func projectPath(projectID, suffix string) string {
	return projectsPath + "/" + escapePathSegment(projectID) + suffix
}

// integrationPath renders an integration-scoped route nested under a project.
// suffix is appended verbatim and must already start with "/" when non-empty.
func integrationPath(projectID, integrationID, suffix string) string {
	return projectPath(projectID, "/integrations/"+escapePathSegment(integrationID)+suffix)
}

// -- auth ---------------------------------------------------------------------

// AuthConfig fetches the instance's accepted auth methods (GET /auth/config).
// Pro only.
func (c *Client) AuthConfig(ctx context.Context) (*AuthConfigResponse, error) {
	if err := c.requireTier(ctx, TargetPro, "AuthConfig"); err != nil {
		return nil, err
	}
	var out AuthConfigResponse
	if err := c.getJSON(ctx, "/auth/config", &out); err != nil {
		return nil, err
	}
	return &out, nil
}

// Login exchanges a verified OIDC ID token for a Pro session JWT
// (POST /auth/login). Pro only.
func (c *Client) Login(ctx context.Context, body LoginRequest) (*LoginResponse, error) {
	if err := c.requireTier(ctx, TargetPro, "Login"); err != nil {
		return nil, err
	}
	var out LoginResponse
	if err := c.callJSON(ctx, methodPost, "/auth/login", body, &out); err != nil {
		return nil, err
	}
	return &out, nil
}

// -- projects -----------------------------------------------------------------

// ListProjects lists the projects visible to the caller
// (GET /v1/projects, paginated). A non-positive limit or offset is omitted
// from the query string, leaving the server's default. Pro only.
func (c *Client) ListProjects(ctx context.Context, limit, offset int) (*ListProjectsResponse, error) {
	if err := c.requireTier(ctx, TargetPro, "ListProjects"); err != nil {
		return nil, err
	}
	var out ListProjectsResponse
	if err := c.getJSON(ctx, projectsPath+pageQuery(limit, offset), &out); err != nil {
		return nil, err
	}
	return &out, nil
}

// CreateProject creates a project (POST /v1/projects). Pro only.
func (c *Client) CreateProject(ctx context.Context, body CreateProjectRequest) (*ProjectResponse, error) {
	if err := c.requireTier(ctx, TargetPro, "CreateProject"); err != nil {
		return nil, err
	}
	var out ProjectResponse
	if err := c.callJSON(ctx, methodPost, projectsPath, body, &out); err != nil {
		return nil, err
	}
	return &out, nil
}

// -- API keys -----------------------------------------------------------------

// ListAPIKeys lists a project's API keys
// (GET /v1/projects/{projectID}/api-keys, paginated). Only key prefixes are
// returned, never full keys. Pro only.
func (c *Client) ListAPIKeys(ctx context.Context, projectID string, limit, offset int) (*ListApiKeysResponse, error) {
	if err := c.requireTier(ctx, TargetPro, "ListAPIKeys"); err != nil {
		return nil, err
	}
	var out ListApiKeysResponse
	path := projectPath(projectID, "/api-keys") + pageQuery(limit, offset)
	if err := c.getJSON(ctx, path, &out); err != nil {
		return nil, err
	}
	return &out, nil
}

// CreateAPIKey issues a new API key for a project
// (POST /v1/projects/{projectID}/api-keys). The plaintext key is returned in
// [CreateApiKeyResponse.Key] and is never retrievable again. Pro only.
func (c *Client) CreateAPIKey(
	ctx context.Context,
	projectID string,
	body CreateApiKeyRequest,
) (*CreateApiKeyResponse, error) {
	if err := c.requireTier(ctx, TargetPro, "CreateAPIKey"); err != nil {
		return nil, err
	}
	var out CreateApiKeyResponse
	if err := c.callJSON(ctx, methodPost, projectPath(projectID, "/api-keys"), body, &out); err != nil {
		return nil, err
	}
	return &out, nil
}

// RevokeAPIKey revokes an API key
// (DELETE /v1/projects/{projectID}/api-keys/{keyID}). The endpoint answers 204
// with no body. Pro only.
func (c *Client) RevokeAPIKey(ctx context.Context, projectID, keyID string) error {
	if err := c.requireTier(ctx, TargetPro, "RevokeAPIKey"); err != nil {
		return err
	}
	path := projectPath(projectID, "/api-keys/"+escapePathSegment(keyID))
	return c.callJSON(ctx, methodDelete, path, nil, nil)
}

// -- integrations -------------------------------------------------------------

// ListIntegrations lists a project's integrations
// (GET /v1/projects/{projectID}/integrations, paginated). Pro only.
func (c *Client) ListIntegrations(
	ctx context.Context,
	projectID string,
	limit, offset int,
) (*ListIntegrationsResponse, error) {
	if err := c.requireTier(ctx, TargetPro, "ListIntegrations"); err != nil {
		return nil, err
	}
	var out ListIntegrationsResponse
	path := projectPath(projectID, "/integrations") + pageQuery(limit, offset)
	if err := c.getJSON(ctx, path, &out); err != nil {
		return nil, err
	}
	return &out, nil
}

// CreateIntegration registers an integration on a project
// (POST /v1/projects/{projectID}/integrations). Pro only.
func (c *Client) CreateIntegration(
	ctx context.Context,
	projectID string,
	body CreateIntegrationRequest,
) (*IntegrationResponse, error) {
	if err := c.requireTier(ctx, TargetPro, "CreateIntegration"); err != nil {
		return nil, err
	}
	var out IntegrationResponse
	if err := c.callJSON(ctx, methodPost, projectPath(projectID, "/integrations"), body, &out); err != nil {
		return nil, err
	}
	return &out, nil
}

// GetIntegration fetches one integration
// (GET /v1/projects/{projectID}/integrations/{integrationID}). Secrets are
// never included. Pro only.
func (c *Client) GetIntegration(ctx context.Context, projectID, integrationID string) (*IntegrationResponse, error) {
	if err := c.requireTier(ctx, TargetPro, "GetIntegration"); err != nil {
		return nil, err
	}
	var out IntegrationResponse
	if err := c.getJSON(ctx, integrationPath(projectID, integrationID, ""), &out); err != nil {
		return nil, err
	}
	return &out, nil
}

// DeleteIntegration removes an integration
// (DELETE /v1/projects/{projectID}/integrations/{integrationID}). The endpoint
// answers 204 with no body. Pro only.
func (c *Client) DeleteIntegration(ctx context.Context, projectID, integrationID string) error {
	if err := c.requireTier(ctx, TargetPro, "DeleteIntegration"); err != nil {
		return err
	}
	return c.callJSON(ctx, methodDelete, integrationPath(projectID, integrationID, ""), nil, nil)
}

// ConnectIntegration begins the OAuth connection flow for an integration
// (POST /v1/projects/{projectID}/integrations/{integrationID}/connect) and
// returns the provider authorization URL the end user must visit. Pro only.
func (c *Client) ConnectIntegration(ctx context.Context, projectID, integrationID string) (*BeginOAuthResponse, error) {
	if err := c.requireTier(ctx, TargetPro, "ConnectIntegration"); err != nil {
		return nil, err
	}
	var out BeginOAuthResponse
	path := integrationPath(projectID, integrationID, "/connect")
	if err := c.callJSON(ctx, methodPost, path, nil, &out); err != nil {
		return nil, err
	}
	return &out, nil
}

// DisconnectIntegration revokes an integration's stored OAuth credentials
// (POST /v1/projects/{projectID}/integrations/{integrationID}/disconnect). The
// endpoint answers 204 with no body. Pro only.
func (c *Client) DisconnectIntegration(ctx context.Context, projectID, integrationID string) error {
	if err := c.requireTier(ctx, TargetPro, "DisconnectIntegration"); err != nil {
		return err
	}
	path := integrationPath(projectID, integrationID, "/disconnect")
	return c.callJSON(ctx, methodPost, path, nil, nil)
}

// ListIntegrationDocuments lists the documents a connected integration exposes
// (GET /v1/projects/{projectID}/integrations/{integrationID}/documents). params
// may be nil to accept the source's defaults. Pro only.
func (c *Client) ListIntegrationDocuments(
	ctx context.Context,
	projectID, integrationID string,
	params *ListIntegrationDocumentsParams,
) (*ListDocumentsResponse, error) {
	if err := c.requireTier(ctx, TargetPro, "ListIntegrationDocuments"); err != nil {
		return nil, err
	}
	var out ListDocumentsResponse
	path := integrationPath(projectID, integrationID, "/documents") + encodeDocumentParams(params)
	if err := c.getJSON(ctx, path, &out); err != nil {
		return nil, err
	}
	return &out, nil
}

// FetchIntegrationDocument downloads one document's bytes from a connected
// integration
// (GET /v1/projects/{projectID}/integrations/{integrationID}/documents/{documentID}).
// The endpoint serves the source's own media type, so the body is returned
// undecoded, ready to hand to [Client.Extract] as a [FileSource]. Pro only.
func (c *Client) FetchIntegrationDocument(ctx context.Context, projectID, integrationID, documentID string) ([]byte, error) {
	if err := c.requireTier(ctx, TargetPro, "FetchIntegrationDocument"); err != nil {
		return nil, err
	}
	path := integrationPath(projectID, integrationID, "/documents/"+escapePathSegment(documentID))
	return c.getBytes(ctx, path)
}

// encodeDocumentParams renders the optional document-listing filters as a query
// suffix, or "" when nothing is set.
func encodeDocumentParams(params *ListIntegrationDocumentsParams) string {
	if params == nil {
		return ""
	}
	q := url.Values{}
	if params.MimeTypes != nil {
		q.Set("mime_types", *params.MimeTypes)
	}
	if params.FolderId != nil {
		q.Set("folder_id", *params.FolderId)
	}
	if params.MaxResults != nil {
		q.Set("max_results", strconv.Itoa(*params.MaxResults))
	}
	if encoded := q.Encode(); encoded != "" {
		return "?" + encoded
	}
	return ""
}

// -- RAG configuration --------------------------------------------------------

// GetRagConfig fetches a project's RAG config
// (GET /v1/projects/{projectID}/rag-config). Pro only.
func (c *Client) GetRagConfig(ctx context.Context, projectID string) (*RagConfigResponse, error) {
	if err := c.requireTier(ctx, TargetPro, "GetRagConfig"); err != nil {
		return nil, err
	}
	var out RagConfigResponse
	if err := c.getJSON(ctx, projectPath(projectID, "/rag-config"), &out); err != nil {
		return nil, err
	}
	return &out, nil
}

// SetRagConfig updates a project's RAG config
// (PUT /v1/projects/{projectID}/rag-config). Pro only.
func (c *Client) SetRagConfig(ctx context.Context, projectID string, body SetRagConfigRequest) (*RagConfigResponse, error) {
	if err := c.requireTier(ctx, TargetPro, "SetRagConfig"); err != nil {
		return nil, err
	}
	var out RagConfigResponse
	if err := c.callJSON(ctx, methodPut, projectPath(projectID, "/rag-config"), body, &out); err != nil {
		return nil, err
	}
	return &out, nil
}
