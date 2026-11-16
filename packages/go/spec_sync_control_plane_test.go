package xberg

import (
	"context"
	"testing"
)

func TestSpecSyncControlPlaneEndpoints(t *testing.T) {
	const providerPath = "/v1/projects/project%2Fspace/saml/providers/provider%2Fspace"
	tests := []controlPlaneCase{
		{
			name: "BackendCreateRoleBoundAPIKey", method: "POST", path: "/v1/projects/project%2Fspace/api-keys/role-bound", body: true,
			call: func(ctx context.Context, c *Client) error {
				_, err := c.BackendCreateRoleBoundAPIKey(ctx, "project/space", CreateRoleBoundApiKeyRequest{Name: "reader"})
				return err
			},
		},
		{
			name: "UpdateSamlAttributeMapping", method: "PATCH", path: providerPath + "/attribute-mapping", body: true,
			call: func(ctx context.Context, c *Client) error {
				_, err := c.UpdateSamlAttributeMapping(ctx, "project/space", "provider/space", SamlAttributeMapping{})
				return err
			},
		},
		{
			name: "StartSamlConnectionTest", method: "POST", path: providerPath + "/test",
			call: func(ctx context.Context, c *Client) error {
				_, err := c.StartSamlConnectionTest(ctx, "project/space", "provider/space")
				return err
			},
		},
		{
			name: "GetSamlConnectionTestStatus", method: "GET", path: providerPath + "/test/test%2Fspace",
			call: func(ctx context.Context, c *Client) error {
				_, err := c.GetSamlConnectionTestStatus(ctx, "project/space", "provider/space", "test/space")
				return err
			},
		},
		{
			name: "RevokeScimConnection", method: "POST", path: "/v1/projects/project%2Fspace/scim/connections/connection%2Fspace/revoke",
			call: func(ctx context.Context, c *Client) error {
				_, err := c.RevokeScimConnection(ctx, "project/space", "connection/space")
				return err
			},
		},
	}
	for _, tc := range tests {
		t.Run(tc.name, func(t *testing.T) {
			tc.query = map[string]string{}
			runControlPlaneCase(t, tc)
		})
	}
}
