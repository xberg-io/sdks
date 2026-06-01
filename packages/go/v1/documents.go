package kreuzbergcloud

import (
	"context"
	"encoding/json"
	"fmt"
	"net/url"
	"time"
)

// DocumentVersion describes a single submitted version of a document, as
// returned by [Client.ListDocumentVersions]. The `result` itself is not
// inlined — fetch the underlying job via [Client.GetJob] (or
// [Client.GetLatestDocument]) when you need the extraction payload.
type DocumentVersion struct {
	JobID                 string `json:"job_id"`
	VersionSequence       int    `json:"version_sequence"`
	ContentHash           string `json:"content_hash"`
	Status                string `json:"status"`
	Filename              string `json:"filename"`
	MimeType              string `json:"mime_type"`
	FileSizeBytes         int64  `json:"file_size_bytes"`
	PagesExtracted        int    `json:"pages_extracted"`
	BillablePages         int    `json:"billable_pages"`
	CreatedAt             string `json:"created_at"`
	ProcessingCompletedAt string `json:"processing_completed_at,omitempty"`
}

// LatestDocument is the envelope returned by GET /v1/documents/{id}: the
// most recent version's job metadata plus the raw ExtractionResult payload
// (kept as json.RawMessage so the caller can decode against whichever
// kreuzberg version they pin without forcing a shared model crate).
type LatestDocument struct {
	ID              string          `json:"id"`
	DocumentID      string          `json:"document_id"`
	VersionSequence int             `json:"version_sequence"`
	Status          string          `json:"status"`
	Filename        string          `json:"filename"`
	MimeType        string          `json:"mime_type"`
	CreatedAt       string          `json:"created_at"`
	Result          json.RawMessage `json:"result"`
}

// DiffResponse is the cloud envelope around kreuzberg's structural diff.
// The `diff` payload itself is kept opaque (json.RawMessage) because the
// kreuzberg-side ExtractionDiff type recurses through Box<ExtractionDiff>
// and the wire shape is stable enough that decoding it against the
// kreuzberg core types directly is the recommended path for richer typing.
type DiffResponse struct {
	FromJobID   string          `json:"from_job_id"`
	ToJobID     string          `json:"to_job_id"`
	FromVersion int             `json:"from_version"`
	ToVersion   int             `json:"to_version"`
	DocumentID  string          `json:"document_id"`
	Diff        json.RawMessage `json:"diff"`
	ComputedAt  string          `json:"computed_at"`
}

// DiffAsyncAccepted is the 202-fallback envelope when GET .../diff overruns
// its server-side inline budget. Poll [Client.PollDocumentDiff] until the
// returned status moves to "succeeded" or "failed".
type DiffAsyncAccepted struct {
	DiffJobID string `json:"diff_job_id"`
	Status    string `json:"status"`
}

// ListDocumentVersions returns every version of a logical document, newest
// first. Pass limit / offset to paginate (limit is capped at 200 on the
// server; offset defaults to 0).
func (c *Client) ListDocumentVersions(
	ctx context.Context,
	documentID string,
	limit int,
	offset int,
) ([]DocumentVersion, error) {
	if documentID == "" {
		return nil, fmt.Errorf("kreuzberg-cloud: ListDocumentVersions requires a non-empty documentID")
	}
	path := "/v1/documents/" + url.PathEscape(documentID) + "/versions"
	q := url.Values{}
	if limit > 0 {
		q.Set("limit", fmt.Sprintf("%d", limit))
	}
	if offset > 0 {
		q.Set("offset", fmt.Sprintf("%d", offset))
	}
	if encoded := q.Encode(); encoded != "" {
		path += "?" + encoded
	}
	var versions []DocumentVersion
	spec := requestSpec{method: methodGet, path: path}
	if err := c.doJSON(ctx, spec, &versions); err != nil {
		return nil, err
	}
	return versions, nil
}

// GetLatestDocument resolves a document_id to its newest version's job and
// inlined extraction result.
func (c *Client) GetLatestDocument(
	ctx context.Context,
	documentID string,
) (*LatestDocument, error) {
	if documentID == "" {
		return nil, fmt.Errorf("kreuzberg-cloud: GetLatestDocument requires a non-empty documentID")
	}
	var doc LatestDocument
	spec := requestSpec{method: methodGet, path: "/v1/documents/" + url.PathEscape(documentID)}
	if err := c.doJSON(ctx, spec, &doc); err != nil {
		return nil, err
	}
	return &doc, nil
}

