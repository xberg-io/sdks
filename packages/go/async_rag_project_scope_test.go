package xberg_test

import (
	"context"
	"encoding/json"
	"fmt"
	"net/http"
	"sync"
	"testing"

	xberg "github.com/xberg-io/sdks/packages/go"
)

const asyncRagReindexBody = `{"re_extract":false}`

func asyncRagProjectCases() []ragScopeCase {
	const collection = "/v1/rag/collections/scope-owned"
	return []ragScopeCase{
		{"ReindexRagDocument", "POST", collection + "/documents/owned-doc/reindex", asyncRagReindexBody,
			func(c *xberg.Client, ctx context.Context) (json.RawMessage, error) {
				return c.ReindexRagDocument(ctx, ragScopeCollection, "owned-doc", json.RawMessage(asyncRagReindexBody))
			}},
		{"MigrateRagEmbeddings", "POST", collection + "/migrate-embeddings", `{}`,
			func(c *xberg.Client, ctx context.Context) (json.RawMessage, error) {
				return c.MigrateRagEmbeddings(ctx, ragScopeCollection, json.RawMessage(`{}`))
			}},
		{"GetRagMigrationJob", "GET", collection + "/migrate-embeddings/owned-job", "",
			func(c *xberg.Client, ctx context.Context) (json.RawMessage, error) {
				return c.GetRagMigrationJob(ctx, ragScopeCollection, "owned-job")
			}},
		{"GetRagJob", "GET", "/v1/rag/jobs/owned-job", "",
			func(c *xberg.Client, ctx context.Context) (json.RawMessage, error) {
				return c.GetRagJob(ctx, "owned-job")
			}},
	}
}

type asyncRagTierCase struct {
	name, tier string
	target     xberg.Target
}

func asyncRagTierCases() []asyncRagTierCase {
	return []asyncRagTierCase{
		{"explicit-pro", "pro", xberg.TargetPro}, {"auto-pro", "pro", ""},
		{"explicit-enterprise", "enterprise", xberg.TargetEnterprise}, {"auto-enterprise", "enterprise", ""},
	}
}

func asyncRagProbe(t *testing.T, r *http.Request, tier string) *http.Response {
	t.Helper()
	if r.Method != "GET" || r.URL.RequestURI() != "/healthz" || r.Header.Get("X-Project-ID") != "" ||
		r.Header.Get("Authorization") != "Bearer synthetic-rag-owner" {
		t.Errorf("invalid async RAG probe: %s %s project=%q", r.Method, r.URL, r.Header.Get("X-Project-ID"))
	}
	return scopeReadResponse(fmt.Sprintf(`{"tier":%q}`, tier))
}

func TestSelectedProjectAsyncRagUsesProHeadersAndPreservesEnterprise(t *testing.T) {
	for _, tier := range asyncRagTierCases() {
		t.Run(tier.name, func(t *testing.T) {
			cases := asyncRagProjectCases()
			probes, operations := 0, 0
			transport := jobPollTransport(func(r *http.Request) (*http.Response, error) {
				if r.URL.Path == "/healthz" {
					probes++
					return asyncRagProbe(t, r, tier.tier), nil
				}
				index := operations
				operations++
				if index >= len(cases) {
					t.Error("unexpected duplicate async RAG request")
					return uploadResponse(http.StatusInternalServerError, `{}`), nil
				}
				project := ""
				if tier.tier == "pro" {
					project = scopeProjectID
				}
				return checkRagProjectRequest(t, r, cases[index], project), nil
			})
			client := ragProjectClient(t, tier.target, transport)
			for _, operation := range cases {
				callRagProjectCase(t, client, xberg.WithProProject(context.Background(), scopeProjectID), operation)
			}
			wantProbes := 0
			if tier.target == "" {
				wantProbes = 1
			}
			if len(cases) != 4 || operations != 4 || probes != wantProbes {
				t.Fatalf("cases=%d operations=%d probes=%d want=4/4/%d", len(cases), operations, probes, wantProbes)
			}
		})
	}
}

func TestUnscopedAsyncRagPreservesSharedSurfaceWithoutProbe(t *testing.T) {
	for _, target := range []xberg.Target{xberg.TargetPro, xberg.TargetEnterprise, ""} {
		t.Run(string(target), func(t *testing.T) {
			cases := asyncRagProjectCases()
			operations := 0
			transport := jobPollTransport(func(r *http.Request) (*http.Response, error) {
				index := operations
				operations++
				if index >= len(cases) {
					t.Error("unselected async RAG request caused a probe or duplicate")
					return uploadResponse(http.StatusInternalServerError, `{}`), nil
				}
				return checkRagProjectRequest(t, r, cases[index], ""), nil
			})
			client := ragProjectClient(t, target, transport)
			for _, operation := range cases {
				callRagProjectCase(t, client, context.Background(), operation)
			}
			if operations != 4 {
				t.Fatalf("operations=%d want=4 without tier probes", operations)
			}
		})
	}
}

