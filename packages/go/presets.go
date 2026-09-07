package xberg

import (
	"context"
)

// The curated preset registry is part of the shared surface: `GET /v1/presets`,
// `GET /v1/presets/{id}` and `GET /v1/presets/{id}/sample/{name}` are declared
// by both the Enterprise and the Pro spec, so none of these methods is
// tier-gated. Saved (user-authored) presets are a separate surface, also shared
// but with a per-tier route spelling — see saved_presets.go.

const presetsPath = "/v1/presets"

// Presets lists the curated, read-only managed presets (GET /v1/presets).
//
// Part of the shared surface (Enterprise + Pro).
func (c *Client) Presets(ctx context.Context) ([]PresetSummary, error) {
	var out []PresetSummary
	if err := c.getJSON(ctx, presetsPath, &out); err != nil {
		return nil, err
	}
	return out, nil
}

// GetPreset fetches the full detail of a managed preset
// (GET /v1/presets/{id}).
//
// Part of the shared surface (Enterprise + Pro).
func (c *Client) GetPreset(ctx context.Context, presetID string) (*PresetDetail, error) {
	var out PresetDetail
	if err := c.getJSON(ctx, presetsPath+"/"+escapePathSegment(presetID), &out); err != nil {
		return nil, err
	}
	return &out, nil
}

// GetPresetSample downloads the raw bytes of a preset's bundled sample file
// (GET /v1/presets/{id}/sample/{name}). The endpoint serves the sample's own
// media type — a sample input document or the reference output JSON — so the
// body is returned undecoded. The names to pass come from
// [PresetDetail.Sample].
//
// Part of the shared surface (Enterprise + Pro).
func (c *Client) GetPresetSample(ctx context.Context, presetID, name string) ([]byte, error) {
	path := presetsPath + "/" + escapePathSegment(presetID) + "/sample/" + escapePathSegment(name)
	return c.getBytes(ctx, path)
}
