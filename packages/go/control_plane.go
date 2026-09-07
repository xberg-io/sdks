package xberg

import (
	"context"
)

// DeleteAccount calls DELETE /auth/account on the Enterprise control plane.
func (c *Client) DeleteAccount(ctx context.Context) error {
	return c.controlPlaneEmpty(ctx, "DeleteAccount", methodDelete, "/auth/account")
}

// GetAuthConfig calls GET /auth/config on the Enterprise control plane.
func (c *Client) GetAuthConfig(ctx context.Context) (*AuthConfigResponse, error) {
	return controlPlaneJSON[AuthConfigResponse](ctx, c, "GetAuthConfig", methodGet, "/auth/config", nil)
}

// BackendLogin calls POST /auth/login on the Enterprise control plane.
func (c *Client) BackendLogin(ctx context.Context, body LoginRequest) (*LoginResponse, error) {
	return controlPlaneJSON[LoginResponse](ctx, c, "BackendLogin", methodPost, "/auth/login", body)
}

// Healthz calls GET /healthz on the Enterprise control plane.
func (c *Client) Healthz(ctx context.Context) (*BackendHealthResponse, error) {
	return controlPlaneJSON[BackendHealthResponse](ctx, c, "Healthz", methodGet, "/healthz", nil)
}

// Readyz calls GET /readyz on the Enterprise control plane.
func (c *Client) Readyz(ctx context.Context) (*BackendReadinessResponse, error) {
	return controlPlaneJSON[BackendReadinessResponse](ctx, c, "Readyz", methodGet, "/readyz", nil)
}

// AcceptInvitation calls POST /v1/invitations/accept on the Enterprise control plane.
func (c *Client) AcceptInvitation(ctx context.Context, body AcceptInvitationRequest) (*MemberResponse, error) {
	return controlPlaneJSON[MemberResponse](ctx, c, "AcceptInvitation", methodPost, "/v1/invitations/accept", body)
}

// BackendListProjects calls GET /v1/projects on the Enterprise control plane.
func (c *Client) BackendListProjects(ctx context.Context, params map[string]string) (*ListProjectsResponse, error) {
	return controlPlaneJSON[ListProjectsResponse](
		ctx,
		c,
		"BackendListProjects",
		methodGet,
		"/v1/projects"+encodeParams(params),
		nil,
	)
}

// BackendCreateProject calls POST /v1/projects on the Enterprise control plane.
func (c *Client) BackendCreateProject(ctx context.Context, body CreateProjectRequest) (*ProjectResponse, error) {
	return controlPlaneJSON[ProjectResponse](ctx, c, "BackendCreateProject", methodPost, "/v1/projects", body)
}

// DeleteProject calls DELETE /v1/projects/{id} on the Enterprise control plane.
func (c *Client) DeleteProject(ctx context.Context, projectID string, params map[string]string) error {
	return c.controlPlaneEmpty(
		ctx,
		"DeleteProject",
		methodDelete,
		"/v1/projects/"+escapePathSegment(projectID)+encodeParams(params),
	)
}

// GetProject calls GET /v1/projects/{id} on the Enterprise control plane.
func (c *Client) GetProject(ctx context.Context, projectID string) (*ProjectResponse, error) {
	return controlPlaneJSON[ProjectResponse](
		ctx,
		c,
		"GetProject",
		methodGet,
		"/v1/projects/"+escapePathSegment(projectID),
		nil,
	)
}

// UpdateProject calls PATCH /v1/projects/{id} on the Enterprise control plane.
func (c *Client) UpdateProject(
	ctx context.Context,
	projectID string,
	body UpdateProjectRequest,
) (*ProjectResponse, error) {
	return controlPlaneJSON[ProjectResponse](
		ctx,
		c,
		"UpdateProject",
		methodPatch,
		"/v1/projects/"+escapePathSegment(projectID),
		body,
	)
}

// GetAnalytics calls GET /v1/projects/{id}/analytics on the Enterprise control plane.
func (c *Client) GetAnalytics(
	ctx context.Context,
	projectID string,
	params map[string]string,
) (*AnalyticsResponse, error) {
	return controlPlaneJSON[AnalyticsResponse](
		ctx,
		c,
		"GetAnalytics",
		methodGet,
		"/v1/projects/"+escapePathSegment(projectID)+"/analytics"+encodeParams(params),
		nil,
	)
}

