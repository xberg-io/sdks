package kreuzbergcloud

import (
	"context"
	"fmt"
)

// CreateSandboxKey requests a short-lived anonymous API key from the public
// sandbox endpoint. No prior authentication is required — the API rate-limits
// by IP and rejects abusive callers with 429.
func (c *Client) CreateSandboxKey(ctx context.Context) (*SandboxKey, error) {
	var key SandboxKey
	spec := requestSpec{method: "POST", path: "/v1/sandbox/key"}
	if err := c.doJSON(ctx, spec, &key); err != nil {
		return nil, err
	}
	if key.APIKey == "" {
		return nil, fmt.Errorf("kreuzberg-cloud: sandbox key endpoint returned empty api_key")
	}
	return &key, nil
}

// FromSandbox is a zero-friction constructor: it builds an anonymous client,
// calls [Client.CreateSandboxKey], and returns a new client preconfigured
// with the resulting API key. Use it for documentation snippets, demo apps,
// and getting-started guides — the issued key is rate-limited and not
// suitable for production.
//
// Caller-supplied options are applied to both the provisioning client and the
// final client, so WithBaseURL / WithHTTPClient / WithTimeout flow through.
func FromSandbox(ctx context.Context, opts ...Option) (*Client, error) {
	provisioning, err := New(opts...)
	if err != nil {
		return nil, err
	}
	key, err := provisioning.CreateSandboxKey(ctx)
	if err != nil {
		return nil, err
	}
	finalOpts := append([]Option{}, opts...)
	finalOpts = append(finalOpts, WithAPIKey(key.APIKey))
	return New(finalOpts...)
}
