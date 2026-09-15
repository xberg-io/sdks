package xberg_test

import (
	"context"
	"net/http"
	"testing"

	xberg "github.com/xberg-io/sdks/packages/go"
)

const (
	savedPresetID       = "cccccccc-0000-4000-8000-000000000001"
	savedPresetListBody = `{"presets":[{"id":"cccccccc-0000-4000-8000-000000000001","name":"Invoice","preferred_call_mode":"tool_use",
		"created_at":"2025-01-01T00:00:00Z"}],"total":1,"limit":50,"page":0}`
	savedPresetDetailBody = `{"id":"cccccccc-0000-4000-8000-000000000001","name":"Invoice","preferred_call_mode":"tool_use",
		"emit_citations":true,"schema":{"type":"object"},
		"created_at":"2025-01-01T00:00:00Z","updated_at":"2025-01-02T00:00:00Z"}`
)

// savedPresetsBase is the one route spelling both specs declare. A hyphenated
// `/v1/saved-presets` appears in neither — it survives only as a tag name — so
// the client must reach this path on either tier.
const savedPresetsBase = "/v1/saved_presets"

// savedPresetTargets are the tiers every saved-preset test exercises; both must
// reach savedPresetsBase.
var savedPresetTargets = []xberg.Target{xberg.TargetEnterprise, xberg.TargetPro}

func TestListSavedPresets_ReachesTheSharedRoute(t *testing.T) {
	t.Parallel()
	for _, target := range savedPresetTargets {
		t.Run(string(target), func(t *testing.T) {
			t.Parallel()
			var seen recordedRequest
			client := targetClient(t, target, http.StatusOK, savedPresetListBody, &seen)

			page, err := client.ListSavedPresets(context.Background(), 25, 5)
			if err != nil {
				t.Fatalf("ListSavedPresets: %v", err)
			}
			if seen.method != http.MethodGet || seen.path != savedPresetsBase {
				t.Errorf("request = %s %s, want GET %s", seen.method, seen.path, savedPresetsBase)
			}
			if seen.query != "limit=25&offset=5" {
				t.Errorf("query = %q, want limit=25&offset=5", seen.query)
			}
			if page.Total != 1 || len(page.Presets) != 1 || page.Presets[0].Name != "Invoice" {
				t.Fatalf("page = %+v, want one preset named Invoice", page)
			}
		})
	}
}

func TestListSavedPresets_OmitsNonPositivePaging(t *testing.T) {
	t.Parallel()
	var seen recordedRequest
	client := targetClient(t, xberg.TargetPro, http.StatusOK, savedPresetListBody, &seen)

	if _, err := client.ListSavedPresets(context.Background(), 0, 0); err != nil {
		t.Fatalf("ListSavedPresets: %v", err)
	}
	if seen.query != "" {
		t.Errorf("query = %q, want empty when limit and offset are unset", seen.query)
	}
}

func TestCreateSavedPreset_ReachesTheSharedRoute(t *testing.T) {
	t.Parallel()
	for _, target := range savedPresetTargets {
		t.Run(string(target), func(t *testing.T) {
			t.Parallel()
			var seen recordedRequest
			client := targetClient(t, target, http.StatusCreated,
				`{"id":"cccccccc-0000-4000-8000-000000000001","message":"created"}`, &seen)

			emitCitations := true
			created, err := client.CreateSavedPreset(context.Background(), xberg.CreateSavedPresetRequest{
				Name:              "Invoice",
				PreferredCallMode: "tool_use",
				EmitCitations:     &emitCitations,
				Schema:            map[string]any{"type": "object"},
			})
			if err != nil {
				t.Fatalf("CreateSavedPreset: %v", err)
			}
			if seen.method != http.MethodPost || seen.path != savedPresetsBase {
				t.Errorf("request = %s %s, want POST %s", seen.method, seen.path, savedPresetsBase)
			}
			if created.Id.String() != savedPresetID {
				t.Errorf("Id = %q, want %s", created.Id.String(), savedPresetID)
			}
		})
	}
}

