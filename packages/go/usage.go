package xberg

import (
	"context"
	"encoding/json"
)

// Usage fetches aggregate extraction usage for a date range (GET /v1/usage).
// params carries the optional "start"/"end" ISO-8601 dates and is passed
// through verbatim; both specs default the window to the current month when
// they are omitted. Both tiers answer with the same UsageResponse schema, so
// the method is not tier-gated.
//
// Part of the shared surface (Enterprise + Pro).
func (c *Client) Usage(ctx context.Context, params map[string]string) (json.RawMessage, error) {
	return c.rawGet(ctx, "/v1/usage"+encodeParams(params))
}