func TestSelectedProjectAsyncRagRejectsBlankOnProAndIgnoresBlankOnEnterprise(t *testing.T) {
	for _, tier := range asyncRagTierCases() {
		t.Run(tier.name, func(t *testing.T) {
			cases := asyncRagProjectCases()
			probes, operations := 0, 0
			transport := jobPollTransport(func(r *http.Request) (*http.Response, error) {
				if r.URL.Path == "/healthz" {
					probes++
					return asyncRagProbe(t, r, tier.tier), nil
				}
				index := operations
				operations++
				return checkRagProjectRequest(t, r, cases[index%len(cases)], ""), nil
			})
			client := ragProjectClient(t, tier.target, transport)
			ctx := xberg.WithProProject(context.Background(), " \t ")
			for _, operation := range cases {
				if tier.tier == "enterprise" {
					callRagProjectCase(t, client, ctx, operation)
					continue
				}
				if _, err := operation.call(client, ctx); err == nil || err.Error() != "xberg: Pro project ID must not be blank" {
					t.Errorf("%s blank selection error=%v", operation.name, err)
				}
			}
			wantOperations, wantProbes := 0, 0
			if tier.tier == "enterprise" {
				wantOperations = 4
			}
			if tier.target == "" {
				wantProbes = 1
			}
			if operations != wantOperations || probes != wantProbes {
				t.Fatalf("operations=%d probes=%d want=%d/%d", operations, probes, wantOperations, wantProbes)
			}
		})
	}
}

func TestSelectedProjectAsyncRagContextsDoNotLeak(t *testing.T) {
	type projectKey struct{}
	var mutex sync.Mutex
	counts := map[string]int{}
	cases := asyncRagProjectCases()
	transport := jobPollTransport(func(r *http.Request) (*http.Response, error) {
		project, ok := r.Context().Value(projectKey{}).(string)
		if !ok {
			t.Error("async RAG request lost caller context")
		}
		for _, operation := range cases {
			if r.Method == operation.method && r.URL.RequestURI() == operation.uri {
				mutex.Lock()
				counts[project+"/"+operation.name]++
				mutex.Unlock()
				return checkRagProjectRequest(t, r, operation, project), nil
			}
		}
		t.Errorf("unexpected async RAG operation or probe: %s %s", r.Method, r.URL)
		return uploadResponse(http.StatusInternalServerError, `{}`), nil
	})
	client := ragProjectClient(t, xberg.TargetPro, transport)
	var group sync.WaitGroup
	for _, project := range []string{scopeProjectID, extractJobB, ""} {
		group.Go(func() {
			ctx := context.WithValue(context.Background(), projectKey{}, project)
			if project != "" {
				ctx = xberg.WithProProject(ctx, project)
			}
			for _, operation := range cases {
				callRagProjectCase(t, client, ctx, operation)
			}
		})
	}
	group.Wait()
	mutex.Lock()
	defer mutex.Unlock()
	if len(counts) != 12 {
		t.Fatalf("distinct async RAG context/operation requests=%d want=12", len(counts))
	}
	for key, count := range counts {
		if count != 1 {
			t.Errorf("%s requests=%d want=1", key, count)
		}
	}
}

func asyncRagEscapedCases() []ragScopeCase {
	const name = "collection/with?query#fragment%literal"
	const doc = "document/with?query#fragment%literal"
	const job = "job/with?query#fragment%literal"
	const collection = "/v1/rag/collections/collection%2Fwith%3Fquery%23fragment%25literal"
	return []ragScopeCase{
		{"escaped-reindex", "POST", collection + "/documents/document%2Fwith%3Fquery%23fragment%25literal/reindex",
			asyncRagReindexBody, func(c *xberg.Client, ctx context.Context) (json.RawMessage, error) {
				return c.ReindexRagDocument(ctx, name, doc, json.RawMessage(asyncRagReindexBody))
			}},
		{"escaped-migration", "POST", collection + "/migrate-embeddings", `{}`,
			func(c *xberg.Client, ctx context.Context) (json.RawMessage, error) {
				return c.MigrateRagEmbeddings(ctx, name, json.RawMessage(`{}`))
			}},
		{"escaped-migration-job", "GET", collection + "/migrate-embeddings/job%2Fwith%3Fquery%23fragment%25literal", "",
			func(c *xberg.Client, ctx context.Context) (json.RawMessage, error) {
				return c.GetRagMigrationJob(ctx, name, job)
			}},
		{"escaped-rag-job", "GET", "/v1/rag/jobs/job%2Fwith%3Fquery%23fragment%25literal", "",
			func(c *xberg.Client, ctx context.Context) (json.RawMessage, error) { return c.GetRagJob(ctx, job) }},
	}
}

