package xberg

import (
	"bytes"
	"context"
	"encoding/json"
	"fmt"
	"io"
	"mime/multipart"
	"net/textproto"
	"strings"
)

// Extract submits a single document for asynchronous extraction and returns the
// queued [JobResponse]. Use [Client.WaitForJob] (or [Client.ExtractAndWait] for
// a one-shot helper) to obtain the extraction result. opts.Webhook, when set,
// asks the server to deliver job-completion events to that URL instead of (or
// in addition to) polling.
//
// Part of the shared surface (Enterprise + Pro).
func (c *Client) Extract(
	ctx context.Context,
	file FileSource,
	opts *ExtractOptions,
) (*JobResponse, error) {
	jobs, err := c.ExtractBatch(ctx, []FileSource{file}, opts)
	if err != nil {
		return nil, err
	}
	if len(jobs) == 0 {
		return nil, fmt.Errorf("xberg: server accepted extract request but returned no job IDs")
	}
	return jobs[0], nil
}

// ExtractBatch submits multiple documents in a single multipart request. The
// server returns one job ID per file (in submission order); each is then
// fetched via [Client.GetJob] so callers receive fully-typed [JobResponse]
// values, mirroring the Python SDK.
//
// Part of the shared surface (Enterprise + Pro).
func (c *Client) ExtractBatch(
	ctx context.Context,
	files []FileSource,
	opts *ExtractOptions,
) ([]*JobResponse, error) {
	if len(files) == 0 {
		return nil, fmt.Errorf("xberg: ExtractBatch requires at least one file")
	}
	if err := validateFileSources(files); err != nil {
		return nil, err
	}
	// Validated before buildMultipartBody so a misaligned or conflicting
	// Configs slice fails without first draining every FileSource.Reader,
	// which is single-use and cannot be replayed for a corrected call.
	if err := validatePerFileConfigs(files, configsOf(opts)); err != nil {
		return nil, err
	}
	documentIDs, err := c.prepareDocumentLineage(ctx, files, opts)
	if err != nil {
		return nil, err
	}
	body, contentType, err := buildMultipartBody(files, opts, documentIDs)
	if err != nil {
		return nil, err
	}
	var resp ExtractResponse
	spec := requestSpec{
		method:          methodPost,
		path:            "/v1/extract",
		body:            bytes.NewReader(body),
		bodyContentType: contentType,
		rewindBody: func() (io.Reader, error) {
			return bytes.NewReader(body), nil
		},
	}
	if err := c.doJSON(ctx, spec, &resp); err != nil {
		return nil, err
	}
	jobIDs := []string{}
	if resp.JobIds != nil {
		jobIDs = *resp.JobIds
	}
	if len(jobIDs) == 0 {
		return nil, fmt.Errorf("xberg: extract response contained no job IDs")
	}
	if len(jobIDs) != len(files) {
		return nil, fmt.Errorf("xberg: expected %d job IDs, got %d", len(files), len(jobIDs))
	}
	jobs := make([]*JobResponse, len(jobIDs))
	for i, id := range jobIDs {
		job, err := c.GetJob(ctx, id)
		if err != nil {
			return nil, err
		}
		jobs[i] = job
	}
	return jobs, nil
}

// buildMultipartBody serializes files and an optional [ExtractOptions] into a
// multipart/form-data body matching the API's documented wire format:
//
//	parts: file (one per document) + optional "options" (JSON string) +
//	       optional "webhook" (JSON string) + optional "config-<filename>"
//	       (JSON string, one per document carrying a per-file override)
//
// The "options", "webhook" and "config-<filename>" parts are omitted entirely
// when the corresponding field is nil, rather than sending an empty placeholder.
func buildMultipartBody(
	files []FileSource,
	opts *ExtractOptions,
	documentIDs map[string]string,
) ([]byte, string, error) {
	var buf bytes.Buffer
	writer := multipart.NewWriter(&buf)
	// ~keep The Enterprise parser captures lineage when reading each file part.
	if err := writeDocumentLineage(writer, documentIDs); err != nil {
		return nil, "", err
	}
	if err := writeFileParts(writer, files); err != nil {
		return nil, "", err
	}
	if opts != nil && opts.Extraction != nil {
		encoded, err := json.Marshal(opts.Extraction)
		if err != nil {
			return nil, "", fmt.Errorf("xberg: encoding options: %w", err)
		}
		if err := writer.WriteField("options", string(encoded)); err != nil {
			return nil, "", fmt.Errorf("xberg: writing options field: %w", err)
		}
	}
	if opts != nil && opts.Webhook != nil {
		// gosec flags WebhookConfig.Secret as a hardcoded-secret pattern match;
		// it is a caller-supplied HMAC secret that belongs in the request body,
		// not a leaked credential.
		encoded, err := json.Marshal(opts.Webhook) //nolint:gosec
		if err != nil {
			return nil, "", fmt.Errorf("xberg: encoding webhook: %w", err)
		}
		if err := writer.WriteField("webhook", string(encoded)); err != nil {
			return nil, "", fmt.Errorf("xberg: writing webhook field: %w", err)
		}
	}
	if err := writeConfigParts(writer, files, configsOf(opts)); err != nil {
		return nil, "", err
	}
	if err := writer.Close(); err != nil {
		return nil, "", fmt.Errorf("xberg: closing multipart writer: %w", err)
	}
	return buf.Bytes(), writer.FormDataContentType(), nil
}

// configsOf reads the per-file overrides off opts, tolerating a nil opts.
func configsOf(opts *ExtractOptions) []*FileExtractionConfig {
	if opts == nil {
		return nil
	}
	return opts.Configs
}

