"""Deserialization tests that lock in the ExtractionResult wire shape.

Each test loads a JSON fixture from spec/fixtures/, deserializes it through
the generated client models, and asserts on exact field values. A regression
in the generated code or the spec will make these tests fail before any
runtime behaviour breaks.
"""

from __future__ import annotations

import json
from pathlib import Path

import pytest

from kreuzberg_cloud._generated.models.extraction_result import ExtractionResult

FIXTURES = Path(__file__).resolve().parents[3] / "spec" / "fixtures"


def load(name: str) -> dict:  # type: ignore[type-arg]
    return json.loads((FIXTURES / name).read_text())


# ---------------------------------------------------------------------------
# Smoke: all fixtures must deserialize without error
# ---------------------------------------------------------------------------


@pytest.mark.parametrize(
    "fixture",
    [
        "extraction_result_minimal.json",
        "extraction_result_pdf.json",
        "extraction_result_xlsx_with_children.json",
        "extraction_result_docx_with_revisions.json",
        "extraction_result_with_uris.json",
    ],
)
def test_all_fixtures_deserialize_without_error(fixture: str) -> None:
    raw = load(fixture)
    ExtractionResult.from_dict(raw)


# ---------------------------------------------------------------------------
# Minimal fixture
# ---------------------------------------------------------------------------


def test_minimal_extraction_result_content_and_mime_type() -> None:
    raw = load("extraction_result_minimal.json")
    result = ExtractionResult.from_dict(raw)
    assert result.content == "Hello"
    assert result.mime_type == "text/plain"


def test_minimal_extraction_result_empty_tables() -> None:
    raw = load("extraction_result_minimal.json")
    result = ExtractionResult.from_dict(raw)
    assert result.tables == []


# ---------------------------------------------------------------------------
# PDF fixture
# ---------------------------------------------------------------------------


def test_pdf_authors_are_present() -> None:
    raw = load("extraction_result_pdf.json")
    result = ExtractionResult.from_dict(raw)
    assert result.metadata.authors == ["Alice Müller", "Bob Chen"]


def test_pdf_quality_score_value() -> None:
    raw = load("extraction_result_pdf.json")
    result = ExtractionResult.from_dict(raw)
    assert result.quality_score == pytest.approx(0.91)


def test_table_cells_are_nested_arrays() -> None:
    raw = load("extraction_result_pdf.json")
    result = ExtractionResult.from_dict(raw)
    assert len(result.tables) == 1
    assert result.tables[0].cells == [["Header A", "Header B"], ["Row 1A", "Row 1B"]]


def test_table_page_number_and_markdown_present() -> None:
    raw = load("extraction_result_pdf.json")
    result = ExtractionResult.from_dict(raw)
    table = result.tables[0]
    assert table.page_number == 1
    assert "Header A" in table.markdown


def test_pdf_format_metadata_is_deserialized() -> None:
    # The Python generator tries ExcelMetadata first (all-optional fields);
    # it wins over OcrMetadata. The important thing is that format_ is not None
    # and not UNSET — the discriminator value is preserved in additional_properties.
    from kreuzberg_cloud._generated.types import UNSET

    raw = load("extraction_result_pdf.json")
    result = ExtractionResult.from_dict(raw)
    assert result.metadata.format_ is not None
    assert result.metadata.format_ is not UNSET
    # The format_type discriminator field leaks into additional_properties
    assert result.metadata.format_["format_type"] == "ocr"  # type: ignore[index]


def test_pdf_pages_are_deserialized() -> None:
    raw = load("extraction_result_pdf.json")
    result = ExtractionResult.from_dict(raw)
    assert result.pages is not None
    assert len(result.pages) == 3
    assert result.pages[0].page_number == 1


# ---------------------------------------------------------------------------
# XLSX with children fixture
# ---------------------------------------------------------------------------


def test_xlsx_children_count() -> None:
    raw = load("extraction_result_xlsx_with_children.json")
    result = ExtractionResult.from_dict(raw)
    assert result.children is not None
    assert len(result.children) == 1


def test_xlsx_child_path_and_mime_type() -> None:
    raw = load("extraction_result_xlsx_with_children.json")
    result = ExtractionResult.from_dict(raw)
    child = result.children[0]  # type: ignore[index]
    assert child.path == "xl/embeddings/Doc1.docx"
    assert child.mime_type == "application/vnd.openxmlformats-officedocument.wordprocessingml.document"


