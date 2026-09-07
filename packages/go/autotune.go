package xberg

import (
	"bytes"
	"context"
	"encoding/json"
	"fmt"
	"io"
	"mime/multipart"
)

// Auto-tune and the tuning-profile registry it promotes into are part of the
// shared surface: both the Enterprise and the Pro spec declare `/v1/auto-tune`
// and `/v1/tuning-profiles` with identical shapes, so none of the methods below
// is tier-gated.

const (
	autoTunePath       = "/v1/auto-tune"
	tuningProfilesPath = "/v1/tuning-profiles"
	// autoTuneRequestPart is the multipart field carrying the JSON-encoded
	// [CreateAutoTuneJobRequest] alongside the repeated "file" parts.
	autoTuneRequestPart = "request"
)

// autoTuneJobPath renders an auto-tune job route, escaping the job ID. suffix
// is appended verbatim and must already start with "/" when non-empty.
func autoTuneJobPath(autoTuneJobID, suffix string) string {
	return autoTunePath + "/" + escapePathSegment(autoTuneJobID) + suffix
}

// ListAutoTuneJobs lists the project's auto-tune jobs (GET /v1/auto-tune,
// paginated). A non-positive limit or offset is omitted from the query string,
// leaving the server's default.
//
// Part of the shared surface (Enterprise + Pro).
func (c *Client) ListAutoTuneJobs(ctx context.Context, limit, offset int) (*ListAutoTuneJobsResponse, error) {
	var out ListAutoTuneJobsResponse
	if err := c.getJSON(ctx, autoTunePath+pageQuery(limit, offset), &out); err != nil {
		return nil, err
	}
	return &out, nil
}

// SubmitAutoTune starts an auto-tune run (POST /v1/auto-tune). The request is
// multipart/form-data: request is sent as a JSON "request" part and each file
// as a repeated "file" part, whose filename must match a
// [AutoTuneDocumentInput.Filename] entry in request.Documents.
//
// Part of the shared surface (Enterprise + Pro).
func (c *Client) SubmitAutoTune(
	ctx context.Context,
	request CreateAutoTuneJobRequest,
	files []FileSource,
) (*CreateAutoTuneJobResponse, error) {
	if len(files) == 0 {
		return nil, fmt.Errorf("xberg: SubmitAutoTune requires at least one file")
	}
	if err := validateFileSources(files); err != nil {
		return nil, err
	}
	body, contentType, err := buildAutoTuneMultipartBody(request, files)
	if err != nil {
		return nil, err
	}
	spec := requestSpec{
		method:          methodPost,
		path:            autoTunePath,
		body:            bytes.NewReader(body),
		bodyContentType: contentType,
		rewindBody: func() (io.Reader, error) {
			return bytes.NewReader(body), nil
		},
	}
	var out CreateAutoTuneJobResponse
	if err := c.doJSON(ctx, spec, &out); err != nil {
		return nil, err
	}
	return &out, nil
}

// GetAutoTuneCapabilities reports the OCR backends and tunable knobs this
// deployment can search over (GET /v1/auto-tune/capabilities).
//
// Part of the shared surface (Enterprise + Pro).
func (c *Client) GetAutoTuneCapabilities(ctx context.Context) (*AutoTuneCapabilitiesResponse, error) {
	var out AutoTuneCapabilitiesResponse
	if err := c.getJSON(ctx, autoTunePath+"/capabilities", &out); err != nil {
		return nil, err
	}
	return &out, nil
}

// GetAutoTuneStatus fetches an auto-tune job's progress
// (GET /v1/auto-tune/{autoTuneJobID}).
//
// Part of the shared surface (Enterprise + Pro).
func (c *Client) GetAutoTuneStatus(ctx context.Context, autoTuneJobID string) (*AutoTuneJobStatus, error) {
	var out AutoTuneJobStatus
	if err := c.getJSON(ctx, autoTuneJobPath(autoTuneJobID, ""), &out); err != nil {
		return nil, err
	}
	return &out, nil
}

