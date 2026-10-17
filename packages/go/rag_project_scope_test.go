package xberg_test

import (
	"context"
	"encoding/json"
	"fmt"
	"io"
	"net/http"
	"slices"
	"sync"
	"testing"

	xberg "github.com/xberg-io/sdks/packages/go"
)

const ragScopeResponse = `{"owned":"rag-response"}`
const ragScopeCollection = "scope-owned"
const ragScopeCreateBody = `{"name":"scope-owned","embedding_source":"byo","embedding_dim":3}`
const ragScopeAddBody = `{"kind":"chunks","external_id":"owned","chunks":[{"content":"owned text","embedding":[1,0,0],"metadata":{}}]}`
const ragScopeDeleteBody = `{"ids":["00000000-0000-4000-8000-000000000001"]}`
const ragScopeRetrieveBody = `{"mode":"vector","query_vector":[1,0,0],"top_k":2,"rerank":null}`

type ragScopeCase struct {
	name, method, uri, body string
	call                    func(*xberg.Client, context.Context) (json.RawMessage, error)
}

func ragProjectCases() []ragScopeCase {
	const collection = "/v1/rag/collections/scope-owned"
	return []ragScopeCase{
		{"ListRagCollections", "GET", "/v1/rag/collections", "",
			func(c *xberg.Client, ctx context.Context) (json.RawMessage, error) { return c.ListRagCollections(ctx) }},
		{"CreateRagCollection", "POST", "/v1/rag/collections", ragScopeCreateBody,
			func(c *xberg.Client, ctx context.Context) (json.RawMessage, error) {
				return c.CreateRagCollection(ctx, json.RawMessage(ragScopeCreateBody))
			}},
		{"GetRagCollection", "GET", collection, "",
			func(c *xberg.Client, ctx context.Context) (json.RawMessage, error) {
				return c.GetRagCollection(ctx, ragScopeCollection)
			}},
		{"DeleteRagCollection", "DELETE", collection, "",
			func(c *xberg.Client, ctx context.Context) (json.RawMessage, error) {
				return nil, c.DeleteRagCollection(ctx, ragScopeCollection)
			}},
		{"AddRagDocuments", "POST", collection + "/documents", ragScopeAddBody,
			func(c *xberg.Client, ctx context.Context) (json.RawMessage, error) {
				return c.AddRagDocuments(ctx, ragScopeCollection, json.RawMessage(ragScopeAddBody))
			}},
		{"DeleteRagDocuments", "DELETE", collection + "/documents", ragScopeDeleteBody,
			func(c *xberg.Client, ctx context.Context) (json.RawMessage, error) {
				return c.DeleteRagDocuments(ctx, ragScopeCollection, json.RawMessage(ragScopeDeleteBody))
			}},
		{"RagRetrieve", "POST", collection + "/retrieve", ragScopeRetrieveBody,
			func(c *xberg.Client, ctx context.Context) (json.RawMessage, error) {
				return c.RagRetrieve(ctx, ragScopeCollection, json.RawMessage(ragScopeRetrieveBody))
			}},
	}
}

func ragProjectClient(t *testing.T, target xberg.Target, transport http.RoundTripper) *xberg.Client {
	t.Helper()
	return mustClient(t, xberg.WithBaseURL("https://rag.example.test"), xberg.WithTarget(target),
		xberg.WithAPIKey("synthetic-rag-owner"), xberg.WithRetries(0),
		xberg.WithHTTPClient(&http.Client{Transport: transport}))
}

func checkRagProjectRequest(t *testing.T, r *http.Request, tc ragScopeCase, project string) *http.Response {
	t.Helper()
	if r.Method != tc.method || r.URL.RequestURI() != tc.uri {
		t.Errorf("request=%s %s want=%s %s", r.Method, r.URL.RequestURI(), tc.method, tc.uri)
	}
	if r.Header.Get("X-Project-ID") != project || r.Header.Get("Authorization") != "Bearer synthetic-rag-owner" {
		t.Errorf("project=%q want=%q; owner bearer preserved=%v", r.Header.Get("X-Project-ID"), project,
			r.Header.Get("Authorization") == "Bearer synthetic-rag-owner")
	}
	var body []byte
	var err error
	if r.Body != nil {
		body, err = io.ReadAll(r.Body)
	}
	if err != nil || string(body) != tc.body {
		t.Errorf("%s body=%s want=%s err=%v", tc.name, body, tc.body, err)
	}
	if tc.body != "" && r.Header.Get("Content-Type") != "application/json" {
		t.Errorf("%s Content-Type=%q", tc.name, r.Header.Get("Content-Type"))
	}
	if tc.name == "DeleteRagCollection" || tc.name == "empty-delete-collection" {
		return uploadResponse(http.StatusNoContent, "")
	}
	return uploadResponse(http.StatusOK, ragScopeResponse)
}

