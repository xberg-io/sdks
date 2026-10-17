package xberg

import (
	"context"
	"encoding/json"
	"fmt"
	"io"
	"net/http"
	"reflect"
	"strings"
	"sync"
	"testing"
)

const autoTuneScopeProject = "11111111-1111-4111-8111-111111111111"
const autoTuneScopeText = "Synthetic invoice total: 123.45"

type autoTuneScopeOperation struct {
	name, method, path, response string
	call                         func(*Client, context.Context) (any, error)
}

func autoTuneScopeOperations(id, escaped string) []autoTuneScopeOperation {
	operations := autoTuneScopeJobOperations(id, escaped)
	return append(operations, autoTuneScopeProfileOperations(id, escaped)...)
}

func autoTuneScopeJobOperations(id, escaped string) []autoTuneScopeOperation {
	base, resource := "/v1/auto-tune", "/v1/auto-tune/"+escaped
	return []autoTuneScopeOperation{
		{"list_jobs", "GET", base + "?limit=25&offset=5", `{"jobs":[],"total":7}`,
			func(c *Client, x context.Context) (any, error) { return c.ListAutoTuneJobs(x, 25, 5) }},
		{"submit", "POST", base, `{"auto_tune_job_id":"job-1","status":"queued"}`,
			func(c *Client, x context.Context) (any, error) {
				files := []FileSource{{Name: "invoice.txt", Reader: strings.NewReader(autoTuneScopeText)}}
				return c.SubmitAutoTune(x, autoTuneScopeSubmission(), files)
			}},
		{"capabilities", "GET", base + "/capabilities",
			`{"default_ocr_ladder":["tesseract"],"ocr_backends":[],"tunable_knobs":[]}`,
			func(c *Client, x context.Context) (any, error) { return c.GetAutoTuneCapabilities(x) }},
		{"status", "GET", resource,
			`{"auto_tune_job_id":"job-1","status":"running","trials_completed":2,"trials_total":8}`,
			func(c *Client, x context.Context) (any, error) { return c.GetAutoTuneStatus(x, id) }},
		{"delete_job", "DELETE", resource, "",
			func(c *Client, x context.Context) (any, error) { return nil, c.DeleteAutoTuneJob(x, id) }},
		{"result", "GET", resource + "/result",
			`{"auto_tune_job_id":"job-1","leaderboard":[{"primary_score":0.91,"variance":0.01,` +
				`"tied_with_winner":false,"config":{},"breakdown":{}}],"profile":{"ocr":"tesseract"}}`,
			func(c *Client, x context.Context) (any, error) { return c.GetAutoTuneResult(x, id) }},
		{"stop", "POST", resource + "/stop", "",
			func(c *Client, x context.Context) (any, error) { return nil, c.StopAutoTuneJob(x, id) }},
	}
}

func autoTuneScopeProfileOperations(id, escaped string) []autoTuneScopeOperation {
	profile := `{"id":"profile-1","name":"invoice-tuned","created_at":"2025-01-01T00:00:00Z",` +
		`"profile":{"ocr":"tesseract"},"scores":{"f1":0.92}}`
	return []autoTuneScopeOperation{
		{"promote", "POST", "/v1/auto-tune/" + escaped + "/promote", profile,
			func(c *Client, x context.Context) (any, error) {
				return c.PromoteAutoTuneProfile(x, id, PromoteProfileRequest{Name: "invoice-tuned"})
			}},
		{"list_profiles", "GET", "/v1/tuning-profiles?limit=25&offset=5", `{"profiles":[],"total":3}`,
			func(c *Client, x context.Context) (any, error) { return c.ListTuningProfiles(x, 25, 5) }},
		{"get_profile", "GET", "/v1/tuning-profiles/" + escaped, profile,
			func(c *Client, x context.Context) (any, error) { return c.GetTuningProfile(x, id) }},
		{"delete_profile", "DELETE", "/v1/tuning-profiles/" + escaped, "",
			func(c *Client, x context.Context) (any, error) { return nil, c.DeleteTuningProfile(x, id) }},
	}
}

