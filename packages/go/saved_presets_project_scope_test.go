package xberg

import (
	"context"
	"fmt"
	"io"
	"net/http"
	"reflect"
	"strings"
	"sync"
	"testing"
)

const presetScopeID = "cccccccc-0000-4000-8000-000000000001"
const presetScopeProject = "11111111-1111-4111-8111-111111111111"
const presetScopeResponse = `{"id":"cccccccc-0000-4000-8000-000000000001","name":"Invoice","message":"created","success":true,"presets":[],"total":7,"limit":25,"page":0}`

type presetScopeOperation struct {
	method, path, body, result string
	call                       func(*Client, context.Context) (string, error)
}

func presetScopeOperations(id, escapedID string) []presetScopeOperation {
	const base = "/v1/saved_presets"
	return []presetScopeOperation{
		{"GET", base + "?limit=25&offset=5", "", "7:25",
			func(c *Client, ctx context.Context) (string, error) {
				v, err := c.ListSavedPresets(ctx, 25, 5)
				if err != nil {
					return "", err
				}
				return fmt.Sprintf("%d:%d", v.Total, v.Limit), nil
			}},
		{"POST", base, `{"name":"Invoice","preferred_call_mode":"text_only","schema":{"type":"object"}}`,
			presetScopeID + ":Invoice:true", func(c *Client, ctx context.Context) (string, error) {
				v, err := c.CreateSavedPreset(ctx, CreateSavedPresetRequest{
					Name: "Invoice", PreferredCallMode: "text_only", Schema: map[string]any{"type": "object"},
				})
				if err != nil {
					return "", err
				}
				return fmt.Sprintf("%s:%s:%t", v.Id, v.Name, v.Success), nil
			}},
		{"GET", base + "/" + escapedID, "", presetScopeID + ":Invoice",
			func(c *Client, ctx context.Context) (string, error) {
				v, err := c.GetSavedPreset(ctx, id)
				if err != nil {
					return "", err
				}
				return v.Id.String() + ":" + v.Name, nil
			}},
		{"PATCH", base + "/" + escapedID, `{"emit_citations":false,"name":"Invoice"}`, "true:created",
			func(c *Client, ctx context.Context) (string, error) {
				name, citations := "Invoice", false
				v, err := c.UpdateSavedPreset(ctx, id, UpdateSavedPresetRequest{Name: &name, EmitCitations: &citations})
				if err != nil {
					return "", err
				}
				return fmt.Sprintf("%t:%s", v.Success, v.Message), nil
			}},
		{"DELETE", base + "/" + escapedID, "", "deleted",
			func(c *Client, ctx context.Context) (string, error) {
				return "deleted", c.DeleteSavedPreset(ctx, id)
			}},
	}
}

type presetScopeTransport func(*http.Request) (*http.Response, error)

func (f presetScopeTransport) RoundTrip(r *http.Request) (*http.Response, error) { return f(r) }

func presetScopeReply(status int, body string) *http.Response {
	return &http.Response{StatusCode: status, Header: http.Header{"Content-Type": {"application/json"}},
		Body: io.NopCloser(strings.NewReader(body))}
}

func presetScopeClient(t *testing.T, target Target, transport http.RoundTripper) *Client {
	t.Helper()
	c, err := New(WithBaseURL("https://preset.example.test"), WithTarget(target), WithAPIKey("synthetic-owner"),
		WithRetries(0), WithHTTPClient(&http.Client{Transport: transport}))
	if err != nil {
		t.Fatal(err)
	}
	return c
}