// encodePerFileConfig renders one override as its JSON part value, or "" when
// the entry is nil. A non-nil config always encodes to at least "{}", so the
// empty string is an unambiguous "no override" marker.
func encodePerFileConfig(config *FileExtractionConfig, filename string) (string, error) {
	if config == nil {
		return "", nil
	}
	raw, err := json.Marshal(config)
	if err != nil {
		return "", fmt.Errorf("xberg: encoding config for file %q: %w", filename, err)
	}
	return string(raw), nil
}

// validatePerFileConfigs rejects a Configs slice that cannot be expressed on the
// multipart wire: one that is not aligned with files, and one that asks for two
// different overrides under a single filename.
//
// The second case is the real constraint of this transport. A "config-<filename>"
// part is keyed on the name, so a batch carrying the same document twice under
// different instructions has one slot for two answers. Erroring names the file
// and points at the fix; the alternative is sending whichever config was written
// last and losing the other with no signal at all.
func validatePerFileConfigs(files []FileSource, configs []*FileExtractionConfig) error {
	// nil means "no overrides"; an explicitly supplied empty slice does not, and
	// is a length mismatch like any other. Python and TypeScript draw the line
	// in the same place (None/undefined skips, [] does not), and conflating the
	// two here would turn a caller's emptied slice into a silent no-op in Go
	// alone.
	if configs == nil {
		return nil
	}
	if len(configs) != len(files) {
		return fmt.Errorf(
			"xberg: ExtractOptions.Configs has %d entries but %d files were supplied; "+
				"pass exactly one entry per file (nil for no override)",
			len(configs), len(files),
		)
	}
	seen := make(map[string]string, len(files))
	for i, file := range files {
		encoded, err := encodePerFileConfig(configs[i], file.Name)
		if err != nil {
			return err
		}
		prior, repeated := seen[file.Name]
		if repeated && prior != encoded {
			return fmt.Errorf(
				"xberg: per-file config conflict for %q: the same filename appears more than once "+
					"in this batch with different configs, but a multipart request carries at most "+
					"one config part per filename; give the copies distinct filenames",
				file.Name,
			)
		}
		seen[file.Name] = encoded
	}
	return nil
}

// writeConfigParts appends one "config-<filename>" JSON text part per document
// carrying a per-file override, after the file, options and webhook parts so a
// request without overrides is byte-identical to one built before they existed.
//
// Assumes validatePerFileConfigs has already run: duplicate filenames therefore
// carry identical configs here, and the part is written once for each name.
func writeConfigParts(writer *multipart.Writer, files []FileSource, configs []*FileExtractionConfig) error {
	if len(configs) == 0 {
		return nil
	}
	written := make(map[string]struct{}, len(files))
	for i, file := range files {
		encoded, err := encodePerFileConfig(configs[i], file.Name)
		if err != nil {
			return err
		}
		if _, done := written[file.Name]; encoded == "" || done {
			continue
		}
		if err := writer.WriteField("config-"+file.Name, encoded); err != nil {
			return fmt.Errorf("xberg: writing config-%s field: %w", file.Name, err)
		}
		written[file.Name] = struct{}{}
	}
	return nil
}

// writeFileParts appends one "file" part per document to writer, tagging each
// with a filename and a sniffed media type. Shared by the extraction and
// auto-tune submissions, which use the same repeated "file" part convention.
func writeFileParts(writer *multipart.Writer, files []FileSource) error {
	for _, file := range files {
		header := textproto.MIMEHeader{}
		header.Set(
			"Content-Disposition",
			// %q escapes the quotes and control characters a filename could
			// carry into this header on its own; pre-replacing them first only
			// escapes them twice.
			fmt.Sprintf(`form-data; name="file"; filename=%q`, file.Name),
		)
		header.Set("Content-Type", sniffContentType(file.Name))
		part, err := writer.CreatePart(header)
		if err != nil {
			return fmt.Errorf("xberg: creating multipart part: %w", err)
		}
		if _, err := io.Copy(part, file.Reader); err != nil {
			return fmt.Errorf("xberg: copying file %q into multipart body: %w", file.Name, err)
		}
	}
	return nil
}

// validateFileSources rejects file sources that cannot be serialized into a
// multipart body, naming the offending index so the caller can fix it.
func validateFileSources(files []FileSource) error {
	for i, f := range files {
		if f.Name == "" {
			return fmt.Errorf("xberg: file %d: Name must not be empty", i)
		}
		if f.Reader == nil {
			return fmt.Errorf("xberg: file %d (%s): Reader must not be nil", i, f.Name)
		}
	}
	return nil
}

// sniffContentType picks a reasonable multipart Content-Type for a filename.
// We map a small set of common extensions; everything else falls back to the
// generic application/octet-stream which the server accepts.
func sniffContentType(filename string) string {
	lower := strings.ToLower(filename)
	switch {
	case strings.HasSuffix(lower, ".pdf"):
		return "application/pdf"
	case strings.HasSuffix(lower, ".png"):
		return "image/png"
	case strings.HasSuffix(lower, ".jpg"), strings.HasSuffix(lower, ".jpeg"):
		return "image/jpeg"
	case strings.HasSuffix(lower, ".txt"):
		return "text/plain"
	case strings.HasSuffix(lower, ".md"):
		return "text/markdown"
	case strings.HasSuffix(lower, ".csv"):
		return "text/csv"
	case strings.HasSuffix(lower, ".docx"):
		return "application/vnd.openxmlformats-officedocument.wordprocessingml.document"
	default:
		return "application/octet-stream"
	}
}
