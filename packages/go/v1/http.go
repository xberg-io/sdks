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
	contentTypeJSON     = "application/json"
	maxRetryBackoff     = 30 * time.Second
	initialRetryBackoff = 250 * time.Millisecond
	retryBackoffFactor  = 2
)

// HTTP method constants. Extracted to satisfy goconst and keep the typed
// helpers locally consistent — no method literal should appear inline in
// a request body elsewhere in this package.
const (
	methodGet  = "GET"
	methodPost = "POST"
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
	defer closeQuietly(body)
	if out == nil {
		if _, copyErr := io.Copy(io.Discard, body); copyErr != nil {
			return fmt.Errorf("kreuzberg-cloud: discarding response body: %w", copyErr)
		}
		return nil
	}
	if err := json.NewDecoder(body).Decode(out); err != nil {
		return fmt.Errorf("kreuzberg-cloud: decoding response: %w", err)
	}
	return nil
}

// doRaw issues spec and returns the response body bytes plus the HTTP
// status for 2xx responses. Use this when the caller needs to
// distinguish between 200-class success codes (e.g. 200 vs 202).
// Non-2xx responses are still converted into typed errors via
// [classifyHTTPError], identical to [Client.do].
func (c *Client) doRaw(
	ctx context.Context,
	spec requestSpec,
) ([]byte, int, error) {
	rc, status, err := c.doWithStatus(ctx, spec)
	if err != nil {
		return nil, 0, err
	}
	defer closeQuietly(rc)
	body, readErr := io.ReadAll(rc)
	if readErr != nil {
		return nil, status, fmt.Errorf(
			"kreuzberg-cloud: reading response body: %w", readErr,
		)
	}
	return body, status, nil
}

// doWithStatus mirrors [Client.do] but propagates the HTTP status
// alongside the body reader. Status is only meaningful when err == nil.
func (c *Client) doWithStatus(
	ctx context.Context,
	spec requestSpec,
) (io.ReadCloser, int, error) {
	attempt := 0
	for {
		body, status, err := c.doOnceWithStatus(ctx, spec)
		if err == nil {
			return body, status, nil
		}
		if attempt >= c.cfg.retries || !shouldRetry(err) || ctx.Err() != nil {
			return nil, 0, err
		}
		delay := nextBackoff(attempt, retryAfter(err))
		select {
		case <-ctx.Done():
			return nil, 0, ctx.Err()
		case <-time.After(delay):
		}
		if spec.body != nil {
			if spec.rewindBody == nil {
				return nil, 0, err
			}
			rewound, rewindErr := spec.rewindBody()
			if rewindErr != nil {
				return nil, 0, fmt.Errorf(
					"kreuzberg-cloud: rewinding body for retry: %w",
					rewindErr,
				)
			}
			spec.body = rewound
		}
		attempt++
	}
}

// doOnceWithStatus is the per-attempt counterpart to [Client.doOnce]
// that exposes the HTTP status code.
func (c *Client) doOnceWithStatus(
	ctx context.Context,
	spec requestSpec,
) (io.ReadCloser, int, error) {
	cancel := func() {}
	if c.cfg.timeout > 0 {
		ctx, cancel = context.WithTimeout(ctx, c.cfg.timeout)
	}
	rc, status, err := c.doOnceWithCancelStatus(ctx, spec, cancel)
	return rc, status, err
}

// doOnceWithCancelStatus mirrors [Client.doOnceWithCancel] but returns
// the HTTP status alongside the response body.
func (c *Client) doOnceWithCancelStatus(
	ctx context.Context,
	spec requestSpec,
	cancel context.CancelFunc,
) (io.ReadCloser, int, error) {
	url := c.urlFor(spec.path)
	req, err := http.NewRequestWithContext(ctx, spec.method, url, spec.body)
	if err != nil {
		cancel()
		return nil, 0, fmt.Errorf("kreuzberg-cloud: building request: %w", err)
	}
	if spec.bodyContentType != "" {
		req.Header.Set("Content-Type", spec.bodyContentType)
	}
	req.Header.Set("Accept", contentTypeJSON)
	if err := c.authorize(ctx, req); err != nil {
		cancel()
		return nil, 0, err
	}
	resp, err := c.cfg.httpClient.Do(req)
	if err != nil {
		cancel()
		return nil, 0, fmt.Errorf(
			"kreuzberg-cloud: %s %s: %w", spec.method, url, err,
		)
	}
	if resp.StatusCode >= 200 && resp.StatusCode < 300 {
		return &cancellingReadCloser{rc: resp.Body, cancel: cancel}, resp.StatusCode, nil
	}
	defer closeQuietly(resp.Body)
	defer cancel()
	body, readErr := io.ReadAll(resp.Body)
	if readErr != nil {
		return nil, 0, fmt.Errorf("kreuzberg-cloud: reading error response body: %w", readErr)
	}
	return nil, 0, classifyHTTPError(resp.StatusCode, body, resp.Header)
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
	defer closeQuietly(resp.Body)
	defer cancel()
	body, readErr := io.ReadAll(resp.Body)
	if readErr != nil {
		return nil, fmt.Errorf("kreuzberg-cloud: reading error response body: %w", readErr)
	}
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

// nextBackoff computes the backoff for the given attempt, honoring an
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

// closeQuietly closes c, swallowing the error. We intentionally drop the
// error: the caller has already obtained the data it needs from the response,
// and a Close failure on read is not actionable.
func closeQuietly(c io.Closer) {
	if c == nil {
		return
	}
	if err := c.Close(); err != nil {
		_ = err
	}
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
