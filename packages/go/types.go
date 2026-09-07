package xberg

import (
	"io"
	"time"

	"github.com/google/uuid"
)

// terminalJobStatuses lists the statuses for which the server will produce no
// further updates. WaitForJob polls until one of these is observed. The
// [JobStatus] values are defined by the generated Enterprise schema set.
var terminalJobStatuses = map[JobStatus]struct{}{
	JobStatusCompleted:      {},
	JobStatusPartialSuccess: {},
	JobStatusFailed:         {},
	JobStatusCancelled:      {},
}

// IsTerminalStatus reports whether the status will produce no further updates.
func IsTerminalStatus(status JobStatus) bool {
	_, ok := terminalJobStatuses[status]
	return ok
}

// BackoffKind selects the polling backoff strategy used by [Client.WaitForJob].
type BackoffKind int

const (
	// BackoffExponential doubles the poll interval each cycle (capped).
	BackoffExponential BackoffKind = iota
	// BackoffConstant keeps the poll interval fixed.
	BackoffConstant
)

// WaitOptions configures [Client.WaitForJob]. Zero-value fields fall back to
// sensible defaults (5 minute timeout, 1 second interval, exponential backoff).
type WaitOptions struct {
	Timeout      time.Duration
	PollInterval time.Duration
	Backoff      BackoffKind
}

// ExtractOptions configures a single call to [Client.Extract] or
// [Client.ExtractBatch]: the extraction pipeline configuration and an
// optional webhook for async delivery of job-completion events. Either field
// may be nil; a nil Webhook omits the multipart "webhook" part entirely,
// rather than sending an empty one.
type ExtractOptions struct {
	// DocumentIDs associates files with Enterprise document lineages. When non-nil,
	// it must contain one entry per file; nil entries omit lineage. Duplicate
	// filenames must carry identical IDs. Pro rejects non-nil IDs before reading files.
	DocumentIDs []*uuid.UUID

	Extraction *ExtractionOptions
	Webhook    *WebhookConfig

	// Configs carries one optional per-file extraction override per document,
	// positionally parallel to the files passed to [Client.Extract] or
	// [Client.ExtractBatch]. When non-empty it must have exactly len(files)
	// entries; a nil entry means "no override for that document". Each override
	// is sent as a "config-<filename>" JSON part, and the server resolves it
	// against Extraction.ExtractionConfig, any preset and the project default —
	// nothing is merged client-side.
	//
	// Because the part is keyed on the filename, two documents submitted under
	// the same filename cannot carry different overrides; that combination is
	// rejected before any bytes are sent rather than silently dropping one.
	Configs []*FileExtractionConfig
}

// ExtractAndWaitOptions configures [Client.ExtractAndWait].
type ExtractAndWaitOptions struct {
	Extract *ExtractOptions
	Wait    *WaitOptions
}

// FileSource describes a file to upload as a multipart part. Reader is read
// in full; Name is used for Content-Disposition and Content-Type sniffing.
type FileSource struct {
	Name   string
	Reader io.Reader
}
