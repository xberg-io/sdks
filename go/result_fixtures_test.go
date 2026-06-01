package kreuzbergcloud_test

import (
	"encoding/json"
	"os"
	"path/filepath"
	"testing"

	kreuzbergcloud "github.com/kreuzberg-dev/kreuzberg-cloud-sdk/go"
)

// loadFixture reads a JSON file from spec/fixtures/ relative to the go/ module
// directory and unmarshals it into a JobResult. The fixture represents an
// ExtractionResult payload as returned by GET /v1/jobs/{id} → result field.
func loadFixture(t *testing.T, name string) kreuzbergcloud.JobResult {
	t.Helper()
	path := filepath.Join("..", "spec", "fixtures", name)
	data, err := os.ReadFile(path)
	if err != nil {
		t.Fatalf("read fixture %q: %v", name, err)
	}
	var r kreuzbergcloud.JobResult
	if err := json.Unmarshal(data, &r); err != nil {
		t.Fatalf("unmarshal %q: %v", name, err)
	}
	return r
}

// ---------------------------------------------------------------------------
// Smoke: all fixtures must unmarshal into JobResult without error
// ---------------------------------------------------------------------------

func TestAllFixturesUnmarshalWithoutError(t *testing.T) {
	t.Parallel()
	fixtures := []string{
		"extraction_result_minimal.json",
		"extraction_result_pdf.json",
		"extraction_result_xlsx_with_children.json",
		"extraction_result_docx_with_revisions.json",
		"extraction_result_with_uris.json",
	}
	for _, name := range fixtures {
		name := name
		t.Run(name, func(t *testing.T) {
			t.Parallel()
			loadFixture(t, name)
		})
	}
}

// ---------------------------------------------------------------------------
// Minimal fixture
// ---------------------------------------------------------------------------

func TestMinimalFixture_ContentAndMimeType(t *testing.T) {
	t.Parallel()
	r := loadFixture(t, "extraction_result_minimal.json")
	if r.Content != "Hello" {
		t.Errorf("Content = %q, want %q", r.Content, "Hello")
	}
	if r.MimeType != "text/plain" {
		t.Errorf("MimeType = %q, want %q", r.MimeType, "text/plain")
	}
}

func TestMinimalFixture_TablesIsEmptyArray(t *testing.T) {
	t.Parallel()
	r := loadFixture(t, "extraction_result_minimal.json")
	var tables []json.RawMessage
	if err := json.Unmarshal(r.Tables, &tables); err != nil {
		t.Fatalf("tables decode: %v", err)
	}
	if len(tables) != 0 {
		t.Errorf("tables len = %d, want 0", len(tables))
	}
}

// ---------------------------------------------------------------------------
// PDF fixture
// ---------------------------------------------------------------------------

func TestPdfFixture_MimeType(t *testing.T) {
	t.Parallel()
	r := loadFixture(t, "extraction_result_pdf.json")
	if r.MimeType != "application/pdf" {
		t.Errorf("MimeType = %q, want application/pdf", r.MimeType)
	}
}

func TestPdfFixture_QualityScore(t *testing.T) {
	t.Parallel()
	r := loadFixture(t, "extraction_result_pdf.json")
	if r.QualityScore == nil {
		t.Fatal("QualityScore is nil, want ~0.91")
	}
	if *r.QualityScore < 0.9 || *r.QualityScore > 0.92 {
		t.Errorf("QualityScore = %f, want ~0.91", *r.QualityScore)
	}
}

func TestPdfFixture_MetadataHasFormatDiscriminator(t *testing.T) {
	t.Parallel()
	r := loadFixture(t, "extraction_result_pdf.json")
	var meta struct {
		Format struct {
			FormatType string `json:"format_type"`
		} `json:"format"`
	}
	if err := json.Unmarshal(r.Metadata, &meta); err != nil {
		t.Fatalf("metadata decode: %v", err)
	}
	if meta.Format.FormatType != "ocr" {
		t.Errorf("format_type = %q, want %q", meta.Format.FormatType, "ocr")
	}
}

func TestPdfFixture_MetadataHasAuthors(t *testing.T) {
	t.Parallel()
	r := loadFixture(t, "extraction_result_pdf.json")
	var meta struct {
		Authors []string `json:"authors"`
	}
	if err := json.Unmarshal(r.Metadata, &meta); err != nil {
		t.Fatalf("metadata decode: %v", err)
	}
	if len(meta.Authors) != 2 {
		t.Fatalf("authors len = %d, want 2", len(meta.Authors))
	}
	if meta.Authors[0] != "Alice Müller" {
		t.Errorf("authors[0] = %q, want %q", meta.Authors[0], "Alice Müller")
	}
}

