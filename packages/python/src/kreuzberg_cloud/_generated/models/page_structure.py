from __future__ import annotations

from collections.abc import Mapping
from typing import TYPE_CHECKING, Any, TypeVar, cast

from attrs import define as _attrs_define
from attrs import field as _attrs_field
from typing_extensions import Self

from ..models.page_unit_type import PageUnitType, check_page_unit_type
from ..types import UNSET, Unset

if TYPE_CHECKING:
    from ..models.page_boundary import PageBoundary
    from ..models.page_info import PageInfo


T = TypeVar("T", bound="PageStructure")


@_attrs_define
class PageStructure:
    """Unified page structure for documents.

    Supports different page types (PDF pages, PPTX slides, Excel sheets)
    with character offset boundaries for chunk-to-page mapping.

    Attributes:
            total_count (int): Total number of pages/slides/sheets
            unit_type (PageUnitType): Type of paginated unit in a document.

                Distinguishes between different types of "pages" (PDF pages, presentation slides, spreadsheet sheets).
            boundaries (list[PageBoundary] | None | Unset): Character offset boundaries for each page

                Maps character ranges in the extracted content to page numbers.
                Used for chunk page range calculation.
            pages (list[PageInfo] | None | Unset): Detailed per-page metadata (optional, only when needed)
    """

    total_count: int
    unit_type: PageUnitType
    boundaries: list[PageBoundary] | None | Unset = UNSET
    pages: list[PageInfo] | None | Unset = UNSET
    additional_properties: dict[str, Any] = _attrs_field(init=False, factory=dict)

    def to_dict(self) -> dict[str, Any]:
        total_count = self.total_count

        unit_type: str = self.unit_type

        boundaries: list[dict[str, Any]] | None | Unset
        if isinstance(self.boundaries, Unset):
            boundaries = UNSET
        elif isinstance(self.boundaries, list):
            boundaries = []
            for boundaries_type_0_item_data in self.boundaries:
                boundaries_type_0_item = boundaries_type_0_item_data.to_dict()
                boundaries.append(boundaries_type_0_item)

        else:
            boundaries = self.boundaries

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

        field_dict: dict[str, Any] = {}
        field_dict.update(self.additional_properties)
        field_dict.update(
            {
                "total_count": total_count,
                "unit_type": unit_type,
            }
        )
        if boundaries is not UNSET:
            field_dict["boundaries"] = boundaries
        if pages is not UNSET:
            field_dict["pages"] = pages

        return field_dict

    @classmethod
    def from_dict(cls, src_dict: Mapping[str, Any]) -> Self:
        from ..models.page_boundary import PageBoundary
        from ..models.page_info import PageInfo

        d = dict(src_dict)
        total_count = d.pop("total_count")

        unit_type = check_page_unit_type(d.pop("unit_type"))

        def _parse_boundaries(data: object) -> list[PageBoundary] | None | Unset:
            if data is None:
                return data
            if isinstance(data, Unset):
                return data
            try:
                if not isinstance(data, list):
                    raise TypeError
                boundaries_type_0 = []
                _boundaries_type_0 = data
                for boundaries_type_0_item_data in _boundaries_type_0:
                    boundaries_type_0_item = PageBoundary.from_dict(boundaries_type_0_item_data)

                    boundaries_type_0.append(boundaries_type_0_item)

                return boundaries_type_0
            except (TypeError, ValueError, AttributeError, KeyError):
                pass
            return cast("list[PageBoundary] | None | Unset", data)

        boundaries = _parse_boundaries(d.pop("boundaries", UNSET))

        def _parse_pages(data: object) -> list[PageInfo] | None | Unset:
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
                    pages_type_0_item = PageInfo.from_dict(pages_type_0_item_data)

                    pages_type_0.append(pages_type_0_item)

                return pages_type_0
            except (TypeError, ValueError, AttributeError, KeyError):
                pass
            return cast("list[PageInfo] | None | Unset", data)

        pages = _parse_pages(d.pop("pages", UNSET))

        page_structure = cls(
            total_count=total_count,
            unit_type=unit_type,
            boundaries=boundaries,
            pages=pages,
        )

        page_structure.additional_properties = d
        return page_structure

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
