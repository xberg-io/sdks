from __future__ import annotations

from collections.abc import Mapping
from typing import TYPE_CHECKING, Any, TypeVar, cast

from attrs import define as _attrs_define
from attrs import field as _attrs_field
from typing_extensions import Self

from ..types import UNSET, Unset

if TYPE_CHECKING:
    from ..models.heading_context import HeadingContext


T = TypeVar("T", bound="ChunkMetadata")


@_attrs_define
class ChunkMetadata:
    """Metadata about a chunk's position in the original document.

    Attributes:
        byte_end (int): Byte offset where this chunk ends in the original text (UTF-8 valid boundary).
        byte_start (int): Byte offset where this chunk starts in the original text (UTF-8 valid boundary).
        chunk_index (int): Zero-based index of this chunk in the document.
        total_chunks (int): Total number of chunks in the document.
        first_page (int | None | Unset): First page number this chunk spans (1-indexed).

            Only populated when page tracking is enabled in extraction configuration.
        heading_context (HeadingContext | None | Unset):
        image_indices (list[int] | Unset): Indices into `ExtractionResult.images` for images on pages covered by this
            chunk.

            Contains zero-based indices into the top-level `images` collection for every
            image whose `page_number` falls within `[first_page, last_page]`.
            Empty when image extraction is disabled or the chunk spans no pages with images.
        last_page (int | None | Unset): Last page number this chunk spans (1-indexed, equal to first_page for single-
            page chunks).

            Only populated when page tracking is enabled in extraction configuration.
        token_count (int | None | Unset): Number of tokens in this chunk (if available).

            This is calculated by the embedding model's tokenizer if embeddings are enabled.
    """

    byte_end: int
    byte_start: int
    chunk_index: int
    total_chunks: int
    first_page: int | None | Unset = UNSET
    heading_context: HeadingContext | None | Unset = UNSET
    image_indices: list[int] | Unset = UNSET
    last_page: int | None | Unset = UNSET
    token_count: int | None | Unset = UNSET
    additional_properties: dict[str, Any] = _attrs_field(init=False, factory=dict)

    def to_dict(self) -> dict[str, Any]:
        from ..models.heading_context import HeadingContext

        byte_end = self.byte_end

        byte_start = self.byte_start

        chunk_index = self.chunk_index

        total_chunks = self.total_chunks

        first_page: int | None | Unset
        if isinstance(self.first_page, Unset):
            first_page = UNSET
        else:
            first_page = self.first_page

        heading_context: dict[str, Any] | None | Unset
        if isinstance(self.heading_context, Unset):
            heading_context = UNSET
        elif isinstance(self.heading_context, HeadingContext):
            heading_context = self.heading_context.to_dict()
        else:
            heading_context = self.heading_context

        image_indices: list[int] | Unset = UNSET
        if not isinstance(self.image_indices, Unset):
            image_indices = self.image_indices

        last_page: int | None | Unset
        if isinstance(self.last_page, Unset):
            last_page = UNSET
        else:
            last_page = self.last_page

        token_count: int | None | Unset
        if isinstance(self.token_count, Unset):
            token_count = UNSET
        else:
            token_count = self.token_count

        field_dict: dict[str, Any] = {}
        field_dict.update(self.additional_properties)
        field_dict.update(
            {
                "byte_end": byte_end,
                "byte_start": byte_start,
                "chunk_index": chunk_index,
                "total_chunks": total_chunks,
            }
        )
        if first_page is not UNSET:
            field_dict["first_page"] = first_page
        if heading_context is not UNSET:
            field_dict["heading_context"] = heading_context
        if image_indices is not UNSET:
            field_dict["image_indices"] = image_indices
        if last_page is not UNSET:
            field_dict["last_page"] = last_page
        if token_count is not UNSET:
            field_dict["token_count"] = token_count

        return field_dict

    @classmethod
    def from_dict(cls, src_dict: Mapping[str, Any]) -> Self:
        from ..models.heading_context import HeadingContext

        d = dict(src_dict)
        byte_end = d.pop("byte_end")

        byte_start = d.pop("byte_start")

        chunk_index = d.pop("chunk_index")

        total_chunks = d.pop("total_chunks")

        def _parse_first_page(data: object) -> int | None | Unset:
            if data is None:
                return data
            if isinstance(data, Unset):
                return data
            return cast("int | None | Unset", data)

        first_page = _parse_first_page(d.pop("first_page", UNSET))

        def _parse_heading_context(data: object) -> HeadingContext | None | Unset:
            if data is None:
                return data
            if isinstance(data, Unset):
                return data
            try:
                if not isinstance(data, dict):
                    raise TypeError
                heading_context_type_1 = HeadingContext.from_dict(data)

                return heading_context_type_1
            except (TypeError, ValueError, AttributeError, KeyError):
                pass
            return cast("HeadingContext | None | Unset", data)

        heading_context = _parse_heading_context(d.pop("heading_context", UNSET))

        image_indices = cast("list[int]", d.pop("image_indices", UNSET))

        def _parse_last_page(data: object) -> int | None | Unset:
            if data is None:
                return data
            if isinstance(data, Unset):
                return data
            return cast("int | None | Unset", data)

        last_page = _parse_last_page(d.pop("last_page", UNSET))

        def _parse_token_count(data: object) -> int | None | Unset:
            if data is None:
                return data
            if isinstance(data, Unset):
                return data
            return cast("int | None | Unset", data)

        token_count = _parse_token_count(d.pop("token_count", UNSET))

        chunk_metadata = cls(
            byte_end=byte_end,
            byte_start=byte_start,
            chunk_index=chunk_index,
            total_chunks=total_chunks,
            first_page=first_page,
            heading_context=heading_context,
            image_indices=image_indices,
            last_page=last_page,
            token_count=token_count,
        )

        chunk_metadata.additional_properties = d
        return chunk_metadata

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