func TestPdfFixture_TableCellsAreNestedArrays(t *testing.T) {
	t.Parallel()
	r := loadFixture(t, "extraction_result_pdf.json")
	var tables []struct {
		Cells [][]string `json:"cells"`
	}
	if err := json.Unmarshal(r.Tables, &tables); err != nil {
		t.Fatalf("tables decode: %v", err)
	}
	if len(tables) != 1 {
		t.Fatalf("tables len = %d, want 1", len(tables))
	}
	if len(tables[0].Cells) != 2 {
		t.Fatalf("cells rows = %d, want 2", len(tables[0].Cells))
	}
	if tables[0].Cells[0][0] != "Header A" {
		t.Errorf("cells[0][0] = %q, want %q", tables[0].Cells[0][0], "Header A")
	}
	if tables[0].Cells[1][1] != "Row 1B" {
		t.Errorf("cells[1][1] = %q, want %q", tables[0].Cells[1][1], "Row 1B")
	}
}

func TestPdfFixture_PagesHaveThreeEntries(t *testing.T) {
	t.Parallel()
	r := loadFixture(t, "extraction_result_pdf.json")
	var pages []struct {
		PageNumber int `json:"page_number"`
	}
	if err := json.Unmarshal(r.Pages, &pages); err != nil {
		t.Fatalf("pages decode: %v", err)
	}
	if len(pages) != 3 {
		t.Errorf("pages len = %d, want 3", len(pages))
	}
	if pages[0].PageNumber != 1 {
		t.Errorf("pages[0].page_number = %d, want 1", pages[0].PageNumber)
	}
}

// ---------------------------------------------------------------------------
// XLSX with children fixture
// ---------------------------------------------------------------------------

func TestXlsxFixture_MimeType(t *testing.T) {
	t.Parallel()
	r := loadFixture(t, "extraction_result_xlsx_with_children.json")
	want := "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
	if r.MimeType != want {
		t.Errorf("MimeType = %q, want %q", r.MimeType, want)
	}
}

func TestXlsxFixture_MetadataFormatTypeIsExcel(t *testing.T) {
	t.Parallel()
	r := loadFixture(t, "extraction_result_xlsx_with_children.json")
	var meta struct {
		Format struct {
			FormatType string   `json:"format_type"`
			SheetCount int      `json:"sheet_count"`
			SheetNames []string `json:"sheet_names"`
		} `json:"format"`
	}
	if err := json.Unmarshal(r.Metadata, &meta); err != nil {
		t.Fatalf("metadata decode: %v", err)
	}
	if meta.Format.FormatType != "excel" {
		t.Errorf("format_type = %q, want %q", meta.Format.FormatType, "excel")
	}
	if meta.Format.SheetCount != 3 {
		t.Errorf("sheet_count = %d, want 3", meta.Format.SheetCount)
	}
}

func TestXlsxFixture_ChildrenHaveOneEntry(t *testing.T) {
	t.Parallel()

	// JobResult doesn't type children; decode from raw JSON
	type nestedResult struct {
		Content  string `json:"content"`
		MimeType string `json:"mime_type"`
	}
	type child struct {
		Path     string       `json:"path"`
		MimeType string       `json:"mime_type"`
		Result   nestedResult `json:"result"`
	}
	type envelope struct {
		Children []child `json:"children"`
	}

	raw, err := os.ReadFile(filepath.Join("..", "spec", "fixtures", "extraction_result_xlsx_with_children.json"))
	if err != nil {
		t.Fatalf("read fixture: %v", err)
	}
	// Unmarshal the full fixture to get children (not in JobResult typed fields)
	var full envelope
	if err := json.Unmarshal(raw, &full); err != nil {
		t.Fatalf("unmarshal full fixture: %v", err)
	}

	if len(full.Children) != 1 {
		t.Fatalf("children len = %d, want 1", len(full.Children))
	}
	if full.Children[0].Path != "xl/embeddings/Doc1.docx" {
		t.Errorf("path = %q, want xl/embeddings/Doc1.docx", full.Children[0].Path)
	}
	if full.Children[0].Result.Content == "" {
		t.Error("nested result content is empty")
	}
}

func TestXlsxFixture_TablesHaveThreeEntries(t *testing.T) {
	t.Parallel()
	r := loadFixture(t, "extraction_result_xlsx_with_children.json")
	var tables []struct {
		Cells [][]string `json:"cells"`
	}
	if err := json.Unmarshal(r.Tables, &tables); err != nil {
		t.Fatalf("tables decode: %v", err)
	}
	if len(tables) != 3 {
		t.Errorf("tables len = %d, want 3", len(tables))
	}
}