func autoTuneScopeSubmission() CreateAutoTuneJobRequest {
	return CreateAutoTuneJobRequest{Documents: []AutoTuneDocumentInput{{
		Filename: "invoice.txt", GroundTruth: autoTuneScopeText, GroundTruthKind: Plaintext,
	}}}
}

type autoTuneScopeTransport func(*http.Request) (*http.Response, error)

func (f autoTuneScopeTransport) RoundTrip(r *http.Request) (*http.Response, error) { return f(r) }

func autoTuneScopeReply(status int, body string) *http.Response {
	return &http.Response{StatusCode: status, Header: http.Header{"Content-Type": {"application/json"}},
		Body: io.NopCloser(strings.NewReader(body))}
}

func autoTuneScopeClient(t *testing.T, target Target, transport http.RoundTripper) *Client {
	t.Helper()
	c, err := New(WithBaseURL("https://autotune.example.test"), WithTarget(target), WithAPIKey("synthetic-owner"),
		WithRetries(0), WithHTTPClient(&http.Client{Transport: transport}))
	if err != nil {
		t.Fatal(err)
	}
	return c
}

func checkAutoTuneScopeMultipart(t *testing.T, r *http.Request) {
	t.Helper()
	if err := r.ParseMultipartForm(1 << 20); err != nil {
		t.Fatal(err)
	}
	defer r.MultipartForm.RemoveAll()
	if len(r.MultipartForm.Value) != 1 || len(r.MultipartForm.Value["request"]) != 1 {
		t.Fatalf("multipart values=%v", r.MultipartForm.Value)
	}
	var got map[string]any
	if err := json.Unmarshal([]byte(r.MultipartForm.Value["request"][0]), &got); err != nil {
		t.Fatal(err)
	}
	expectedJSON, err := json.Marshal(autoTuneScopeSubmission())
	if err != nil {
		t.Fatal(err)
	}
	var expected map[string]any
	if err := json.Unmarshal(expectedJSON, &expected); err != nil {
		t.Fatal(err)
	}
	if !reflect.DeepEqual(got, expected) {
		t.Errorf("request=%v want=%v", got, expected)
	}
	if len(r.MultipartForm.File) != 1 || len(r.MultipartForm.File["file"]) != 1 {
		t.Fatalf("multipart files=%v", r.MultipartForm.File)
	}
	file := r.MultipartForm.File["file"][0]
	if file.Filename != "invoice.txt" {
		t.Errorf("filename=%q want invoice.txt", file.Filename)
	}
	reader, err := file.Open()
	if err != nil {
		t.Fatal(err)
	}
	defer reader.Close()
	contents, err := io.ReadAll(reader)
	if err != nil || string(contents) != autoTuneScopeText {
		t.Errorf("file bytes=%q err=%v", contents, err)
	}
}

func checkAutoTuneScopeRequest(
	t *testing.T, r *http.Request, op autoTuneScopeOperation, project string,
) *http.Response {
	t.Helper()
	if r.Method != op.method || r.URL.RequestURI() != op.path || r.URL.Fragment != "" {
		t.Errorf("request=%s %s want=%s %s", r.Method, r.URL.RequestURI(), op.method, op.path)
	}
	if r.Header.Get("X-Project-ID") != project || r.Header.Get("Authorization") != "Bearer synthetic-owner" {
		t.Errorf("project=%q want=%q authorization=%q",
			r.Header.Get("X-Project-ID"), project, r.Header.Get("Authorization"))
	}
	if op.name == "submit" {
		checkAutoTuneScopeMultipart(t, r)
	} else {
		checkAutoTuneScopeBody(t, r, op.name)
	}
	status := http.StatusOK
	if op.response == "" {
		status = http.StatusNoContent
	}
	return autoTuneScopeReply(status, op.response)
}

