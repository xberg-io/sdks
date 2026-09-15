package xberg

import (
	"context"
	"encoding/json"
	"net/url"
	"strconv"
)

// This file holds the Enterprise-only surface. Every method is capability-gated
// against the Enterprise tier (an explicit [WithTarget], or probed from GET
// /healthz), returning a [TierError] rather than a request that would 404 on
// Pro. Endpoints whose spec response is an inline (untyped) schema return
// [json.RawMessage] so callers decode against whichever server version they
// target; the rest use the generated models.

// documentsPath is the root of the Enterprise document-history surface
// (versions, diffs and the latest stored extraction result).
const documentsPath = "/v1/documents"

// documentPath renders a document-scoped route, escaping the document ID.
// suffix is appended verbatim and must already start with "/" when non-empty.
func documentPath(documentID, suffix string) string {
	return documentsPath + "/" + escapePathSegment(documentID) + suffix
}

// GetDocument fetches a document's latest version together with its extraction
// result (GET /v1/documents/{documentID}). The spec declares an inline,
// unnamed response schema, so the body is returned undecoded. Enterprise only.
func (c *Client) GetDocument(ctx context.Context, documentID string) (json.RawMessage, error) {
	if err := c.requireTier(ctx, TargetEnterprise, "GetDocument"); err != nil {
		return nil, err
	}
	return c.rawGet(ctx, documentPath(documentID, ""))
}

// Versions lists a document's versions (GET /v1/documents/{id}/versions).
// Enterprise only.
func (c *Client) Versions(ctx context.Context, documentID string) (json.RawMessage, error) {
	if err := c.requireTier(ctx, TargetEnterprise, "Versions"); err != nil {
		return nil, err
	}
	return c.rawGet(ctx, documentPath(documentID, "/versions"))
}

// Diff diffs document versions (GET /v1/documents/{id}/diff). Query parameters
// (e.g. "from", "to") are passed through verbatim. Enterprise only.
func (c *Client) Diff(ctx context.Context, documentID string, params map[string]string) (json.RawMessage, error) {
	if err := c.requireTier(ctx, TargetEnterprise, "Diff"); err != nil {
		return nil, err
	}
	return c.rawGet(ctx, documentPath(documentID, "/diff")+encodeParams(params))
}

// GetDiffJob polls a diff job (GET /v1/documents/{id}/diff/{diffJobID}).
// Enterprise only.
func (c *Client) GetDiffJob(ctx context.Context, documentID, diffJobID string) (json.RawMessage, error) {
	if err := c.requireTier(ctx, TargetEnterprise, "GetDiffJob"); err != nil {
		return nil, err
	}
	return c.rawGet(ctx, documentPath(documentID, "/diff/"+escapePathSegment(diffJobID)))
}

// ListExtractionEvents lists the project's extraction events
// (GET /v1/extractions). A non-positive days, limit or offset is omitted from
// the query string, leaving the server's default. Enterprise only.
func (c *Client) ListExtractionEvents(
	ctx context.Context,
	days, limit, offset int,
) (*ListExtractionEventsResponse, error) {
	if err := c.requireTier(ctx, TargetEnterprise, "ListExtractionEvents"); err != nil {
		return nil, err
	}
	query := pageValues(limit, offset)
	if days > 0 {
		query.Set("days", strconv.Itoa(days))
	}
	path := "/v1/extractions" + querySuffix(query)
	var out ListExtractionEventsResponse
	if err := c.getJSON(ctx, path, &out); err != nil {
		return nil, err
	}
	return &out, nil
}

// webhookDeliveriesPath renders a subscription's delivery collection route on
// the data plane, escaping the webhook ID.
func webhookDeliveriesPath(webhookID string) string {
	return "/v1/webhooks/" + escapePathSegment(webhookID) + "/deliveries"
}

// ListSubscriptionDeliveries lists a webhook subscription's delivery attempts
// (GET /v1/webhooks/{webhookID}/deliveries, paginated). Attempt metadata only,
// without payload previews — call [Client.GetSubscriptionDelivery] for those.
// A non-positive limit or offset is omitted from the query string, leaving the
// server's default. Enterprise only.
//
// ~keep Distinct from [Client.ListWebhookDeliveries], which reads the same
// history through the control plane's project-scoped route.
func (c *Client) ListSubscriptionDeliveries(
	ctx context.Context,
	webhookID string,
	limit, offset int,
) (*ListWebhookDeliveriesResponse, error) {
	if err := c.requireTier(ctx, TargetEnterprise, "ListSubscriptionDeliveries"); err != nil {
		return nil, err
	}
	var out ListWebhookDeliveriesResponse
	if err := c.getJSON(ctx, webhookDeliveriesPath(webhookID)+pageQuery(limit, offset), &out); err != nil {
		return nil, err
	}
	return &out, nil
}

// GetSubscriptionDelivery fetches one delivery attempt with its bounded request
// and response previews
// (GET /v1/webhooks/{webhookID}/deliveries/{deliveryID}). The previews are
// truncated by the server, which flags which ones are incomplete, and can carry
// project document content. Enterprise only.
func (c *Client) GetSubscriptionDelivery(
	ctx context.Context,
	webhookID, deliveryID string,
) (*WebhookDeliveryDetailResponse, error) {
	if err := c.requireTier(ctx, TargetEnterprise, "GetSubscriptionDelivery"); err != nil {
		return nil, err
	}
	path := webhookDeliveriesPath(webhookID) + "/" + escapePathSegment(deliveryID)
	var out WebhookDeliveryDetailResponse
	if err := c.getJSON(ctx, path, &out); err != nil {
		return nil, err
	}
	return &out, nil
}

// encodeParams renders a sorted "?k=v" query suffix, or "" when params is empty.
func encodeParams(params map[string]string) string {
	if len(params) == 0 {
		return ""
	}
	q := url.Values{}
	for k, v := range params {
		q.Set(k, v)
	}
	return "?" + q.Encode()
}
