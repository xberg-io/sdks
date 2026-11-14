package xberg

import "context"

// GetProjectExtractionConfig reads a project's stored extraction defaults. Enterprise only.
func (c *Client) GetProjectExtractionConfig(ctx context.Context, projectID string) (*ProjectExtractionConfigResponse, error) {
	var out ProjectExtractionConfigResponse
	if err := c.projectExtractionConfig(ctx, "GetProjectExtractionConfig", methodGet, projectID, nil, &out); err != nil {
		return nil, err
	}
	return &out, nil
}

// SetProjectExtractionConfig replaces a project's stored extraction defaults. Enterprise only.
func (c *Client) SetProjectExtractionConfig(
	ctx context.Context, projectID string, body ExtractionConfig,
) (*ProjectExtractionConfigResponse, error) {
	var out ProjectExtractionConfigResponse
	if err := c.projectExtractionConfig(ctx, "SetProjectExtractionConfig", methodPut, projectID, body, &out); err != nil {
		return nil, err
	}
	return &out, nil
}

// ClearProjectExtractionConfig clears a project's stored extraction defaults. Enterprise only.
func (c *Client) ClearProjectExtractionConfig(ctx context.Context, projectID string) error {
	return c.projectExtractionConfig(ctx, "ClearProjectExtractionConfig", methodDelete, projectID, nil, nil)
}

func (c *Client) projectExtractionConfig(ctx context.Context, operation, method, projectID string, body, out any) error {
	if err := c.requireTier(ctx, TargetEnterprise, operation); err != nil {
		return err
	}
	spec, err := withJSONBody(requestSpec{
		method: method, path: projectPath(projectID, "/extraction-config"), projectID: projectID,
	}, body)
	if err != nil {
		return err
	}
	return c.doJSON(ctx, spec, out)
}