// BackendListAPIKeys calls GET /v1/projects/{id}/api-keys on the Enterprise control plane.
func (c *Client) BackendListAPIKeys(
	ctx context.Context,
	projectID string,
	params map[string]string,
) (*ListApiKeysResponse, error) {
	return controlPlaneJSON[ListApiKeysResponse](
		ctx,
		c,
		"BackendListAPIKeys",
		methodGet,
		"/v1/projects/"+escapePathSegment(projectID)+"/api-keys"+encodeParams(params),
		nil,
	)
}

// BackendCreateAPIKey calls POST /v1/projects/{id}/api-keys on the Enterprise control plane.
func (c *Client) BackendCreateAPIKey(
	ctx context.Context,
	projectID string,
	body CreateApiKeyRequest,
) (*CreateApiKeyResponse, error) {
	return controlPlaneJSON[CreateApiKeyResponse](
		ctx,
		c,
		"BackendCreateAPIKey",
		methodPost,
		"/v1/projects/"+escapePathSegment(projectID)+"/api-keys",
		body,
	)
}

// BackendRevokeAPIKey calls DELETE /v1/projects/{id}/api-keys/{key_id} on the Enterprise control plane.
func (c *Client) BackendRevokeAPIKey(ctx context.Context, projectID string, keyID string) error {
	return c.controlPlaneEmpty(
		ctx,
		"BackendRevokeAPIKey",
		methodDelete,
		"/v1/projects/"+escapePathSegment(projectID)+"/api-keys/"+escapePathSegment(keyID),
	)
}

// RegenerateAPIKey calls POST /v1/projects/{id}/api-keys/{key_id}/regenerate on the Enterprise control plane.
func (c *Client) RegenerateAPIKey(ctx context.Context, projectID string, keyID string) (*CreateApiKeyResponse, error) {
	return controlPlaneJSON[CreateApiKeyResponse](
		ctx,
		c,
		"RegenerateAPIKey",
		methodPost,
		"/v1/projects/"+escapePathSegment(projectID)+"/api-keys/"+escapePathSegment(keyID)+"/regenerate",
		nil,
	)
}

// ListProjectAudit calls GET /v1/projects/{id}/audit on the Enterprise control plane.
func (c *Client) ListProjectAudit(
	ctx context.Context,
	projectID string,
	params map[string]string,
) (*ListAuditEntriesResponse, error) {
	return controlPlaneJSON[ListAuditEntriesResponse](
		ctx,
		c,
		"ListProjectAudit",
		methodGet,
		"/v1/projects/"+escapePathSegment(projectID)+"/audit"+encodeParams(params),
		nil,
	)
}

// GetBilling calls GET /v1/projects/{id}/billing on the Enterprise control plane.
func (c *Client) GetBilling(ctx context.Context, projectID string) (*BillingResponse, error) {
	return controlPlaneJSON[BillingResponse](
		ctx,
		c,
		"GetBilling",
		methodGet,
		"/v1/projects/"+escapePathSegment(projectID)+"/billing",
		nil,
	)
}

// CreateCheckout calls POST /v1/projects/{id}/billing/checkout on the Enterprise control plane.
func (c *Client) CreateCheckout(ctx context.Context, projectID string) (*CheckoutResponse, error) {
	return controlPlaneJSON[CheckoutResponse](
		ctx,
		c,
		"CreateCheckout",
		methodPost,
		"/v1/projects/"+escapePathSegment(projectID)+"/billing/checkout",
		nil,
	)
}

// CreatePortal calls POST /v1/projects/{id}/billing/portal on the Enterprise control plane.
func (c *Client) CreatePortal(ctx context.Context, projectID string) (*PortalResponse, error) {
	return controlPlaneJSON[PortalResponse](
		ctx,
		c,
		"CreatePortal",
		methodPost,
		"/v1/projects/"+escapePathSegment(projectID)+"/billing/portal",
		nil,
	)
}