// DeleteAutoTuneJob cancels and deletes an auto-tune job
// (DELETE /v1/auto-tune/{autoTuneJobID}). The endpoint answers 204 with no body.
//
// Part of the shared surface (Enterprise + Pro).
func (c *Client) DeleteAutoTuneJob(ctx context.Context, autoTuneJobID string) error {
	return c.callJSON(ctx, methodDelete, autoTuneJobPath(autoTuneJobID, ""), nil, nil)
}

// PromoteAutoTuneProfile promotes a completed run's winning configuration into
// a named, reusable tuning profile
// (POST /v1/auto-tune/{autoTuneJobID}/promote).
//
// Part of the shared surface (Enterprise + Pro).
func (c *Client) PromoteAutoTuneProfile(
	ctx context.Context,
	autoTuneJobID string,
	body PromoteProfileRequest,
) (*TuningProfileDetail, error) {
	var out TuningProfileDetail
	if err := c.callJSON(ctx, methodPost, autoTuneJobPath(autoTuneJobID, "/promote"), body, &out); err != nil {
		return nil, err
	}
	return &out, nil
}

// GetAutoTuneResult fetches a completed run's leaderboard and winning profile
// (GET /v1/auto-tune/{autoTuneJobID}/result).
//
// Part of the shared surface (Enterprise + Pro).
func (c *Client) GetAutoTuneResult(ctx context.Context, autoTuneJobID string) (*AutoTuneResult, error) {
	var out AutoTuneResult
	if err := c.getJSON(ctx, autoTuneJobPath(autoTuneJobID, "/result"), &out); err != nil {
		return nil, err
	}
	return &out, nil
}

// ListTuningProfiles lists the project's promoted tuning profiles
// (GET /v1/tuning-profiles, paginated). A non-positive limit or offset is
// omitted from the query string, leaving the server's default.
//
// Part of the shared surface (Enterprise + Pro).
func (c *Client) ListTuningProfiles(ctx context.Context, limit, offset int) (*ListTuningProfilesResponse, error) {
	var out ListTuningProfilesResponse
	if err := c.getJSON(ctx, tuningProfilesPath+pageQuery(limit, offset), &out); err != nil {
		return nil, err
	}
	return &out, nil
}

// GetTuningProfile fetches one promoted tuning profile
// (GET /v1/tuning-profiles/{profileID}).
//
// Part of the shared surface (Enterprise + Pro).
func (c *Client) GetTuningProfile(ctx context.Context, profileID string) (*TuningProfileDetail, error) {
	var out TuningProfileDetail
	if err := c.getJSON(ctx, tuningProfilesPath+"/"+escapePathSegment(profileID), &out); err != nil {
		return nil, err
	}
	return &out, nil
}

// DeleteTuningProfile deletes a promoted tuning profile
// (DELETE /v1/tuning-profiles/{profileID}). The endpoint answers 204 with no
// body.
//
// Part of the shared surface (Enterprise + Pro).
func (c *Client) DeleteTuningProfile(ctx context.Context, profileID string) error {
	path := tuningProfilesPath + "/" + escapePathSegment(profileID)
	return c.callJSON(ctx, methodDelete, path, nil, nil)
}

// buildAutoTuneMultipartBody serializes an auto-tune submission into the wire
// format the API documents: a JSON "request" part plus one "file" part per
// document.
func buildAutoTuneMultipartBody(
	request CreateAutoTuneJobRequest,
	files []FileSource,
) ([]byte, string, error) {
	var buf bytes.Buffer
	writer := multipart.NewWriter(&buf)
	encoded, err := json.Marshal(request)
	if err != nil {
		return nil, "", fmt.Errorf("xberg: encoding auto-tune request: %w", err)
	}
	if err := writer.WriteField(autoTuneRequestPart, string(encoded)); err != nil {
		return nil, "", fmt.Errorf("xberg: writing auto-tune request field: %w", err)
	}
	if err := writeFileParts(writer, files); err != nil {
		return nil, "", err
	}
	if err := writer.Close(); err != nil {
		return nil, "", fmt.Errorf("xberg: closing multipart writer: %w", err)
	}
	return buf.Bytes(), writer.FormDataContentType(), nil
}
