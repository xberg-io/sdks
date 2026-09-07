package xberg

import (
	"context"
	"errors"
	"fmt"
	"net/url"
	"strconv"
	"sync"
	"time"
)

// Default poll/timeout values used when [WaitOptions] is nil or has zero
// fields. Tuned to be friendly for long-running extractions while remaining
// snappy for fast jobs (sub-second OCR-free PDFs).
const (
	defaultWaitTimeout      = 5 * time.Minute
	defaultWaitPollInterval = 1 * time.Second
	maxWaitPollInterval     = 30 * time.Second
)

// jobsPath is the root of the job surface, shared by Enterprise and Pro.
const jobsPath = "/v1/jobs"

// jobPath renders a job-scoped route, escaping the job ID. suffix is appended
// verbatim and must already start with "/" when non-empty.
func jobPath(jobID, suffix string) string {
	return jobsPath + "/" + escapePathSegment(jobID) + suffix
}

// GetJob fetches the current status of a single job by ID.
//
// Part of the shared surface (Enterprise + Pro).
func (c *Client) GetJob(ctx context.Context, jobID string) (*JobResponse, error) {
	if jobID == "" {
		return nil, fmt.Errorf("xberg: GetJob requires a non-empty jobID")
	}
	var job JobResponse
	if err := c.getJSON(ctx, jobPath(jobID, ""), &job); err != nil {
		return nil, err
	}
	return &job, nil
}

// CancelJob cancels a running job (DELETE /v1/jobs/{id}). It is idempotent:
// the server answers 204 both for a job that is cancelled by this call and one
// that has already reached a terminal state. A 404 (job not found in the
// caller's project) surfaces as a [NotFoundError].
//
// Part of the shared surface (Enterprise + Pro).
func (c *Client) CancelJob(ctx context.Context, jobID string) error {
	if jobID == "" {
		return fmt.Errorf("xberg: CancelJob requires a non-empty jobID")
	}
	return c.callJSON(ctx, methodDelete, jobPath(jobID, ""), nil, nil)
}

// GetJobResult fetches a job's stored extraction result via
// GET /v1/jobs/{id}/result. The returned [JobResult] carries the extracted
// documents in Results (opaque JSON, one entry per document), any child job
// IDs produced by a split, and any non-fatal per-document errors. The server
// answers 409 — surfaced as an [XbergError] — while the job has not reached a
// terminal successful state.
//
// Part of the shared surface (Enterprise + Pro).
func (c *Client) GetJobResult(ctx context.Context, jobID string) (*JobResult, error) {
	if jobID == "" {
		return nil, fmt.Errorf("xberg: GetJobResult requires a non-empty jobID")
	}
	var result JobResult
	if err := c.getJSON(ctx, jobPath(jobID, "/result"), &result); err != nil {
		return nil, err
	}
	return &result, nil
}

// GetJobPage downloads one page raster persisted during a structured
// extraction (GET /v1/jobs/{jobID}/pages/{pageNumber}). Page numbers are
// 1-indexed and the endpoint serves image/png, so the body is returned
// undecoded. Enterprise only.
func (c *Client) GetJobPage(ctx context.Context, jobID string, pageNumber int) ([]byte, error) {
	if err := c.requireTier(ctx, TargetEnterprise, "GetJobPage"); err != nil {
		return nil, err
	}
	if jobID == "" {
		return nil, fmt.Errorf("xberg: GetJobPage requires a non-empty jobID")
	}
	return c.getBytes(ctx, jobPath(jobID, "/pages/"+strconv.Itoa(pageNumber)))
}

// ListJobs lists jobs via GET /v1/jobs (paginated). A non-positive limit or
// offset is omitted from the query string.
//
// Part of the shared surface (Enterprise + Pro).
func (c *Client) ListJobs(ctx context.Context, limit, offset int) (*ListJobsResponse, error) {
	path := jobsPath + pageQuery(limit, offset)
	var out ListJobsResponse
	if err := c.getJSON(ctx, path, &out); err != nil {
		return nil, err
	}
	return &out, nil
}

// Audit fetches audit-log entries via GET /v1/audit. An empty action or a
// non-positive limit/offset is omitted from the query string.
//
// Part of the shared surface (Enterprise + Pro).
func (c *Client) Audit(ctx context.Context, action string, limit, offset int) (*ListAuditEntriesResponse, error) {
	q := pageValues(limit, offset)
	if action != "" {
		q.Set("action", action)
	}
	path := "/v1/audit" + querySuffix(q)
	var out ListAuditEntriesResponse
	if err := c.getJSON(ctx, path, &out); err != nil {
		return nil, err
	}
	return &out, nil
}

