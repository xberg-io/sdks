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
	return c.enterpriseGet(ctx, documentPath(documentID, ""))
}

// Versions lists a document's versions (GET /v1/documents/{id}/versions).
// Enterprise only.
func (c *Client) Versions(ctx context.Context, documentID string) (json.RawMessage, error) {
	if err := c.requireTier(ctx, TargetEnterprise, "Versions"); err != nil {
		return nil, err
	}
	return c.enterpriseGet(ctx, documentPath(documentID, "/versions"))
}

// Diff diffs document versions (GET /v1/documents/{id}/diff). Query parameters
// (e.g. "from", "to") are passed through verbatim. Enterprise only.
func (c *Client) Diff(ctx context.Context, documentID string, params map[string]string) (json.RawMessage, error) {
	if err := c.requireTier(ctx, TargetEnterprise, "Diff"); err != nil {
		return nil, err
	}
	return c.enterpriseGet(ctx, documentPath(documentID, "/diff")+encodeParams(params))
}

// GetDiffJob polls a diff job (GET /v1/documents/{id}/diff/{diffJobID}).
// Enterprise only.
func (c *Client) GetDiffJob(ctx context.Context, documentID, diffJobID string) (json.RawMessage, error) {
	if err := c.requireTier(ctx, TargetEnterprise, "GetDiffJob"); err != nil {
		return nil, err
	}
	return c.enterpriseGet(ctx, documentPath(documentID, "/diff/"+escapePathSegment(diffJobID)))
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

// SubmitEnrich submits text for asynchronous enrichment (POST /v1/enrich) and
// returns the queued job's ID. Poll it with [Client.GetEnrichStatus].
// Enterprise only.
func (c *Client) SubmitEnrich(ctx context.Context, body EnrichTextRequest) (*EnrichJobSubmitted, error) {
	if err := c.requireTier(ctx, TargetEnterprise, "SubmitEnrich"); err != nil {
		return nil, err
	}
	var out EnrichJobSubmitted
	if err := c.callJSON(ctx, methodPost, "/v1/enrich", body, &out); err != nil {
		return nil, err
	}
	return &out, nil
}

// GetEnrichStatus polls an enrichment job (GET /v1/enrich/{jobID}). The
// returned union carries the result once the job completes, or the failure
// message when it failed — discriminate with its AsEnrichJobStatus* methods.
// Enterprise only.
func (c *Client) GetEnrichStatus(ctx context.Context, jobID string) (*EnrichJobStatus, error) {
	if err := c.requireTier(ctx, TargetEnterprise, "GetEnrichStatus"); err != nil {
		return nil, err
	}
	var out EnrichJobStatus
	if err := c.getJSON(ctx, "/v1/enrich/"+escapePathSegment(jobID), &out); err != nil {
		return nil, err
	}
	return &out, nil
}

// PresignUpload requests a presigned upload URL (POST /v1/uploads/presign).
// Enterprise only.
func (c *Client) PresignUpload(ctx context.Context, body any) (json.RawMessage, error) {
	if err := c.requireTier(ctx, TargetEnterprise, "PresignUpload"); err != nil {
		return nil, err
	}
	return c.enterpriseSend(ctx, methodPost, "/v1/uploads/presign", body)
}

// ConfirmUpload confirms a presigned upload (POST /v1/uploads/confirm).
// Enterprise only.
func (c *Client) ConfirmUpload(ctx context.Context, body any) (json.RawMessage, error) {
	if err := c.requireTier(ctx, TargetEnterprise, "ConfirmUpload"); err != nil {
		return nil, err
	}
	return c.enterpriseSend(ctx, methodPost, "/v1/uploads/confirm", body)
}

// Usage fetches usage/metering data (GET /v1/usage). Query parameters are
// passed through verbatim. Enterprise only.
func (c *Client) Usage(ctx context.Context, params map[string]string) (json.RawMessage, error) {
	if err := c.requireTier(ctx, TargetEnterprise, "Usage"); err != nil {
		return nil, err
	}
	return c.enterpriseGet(ctx, "/v1/usage"+encodeParams(params))
}

func (c *Client) enterpriseGet(ctx context.Context, path string) (json.RawMessage, error) {
	var out json.RawMessage
	if err := c.getJSON(ctx, path, &out); err != nil {
		return nil, err
	}
	return out, nil
}

func (c *Client) enterpriseSend(ctx context.Context, method, path string, body any) (json.RawMessage, error) {
	var out json.RawMessage
	if err := c.callJSON(ctx, method, path, body, &out); err != nil {
		return nil, err
	}
	return out, nil
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
