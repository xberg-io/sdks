package kreuzbergcloud

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

// Extract submits a single document for asynchronous extraction and returns
// the queued [Job]. Use [Client.WaitForJob] (or [Client.ExtractAndWait] for a
// one-shot helper) to obtain the extraction result.
func (c *Client) Extract(
	ctx context.Context,
	file FileSource,
	opts *ExtractionOptions,
) (*Job, error) {
	jobs, err := c.ExtractBatch(ctx, []FileSource{file}, opts)
	if err != nil {
		return nil, err
	}
	if len(jobs) == 0 {
		return nil, fmt.Errorf("xberg-enterprise: server accepted extract request but returned no job IDs")
	}
	return jobs[0], nil
}

// ExtractBatch submits multiple documents in a single multipart request.
// Each file becomes one Job in the response, in submission order.
func (c *Client) ExtractBatch(
	ctx context.Context,
	files []FileSource,
	opts *ExtractionOptions,
) ([]*Job, error) {
	if len(files) == 0 {
		return nil, fmt.Errorf("xberg-enterprise: ExtractBatch requires at least one file")
	}
	for i, f := range files {
		if f.Name == "" {
			return nil, fmt.Errorf("xberg-enterprise: file %d: Name must not be empty", i)
		}
		if f.Reader == nil {
			return nil, fmt.Errorf("xberg-enterprise: file %d (%s): Reader must not be nil", i, f.Name)
		}
	}
	body, contentType, err := buildMultipartBody(files, opts)
	if err != nil {
		return nil, err
	}
	var resp extractResponse
	spec := requestSpec{
		method:          "POST",
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
	if len(resp.JobIDs) != len(files) {
		return nil, fmt.Errorf(
			"xberg-enterprise: expected %d job IDs, got %d",
			len(files), len(resp.JobIDs),
		)
	}
	jobs := make([]*Job, len(resp.JobIDs))
	for i, id := range resp.JobIDs {
		filename := ""
		if i < len(files) {
			filename = files[i].Name
		}
		jobs[i] = &Job{ID: id, Filename: filename, Status: resp.Status}
	}
	return jobs, nil
}

// buildMultipartBody serializes files and optional ExtractionOptions into a
// multipart/form-data body matching the API's documented wire format:
//
//	parts: file (one per document) + optional "options" (JSON string) + "webhook" (JSON string)
func buildMultipartBody(
	files []FileSource,
	opts *ExtractionOptions,
) ([]byte, string, error) {
	var buf bytes.Buffer
	writer := multipart.NewWriter(&buf)
	for _, file := range files {
		header := textproto.MIMEHeader{}
		header.Set(
			"Content-Disposition",
			fmt.Sprintf(
				`form-data; name="file"; filename=%q`,
				strings.ReplaceAll(file.Name, `"`, `\"`),
			),
		)
		header.Set("Content-Type", sniffContentType(file.Name))
		part, err := writer.CreatePart(header)
		if err != nil {
			return nil, "", fmt.Errorf("xberg-enterprise: creating multipart part: %w", err)
		}
		if _, err := io.Copy(part, file.Reader); err != nil {
			return nil, "", fmt.Errorf(
				"xberg-enterprise: copying file %q into multipart body: %w",
				file.Name, err,
			)
		}
	}
	if opts != nil {
		encoded, err := json.Marshal(opts)
		if err != nil {
			return nil, "", fmt.Errorf("xberg-enterprise: encoding options: %w", err)
		}
		if err := writer.WriteField("options", string(encoded)); err != nil {
			return nil, "", fmt.Errorf("xberg-enterprise: writing options field: %w", err)
		}
	}
	if err := writer.WriteField("webhook", `{"url":""}`); err != nil {
		return nil, "", fmt.Errorf("xberg-enterprise: writing webhook field: %w", err)
	}
	if err := writer.Close(); err != nil {
		return nil, "", fmt.Errorf("xberg-enterprise: closing multipart writer: %w", err)
	}
	return buf.Bytes(), writer.FormDataContentType(), nil
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
