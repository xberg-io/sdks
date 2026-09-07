package xberg

import (
	"bytes"
	"context"
	"errors"
	"fmt"
	"io"
	"mime/multipart"
	"net/http"
	"net/url"
)

// OAuthCallback exchanges an OAuth code and returns the redirect location without following it.
// No API key or control-plane bearer is sent to this public endpoint.
func (c *Client) OAuthCallback(ctx context.Context, code, state string) (string, error) {
	transport, err := c.controlPlaneClient(ctx, "OAuthCallback", controlPlanePublic)
	if err != nil {
		return "", err
	}
	if transport.cfg.timeout > 0 {
		var cancel context.CancelFunc
		ctx, cancel = context.WithTimeout(ctx, transport.cfg.timeout)
		defer cancel()
	}
	path := "/v1/oauth/callback"
	endpoint := transport.urlFor(path)
	req, err := http.NewRequestWithContext(ctx, methodGet, endpoint, nil)
	if err != nil {
		return "", fmt.Errorf("xberg: constructing OAuth callback: %w", err)
	}
	req.URL.RawQuery = url.Values{"code": {code}, "state": {state}}.Encode()
	if err = transport.authorize(ctx, req); err != nil {
		return "", err
	}
	client := *transport.cfg.httpClient
	client.CheckRedirect = func(_ *http.Request, _ []*http.Request) error { return http.ErrUseLastResponse }
	resp, err := client.Do(req)
	if err != nil {
		var requestError *url.Error
		if errors.As(err, &requestError) {
			err = requestError.Err
		}
		return "", &ConnectionError{Method: methodGet, URL: endpoint, Cause: err}
	}
	defer closeQuietly(resp.Body)
	if resp.StatusCode == http.StatusSeeOther {
		location := resp.Header.Get("Location")
		if location == "" {
			return "", fmt.Errorf("xberg: OAuth callback returned no redirect location")
		}
		return location, nil
	}
	body, err := io.ReadAll(resp.Body)
	if err != nil {
		return "", fmt.Errorf("xberg: reading OAuth callback response: %w", err)
	}
	return "", classifyHTTPError(resp.StatusCode, body, resp.Header)
}

// BackendFetchIntegrationDocument downloads original document bytes from the Enterprise control plane.
func (c *Client) BackendFetchIntegrationDocument(ctx context.Context, projectID, integrationID, documentID string) ([]byte, error) {
	transport, err := c.controlPlaneClient(ctx, "BackendFetchIntegrationDocument", controlPlaneAuthenticated)
	if err != nil {
		return nil, err
	}
	return transport.getBytes(ctx, integrationPath(projectID, integrationID, "/documents/"+url.PathEscape(documentID)))
}

// PublicSandboxOptions selects a public extraction mode and optional OIDC credential.
// Token is specific to the public sandbox and never falls back to the client's credentials.
type PublicSandboxOptions struct {
	Mode   string
	Preset string
	URL    string
	Token  string
}

// SandboxExtract extracts a single file using a project's Enterprise sandbox.
func (c *Client) SandboxExtract(ctx context.Context, projectID string, file FileSource) (*SandboxExtractResponse, error) {
	transport, err := c.controlPlaneClient(ctx, "SandboxExtract", controlPlaneAuthenticated)
	if err != nil {
		return nil, err
	}
	return sandboxMultipart(ctx, transport, projectPath(projectID, "/sandbox/extract"), &file, nil)
}

// PublicSandboxExtract submits a file, or a URL in web mode, to the Enterprise public sandbox.
// OIDC authentication can be supplied through options.Token; project and session credentials are omitted.
func (c *Client) PublicSandboxExtract(ctx context.Context, file *FileSource, options *PublicSandboxOptions) (*SandboxExtractResponse, error) {
	transport, err := c.controlPlaneClient(ctx, "PublicSandboxExtract", controlPlanePublic)
	if err != nil {
		return nil, err
	}
	if options != nil {
		transport.cfg.apiKey = options.Token
	}
	return sandboxMultipart(ctx, transport, "/v1/sandbox/public/extract", file, options)
}

func sandboxMultipart(ctx context.Context, c *Client, path string, file *FileSource, options *PublicSandboxOptions) (*SandboxExtractResponse, error) {
	var buffer bytes.Buffer
	writer := multipart.NewWriter(&buffer)
	if file != nil {
		files := []FileSource{*file}
		if err := validateFileSources(files); err != nil {
			return nil, err
		}
		if err := writeFileParts(writer, files); err != nil {
			return nil, err
		}
	}
	if options != nil {
		for key, value := range map[string]string{"mode": options.Mode, "preset": options.Preset, "url": options.URL} {
			if value != "" {
				if err := writer.WriteField(key, value); err != nil {
					return nil, fmt.Errorf("xberg: writing sandbox field: %w", err)
				}
			}
		}
	}
	if err := writer.Close(); err != nil {
		return nil, fmt.Errorf("xberg: closing sandbox multipart: %w", err)
	}
	body := buffer.Bytes()
	spec := requestSpec{method: methodPost, path: path, body: bytes.NewReader(body), bodyContentType: writer.FormDataContentType(), rewindBody: func() (io.Reader, error) { return bytes.NewReader(body), nil }}
	var out SandboxExtractResponse
	if err := c.doJSON(ctx, spec, &out); err != nil {
		return nil, err
	}
	return &out, nil
}