func checkPresetScopeRequest(t *testing.T, r *http.Request, op presetScopeOperation, project string) *http.Response {
	t.Helper()
	if r.Method != op.method || r.URL.RequestURI() != op.path || r.URL.Fragment != "" {
		t.Errorf("request=%s %s want=%s %s", r.Method, r.URL.RequestURI(), op.method, op.path)
	}
	if r.Header.Get("X-Project-ID") != project || r.Header.Get("Authorization") != "Bearer synthetic-owner" {
		t.Errorf("project=%q want=%q; authorization=%q", r.Header.Get("X-Project-ID"), project,
			r.Header.Get("Authorization"))
	}
	var body []byte
	var err error
	if r.Body != nil {
		body, err = io.ReadAll(r.Body)
	}
	if err != nil || string(body) != op.body {
		t.Errorf("%s body=%s want=%s err=%v", op.method, body, op.body, err)
	}
	if op.body != "" && r.Header.Get("Content-Type") != "application/json" {
		t.Errorf("Content-Type=%q want application/json", r.Header.Get("Content-Type"))
	}
	if op.method == "DELETE" {
		return presetScopeReply(http.StatusNoContent, "")
	}
	return presetScopeReply(http.StatusOK, presetScopeResponse)
}

func callPresetScopeOperation(t *testing.T, c *Client, ctx context.Context, op presetScopeOperation) {
	t.Helper()
	result, err := op.call(c, ctx)
	if err != nil || result != op.result {
		t.Errorf("%s %s result=%q want=%q err=%v", op.method, op.path, result, op.result, err)
	}
}

func runPresetScopeMatrix(t *testing.T, selected, blank bool) {
	t.Helper()
	for _, tier := range []Target{TargetPro, TargetEnterprise} {
		for _, target := range []Target{tier, ""} {
			t.Run(string(tier)+"/target="+string(target), func(t *testing.T) {
				runPresetScopeTier(t, tier, target, selected, blank)
			})
		}
	}
}

func runPresetScopeTier(t *testing.T, tier, target Target, selected, blank bool) {
	t.Helper()
	operations := presetScopeOperations(presetScopeID, presetScopeID)
	probes, calls := 0, 0
	project := ""
	if selected && tier == TargetPro {
		project = presetScopeProject
	}
	transport := presetScopeTransport(func(r *http.Request) (*http.Response, error) {
		if r.URL.Path == "/healthz" {
			probes++
			if r.Method != "GET" || r.URL.RequestURI() != "/healthz" || r.Header.Get("X-Project-ID") != "" ||
				r.Header.Get("Authorization") != "Bearer synthetic-owner" {
				t.Error("invalid tier probe")
			}
			return presetScopeReply(http.StatusOK, fmt.Sprintf(`{"tier":%q}`, tier)), nil
		}
		index := calls
		calls++
		if index >= len(operations) {
			t.Error("unexpected duplicate request")
			return presetScopeReply(500, `{}`), nil
		}
		return checkPresetScopeRequest(t, r, operations[index], project), nil
	})
	client := presetScopeClient(t, target, transport)
	ctx := context.Background()
	if selected {
		ctx = WithProProject(ctx, presetScopeProject)
	}
	if blank {
		ctx = WithProProject(ctx, " \t ")
	}
	for _, op := range operations {
		if blank && tier == TargetPro {
			if _, err := op.call(client, ctx); err == nil || err.Error() != "xberg: Pro project ID must not be blank" {
				t.Errorf("%s blank selector error=%v", op.method, err)
			}
		} else {
			callPresetScopeOperation(t, client, ctx, op)
		}
	}
	wantCalls, wantProbes := 5, 0
	if blank && tier == TargetPro {
		wantCalls = 0
	}
	if target == "" && (selected || blank) {
		wantProbes = 1
	}
	if len(operations) != 5 || calls != wantCalls || probes != wantProbes {
		t.Fatalf("operations=%d calls=%d probes=%d want=5/%d/%d", len(operations), calls, probes, wantCalls, wantProbes)
	}
}

func TestSavedPresetsProjectShouldSelectProAndPreserveEnterprise(t *testing.T) {
	runPresetScopeMatrix(t, true, false)
}

func TestSavedPresetsProjectShouldPreserveUnselectedRequestsWithoutProbe(t *testing.T) {
	runPresetScopeMatrix(t, false, false)
}

func TestSavedPresetsProjectShouldRejectBlankOnProAndIgnoreOnEnterprise(t *testing.T) {
	runPresetScopeMatrix(t, false, true)
}

