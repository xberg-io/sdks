package xberg

import (
	"context"
	"fmt"
	"net/url"
	"strings"
)

const extractPath = "/v1/extract"

type proProjectKey struct{}

// WithProProject selects a Pro project for extraction and job operations,
// usage/audit, upload preparation, RAG collection CRUD, document add/delete
// and retrieval. Extraction/job selection requires Pro. Enterprise ignores
// selection for shared usage/audit/upload/RAG operations. Unrelated routes
// ignore it. Context deadlines and cancellation are preserved. ~keep
func WithProProject(ctx context.Context, projectID string) context.Context {
	return context.WithValue(ctx, proProjectKey{}, projectID)
}

func ownsJobProjectScope(method, path string) bool {
	parts := strings.Split(strings.TrimPrefix(path, "/"), "/")
	if path == extractPath {
		return method == methodPost
	}
	if ownsCrawlOrEnrichProjectScope(method, parts) {
		return true
	}
	if len(parts) < 2 || parts[0] != "v1" || parts[1] != "jobs" {
		return false
	}
	if method == methodDelete {
		return len(parts) == 3 && parts[2] != ""
	}
	if method != methodGet {
		return false
	}
	return len(parts) == 2 || (len(parts) == 3 && parts[2] != "") ||
		(len(parts) == 4 && parts[2] != "" && parts[3] == "result") ||
		(len(parts) == 5 && parts[2] != "" && parts[3] == "pages" && parts[4] != "")
}

func ownsCrawlOrEnrichProjectScope(method string, parts []string) bool {
	if len(parts) < 2 || parts[0] != "v1" {
		return false
	}
	if parts[1] == "enrich" {
		return (method == methodPost && len(parts) == 2) ||
			(method == methodGet && len(parts) == 3 && parts[2] != "")
	}
	return method == methodGet && len(parts) == 4 && parts[1] == "crawl-jobs" &&
		parts[2] != "" && parts[3] == "events"
}

func ownsRagHeaderProjectScope(method, path string) bool {
	parts := strings.Split(strings.TrimPrefix(path, "/"), "/")
	if len(parts) < 3 || parts[0] != "v1" || parts[1] != "rag" || parts[2] != "collections" {
		return false
	}
	if len(parts) == 3 {
		return method == methodGet || method == methodPost
	}
	if parts[3] == "" {
		return false
	}
	if len(parts) == 4 {
		return method == methodGet || method == methodDelete
	}
	return len(parts) == 5 && ((parts[4] == "documents" && (method == methodPost || method == methodDelete)) ||
		(parts[4] == "retrieve" && method == methodPost))
}

func (c *Client) applyProProject(ctx context.Context, spec requestSpec) (requestSpec, error) {
	projectID, selected := ctx.Value(proProjectKey{}).(string)
	if !selected {
		return spec, nil
	}
	u, err := url.Parse(spec.path)
	if err != nil {
		return spec, fmt.Errorf("xberg: parsing job request path: %w", err)
	}
	if (spec.method == methodGet && (u.EscapedPath() == "/v1/usage" || u.EscapedPath() == "/v1/audit")) ||
		(spec.method == methodPost && (u.EscapedPath() == presignUploadPath || u.EscapedPath() == confirmUploadPath)) ||
		ownsRagHeaderProjectScope(spec.method, u.EscapedPath()) {
		return c.applyProHeaderProject(ctx, spec, projectID)
	}
	if !ownsJobProjectScope(spec.method, u.EscapedPath()) {
		return spec, nil
	}
	if strings.TrimSpace(projectID) == "" {
		return spec, fmt.Errorf("xberg: Pro project ID must not be blank")
	}
	if err := c.requireTier(ctx, TargetPro, "job project selection"); err != nil {
		return spec, err
	}
	if u.Path == extractPath {
		spec.projectID = projectID
	} else {
		query := u.Query()
		query.Set("project_id", projectID)
		u.RawQuery = query.Encode()
		spec.path = u.String()
	}
	return spec, nil
}

func (c *Client) applyProHeaderProject(ctx context.Context, spec requestSpec, projectID string) (requestSpec, error) {
	tier, err := c.resolveTier(ctx)
	if err != nil {
		return spec, err
	}
	if tier != string(TargetPro) {
		return spec, nil
	}
	if strings.TrimSpace(projectID) == "" {
		return spec, fmt.Errorf("xberg: Pro project ID must not be blank")
	}
	spec.projectID = projectID
	return spec, nil
}
