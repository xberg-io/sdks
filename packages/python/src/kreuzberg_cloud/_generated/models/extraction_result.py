from __future__ import annotations

from collections.abc import Mapping
from typing import TYPE_CHECKING, Any, TypeVar, cast

from attrs import define as _attrs_define
from attrs import field as _attrs_field
from typing_extensions import Self

from ..models.extraction_method import ExtractionMethod, check_extraction_method
from ..types import UNSET, Unset

if TYPE_CHECKING:
    from ..models.archive_entry import ArchiveEntry
    from ..models.chunk import Chunk
    from ..models.djot_content import DjotContent
    from ..models.document_revision import DocumentRevision
    from ..models.document_structure import DocumentStructure
    from ..models.element import Element
    from ..models.extracted_image import ExtractedImage
    from ..models.extracted_uri import ExtractedUri
    from ..models.keyword import Keyword
    from ..models.llm_usage import LlmUsage
    from ..models.metadata import Metadata
    from ..models.ocr_element import OcrElement
    from ..models.page_content import PageContent
    from ..models.pdf_annotation import PdfAnnotation
    from ..models.processing_warning import ProcessingWarning
    from ..models.table import Table


T = TypeVar("T", bound="ExtractionResult")


@_attrs_define
class ExtractionResult:
    """General extraction result used by the core extraction API.

    This is the main result type returned by all extraction functions.

    Attributes:
            content (str):
            metadata (Metadata): Extraction result metadata.

                Contains common fields applicable to all formats, format-specific metadata
                via a discriminated union, and additional custom fields from postprocessors.
            mime_type (str):
            tables (list[Table]):
            annotations (list[PdfAnnotation] | None | Unset): PDF annotations extracted from the document.

                When annotation extraction is enabled via `PdfConfig::extract_annotations`,
                this field contains text notes, highlights, links, stamps, and other
                annotations found in PDF documents.
            children (list[ArchiveEntry] | None | Unset): Nested extraction results from archive contents.

                When extracting archives, each processable file inside produces its own
                full extraction result. Set to `None` for non-archive formats.
                Use `max_archive_depth` in config to control recursion depth.
            chunks (list[Chunk] | None | Unset): Text chunks when chunking is enabled.

                When chunking configuration is provided, the content is split into
                overlapping chunks for efficient processing. Each chunk contains the text,
                optional embeddings (if enabled), and metadata about its position.
            detected_languages (list[str] | None | Unset):
            djot_content (DjotContent | None | Unset):
            document (DocumentStructure | None | Unset):
            elements (list[Element] | None | Unset): Semantic elements when element-based result format is enabled.

                When result_format is set to ElementBased, this field contains semantic
                elements with type classification, unique identifiers, and metadata for
                Unstructured-compatible element-based processing.
            extracted_keywords (list[Keyword] | None | Unset): Extracted keywords when keyword extraction is enabled.

                When keyword extraction (RAKE or YAKE) is configured, this field contains
                the extracted keywords with scores, algorithm info, and position data.
                Previously stored in `metadata.additional["keywords"]`.
            extraction_method (ExtractionMethod | None | Unset):
            images (list[ExtractedImage] | None | Unset): Extracted images from the document.

                When image extraction is enabled via `ImageExtractionConfig`, this field
                contains all images found in the document with their raw data and metadata.
                Each image may optionally contain a nested `ocr_result` if OCR was performed.
            llm_usage (list[LlmUsage] | None | Unset): LLM token usage and cost data for all LLM calls made during this
                extraction.

                Contains one entry per LLM call. Multiple entries are produced when
                VLM OCR, structured extraction, or LLM embeddings run during
                the same extraction.

                `None` when no LLM was used.
            ocr_elements (list[OcrElement] | None | Unset): OCR elements with full spatial and confidence metadata.

                When OCR is performed with element extraction enabled, this field contains
                the structured representation of detected text including:
                - Bounding geometry (rectangles or quadrilaterals)
                - Confidence scores (detection and recognition)
                - Rotation information
                - Hierarchical relationships (Tesseract only)

                This field preserves all metadata that would otherwise be lost when
                converting to plain text or markdown output formats.

                Only populated when `OcrElementConfig.include_elements` is true.
            pages (list[PageContent] | None | Unset): Per-page content when page extraction is enabled.

                When page extraction is configured, the document is split into per-page content
                with tables and images mapped to their respective pages.
            processing_warnings (list[ProcessingWarning] | Unset): Non-fatal warnings collected during processing pipeline
                stages.

                Captures errors from optional pipeline features (embedding, chunking,
                language detection, output formatting) that don't prevent extraction
                but may indicate degraded results.
                Previously stored as individual keys in `metadata.additional`.
            quality_score (float | None | Unset): Document quality score from quality analysis.

                A value between 0.0 and 1.0 indicating the overall text quality.
                Previously stored in `metadata.additional["quality_score"]`.
            revisions (list[DocumentRevision] | None | Unset): Tracked changes embedded in the source document.

                Populated by per-format extractors that understand change-tracking
                metadata (DOCX `w:ins`/`w:del`/`w:rPrChange`, ODT `text:change-*`,
                …). Every extractor defaults to `None` until its format-specific
                implementation is added. Extractors that do populate this field follow
                the "accepted-changes" convention: inserted text is present in
                `content`, deleted text is absent — the revision list is the separate
                audit trail.
            structured_output (Any | Unset): Structured extraction output from LLM-based JSON schema extraction.

                When `structured_extraction` is configured in `ExtractionConfig`, the
                extracted document content is sent to a VLM with the provided JSON schema.
                The response is parsed and stored here as a JSON value matching the schema.
            uris (list[ExtractedUri] | None | Unset): URIs/links discovered during document extraction.

                Contains hyperlinks, image references, citations, email addresses, and
                other URI-like references found in the document. Always extracted when
                present in the source document.
    """

    content: str
    metadata: Metadata
    mime_type: str
    tables: list[Table]
    annotations: list[PdfAnnotation] | None | Unset = UNSET
    children: list[ArchiveEntry] | None | Unset = UNSET
    chunks: list[Chunk] | None | Unset = UNSET
    detected_languages: list[str] | None | Unset = UNSET
    djot_content: DjotContent | None | Unset = UNSET
    document: DocumentStructure | None | Unset = UNSET
    elements: list[Element] | None | Unset = UNSET
    extracted_keywords: list[Keyword] | None | Unset = UNSET
    extraction_method: ExtractionMethod | None | Unset = UNSET
    images: list[ExtractedImage] | None | Unset = UNSET
    llm_usage: list[LlmUsage] | None | Unset = UNSET
    ocr_elements: list[OcrElement] | None | Unset = UNSET
    pages: list[PageContent] | None | Unset = UNSET
    processing_warnings: list[ProcessingWarning] | Unset = UNSET
    quality_score: float | None | Unset = UNSET
    revisions: list[DocumentRevision] | None | Unset = UNSET
    structured_output: Any | Unset = UNSET
    uris: list[ExtractedUri] | None | Unset = UNSET
    additional_properties: dict[str, Any] = _attrs_field(init=False, factory=dict)

    def to_dict(self) -> dict[str, Any]:
        from ..models.djot_content import DjotContent
        from ..models.document_structure import DocumentStructure

        content = self.content

        metadata = self.metadata.to_dict()

        mime_type = self.mime_type

        tables = []
        for tables_item_data in self.tables:
            tables_item = tables_item_data.to_dict()
            tables.append(tables_item)

        annotations: list[dict[str, Any]] | None | Unset
        if isinstance(self.annotations, Unset):
            annotations = UNSET
        elif isinstance(self.annotations, list):
            annotations = []
            for annotations_type_0_item_data in self.annotations:
                annotations_type_0_item = annotations_type_0_item_data.to_dict()
                annotations.append(annotations_type_0_item)

        else:
            annotations = self.annotations

        children: list[dict[str, Any]] | None | Unset
        if isinstance(self.children, Unset):
            children = UNSET
        elif isinstance(self.children, list):
            children = []
            for children_type_0_item_data in self.children:
                children_type_0_item = children_type_0_item_data.to_dict()
                children.append(children_type_0_item)

        else:
            children = self.children

        chunks: list[dict[str, Any]] | None | Unset
        if isinstance(self.chunks, Unset):
            chunks = UNSET
        elif isinstance(self.chunks, list):
            chunks = []
            for chunks_type_0_item_data in self.chunks:
                chunks_type_0_item = chunks_type_0_item_data.to_dict()
                chunks.append(chunks_type_0_item)

        else:
            chunks = self.chunks

        detected_languages: list[str] | None | Unset
        if isinstance(self.detected_languages, Unset):
            detected_languages = UNSET
        elif isinstance(self.detected_languages, list):
            detected_languages = self.detected_languages

        else:
            detected_languages = self.detected_languages

        djot_content: dict[str, Any] | None | Unset
        if isinstance(self.djot_content, Unset):
            djot_content = UNSET
        elif isinstance(self.djot_content, DjotContent):
            djot_content = self.djot_content.to_dict()
        else:
            djot_content = self.djot_content

        document: dict[str, Any] | None | Unset
        if isinstance(self.document, Unset):
            document = UNSET
        elif isinstance(self.document, DocumentStructure):
            document = self.document.to_dict()
        else:
            document = self.document

        elements: list[dict[str, Any]] | None | Unset
        if isinstance(self.elements, Unset):
            elements = UNSET
        elif isinstance(self.elements, list):
            elements = []
            for elements_type_0_item_data in self.elements:
                elements_type_0_item = elements_type_0_item_data.to_dict()
                elements.append(elements_type_0_item)

        else:
            elements = self.elements

        extracted_keywords: list[dict[str, Any]] | None | Unset
        if isinstance(self.extracted_keywords, Unset):
            extracted_keywords = UNSET
        elif isinstance(self.extracted_keywords, list):
            extracted_keywords = []
            for extracted_keywords_type_0_item_data in self.extracted_keywords:
                extracted_keywords_type_0_item = extracted_keywords_type_0_item_data.to_dict()
                extracted_keywords.append(extracted_keywords_type_0_item)

        else:
            extracted_keywords = self.extracted_keywords

        extraction_method: None | str | Unset
        if isinstance(self.extraction_method, Unset):
            extraction_method = UNSET
        elif isinstance(self.extraction_method, str):
            extraction_method = self.extraction_method
        else:
            extraction_method = self.extraction_method

        images: list[dict[str, Any]] | None | Unset
        if isinstance(self.images, Unset):
            images = UNSET
        elif isinstance(self.images, list):
            images = []
            for images_type_0_item_data in self.images:
                images_type_0_item = images_type_0_item_data.to_dict()
                images.append(images_type_0_item)

        else:
            images = self.images

        llm_usage: list[dict[str, Any]] | None | Unset
        if isinstance(self.llm_usage, Unset):
            llm_usage = UNSET
        elif isinstance(self.llm_usage, list):
            llm_usage = []
            for llm_usage_type_0_item_data in self.llm_usage:
                llm_usage_type_0_item = llm_usage_type_0_item_data.to_dict()
                llm_usage.append(llm_usage_type_0_item)

        else:
            llm_usage = self.llm_usage

        ocr_elements: list[dict[str, Any]] | None | Unset
        if isinstance(self.ocr_elements, Unset):
            ocr_elements = UNSET
        elif isinstance(self.ocr_elements, list):
            ocr_elements = []
            for ocr_elements_type_0_item_data in self.ocr_elements:
                ocr_elements_type_0_item = ocr_elements_type_0_item_data.to_dict()
                ocr_elements.append(ocr_elements_type_0_item)

        else:
            ocr_elements = self.ocr_elements

        pages: list[dict[str, Any]] | None | Unset
        if isinstance(self.pages, Unset):
            pages = UNSET
        elif isinstance(self.pages, list):
            pages = []
            for pages_type_0_item_data in self.pages:
                pages_type_0_item = pages_type_0_item_data.to_dict()
                pages.append(pages_type_0_item)

        else:
            pages = self.pages

        processing_warnings: list[dict[str, Any]] | Unset = UNSET
        if not isinstance(self.processing_warnings, Unset):
            processing_warnings = []
            for processing_warnings_item_data in self.processing_warnings:
                processing_warnings_item = processing_warnings_item_data.to_dict()
                processing_warnings.append(processing_warnings_item)

        quality_score: float | None | Unset
        if isinstance(self.quality_score, Unset):
            quality_score = UNSET
        else:
            quality_score = self.quality_score

        revisions: list[dict[str, Any]] | None | Unset
        if isinstance(self.revisions, Unset):
            revisions = UNSET
        elif isinstance(self.revisions, list):
            revisions = []
            for revisions_type_0_item_data in self.revisions:
                revisions_type_0_item = revisions_type_0_item_data.to_dict()
                revisions.append(revisions_type_0_item)

        else:
            revisions = self.revisions

        structured_output = self.structured_output

        uris: list[dict[str, Any]] | None | Unset
        if isinstance(self.uris, Unset):
            uris = UNSET
        elif isinstance(self.uris, list):
            uris = []
            for uris_type_0_item_data in self.uris:
                uris_type_0_item = uris_type_0_item_data.to_dict()
                uris.append(uris_type_0_item)

        else:
            uris = self.uris

        field_dict: dict[str, Any] = {}
        field_dict.update(self.additional_properties)
        field_dict.update(
            {
                "content": content,
                "metadata": metadata,
                "mime_type": mime_type,
                "tables": tables,
            }
        )
        if annotations is not UNSET:
            field_dict["annotations"] = annotations
        if children is not UNSET:
            field_dict["children"] = children
        if chunks is not UNSET:
            field_dict["chunks"] = chunks
        if detected_languages is not UNSET:
            field_dict["detected_languages"] = detected_languages
        if djot_content is not UNSET:
            field_dict["djot_content"] = djot_content
        if document is not UNSET:
            field_dict["document"] = document
        if elements is not UNSET:
            field_dict["elements"] = elements
        if extracted_keywords is not UNSET:
            field_dict["extracted_keywords"] = extracted_keywords
        if extraction_method is not UNSET:
            field_dict["extraction_method"] = extraction_method
        if images is not UNSET:
            field_dict["images"] = images
        if llm_usage is not UNSET:
            field_dict["llm_usage"] = llm_usage
        if ocr_elements is not UNSET:
            field_dict["ocr_elements"] = ocr_elements
        if pages is not UNSET:
            field_dict["pages"] = pages
        if processing_warnings is not UNSET:
            field_dict["processing_warnings"] = processing_warnings
        if quality_score is not UNSET:
            field_dict["quality_score"] = quality_score
        if revisions is not UNSET:
            field_dict["revisions"] = revisions
        if structured_output is not UNSET:
            field_dict["structured_output"] = structured_output
        if uris is not UNSET:
            field_dict["uris"] = uris

        return field_dict

    @classmethod
    def from_dict(cls, src_dict: Mapping[str, Any]) -> Self:
        from ..models.archive_entry import ArchiveEntry
        from ..models.chunk import Chunk
        from ..models.djot_content import DjotContent
        from ..models.document_revision import DocumentRevision
        from ..models.document_structure import DocumentStructure
        from ..models.element import Element
        from ..models.extracted_image import ExtractedImage
        from ..models.extracted_uri import ExtractedUri
        from ..models.keyword import Keyword
        from ..models.llm_usage import LlmUsage
        from ..models.metadata import Metadata
        from ..models.ocr_element import OcrElement
        from ..models.page_content import PageContent
        from ..models.pdf_annotation import PdfAnnotation
        from ..models.processing_warning import ProcessingWarning
        from ..models.table import Table

        d = dict(src_dict)
        content = d.pop("content")

        metadata = Metadata.from_dict(d.pop("metadata"))

        mime_type = d.pop("mime_type")

        tables = []
        _tables = d.pop("tables")
        for tables_item_data in _tables:
            tables_item = Table.from_dict(tables_item_data)

            tables.append(tables_item)

        def _parse_annotations(data: object) -> list[PdfAnnotation] | None | Unset:
            if data is None:
                return data
            if isinstance(data, Unset):
                return data
            try:
                if not isinstance(data, list):
                    raise TypeError
                annotations_type_0 = []
                _annotations_type_0 = data
                for annotations_type_0_item_data in _annotations_type_0:
                    annotations_type_0_item = PdfAnnotation.from_dict(annotations_type_0_item_data)

                    annotations_type_0.append(annotations_type_0_item)

                return annotations_type_0
            except (TypeError, ValueError, AttributeError, KeyError):
                pass
            return cast("list[PdfAnnotation] | None | Unset", data)

        annotations = _parse_annotations(d.pop("annotations", UNSET))

        def _parse_children(data: object) -> list[ArchiveEntry] | None | Unset:
            if data is None:
                return data
            if isinstance(data, Unset):
                return data
            try:
                if not isinstance(data, list):
                    raise TypeError
                children_type_0 = []
                _children_type_0 = data
                for children_type_0_item_data in _children_type_0:
                    children_type_0_item = ArchiveEntry.from_dict(children_type_0_item_data)

                    children_type_0.append(children_type_0_item)

                return children_type_0
            except (TypeError, ValueError, AttributeError, KeyError):
                pass
            return cast("list[ArchiveEntry] | None | Unset", data)

        children = _parse_children(d.pop("children", UNSET))

        def _parse_chunks(data: object) -> list[Chunk] | None | Unset:
            if data is None:
                return data
            if isinstance(data, Unset):
                return data
            try:
                if not isinstance(data, list):
                    raise TypeError
                chunks_type_0 = []
                _chunks_type_0 = data
                for chunks_type_0_item_data in _chunks_type_0:
                    chunks_type_0_item = Chunk.from_dict(chunks_type_0_item_data)

                    chunks_type_0.append(chunks_type_0_item)

                return chunks_type_0
            except (TypeError, ValueError, AttributeError, KeyError):
                pass
            return cast("list[Chunk] | None | Unset", data)

        chunks = _parse_chunks(d.pop("chunks", UNSET))

        def _parse_detected_languages(data: object) -> list[str] | None | Unset:
            if data is None:
                return data
            if isinstance(data, Unset):
                return data
            try:
                if not isinstance(data, list):
                    raise TypeError
                detected_languages_type_0 = cast("list[str]", data)

                return detected_languages_type_0
            except (TypeError, ValueError, AttributeError, KeyError):
                pass
            return cast("list[str] | None | Unset", data)

        detected_languages = _parse_detected_languages(d.pop("detected_languages", UNSET))

        def _parse_djot_content(data: object) -> DjotContent | None | Unset:
            if data is None:
                return data
            if isinstance(data, Unset):
                return data
            try:
                if not isinstance(data, dict):
                    raise TypeError
                djot_content_type_1 = DjotContent.from_dict(data)

                return djot_content_type_1
            except (TypeError, ValueError, AttributeError, KeyError):
                pass
            return cast("DjotContent | None | Unset", data)

        djot_content = _parse_djot_content(d.pop("djot_content", UNSET))

        def _parse_document(data: object) -> DocumentStructure | None | Unset:
            if data is None:
                return data
            if isinstance(data, Unset):
                return data
            try:
                if not isinstance(data, dict):
                    raise TypeError
                document_type_1 = DocumentStructure.from_dict(data)

                return document_type_1
            except (TypeError, ValueError, AttributeError, KeyError):
                pass
            return cast("DocumentStructure | None | Unset", data)

        document = _parse_document(d.pop("document", UNSET))

        def _parse_elements(data: object) -> list[Element] | None | Unset:
            if data is None:
                return data
            if isinstance(data, Unset):
                return data
            try:
                if not isinstance(data, list):
                    raise TypeError
                elements_type_0 = []
                _elements_type_0 = data
                for elements_type_0_item_data in _elements_type_0:
                    elements_type_0_item = Element.from_dict(elements_type_0_item_data)

                    elements_type_0.append(elements_type_0_item)

                return elements_type_0
            except (TypeError, ValueError, AttributeError, KeyError):
                pass
            return cast("list[Element] | None | Unset", data)

        elements = _parse_elements(d.pop("elements", UNSET))

        def _parse_extracted_keywords(data: object) -> list[Keyword] | None | Unset:
            if data is None:
                return data
            if isinstance(data, Unset):
                return data
            try:
                if not isinstance(data, list):
                    raise TypeError
                extracted_keywords_type_0 = []
                _extracted_keywords_type_0 = data
                for extracted_keywords_type_0_item_data in _extracted_keywords_type_0:
                    extracted_keywords_type_0_item = Keyword.from_dict(extracted_keywords_type_0_item_data)

                    extracted_keywords_type_0.append(extracted_keywords_type_0_item)

                return extracted_keywords_type_0
            except (TypeError, ValueError, AttributeError, KeyError):
                pass
            return cast("list[Keyword] | None | Unset", data)

        extracted_keywords = _parse_extracted_keywords(d.pop("extracted_keywords", UNSET))

        def _parse_extraction_method(data: object) -> ExtractionMethod | None | Unset:
            if data is None:
                return data
            if isinstance(data, Unset):
                return data
            try:
                if not isinstance(data, str):
                    raise TypeError
                extraction_method_type_1 = check_extraction_method(data)

                return extraction_method_type_1
            except (TypeError, ValueError, AttributeError, KeyError):
                pass
            return cast("ExtractionMethod | None | Unset", data)

        extraction_method = _parse_extraction_method(d.pop("extraction_method", UNSET))

        def _parse_images(data: object) -> list[ExtractedImage] | None | Unset:
            if data is None:
                return data
            if isinstance(data, Unset):
                return data
            try:
                if not isinstance(data, list):
                    raise TypeError
                images_type_0 = []
                _images_type_0 = data
                for images_type_0_item_data in _images_type_0:
                    images_type_0_item = ExtractedImage.from_dict(images_type_0_item_data)

                    images_type_0.append(images_type_0_item)

                return images_type_0
            except (TypeError, ValueError, AttributeError, KeyError):
                pass
            return cast("list[ExtractedImage] | None | Unset", data)

        images = _parse_images(d.pop("images", UNSET))

        def _parse_llm_usage(data: object) -> list[LlmUsage] | None | Unset:
            if data is None:
                return data
            if isinstance(data, Unset):
                return data
            try:
                if not isinstance(data, list):
                    raise TypeError
                llm_usage_type_0 = []
                _llm_usage_type_0 = data
                for llm_usage_type_0_item_data in _llm_usage_type_0:
                    llm_usage_type_0_item = LlmUsage.from_dict(llm_usage_type_0_item_data)

                    llm_usage_type_0.append(llm_usage_type_0_item)

                return llm_usage_type_0
            except (TypeError, ValueError, AttributeError, KeyError):
                pass
            return cast("list[LlmUsage] | None | Unset", data)

        llm_usage = _parse_llm_usage(d.pop("llm_usage", UNSET))

        def _parse_ocr_elements(data: object) -> list[OcrElement] | None | Unset:
            if data is None:
                return data
            if isinstance(data, Unset):
                return data
            try:
                if not isinstance(data, list):
                    raise TypeError
                ocr_elements_type_0 = []
                _ocr_elements_type_0 = data
                for ocr_elements_type_0_item_data in _ocr_elements_type_0:
                    ocr_elements_type_0_item = OcrElement.from_dict(ocr_elements_type_0_item_data)

                    ocr_elements_type_0.append(ocr_elements_type_0_item)

                return ocr_elements_type_0
            except (TypeError, ValueError, AttributeError, KeyError):
                pass
            return cast("list[OcrElement] | None | Unset", data)

        ocr_elements = _parse_ocr_elements(d.pop("ocr_elements", UNSET))

        def _parse_pages(data: object) -> list[PageContent] | None | Unset:
            if data is None:
                return data
            if isinstance(data, Unset):
                return data
            try:
                if not isinstance(data, list):
                    raise TypeError
                pages_type_0 = []
                _pages_type_0 = data
                for pages_type_0_item_data in _pages_type_0:
                    pages_type_0_item = PageContent.from_dict(pages_type_0_item_data)

                    pages_type_0.append(pages_type_0_item)

                return pages_type_0
            except (TypeError, ValueError, AttributeError, KeyError):
                pass
            return cast("list[PageContent] | None | Unset", data)

        pages = _parse_pages(d.pop("pages", UNSET))

        _processing_warnings = d.pop("processing_warnings", UNSET)
        processing_warnings: list[ProcessingWarning] | Unset = UNSET
        if _processing_warnings is not UNSET:
            processing_warnings = []
            for processing_warnings_item_data in _processing_warnings:
                processing_warnings_item = ProcessingWarning.from_dict(processing_warnings_item_data)

                processing_warnings.append(processing_warnings_item)

        def _parse_quality_score(data: object) -> float | None | Unset:
            if data is None:
                return data
            if isinstance(data, Unset):
                return data
            return cast("float | None | Unset", data)

        quality_score = _parse_quality_score(d.pop("quality_score", UNSET))

        def _parse_revisions(data: object) -> list[DocumentRevision] | None | Unset:
            if data is None:
                return data
            if isinstance(data, Unset):
                return data
            try:
                if not isinstance(data, list):
                    raise TypeError
                revisions_type_0 = []
                _revisions_type_0 = data
                for revisions_type_0_item_data in _revisions_type_0:
                    revisions_type_0_item = DocumentRevision.from_dict(revisions_type_0_item_data)

                    revisions_type_0.append(revisions_type_0_item)

                return revisions_type_0
            except (TypeError, ValueError, AttributeError, KeyError):
                pass
            return cast("list[DocumentRevision] | None | Unset", data)

        revisions = _parse_revisions(d.pop("revisions", UNSET))

        structured_output = d.pop("structured_output", UNSET)

        def _parse_uris(data: object) -> list[ExtractedUri] | None | Unset:
            if data is None:
                return data
            if isinstance(data, Unset):
                return data
            try:
                if not isinstance(data, list):
                    raise TypeError
                uris_type_0 = []
                _uris_type_0 = data
                for uris_type_0_item_data in _uris_type_0:
                    uris_type_0_item = ExtractedUri.from_dict(uris_type_0_item_data)

                    uris_type_0.append(uris_type_0_item)

                return uris_type_0
            except (TypeError, ValueError, AttributeError, KeyError):
                pass
            return cast("list[ExtractedUri] | None | Unset", data)

        uris = _parse_uris(d.pop("uris", UNSET))

        extraction_result = cls(
            content=content,
            metadata=metadata,
            mime_type=mime_type,
            tables=tables,
            annotations=annotations,
            children=children,
            chunks=chunks,
            detected_languages=detected_languages,
            djot_content=djot_content,
            document=document,
            elements=elements,
            extracted_keywords=extracted_keywords,
            extraction_method=extraction_method,
            images=images,
            llm_usage=llm_usage,
            ocr_elements=ocr_elements,
            pages=pages,
            processing_warnings=processing_warnings,
            quality_score=quality_score,
            revisions=revisions,
            structured_output=structured_output,
            uris=uris,
        )

        extraction_result.additional_properties = d
        return extraction_result

    @property
    def additional_keys(self) -> list[str]:
        return list(self.additional_properties.keys())

    def __getitem__(self, key: str) -> Any:
        return self.additional_properties[key]

    def __setitem__(self, key: str, value: Any) -> None:
        self.additional_properties[key] = value

    def __delitem__(self, key: str) -> None:
        del self.additional_properties[key]

    def __contains__(self, key: str) -> bool:
        return key in self.additional_properties
