package kreuzbergcloud

import (
	"context"
	"errors"
	"fmt"
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

// GetJob fetches the current status of a single job by ID.
func (c *Client) GetJob(ctx context.Context, jobID string) (*Job, error) {
	if jobID == "" {
		return nil, fmt.Errorf("kreuzberg-cloud: GetJob requires a non-empty jobID")
	}
	var job Job
	spec := requestSpec{method: methodGet, path: "/v1/jobs/" + jobID}
	if err := c.doJSON(ctx, spec, &job); err != nil {
		return nil, err
	}
	return &job, nil
}

// WaitForJob polls GET /v1/jobs/{id} until the job reaches a terminal status
// or the configured timeout elapses. The returned [JobResult] is the same
// payload exposed via Job.Result on success; on a "failed" terminal status
// it returns a typed error wrapping the server-supplied message.
func (c *Client) WaitForJob(
	ctx context.Context,
	jobID string,
	opts *WaitOptions,
) (*JobResult, error) {
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
			return jobResultFromTerminal(job)
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
func (c *Client) WaitForJobs(
	ctx context.Context,
	jobIDs []string,
	opts *WaitOptions,
) ([]*JobResult, error) {
	if len(jobIDs) == 0 {
		return nil, nil
	}
	results := make([]*JobResult, len(jobIDs))
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
// blocks until extraction completes, returning the final [JobResult]. The
// extraction options and wait policy can be overridden via opts; either field
// may be nil to accept defaults.
func (c *Client) ExtractAndWait(
	ctx context.Context,
	file FileSource,
	opts *ExtractAndWaitOptions,
) (*JobResult, error) {
	var extraction *ExtractionOptions
	var wait *WaitOptions
	if opts != nil {
		extraction = opts.Extraction
		wait = opts.Wait
	}
	job, err := c.Extract(ctx, file, extraction)
	if err != nil {
		return nil, err
	}
	return c.WaitForJob(ctx, job.ID, wait)
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

// jobResultFromTerminal converts a terminal Job into a JobResult or error.
func jobResultFromTerminal(job *Job) (*JobResult, error) {
	switch job.Status {
	case JobStatusCompleted, JobStatusPartialSuccess:
		if job.Result == nil {
			return nil, fmt.Errorf(
				"kreuzberg-cloud: job %s reported %s but no result body",
				job.ID, job.Status,
			)
		}
		return job.Result, nil
	case JobStatusFailed:
		message := "job failed"
		if job.Result != nil && job.Result.Content != "" {
			message = job.Result.Content
		}
		return nil, fmt.Errorf("kreuzberg-cloud: job %s failed: %s", job.ID, message)
	case JobStatusCancelled:
		return nil, fmt.Errorf("kreuzberg-cloud: job %s was canceled", job.ID)
	default:
		return nil, fmt.Errorf(
			"kreuzberg-cloud: job %s reached unrecognized terminal status %q",
			job.ID, job.Status,
		)
	}
}
