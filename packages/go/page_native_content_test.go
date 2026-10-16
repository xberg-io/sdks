package xberg_test

import (
	"encoding/json"
	"reflect"
	"testing"

	xberg "github.com/xberg-io/sdks/packages/go"
)

func TestNativeContentPageOptionPreservesTrueFalseAndOmission(t *testing.T) {
	for _, flag := range []*bool{ptrTo(true), ptrTo(false), nil} {
		name := "omitted"
		if flag != nil {
			if *flag {
				name = "true"
			} else {
				name = "false"
			}
		}
		t.Run(name, func(t *testing.T) {
			config := xberg.ExtractionConfig{Pages: &xberg.PageConfig{ExtractPages: ptrTo(true), KeepNativeContent: flag}}
			raw, err := json.Marshal(config)
			if err != nil {
				t.Fatal(err)
			}
			expected := map[string]interface{}{"extract_pages": true}
			if flag != nil {
				expected["keep_native_content"] = *flag
			}
			var payload map[string]interface{}
			if err = json.Unmarshal(raw, &payload); err != nil {
				t.Fatal(err)
			}
			if !reflect.DeepEqual(payload["pages"], expected) {
				t.Fatalf("wire=%s want pages=%+v", raw, expected)
			}
			var decoded xberg.ExtractionConfig
			if err = json.Unmarshal(raw, &decoded); err != nil {
				t.Fatal(err)
			}
			if decoded.Pages == nil || !reflect.DeepEqual(decoded.Pages.KeepNativeContent, flag) {
				t.Fatalf("decoded pages=%+v want flag=%v", decoded.Pages, flag)
			}
		})
	}
}