// BackendListIntegrations calls GET /v1/projects/{id}/integrations on the Enterprise control plane.
func (c *Client) BackendListIntegrations(
	ctx context.Context,
	projectID string,
	params map[string]string,
) (*ListIntegrationsResponse, error) {
	return controlPlaneJSON[ListIntegrationsResponse](
		ctx,
		c,
		"BackendListIntegrations",
		methodGet,
		"/v1/projects/"+escapePathSegment(projectID)+"/integrations"+encodeParams(params),
		nil,
	)
}

// BackendCreateIntegration calls POST /v1/projects/{id}/integrations on the Enterprise control plane.
func (c *Client) BackendCreateIntegration(
	ctx context.Context,
	projectID string,
	body BackendCreateIntegrationRequest,
) (*IntegrationResponse, error) {
	return controlPlaneJSON[IntegrationResponse](
		ctx,
		c,
		"BackendCreateIntegration",
		methodPost,
		"/v1/projects/"+escapePathSegment(projectID)+"/integrations",
		body,
	)
}

// BackendDeleteIntegration calls DELETE /v1/projects/{id}/integrations/{iid} on the Enterprise control plane.
func (c *Client) BackendDeleteIntegration(ctx context.Context, projectID string, integrationID string) error {
	return c.controlPlaneEmpty(
		ctx,
		"BackendDeleteIntegration",
		methodDelete,
		"/v1/projects/"+escapePathSegment(projectID)+"/integrations/"+escapePathSegment(integrationID),
	)
}

// BackendGetIntegration calls GET /v1/projects/{id}/integrations/{iid} on the Enterprise control plane.
func (c *Client) BackendGetIntegration(
	ctx context.Context,
	projectID string,
	integrationID string,
) (*IntegrationResponse, error) {
	return controlPlaneJSON[IntegrationResponse](
		ctx,
		c,
		"BackendGetIntegration",
		methodGet,
		"/v1/projects/"+escapePathSegment(projectID)+"/integrations/"+escapePathSegment(integrationID),
		nil,
	)
}

// OAuthConnect calls POST /v1/projects/{id}/integrations/{iid}/connect on the Enterprise control plane.
func (c *Client) OAuthConnect(
	ctx context.Context,
	projectID string,
	integrationID string,
) (*BeginConnectResponse, error) {
	return controlPlaneJSON[BeginConnectResponse](
		ctx,
		c,
		"OAuthConnect",
		methodPost,
		"/v1/projects/"+escapePathSegment(projectID)+"/integrations/"+escapePathSegment(integrationID)+"/connect",
		nil,
	)
}

// BackendDisconnectIntegration calls POST /v1/projects/{id}/integrations/{iid}/disconnect on the Enterprise control plane.
func (c *Client) BackendDisconnectIntegration(ctx context.Context, projectID string, integrationID string) error {
	return c.controlPlaneEmpty(
		ctx,
		"BackendDisconnectIntegration",
		methodPost,
		"/v1/projects/"+escapePathSegment(projectID)+"/integrations/"+escapePathSegment(integrationID)+"/disconnect",
	)
}

// BackendListIntegrationDocuments calls GET /v1/projects/{id}/integrations/{iid}/documents on the Enterprise control plane.
func (c *Client) BackendListIntegrationDocuments(
	ctx context.Context,
	projectID string,
	integrationID string,
	params map[string]string,
) (*ListDocumentsResponse, error) {
	return controlPlaneJSON[ListDocumentsResponse](
		ctx,
		c,
		"BackendListIntegrationDocuments",
		methodGet,
		"/v1/projects/"+escapePathSegment(projectID)+"/integrations/"+escapePathSegment(integrationID)+"/documents"+encodeParams(params),
		nil,
	)
}

// ListInvitations calls GET /v1/projects/{id}/invitations on the Enterprise control plane.
func (c *Client) ListInvitations(
	ctx context.Context,
	projectID string,
	params map[string]string,
) (*ListInvitationsResponse, error) {
	return controlPlaneJSON[ListInvitationsResponse](
		ctx,
		c,
		"ListInvitations",
		methodGet,
		"/v1/projects/"+escapePathSegment(projectID)+"/invitations"+encodeParams(params),
		nil,
	)
}

