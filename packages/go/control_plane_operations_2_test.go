package xberg

import (
	"context"
	"testing"
)

func TestControlPlaneListProjectAudit(t *testing.T) {
	runControlPlaneCase(t, controlPlaneCase{
		name: "ListProjectAudit", method: "GET", path: "/v1/projects/id%2F%20space/audit",
		query: map[string]string{"action": "query /&value", "limit": "7", "offset": "7"},
		body:  false, public: false,
		call: func(ctx context.Context, c *Client) error {
			_, err := c.ListProjectAudit(ctx, "id/ space", map[string]string{"action": "query /&value", "limit": "7", "offset": "7"})
			return err
		},
	})
}

func TestControlPlaneGetBilling(t *testing.T) {
	runControlPlaneCase(t, controlPlaneCase{
		name: "GetBilling", method: "GET", path: "/v1/projects/id%2F%20space/billing",
		query: map[string]string{},
		body:  false, public: false,
		call: func(ctx context.Context, c *Client) error { _, err := c.GetBilling(ctx, "id/ space"); return err },
	})
}

func TestControlPlaneCreateCheckout(t *testing.T) {
	runControlPlaneCase(t, controlPlaneCase{
		name: "CreateCheckout", method: "POST", path: "/v1/projects/id%2F%20space/billing/checkout",
		query: map[string]string{},
		body:  false, public: false,
		call: func(ctx context.Context, c *Client) error { _, err := c.CreateCheckout(ctx, "id/ space"); return err },
	})
}

func TestControlPlaneCreatePortal(t *testing.T) {
	runControlPlaneCase(t, controlPlaneCase{
		name: "CreatePortal", method: "POST", path: "/v1/projects/id%2F%20space/billing/portal",
		query: map[string]string{},
		body:  false, public: false,
		call: func(ctx context.Context, c *Client) error { _, err := c.CreatePortal(ctx, "id/ space"); return err },
	})
}

func TestControlPlaneBackendListIntegrations(t *testing.T) {
	runControlPlaneCase(t, controlPlaneCase{
		name: "BackendListIntegrations", method: "GET", path: "/v1/projects/id%2F%20space/integrations",
		query: map[string]string{"limit": "7", "offset": "7"},
		body:  false, public: false,
		call: func(ctx context.Context, c *Client) error {
			_, err := c.BackendListIntegrations(ctx, "id/ space", map[string]string{"limit": "7", "offset": "7"})
			return err
		},
	})
}

func TestControlPlaneBackendCreateIntegration(t *testing.T) {
	runControlPlaneCase(t, controlPlaneCase{
		name: "BackendCreateIntegration", method: "POST", path: "/v1/projects/id%2F%20space/integrations",
		query: map[string]string{},
		body:  true, public: false,
		call: func(ctx context.Context, c *Client) error {
			_, err := c.BackendCreateIntegration(ctx, "id/ space", BackendCreateIntegrationRequest{})
			return err
		},
	})
}

func TestControlPlaneBackendDeleteIntegration(t *testing.T) {
	runControlPlaneCase(t, controlPlaneCase{
		name: "BackendDeleteIntegration", method: "DELETE", path: "/v1/projects/id%2F%20space/integrations/iid%2F%20space",
		query: map[string]string{},
		body:  false, public: false,
		call: func(ctx context.Context, c *Client) error {
			return c.BackendDeleteIntegration(ctx, "id/ space", "iid/ space")
		},
	})
}

func TestControlPlaneBackendGetIntegration(t *testing.T) {
	runControlPlaneCase(t, controlPlaneCase{
		name: "BackendGetIntegration", method: "GET", path: "/v1/projects/id%2F%20space/integrations/iid%2F%20space",
		query: map[string]string{},
		body:  false, public: false,
		call: func(ctx context.Context, c *Client) error {
			_, err := c.BackendGetIntegration(ctx, "id/ space", "iid/ space")
			return err
		},
	})
}
