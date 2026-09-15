package xberg

import (
	"bytes"
	"context"
	"encoding/json"
	"fmt"
	"io"
)

// The presigned-upload flow is part of the shared surface: both specs declare
// `/v1/uploads/presign` and `/v1/uploads/confirm` with the same request and
// response schemas, so neither is tier-gated. They differ only in optional
// scoping — Enterprise accepts an extra optional `X-Project-ID` header — which
// the client does not send on either tier. Both endpoints declare their bodies
// as named schemas but are exposed untyped here, matching the Python and
// TypeScript SDKs.
//
// [Client.PutLocalUpload] is the exception: writing bytes back through the
// local object store is Pro-only, and is gated accordingly.

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
