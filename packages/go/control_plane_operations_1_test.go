package xberg

import (
	"context"
	"testing"
)

func TestControlPlaneDeleteProject(t *testing.T) {
	runControlPlaneCase(t, controlPlaneCase{
		name: "DeleteProject", method: "DELETE", path: "/v1/projects/id%2F%20space",
		query: map[string]string{"erase": "false"},
		body:  false, public: false,
		call: func(ctx context.Context, c *Client) error {
			return c.DeleteProject(ctx, "id/ space", map[string]string{"erase": "false"})
		},
	})
}

func TestControlPlaneGetProject(t *testing.T) {
	runControlPlaneCase(t, controlPlaneCase{
		name: "GetProject", method: "GET", path: "/v1/projects/id%2F%20space",
		query: map[string]string{},
		body:  false, public: false,
		call: func(ctx context.Context, c *Client) error { _, err := c.GetProject(ctx, "id/ space"); return err },
	})
}

func TestControlPlaneUpdateProject(t *testing.T) {
	runControlPlaneCase(t, controlPlaneCase{
		name: "UpdateProject", method: "PATCH", path: "/v1/projects/id%2F%20space",
		query: map[string]string{},
		body:  true, public: false,
		call: func(ctx context.Context, c *Client) error {
			_, err := c.UpdateProject(ctx, "id/ space", UpdateProjectRequest{})
			return err
		},
	})
}

func TestControlPlaneGetAnalytics(t *testing.T) {
	runControlPlaneCase(t, controlPlaneCase{
		name: "GetAnalytics", method: "GET", path: "/v1/projects/id%2F%20space/analytics",
		query: map[string]string{"start_date": "query /&value", "end_date": "query /&value"},
		body:  false, public: false,
		call: func(ctx context.Context, c *Client) error {
			_, err := c.GetAnalytics(ctx, "id/ space", map[string]string{"start_date": "query /&value", "end_date": "query /&value"})
			return err
		},
	})
}

func TestControlPlaneBackendListAPIKeys(t *testing.T) {
	runControlPlaneCase(t, controlPlaneCase{
		name: "BackendListAPIKeys", method: "GET", path: "/v1/projects/id%2F%20space/api-keys",
		query: map[string]string{"limit": "7", "offset": "7"},
		body:  false, public: false,
		call: func(ctx context.Context, c *Client) error {
			_, err := c.BackendListAPIKeys(ctx, "id/ space", map[string]string{"limit": "7", "offset": "7"})
			return err
		},
	})
}

func TestControlPlaneBackendCreateAPIKey(t *testing.T) {
	runControlPlaneCase(t, controlPlaneCase{
		name: "BackendCreateAPIKey", method: "POST", path: "/v1/projects/id%2F%20space/api-keys",
		query: map[string]string{},
		body:  true, public: false,
		call: func(ctx context.Context, c *Client) error {
			_, err := c.BackendCreateAPIKey(ctx, "id/ space", CreateApiKeyRequest{})
			return err
		},
	})
}

func TestControlPlaneBackendRevokeAPIKey(t *testing.T) {
	runControlPlaneCase(t, controlPlaneCase{
		name: "BackendRevokeAPIKey", method: "DELETE", path: "/v1/projects/id%2F%20space/api-keys/key_id%2F%20space",
		query: map[string]string{},
		body:  false, public: false,
		call: func(ctx context.Context, c *Client) error {
			return c.BackendRevokeAPIKey(ctx, "id/ space", "key_id/ space")
		},
	})
}

func TestControlPlaneRegenerateAPIKey(t *testing.T) {
	runControlPlaneCase(t, controlPlaneCase{
		name: "RegenerateAPIKey", method: "POST", path: "/v1/projects/id%2F%20space/api-keys/key_id%2F%20space/regenerate",
		query: map[string]string{},
		body:  false, public: false,
		call: func(ctx context.Context, c *Client) error {
			_, err := c.RegenerateAPIKey(ctx, "id/ space", "key_id/ space")
			return err
		},
	})
}
