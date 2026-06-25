from __future__ import annotations

from collections.abc import Mapping
from typing import TYPE_CHECKING, Any, TypeVar

from attrs import define as _attrs_define
from attrs import field as _attrs_field
from typing_extensions import Self

from ..types import UNSET, Unset

if TYPE_CHECKING:
    from ..models.hierarchical_block import HierarchicalBlock


T = TypeVar("T", bound="PageHierarchy")


@_attrs_define
class PageHierarchy:
    """Page hierarchy structure containing heading levels and block information.

    Used when PDF text hierarchy extraction is enabled. Contains hierarchical
    blocks with heading levels (H1-H6) for semantic document structure.

    Attributes:
            block_count (int): Number of hierarchy blocks on this page
            blocks (list[HierarchicalBlock] | Unset): Hierarchical blocks with heading levels
    """

    block_count: int
    blocks: list[HierarchicalBlock] | Unset = UNSET
    additional_properties: dict[str, Any] = _attrs_field(init=False, factory=dict)

    def to_dict(self) -> dict[str, Any]:
        block_count = self.block_count

        blocks: list[dict[str, Any]] | Unset = UNSET
        if not isinstance(self.blocks, Unset):
            blocks = []
            for blocks_item_data in self.blocks:
                blocks_item = blocks_item_data.to_dict()
                blocks.append(blocks_item)

        field_dict: dict[str, Any] = {}
        field_dict.update(self.additional_properties)
        field_dict.update(
            {
                "block_count": block_count,
            }
        )
        if blocks is not UNSET:
            field_dict["blocks"] = blocks

        return field_dict

    @classmethod
    def from_dict(cls, src_dict: Mapping[str, Any]) -> Self:
        from ..models.hierarchical_block import HierarchicalBlock

        d = dict(src_dict)
        block_count = d.pop("block_count")

        _blocks = d.pop("blocks", UNSET)
        blocks: list[HierarchicalBlock] | Unset = UNSET
        if _blocks is not UNSET:
            blocks = []
            for blocks_item_data in _blocks:
                blocks_item = HierarchicalBlock.from_dict(blocks_item_data)

                blocks.append(blocks_item)

        page_hierarchy = cls(
            block_count=block_count,
            blocks=blocks,
        )

        page_hierarchy.additional_properties = d
        return page_hierarchy

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
