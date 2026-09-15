package xberg

import (
	"context"
)

// Saved (user-authored) presets are part of the shared surface: both specs
// declare the full CRUD set at the same route, with identical request and
// response schemas, so the methods below are written once and are not
// tier-gated.

// savedPresetsPath is the saved-preset collection route, served by both tiers.
const savedPresetsPath = "/v1/saved_presets"

// savedPresetPath renders a preset-scoped route, escaping the preset ID.
func savedPresetPath(presetID string) string {
	return savedPresetsPath + "/" + escapePathSegment(presetID)
}

// ListSavedPresets lists the caller's saved presets (GET /v1/saved_presets,
// paginated). A non-positive limit or offset is omitted from the query string,
// leaving the server's default.
//
// Part of the shared surface (Enterprise + Pro).
func (c *Client) ListSavedPresets(ctx context.Context, limit, offset int) (*ListSavedPresetsResponse, error) {
	var out ListSavedPresetsResponse
	if err := c.getJSON(ctx, savedPresetsPath+pageQuery(limit, offset), &out); err != nil {
		return nil, err
	}
	return &out, nil
}

// CreateSavedPreset creates a saved preset (POST /v1/saved_presets).
//
// Part of the shared surface (Enterprise + Pro).
func (c *Client) CreateSavedPreset(
	ctx context.Context,
	body CreateSavedPresetRequest,
) (*CreateSavedPresetResponse, error) {
	var out CreateSavedPresetResponse
	if err := c.callJSON(ctx, methodPost, savedPresetsPath, body, &out); err != nil {
		return nil, err
	}
	return &out, nil
}

// GetSavedPreset fetches one saved preset (GET /v1/saved_presets/{presetID}).
//
// Part of the shared surface (Enterprise + Pro).
func (c *Client) GetSavedPreset(ctx context.Context, presetID string) (*SavedPresetDetail, error) {
	var out SavedPresetDetail
	if err := c.getJSON(ctx, savedPresetPath(presetID), &out); err != nil {
		return nil, err
	}
	return &out, nil
}

// UpdateSavedPreset updates a saved preset (PATCH /v1/saved_presets/{presetID}).
// The body carries the full replacement preset, not a sparse patch.
//
// Part of the shared surface (Enterprise + Pro).
func (c *Client) UpdateSavedPreset(
	ctx context.Context,
	presetID string,
	body UpdateSavedPresetRequest,
) (*UpdateSavedPresetResponse, error) {
	var out UpdateSavedPresetResponse
	if err := c.callJSON(ctx, methodPatch, savedPresetPath(presetID), body, &out); err != nil {
		return nil, err
	}
	return &out, nil
}

// DeleteSavedPreset deletes a saved preset (DELETE /v1/saved_presets/{presetID}).
// The endpoint answers 204 with no body.
//
// Part of the shared surface (Enterprise + Pro).
func (c *Client) DeleteSavedPreset(ctx context.Context, presetID string) error {
	return c.callJSON(ctx, methodDelete, savedPresetPath(presetID), nil, nil)
}
