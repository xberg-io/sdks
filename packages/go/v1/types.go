package kreuzbergcloud

import (
	"encoding/json"
	"io"
	"time"
)

// JobStatus is one of the values returned by the API in [Job.Status].
//
// We model the status as a plain string rather than a typed enum so that new
// server-side states do not break clients compiled against an older SDK.
const (
	JobStatusAwaitingUpload = "awaiting_upload"
	JobStatusPending        = "pending"
	JobStatusProcessing     = "processing"
	JobStatusChunking       = "chunking"
	JobStatusAggregating    = "aggregating"
	JobStatusCompleted      = "completed"
	JobStatusPartialSuccess = "partial_success"
	JobStatusFailed         = "failed"
	JobStatusCancelled      = "cancelled"
)

// terminalJobStatuses lists the statuses for which the server will produce no
// further updates. WaitForJob polls until one of these is observed.
var terminalJobStatuses = map[string]struct{}{
	JobStatusCompleted:      {},
	JobStatusPartialSuccess: {},
	JobStatusFailed:         {},
	JobStatusCancelled:      {},
}

// IsTerminalStatus reports whether the status will produce no further updates.
func IsTerminalStatus(status string) bool {
	_, ok := terminalJobStatuses[status]
	return ok
}

// Job is the lifecycle envelope returned by GET /v1/jobs/{id}. The optional
// Result field is populated once the job reaches a terminal status.
type Job struct {
	ID                string          `json:"id"`
	Filename          string          `json:"filename"`
	Status            string          `json:"status"`
	CreatedAt         time.Time       `json:"created_at"`
	ProcessingTimeMs  *int64          `json:"processing_time_ms,omitempty"`
	Result            *JobResult      `json:"result,omitempty"`
	RawResponseBody   json.RawMessage `json:"-"`
}

// JobResult is the extraction payload produced on terminal success. The shape
// matches the OpenAPI ExtractionResult schema; rich nested types like Tables
// and Images are deferred to a follow-up — see TODO below.
//
// TODO(workstream-e-go): expose strongly-typed Tables, Images, Chunks,
// PageContent, and Metadata. Currently held as json.RawMessage so callers can
// access the data without forcing us to mirror every nested struct here.
type JobResult struct {
	Content            string          `json:"content"`
	MimeType           string          `json:"mime_type,omitempty"`
	DetectedLanguages  []string        `json:"detected_languages,omitempty"`
	QualityScore       *float64        `json:"quality_score,omitempty"`
	Pages              json.RawMessage `json:"pages,omitempty"`
	Tables             json.RawMessage `json:"tables,omitempty"`
	Images             json.RawMessage `json:"images,omitempty"`
	Chunks             json.RawMessage `json:"chunks,omitempty"`
	Metadata           json.RawMessage `json:"metadata,omitempty"`
	ProcessingWarnings json.RawMessage `json:"processing_warnings,omitempty"`
}

// Text is a convenience alias for [JobResult.Content].
func (r *JobResult) Text() string {
	if r == nil {
		return ""
	}
	return r.Content
}

// OCRConfig is the minimum viable OCR option set for v1. Additional knobs
// (psm, dpi, custom languages) are deferred — TODO(workstream-e-go).
type OCRConfig struct {
	Backend  string `json:"backend,omitempty"`
	Language string `json:"language,omitempty"`
}

// ExtractionConfig mirrors a small subset of the server-side extraction
// configuration. We expose only the knobs the v1 docs Quickstart needs:
// output format, OCR backend/language, and the force/disable OCR toggles.
//
// TODO(workstream-e-go): expose chunking, content filtering, language
// detection, table extraction, security limits, and presign options.
type ExtractionConfig struct {
	OutputFormat string     `json:"output_format,omitempty"`
	OCR          *OCRConfig `json:"ocr,omitempty"`
	ForceOCR     *bool      `json:"force_ocr,omitempty"`
	DisableOCR   *bool      `json:"disable_ocr,omitempty"`
}

// ExtractionOptions is the top-level options envelope sent on every extract
// request. It nests an [ExtractionConfig] so the JSON wire shape mirrors the
// REST API and the Python/TypeScript SDKs exactly.
type ExtractionOptions struct {
	ExtractionConfig *ExtractionConfig `json:"extraction_config,omitempty"`
}

// SandboxKey is the response from POST /v1/sandbox/key. The endpoint mints a
// short-lived, anonymous API key for the public sandbox project.
type SandboxKey struct {
	APIKey         string    `json:"api_key"`
	ExpiresAt      time.Time `json:"expires_at"`
	PagesRemaining int64     `json:"pages_remaining"`
}

// BackoffKind selects the polling backoff strategy used by [Client.WaitForJob].
type BackoffKind int

const (
	// BackoffExponential doubles the delay between polls up to a 30s ceiling.
	BackoffExponential BackoffKind = iota
	// BackoffConstant uses [WaitOptions.PollInterval] for every poll.
	BackoffConstant
)

// WaitOptions configures [Client.WaitForJob]. Zero-value fields fall back to
// sensible defaults (5 minute timeout, 1 second interval, exponential backoff).
type WaitOptions struct {
	Timeout      time.Duration
	PollInterval time.Duration
	Backoff      BackoffKind
}

// ExtractAndWaitOptions configures [Client.ExtractAndWait].
type ExtractAndWaitOptions struct {
	Extraction *ExtractionOptions
	Wait       *WaitOptions
}

// FileSource describes a file to upload as a multipart part. Reader is read
// in full; Name is used for Content-Disposition and Content-Type sniffing.
type FileSource struct {
	Name   string
	Reader io.Reader
}

// extractResponse models the 202 Accepted body of POST /v1/extract.
type extractResponse struct {
	JobIDs []string `json:"job_ids"`
	Status string   `json:"status"`
}