func TestSavedPresetsProjectShouldEscapeResourceSegments(t *testing.T) {
	const id = "preset/with?query#fragment%literal"
	const escaped = "preset%2Fwith%3Fquery%23fragment%25literal"
	operations := presetScopeOperations(id, escaped)[2:]
	calls := 0
	client := presetScopeClient(t, TargetPro, presetScopeTransport(func(r *http.Request) (*http.Response, error) {
		index := calls
		calls++
		if index >= len(operations) {
			t.Error("unexpected duplicate request")
			return presetScopeReply(500, `{}`), nil
		}
		return checkPresetScopeRequest(t, r, operations[index], presetScopeProject), nil
	}))
	for _, op := range operations {
		callPresetScopeOperation(t, client, WithProProject(context.Background(), presetScopeProject), op)
	}
	if len(operations) != 3 || calls != 3 {
		t.Fatalf("operations=%d calls=%d want=3/3", len(operations), calls)
	}
}

func TestSavedPresetsProjectShouldKeepConcurrentContextsIsolated(t *testing.T) {
	type expectedProject struct{}
	var mutex sync.Mutex
	counts := map[string]int{}
	operations := presetScopeOperations(presetScopeID, presetScopeID)
	client := presetScopeClient(t, TargetPro, presetScopeTransport(func(r *http.Request) (*http.Response, error) {
		project, ok := r.Context().Value(expectedProject{}).(string)
		if !ok {
			t.Error("caller context lost")
		}
		for _, op := range operations {
			if r.Method == op.method && r.URL.RequestURI() == op.path {
				mutex.Lock()
				counts[project+"/"+op.method+"/"+op.path]++
				mutex.Unlock()
				return checkPresetScopeRequest(t, r, op, project), nil
			}
		}
		t.Errorf("unexpected operation or probe: %s %s", r.Method, r.URL)
		return presetScopeReply(500, `{}`), nil
	}))
	var group sync.WaitGroup
	for _, project := range []string{presetScopeProject, "22222222-2222-4222-8222-222222222222", ""} {
		group.Go(func() {
			ctx := context.WithValue(context.Background(), expectedProject{}, project)
			if project != "" {
				ctx = WithProProject(ctx, project)
			}
			for _, op := range operations {
				callPresetScopeOperation(t, client, ctx, op)
			}
		})
	}
	group.Wait()
	if len(counts) != 15 {
		t.Fatalf("distinct project/operation pairs=%d want=15", len(counts))
	}
	for key, count := range counts {
		if count != 1 {
			t.Errorf("%s requests=%d want=1", key, count)
		}
	}
}

func TestSavedPresetsProjectShouldIgnoreMalformedAndUnrelatedRoutesWithoutProbe(t *testing.T) {
	cases := []requestSpec{
		{method: "GET", path: "/v1/saved_presets/"}, {method: "GET", path: "/v1/saved_presets//"},
		{method: "GET", path: "/v1/saved_presets/id/extra"}, {method: "GET", path: "/v1/saved-presets"},
		{method: "GET", path: "/v1/presets"}, {method: "PUT", path: "/v1/saved_presets/id"},
		{method: "POST", path: "/v1/saved_presets/id"}, {method: "DELETE", path: "/v1/saved_presets"},
		{method: "PATCH", path: "/v1/saved_presets"}, {method: "POST", path: "/v1/saved_presets/"},
	}
	calls := 0
	client := presetScopeClient(t, "", presetScopeTransport(func(*http.Request) (*http.Response, error) {
		calls++
		return presetScopeReply(500, `{}`), nil
	}))
	for _, spec := range cases {
		got, err := client.applyProProject(WithProProject(context.Background(), " \t "), spec)
		if err != nil || !reflect.DeepEqual(got, spec) {
			t.Errorf("%s %s changed: %+v err=%v", spec.method, spec.path, got, err)
		}
	}
	if len(cases) != 10 || calls != 0 {
		t.Fatalf("cases=%d transport calls=%d want=10/0", len(cases), calls)
	}
}
