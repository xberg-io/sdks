package xberg

import (
	"context"
	"fmt"
	"net/http"
	"sync"
	"time"

	"golang.org/x/sync/singleflight"
)

// DefaultEnterpriseBaseURL is the production endpoint of the Xberg Enterprise
// API. It is the default base URL for the enterprise target (and when no target
// is given); the Pro target ships no default and requires an explicit base URL.
const DefaultEnterpriseBaseURL = "https://api.xberg.io"

// DefaultBaseURL is retained as an alias of [DefaultEnterpriseBaseURL] for
// callers written against the single-target client.
const DefaultBaseURL = DefaultEnterpriseBaseURL

const userAgent = "xberg-io-sdk-go/" + Version

// Target selects which product a [Client] talks to. When unset the tier is
// discovered lazily from GET /healthz before the first tier-specific call.
type Target string

const (
	// TargetEnterprise selects Xberg Enterprise (defaults the base URL).
	TargetEnterprise Target = "enterprise"
	// TargetPro selects Xberg Pro (requires an explicit base URL).
	TargetPro Target = "pro"
)

// Option configures a Client constructed via New.
type Option func(*clientConfig)

// WithBaseURL overrides the base URL of the API. For the enterprise target it
// defaults to [DefaultEnterpriseBaseURL]; the Pro target requires it.
func WithBaseURL(u string) Option {
	return func(c *clientConfig) {
		c.baseURL = u
		c.baseURLSet = true
	}
}

// WithControlPlaneBaseURL sets the origin of the Enterprise control plane,
// which runs as a second binary alongside the data plane. It defaults to the
// data-plane base URL — Pro serves both planes from one binary, so every Pro
// call keeps working untouched.
func WithControlPlaneBaseURL(u string) Option {
	return func(c *clientConfig) {
		c.controlPlaneBaseURL = u
		c.controlPlaneBaseURLSet = true
	}
}

// WithControlPlaneToken sets the bearer credential for Enterprise control-plane requests.
// When omitted, control-plane calls use the configured API key.
func WithControlPlaneToken(token string) Option {
	return func(c *clientConfig) { c.controlPlaneToken = &token }
}

// WithAPIKey sets the bearer token sent on every request.
func WithAPIKey(key string) Option {
	return func(c *clientConfig) { c.apiKey = key }
}

// WithTarget pins the product this client talks to, skipping the /healthz
// capability probe. Pass [TargetEnterprise] or [TargetPro].
func WithTarget(t Target) Option {
	return func(c *clientConfig) { c.target = t }
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
	baseURL                string
	baseURLSet             bool
	controlPlaneBaseURL    string
	controlPlaneBaseURLSet bool
	apiKey                 string
	controlPlaneToken      *string
	userAgent              string
	httpClient             *http.Client
	timeout                time.Duration
	retries                int
	target                 Target
}

// Client is the dual-target client for Xberg Enterprise and Xberg Pro. One
// Client speaks to either product: the shared surface (extraction, jobs, audit,
// curated presets, RAG) is written once, and tier-specific methods are
// capability-gated against the connected instance's tier (an explicit
// [WithTarget], else probed from GET /healthz).
type Client struct {
	cfg clientConfig

	tierMu     sync.Mutex
	tierProbed bool
	probedTier string
	tierGroup  singleflight.Group
}

// New constructs a Client. With no options it targets the Enterprise production
// API. Selecting [TargetPro] without a base URL is a configuration error, since
// the Pro spec ships no default server.
func New(opts ...Option) (*Client, error) {
	cfg := clientConfig{
		userAgent: userAgent,
		httpClient: &http.Client{
			Timeout: 30 * time.Second,
		},
	}
	for _, opt := range opts {
		opt(&cfg)
	}
	if err := resolveBaseURL(&cfg); err != nil {
		return nil, err
	}
	if err := resolveControlPlaneBaseURL(&cfg); err != nil {
		return nil, err
	}
	return &Client{cfg: cfg}, nil
}

// resolveBaseURL enforces the base-URL policy: an explicit empty base URL is
// rejected; an unset base URL defaults to Enterprise unless the Pro target is
// selected, which has no default.
func resolveBaseURL(cfg *clientConfig) error {
	if cfg.baseURLSet {
		if cfg.baseURL == "" {
			return fmt.Errorf("xberg: base URL must not be empty")
		}
		return nil
	}
	if cfg.target == TargetPro {
		return fmt.Errorf(
			"xberg: Xberg Pro has no default base URL (its spec ships no servers block); " +
				"pass WithBaseURL pointing at your Pro instance",
		)
	}
	cfg.baseURL = DefaultEnterpriseBaseURL
	return nil
}

