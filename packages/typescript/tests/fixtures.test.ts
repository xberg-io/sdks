/**
 * Deserialization tests that lock in the ExtractionResult wire shape.
 *
 * Each test loads a JSON fixture from spec/fixtures/, casts it to the
 * generated TypeScript type, and asserts on specific field values. A
 * regression in the generated schema will make type-level assertions fail
 * at compile time and value-level assertions fail at runtime.
 */

import { readFileSync } from "node:fs";
import { resolve } from "node:path";
import { describe, expect, it } from "vitest";
import type { components } from "../src/_generated/schema";

type ExtractionResult = components["schemas"]["ExtractionResult"];

const FIXTURES = resolve(__dirname, "../../../spec/fixtures");

function load(name: string): ExtractionResult {
	return JSON.parse(readFileSync(resolve(FIXTURES, name), "utf-8")) as ExtractionResult;
}

// ---------------------------------------------------------------------------
// Smoke: all fixtures must parse as valid JSON and cast without error
// ---------------------------------------------------------------------------

describe("all fixtures deserialize without error", () => {
	const fixtureNames = [
		"extraction_result_minimal.json",
		"extraction_result_pdf.json",
		"extraction_result_xlsx_with_children.json",
		"extraction_result_docx_with_revisions.json",
		"extraction_result_with_uris.json",
	] as const;

	it.each(fixtureNames)("parses %s", (name) => {
		expect(() => load(name)).not.toThrow();
	});
});

// ---------------------------------------------------------------------------
// Minimal fixture
// ---------------------------------------------------------------------------

describe("minimal ExtractionResult", () => {
	it("should_have_correct_content_and_mime_type", () => {
		const r = load("extraction_result_minimal.json");
		expect(r.content).toBe("Hello");
		expect(r.mime_type).toBe("text/plain");
	});

	it("should_have_empty_tables_array", () => {
		const r = load("extraction_result_minimal.json");
		expect(r.tables).toEqual([]);
	});

	it("should_have_metadata_object", () => {
		const r = load("extraction_result_minimal.json");
		expect(r.metadata).toBeDefined();
		expect(typeof r.metadata).toBe("object");
	});
});

// ---------------------------------------------------------------------------
// PDF fixture
// ---------------------------------------------------------------------------

describe("PDF ExtractionResult", () => {
	it("should_have_pdf_mime_type", () => {
		const r = load("extraction_result_pdf.json");
		expect(r.mime_type).toBe("application/pdf");
	});

	it("should_have_authors_as_string_array", () => {
		const r = load("extraction_result_pdf.json");
		expect(r.metadata.authors).toEqual(["Alice Müller", "Bob Chen"]);
	});

	it("should_have_quality_score_close_to_expected_value", () => {
		const r = load("extraction_result_pdf.json");
		expect(r.quality_score).toBeCloseTo(0.91);
	});

	it("Table_cells_is_a_nested_string_array", () => {
		const r = load("extraction_result_pdf.json");
		expect(r.tables[0]?.cells).toEqual([
			["Header A", "Header B"],
			["Row 1A", "Row 1B"],
		]);
	});

	it("should_have_table_page_number_and_markdown", () => {
		const r = load("extraction_result_pdf.json");
		const table = r.tables[0];
		expect(table?.page_number).toBe(1);
		expect(table?.markdown).toContain("Header A");
	});

	it("PDF_metadata_format_uses_ocr_format_type_discriminator", () => {
		const r = load("extraction_result_pdf.json");
		expect(r.metadata.format?.format_type).toBe("ocr");
	});

	it("should_have_three_pages", () => {
		const r = load("extraction_result_pdf.json");
		expect(r.pages).toHaveLength(3);
		expect(r.pages?.[0]?.page_number).toBe(1);
	});
});

// ---------------------------------------------------------------------------
// XLSX with children fixture
// ---------------------------------------------------------------------------

