package xberg

import (
	"context"
)

// Asynchronous text enrichment is part of the shared surface: both specs
// declare `/v1/enrich` and `/v1/enrich/{job_id}` with the same request body and
// the same response schemas, so neither method below is tier-gated. The specs
// differ only in optional scoping — Pro accepts an extra optional `project_id`
// query parameter — which the client does not send on either tier.

// enrichPath is the enrichment submission route, served by both tiers.
const enrichPath = "/v1/enrich"

// SubmitEnrich submits text for asynchronous enrichment (POST /v1/enrich) and
// returns the queued job's ID. Poll it with [Client.GetEnrichStatus].
//
// Part of the shared surface (Enterprise + Pro).
func (c *Client) SubmitEnrich(ctx context.Context, body EnrichTextRequest) (*EnrichJobSubmitted, error) {
	var out EnrichJobSubmitted
	if err := c.callJSON(ctx, methodPost, enrichPath, body, &out); err != nil {
		return nil, err
	}
	return &out, nil
}

// GetEnrichStatus polls an enrichment job (GET /v1/enrich/{jobID}). The
// returned union carries the result once the job completes, or the failure
// message when it failed — discriminate with its AsEnrichJobStatus* methods.
//
// Part of the shared surface (Enterprise + Pro).
func (c *Client) GetEnrichStatus(ctx context.Context, jobID string) (*EnrichJobStatus, error) {
	var out EnrichJobStatus
	if err := c.getJSON(ctx, enrichPath+"/"+escapePathSegment(jobID), &out); err != nil {
		return nil, err
	}
	return &out, nil
}
