package xberg

import (
	"context"
	"testing"
)

func TestControlPlaneUpdateWebhook(t *testing.T) {
	runControlPlaneCase(t, controlPlaneCase{
		name: "UpdateWebhook", method: "PATCH", path: "/v1/projects/id%2F%20space/webhooks/wh_id%2F%20space",
		query: map[string]string{},
		body:  true, public: false,
		call: func(ctx context.Context, c *Client) error {
			_, err := c.UpdateWebhook(ctx, "id/ space", "wh_id/ space", UpdateWebhookRequest{})
			return err
		},
	})
}

func TestControlPlaneListWebhookDeliveries(t *testing.T) {
	runControlPlaneCase(t, controlPlaneCase{
		name: "ListWebhookDeliveries", method: "GET", path: "/v1/projects/id%2F%20space/webhooks/wh_id%2F%20space/deliveries",
		query: map[string]string{"limit": "7", "offset": "7"},
		body:  false, public: false,
		call: func(ctx context.Context, c *Client) error {
			_, err := c.ListWebhookDeliveries(ctx, "id/ space", "wh_id/ space", map[string]string{"limit": "7", "offset": "7"})
			return err
		},
	})
}

func TestControlPlaneRetryWebhookDelivery(t *testing.T) {
	runControlPlaneCase(t, controlPlaneCase{
		name: "RetryWebhookDelivery", method: "POST", path: "/v1/projects/id%2F%20space/webhooks/wh_id%2F%20space/deliveries/delivery_id%2F%20space/retry",
		query: map[string]string{},
		body:  false, public: false,
		call: func(ctx context.Context, c *Client) error {
			_, err := c.RetryWebhookDelivery(ctx, "id/ space", "wh_id/ space", "delivery_id/ space")
			return err
		},
	})
}

func TestControlPlaneTestWebhook(t *testing.T) {
	runControlPlaneCase(t, controlPlaneCase{
		name: "TestWebhook", method: "POST", path: "/v1/projects/id%2F%20space/webhooks/wh_id%2F%20space/test",
		query: map[string]string{},
		body:  false, public: false,
		call: func(ctx context.Context, c *Client) error {
			_, err := c.TestWebhook(ctx, "id/ space", "wh_id/ space")
			return err
		},
	})
}
