from __future__ import annotations

from collections.abc import Mapping
from typing import TYPE_CHECKING, Any, TypeVar, cast

from attrs import define as _attrs_define
from attrs import field as _attrs_field
from typing_extensions import Self

from ..types import UNSET, Unset

if TYPE_CHECKING:
    from ..models.chunking_config import ChunkingConfig
    from ..models.content_filter_config import ContentFilterConfig
    from ..models.image_extraction_config import ImageExtractionConfig
    from ..models.language_detection_config import LanguageDetectionConfig
    from ..models.layout_detection_config import LayoutDetectionConfig
    from ..models.ocr_config import OcrConfig
    from ..models.page_config import PageConfig
    from ..models.pdf_config import PdfConfig
    from ..models.post_processor_config import PostProcessorConfig
    from ..models.token_reduction_config import TokenReductionConfig


T = TypeVar("T", bound="ExtractionConfig")


@_attrs_define
class ExtractionConfig:
    """Top-level extraction configuration — mirrors kreuzberg::ExtractionConfig.

    Attributes:
        cache_namespace (None | str | Unset): Cache namespace for tenant isolation
        cache_ttl_secs (int | None | Unset): Per-request cache TTL override in seconds
        chunking (ChunkingConfig | None | Unset):
        content_filter (ContentFilterConfig | None | Unset):
        disable_ocr (bool | None | Unset): Disable OCR entirely
        enable_quality_processing (bool | None | Unset): Enable quality post-processing
        extraction_timeout_secs (int | None | Unset): Per-file extraction timeout in seconds
        force_ocr (bool | None | Unset): Force OCR on all pages (bypass native text extraction)
        force_ocr_pages (list[int] | None | Unset): Force OCR on specific pages (1-indexed)
        html_options (Any | Unset): HTML extraction options (flexible JSON)
        images (ImageExtractionConfig | None | Unset):
        include_document_structure (bool | None | Unset): Include structured document tree in output
        keywords (Any | Unset): Keyword extraction configuration (flexible JSON)
        language_detection (LanguageDetectionConfig | None | Unset):
        layout (LayoutDetectionConfig | None | Unset):
        max_archive_depth (int | None | Unset): Maximum recursion depth for archive extraction
        max_concurrent_extractions (int | None | Unset): Maximum concurrent extractions
        ocr (None | OcrConfig | Unset):
        output_format (None | str | Unset): Output text format: "plain", "markdown", "html", "djot", "structured",
            "json"
        pages (None | PageConfig | Unset):
        pdf_options (None | PdfConfig | Unset):
        postprocessor (None | PostProcessorConfig | Unset):
        result_format (None | str | Unset): Result format: "unified" or "element_based"
        security_limits (Any | Unset): Security limits (flexible JSON)
        token_reduction (None | TokenReductionConfig | Unset):
        use_cache (bool | None | Unset): Enable extraction result caching
    """

    cache_namespace: None | str | Unset = UNSET
    cache_ttl_secs: int | None | Unset = UNSET
    chunking: ChunkingConfig | None | Unset = UNSET
    content_filter: ContentFilterConfig | None | Unset = UNSET
    disable_ocr: bool | None | Unset = UNSET
    enable_quality_processing: bool | None | Unset = UNSET
    extraction_timeout_secs: int | None | Unset = UNSET
    force_ocr: bool | None | Unset = UNSET
    force_ocr_pages: list[int] | None | Unset = UNSET
    html_options: Any | Unset = UNSET
    images: ImageExtractionConfig | None | Unset = UNSET
    include_document_structure: bool | None | Unset = UNSET
    keywords: Any | Unset = UNSET
    language_detection: LanguageDetectionConfig | None | Unset = UNSET
    layout: LayoutDetectionConfig | None | Unset = UNSET
    max_archive_depth: int | None | Unset = UNSET
    max_concurrent_extractions: int | None | Unset = UNSET
    ocr: None | OcrConfig | Unset = UNSET
    output_format: None | str | Unset = UNSET
    pages: None | PageConfig | Unset = UNSET
    pdf_options: None | PdfConfig | Unset = UNSET
    postprocessor: None | PostProcessorConfig | Unset = UNSET
    result_format: None | str | Unset = UNSET
    security_limits: Any | Unset = UNSET
    token_reduction: None | TokenReductionConfig | Unset = UNSET
    use_cache: bool | None | Unset = UNSET
    additional_properties: dict[str, Any] = _attrs_field(init=False, factory=dict)

    def to_dict(self) -> dict[str, Any]:
        from ..models.chunking_config import ChunkingConfig
        from ..models.content_filter_config import ContentFilterConfig
        from ..models.image_extraction_config import ImageExtractionConfig
        from ..models.language_detection_config import LanguageDetectionConfig
        from ..models.layout_detection_config import LayoutDetectionConfig
        from ..models.ocr_config import OcrConfig
        from ..models.page_config import PageConfig
        from ..models.pdf_config import PdfConfig
        from ..models.post_processor_config import PostProcessorConfig
        from ..models.token_reduction_config import TokenReductionConfig

        cache_namespace: None | str | Unset
        if isinstance(self.cache_namespace, Unset):
            cache_namespace = UNSET
        else:
            cache_namespace = self.cache_namespace

        cache_ttl_secs: int | None | Unset
        if isinstance(self.cache_ttl_secs, Unset):
            cache_ttl_secs = UNSET
        else:
            cache_ttl_secs = self.cache_ttl_secs

        chunking: dict[str, Any] | None | Unset
        if isinstance(self.chunking, Unset):
            chunking = UNSET
        elif isinstance(self.chunking, ChunkingConfig):
            chunking = self.chunking.to_dict()
        else:
            chunking = self.chunking

        content_filter: dict[str, Any] | None | Unset
        if isinstance(self.content_filter, Unset):
            content_filter = UNSET
        elif isinstance(self.content_filter, ContentFilterConfig):
            content_filter = self.content_filter.to_dict()
        else:
            content_filter = self.content_filter

        disable_ocr: bool | None | Unset
        if isinstance(self.disable_ocr, Unset):
            disable_ocr = UNSET
        else:
            disable_ocr = self.disable_ocr

        enable_quality_processing: bool | None | Unset
        if isinstance(self.enable_quality_processing, Unset):
            enable_quality_processing = UNSET
        else:
            enable_quality_processing = self.enable_quality_processing

        extraction_timeout_secs: int | None | Unset
        if isinstance(self.extraction_timeout_secs, Unset):
            extraction_timeout_secs = UNSET
        else:
            extraction_timeout_secs = self.extraction_timeout_secs

        force_ocr: bool | None | Unset
        if isinstance(self.force_ocr, Unset):
            force_ocr = UNSET
        else:
            force_ocr = self.force_ocr

        force_ocr_pages: list[int] | None | Unset
        if isinstance(self.force_ocr_pages, Unset):
            force_ocr_pages = UNSET
        elif isinstance(self.force_ocr_pages, list):
            force_ocr_pages = self.force_ocr_pages

        else:
            force_ocr_pages = self.force_ocr_pages

        html_options = self.html_options

        images: dict[str, Any] | None | Unset
        if isinstance(self.images, Unset):
            images = UNSET
        elif isinstance(self.images, ImageExtractionConfig):
            images = self.images.to_dict()
        else:
            images = self.images

        include_document_structure: bool | None | Unset
        if isinstance(self.include_document_structure, Unset):
            include_document_structure = UNSET
        else:
            include_document_structure = self.include_document_structure

        keywords = self.keywords

        language_detection: dict[str, Any] | None | Unset
        if isinstance(self.language_detection, Unset):
            language_detection = UNSET
        elif isinstance(self.language_detection, LanguageDetectionConfig):
            language_detection = self.language_detection.to_dict()
        else:
            language_detection = self.language_detection

        layout: dict[str, Any] | None | Unset
        if isinstance(self.layout, Unset):
            layout = UNSET
        elif isinstance(self.layout, LayoutDetectionConfig):
            layout = self.layout.to_dict()
        else:
            layout = self.layout

        max_archive_depth: int | None | Unset
        if isinstance(self.max_archive_depth, Unset):
            max_archive_depth = UNSET
        else:
            max_archive_depth = self.max_archive_depth

        max_concurrent_extractions: int | None | Unset
        if isinstance(self.max_concurrent_extractions, Unset):
            max_concurrent_extractions = UNSET
        else:
            max_concurrent_extractions = self.max_concurrent_extractions

        ocr: dict[str, Any] | None | Unset
        if isinstance(self.ocr, Unset):
            ocr = UNSET
        elif isinstance(self.ocr, OcrConfig):
            ocr = self.ocr.to_dict()
        else:
            ocr = self.ocr

        output_format: None | str | Unset
        if isinstance(self.output_format, Unset):
            output_format = UNSET
        else:
            output_format = self.output_format

        pages: dict[str, Any] | None | Unset
        if isinstance(self.pages, Unset):
            pages = UNSET
        elif isinstance(self.pages, PageConfig):
            pages = self.pages.to_dict()
        else:
            pages = self.pages

        pdf_options: dict[str, Any] | None | Unset
        if isinstance(self.pdf_options, Unset):
            pdf_options = UNSET
        elif isinstance(self.pdf_options, PdfConfig):
            pdf_options = self.pdf_options.to_dict()
        else:
            pdf_options = self.pdf_options

        postprocessor: dict[str, Any] | None | Unset
        if isinstance(self.postprocessor, Unset):
            postprocessor = UNSET
        elif isinstance(self.postprocessor, PostProcessorConfig):
            postprocessor = self.postprocessor.to_dict()
        else:
            postprocessor = self.postprocessor

        result_format: None | str | Unset
        if isinstance(self.result_format, Unset):
            result_format = UNSET
        else:
            result_format = self.result_format

        security_limits = self.security_limits

        token_reduction: dict[str, Any] | None | Unset
        if isinstance(self.token_reduction, Unset):
            token_reduction = UNSET
        elif isinstance(self.token_reduction, TokenReductionConfig):
            token_reduction = self.token_reduction.to_dict()
        else:
            token_reduction = self.token_reduction

        use_cache: bool | None | Unset
        if isinstance(self.use_cache, Unset):
            use_cache = UNSET
        else:
            use_cache = self.use_cache

        field_dict: dict[str, Any] = {}
        field_dict.update(self.additional_properties)
        field_dict.update({})
        if cache_namespace is not UNSET:
            field_dict["cache_namespace"] = cache_namespace
        if cache_ttl_secs is not UNSET:
            field_dict["cache_ttl_secs"] = cache_ttl_secs
        if chunking is not UNSET:
            field_dict["chunking"] = chunking
        if content_filter is not UNSET:
            field_dict["content_filter"] = content_filter
        if disable_ocr is not UNSET:
            field_dict["disable_ocr"] = disable_ocr
        if enable_quality_processing is not UNSET:
            field_dict["enable_quality_processing"] = enable_quality_processing
        if extraction_timeout_secs is not UNSET:
            field_dict["extraction_timeout_secs"] = extraction_timeout_secs
        if force_ocr is not UNSET:
            field_dict["force_ocr"] = force_ocr
        if force_ocr_pages is not UNSET:
            field_dict["force_ocr_pages"] = force_ocr_pages
        if html_options is not UNSET:
            field_dict["html_options"] = html_options
        if images is not UNSET:
            field_dict["images"] = images
        if include_document_structure is not UNSET:
            field_dict["include_document_structure"] = include_document_structure
        if keywords is not UNSET:
            field_dict["keywords"] = keywords
        if language_detection is not UNSET:
            field_dict["language_detection"] = language_detection
        if layout is not UNSET:
            field_dict["layout"] = layout
        if max_archive_depth is not UNSET:
            field_dict["max_archive_depth"] = max_archive_depth
        if max_concurrent_extractions is not UNSET:
            field_dict["max_concurrent_extractions"] = max_concurrent_extractions
        if ocr is not UNSET:
            field_dict["ocr"] = ocr
        if output_format is not UNSET:
            field_dict["output_format"] = output_format
        if pages is not UNSET:
            field_dict["pages"] = pages
        if pdf_options is not UNSET:
            field_dict["pdf_options"] = pdf_options
        if postprocessor is not UNSET:
            field_dict["postprocessor"] = postprocessor
        if result_format is not UNSET:
            field_dict["result_format"] = result_format
        if security_limits is not UNSET:
            field_dict["security_limits"] = security_limits
        if token_reduction is not UNSET:
            field_dict["token_reduction"] = token_reduction
        if use_cache is not UNSET:
            field_dict["use_cache"] = use_cache

        return field_dict

    @classmethod
    def from_dict(cls, src_dict: Mapping[str, Any]) -> Self:
        from ..models.chunking_config import ChunkingConfig
        from ..models.content_filter_config import ContentFilterConfig
        from ..models.image_extraction_config import ImageExtractionConfig
        from ..models.language_detection_config import LanguageDetectionConfig
        from ..models.layout_detection_config import LayoutDetectionConfig
        from ..models.ocr_config import OcrConfig
        from ..models.page_config import PageConfig
        from ..models.pdf_config import PdfConfig
        from ..models.post_processor_config import PostProcessorConfig
        from ..models.token_reduction_config import TokenReductionConfig

        d = dict(src_dict)

        def _parse_cache_namespace(data: object) -> None | str | Unset:
            if data is None:
                return data
            if isinstance(data, Unset):
                return data
            return cast("None | str | Unset", data)

        cache_namespace = _parse_cache_namespace(d.pop("cache_namespace", UNSET))

        def _parse_cache_ttl_secs(data: object) -> int | None | Unset:
            if data is None:
                return data
            if isinstance(data, Unset):
                return data
            return cast("int | None | Unset", data)

        cache_ttl_secs = _parse_cache_ttl_secs(d.pop("cache_ttl_secs", UNSET))

        def _parse_chunking(data: object) -> ChunkingConfig | None | Unset:
            if data is None:
                return data
            if isinstance(data, Unset):
                return data
            try:
                if not isinstance(data, dict):
                    raise TypeError
                chunking_type_1 = ChunkingConfig.from_dict(data)

                return chunking_type_1
            except (TypeError, ValueError, AttributeError, KeyError):
                pass
            return cast("ChunkingConfig | None | Unset", data)

        chunking = _parse_chunking(d.pop("chunking", UNSET))

        def _parse_content_filter(data: object) -> ContentFilterConfig | None | Unset:
            if data is None:
                return data
            if isinstance(data, Unset):
                return data
            try:
                if not isinstance(data, dict):
                    raise TypeError
                content_filter_type_1 = ContentFilterConfig.from_dict(data)

                return content_filter_type_1
            except (TypeError, ValueError, AttributeError, KeyError):
                pass
            return cast("ContentFilterConfig | None | Unset", data)

        content_filter = _parse_content_filter(d.pop("content_filter", UNSET))

        def _parse_disable_ocr(data: object) -> bool | None | Unset:
            if data is None:
                return data
            if isinstance(data, Unset):
                return data
            return cast("bool | None | Unset", data)

        disable_ocr = _parse_disable_ocr(d.pop("disable_ocr", UNSET))

        def _parse_enable_quality_processing(data: object) -> bool | None | Unset:
            if data is None:
                return data
            if isinstance(data, Unset):
                return data
            return cast("bool | None | Unset", data)

        enable_quality_processing = _parse_enable_quality_processing(d.pop("enable_quality_processing", UNSET))

        def _parse_extraction_timeout_secs(data: object) -> int | None | Unset:
            if data is None:
                return data
            if isinstance(data, Unset):
                return data
            return cast("int | None | Unset", data)

        extraction_timeout_secs = _parse_extraction_timeout_secs(d.pop("extraction_timeout_secs", UNSET))

        def _parse_force_ocr(data: object) -> bool | None | Unset:
            if data is None:
                return data
            if isinstance(data, Unset):
                return data
            return cast("bool | None | Unset", data)

        force_ocr = _parse_force_ocr(d.pop("force_ocr", UNSET))

        def _parse_force_ocr_pages(data: object) -> list[int] | None | Unset:
            if data is None:
                return data
            if isinstance(data, Unset):
                return data
            try:
                if not isinstance(data, list):
                    raise TypeError
                force_ocr_pages_type_0 = cast("list[int]", data)

                return force_ocr_pages_type_0
            except (TypeError, ValueError, AttributeError, KeyError):
                pass
            return cast("list[int] | None | Unset", data)

        force_ocr_pages = _parse_force_ocr_pages(d.pop("force_ocr_pages", UNSET))

        html_options = d.pop("html_options", UNSET)

        def _parse_images(data: object) -> ImageExtractionConfig | None | Unset:
            if data is None:
                return data
            if isinstance(data, Unset):
                return data
            try:
                if not isinstance(data, dict):
                    raise TypeError
                images_type_1 = ImageExtractionConfig.from_dict(data)

                return images_type_1
            except (TypeError, ValueError, AttributeError, KeyError):
                pass
            return cast("ImageExtractionConfig | None | Unset", data)

        images = _parse_images(d.pop("images", UNSET))

        def _parse_include_document_structure(data: object) -> bool | None | Unset:
            if data is None:
                return data
            if isinstance(data, Unset):
                return data
            return cast("bool | None | Unset", data)

        include_document_structure = _parse_include_document_structure(d.pop("include_document_structure", UNSET))

        keywords = d.pop("keywords", UNSET)

        def _parse_language_detection(data: object) -> LanguageDetectionConfig | None | Unset:
            if data is None:
                return data
            if isinstance(data, Unset):
                return data
            try:
                if not isinstance(data, dict):
                    raise TypeError
                language_detection_type_1 = LanguageDetectionConfig.from_dict(data)

                return language_detection_type_1
            except (TypeError, ValueError, AttributeError, KeyError):
                pass
            return cast("LanguageDetectionConfig | None | Unset", data)

        language_detection = _parse_language_detection(d.pop("language_detection", UNSET))

        def _parse_layout(data: object) -> LayoutDetectionConfig | None | Unset:
            if data is None:
                return data
            if isinstance(data, Unset):
                return data
            try:
                if not isinstance(data, dict):
                    raise TypeError
                layout_type_1 = LayoutDetectionConfig.from_dict(data)

                return layout_type_1
            except (TypeError, ValueError, AttributeError, KeyError):
                pass
            return cast("LayoutDetectionConfig | None | Unset", data)

        layout = _parse_layout(d.pop("layout", UNSET))

        def _parse_max_archive_depth(data: object) -> int | None | Unset:
            if data is None:
                return data
            if isinstance(data, Unset):
                return data
            return cast("int | None | Unset", data)

        max_archive_depth = _parse_max_archive_depth(d.pop("max_archive_depth", UNSET))

        def _parse_max_concurrent_extractions(data: object) -> int | None | Unset:
            if data is None:
                return data
            if isinstance(data, Unset):
                return data
            return cast("int | None | Unset", data)

        max_concurrent_extractions = _parse_max_concurrent_extractions(d.pop("max_concurrent_extractions", UNSET))

        def _parse_ocr(data: object) -> None | OcrConfig | Unset:
            if data is None:
                return data
            if isinstance(data, Unset):
                return data
            try:
                if not isinstance(data, dict):
                    raise TypeError
                ocr_type_1 = OcrConfig.from_dict(data)

                return ocr_type_1
            except (TypeError, ValueError, AttributeError, KeyError):
                pass
            return cast("None | OcrConfig | Unset", data)

        ocr = _parse_ocr(d.pop("ocr", UNSET))

        def _parse_output_format(data: object) -> None | str | Unset:
            if data is None:
                return data
            if isinstance(data, Unset):
                return data
            return cast("None | str | Unset", data)

        output_format = _parse_output_format(d.pop("output_format", UNSET))

        def _parse_pages(data: object) -> None | PageConfig | Unset:
            if data is None:
                return data
            if isinstance(data, Unset):
                return data
            try:
                if not isinstance(data, dict):
                    raise TypeError
                pages_type_1 = PageConfig.from_dict(data)

                return pages_type_1
            except (TypeError, ValueError, AttributeError, KeyError):
                pass
            return cast("None | PageConfig | Unset", data)

        pages = _parse_pages(d.pop("pages", UNSET))

        def _parse_pdf_options(data: object) -> None | PdfConfig | Unset:
            if data is None:
                return data
            if isinstance(data, Unset):
                return data
            try:
                if not isinstance(data, dict):
                    raise TypeError
                pdf_options_type_1 = PdfConfig.from_dict(data)

                return pdf_options_type_1
            except (TypeError, ValueError, AttributeError, KeyError):
                pass
            return cast("None | PdfConfig | Unset", data)

        pdf_options = _parse_pdf_options(d.pop("pdf_options", UNSET))

        def _parse_postprocessor(data: object) -> None | PostProcessorConfig | Unset:
            if data is None:
                return data
            if isinstance(data, Unset):
                return data
            try:
                if not isinstance(data, dict):
                    raise TypeError
                postprocessor_type_1 = PostProcessorConfig.from_dict(data)

                return postprocessor_type_1
            except (TypeError, ValueError, AttributeError, KeyError):
                pass
            return cast("None | PostProcessorConfig | Unset", data)

        postprocessor = _parse_postprocessor(d.pop("postprocessor", UNSET))

        def _parse_result_format(data: object) -> None | str | Unset:
            if data is None:
                return data
            if isinstance(data, Unset):
                return data
            return cast("None | str | Unset", data)

        result_format = _parse_result_format(d.pop("result_format", UNSET))

        security_limits = d.pop("security_limits", UNSET)

        def _parse_token_reduction(data: object) -> None | TokenReductionConfig | Unset:
            if data is None:
                return data
            if isinstance(data, Unset):
                return data
            try:
                if not isinstance(data, dict):
                    raise TypeError
                token_reduction_type_1 = TokenReductionConfig.from_dict(data)

                return token_reduction_type_1
            except (TypeError, ValueError, AttributeError, KeyError):
                pass
            return cast("None | TokenReductionConfig | Unset", data)

        token_reduction = _parse_token_reduction(d.pop("token_reduction", UNSET))

        def _parse_use_cache(data: object) -> bool | None | Unset:
            if data is None:
                return data
            if isinstance(data, Unset):
                return data
            return cast("bool | None | Unset", data)

        use_cache = _parse_use_cache(d.pop("use_cache", UNSET))

        extraction_config = cls(
            cache_namespace=cache_namespace,
            cache_ttl_secs=cache_ttl_secs,
            chunking=chunking,
            content_filter=content_filter,
            disable_ocr=disable_ocr,
            enable_quality_processing=enable_quality_processing,
            extraction_timeout_secs=extraction_timeout_secs,
            force_ocr=force_ocr,
            force_ocr_pages=force_ocr_pages,
            html_options=html_options,
            images=images,
            include_document_structure=include_document_structure,
            keywords=keywords,
            language_detection=language_detection,
            layout=layout,
            max_archive_depth=max_archive_depth,
            max_concurrent_extractions=max_concurrent_extractions,
            ocr=ocr,
            output_format=output_format,
            pages=pages,
            pdf_options=pdf_options,
            postprocessor=postprocessor,
            result_format=result_format,
            security_limits=security_limits,
            token_reduction=token_reduction,
            use_cache=use_cache,
        )

        extraction_config.additional_properties = d
        return extraction_config

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