func TestGetSavedPreset_ReachesTheSharedRoute(t *testing.T) {
	t.Parallel()
	for _, target := range savedPresetTargets {
		t.Run(string(target), func(t *testing.T) {
			t.Parallel()
			var seen recordedRequest
			client := targetClient(t, target, http.StatusOK, savedPresetDetailBody, &seen)

			preset, err := client.GetSavedPreset(context.Background(), savedPresetID)
			if err != nil {
				t.Fatalf("GetSavedPreset: %v", err)
			}
			if seen.method != http.MethodGet || seen.path != savedPresetsBase+"/"+savedPresetID {
				t.Errorf("request = %s %s, want GET %s/%s", seen.method, seen.path, savedPresetsBase, savedPresetID)
			}
			if preset.Name != "Invoice" || !preset.EmitCitations {
				t.Errorf("preset = %+v, want name=Invoice emit_citations=true", preset)
			}
		})
	}
}

func TestUpdateSavedPreset_PatchesTheSharedRoute(t *testing.T) {
	t.Parallel()
	for _, target := range savedPresetTargets {
		t.Run(string(target), func(t *testing.T) {
			t.Parallel()
			var seen recordedRequest
			client := targetClient(t, target, http.StatusOK,
				`{"success":true,"message":"updated"}`, &seen)

			name := "Invoice v2"
			callMode := "text_only"
			emitCitations := false
			schema := map[string]any{"type": "object"}
			updated, err := client.UpdateSavedPreset(context.Background(), savedPresetID,
				xberg.UpdateSavedPresetRequest{
					Name:              &name,
					PreferredCallMode: &callMode,
					EmitCitations:     &emitCitations,
					Schema:            &schema,
				})
			if err != nil {
				t.Fatalf("UpdateSavedPreset: %v", err)
			}
			if seen.method != http.MethodPatch || seen.path != savedPresetsBase+"/"+savedPresetID {
				t.Errorf("request = %s %s, want PATCH %s/%s", seen.method, seen.path, savedPresetsBase, savedPresetID)
			}
			if !updated.Success {
				t.Errorf("Success = false, want true")
			}
		})
	}
}

func TestDeleteSavedPreset_DeletesTheSharedRoute(t *testing.T) {
	t.Parallel()
	for _, target := range savedPresetTargets {
		t.Run(string(target), func(t *testing.T) {
			t.Parallel()
			var seen recordedRequest
			client := targetClient(t, target, http.StatusNoContent, "", &seen)

			if err := client.DeleteSavedPreset(context.Background(), savedPresetID); err != nil {
				t.Fatalf("DeleteSavedPreset: %v", err)
			}
			if seen.method != http.MethodDelete || seen.path != savedPresetsBase+"/"+savedPresetID {
				t.Errorf("request = %s %s, want DELETE %s/%s", seen.method, seen.path, savedPresetsBase, savedPresetID)
			}
		})
	}
}

func TestSavedPresets_EscapePresetID(t *testing.T) {
	t.Parallel()
	var seen recordedRequest
	client := targetClient(t, xberg.TargetEnterprise, http.StatusOK, savedPresetDetailBody, &seen)

	if _, err := client.GetSavedPreset(context.Background(), "a b/c"); err != nil {
		t.Fatalf("GetSavedPreset: %v", err)
	}
	if seen.path != "/v1/saved_presets/a b/c" {
		t.Errorf("decoded path = %q, want the escaped saved-preset route", seen.path)
	}
}

// TestSavedPresets_AreNotTierGated pins the Phase 5 fix: the saved-preset
// methods used to require the Pro tier, which made them unreachable against an
// Enterprise instance that serves the very same operations.
func TestSavedPresets_AreNotTierGated(t *testing.T) {
	t.Parallel()
	var seen recordedRequest
	client := targetClient(t, xberg.TargetEnterprise, http.StatusOK, savedPresetListBody, &seen)

	_, err := client.ListSavedPresets(context.Background(), 0, 0)
	var tierErr *xberg.TierError
	if asError(err, &tierErr) {
		t.Fatalf("ListSavedPresets returned %v; saved presets must not be Pro-gated", tierErr)
	}
	if err != nil {
		t.Fatalf("ListSavedPresets on enterprise: %v", err)
	}
	if seen.path != savedPresetsBase {
		t.Errorf("path = %q, want %s to be reached", seen.path, savedPresetsBase)
	}
}