func callRagProjectCase(ctx context.Context, t *testing.T, client *xberg.Client, tc ragScopeCase) {
	t.Helper()
	value, err := tc.call(client, ctx)
	want := ragScopeResponse
	if tc.name == "DeleteRagCollection" || tc.name == "empty-delete-collection" || tc.name == "embedding-presets" {
		want = ""
	}
	if err != nil || string(value) != want {
		t.Errorf("%s response=%s want=%s err=%v", tc.name, value, want, err)
	}
}

func TestSelectedProjectRagUsesProHeadersAndPreservesEnterprise(t *testing.T) {
	for _, tc := range []struct {
		name, tier string
		target     xberg.Target
	}{
		{"explicit-pro", "pro", xberg.TargetPro}, {"auto-pro", "pro", ""},
		{"explicit-enterprise", "enterprise", xberg.TargetEnterprise}, {"auto-enterprise", "enterprise", ""},
	} {
		t.Run(tc.name, func(t *testing.T) {
			cases := ragProjectCases()
			probes, operations := 0, 0
			transport := jobPollTransport(func(r *http.Request) (*http.Response, error) {
				if r.URL.Path == "/healthz" {
					probes++
					if r.Method != "GET" || r.Header.Get("X-Project-ID") != "" {
						t.Error("selected project leaked into tier probe")
					}
					return scopeReadResponse(fmt.Sprintf(`{"tier":%q}`, tc.tier)), nil
				}
				index := operations
				operations++
				if index >= len(cases) {
					t.Error("unexpected additional RAG operation")
					return uploadResponse(http.StatusInternalServerError, `{}`), nil
				}
				project := ""
				if tc.tier == "pro" {
					project = scopeProjectID
				}
				return checkRagProjectRequest(t, r, cases[index], project), nil
			})
			client := ragProjectClient(t, tc.target, transport)
			for _, operation := range cases {
				callRagProjectCase(xberg.WithProProject(context.Background(), scopeProjectID), t, client, operation)
			}
			wantProbes := 0
			if tc.target == "" {
				wantProbes = 1
			}
			if len(cases) != 7 || operations != 7 || probes != wantProbes {
				t.Fatalf("cases=%d operations=%d probes=%d want=7/7/%d", len(cases), operations, probes, wantProbes)
			}
		})
	}
}

func TestUnscopedRagPreservesSharedSurfaceWithoutProbe(t *testing.T) {
	for _, target := range []xberg.Target{xberg.TargetPro, xberg.TargetEnterprise, ""} {
		t.Run(string(target), func(t *testing.T) {
			cases := ragProjectCases()
			operations := 0
			transport := jobPollTransport(func(r *http.Request) (*http.Response, error) {
				index := operations
				operations++
				if index >= len(cases) {
					t.Error("unselected request caused a probe or duplicate operation")
					return uploadResponse(http.StatusInternalServerError, `{}`), nil
				}
				return checkRagProjectRequest(t, r, cases[index], ""), nil
			})
			client := ragProjectClient(t, target, transport)
			for _, operation := range cases {
				callRagProjectCase(context.Background(), t, client, operation)
			}
			if operations != 7 {
				t.Fatalf("operations=%d want=7 without tier probes", operations)
			}
		})
	}
}

func TestSelectedProjectRagRejectsBlankOnProAndIgnoresBlankOnEnterprise(t *testing.T) {
	for _, tc := range []struct {
		name, tier string
		target     xberg.Target
	}{
		{"explicit-pro", "pro", xberg.TargetPro}, {"auto-pro", "pro", ""},
		{"explicit-enterprise", "enterprise", xberg.TargetEnterprise}, {"auto-enterprise", "enterprise", ""},
	} {
		t.Run(tc.name, func(t *testing.T) {
			cases := ragProjectCases()
			probes, operations := 0, 0
			transport := jobPollTransport(func(r *http.Request) (*http.Response, error) {
				if r.URL.Path == "/healthz" {
					probes++
					return scopeReadResponse(fmt.Sprintf(`{"tier":%q}`, tc.tier)), nil
				}
				index := operations
				operations++
				return checkRagProjectRequest(t, r, cases[index%len(cases)], ""), nil
			})
			client := ragProjectClient(t, tc.target, transport)
			ctx := xberg.WithProProject(context.Background(), " \t ")
			for _, operation := range cases {
				if tc.tier == "enterprise" {
					callRagProjectCase(ctx, t, client, operation)
					continue
				}
				if _, err := operation.call(client, ctx); err == nil || err.Error() != "xberg: Pro project ID must not be blank" {
					t.Errorf("%s blank selection error=%v", operation.name, err)
				}
			}
			wantOperations, wantProbes := 0, 0
			if tc.tier == "enterprise" {
				wantOperations = 7
			}
			if tc.target == "" {
				wantProbes = 1
			}
			if operations != wantOperations || probes != wantProbes {
				t.Fatalf("operations=%d probes=%d want=%d/%d", operations, probes, wantOperations, wantProbes)
			}
		})
	}
}

