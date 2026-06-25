from __future__ import annotations

from collections.abc import Mapping
from typing import TYPE_CHECKING, Any, TypeVar

from attrs import define as _attrs_define
from attrs import field as _attrs_field
from typing_extensions import Self

from ..types import UNSET, Unset

if TYPE_CHECKING:
    from ..models.djot_image import DjotImage
    from ..models.djot_link import DjotLink
    from ..models.footnote import Footnote
    from ..models.formatted_block import FormattedBlock
    from ..models.metadata import Metadata
    from ..models.table import Table


T = TypeVar("T", bound="DjotContent")


@_attrs_define
class DjotContent:
    """Comprehensive Djot document structure with semantic preservation.

    This type captures the full richness of Djot markup, including:
    - Block-level structures (headings, lists, blockquotes, code blocks, etc.)
    - Inline formatting (emphasis, strong, highlight, subscript, superscript, etc.)
    - Attributes (classes, IDs, key-value pairs)
    - Links, images, footnotes
    - Math expressions (inline and display)
    - Tables with full structure

    Available when the `djot` feature is enabled.

    Attributes:
            blocks (list[FormattedBlock]): Structured block-level content
            footnotes (list[Footnote]): Footnote definitions
            images (list[DjotImage]): Extracted images with metadata
            links (list[DjotLink]): Extracted links with URLs
            metadata (Metadata): Extraction result metadata.

                Contains common fields applicable to all formats, format-specific metadata
                via a discriminated union, and additional custom fields from postprocessors.
            plain_text (str): Plain text representation for backwards compatibility
            tables (list[Table]): Extracted tables as structured data
            attributes (Any | Unset): Attributes mapped by element identifier (if present)
    """

    blocks: list[FormattedBlock]
    footnotes: list[Footnote]
    images: list[DjotImage]
    links: list[DjotLink]
    metadata: Metadata
    plain_text: str
    tables: list[Table]
    attributes: Any | Unset = UNSET
    additional_properties: dict[str, Any] = _attrs_field(init=False, factory=dict)

    def to_dict(self) -> dict[str, Any]:
        blocks = []
        for blocks_item_data in self.blocks:
            blocks_item = blocks_item_data.to_dict()
            blocks.append(blocks_item)

        footnotes = []
        for footnotes_item_data in self.footnotes:
            footnotes_item = footnotes_item_data.to_dict()
            footnotes.append(footnotes_item)

        images = []
        for images_item_data in self.images:
            images_item = images_item_data.to_dict()
            images.append(images_item)

        links = []
        for links_item_data in self.links:
            links_item = links_item_data.to_dict()
            links.append(links_item)

        metadata = self.metadata.to_dict()

        plain_text = self.plain_text

        tables = []
        for tables_item_data in self.tables:
            tables_item = tables_item_data.to_dict()
            tables.append(tables_item)

        attributes = self.attributes

        field_dict: dict[str, Any] = {}
        field_dict.update(self.additional_properties)
        field_dict.update(
            {
                "blocks": blocks,
                "footnotes": footnotes,
                "images": images,
                "links": links,
                "metadata": metadata,
                "plain_text": plain_text,
                "tables": tables,
            }
        )
        if attributes is not UNSET:
            field_dict["attributes"] = attributes

        return field_dict

    @classmethod
    def from_dict(cls, src_dict: Mapping[str, Any]) -> Self:
        from ..models.djot_image import DjotImage
        from ..models.djot_link import DjotLink
        from ..models.footnote import Footnote
        from ..models.formatted_block import FormattedBlock
        from ..models.metadata import Metadata
        from ..models.table import Table

        d = dict(src_dict)
        blocks = []
        _blocks = d.pop("blocks")
        for blocks_item_data in _blocks:
            blocks_item = FormattedBlock.from_dict(blocks_item_data)

            blocks.append(blocks_item)

        footnotes = []
        _footnotes = d.pop("footnotes")
        for footnotes_item_data in _footnotes:
            footnotes_item = Footnote.from_dict(footnotes_item_data)

            footnotes.append(footnotes_item)

        images = []
        _images = d.pop("images")
        for images_item_data in _images:
            images_item = DjotImage.from_dict(images_item_data)

            images.append(images_item)

        links = []
        _links = d.pop("links")
        for links_item_data in _links:
            links_item = DjotLink.from_dict(links_item_data)

            links.append(links_item)

        metadata = Metadata.from_dict(d.pop("metadata"))

        plain_text = d.pop("plain_text")

        tables = []
        _tables = d.pop("tables")
        for tables_item_data in _tables:
            tables_item = Table.from_dict(tables_item_data)

            tables.append(tables_item)

        attributes = d.pop("attributes", UNSET)

        djot_content = cls(
            blocks=blocks,
            footnotes=footnotes,
            images=images,
            links=links,
            metadata=metadata,
            plain_text=plain_text,
            tables=tables,
            attributes=attributes,
        )

        djot_content.additional_properties = d
        return djot_content

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
