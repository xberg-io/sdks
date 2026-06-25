from __future__ import annotations

from collections.abc import Mapping
from typing import Any, TypeVar, cast

from attrs import define as _attrs_define
from attrs import field as _attrs_field
from typing_extensions import Self

from ..types import UNSET, Unset

T = TypeVar("T", bound="TextMetadata")


@_attrs_define
class TextMetadata:
    """Text/Markdown metadata.

    Extracted from plain text and Markdown files. Includes word counts and,
    for Markdown, structural elements like headers and links.

    Attributes:
            character_count (int): Number of characters
            line_count (int): Number of lines in the document
            word_count (int): Number of words
            code_blocks (list[list[str]] | None | Unset): Code blocks as (language, code) tuples (for Markdown files)
            headers (list[str] | None | Unset): Markdown headers (headings text only, for Markdown files)
            links (list[list[str]] | None | Unset): Markdown links as (text, url) tuples (for Markdown files)
    """

    character_count: int
    line_count: int
    word_count: int
    code_blocks: list[list[str]] | None | Unset = UNSET
    headers: list[str] | None | Unset = UNSET
    links: list[list[str]] | None | Unset = UNSET
    additional_properties: dict[str, Any] = _attrs_field(init=False, factory=dict)

    def to_dict(self) -> dict[str, Any]:
        character_count = self.character_count

        line_count = self.line_count

        word_count = self.word_count

        code_blocks: list[list[str]] | None | Unset
        if isinstance(self.code_blocks, Unset):
            code_blocks = UNSET
        elif isinstance(self.code_blocks, list):
            code_blocks = []
            for code_blocks_type_0_item_data in self.code_blocks:
                code_blocks_type_0_item = code_blocks_type_0_item_data

                code_blocks.append(code_blocks_type_0_item)

        else:
            code_blocks = self.code_blocks

        headers: list[str] | None | Unset
        if isinstance(self.headers, Unset):
            headers = UNSET
        elif isinstance(self.headers, list):
            headers = self.headers

        else:
            headers = self.headers

        links: list[list[str]] | None | Unset
        if isinstance(self.links, Unset):
            links = UNSET
        elif isinstance(self.links, list):
            links = []
            for links_type_0_item_data in self.links:
                links_type_0_item = links_type_0_item_data

                links.append(links_type_0_item)

        else:
            links = self.links

        field_dict: dict[str, Any] = {}
        field_dict.update(self.additional_properties)
        field_dict.update(
            {
                "character_count": character_count,
                "line_count": line_count,
                "word_count": word_count,
            }
        )
        if code_blocks is not UNSET:
            field_dict["code_blocks"] = code_blocks
        if headers is not UNSET:
            field_dict["headers"] = headers
        if links is not UNSET:
            field_dict["links"] = links

        return field_dict

    @classmethod
    def from_dict(cls, src_dict: Mapping[str, Any]) -> Self:
        d = dict(src_dict)
        character_count = d.pop("character_count")

        line_count = d.pop("line_count")

        word_count = d.pop("word_count")

        def _parse_code_blocks(data: object) -> list[list[str]] | None | Unset:
            if data is None:
                return data
            if isinstance(data, Unset):
                return data
            try:
                if not isinstance(data, list):
                    raise TypeError
                code_blocks_type_0 = []
                _code_blocks_type_0 = data
                for code_blocks_type_0_item_data in _code_blocks_type_0:
                    code_blocks_type_0_item = cast("list[str]", code_blocks_type_0_item_data)

                    code_blocks_type_0.append(code_blocks_type_0_item)

                return code_blocks_type_0
            except (TypeError, ValueError, AttributeError, KeyError):
                pass
            return cast("list[list[str]] | None | Unset", data)

        code_blocks = _parse_code_blocks(d.pop("code_blocks", UNSET))

        def _parse_headers(data: object) -> list[str] | None | Unset:
            if data is None:
                return data
            if isinstance(data, Unset):
                return data
            try:
                if not isinstance(data, list):
                    raise TypeError
                headers_type_0 = cast("list[str]", data)

                return headers_type_0
            except (TypeError, ValueError, AttributeError, KeyError):
                pass
            return cast("list[str] | None | Unset", data)

        headers = _parse_headers(d.pop("headers", UNSET))

        def _parse_links(data: object) -> list[list[str]] | None | Unset:
            if data is None:
                return data
            if isinstance(data, Unset):
                return data
            try:
                if not isinstance(data, list):
                    raise TypeError
                links_type_0 = []
                _links_type_0 = data
                for links_type_0_item_data in _links_type_0:
                    links_type_0_item = cast("list[str]", links_type_0_item_data)

                    links_type_0.append(links_type_0_item)

                return links_type_0
            except (TypeError, ValueError, AttributeError, KeyError):
                pass
            return cast("list[list[str]] | None | Unset", data)

        links = _parse_links(d.pop("links", UNSET))

        text_metadata = cls(
            character_count=character_count,
            line_count=line_count,
            word_count=word_count,
            code_blocks=code_blocks,
            headers=headers,
            links=links,
        )

        text_metadata.additional_properties = d
        return text_metadata

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