func checkAutoTuneScopeBody(t *testing.T, r *http.Request, name string) {
	t.Helper()
	var body []byte
	var err error
	if r.Body != nil {
		body, err = io.ReadAll(r.Body)
	}
	if err != nil {
		t.Fatal(err)
	}
	if name != "promote" {
		if len(body) != 0 {
			t.Errorf("unexpected body=%q", body)
		}
		return
	}
	if r.Header.Get("Content-Type") != "application/json" {
		t.Errorf("Content-Type=%q", r.Header.Get("Content-Type"))
	}
	var decoded map[string]any
	if err := json.Unmarshal(body, &decoded); err != nil {
		t.Fatal(err)
	}
	if !reflect.DeepEqual(decoded, map[string]any{"name": "invoice-tuned"}) {
		t.Errorf("promotion body=%v", decoded)
	}
}

func callAutoTuneScopeOperation(t *testing.T, c *Client, ctx context.Context, op autoTuneScopeOperation) {
	t.Helper()
	got, err := op.call(c, ctx)
	if err != nil {
		t.Fatalf("%s: %v", op.name, err)
	}
	if op.response == "" {
		if got != nil {
			t.Errorf("no-content result=%v", got)
		}
		return
	}
	expected := reflect.New(reflect.TypeOf(got).Elem()).Interface()
	if err := json.Unmarshal([]byte(op.response), expected); err != nil {
		t.Fatal(err)
	}
	if !reflect.DeepEqual(got, expected) {
		t.Errorf("%s decoded=%+v want=%+v", op.name, got, expected)
	}
}

type autoTuneScopeMode struct {
	name            string
	target, tier    Target
	selected, blank bool
}

func TestAutoTuneProjectShouldSelectProAndPreserveOtherModes(t *testing.T) {
	modes := []autoTuneScopeMode{
		{"explicit_pro", TargetPro, TargetPro, true, false}, {"automatic_pro", "", TargetPro, true, false},
		{"enterprise", TargetEnterprise, TargetEnterprise, true, false},
		{"automatic_enterprise", "", TargetEnterprise, true, false},
		{"unselected", TargetPro, TargetPro, false, false}, {"blank_pro", TargetPro, TargetPro, true, true},
	}
	operations := autoTuneScopeOperations("job-1", "job-1")
	if len(modes)*len(operations) != 66 {
		t.Fatalf("matrix cells=%d want=66", len(modes)*len(operations))
	}
	for _, mode := range modes {
		for _, op := range operations {
			t.Run(mode.name+"/"+op.name, func(t *testing.T) { runAutoTuneScopeCase(t, mode, op) })
		}
	}
}

func TestAutoTuneProjectShouldRejectBlankAfterAutomaticProDetection(t *testing.T) {
	mode := autoTuneScopeMode{"automatic_pro", "", TargetPro, true, true}
	for _, op := range autoTuneScopeOperations("job-1", "job-1") {
		t.Run(op.name, func(t *testing.T) { runAutoTuneScopeCase(t, mode, op) })
	}
}

func TestAutoTuneProjectShouldIgnoreBlankSelectionOnEnterprise(t *testing.T) {
	for _, target := range []Target{TargetEnterprise, ""} {
		mode := autoTuneScopeMode{string(target), target, TargetEnterprise, true, true}
		for _, op := range autoTuneScopeOperations("job-1", "job-1") {
			t.Run(mode.name+"/"+op.name, func(t *testing.T) { runAutoTuneScopeCase(t, mode, op) })
		}
	}
}

func runAutoTuneScopeCase(t *testing.T, mode autoTuneScopeMode, op autoTuneScopeOperation) {
	t.Helper()
	calls, probes := 0, 0
	project := ""
	if mode.selected && mode.tier == TargetPro {
		project = autoTuneScopeProject
	}
	transport := autoTuneScopeTransport(func(r *http.Request) (*http.Response, error) {
		if r.URL.Path == "/healthz" {
			probes++
			checkAutoTuneScopeProbe(t, r)
			return autoTuneScopeReply(200, fmt.Sprintf(`{"tier":%q}`, mode.tier)), nil
		}
		calls++
		return checkAutoTuneScopeRequest(t, r, op, project), nil
	})
	c := autoTuneScopeClient(t, mode.target, transport)
	ctx := autoTuneScopeContext(mode)
	if mode.blank && mode.tier == TargetPro {
		_, err := op.call(c, ctx)
		if err == nil || err.Error() != "xberg: Pro project ID must not be blank" {
			t.Errorf("blank selector error=%v", err)
		}
	} else {
		callAutoTuneScopeOperation(t, c, ctx, op)
	}
	wantCalls, wantProbes := 1, 0
	if mode.blank && mode.tier == TargetPro {
		wantCalls = 0
	}
	if mode.target == "" {
		wantProbes = 1
	}
	if calls != wantCalls || probes != wantProbes {
		t.Fatalf("calls/probes=%d/%d want=%d/%d", calls, probes, wantCalls, wantProbes)
	}
}

