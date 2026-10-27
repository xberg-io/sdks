package xberg

import (
	"bytes"
	"context"
	"encoding/json"
	"fmt"
	"io"
)

// Presign and confirm are shared operations on both tiers. WithProProject selects
// a Pro project through X-Project-ID; Enterprise ignores that context. Unscoped
// calls preserve the shared behavior without probing the instance tier. ~keep
//
// PutLocalUpload is Pro-only and uses its explicit projectID and capability
// token rather than the selected-project context. ~keep

const (
	presignUploadPath = "/v1/uploads/presign"
	confirmUploadPath = "/v1/uploads/confirm"
	// contentTypeOctetStream is the media type the local-upload endpoint
	// declares for its raw document body.
	contentTypeOctetStream = "application/octet-stream"
)

// PresignUpload requests presigned upload URLs (POST /v1/uploads/presign) and
// returns the decoded body, which carries a batch ID and one entry per object.
//
// Part of the shared surface (Enterprise + Pro).
func (c *Client) PresignUpload(ctx context.Context, body any) (json.RawMessage, error) {
	return c.rawSend(ctx, methodPost, presignUploadPath, body)
}

// ConfirmUpload confirms a presigned upload batch and enqueues extraction
// (POST /v1/uploads/confirm, 202). The response carries the job IDs the batch
// produced.
//
// Part of the shared surface (Enterprise + Pro).
func (c *Client) ConfirmUpload(ctx context.Context, body any) (json.RawMessage, error) {
	return c.rawSend(ctx, methodPost, confirmUploadPath, body)
}

// PresignUploadTyped is [Client.PresignUpload] decoded into the generated
// [PresignUploadResponse] (batch ID plus one [PresignedUploadInfo] per object).
// Both tiers return the same shape. PresignUpload keeps its json.RawMessage
// result for existing callers.
//
// Part of the shared surface (Enterprise + Pro).
func (c *Client) PresignUploadTyped(ctx context.Context, body any) (*PresignUploadResponse, error) {
	var out PresignUploadResponse
	if err := c.callJSON(ctx, methodPost, presignUploadPath, body, &out); err != nil {
		return nil, err
	}
	return &out, nil
}

// ConfirmUploadTyped is [Client.ConfirmUpload] decoded into the generated
// [ConfirmUploadResponse] (the queued job IDs and their status). Both tiers
// return the same shape. ConfirmUpload keeps its json.RawMessage result for
// existing callers.
//
// Part of the shared surface (Enterprise + Pro).
func (c *Client) ConfirmUploadTyped(ctx context.Context, body any) (*ConfirmUploadResponse, error) {
	var out ConfirmUploadResponse
	if err := c.callJSON(ctx, methodPost, confirmUploadPath, body, &out); err != nil {
		return nil, err
	}
	return &out, nil
}

// PutLocalUpload writes raw document bytes against a presigned capability
// (PUT /v1/uploads/local/{projectID}/{token}, 204). token is the one-use,
// expiring capability [Client.PresignUpload] issued for this object, and the
// accepted size is the limit recorded when it was minted — a larger body is
// rejected with 413. Pro only.
func (c *Client) PutLocalUpload(ctx context.Context, projectID, token string, content []byte) error {
	if err := c.requireTier(ctx, TargetPro, "PutLocalUpload"); err != nil {
		return err
	}
	if projectID == "" || token == "" {
		return fmt.Errorf("xberg: PutLocalUpload requires a non-empty projectID and token")
	}
	path := "/v1/uploads/local/" + escapePathSegment(projectID) + "/" + escapePathSegment(token)
	spec := requestSpec{
		method:          methodPut,
		path:            path,
		body:            bytes.NewReader(content),
		bodyContentType: contentTypeOctetStream,
		rewindBody:      func() (io.Reader, error) { return bytes.NewReader(content), nil },
	}
	return c.doJSON(ctx, spec, nil)
}
