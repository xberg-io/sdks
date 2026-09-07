package xberg

import (
	"context"
	"encoding/json"
)

// The RAG API is part of the shared surface (Enterprise + Pro). Its request and
// response bodies are returned as [json.RawMessage] so callers can decode
// against whichever server version they target — mirroring the Python/TS SDKs,
// which expose these endpoints untyped.

// ListRagCollections lists RAG collections (GET /v1/rag/collections).
func (c *Client) ListRagCollections(ctx context.Context) (json.RawMessage, error) {
	return c.ragGet(ctx, "/v1/rag/collections")
}

// CreateRagCollection creates a RAG collection (POST /v1/rag/collections).
func (c *Client) CreateRagCollection(ctx context.Context, body any) (json.RawMessage, error) {
	return c.ragSend(ctx, methodPost, "/v1/rag/collections", body)
}

// GetRagCollection fetches a RAG collection (GET /v1/rag/collections/{name}).
func (c *Client) GetRagCollection(ctx context.Context, name string) (json.RawMessage, error) {
	return c.ragGet(ctx, "/v1/rag/collections/"+escapePathSegment(name))
}

// DeleteRagCollection deletes a RAG collection (DELETE /v1/rag/collections/{name}).
// The endpoint answers 204 with no body.
func (c *Client) DeleteRagCollection(ctx context.Context, name string) error {
	return c.callJSON(ctx, methodDelete, "/v1/rag/collections/"+escapePathSegment(name), nil, nil)
}

// AddRagDocuments adds documents to a RAG collection
// (POST /v1/rag/collections/{name}/documents).
func (c *Client) AddRagDocuments(ctx context.Context, name string, body any) (json.RawMessage, error) {
	return c.ragSend(ctx, methodPost, "/v1/rag/collections/"+escapePathSegment(name)+"/documents", body)
}

// DeleteRagDocuments deletes documents from a RAG collection by ID or filter
// expression (DELETE /v1/rag/collections/{name}/documents). The response
// carries the deleted count.
func (c *Client) DeleteRagDocuments(ctx context.Context, name string, body any) (json.RawMessage, error) {
	return c.ragSend(ctx, methodDelete, "/v1/rag/collections/"+escapePathSegment(name)+"/documents", body)
}

// ReindexRagDocument reindexes a RAG document
// (POST /v1/rag/collections/{name}/documents/{id}/reindex).
func (c *Client) ReindexRagDocument(ctx context.Context, name, documentID string, body any) (json.RawMessage, error) {
	path := "/v1/rag/collections/" + escapePathSegment(name) + "/documents/" + escapePathSegment(documentID) + "/reindex"
	return c.ragSend(ctx, methodPost, path, body)
}

// RagRetrieve retrieves chunks from a RAG collection
// (POST /v1/rag/collections/{name}/retrieve).
func (c *Client) RagRetrieve(ctx context.Context, name string, body any) (json.RawMessage, error) {
	return c.ragSend(ctx, methodPost, "/v1/rag/collections/"+escapePathSegment(name)+"/retrieve", body)
}

// MigrateRagEmbeddings kicks off an embedding migration
// (POST /v1/rag/collections/{name}/migrate-embeddings).
func (c *Client) MigrateRagEmbeddings(ctx context.Context, name string, body any) (json.RawMessage, error) {
	return c.ragSend(ctx, methodPost, "/v1/rag/collections/"+escapePathSegment(name)+"/migrate-embeddings", body)
}

// GetRagMigrationJob polls an embedding-migration job
// (GET /v1/rag/collections/{name}/migrate-embeddings/{jobID}).
func (c *Client) GetRagMigrationJob(ctx context.Context, name, jobID string) (json.RawMessage, error) {
	path := "/v1/rag/collections/" + escapePathSegment(name) + "/migrate-embeddings/" + escapePathSegment(jobID)
	return c.ragGet(ctx, path)
}

// GetRagJob fetches a RAG job's status (GET /v1/rag/jobs/{jobID}).
func (c *Client) GetRagJob(ctx context.Context, jobID string) (json.RawMessage, error) {
	return c.ragGet(ctx, "/v1/rag/jobs/"+escapePathSegment(jobID))
}

func (c *Client) ragGet(ctx context.Context, path string) (json.RawMessage, error) {
	var out json.RawMessage
	if err := c.getJSON(ctx, path, &out); err != nil {
		return nil, err
	}
	return out, nil
}

func (c *Client) ragSend(ctx context.Context, method, path string, body any) (json.RawMessage, error) {
	var out json.RawMessage
	if err := c.callJSON(ctx, method, path, body, &out); err != nil {
		return nil, err
	}
	return out, nil
}