// WaitForJob polls GET /v1/jobs/{id} until the job reaches a terminal status or
// the configured timeout elapses. It returns the terminal [JobResponse] on a
// successful state (completed / partial_success); a failed or cancelled job
// yields an error wrapping the server-supplied message.
//
// Part of the shared surface (Enterprise + Pro).
func (c *Client) WaitForJob(
	ctx context.Context,
	jobID string,
	opts *WaitOptions,
) (*JobResponse, error) {
	options := normaliseWaitOptions(opts)
	start := time.Now()
	deadline := start.Add(options.Timeout)
	pollInterval := options.PollInterval
	for {
		job, err := c.GetJob(ctx, jobID)
		if err != nil {
			return nil, err
		}
		if IsTerminalStatus(job.Status) {
			return jobFromTerminal(jobID, job)
		}
		if !time.Now().Before(deadline) {
			return nil, &TimeoutError{JobID: jobID, Elapsed: time.Since(start)}
		}
		wait := pollInterval
		if remaining := time.Until(deadline); remaining < wait {
			wait = remaining
		}
		select {
		case <-ctx.Done():
			return nil, ctx.Err()
		case <-time.After(wait):
		}
		if options.Backoff == BackoffExponential {
			pollInterval = nextPollInterval(pollInterval)
		}
	}
}

// WaitForJobs concurrently waits for a slice of job IDs and returns their
// results in submission order. Errors from individual jobs are propagated
// immediately — the first error cancels the remaining waits.
//
// Part of the shared surface (Enterprise + Pro).
func (c *Client) WaitForJobs(
	ctx context.Context,
	jobIDs []string,
	opts *WaitOptions,
) ([]*JobResponse, error) {
	if len(jobIDs) == 0 {
		return nil, nil
	}
	results := make([]*JobResponse, len(jobIDs))
	errs := make([]error, len(jobIDs))
	groupCtx, cancel := context.WithCancel(ctx)
	defer cancel()
	var waitGroup sync.WaitGroup
	for index, jobID := range jobIDs {
		waitGroup.Add(1)
		go func(i int, id string) {
			defer waitGroup.Done()
			result, err := c.WaitForJob(groupCtx, id, opts)
			results[i] = result
			if err != nil {
				errs[i] = err
				cancel()
			}
		}(index, jobID)
	}
	waitGroup.Wait()
	for _, err := range errs {
		if err != nil && !errors.Is(err, context.Canceled) {
			return results, err
		}
	}
	for _, err := range errs {
		if err != nil {
			return results, err
		}
	}
	return results, nil
}

// ExtractAndWait is a convenience wrapper that submits a single document and
// blocks until extraction completes, returning the terminal [JobResponse]. The
// extraction options and wait policy can be overridden via opts; either field
// may be nil to accept defaults.
//
// Part of the shared surface (Enterprise + Pro).
func (c *Client) ExtractAndWait(
	ctx context.Context,
	file FileSource,
	opts *ExtractAndWaitOptions,
) (*JobResponse, error) {
	var extract *ExtractOptions
	var wait *WaitOptions
	if opts != nil {
		extract = opts.Extract
		wait = opts.Wait
	}
	job, err := c.Extract(ctx, file, extract)
	if err != nil {
		return nil, err
	}
	return c.WaitForJob(ctx, job.Id.String(), wait)
}

func normaliseWaitOptions(opts *WaitOptions) WaitOptions {
	out := WaitOptions{
		Timeout:      defaultWaitTimeout,
		PollInterval: defaultWaitPollInterval,
		Backoff:      BackoffExponential,
	}
	if opts == nil {
		return out
	}
	if opts.Timeout > 0 {
		out.Timeout = opts.Timeout
	}
	if opts.PollInterval > 0 {
		out.PollInterval = opts.PollInterval
	}
	out.Backoff = opts.Backoff
	return out
}

func nextPollInterval(current time.Duration) time.Duration {
	next := current * 2
	if next > maxWaitPollInterval {
		return maxWaitPollInterval
	}
	return next
}

// jobFromTerminal returns a terminal job or maps a failed/cancelled state to an
// error carrying the server-supplied detail when present.
func jobFromTerminal(jobID string, job *JobResponse) (*JobResponse, error) {
	switch job.Status {
	case JobStatusCompleted, JobStatusPartialSuccess:
		return job, nil
	case JobStatusFailed:
		if detail := jobFailureDetail(job); detail != "" {
			return nil, fmt.Errorf("xberg: job %s failed: %s", jobID, detail)
		}
		return nil, fmt.Errorf("xberg: job %s failed", jobID)
	case JobStatusCancelled:
		return nil, fmt.Errorf("xberg: job %s was cancelled", jobID)
	default:
		return nil, fmt.Errorf(
			"xberg: job %s reached unrecognized terminal status %q", jobID, job.Status,
		)
	}
}

// jobFailureDetail best-effort extracts a human-readable failure message from a
// terminal job's inlined extraction result.
func jobFailureDetail(job *JobResponse) string {
	if job.Result != nil && job.Result.Content != "" {
		return job.Result.Content
	}
	return ""
}

// pageValues builds the shared limit/offset query values, omitting
// non-positive values so the server's own defaults apply.
func pageValues(limit, offset int) url.Values {
	q := url.Values{}
	if limit > 0 {
		q.Set("limit", strconv.Itoa(limit))
	}
	if offset > 0 {
		q.Set("offset", strconv.Itoa(offset))
	}
	return q
}

// querySuffix renders values as a "?k=v" suffix, or "" when nothing is set.
func querySuffix(values url.Values) string {
	if encoded := values.Encode(); encoded != "" {
		return "?" + encoded
	}
	return ""
}

// pageQuery builds a "?limit=&offset=" suffix, omitting non-positive values.
func pageQuery(limit, offset int) string {
	return querySuffix(pageValues(limit, offset))
}
