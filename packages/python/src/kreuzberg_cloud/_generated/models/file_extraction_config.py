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
    from ..models.ocr_config import OcrConfig
    from ..models.page_config import PageConfig
    from ..models.post_processor_config import PostProcessorConfig
    from ..models.token_reduction_config import TokenReductionConfig


T = TypeVar("T", bound="FileExtractionConfig")


@_attrs_define
class FileExtractionConfig:
    """Per-file extraction config override for batch/presign requests.

    All fields are optional — only provided fields override the batch-level config.

    Attributes:
            chunking (ChunkingConfig | None | Unset):
            content_filter (ContentFilterConfig | None | Unset):
            disable_ocr (bool | None | Unset):
            enable_quality_processing (bool | None | Unset):
            extraction_timeout_secs (int | None | Unset):
            force_ocr (bool | None | Unset):
            force_ocr_pages (list[int] | None | Unset):
            images (ImageExtractionConfig | None | Unset):
            include_document_structure (bool | None | Unset):
            language_detection (LanguageDetectionConfig | None | Unset):
            ocr (None | OcrConfig | Unset):
            output_format (None | str | Unset):
            pages (None | PageConfig | Unset):
            postprocessor (None | PostProcessorConfig | Unset):
            result_format (None | str | Unset):
            token_reduction (None | TokenReductionConfig | Unset):
    """

    chunking: ChunkingConfig | None | Unset = UNSET
    content_filter: ContentFilterConfig | None | Unset = UNSET
    disable_ocr: bool | None | Unset = UNSET
    enable_quality_processing: bool | None | Unset = UNSET
    extraction_timeout_secs: int | None | Unset = UNSET
    force_ocr: bool | None | Unset = UNSET
    force_ocr_pages: list[int] | None | Unset = UNSET
    images: ImageExtractionConfig | None | Unset = UNSET
    include_document_structure: bool | None | Unset = UNSET
    language_detection: LanguageDetectionConfig | None | Unset = UNSET
    ocr: None | OcrConfig | Unset = UNSET
    output_format: None | str | Unset = UNSET
    pages: None | PageConfig | Unset = UNSET
    postprocessor: None | PostProcessorConfig | Unset = UNSET
    result_format: None | str | Unset = UNSET
    token_reduction: None | TokenReductionConfig | Unset = UNSET
    additional_properties: dict[str, Any] = _attrs_field(init=False, factory=dict)

    def to_dict(self) -> dict[str, Any]:
        from ..models.chunking_config import ChunkingConfig
        from ..models.content_filter_config import ContentFilterConfig
        from ..models.image_extraction_config import ImageExtractionConfig
        from ..models.language_detection_config import LanguageDetectionConfig
        from ..models.ocr_config import OcrConfig
        from ..models.page_config import PageConfig
        from ..models.post_processor_config import PostProcessorConfig
        from ..models.token_reduction_config import TokenReductionConfig

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

        language_detection: dict[str, Any] | None | Unset
        if isinstance(self.language_detection, Unset):
            language_detection = UNSET
        elif isinstance(self.language_detection, LanguageDetectionConfig):
            language_detection = self.language_detection.to_dict()
        else:
            language_detection = self.language_detection

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

        token_reduction: dict[str, Any] | None | Unset
        if isinstance(self.token_reduction, Unset):
            token_reduction = UNSET
        elif isinstance(self.token_reduction, TokenReductionConfig):
            token_reduction = self.token_reduction.to_dict()
        else:
            token_reduction = self.token_reduction

        field_dict: dict[str, Any] = {}
        field_dict.update(self.additional_properties)
        field_dict.update({})
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
        if images is not UNSET:
            field_dict["images"] = images
        if include_document_structure is not UNSET:
            field_dict["include_document_structure"] = include_document_structure
        if language_detection is not UNSET:
            field_dict["language_detection"] = language_detection
        if ocr is not UNSET:
            field_dict["ocr"] = ocr
        if output_format is not UNSET:
            field_dict["output_format"] = output_format
        if pages is not UNSET:
            field_dict["pages"] = pages
        if postprocessor is not UNSET:
            field_dict["postprocessor"] = postprocessor
        if result_format is not UNSET:
            field_dict["result_format"] = result_format
        if token_reduction is not UNSET:
            field_dict["token_reduction"] = token_reduction

        return field_dict

    @classmethod
    def from_dict(cls, src_dict: Mapping[str, Any]) -> Self:
        from ..models.chunking_config import ChunkingConfig
        from ..models.content_filter_config import ContentFilterConfig
        from ..models.image_extraction_config import ImageExtractionConfig
        from ..models.language_detection_config import LanguageDetectionConfig
        from ..models.ocr_config import OcrConfig
        from ..models.page_config import PageConfig
        from ..models.post_processor_config import PostProcessorConfig
        from ..models.token_reduction_config import TokenReductionConfig

        d = dict(src_dict)

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

        file_extraction_config = cls(
            chunking=chunking,
            content_filter=content_filter,
            disable_ocr=disable_ocr,
            enable_quality_processing=enable_quality_processing,
            extraction_timeout_secs=extraction_timeout_secs,
            force_ocr=force_ocr,
            force_ocr_pages=force_ocr_pages,
            images=images,
            include_document_structure=include_document_structure,
            language_detection=language_detection,
            ocr=ocr,
            output_format=output_format,
            pages=pages,
            postprocessor=postprocessor,
            result_format=result_format,
            token_reduction=token_reduction,
        )

        file_extraction_config.additional_properties = d
        return file_extraction_config

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