func autoTuneScopeContext(mode autoTuneScopeMode) context.Context {
	ctx := context.Background()
	if !mode.selected {
		return ctx
	}
	value := autoTuneScopeProject
	if mode.blank {
		value = " \t "
	}
	return WithProProject(ctx, value)
}

func TestAutoTuneProjectShouldCacheAutomaticTierAcrossOperations(t *testing.T) {
	operations := autoTuneScopeOperations("job-1", "job-1")
	calls, probes := 0, 0
	c := autoTuneScopeClient(t, "", autoTuneScopeTransport(func(r *http.Request) (*http.Response, error) {
		if r.URL.Path == "/healthz" {
			probes++
			checkAutoTuneScopeProbe(t, r)
			return autoTuneScopeReply(200, `{"tier":"pro"}`), nil
		}
		index := calls
		calls++
		if index >= len(operations) {
			t.Error("duplicate request")
			return autoTuneScopeReply(500, `{}`), nil
		}
		return checkAutoTuneScopeRequest(t, r, operations[index], autoTuneScopeProject), nil
	}))
	for _, op := range operations {
		callAutoTuneScopeOperation(t, c, WithProProject(context.Background(), autoTuneScopeProject), op)
	}
	if calls != 11 || probes != 1 {
		t.Fatalf("calls/probes=%d/%d want=11/1", calls, probes)
	}
}

func checkAutoTuneScopeProbe(t *testing.T, r *http.Request) {
	t.Helper()
	if r.Method != "GET" || r.URL.RequestURI() != "/healthz" || r.Header.Get("X-Project-ID") != "" ||
		r.Header.Get("Authorization") != "Bearer synthetic-owner" {
		t.Errorf("invalid probe=%s %s headers=%v", r.Method, r.URL.RequestURI(), r.Header)
	}
}

func TestAutoTuneProjectShouldEscapeResourceSegments(t *testing.T) {
	const id = "job/with?query#fragment%literal"
	const escaped = "job%2Fwith%3Fquery%23fragment%25literal"
	operations := autoTuneScopeOperations(id, escaped)
	calls := 0
	c := autoTuneScopeClient(t, TargetPro, autoTuneScopeTransport(func(r *http.Request) (*http.Response, error) {
		index := calls
		calls++
		if index >= len(operations) {
			t.Error("duplicate request")
			return autoTuneScopeReply(500, `{}`), nil
		}
		return checkAutoTuneScopeRequest(t, r, operations[index], autoTuneScopeProject), nil
	}))
	for _, op := range operations {
		callAutoTuneScopeOperation(t, c, WithProProject(context.Background(), autoTuneScopeProject), op)
	}
	if calls != 11 {
		t.Fatalf("calls=%d want=11", calls)
	}
}