func TestSelectedProjectAsyncRagEscapesEachResourceSegment(t *testing.T) {
	for _, target := range []xberg.Target{xberg.TargetPro, ""} {
		t.Run(string(target), func(t *testing.T) {
			cases := asyncRagEscapedCases()
			probes, operations := 0, 0
			transport := jobPollTransport(func(r *http.Request) (*http.Response, error) {
				if r.URL.Path == "/healthz" {
					probes++
					return asyncRagProbe(t, r, "pro"), nil
				}
				index := operations
				operations++
				if index >= len(cases) {
					t.Error("escaped async RAG duplicate request")
					return uploadResponse(http.StatusInternalServerError, `{}`), nil
				}
				if r.URL.RawQuery != "" || r.URL.Fragment != "" {
					t.Error("resource segment escaped into query or fragment")
				}
				return checkRagProjectRequest(t, r, cases[index], scopeProjectID), nil
			})
			client := ragProjectClient(t, target, transport)
			for _, operation := range cases {
				callRagProjectCase(t, client, xberg.WithProProject(context.Background(), scopeProjectID), operation)
			}
			wantProbes := 0
			if target == "" {
				wantProbes = 1
			}
			if operations != 4 || probes != wantProbes {
				t.Fatalf("operations=%d probes=%d want=4/%d", operations, probes, wantProbes)
			}
		})
	}
}

func asyncRagMalformedCases() []ragScopeCase {
	return []ragScopeCase{
		{"empty-reindex-name", "POST", "/v1/rag/collections//documents/owned-doc/reindex", asyncRagReindexBody,
			func(c *xberg.Client, ctx context.Context) (json.RawMessage, error) {
				return c.ReindexRagDocument(ctx, "", "owned-doc", json.RawMessage(asyncRagReindexBody))
			}},
		{"empty-reindex-document", "POST", "/v1/rag/collections/scope-owned/documents//reindex", asyncRagReindexBody,
			func(c *xberg.Client, ctx context.Context) (json.RawMessage, error) {
				return c.ReindexRagDocument(ctx, ragScopeCollection, "", json.RawMessage(asyncRagReindexBody))
			}},
		{"empty-migration-name", "POST", "/v1/rag/collections//migrate-embeddings", `{}`,
			func(c *xberg.Client, ctx context.Context) (json.RawMessage, error) {
				return c.MigrateRagEmbeddings(ctx, "", json.RawMessage(`{}`))
			}},
		{"empty-migration-job-name", "GET", "/v1/rag/collections//migrate-embeddings/owned-job", "",
			func(c *xberg.Client, ctx context.Context) (json.RawMessage, error) {
				return c.GetRagMigrationJob(ctx, "", "owned-job")
			}},
		{"empty-migration-job-id", "GET", "/v1/rag/collections/scope-owned/migrate-embeddings/", "",
			func(c *xberg.Client, ctx context.Context) (json.RawMessage, error) {
				return c.GetRagMigrationJob(ctx, ragScopeCollection, "")
			}},
		{"empty-rag-job-id", "GET", "/v1/rag/jobs/", "",
			func(c *xberg.Client, ctx context.Context) (json.RawMessage, error) { return c.GetRagJob(ctx, "") }},
		{"embedding-presets", "GET", "/v1/rag/embedding-presets", "",
			func(c *xberg.Client, ctx context.Context) (json.RawMessage, error) {
				_, err := c.ListManagedEmbeddingPresets(ctx)
				return nil, err
			}},
	}
}

func TestSelectedProjectAsyncRagMalformedAndUnrelatedRoutesStayUnselected(t *testing.T) {
	cases := asyncRagMalformedCases()
	operations := 0
	transport := jobPollTransport(func(r *http.Request) (*http.Response, error) {
		index := operations
		operations++
		if index >= len(cases) {
			t.Error("malformed or unrelated async RAG route caused a probe or duplicate")
			return uploadResponse(http.StatusInternalServerError, `{}`), nil
		}
		return checkRagProjectRequest(t, r, cases[index], ""), nil
	})
	client := ragProjectClient(t, "", transport)
	for _, operation := range cases {
		callRagProjectCase(t, client, xberg.WithProProject(context.Background(), " \t "), operation)
	}
	if len(cases) != 7 || operations != 7 {
		t.Fatalf("cases=%d operations=%d want=7/7 without tier probes", len(cases), operations)
	}
}