// InviteUser calls POST /v1/projects/{id}/invitations on the Enterprise control plane.
func (c *Client) InviteUser(
	ctx context.Context,
	projectID string,
	body CreateInvitationRequest,
) (*CreateInvitationResponse, error) {
	return controlPlaneJSON[CreateInvitationResponse](
		ctx,
		c,
		"InviteUser",
		methodPost,
		"/v1/projects/"+escapePathSegment(projectID)+"/invitations",
		body,
	)
}

// RevokeInvitation calls DELETE /v1/projects/{id}/invitations/{inv_id} on the Enterprise control plane.
func (c *Client) RevokeInvitation(ctx context.Context, projectID string, invitationID string) error {
	return c.controlPlaneEmpty(
		ctx,
		"RevokeInvitation",
		methodDelete,
		"/v1/projects/"+escapePathSegment(projectID)+"/invitations/"+escapePathSegment(invitationID),
	)
}

// LeaveProject calls POST /v1/projects/{id}/leave on the Enterprise control plane.
func (c *Client) LeaveProject(ctx context.Context, projectID string) error {
	return c.controlPlaneEmpty(ctx, "LeaveProject", methodPost, "/v1/projects/"+escapePathSegment(projectID)+"/leave")
}

// ListMembers calls GET /v1/projects/{id}/members on the Enterprise control plane.
func (c *Client) ListMembers(
	ctx context.Context,
	projectID string,
	params map[string]string,
) (*ListMembersResponse, error) {
	return controlPlaneJSON[ListMembersResponse](
		ctx,
		c,
		"ListMembers",
		methodGet,
		"/v1/projects/"+escapePathSegment(projectID)+"/members"+encodeParams(params),
		nil,
	)
}

// RemoveMember calls DELETE /v1/projects/{id}/members/{user_id} on the Enterprise control plane.
func (c *Client) RemoveMember(ctx context.Context, projectID string, userID string) error {
	return c.controlPlaneEmpty(
		ctx,
		"RemoveMember",
		methodDelete,
		"/v1/projects/"+escapePathSegment(projectID)+"/members/"+escapePathSegment(userID),
	)
}

// UpdateMemberRole calls PATCH /v1/projects/{id}/members/{user_id} on the Enterprise control plane.
func (c *Client) UpdateMemberRole(
	ctx context.Context,
	projectID string,
	userID string,
	body UpdateMemberRoleRequest,
) (*MemberResponse, error) {
	return controlPlaneJSON[MemberResponse](
		ctx,
		c,
		"UpdateMemberRole",
		methodPatch,
		"/v1/projects/"+escapePathSegment(projectID)+"/members/"+escapePathSegment(userID),
		body,
	)
}

// BackendGetRAGConfig calls GET /v1/projects/{id}/rag-config on the Enterprise control plane.
func (c *Client) BackendGetRAGConfig(ctx context.Context, projectID string) (*RagConfigResponse, error) {
	return controlPlaneJSON[RagConfigResponse](
		ctx,
		c,
		"BackendGetRAGConfig",
		methodGet,
		"/v1/projects/"+escapePathSegment(projectID)+"/rag-config",
		nil,
	)
}

// BackendSetRAGConfig calls PUT /v1/projects/{id}/rag-config on the Enterprise control plane.
func (c *Client) BackendSetRAGConfig(
	ctx context.Context,
	projectID string,
	body SetRagConfigRequest,
) (*RagConfigResponse, error) {
	return controlPlaneJSON[RagConfigResponse](
		ctx,
		c,
		"BackendSetRAGConfig",
		methodPut,
		"/v1/projects/"+escapePathSegment(projectID)+"/rag-config",
		body,
	)
}

// GetUsage calls GET /v1/projects/{id}/usage on the Enterprise control plane.
func (c *Client) GetUsage(
	ctx context.Context,
	projectID string,
	params map[string]string,
) (*BackendUsageResponse, error) {
	return controlPlaneJSON[BackendUsageResponse](
		ctx,
		c,
		"GetUsage",
		methodGet,
		"/v1/projects/"+escapePathSegment(projectID)+"/usage"+encodeParams(params),
		nil,
	)
}

