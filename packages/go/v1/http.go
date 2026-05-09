package kreuzbergcloud

import (
	"context"
	"encoding/json"
	"errors"
	"fmt"
	"io"
	"net/http"
	"strings"
	"time"
)

const (
	contentTypeJSON    = "application/json"
	maxRetryBackoff    = 30 * time.Second
	initialRetryBackoff = 250 * time.Millisecond
	retryBackoffFactor = 2
)

// requestSpec describes a single HTTP request issued by the typed helpers
// below. Body is nil for GET; bodyContentType is required when Body is set.
type requestSpec struct {
	method          string
	path            string
	body            io.Reader
	bodyContentType string
	// rewindBody is invoked before each retry attempt to reset the body
	// reader to the start. Required when retries > 0 and body != nil.
	rewindBody func() (io.Reader, error)
}

// doJSON executes spec, decodes a 2xx JSON response into out, and maps
// non-2xx responses to typed error values. out may be nil when the caller
// only cares about the status code.
func (c *Client) doJSON(ctx context.Context, spec requestSpec, out any) error {
	body, err := c.do(ctx, spec)
	if err != nil {
		return err
	}
	defer body.Close()
	if out == nil {
		_, _ = io.Copy(io.Discard, body)
		return nil
	}
	if err := json.NewDecoder(body).Decode(out); err != nil {
		return fmt.Errorf("kreuzberg-cloud: decoding response: %w", err)
	}
	return nil
}

// do executes spec and returns the response body for 2xx responses. The
// caller MUST close the returned reader.
func (c *Client) do(ctx context.Context, spec requestSpec) (io.ReadCloser, error) {
	attempt := 0
	for {
		body, err := c.doOnce(ctx, spec)
		if err == nil {
			return body, nil
		}
		if attempt >= c.cfg.retries || !shouldRetry(err) || ctx.Err() != nil {
			return nil, err
		}
		delay := nextBackoff(attempt, retryAfter(err))
		select {
		case <-ctx.Done():
			return nil, ctx.Err()
		case <-time.After(delay):
		}
		if spec.body != nil {
			if spec.rewindBody == nil {
				return nil, err
			}
			rewound, rewindErr := spec.rewindBody()
			if rewindErr != nil {
				return nil, fmt.Errorf("kreuzberg-cloud: rewinding body for retry: %w", rewindErr)
			}
			spec.body = rewound
		}
		attempt++
	}
}

// doOnce performs a single HTTP round-trip without retries. When a per-call
// timeout is configured, the cancel function is attached to the response body
// (2xx) or invoked immediately on failure — we cannot defer it here because
// 2xx body reads happen after this call returns.
func (c *Client) doOnce(ctx context.Context, spec requestSpec) (io.ReadCloser, error) {
	cancel := func() {}
	if c.cfg.timeout > 0 {
		ctx, cancel = context.WithTimeout(ctx, c.cfg.timeout)
	}
	return c.doOnceWithCancel(ctx, spec, cancel)
}

// doOnceWithCancel executes the round-trip; cancel is called once the caller
// has finished reading the response body (2xx) or immediately on failure.
func (c *Client) doOnceWithCancel(
	ctx context.Context,
	spec requestSpec,
	cancel context.CancelFunc,
) (io.ReadCloser, error) {
	url := c.urlFor(spec.path)
	req, err := http.NewRequestWithContext(ctx, spec.method, url, spec.body)
	if err != nil {
		cancel()
		return nil, fmt.Errorf("kreuzberg-cloud: building request: %w", err)
	}
	if spec.bodyContentType != "" {
		req.Header.Set("Content-Type", spec.bodyContentType)
	}
	req.Header.Set("Accept", contentTypeJSON)
	if err := c.authorize(ctx, req); err != nil {
		cancel()
		return nil, err
	}
	resp, err := c.cfg.httpClient.Do(req)
	if err != nil {
		cancel()
		return nil, fmt.Errorf("kreuzberg-cloud: %s %s: %w", spec.method, url, err)
	}
	if resp.StatusCode >= 200 && resp.StatusCode < 300 {
		return &cancellingReadCloser{rc: resp.Body, cancel: cancel}, nil
	}
	defer resp.Body.Close()
	defer cancel()
	body, _ := io.ReadAll(resp.Body)
	return nil, classifyHTTPError(resp.StatusCode, body, resp.Header)
}

// urlFor concatenates baseURL and path, normalising a single slash boundary.
func (c *Client) urlFor(path string) string {
	base := strings.TrimRight(c.cfg.baseURL, "/")
	if !strings.HasPrefix(path, "/") {
		path = "/" + path
	}
	return base + path
}

// shouldRetry mirrors IsRetryable but tolerates wrapped errors.
func shouldRetry(err error) bool { return IsRetryable(err) }

// retryAfter returns the server-suggested backoff for 429 responses or zero.
func retryAfter(err error) time.Duration {
	var rate *RateLimitError
	if errors.As(err, &rate) {
		return rate.RetryAfter
	}
	return 0
}

// nextBackoff computes the backoff for the given attempt, honouring an
// optional server-suggested Retry-After value. Attempt is zero-based.
func nextBackoff(attempt int, suggested time.Duration) time.Duration {
	if suggested > 0 {
		if suggested > maxRetryBackoff {
			return maxRetryBackoff
		}
		return suggested
	}
	delay := initialRetryBackoff
	for i := 0; i < attempt; i++ {
		delay *= retryBackoffFactor
		if delay >= maxRetryBackoff {
			return maxRetryBackoff
		}
	}
	return delay
}

// cancellingReadCloser wraps a response body so the per-request cancel func
// fires when the body is closed. This keeps short-lived contexts attached to
// streaming bodies without leaking goroutines.
type cancellingReadCloser struct {
	rc     io.ReadCloser
	cancel context.CancelFunc
}

func (c *cancellingReadCloser) Read(p []byte) (int, error) { return c.rc.Read(p) }

func (c *cancellingReadCloser) Close() error {
	err := c.rc.Close()
	if c.cancel != nil {
		c.cancel()
	}
	return err
}
