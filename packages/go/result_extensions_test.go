package xberg_test

import (
	"context"
	"encoding/json"
	"os"
	"reflect"
	"testing"
)

func TestJobResultRetainsUndocumentedDocumentProperties(t *testing.T) {
	raw, err := os.ReadFile("../../spec/fixtures/extraction_result_ocr_recovery.json")
	if err != nil {
		t.Fatal(err)
	}
	response := `{"job_id":"aaaaaaaa-0000-4000-8000-000000000001","status":"completed","cached":false,"results":[` + string(raw) + `]}`
	var seen recordedRequest
	c := proClient(t, 200, response, &seen)
	result, err := c.GetJobResult(context.Background(), "aaaaaaaa-0000-4000-8000-000000000001")
	if err != nil {
		t.Fatal(err)
	}
	if seen.method != "GET" || seen.path != "/v1/jobs/aaaaaaaa-0000-4000-8000-000000000001/result" {
		t.Fatalf("request=%+v", seen)
	}
	if result.Results == nil || len(*result.Results) != 1 {
		t.Fatalf("results=%+v", result.Results)
	}
	encoded, err := json.Marshal((*result.Results)[0])
	if err != nil {
		t.Fatal(err)
	}
	var got, want map[string]json.RawMessage
	if err = json.Unmarshal(encoded, &got); err != nil {
		t.Fatal(err)
	}
	if err = json.Unmarshal(raw, &want); err != nil {
		t.Fatal(err)
	}
	for _, key := range []string{"ocr_page_failures", "pages", "future_opaque"} {
		var gotValue, wantValue any
		if err = json.Unmarshal(got[key], &gotValue); err != nil {
			t.Fatalf("missing preserved %s: %s", key, encoded)
		}
		if err = json.Unmarshal(want[key], &wantValue); err != nil {
			t.Fatal(err)
		}
		if !reflect.DeepEqual(gotValue, wantValue) {
			t.Fatalf("%s=%+v want %+v", key, gotValue, wantValue)
		}
	}
}