// ---------------------------------------------------------------------------
// DOCX with revisions fixture
// ---------------------------------------------------------------------------

func TestDocxFixture_RevisionsCount(t *testing.T) {
	t.Parallel()
	raw, err := os.ReadFile(filepath.Join("..", "spec", "fixtures", "extraction_result_docx_with_revisions.json"))
	if err != nil {
		t.Fatalf("read fixture: %v", err)
	}
	var envelope struct {
		Revisions []struct {
			Kind       string `json:"kind"`
			Author     string `json:"author"`
			RevisionID string `json:"revision_id"`
			Timestamp  string `json:"timestamp"`
		} `json:"revisions"`
	}
	if err := json.Unmarshal(raw, &envelope); err != nil {
		t.Fatalf("unmarshal: %v", err)
	}
	if len(envelope.Revisions) != 3 {
		t.Fatalf("revisions len = %d, want 3", len(envelope.Revisions))
	}
}

func TestDocxFixture_FirstRevisionIsInsertionByAlice(t *testing.T) {
	t.Parallel()
	raw, err := os.ReadFile(filepath.Join("..", "spec", "fixtures", "extraction_result_docx_with_revisions.json"))
	if err != nil {
		t.Fatalf("read fixture: %v", err)
	}
	var envelope struct {
		Revisions []struct {
			Kind       string `json:"kind"`
			Author     string `json:"author"`
			RevisionID string `json:"revision_id"`
			Timestamp  string `json:"timestamp"`
		} `json:"revisions"`
	}
	if err := json.Unmarshal(raw, &envelope); err != nil {
		t.Fatalf("unmarshal: %v", err)
	}
	rev := envelope.Revisions[0]
	if rev.Kind != "insertion" {
		t.Errorf("kind = %q, want insertion", rev.Kind)
	}
	if rev.Author != "Alice" {
		t.Errorf("author = %q, want Alice", rev.Author)
	}
	if rev.RevisionID != "42" {
		t.Errorf("revision_id = %q, want 42", rev.RevisionID)
	}
	if rev.Timestamp != "2024-03-15T10:30:00Z" {
		t.Errorf("timestamp = %q, want 2024-03-15T10:30:00Z", rev.Timestamp)
	}
}

func TestDocxFixture_RevisionKindsCoverAllThreeVariants(t *testing.T) {
	t.Parallel()
	raw, err := os.ReadFile(filepath.Join("..", "spec", "fixtures", "extraction_result_docx_with_revisions.json"))
	if err != nil {
		t.Fatalf("read fixture: %v", err)
	}
	var envelope struct {
		Revisions []struct {
			Kind string `json:"kind"`
		} `json:"revisions"`
	}
	if err := json.Unmarshal(raw, &envelope); err != nil {
		t.Fatalf("unmarshal: %v", err)
	}
	kinds := make(map[string]bool)
	for _, rev := range envelope.Revisions {
		kinds[rev.Kind] = true
	}
	for _, want := range []string{"insertion", "deletion", "comment"} {
		if !kinds[want] {
			t.Errorf("missing revision kind %q", want)
		}
	}
}

func TestDocxFixture_ExtractedKeywordsHaveYakeAlgorithm(t *testing.T) {
	t.Parallel()
	raw, err := os.ReadFile(filepath.Join("..", "spec", "fixtures", "extraction_result_docx_with_revisions.json"))
	if err != nil {
		t.Fatalf("read fixture: %v", err)
	}
	var envelope struct {
		ExtractedKeywords []struct {
			Text      string  `json:"text"`
			Score     float64 `json:"score"`
			Algorithm string  `json:"algorithm"`
			Positions []int   `json:"positions"`
		} `json:"extracted_keywords"`
	}
	if err := json.Unmarshal(raw, &envelope); err != nil {
		t.Fatalf("unmarshal: %v", err)
	}
	if len(envelope.ExtractedKeywords) < 2 {
		t.Fatalf("extracted_keywords len = %d, want >= 2", len(envelope.ExtractedKeywords))
	}
	kw := envelope.ExtractedKeywords[0]
	if kw.Algorithm != "yake" {
		t.Errorf("algorithm = %q, want yake", kw.Algorithm)
	}
	if kw.Score <= 0 {
		t.Errorf("score = %f, want > 0", kw.Score)
	}
	if kw.Text != "project timeline" {
		t.Errorf("text = %q, want project timeline", kw.Text)
	}
}

