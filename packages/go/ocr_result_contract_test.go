package xberg_test

import (
	"context"
	"encoding/json"
	"os"
	"reflect"
	"testing"

	xberg "github.com/xberg-io/sdks/packages/go"
)

func TestJobExposesTypedOCRRecoveryFields(t *testing.T) {
	raw, err := os.ReadFile("../../spec/fixtures/extraction_result_ocr_recovery.json")
	if err != nil {
		t.Fatal(err)
	}
	for _, target := range []xberg.Target{xberg.TargetPro, xberg.TargetEnterprise} {
		t.Run(string(target), func(t *testing.T) {
			var seen recordedRequest
			payload := `{"id":"aaaaaaaa-0000-4000-8000-000000000001","filename":"synthetic.pdf","mime_type":"application/pdf","job_type":"extraction","status":"completed","result":` + string(raw) + `}`
			c := targetClient(t, target, 200, payload, &seen)
			job, err := c.GetJob(context.Background(), "aaaaaaaa-0000-4000-8000-000000000001")
			if err != nil {
				t.Fatal(err)
			}
			if seen.method != "GET" || seen.path != "/v1/jobs/aaaaaaaa-0000-4000-8000-000000000001" {
				t.Fatalf("request=%+v", seen)
			}
			extraction, err := job.AsGetJobResponse0()
			if err != nil {
				t.Fatal(err)
			}
			result := extraction.Result
			if result == nil || result.OcrPageFailures == nil || len(*result.OcrPageFailures) != 1 {
				t.Fatalf("result=%+v", result)
			}
			failure := (*result.OcrPageFailures)[0]
			if failure.Page != 1 || !failure.Recovered {
				t.Fatalf("failure=%+v", failure)
			}
			if result.Pages == nil || len(*result.Pages) != 1 {
				t.Fatalf("pages=%+v", result.Pages)
			}
			page := (*result.Pages)[0]
			if page.NativeContent == nil || *page.NativeContent != "Invoice total 125.50" {
				t.Fatalf("page=%+v", page)
			}
		})
	}
}

func TestPaddleOCRSettingsRoundTripThroughTypedConfig(t *testing.T) {
	settings := map[string]interface{}{"device": "cpu", "threads": float64(2)}
	config := xberg.ExtractionConfig{Ocr: &xberg.OcrConfig{PaddleOcrSettings: &settings}}
	raw, err := json.Marshal(config)
	if err != nil {
		t.Fatal(err)
	}
	var decoded xberg.ExtractionConfig
	if err = json.Unmarshal(raw, &decoded); err != nil {
		t.Fatal(err)
	}
	if decoded.Ocr == nil || decoded.Ocr.PaddleOcrSettings == nil {
		t.Fatalf("config=%+v", decoded)
	}
	got := *decoded.Ocr.PaddleOcrSettings
	if got["device"] != "cpu" || got["threads"] != float64(2) {
		t.Fatalf("settings=%+v", got)
	}
}

func TestUnsetOCRAndKeywordReferencesAreOmitted(t *testing.T) {
	config := xberg.ExtractionConfig{
		Keywords: &xberg.KeywordConfig{},
		Ocr:      &xberg.OcrConfig{TesseractConfig: &xberg.TesseractConfig{}},
	}
	raw, err := json.Marshal(config)
	if err != nil {
		t.Fatal(err)
	}
	var decoded map[string]interface{}
	if err = json.Unmarshal(raw, &decoded); err != nil {
		t.Fatal(err)
	}
	keywords := decoded["keywords"].(map[string]interface{})
	for _, key := range []string{"rake_params", "yake_params"} {
		if _, present := keywords[key]; present {
			t.Fatalf("unset %s serialized: %s", key, raw)
		}
	}
	ocr := decoded["ocr"].(map[string]interface{})
	tesseract := ocr["tesseract_config"].(map[string]interface{})
	if _, present := tesseract["preprocessing"]; present {
		t.Fatalf("unset preprocessing serialized: %s", raw)
	}
}

func TestPresentOCRAndKeywordReferencesDecodeWithExactValues(t *testing.T) {
	raw := `{"keywords":{"rake_params":{"min_word_length":2,"max_words_per_phrase":3},"yake_params":{"window_size":2}},"ocr":{"tesseract_config":{"preprocessing":{"auto_rotate":false,"binarization_method":"otsu","contrast_enhance":false,"denoise":false,"deskew":true,"invert_colors":false,"target_dpi":300}}}}`
	var config xberg.ExtractionConfig
	if err := json.Unmarshal([]byte(raw), &config); err != nil {
		t.Fatal(err)
	}
	if config.Keywords == nil || config.Keywords.RakeParams == nil || config.Keywords.YakeParams == nil {
		t.Fatalf("keywords=%+v", config.Keywords)
	}
	if config.Keywords.RakeParams.MinWordLength != 2 || config.Keywords.RakeParams.MaxWordsPerPhrase != 3 || config.Keywords.YakeParams.WindowSize != 2 {
		t.Fatalf("keywords=%+v", config.Keywords)
	}
	if config.Ocr == nil || config.Ocr.TesseractConfig == nil || config.Ocr.TesseractConfig.Preprocessing == nil {
		t.Fatalf("ocr=%+v", config.Ocr)
	}
	prep := config.Ocr.TesseractConfig.Preprocessing
	want := &xberg.ImagePreprocessingConfig{
		AutoRotate: ptrTo(false), BinarizationMethod: ptrTo("otsu"), ContrastEnhance: ptrTo(false),
		Denoise: ptrTo(false), Deskew: ptrTo(true), InvertColors: ptrTo(false), TargetDpi: ptrTo(int32(300)),
	}
	if !reflect.DeepEqual(prep, want) {
		t.Fatalf("preprocessing=%+v want %+v", prep, want)
	}
	encoded, err := json.Marshal(config)
	if err != nil {
		t.Fatal(err)
	}
	var decoded xberg.ExtractionConfig
	if err = json.Unmarshal(encoded, &decoded); err != nil {
		t.Fatal(err)
	}
	if !reflect.DeepEqual(config, decoded) {
		t.Fatalf("roundtrip=%s", encoded)
	}
}