// DocumentDiffResult is the union returned by GET .../diff: either the
// computed [DiffResponse] (inline) or a [DiffAsyncAccepted] handle when
// the server bumped the job onto its async fallback path. Exactly one of
// Diff and Async is non-nil.
type DocumentDiffResult struct {
	Diff  *DiffResponse
	Async *DiffAsyncAccepted
}

// GetDocumentDiff requests a diff between two versions of the same
// document. Each of `from` / `to` accepts either a version_sequence
// integer (as a string, e.g. "1") or a job UUID. On the sync path the
// returned result.Diff carries the computed [DiffResponse]; on the async
// fallback path result.Async holds a [DiffAsyncAccepted] handle suitable
// for [Client.PollDocumentDiff].
func (c *Client) GetDocumentDiff(
	ctx context.Context,
	documentID string,
	from string,
	to string,
) (*DocumentDiffResult, error) {
	if documentID == "" {
		return nil, fmt.Errorf("kreuzberg-cloud: GetDocumentDiff requires a non-empty documentID")
	}
	if from == "" || to == "" {
		return nil, fmt.Errorf("kreuzberg-cloud: GetDocumentDiff requires non-empty from and to")
	}
	q := url.Values{}
	q.Set("from", from)
	q.Set("to", to)
	path := "/v1/documents/" + url.PathEscape(documentID) + "/diff?" + q.Encode()
	body, status, err := c.doRaw(ctx, requestSpec{method: methodGet, path: path})
	if err != nil {
		return nil, err
	}
	switch status {
	case 200:
		var d DiffResponse
		if err := json.Unmarshal(body, &d); err != nil {
			return nil, fmt.Errorf("kreuzberg-cloud: GetDocumentDiff decode 200: %w", err)
		}
		return &DocumentDiffResult{Diff: &d}, nil
	case 202:
		var a DiffAsyncAccepted
		if err := json.Unmarshal(body, &a); err != nil {
			return nil, fmt.Errorf("kreuzberg-cloud: GetDocumentDiff decode 202: %w", err)
		}
		return &DocumentDiffResult{Async: &a}, nil
	default:
		return nil, fmt.Errorf("kreuzberg-cloud: GetDocumentDiff unexpected status %d", status)
	}
}

// PollDocumentDiff polls the async fallback endpoint until the diff
// computation completes or the supplied context is canceled. Returns the
// terminal [DiffResponse] on success.
func (c *Client) PollDocumentDiff(
	ctx context.Context,
	documentID string,
	diffJobID string,
	opts *WaitOptions,
) (*DiffResponse, error) {
	if documentID == "" {
		return nil, fmt.Errorf("kreuzberg-cloud: PollDocumentDiff requires a non-empty documentID")
	}
	if diffJobID == "" {
		return nil, fmt.Errorf("kreuzberg-cloud: PollDocumentDiff requires a non-empty diffJobID")
	}
	options := normaliseWaitOptions(opts)
	start := time.Now()
	deadline := start.Add(options.Timeout)
	pollInterval := options.PollInterval
	path := "/v1/documents/" + url.PathEscape(documentID) +
		"/diff/" + url.PathEscape(diffJobID)
	for {
		body, status, err := c.doRaw(ctx, requestSpec{method: methodGet, path: path})
		if err != nil {
			return nil, err
		}
		switch status {
		case 200:
			var d DiffResponse
			if err := json.Unmarshal(body, &d); err != nil {
				return nil, fmt.Errorf("kreuzberg-cloud: PollDocumentDiff decode 200: %w", err)
			}
			return &d, nil
		case 202:
			// still pending — fall through to backoff
		case 422:
			return nil, fmt.Errorf("kreuzberg-cloud: PollDocumentDiff failed: %s", string(body))
		default:
			return nil, fmt.Errorf("kreuzberg-cloud: PollDocumentDiff unexpected status %d", status)
		}
		if !time.Now().Before(deadline) {
			return nil, &TimeoutError{JobID: diffJobID, Elapsed: time.Since(start)}
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
			pollInterval *= 2
			if pollInterval > maxWaitPollInterval {
				pollInterval = maxWaitPollInterval
			}
		}
	}
}