// ListWebhooks calls GET /v1/projects/{id}/webhooks on the Enterprise control plane.
func (c *Client) ListWebhooks(
	ctx context.Context,
	projectID string,
	params map[string]string,
) (*ListWebhooksResponse, error) {
	return controlPlaneJSON[ListWebhooksResponse](
		ctx,
		c,
		"ListWebhooks",
		methodGet,
		"/v1/projects/"+escapePathSegment(projectID)+"/webhooks"+encodeParams(params),
		nil,
	)
}

// CreateWebhook calls POST /v1/projects/{id}/webhooks on the Enterprise control plane.
func (c *Client) CreateWebhook(
	ctx context.Context,
	projectID string,
	body CreateWebhookRequest,
) (*WebhookResponse, error) {
	return controlPlaneJSON[WebhookResponse](
		ctx,
		c,
		"CreateWebhook",
		methodPost,
		"/v1/projects/"+escapePathSegment(projectID)+"/webhooks",
		body,
	)
}

// DeleteWebhook calls DELETE /v1/projects/{id}/webhooks/{wh_id} on the Enterprise control plane.
func (c *Client) DeleteWebhook(ctx context.Context, projectID string, webhookID string) error {
	return c.controlPlaneEmpty(
		ctx,
		"DeleteWebhook",
		methodDelete,
		"/v1/projects/"+escapePathSegment(projectID)+"/webhooks/"+escapePathSegment(webhookID),
	)
}

// UpdateWebhook calls PATCH /v1/projects/{id}/webhooks/{wh_id} on the Enterprise control plane.
func (c *Client) UpdateWebhook(
	ctx context.Context,
	projectID string,
	webhookID string,
	body UpdateWebhookRequest,
) (*WebhookResponse, error) {
	return controlPlaneJSON[WebhookResponse](
		ctx,
		c,
		"UpdateWebhook",
		methodPatch,
		"/v1/projects/"+escapePathSegment(projectID)+"/webhooks/"+escapePathSegment(webhookID),
		body,
	)
}

// ListWebhookDeliveries calls GET /v1/projects/{id}/webhooks/{wh_id}/deliveries on the Enterprise control plane.
func (c *Client) ListWebhookDeliveries(
	ctx context.Context,
	projectID string,
	webhookID string,
	params map[string]string,
) (*ListWebhookDeliveriesResponse, error) {
	return controlPlaneJSON[ListWebhookDeliveriesResponse](
		ctx,
		c,
		"ListWebhookDeliveries",
		methodGet,
		"/v1/projects/"+escapePathSegment(projectID)+"/webhooks/"+escapePathSegment(webhookID)+"/deliveries"+encodeParams(params),
		nil,
	)
}

// RetryWebhookDelivery calls POST /v1/projects/{id}/webhooks/{wh_id}/deliveries/{delivery_id}/retry on the Enterprise control plane.
func (c *Client) RetryWebhookDelivery(
	ctx context.Context,
	projectID string,
	webhookID string,
	deliveryID string,
) (*RetryWebhookDeliveryResponse, error) {
	return controlPlaneJSON[RetryWebhookDeliveryResponse](
		ctx,
		c,
		"RetryWebhookDelivery",
		methodPost,
		"/v1/projects/"+escapePathSegment(projectID)+"/webhooks/"+escapePathSegment(webhookID)+"/deliveries/"+escapePathSegment(deliveryID)+"/retry",
		nil,
	)
}

// TestWebhook calls POST /v1/projects/{id}/webhooks/{wh_id}/test on the Enterprise control plane.
func (c *Client) TestWebhook(ctx context.Context, projectID string, webhookID string) (*WebhookTestResponse, error) {
	return controlPlaneJSON[WebhookTestResponse](
		ctx,
		c,
		"TestWebhook",
		methodPost,
		"/v1/projects/"+escapePathSegment(projectID)+"/webhooks/"+escapePathSegment(webhookID)+"/test",
		nil,
	)
}
