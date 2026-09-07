package xberg

import (
	"context"
	"testing"
)

func TestControlPlaneRemoveMember(t *testing.T) {
	runControlPlaneCase(t, controlPlaneCase{
		name: "RemoveMember", method: "DELETE", path: "/v1/projects/id%2F%20space/members/user_id%2F%20space",
		query: map[string]string{},
		body:  false, public: false,
		call: func(ctx context.Context, c *Client) error { return c.RemoveMember(ctx, "id/ space", "user_id/ space") },
	})
}

func TestControlPlaneUpdateMemberRole(t *testing.T) {
	runControlPlaneCase(t, controlPlaneCase{
		name: "UpdateMemberRole", method: "PATCH", path: "/v1/projects/id%2F%20space/members/user_id%2F%20space",
		query: map[string]string{},
		body:  true, public: false,
		call: func(ctx context.Context, c *Client) error {
			_, err := c.UpdateMemberRole(ctx, "id/ space", "user_id/ space", UpdateMemberRoleRequest{})
			return err
		},
	})
}

func TestControlPlaneBackendGetRAGConfig(t *testing.T) {
	runControlPlaneCase(t, controlPlaneCase{
		name: "BackendGetRAGConfig", method: "GET", path: "/v1/projects/id%2F%20space/rag-config",
		query: map[string]string{},
		body:  false, public: false,
		call: func(ctx context.Context, c *Client) error {
			_, err := c.BackendGetRAGConfig(ctx, "id/ space")
			return err
		},
	})
}

func TestControlPlaneBackendSetRAGConfig(t *testing.T) {
	runControlPlaneCase(t, controlPlaneCase{
		name: "BackendSetRAGConfig", method: "PUT", path: "/v1/projects/id%2F%20space/rag-config",
		query: map[string]string{},
		body:  true, public: false,
		call: func(ctx context.Context, c *Client) error {
			_, err := c.BackendSetRAGConfig(ctx, "id/ space", SetRagConfigRequest{})
			return err
		},
	})
}

func TestControlPlaneGetUsage(t *testing.T) {
	runControlPlaneCase(t, controlPlaneCase{
		name: "GetUsage", method: "GET", path: "/v1/projects/id%2F%20space/usage",
		query: map[string]string{"start_date": "query /&value", "end_date": "query /&value"},
		body:  false, public: false,
		call: func(ctx context.Context, c *Client) error {
			_, err := c.GetUsage(ctx, "id/ space", map[string]string{"start_date": "query /&value", "end_date": "query /&value"})
			return err
		},
	})
}

func TestControlPlaneListWebhooks(t *testing.T) {
	runControlPlaneCase(t, controlPlaneCase{
		name: "ListWebhooks", method: "GET", path: "/v1/projects/id%2F%20space/webhooks",
		query: map[string]string{"limit": "7", "offset": "7"},
		body:  false, public: false,
		call: func(ctx context.Context, c *Client) error {
			_, err := c.ListWebhooks(ctx, "id/ space", map[string]string{"limit": "7", "offset": "7"})
			return err
		},
	})
}

func TestControlPlaneCreateWebhook(t *testing.T) {
	runControlPlaneCase(t, controlPlaneCase{
		name: "CreateWebhook", method: "POST", path: "/v1/projects/id%2F%20space/webhooks",
		query: map[string]string{},
		body:  true, public: false,
		call: func(ctx context.Context, c *Client) error {
			_, err := c.CreateWebhook(ctx, "id/ space", CreateWebhookRequest{})
			return err
		},
	})
}

func TestControlPlaneDeleteWebhook(t *testing.T) {
	runControlPlaneCase(t, controlPlaneCase{
		name: "DeleteWebhook", method: "DELETE", path: "/v1/projects/id%2F%20space/webhooks/wh_id%2F%20space",
		query: map[string]string{},
		body:  false, public: false,
		call: func(ctx context.Context, c *Client) error { return c.DeleteWebhook(ctx, "id/ space", "wh_id/ space") },
	})
}
