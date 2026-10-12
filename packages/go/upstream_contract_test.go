package xberg_test

import (
	"encoding/json"
	"strings"
	"testing"

	xberg "github.com/xberg-io/sdks/packages/go"
)

func TestUpstreamDirectFieldTypes(t *testing.T) {
	hash := strings.Repeat("a", 64)
	action := xberg.JobSubmit
	entry := xberg.DocumentVersionEntry{ContentHash: &hash}
	params := xberg.ListAuditEntriesParams{Action: &action}
	llm := xberg.LlmConfig{ApiKey: "fixture-key", Model: "fixture-model"}
	_ = xberg.ProPresignUploadRequest{Documents: []xberg.ProPresignDocumentInput{{Filename: "fixture.pdf", MimeType: "application/pdf"}}}
	_ = xberg.SandboxExtractResponse{Result: &xberg.BackendExtractedDocument{Content: "result"}}
	var health xberg.HealthResponse
	health.Rag.Enabled = true
	if entry.ContentHash == nil || *entry.ContentHash != hash || !params.Action.Valid() || !health.Rag.Enabled {
		t.Fatal("corrected upstream field values changed")
	}
	encoded, err := json.Marshal(llm)
	if err != nil {
		t.Fatal(err)
	}
	var object map[string]json.RawMessage
	if err := json.Unmarshal(encoded, &object); err != nil {
		t.Fatal(err)
	}
	if string(object["api_key"]) != `"fixture-key"` {
		t.Fatalf("API key wire value = %s", encoded)
	}
	encoded, err = json.Marshal(params)
	if err != nil {
		t.Fatal(err)
	}
	if err := json.Unmarshal(encoded, &object); err != nil {
		t.Fatal(err)
	}
	if string(object["action"]) != `"job.submit"` {
		t.Fatalf("audit action wire value = %s", encoded)
	}
}

func TestUpstreamVersionHashNullableRoundTrip(t *testing.T) {
	for _, hash := range []string{"null", `"` + strings.Repeat("a", 64) + `"`} {
		previous := "previous"
		entry := xberg.DocumentVersionEntry{ContentHash: &previous}
		if err := json.Unmarshal([]byte(`{"content_hash":`+hash+`,"filename":"fixture.pdf"}`), &entry); err != nil {
			t.Fatal(err)
		}
		encoded, err := json.Marshal(entry)
		if err != nil {
			t.Fatal(err)
		}
		var object map[string]json.RawMessage
		if err := json.Unmarshal(encoded, &object); err != nil {
			t.Fatal(err)
		}
		if string(object["content_hash"]) != hash || entry.Filename != "fixture.pdf" {
			t.Fatalf("round trip = %s", encoded)
		}
		if hash == "null" && entry.ContentHash != nil {
			t.Fatal("null hash retained previous value")
		}
	}
}

func TestUpstreamProPresignOptionalConfigAndAPIKey(t *testing.T) {
	config := &xberg.ProFileExtractionConfig{StructuredExtraction: &xberg.ProStructuredExtractionConfig{Llm: xberg.ProLlmConfig{Model: "fixture-model"}}}
	request := xberg.ProPresignUploadRequest{Documents: []xberg.ProPresignDocumentInput{{Filename: "fixture.pdf", MimeType: "application/pdf", Config: config}}}
	encoded, err := json.Marshal(request)
	if err != nil {
		t.Fatal(err)
	}
	var object map[string]any
	if err := json.Unmarshal(encoded, &object); err != nil {
		t.Fatal(err)
	}
	document := object["documents"].([]any)[0].(map[string]any)
	llm := document["config"].(map[string]any)["structured_extraction"].(map[string]any)["llm"].(map[string]any)
	if _, exists := llm["api_key"]; exists {
		t.Fatalf("optional API key serialized: %s", encoded)
	}
	if llm["model"] != "fixture-model" {
		t.Fatalf("LLM config lost: %s", encoded)
	}
	key := "fixture-key"
	config.StructuredExtraction.Llm.ApiKey = &key
	encoded, err = json.Marshal(request)
	if err != nil {
		t.Fatal(err)
	}
	if err := json.Unmarshal(encoded, &object); err != nil {
		t.Fatal(err)
	}
	document = object["documents"].([]any)[0].(map[string]any)
	llm = document["config"].(map[string]any)["structured_extraction"].(map[string]any)["llm"].(map[string]any)
	if llm["api_key"] != key {
		t.Fatalf("explicit API key lost: %s", encoded)
	}
	request.Documents[0].Config = nil
	encoded, err = json.Marshal(request)
	if err != nil {
		t.Fatal(err)
	}
	if err := json.Unmarshal(encoded, &object); err != nil {
		t.Fatal(err)
	}
	document = object["documents"].([]any)[0].(map[string]any)
	if _, exists := document["config"]; exists {
		t.Fatalf("optional per-file config serialized: %s", encoded)
	}
}

func TestUpstreamTesseractNumericThresholding(t *testing.T) {
	for _, value := range []int32{0, 1, 2} {
		config := xberg.TesseractConfig{ThresholdingMethod: &value}
		encoded, err := json.Marshal(config)
		if err != nil {
			t.Fatal(err)
		}
		var decoded xberg.TesseractConfig
		if err := json.Unmarshal(encoded, &decoded); err != nil {
			t.Fatal(err)
		}
		if decoded.ThresholdingMethod == nil || *decoded.ThresholdingMethod != value {
			t.Fatalf("numeric method %d round trip = %s", value, encoded)
		}
		var object map[string]any
		if err := json.Unmarshal(encoded, &object); err != nil {
			t.Fatal(err)
		}
		if number, ok := object["thresholding_method"].(float64); !ok || number != float64(value) {
			t.Fatalf("numeric method serialized as %v", object["thresholding_method"])
		}
	}
}

func TestUpstreamSandboxAndHealthResponseShapes(t *testing.T) {
	var sandbox xberg.SandboxExtractResponse
	if err := json.Unmarshal([]byte(`{"result":{"content":"result","metadata":{},"mime_type":"text/plain","tables":[]}}`), &sandbox); err != nil {
		t.Fatal(err)
	}
	if sandbox.Result == nil || sandbox.Result.Content != "result" {
		t.Fatalf("sandbox result = %#v", sandbox.Result)
	}
	var result *xberg.BackendExtractedDocument = sandbox.Result
	if result.MimeType != "text/plain" {
		t.Fatal("backend result metadata lost")
	}
	var health xberg.HealthResponse
	if err := json.Unmarshal([]byte(`{"rag":{"enabled":true},"status":"ok","tier":"enterprise"}`), &health); err != nil {
		t.Fatal(err)
	}
	if !health.Rag.Enabled || health.Tier != "enterprise" {
		t.Fatalf("health response = %#v", health)
	}
}