func TestSelectedProjectRagContextsDoNotLeak(t *testing.T) {
	type projectKey struct{}
	var mutex sync.Mutex
	counts := map[string]int{}
	cases := ragProjectCases()
	transport := jobPollTransport(func(r *http.Request) (*http.Response, error) {
		project, ok := r.Context().Value(projectKey{}).(string)
		if !ok {
			t.Error("RAG request lost caller context")
		}
		for _, tc := range cases {
			if r.Method == tc.method && r.URL.RequestURI() == tc.uri {
				mutex.Lock()
				counts[project+"/"+tc.name]++
				mutex.Unlock()
				return checkRagProjectRequest(t, r, tc, project), nil
			}
		}
		t.Errorf("unexpected request or probe: %s %s", r.Method, r.URL)
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
			for _, tc := range cases {
				callRagProjectCase(ctx, t, client, tc)
			}
		})
	}
	group.Wait()
	mutex.Lock()
	defer mutex.Unlock()
	if len(counts) != 21 {
		t.Fatalf("distinct context/operation requests=%d want=21", len(counts))
	}
	for key, count := range counts {
		if count != 1 {
			t.Errorf("%s requests=%d want=1", key, count)
		}
	}
}

func ragExcludedProjectCases() []ragScopeCase {
	return []ragScopeCase{
		{"embedding-presets", "GET", "/v1/rag/embedding-presets", "",
			func(c *xberg.Client, ctx context.Context) (json.RawMessage, error) {
				_, err := c.ListManagedEmbeddingPresets(ctx)
				return nil, err
			}},
		{"empty-get-collection", "GET", "/v1/rag/collections/", "",
			func(c *xberg.Client, ctx context.Context) (json.RawMessage, error) {
				return c.GetRagCollection(ctx, "")
			}},
		{"empty-delete-collection", "DELETE", "/v1/rag/collections/", "",
			func(c *xberg.Client, ctx context.Context) (json.RawMessage, error) {
				return nil, c.DeleteRagCollection(ctx, "")
			}},
		{"empty-add-documents", "POST", "/v1/rag/collections//documents", ragScopeAddBody,
			func(c *xberg.Client, ctx context.Context) (json.RawMessage, error) {
				return c.AddRagDocuments(ctx, "", json.RawMessage(ragScopeAddBody))
			}},
		{"empty-delete-documents", "DELETE", "/v1/rag/collections//documents", ragScopeDeleteBody,
			func(c *xberg.Client, ctx context.Context) (json.RawMessage, error) {
				return c.DeleteRagDocuments(ctx, "", json.RawMessage(ragScopeDeleteBody))
			}},
		{"empty-retrieve", "POST", "/v1/rag/collections//retrieve", ragScopeRetrieveBody,
			func(c *xberg.Client, ctx context.Context) (json.RawMessage, error) {
				return c.RagRetrieve(ctx, "", json.RawMessage(ragScopeRetrieveBody))
			}},
	}
}

func TestSelectedProjectRagExcludedAndMalformedRoutesStayUnselected(t *testing.T) {
	cases := ragExcludedProjectCases()
	seen := []string{}
	transport := jobPollTransport(func(r *http.Request) (*http.Response, error) {
		index := len(seen)
		seen = append(seen, r.Method+" "+r.URL.RequestURI())
		if index >= len(cases) {
			t.Error("excluded route caused a probe or extra request")
			return uploadResponse(http.StatusInternalServerError, `{}`), nil
		}
		return checkRagProjectRequest(t, r, cases[index], ""), nil
	})
	client := ragProjectClient(t, "", transport)
	want := []string{}
	for _, tc := range cases {
		want = append(want, tc.method+" "+tc.uri)
		callRagProjectCase(xberg.WithProProject(context.Background(), " \t "), t, client, tc)
	}
	if len(cases) != 6 || !slices.Equal(seen, want) {
		t.Fatalf("excluded request trace=%v want=%v", seen, want)
	}
}