func TestDocxFixture_KeywordPositionsAreIntegerSlice(t *testing.T) {
	t.Parallel()
	raw, err := os.ReadFile(filepath.Join("..", "spec", "fixtures", "extraction_result_docx_with_revisions.json"))
	if err != nil {
		t.Fatalf("read fixture: %v", err)
	}
	var envelope struct {
		ExtractedKeywords []struct {
			Positions []int `json:"positions"`
		} `json:"extracted_keywords"`
	}
	if err := json.Unmarshal(raw, &envelope); err != nil {
		t.Fatalf("unmarshal: %v", err)
	}
	positions := envelope.ExtractedKeywords[0].Positions
	if len(positions) != 2 {
		t.Fatalf("positions len = %d, want 2", len(positions))
	}
	if positions[0] != 4 || positions[1] != 30 {
		t.Errorf("positions = %v, want [4 30]", positions)
	}
}

// ---------------------------------------------------------------------------
// URI fixture
// ---------------------------------------------------------------------------

func TestUriFixture_HasThreeUris(t *testing.T) {
	t.Parallel()
	raw, err := os.ReadFile(filepath.Join("..", "spec", "fixtures", "extraction_result_with_uris.json"))
	if err != nil {
		t.Fatalf("read fixture: %v", err)
	}
	var envelope struct {
		Uris []struct {
			Kind  string `json:"kind"`
			URL   string `json:"url"`
			Label string `json:"label"`
			Page  int    `json:"page"`
		} `json:"uris"`
	}
	if err := json.Unmarshal(raw, &envelope); err != nil {
		t.Fatalf("unmarshal: %v", err)
	}
	if len(envelope.Uris) != 3 {
		t.Fatalf("uris len = %d, want 3", len(envelope.Uris))
	}
}

func TestUriFixture_AllUrisHaveNonEmptyURL(t *testing.T) {
	t.Parallel()
	raw, err := os.ReadFile(filepath.Join("..", "spec", "fixtures", "extraction_result_with_uris.json"))
	if err != nil {
		t.Fatalf("read fixture: %v", err)
	}
	var envelope struct {
		Uris []struct {
			URL string `json:"url"`
		} `json:"uris"`
	}
	if err := json.Unmarshal(raw, &envelope); err != nil {
		t.Fatalf("unmarshal: %v", err)
	}
	for i, u := range envelope.Uris {
		if u.URL == "" {
			t.Errorf("uris[%d].url is empty", i)
		}
	}
}

func TestUriFixture_KindsLabelsAndValues(t *testing.T) {
	t.Parallel()
	raw, err := os.ReadFile(filepath.Join("..", "spec", "fixtures", "extraction_result_with_uris.json"))
	if err != nil {
		t.Fatalf("read fixture: %v", err)
	}
	var envelope struct {
		Uris []struct {
			Kind  string `json:"kind"`
			URL   string `json:"url"`
			Label string `json:"label"`
			Page  int    `json:"page"`
		} `json:"uris"`
	}
	if err := json.Unmarshal(raw, &envelope); err != nil {
		t.Fatalf("unmarshal: %v", err)
	}
	uris := envelope.Uris
	if uris[0].Kind != "hyperlink" {
		t.Errorf("uris[0].kind = %q, want hyperlink", uris[0].Kind)
	}
	if uris[0].URL != "https://docs.example.com" {
		t.Errorf("uris[0].url = %q, want https://docs.example.com", uris[0].URL)
	}
	if uris[0].Label != "official documentation" {
		t.Errorf("uris[0].label = %q, want official documentation", uris[0].Label)
	}
	if uris[1].Kind != "email" {
		t.Errorf("uris[1].kind = %q, want email", uris[1].Kind)
	}
	if uris[2].Kind != "anchor" {
		t.Errorf("uris[2].kind = %q, want anchor", uris[2].Kind)
	}
}

func TestUriFixture_AllUrisAreOnPage1(t *testing.T) {
	t.Parallel()
	raw, err := os.ReadFile(filepath.Join("..", "spec", "fixtures", "extraction_result_with_uris.json"))
	if err != nil {
		t.Fatalf("read fixture: %v", err)
	}
	var envelope struct {
		Uris []struct {
			Page int `json:"page"`
		} `json:"uris"`
	}
	if err := json.Unmarshal(raw, &envelope); err != nil {
		t.Fatalf("unmarshal: %v", err)
	}
	for i, u := range envelope.Uris {
		if u.Page != 1 {
			t.Errorf("uris[%d].page = %d, want 1", i, u.Page)
		}
	}
}
