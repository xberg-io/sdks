from __future__ import annotations

from collections.abc import Mapping
from typing import TYPE_CHECKING, Any, TypeVar, cast

from attrs import define as _attrs_define
from attrs import field as _attrs_field
from typing_extensions import Self

from ..models.block_type import BlockType, check_block_type
from ..types import UNSET, Unset

if TYPE_CHECKING:
    from ..models.attributes import Attributes
    from ..models.inline_element import InlineElement


T = TypeVar("T", bound="FormattedBlock")


@_attrs_define
class FormattedBlock:
    """Block-level element in a Djot document.

    Represents structural elements like headings, paragraphs, lists, code blocks, etc.

    Attributes:
            block_type (BlockType): Types of block-level elements in Djot.
            inline_content (list[InlineElement]): Inline content within the block
            attributes (Attributes | None | Unset):
            children (list[FormattedBlock] | Unset): Nested blocks for containers (blockquotes, list items, divs)
            code (None | str | Unset): Raw code content for code blocks
            language (None | str | Unset): Language identifier for code blocks
            level (int | None | Unset): Heading level (1-6) for headings, or nesting level for lists
    """

    block_type: BlockType
    inline_content: list[InlineElement]
    attributes: Attributes | None | Unset = UNSET
    children: list[FormattedBlock] | Unset = UNSET
    code: None | str | Unset = UNSET
    language: None | str | Unset = UNSET
    level: int | None | Unset = UNSET
    additional_properties: dict[str, Any] = _attrs_field(init=False, factory=dict)

    def to_dict(self) -> dict[str, Any]:
        from ..models.attributes import Attributes

        block_type: str = self.block_type

        inline_content = []
        for inline_content_item_data in self.inline_content:
            inline_content_item = inline_content_item_data.to_dict()
            inline_content.append(inline_content_item)

        attributes: dict[str, Any] | None | Unset
        if isinstance(self.attributes, Unset):
            attributes = UNSET
        elif isinstance(self.attributes, Attributes):
            attributes = self.attributes.to_dict()
        else:
            attributes = self.attributes

        children: list[dict[str, Any]] | Unset = UNSET
        if not isinstance(self.children, Unset):
            children = []
            for children_item_data in self.children:
                children_item = children_item_data.to_dict()
                children.append(children_item)

        code: None | str | Unset
        if isinstance(self.code, Unset):
            code = UNSET
        else:
            code = self.code

        language: None | str | Unset
        if isinstance(self.language, Unset):
            language = UNSET
        else:
            language = self.language

        level: int | None | Unset
        if isinstance(self.level, Unset):
            level = UNSET
        else:
            level = self.level

        field_dict: dict[str, Any] = {}
        field_dict.update(self.additional_properties)
        field_dict.update(
            {
                "block_type": block_type,
                "inline_content": inline_content,
            }
        )
        if attributes is not UNSET:
            field_dict["attributes"] = attributes
        if children is not UNSET:
            field_dict["children"] = children
        if code is not UNSET:
            field_dict["code"] = code
        if language is not UNSET:
            field_dict["language"] = language
        if level is not UNSET:
            field_dict["level"] = level

        return field_dict

    @classmethod
    def from_dict(cls, src_dict: Mapping[str, Any]) -> Self:
        from ..models.attributes import Attributes
        from ..models.inline_element import InlineElement

        d = dict(src_dict)
        block_type = check_block_type(d.pop("block_type"))

        inline_content = []
        _inline_content = d.pop("inline_content")
        for inline_content_item_data in _inline_content:
            inline_content_item = InlineElement.from_dict(inline_content_item_data)

            inline_content.append(inline_content_item)

        def _parse_attributes(data: object) -> Attributes | None | Unset:
            if data is None:
                return data
            if isinstance(data, Unset):
                return data
            try:
                if not isinstance(data, dict):
                    raise TypeError
                attributes_type_1 = Attributes.from_dict(data)

                return attributes_type_1
            except (TypeError, ValueError, AttributeError, KeyError):
                pass
            return cast("Attributes | None | Unset", data)

        attributes = _parse_attributes(d.pop("attributes", UNSET))

        _children = d.pop("children", UNSET)
        children: list[FormattedBlock] | Unset = UNSET
        if _children is not UNSET:
            children = []
            for children_item_data in _children:
                children_item = FormattedBlock.from_dict(children_item_data)

                children.append(children_item)

        def _parse_code(data: object) -> None | str | Unset:
            if data is None:
                return data
            if isinstance(data, Unset):
                return data
            return cast("None | str | Unset", data)

        code = _parse_code(d.pop("code", UNSET))

        def _parse_language(data: object) -> None | str | Unset:
            if data is None:
                return data
            if isinstance(data, Unset):
                return data
            return cast("None | str | Unset", data)

        language = _parse_language(d.pop("language", UNSET))

        def _parse_level(data: object) -> int | None | Unset:
            if data is None:
                return data
            if isinstance(data, Unset):
                return data
            return cast("int | None | Unset", data)

        level = _parse_level(d.pop("level", UNSET))

        formatted_block = cls(
            block_type=block_type,
            inline_content=inline_content,
            attributes=attributes,
            children=children,
            code=code,
            language=language,
            level=level,
        )

        formatted_block.additional_properties = d
        return formatted_block

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
