package xberg

import (
	"context"
	"net/http"
)

type controlPlaneAuth string

const (
	controlPlaneAuthenticated controlPlaneAuth = "authenticated"
	controlPlanePublic        controlPlaneAuth = "public"
)

func (c *Client) controlPlaneClient(ctx context.Context, operation string, auth controlPlaneAuth) (*Client, error) {
	if err := c.requireTier(ctx, TargetEnterprise, operation); err != nil {
		return nil, err
	}
	// ~keep Copy configuration only: a Client contains live mutexes and cannot be shallow-copied.
	config := c.cfg
	httpClient := *config.httpClient
	httpClient.CheckRedirect = func(_ *http.Request, _ []*http.Request) error { return http.ErrUseLastResponse }
	config.httpClient = &httpClient
	config.baseURL = config.controlPlaneBaseURL
	if config.controlPlaneToken != nil {
		config.apiKey = *config.controlPlaneToken
	}
	if auth == controlPlanePublic {
		config.apiKey = ""
		config.httpClient.Jar = nil
	}
	return &Client{cfg: config}, nil
}

func controlPlaneJSON[T any](ctx context.Context, c *Client, operation, method, path string, body any) (*T, error) {
	auth := controlPlaneAuthenticated
	switch operation {
	case "GetAuthConfig", "BackendLogin", "Healthz", "Readyz":
		auth = controlPlanePublic
	}
	transport, err := c.controlPlaneClient(ctx, operation, auth)
	if err != nil {
		return nil, err
	}
	var out T
	if err := transport.callJSON(ctx, method, path, body, &out); err != nil {
		return nil, err
	}
	return &out, nil
}

func (c *Client) controlPlaneEmpty(ctx context.Context, operation, method, path string) error {
	transport, err := c.controlPlaneClient(ctx, operation, controlPlaneAuthenticated)
	if err != nil {
		return err
	}
	return transport.callJSON(ctx, method, path, nil, nil)
}