def test_xlsx_child_carries_nested_extraction_result() -> None:
    raw = load("extraction_result_xlsx_with_children.json")
    result = ExtractionResult.from_dict(raw)
    nested = result.children[0].result  # type: ignore[index]
    assert nested.content  # non-empty
    assert nested.tables == []


def test_xlsx_tables_across_sheets() -> None:
    raw = load("extraction_result_xlsx_with_children.json")
    result = ExtractionResult.from_dict(raw)
    assert len(result.tables) == 3
    assert result.tables[0].cells[0] == ["Department", "Budget", "Actual"]


def test_xlsx_format_metadata_sheet_count() -> None:

    raw = load("extraction_result_xlsx_with_children.json")
    result = ExtractionResult.from_dict(raw)
    from kreuzberg_cloud._generated.models.excel_metadata import ExcelMetadata

    assert isinstance(result.metadata.format_, ExcelMetadata)
    assert result.metadata.format_.sheet_count == 3
    assert result.metadata.format_.sheet_names == ["Q1", "Q2", "Q3"]


# ---------------------------------------------------------------------------
# DOCX with revisions fixture
# ---------------------------------------------------------------------------


def test_docx_revisions_count() -> None:
    raw = load("extraction_result_docx_with_revisions.json")
    result = ExtractionResult.from_dict(raw)
    assert result.revisions is not None
    assert len(result.revisions) == 3


def test_docx_revision_insertion_fields() -> None:
    raw = load("extraction_result_docx_with_revisions.json")
    result = ExtractionResult.from_dict(raw)
    rev = result.revisions[0]  # type: ignore[index]
    assert rev.kind == "insertion"
    assert rev.author == "Alice"
    assert rev.revision_id == "42"
    assert rev.timestamp == "2024-03-15T10:30:00Z"


def test_docx_revision_kinds_are_all_present() -> None:
    raw = load("extraction_result_docx_with_revisions.json")
    result = ExtractionResult.from_dict(raw)
    kinds = {r.kind for r in result.revisions}  # type: ignore[union-attr]
    assert kinds == {"insertion", "deletion", "comment"}


def test_docx_extracted_keywords_count_and_values() -> None:
    raw = load("extraction_result_docx_with_revisions.json")
    result = ExtractionResult.from_dict(raw)
    assert result.extracted_keywords is not None
    assert len(result.extracted_keywords) >= 2


def test_docx_keyword_score_and_algorithm() -> None:
    raw = load("extraction_result_docx_with_revisions.json")
    result = ExtractionResult.from_dict(raw)
    kw = result.extracted_keywords[0]  # type: ignore[index]
    assert kw.score > 0
    assert kw.algorithm == "yake"
    assert kw.text == "project timeline"


def test_docx_keyword_positions() -> None:
    raw = load("extraction_result_docx_with_revisions.json")
    result = ExtractionResult.from_dict(raw)
    kw = result.extracted_keywords[0]  # type: ignore[index]
    assert kw.positions == [4, 30]


# ---------------------------------------------------------------------------
# URI fixture
# ---------------------------------------------------------------------------


def test_uris_count() -> None:
    raw = load("extraction_result_with_uris.json")
    result = ExtractionResult.from_dict(raw)
    assert result.uris is not None
    assert len(result.uris) == 3


def test_all_uris_have_non_empty_url() -> None:
    raw = load("extraction_result_with_uris.json")
    result = ExtractionResult.from_dict(raw)
    assert all(u.url for u in result.uris)  # type: ignore[union-attr]


def test_uri_kinds_and_labels() -> None:
    raw = load("extraction_result_with_uris.json")
    result = ExtractionResult.from_dict(raw)
    uris = result.uris  # type: ignore[union-attr]
    assert uris[0].kind == "hyperlink"
    assert uris[0].url == "https://docs.example.com"
    assert uris[0].label == "official documentation"
    assert uris[1].kind == "email"
    assert uris[2].kind == "anchor"


def test_uri_page_number() -> None:
    raw = load("extraction_result_with_uris.json")
    result = ExtractionResult.from_dict(raw)
    assert all(u.page == 1 for u in result.uris)  # type: ignore[union-attr]