// resolveControlPlaneBaseURL defaults the control-plane origin to the data-plane
// one. Enterprise runs the control plane (projects, API keys, integrations, RAG
// config, members, invitations, managed webhooks, usage, analytics, billing) as
// a second binary on its own origin; Pro serves it from the same one. The
// default therefore has to be the data-plane base URL, exactly as the console's
// NEXT_PUBLIC_BACKEND_API_URL is same-origin unless set — anything else would
// break every Pro control-plane call the moment this option existed.
func resolveControlPlaneBaseURL(cfg *clientConfig) error {
	if !cfg.controlPlaneBaseURLSet {
		cfg.controlPlaneBaseURL = cfg.baseURL
		return nil
	}
	if cfg.controlPlaneBaseURL == "" {
		return fmt.Errorf("xberg: control-plane base URL must not be empty")
	}
	return nil
}

// HTTPClient returns the underlying *http.Client. Useful for tests that need
// to inspect the configured transport.
func (c *Client) HTTPClient() *http.Client { return c.cfg.httpClient }

// BaseURL returns the configured base URL.
func (c *Client) BaseURL() string { return c.cfg.baseURL }

// ControlPlaneBaseURL returns the origin of Enterprise control-plane requests.
// It is the same as [Client.BaseURL] unless
// [WithControlPlaneBaseURL] was given.
func (c *Client) ControlPlaneBaseURL() string { return c.cfg.controlPlaneBaseURL }

// Target returns the explicitly configured target, or the empty [Target] when
// the tier is discovered lazily from GET /healthz.
func (c *Client) Target() Target { return c.cfg.target }

// authorize attaches User-Agent + Authorization headers to a request.
//
// This is exported only via the per-operation wrappers; kept package-private so
// it cannot be misused by callers.
func (c *Client) authorize(_ context.Context, req *http.Request) error {
	if c.cfg.userAgent != "" {
		req.Header.Set("User-Agent", c.cfg.userAgent)
	}
	if c.cfg.apiKey != "" {
		req.Header.Set("Authorization", "Bearer "+c.cfg.apiKey)
	}
	return nil
}

// resolveTier returns the effective tier: an explicit [WithTarget] if set,
// otherwise the value probed once from GET /healthz and cached thereafter.
//
// Concurrent callers racing an unset [WithTarget] share a single in-flight
// probe via singleflight rather than serializing behind a mutex held across
// the HTTP round trip. A probe is cached only once it observes a recognized
// tier: a failed request, or a /healthz response with a missing or
// unrecognized tier, returns an error and leaves the client retryable instead
// of caching an unusable result for its lifetime.
func (c *Client) resolveTier(ctx context.Context) (string, error) {
	if c.cfg.target != "" {
		return string(c.cfg.target), nil
	}
	if tier, ok := c.cachedTier(); ok {
		return tier, nil
	}
	result, err, _ := c.tierGroup.Do("tier", func() (any, error) {
		// Re-check: another goroutine may have completed a probe between our
		// cachedTier miss above and acquiring the singleflight slot.
		if tier, ok := c.cachedTier(); ok {
			return tier, nil
		}
		return c.probeTier(ctx)
	})
	if err != nil {
		return "", err
	}
	tier, ok := result.(string)
	if !ok {
		return "", fmt.Errorf("xberg: tier probe returned unexpected type %T", result)
	}
	return tier, nil
}

// cachedTier returns the previously probed tier, if any.
func (c *Client) cachedTier() (string, bool) {
	c.tierMu.Lock()
	defer c.tierMu.Unlock()
	return c.probedTier, c.tierProbed
}

// probeTier issues GET /healthz and validates the reported tier. tierMu is
// only held to read or write the cached fields, never across the request.
func (c *Client) probeTier(ctx context.Context) (string, error) {
	var health struct {
		Tier string `json:"tier"`
	}
	spec := requestSpec{method: methodGet, path: "/healthz"}
	if err := c.doJSON(ctx, spec, &health); err != nil {
		return "", fmt.Errorf("xberg: probing tier: %w", err)
	}
	if !isRecognisedTier(health.Tier) {
		if health.Tier == "" {
			return "", fmt.Errorf("xberg: healthz response did not report a tier")
		}
		return "", fmt.Errorf("xberg: healthz reported unrecognized tier %q", health.Tier)
	}
	c.tierMu.Lock()
	c.tierProbed = true
	c.probedTier = health.Tier
	c.tierMu.Unlock()
	return health.Tier, nil
}

// isRecognisedTier reports whether tier is one of the values the Enterprise
// and Pro healthz responses actually use.
func isRecognisedTier(tier string) bool {
	switch Target(tier) {
	case TargetEnterprise, TargetPro:
		return true
	default:
		return false
	}
}

// requireTier returns a [TierError] when the connected tier does not match the
// tier a method requires, without issuing the underlying (wrong-tier) request.
func (c *Client) requireTier(ctx context.Context, required Target, method string) error {
	tier, err := c.resolveTier(ctx)
	if err != nil {
		return err
	}
	if tier != string(required) {
		actual := tier
		if actual == "" {
			actual = "unknown"
		}
		return &TierError{Method: method, Required: string(required), Actual: actual}
	}
	return nil
}
