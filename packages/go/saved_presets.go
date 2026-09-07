package xberg

import (
	"context"
)

// Saved (user-authored) presets are part of the shared surface — both specs
// declare the full CRUD set — but they spell the route differently: Enterprise
// serves /v1/saved_presets with a {preset_id} parameter, Pro serves
// /v1/saved-presets with an {id} parameter. The request and response schemas
// are identical, so the methods below are written once, resolve the connected
// tier (an explicit [WithTarget], else probed from GET /healthz) and render the
// path from it rather than hardcoding either spelling.

const (
	// savedPresetsPathEnterprise is the Enterprise spelling (underscore).
	savedPresetsPathEnterprise = "/v1/saved_presets"
	// savedPresetsPathPro is the Pro spelling (hyphen).
	savedPresetsPathPro = "/v1/saved-presets"
)

// savedPresetsPath renders the saved-preset route for the given tier. An empty
// presetID yields the collection route; otherwise the ID is escaped and
// appended. Any tier other than Pro uses the Enterprise spelling, which is also
// the fallback when the probe reported nothing usable.
func savedPresetsPath(tier, presetID string) string {
	base := savedPresetsPathEnterprise
	if tier == string(TargetPro) {
		base = savedPresetsPathPro
	}
	if presetID == "" {
		return base
	}
	return base + "/" + escapePathSegment(presetID)
}

// resolveSavedPresetsPath resolves the connected tier and renders the
// saved-preset route for it.
func (c *Client) resolveSavedPresetsPath(ctx context.Context, presetID string) (string, error) {
	tier, err := c.resolveTier(ctx)
	if err != nil {
		return "", err
	}
	return savedPresetsPath(tier, presetID), nil
}

// ListSavedPresets lists the caller's saved presets (GET /v1/saved_presets on
// Enterprise, GET /v1/saved-presets on Pro, paginated). A non-positive limit or
// offset is omitted from the query string, leaving the server's default.
//
// Part of the shared surface (Enterprise + Pro).
func (c *Client) ListSavedPresets(ctx context.Context, limit, offset int) (*ListSavedPresetsResponse, error) {
	path, err := c.resolveSavedPresetsPath(ctx, "")
	if err != nil {
		return nil, err
	}
	var out ListSavedPresetsResponse
	if err := c.getJSON(ctx, path+pageQuery(limit, offset), &out); err != nil {
		return nil, err
	}
	return &out, nil
}

// CreateSavedPreset creates a saved preset (POST /v1/saved_presets on
// Enterprise, POST /v1/saved-presets on Pro).
//
// Part of the shared surface (Enterprise + Pro).
func (c *Client) CreateSavedPreset(
	ctx context.Context,
	body CreateSavedPresetRequest,
) (*CreateSavedPresetResponse, error) {
	path, err := c.resolveSavedPresetsPath(ctx, "")
	if err != nil {
		return nil, err
	}
	var out CreateSavedPresetResponse
	if err := c.callJSON(ctx, methodPost, path, body, &out); err != nil {
		return nil, err
	}
	return &out, nil
}

// GetSavedPreset fetches one saved preset (GET /v1/saved_presets/{presetID} on
// Enterprise, GET /v1/saved-presets/{presetID} on Pro).
//
// Part of the shared surface (Enterprise + Pro).
func (c *Client) GetSavedPreset(ctx context.Context, presetID string) (*SavedPresetDetail, error) {
	path, err := c.resolveSavedPresetsPath(ctx, presetID)
	if err != nil {
		return nil, err
	}
	var out SavedPresetDetail
	if err := c.getJSON(ctx, path, &out); err != nil {
		return nil, err
	}
	return &out, nil
}

// UpdateSavedPreset updates a saved preset (PATCH /v1/saved_presets/{presetID}
// on Enterprise, PATCH /v1/saved-presets/{presetID} on Pro). The body carries
// the full replacement preset, not a sparse patch.
//
// Part of the shared surface (Enterprise + Pro).
func (c *Client) UpdateSavedPreset(
	ctx context.Context,
	presetID string,
	body UpdateSavedPresetRequest,
) (*UpdateSavedPresetResponse, error) {
	path, err := c.resolveSavedPresetsPath(ctx, presetID)
	if err != nil {
		return nil, err
	}
	var out UpdateSavedPresetResponse
	if err := c.callJSON(ctx, methodPatch, path, body, &out); err != nil {
		return nil, err
	}
	return &out, nil
}

// DeleteSavedPreset deletes a saved preset (DELETE /v1/saved_presets/{presetID}
// on Enterprise, DELETE /v1/saved-presets/{presetID} on Pro). The endpoint
// answers 204 with no body.
//
// Part of the shared surface (Enterprise + Pro).
func (c *Client) DeleteSavedPreset(ctx context.Context, presetID string) error {
	path, err := c.resolveSavedPresetsPath(ctx, presetID)
	if err != nil {
		return err
	}
	return c.callJSON(ctx, methodDelete, path, nil, nil)
}
