package xberg

import (
	"context"
	"testing"
)

func TestControlPlaneOAuthConnect(t *testing.T) {
	runControlPlaneCase(t, controlPlaneCase{
		name: "OAuthConnect", method: "POST", path: "/v1/projects/id%2F%20space/integrations/iid%2F%20space/connect",
		query: map[string]string{},
		body:  false, public: false,
		call: func(ctx context.Context, c *Client) error {
			_, err := c.OAuthConnect(ctx, "id/ space", "iid/ space")
			return err
		},
	})
}

func TestControlPlaneBackendDisconnectIntegration(t *testing.T) {
	runControlPlaneCase(t, controlPlaneCase{
		name: "BackendDisconnectIntegration", method: "POST", path: "/v1/projects/id%2F%20space/integrations/iid%2F%20space/disconnect",
		query: map[string]string{},
		body:  false, public: false,
		call: func(ctx context.Context, c *Client) error {
			return c.BackendDisconnectIntegration(ctx, "id/ space", "iid/ space")
		},
	})
}

func TestControlPlaneBackendListIntegrationDocuments(t *testing.T) {
	runControlPlaneCase(t, controlPlaneCase{
		name: "BackendListIntegrationDocuments", method: "GET", path: "/v1/projects/id%2F%20space/integrations/iid%2F%20space/documents",
		query: map[string]string{"mime_types": "query /&value", "folder_id": "query /&value", "max_results": "7"},
		body:  false, public: false,
		call: func(ctx context.Context, c *Client) error {
			_, err := c.BackendListIntegrationDocuments(ctx, "id/ space", "iid/ space", map[string]string{"mime_types": "query /&value", "folder_id": "query /&value", "max_results": "7"})
			return err
		},
	})
}

func TestControlPlaneListInvitations(t *testing.T) {
	runControlPlaneCase(t, controlPlaneCase{
		name: "ListInvitations", method: "GET", path: "/v1/projects/id%2F%20space/invitations",
		query: map[string]string{"limit": "7", "offset": "7"},
		body:  false, public: false,
		call: func(ctx context.Context, c *Client) error {
			_, err := c.ListInvitations(ctx, "id/ space", map[string]string{"limit": "7", "offset": "7"})
			return err
		},
	})
}

func TestControlPlaneInviteUser(t *testing.T) {
	runControlPlaneCase(t, controlPlaneCase{
		name: "InviteUser", method: "POST", path: "/v1/projects/id%2F%20space/invitations",
		query: map[string]string{},
		body:  true, public: false,
		call: func(ctx context.Context, c *Client) error {
			_, err := c.InviteUser(ctx, "id/ space", CreateInvitationRequest{})
			return err
		},
	})
}

func TestControlPlaneRevokeInvitation(t *testing.T) {
	runControlPlaneCase(t, controlPlaneCase{
		name: "RevokeInvitation", method: "DELETE", path: "/v1/projects/id%2F%20space/invitations/inv_id%2F%20space",
		query: map[string]string{},
		body:  false, public: false,
		call: func(ctx context.Context, c *Client) error {
			return c.RevokeInvitation(ctx, "id/ space", "inv_id/ space")
		},
	})
}

func TestControlPlaneLeaveProject(t *testing.T) {
	runControlPlaneCase(t, controlPlaneCase{
		name: "LeaveProject", method: "POST", path: "/v1/projects/id%2F%20space/leave",
		query: map[string]string{},
		body:  false, public: false,
		call: func(ctx context.Context, c *Client) error { return c.LeaveProject(ctx, "id/ space") },
	})
}

func TestControlPlaneListMembers(t *testing.T) {
	runControlPlaneCase(t, controlPlaneCase{
		name: "ListMembers", method: "GET", path: "/v1/projects/id%2F%20space/members",
		query: map[string]string{"limit": "7", "offset": "7"},
		body:  false, public: false,
		call: func(ctx context.Context, c *Client) error {
			_, err := c.ListMembers(ctx, "id/ space", map[string]string{"limit": "7", "offset": "7"})
			return err
		},
	})
}
