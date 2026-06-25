from __future__ import annotations

from collections.abc import Mapping
from typing import TYPE_CHECKING, Any, TypeVar, cast

from attrs import define as _attrs_define
from attrs import field as _attrs_field
from typing_extensions import Self

from ..types import UNSET, Unset

if TYPE_CHECKING:
    from ..models.archive_metadata import ArchiveMetadata
    from ..models.csv_metadata import CsvMetadata
    from ..models.email_metadata import EmailMetadata
    from ..models.error_metadata import ErrorMetadata
    from ..models.excel_metadata import ExcelMetadata
    from ..models.html_metadata import HtmlMetadata
    from ..models.image_metadata import ImageMetadata
    from ..models.image_preprocessing_metadata import ImagePreprocessingMetadata
    from ..models.metadata_additional import MetadataAdditional
    from ..models.ocr_metadata import OcrMetadata
    from ..models.page_structure import PageStructure
    from ..models.pptx_metadata import PptxMetadata
    from ..models.pst_metadata import PstMetadata
    from ..models.text_metadata import TextMetadata
    from ..models.xml_metadata import XmlMetadata


T = TypeVar("T", bound="Metadata")


@_attrs_define
class Metadata:
    """Extraction result metadata.

    Contains common fields applicable to all formats, format-specific metadata
    via a discriminated union, and additional custom fields from postprocessors.

    Attributes:
            abstract_text (None | str | Unset): Abstract or summary text (from frontmatter).
            additional (MetadataAdditional | Unset): Additional custom fields from postprocessors.

                Serialized as a nested `"additional"` object (not flattened at root level).
                Uses `Cow<'static, str>` keys so static string keys avoid allocation.
            authors (list[str] | None | Unset): Primary author(s) - always Vec for consistency
            category (None | str | Unset): Document category (from frontmatter or classification).
            created_at (None | str | Unset): Creation timestamp (ISO 8601 format)
            created_by (None | str | Unset): User who created the document
            document_version (None | str | Unset): Document version string (from frontmatter).
            error (ErrorMetadata | None | Unset):
            extraction_duration_ms (int | None | Unset): Extraction duration in milliseconds (for benchmarking).

                This field is populated by batch extraction to provide per-file timing
                information. It's `None` for single-file extraction (which uses external timing).
            format_ (ArchiveMetadata | CsvMetadata | EmailMetadata | ExcelMetadata | HtmlMetadata | ImageMetadata | None |
                OcrMetadata | PptxMetadata | PstMetadata | TextMetadata | Unset | XmlMetadata):
            image_preprocessing (ImagePreprocessingMetadata | None | Unset):
            json_schema (Any | Unset): JSON schema (for structured data extraction)
            keywords (list[str] | None | Unset): Keywords/tags - always Vec for consistency
            language (None | str | Unset): Primary language (ISO 639 code)
            modified_at (None | str | Unset): Last modification timestamp (ISO 8601 format)
            modified_by (None | str | Unset): User who last modified the document
            ocr_used (bool | Unset): Whether OCR was used during extraction.

                Set to `true` whenever the extraction pipeline ran an OCR backend
                (Tesseract, PaddleOCR, VLM, etc.) and used that output as the primary
                or fallback text. `false` means native text extraction was used exclusively.
            output_format (None | str | Unset): Output format identifier (e.g., "markdown", "html", "text").

                Set by the output format pipeline stage when format conversion is applied.
                Previously stored in `metadata.additional["output_format"]`.
            pages (None | PageStructure | Unset):
            subject (None | str | Unset): Document subject or description
            tags (list[str] | None | Unset): Document tags (from frontmatter).
            title (None | str | Unset): Document title
    """

    abstract_text: None | str | Unset = UNSET
    additional: MetadataAdditional | Unset = UNSET
    authors: list[str] | None | Unset = UNSET
    category: None | str | Unset = UNSET
    created_at: None | str | Unset = UNSET
    created_by: None | str | Unset = UNSET
    document_version: None | str | Unset = UNSET
    error: ErrorMetadata | None | Unset = UNSET
    extraction_duration_ms: int | None | Unset = UNSET
    format_: (
        ArchiveMetadata
        | CsvMetadata
        | EmailMetadata
        | ExcelMetadata
        | HtmlMetadata
        | ImageMetadata
        | None
        | OcrMetadata
        | PptxMetadata
        | PstMetadata
        | TextMetadata
        | Unset
        | XmlMetadata
    ) = UNSET
    image_preprocessing: ImagePreprocessingMetadata | None | Unset = UNSET
    json_schema: Any | Unset = UNSET
    keywords: list[str] | None | Unset = UNSET
    language: None | str | Unset = UNSET
    modified_at: None | str | Unset = UNSET
    modified_by: None | str | Unset = UNSET
    ocr_used: bool | Unset = UNSET
    output_format: None | str | Unset = UNSET
    pages: None | PageStructure | Unset = UNSET
    subject: None | str | Unset = UNSET
    tags: list[str] | None | Unset = UNSET
    title: None | str | Unset = UNSET
    additional_properties: dict[str, Any] = _attrs_field(init=False, factory=dict)

    def to_dict(self) -> dict[str, Any]:
        from ..models.archive_metadata import ArchiveMetadata
        from ..models.csv_metadata import CsvMetadata
        from ..models.email_metadata import EmailMetadata
        from ..models.error_metadata import ErrorMetadata
        from ..models.excel_metadata import ExcelMetadata
        from ..models.html_metadata import HtmlMetadata
        from ..models.image_metadata import ImageMetadata
        from ..models.image_preprocessing_metadata import ImagePreprocessingMetadata
        from ..models.ocr_metadata import OcrMetadata
        from ..models.page_structure import PageStructure
        from ..models.pptx_metadata import PptxMetadata
        from ..models.pst_metadata import PstMetadata
        from ..models.text_metadata import TextMetadata
        from ..models.xml_metadata import XmlMetadata

        abstract_text: None | str | Unset
        if isinstance(self.abstract_text, Unset):
            abstract_text = UNSET
        else:
            abstract_text = self.abstract_text

        additional: dict[str, Any] | Unset = UNSET
        if not isinstance(self.additional, Unset):
            additional = self.additional.to_dict()

        authors: list[str] | None | Unset
        if isinstance(self.authors, Unset):
            authors = UNSET
        elif isinstance(self.authors, list):
            authors = self.authors

        else:
            authors = self.authors

        category: None | str | Unset
        if isinstance(self.category, Unset):
            category = UNSET
        else:
            category = self.category

        created_at: None | str | Unset
        if isinstance(self.created_at, Unset):
            created_at = UNSET
        else:
            created_at = self.created_at

        created_by: None | str | Unset
        if isinstance(self.created_by, Unset):
            created_by = UNSET
        else:
            created_by = self.created_by

        document_version: None | str | Unset
        if isinstance(self.document_version, Unset):
            document_version = UNSET
        else:
            document_version = self.document_version

        error: dict[str, Any] | None | Unset
        if isinstance(self.error, Unset):
            error = UNSET
        elif isinstance(self.error, ErrorMetadata):
            error = self.error.to_dict()
        else:
            error = self.error

        extraction_duration_ms: int | None | Unset
        if isinstance(self.extraction_duration_ms, Unset):
            extraction_duration_ms = UNSET
        else:
            extraction_duration_ms = self.extraction_duration_ms

        format_: dict[str, Any] | None | Unset
        if isinstance(self.format_, Unset):
            format_ = UNSET
        elif (
            isinstance(self.format_, ExcelMetadata)
            or isinstance(self.format_, EmailMetadata)
            or isinstance(self.format_, PptxMetadata)
            or isinstance(self.format_, ArchiveMetadata)
            or isinstance(self.format_, ImageMetadata)
            or isinstance(self.format_, XmlMetadata)
            or isinstance(self.format_, TextMetadata)
            or isinstance(self.format_, HtmlMetadata)
            or isinstance(self.format_, OcrMetadata)
            or isinstance(self.format_, CsvMetadata)
            or isinstance(self.format_, PstMetadata)
        ):
            format_ = self.format_.to_dict()
        else:
            format_ = self.format_

        image_preprocessing: dict[str, Any] | None | Unset
        if isinstance(self.image_preprocessing, Unset):
            image_preprocessing = UNSET
        elif isinstance(self.image_preprocessing, ImagePreprocessingMetadata):
            image_preprocessing = self.image_preprocessing.to_dict()
        else:
            image_preprocessing = self.image_preprocessing

        json_schema = self.json_schema

        keywords: list[str] | None | Unset
        if isinstance(self.keywords, Unset):
            keywords = UNSET
        elif isinstance(self.keywords, list):
            keywords = self.keywords

        else:
            keywords = self.keywords

        language: None | str | Unset
        if isinstance(self.language, Unset):
            language = UNSET
        else:
            language = self.language

        modified_at: None | str | Unset
        if isinstance(self.modified_at, Unset):
            modified_at = UNSET
        else:
            modified_at = self.modified_at

        modified_by: None | str | Unset
        if isinstance(self.modified_by, Unset):
            modified_by = UNSET
        else:
            modified_by = self.modified_by

        ocr_used = self.ocr_used

        output_format: None | str | Unset
        if isinstance(self.output_format, Unset):
            output_format = UNSET
        else:
            output_format = self.output_format

        pages: dict[str, Any] | None | Unset
        if isinstance(self.pages, Unset):
            pages = UNSET
        elif isinstance(self.pages, PageStructure):
            pages = self.pages.to_dict()
        else:
            pages = self.pages

        subject: None | str | Unset
        if isinstance(self.subject, Unset):
            subject = UNSET
        else:
            subject = self.subject

        tags: list[str] | None | Unset
        if isinstance(self.tags, Unset):
            tags = UNSET
        elif isinstance(self.tags, list):
            tags = self.tags

        else:
            tags = self.tags

        title: None | str | Unset
        if isinstance(self.title, Unset):
            title = UNSET
        else:
            title = self.title

        field_dict: dict[str, Any] = {}
        field_dict.update(self.additional_properties)
        field_dict.update({})
        if abstract_text is not UNSET:
            field_dict["abstract_text"] = abstract_text
        if additional is not UNSET:
            field_dict["additional"] = additional
        if authors is not UNSET:
            field_dict["authors"] = authors
        if category is not UNSET:
            field_dict["category"] = category
        if created_at is not UNSET:
            field_dict["created_at"] = created_at
        if created_by is not UNSET:
            field_dict["created_by"] = created_by
        if document_version is not UNSET:
            field_dict["document_version"] = document_version
        if error is not UNSET:
            field_dict["error"] = error
        if extraction_duration_ms is not UNSET:
            field_dict["extraction_duration_ms"] = extraction_duration_ms
        if format_ is not UNSET:
            field_dict["format"] = format_
        if image_preprocessing is not UNSET:
            field_dict["image_preprocessing"] = image_preprocessing
        if json_schema is not UNSET:
            field_dict["json_schema"] = json_schema
        if keywords is not UNSET:
            field_dict["keywords"] = keywords
        if language is not UNSET:
            field_dict["language"] = language
        if modified_at is not UNSET:
            field_dict["modified_at"] = modified_at
        if modified_by is not UNSET:
            field_dict["modified_by"] = modified_by
        if ocr_used is not UNSET:
            field_dict["ocr_used"] = ocr_used
        if output_format is not UNSET:
            field_dict["output_format"] = output_format
        if pages is not UNSET:
            field_dict["pages"] = pages
        if subject is not UNSET:
            field_dict["subject"] = subject
        if tags is not UNSET:
            field_dict["tags"] = tags
        if title is not UNSET:
            field_dict["title"] = title

        return field_dict

    @classmethod
    def from_dict(cls, src_dict: Mapping[str, Any]) -> Self:
        from ..models.archive_metadata import ArchiveMetadata
        from ..models.csv_metadata import CsvMetadata
        from ..models.email_metadata import EmailMetadata
        from ..models.error_metadata import ErrorMetadata
        from ..models.excel_metadata import ExcelMetadata
        from ..models.html_metadata import HtmlMetadata
        from ..models.image_metadata import ImageMetadata
        from ..models.image_preprocessing_metadata import ImagePreprocessingMetadata
        from ..models.metadata_additional import MetadataAdditional
        from ..models.ocr_metadata import OcrMetadata
        from ..models.page_structure import PageStructure
        from ..models.pptx_metadata import PptxMetadata
        from ..models.pst_metadata import PstMetadata
        from ..models.text_metadata import TextMetadata
        from ..models.xml_metadata import XmlMetadata

        d = dict(src_dict)

        def _parse_abstract_text(data: object) -> None | str | Unset:
            if data is None:
                return data
            if isinstance(data, Unset):
                return data
            return cast("None | str | Unset", data)

        abstract_text = _parse_abstract_text(d.pop("abstract_text", UNSET))

        _additional = d.pop("additional", UNSET)
        additional: MetadataAdditional | Unset
        if isinstance(_additional, Unset):
            additional = UNSET
        else:
            additional = MetadataAdditional.from_dict(_additional)

        def _parse_authors(data: object) -> list[str] | None | Unset:
            if data is None:
                return data
            if isinstance(data, Unset):
                return data
            try:
                if not isinstance(data, list):
                    raise TypeError
                authors_type_0 = cast("list[str]", data)

                return authors_type_0
            except (TypeError, ValueError, AttributeError, KeyError):
                pass
            return cast("list[str] | None | Unset", data)

        authors = _parse_authors(d.pop("authors", UNSET))

        def _parse_category(data: object) -> None | str | Unset:
            if data is None:
                return data
            if isinstance(data, Unset):
                return data
            return cast("None | str | Unset", data)

        category = _parse_category(d.pop("category", UNSET))

        def _parse_created_at(data: object) -> None | str | Unset:
            if data is None:
                return data
            if isinstance(data, Unset):
                return data
            return cast("None | str | Unset", data)

        created_at = _parse_created_at(d.pop("created_at", UNSET))

        def _parse_created_by(data: object) -> None | str | Unset:
            if data is None:
                return data
            if isinstance(data, Unset):
                return data
            return cast("None | str | Unset", data)

        created_by = _parse_created_by(d.pop("created_by", UNSET))

        def _parse_document_version(data: object) -> None | str | Unset:
            if data is None:
                return data
            if isinstance(data, Unset):
                return data
            return cast("None | str | Unset", data)

        document_version = _parse_document_version(d.pop("document_version", UNSET))

        def _parse_error(data: object) -> ErrorMetadata | None | Unset:
            if data is None:
                return data
            if isinstance(data, Unset):
                return data
            try:
                if not isinstance(data, dict):
                    raise TypeError
                error_type_1 = ErrorMetadata.from_dict(data)

                return error_type_1
            except (TypeError, ValueError, AttributeError, KeyError):
                pass
            return cast("ErrorMetadata | None | Unset", data)

        error = _parse_error(d.pop("error", UNSET))

        def _parse_extraction_duration_ms(data: object) -> int | None | Unset:
            if data is None:
                return data
            if isinstance(data, Unset):
                return data
            return cast("int | None | Unset", data)

        extraction_duration_ms = _parse_extraction_duration_ms(d.pop("extraction_duration_ms", UNSET))

        def _parse_format_(
            data: object,
        ) -> (
            ArchiveMetadata
            | CsvMetadata
            | EmailMetadata
            | ExcelMetadata
            | HtmlMetadata
            | ImageMetadata
            | None
            | OcrMetadata
            | PptxMetadata
            | PstMetadata
            | TextMetadata
            | Unset
            | XmlMetadata
        ):
            if data is None:
                return data
            if isinstance(data, Unset):
                return data
            try:
                if not isinstance(data, dict):
                    raise TypeError
                componentsschemas_format_metadata_type_0 = ExcelMetadata.from_dict(data)

                return componentsschemas_format_metadata_type_0
            except (TypeError, ValueError, AttributeError, KeyError):
                pass
            try:
                if not isinstance(data, dict):
                    raise TypeError
                componentsschemas_format_metadata_type_1 = EmailMetadata.from_dict(data)

                return componentsschemas_format_metadata_type_1
            except (TypeError, ValueError, AttributeError, KeyError):
                pass
            try:
                if not isinstance(data, dict):
                    raise TypeError
                componentsschemas_format_metadata_type_2 = PptxMetadata.from_dict(data)

                return componentsschemas_format_metadata_type_2
            except (TypeError, ValueError, AttributeError, KeyError):
                pass
            try:
                if not isinstance(data, dict):
                    raise TypeError
                componentsschemas_format_metadata_type_3 = ArchiveMetadata.from_dict(data)

                return componentsschemas_format_metadata_type_3
            except (TypeError, ValueError, AttributeError, KeyError):
                pass
            try:
                if not isinstance(data, dict):
                    raise TypeError
                componentsschemas_format_metadata_type_4 = ImageMetadata.from_dict(data)

                return componentsschemas_format_metadata_type_4
            except (TypeError, ValueError, AttributeError, KeyError):
                pass
            try:
                if not isinstance(data, dict):
                    raise TypeError
                componentsschemas_format_metadata_type_5 = XmlMetadata.from_dict(data)

                return componentsschemas_format_metadata_type_5
            except (TypeError, ValueError, AttributeError, KeyError):
                pass
            try:
                if not isinstance(data, dict):
                    raise TypeError
                componentsschemas_format_metadata_type_6 = TextMetadata.from_dict(data)

                return componentsschemas_format_metadata_type_6
            except (TypeError, ValueError, AttributeError, KeyError):
                pass
            try:
                if not isinstance(data, dict):
                    raise TypeError
                componentsschemas_format_metadata_type_7 = HtmlMetadata.from_dict(data)

                return componentsschemas_format_metadata_type_7
            except (TypeError, ValueError, AttributeError, KeyError):
                pass
            try:
                if not isinstance(data, dict):
                    raise TypeError
                componentsschemas_format_metadata_type_8 = OcrMetadata.from_dict(data)

                return componentsschemas_format_metadata_type_8
            except (TypeError, ValueError, AttributeError, KeyError):
                pass
            try:
                if not isinstance(data, dict):
                    raise TypeError
                componentsschemas_format_metadata_type_9 = CsvMetadata.from_dict(data)

                return componentsschemas_format_metadata_type_9
            except (TypeError, ValueError, AttributeError, KeyError):
                pass
            try:
                if not isinstance(data, dict):
                    raise TypeError
                componentsschemas_format_metadata_type_10 = PstMetadata.from_dict(data)

                return componentsschemas_format_metadata_type_10
            except (TypeError, ValueError, AttributeError, KeyError):
                pass
            return cast(
                "ArchiveMetadata | CsvMetadata | EmailMetadata | ExcelMetadata | HtmlMetadata | ImageMetadata | None | OcrMetadata | PptxMetadata | PstMetadata | TextMetadata | Unset | XmlMetadata",
                data,
            )

        format_ = _parse_format_(d.pop("format", UNSET))

        def _parse_image_preprocessing(data: object) -> ImagePreprocessingMetadata | None | Unset:
            if data is None:
                return data
            if isinstance(data, Unset):
                return data
            try:
                if not isinstance(data, dict):
                    raise TypeError
                image_preprocessing_type_1 = ImagePreprocessingMetadata.from_dict(data)

                return image_preprocessing_type_1
            except (TypeError, ValueError, AttributeError, KeyError):
                pass
            return cast("ImagePreprocessingMetadata | None | Unset", data)

        image_preprocessing = _parse_image_preprocessing(d.pop("image_preprocessing", UNSET))

        json_schema = d.pop("json_schema", UNSET)

        def _parse_keywords(data: object) -> list[str] | None | Unset:
            if data is None:
                return data
            if isinstance(data, Unset):
                return data
            try:
                if not isinstance(data, list):
                    raise TypeError
                keywords_type_0 = cast("list[str]", data)

                return keywords_type_0
            except (TypeError, ValueError, AttributeError, KeyError):
                pass
            return cast("list[str] | None | Unset", data)

        keywords = _parse_keywords(d.pop("keywords", UNSET))

        def _parse_language(data: object) -> None | str | Unset:
            if data is None:
                return data
            if isinstance(data, Unset):
                return data
            return cast("None | str | Unset", data)

        language = _parse_language(d.pop("language", UNSET))

        def _parse_modified_at(data: object) -> None | str | Unset:
            if data is None:
                return data
            if isinstance(data, Unset):
                return data
            return cast("None | str | Unset", data)

        modified_at = _parse_modified_at(d.pop("modified_at", UNSET))

        def _parse_modified_by(data: object) -> None | str | Unset:
            if data is None:
                return data
            if isinstance(data, Unset):
                return data
            return cast("None | str | Unset", data)

        modified_by = _parse_modified_by(d.pop("modified_by", UNSET))

        ocr_used = d.pop("ocr_used", UNSET)

        def _parse_output_format(data: object) -> None | str | Unset:
            if data is None:
                return data
            if isinstance(data, Unset):
                return data
            return cast("None | str | Unset", data)

        output_format = _parse_output_format(d.pop("output_format", UNSET))

        def _parse_pages(data: object) -> None | PageStructure | Unset:
            if data is None:
                return data
            if isinstance(data, Unset):
                return data
            try:
                if not isinstance(data, dict):
                    raise TypeError
                pages_type_1 = PageStructure.from_dict(data)

                return pages_type_1
            except (TypeError, ValueError, AttributeError, KeyError):
                pass
            return cast("None | PageStructure | Unset", data)

        pages = _parse_pages(d.pop("pages", UNSET))

        def _parse_subject(data: object) -> None | str | Unset:
            if data is None:
                return data
            if isinstance(data, Unset):
                return data
            return cast("None | str | Unset", data)

        subject = _parse_subject(d.pop("subject", UNSET))

        def _parse_tags(data: object) -> list[str] | None | Unset:
            if data is None:
                return data
            if isinstance(data, Unset):
                return data
            try:
                if not isinstance(data, list):
                    raise TypeError
                tags_type_0 = cast("list[str]", data)

                return tags_type_0
            except (TypeError, ValueError, AttributeError, KeyError):
                pass
            return cast("list[str] | None | Unset", data)

        tags = _parse_tags(d.pop("tags", UNSET))

        def _parse_title(data: object) -> None | str | Unset:
            if data is None:
                return data
            if isinstance(data, Unset):
                return data
            return cast("None | str | Unset", data)

        title = _parse_title(d.pop("title", UNSET))

        metadata = cls(
            abstract_text=abstract_text,
            additional=additional,
            authors=authors,
            category=category,
            created_at=created_at,
            created_by=created_by,
            document_version=document_version,
            error=error,
            extraction_duration_ms=extraction_duration_ms,
            format_=format_,
            image_preprocessing=image_preprocessing,
            json_schema=json_schema,
            keywords=keywords,
            language=language,
            modified_at=modified_at,
            modified_by=modified_by,
            ocr_used=ocr_used,
            output_format=output_format,
            pages=pages,
            subject=subject,
            tags=tags,
            title=title,
        )

        metadata.additional_properties = d
        return metadata

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