describe("XLSX ExtractionResult with children", () => {
	it("should_have_xlsx_mime_type", () => {
		const r = load("extraction_result_xlsx_with_children.json");
		expect(r.mime_type).toBe("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
	});

	it("should_have_excel_format_type_discriminator", () => {
		const r = load("extraction_result_xlsx_with_children.json");
		expect(r.metadata.format?.format_type).toBe("excel");
	});

	it("should_have_one_child_archive_entry", () => {
		const r = load("extraction_result_xlsx_with_children.json");
		expect(r.children).toHaveLength(1);
	});

	it("child_should_have_correct_path_and_mime_type", () => {
		const r = load("extraction_result_xlsx_with_children.json");
		const child = r.children?.[0];
		expect(child?.path).toBe("xl/embeddings/Doc1.docx");
		expect(child?.mime_type).toBe("application/vnd.openxmlformats-officedocument.wordprocessingml.document");
	});

	it("child_carries_nested_ExtractionResult_with_content", () => {
		const r = load("extraction_result_xlsx_with_children.json");
		const nested = r.children?.[0]?.result;
		expect(nested?.content).toBeTruthy();
		expect(nested?.tables).toEqual([]);
	});

	it("should_have_three_tables_across_sheets", () => {
		const r = load("extraction_result_xlsx_with_children.json");
		expect(r.tables).toHaveLength(3);
		expect(r.tables[0]?.cells[0]).toEqual(["Department", "Budget", "Actual"]);
	});
});

// ---------------------------------------------------------------------------
// DOCX with revisions fixture
// ---------------------------------------------------------------------------

describe("DOCX ExtractionResult with revisions", () => {
	it("should_have_three_revisions", () => {
		const r = load("extraction_result_docx_with_revisions.json");
		expect(r.revisions).toHaveLength(3);
	});

	it("first_revision_is_insertion_by_alice", () => {
		const r = load("extraction_result_docx_with_revisions.json");
		const rev = r.revisions?.[0];
		expect(rev?.kind).toBe("insertion");
		expect(rev?.author).toBe("Alice");
		expect(rev?.revision_id).toBe("42");
		expect(rev?.timestamp).toBe("2024-03-15T10:30:00Z");
	});

	it("revisions_cover_insertion_deletion_and_comment_kinds", () => {
		const r = load("extraction_result_docx_with_revisions.json");
		const kinds = new Set(r.revisions?.map((rev) => rev.kind));
		expect(kinds).toEqual(new Set(["insertion", "deletion", "comment"]));
	});

	it("should_have_two_extracted_keywords", () => {
		const r = load("extraction_result_docx_with_revisions.json");
		expect(r.extracted_keywords).toHaveLength(2);
	});

	it("first_keyword_has_yake_algorithm_and_positive_score", () => {
		const r = load("extraction_result_docx_with_revisions.json");
		const kw = r.extracted_keywords?.[0];
		expect(kw?.algorithm).toBe("yake");
		expect(kw?.score).toBeGreaterThan(0);
		expect(kw?.text).toBe("project timeline");
	});

	it("keyword_positions_are_integer_arrays", () => {
		const r = load("extraction_result_docx_with_revisions.json");
		const kw = r.extracted_keywords?.[0];
		expect(kw?.positions).toEqual([4, 30]);
	});
});

// ---------------------------------------------------------------------------
// URI fixture
// ---------------------------------------------------------------------------

describe("ExtractionResult with URIs", () => {
	it("should_have_three_uris", () => {
		const r = load("extraction_result_with_uris.json");
		expect(r.uris).toHaveLength(3);
	});

	it("all_uris_have_non_empty_url", () => {
		const r = load("extraction_result_with_uris.json");
		const urls = r.uris?.map((u) => u.url) ?? [];
		expect(urls.every((url) => url.length > 0)).toBe(true);
	});

	it("uri_kinds_and_labels_match_fixture_values", () => {
		const r = load("extraction_result_with_uris.json");
		const uris = r.uris ?? [];
		expect(uris[0]?.kind).toBe("hyperlink");
		expect(uris[0]?.url).toBe("https://docs.example.com");
		expect(uris[0]?.label).toBe("official documentation");
		expect(uris[1]?.kind).toBe("email");
		expect(uris[2]?.kind).toBe("anchor");
	});

	it("all_uris_are_on_page_1", () => {
		const r = load("extraction_result_with_uris.json");
		const pages = r.uris?.map((u) => u.page) ?? [];
		expect(pages.every((p) => p === 1)).toBe(true);
	});
});