func TestAutoTuneProjectShouldKeepConcurrentContextsIsolated(t *testing.T) {
	type expectedProject struct{}
	operations := autoTuneScopeOperations("job-1", "job-1")
	var mutex sync.Mutex
	counts := map[string]int{}
	c := autoTuneScopeClient(t, TargetPro, autoTuneScopeTransport(func(r *http.Request) (*http.Response, error) {
		project, ok := r.Context().Value(expectedProject{}).(string)
		if !ok {
			t.Error("caller context lost")
		}
		for _, op := range operations {
			if r.Method == op.method && r.URL.RequestURI() == op.path {
				mutex.Lock()
				counts[project+"/"+op.name]++
				mutex.Unlock()
				return checkAutoTuneScopeRequest(t, r, op, project), nil
			}
		}
		t.Errorf("unexpected request=%s %s", r.Method, r.URL)
		return autoTuneScopeReply(500, `{}`), nil
	}))
	var group sync.WaitGroup
	for _, project := range []string{autoTuneScopeProject, "22222222-2222-4222-8222-222222222222", ""} {
		group.Go(func() {
			ctx := context.WithValue(context.Background(), expectedProject{}, project)
			if project != "" {
				ctx = WithProProject(ctx, project)
			}
			for _, op := range operations {
				callAutoTuneScopeOperation(t, c, ctx, op)
			}
		})
	}
	group.Wait()
	if len(counts) != 33 {
		t.Fatalf("distinct project/operation pairs=%d want=33", len(counts))
	}
	for key, count := range counts {
		if count != 1 {
			t.Errorf("%s requests=%d want=1", key, count)
		}
	}
}

func TestAutoTuneProjectShouldIgnoreNearMissesWithoutProbe(t *testing.T) {
	cases := []requestSpec{
		{method: "PATCH", path: "/v1/auto-tune"}, {method: "GET", path: "/v1/auto-tunex"},
		{method: "GET", path: "/v1/auto-tune/"}, {method: "GET", path: "/v1/auto-tune//result"},
		{method: "GET", path: "/v1/auto-tune/id/result/extra"}, {method: "GET", path: "/v1/auto-tune/id/stop"},
		{method: "POST", path: "/v1/auto-tune/id/result"}, {method: "POST", path: "/v1/auto-tune/id/capabilities"},
		{method: "DELETE", path: "/v1/auto-tune/capabilities"}, {method: "GET", path: "/v1/tuning-profiles/"},
		{method: "GET", path: "/v1/tuning-profiles/id/extra"}, {method: "POST", path: "/v1/tuning-profiles"},
		{method: "PUT", path: "/v1/tuning-profiles/id"}, {method: "GET", path: "/v1/rag/embedding-presets"},
	}
	calls := 0
	c := autoTuneScopeClient(t, "", autoTuneScopeTransport(func(*http.Request) (*http.Response, error) {
		calls++
		return autoTuneScopeReply(500, `{}`), nil
	}))
	for _, spec := range cases {
		spec.projectID = "explicit-project"
		got, err := c.applyProProject(WithProProject(context.Background(), " \t "), spec)
		if err != nil || !reflect.DeepEqual(got, spec) {
			t.Errorf("%s %s changed=%+v err=%v", spec.method, spec.path, got, err)
		}
	}
	if len(cases) != 14 || calls != 0 {
		t.Fatalf("cases/calls=%d/%d want=14/0", len(cases), calls)
	}
}

func TestAutoTuneProjectShouldPreserveExplicitSelectionOutsidePro(t *testing.T) {
	cases := []struct {
		target   Target
		selected bool
	}{
		{TargetEnterprise, false}, {TargetEnterprise, true}, {TargetPro, false},
	}
	for _, test := range cases {
		t.Run(fmt.Sprintf("%s/selected=%t", test.target, test.selected), func(t *testing.T) {
			calls := 0
			c := autoTuneScopeClient(t, test.target, autoTuneScopeTransport(func(r *http.Request) (*http.Response, error) {
				calls++
				if r.Method != "DELETE" || r.URL.RequestURI() != "/v1/auto-tune/id" {
					t.Errorf("request=%s %s", r.Method, r.URL)
				}
				if r.Header.Get("X-Project-ID") != "explicit-project" {
					t.Errorf("project=%q", r.Header.Get("X-Project-ID"))
				}
				return autoTuneScopeReply(204, ""), nil
			}))
			ctx := context.Background()
			if test.selected {
				ctx = WithProProject(ctx, " \t ")
			}
			spec := requestSpec{method: "DELETE", path: "/v1/auto-tune/id", projectID: "explicit-project"}
			if err := c.doJSON(ctx, spec, nil); err != nil {
				t.Fatal(err)
			}
			if calls != 1 {
				t.Fatalf("calls=%d want=1", calls)
			}
		})
	}
}
