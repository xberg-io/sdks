package kreuzbergcloud

import (
	"context"
	"fmt"
	"net/http"
	"time"
)

// DefaultBaseURL is the production endpoint of the Kreuzberg Cloud API.
const DefaultBaseURL = "https://api.kreuzberg.cloud"

const userAgent = "kreuzberg-cloud-go/0.0.1"

// Option configures a Client constructed via New.
type Option func(*clientConfig)

// WithBaseURL overrides the base URL of the API. Defaults to DefaultBaseURL.
func WithBaseURL(u string) Option {
	return func(c *clientConfig) { c.baseURL = u }
}

// WithAPIKey sets the bearer token sent on every request.
func WithAPIKey(key string) Option {
	return func(c *clientConfig) { c.apiKey = key }
}

// WithHTTPClient sets a custom *http.Client. Useful for testing or for
// installing transport-level middleware (retries, tracing, etc.).
func WithHTTPClient(httpClient *http.Client) Option {
	return func(c *clientConfig) { c.httpClient = httpClient }
}

// WithUserAgent overrides the default User-Agent header.
func WithUserAgent(ua string) Option {
	return func(c *clientConfig) { c.userAgent = ua }
}

// WithTimeout sets a per-request timeout that wraps the caller's context for
// every HTTP call. Zero or negative values disable the wrapper (the caller's
// context governs the deadline).
func WithTimeout(d time.Duration) Option {
	return func(c *clientConfig) { c.timeout = d }
}

// WithRetries sets the maximum number of automatic retry attempts on
// retryable HTTP responses (429, 502, 503, 504). Default: 0 (no retries).
func WithRetries(n int) Option {
	return func(c *clientConfig) { c.retries = n }
}

type clientConfig struct {
	baseURL    string
	apiKey     string
	userAgent  string
	httpClient *http.Client
	timeout    time.Duration
	retries    int
}

// Client is a thin wrapper around the generated openapi-fetch client. It
// exposes the same per-operation methods (see generated.go) but injects
// authentication, base URL, and User-Agent headers automatically.
type Client struct {
	cfg clientConfig
}

// New constructs a Client. With no options it targets the production API.
func New(opts ...Option) (*Client, error) {
	cfg := clientConfig{
		baseURL:   DefaultBaseURL,
		userAgent: userAgent,
		httpClient: &http.Client{
			Timeout: 30 * time.Second,
		},
	}
	for _, opt := range opts {
		opt(&cfg)
	}
	if cfg.baseURL == "" {
		return nil, fmt.Errorf("kreuzberg-cloud: base URL must not be empty")
	}
	return &Client{cfg: cfg}, nil
}

// HTTPClient returns the underlying *http.Client. Useful for tests that need
// to inspect the configured transport.
func (c *Client) HTTPClient() *http.Client { return c.cfg.httpClient }

// BaseURL returns the configured base URL.
func (c *Client) BaseURL() string { return c.cfg.baseURL }

// authorize attaches User-Agent + Authorization headers to a request.
//
// This is exported only via the per-operation wrappers in the generated code;
// kept package-private so it cannot be misused by callers.
func (c *Client) authorize(_ context.Context, req *http.Request) error {
	if c.cfg.userAgent != "" {
		req.Header.Set("User-Agent", c.cfg.userAgent)
	}
	if c.cfg.apiKey != "" {
		req.Header.Set("Authorization", "Bearer "+c.cfg.apiKey)
	}
	return nil
}
