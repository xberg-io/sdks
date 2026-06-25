from __future__ import annotations

from collections.abc import Mapping
from typing import Any, TypeVar, cast

from attrs import define as _attrs_define
from attrs import field as _attrs_field
from typing_extensions import Self

from ..types import UNSET, Unset

T = TypeVar("T", bound="PageInfo")


@_attrs_define
class PageInfo:
    """Metadata for individual page/slide/sheet.

    Captures per-page information including dimensions, content counts,
    and visibility state (for presentations).

    Attributes:
            number (int): Page number (1-indexed)
            dimensions (list[float] | None | Unset): Dimensions in points (PDF) or pixels (images): (width, height)
            has_vector_graphics (bool | Unset): Whether this page contains non-trivial vector graphics (paths, shapes,
                curves)

                Indicates the presence of vector-drawn content such as charts, diagrams,
                or geometric shapes (e.g., from Adobe InDesign, LaTeX TikZ). These are
                invisible to `ExtractionResult.images` since they are not embedded as raster
                XObjects. Set to `true` when path count exceeds a heuristic threshold,
                signaling that downstream consumers may want to rasterize the page to
                capture this content.

                Only populated for PDFs; `None` for other document types.
            hidden (bool | None | Unset): Whether this page is hidden (e.g., in presentations)
            image_count (int | None | Unset): Number of images on this page
            is_blank (bool | None | Unset): Whether this page is blank (no meaningful text, no images, no tables)

                A page is considered blank if it has fewer than 3 non-whitespace characters
                and contains no tables or images. This is useful for filtering out empty pages
                in scanned documents or PDFs with blank separator pages.
            table_count (int | None | Unset): Number of tables on this page
            title (None | str | Unset): Page title (usually for presentations)
    """

    number: int
    dimensions: list[float] | None | Unset = UNSET
    has_vector_graphics: bool | Unset = UNSET
    hidden: bool | None | Unset = UNSET
    image_count: int | None | Unset = UNSET
    is_blank: bool | None | Unset = UNSET
    table_count: int | None | Unset = UNSET
    title: None | str | Unset = UNSET
    additional_properties: dict[str, Any] = _attrs_field(init=False, factory=dict)

    def to_dict(self) -> dict[str, Any]:
        number = self.number

        dimensions: list[float] | None | Unset
        if isinstance(self.dimensions, Unset):
            dimensions = UNSET
        elif isinstance(self.dimensions, list):
            dimensions = self.dimensions

        else:
            dimensions = self.dimensions

        has_vector_graphics = self.has_vector_graphics

        hidden: bool | None | Unset
        if isinstance(self.hidden, Unset):
            hidden = UNSET
        else:
            hidden = self.hidden

        image_count: int | None | Unset
        if isinstance(self.image_count, Unset):
            image_count = UNSET
        else:
            image_count = self.image_count

        is_blank: bool | None | Unset
        if isinstance(self.is_blank, Unset):
            is_blank = UNSET
        else:
            is_blank = self.is_blank

        table_count: int | None | Unset
        if isinstance(self.table_count, Unset):
            table_count = UNSET
        else:
            table_count = self.table_count

        title: None | str | Unset
        if isinstance(self.title, Unset):
            title = UNSET
        else:
            title = self.title

        field_dict: dict[str, Any] = {}
        field_dict.update(self.additional_properties)
        field_dict.update(
            {
                "number": number,
            }
        )
        if dimensions is not UNSET:
            field_dict["dimensions"] = dimensions
        if has_vector_graphics is not UNSET:
            field_dict["has_vector_graphics"] = has_vector_graphics
        if hidden is not UNSET:
            field_dict["hidden"] = hidden
        if image_count is not UNSET:
            field_dict["image_count"] = image_count
        if is_blank is not UNSET:
            field_dict["is_blank"] = is_blank
        if table_count is not UNSET:
            field_dict["table_count"] = table_count
        if title is not UNSET:
            field_dict["title"] = title

        return field_dict

    @classmethod
    def from_dict(cls, src_dict: Mapping[str, Any]) -> Self:
        d = dict(src_dict)
        number = d.pop("number")

        def _parse_dimensions(data: object) -> list[float] | None | Unset:
            if data is None:
                return data
            if isinstance(data, Unset):
                return data
            try:
                if not isinstance(data, list):
                    raise TypeError
                dimensions_type_0 = cast("list[float]", data)

                return dimensions_type_0
            except (TypeError, ValueError, AttributeError, KeyError):
                pass
            return cast("list[float] | None | Unset", data)

        dimensions = _parse_dimensions(d.pop("dimensions", UNSET))

        has_vector_graphics = d.pop("has_vector_graphics", UNSET)

        def _parse_hidden(data: object) -> bool | None | Unset:
            if data is None:
                return data
            if isinstance(data, Unset):
                return data
            return cast("bool | None | Unset", data)

        hidden = _parse_hidden(d.pop("hidden", UNSET))

        def _parse_image_count(data: object) -> int | None | Unset:
            if data is None:
                return data
            if isinstance(data, Unset):
                return data
            return cast("int | None | Unset", data)

        image_count = _parse_image_count(d.pop("image_count", UNSET))

        def _parse_is_blank(data: object) -> bool | None | Unset:
            if data is None:
                return data
            if isinstance(data, Unset):
                return data
            return cast("bool | None | Unset", data)

        is_blank = _parse_is_blank(d.pop("is_blank", UNSET))

        def _parse_table_count(data: object) -> int | None | Unset:
            if data is None:
                return data
            if isinstance(data, Unset):
                return data
            return cast("int | None | Unset", data)

        table_count = _parse_table_count(d.pop("table_count", UNSET))

        def _parse_title(data: object) -> None | str | Unset:
            if data is None:
                return data
            if isinstance(data, Unset):
                return data
            return cast("None | str | Unset", data)

        title = _parse_title(d.pop("title", UNSET))

        page_info = cls(
            number=number,
            dimensions=dimensions,
            has_vector_graphics=has_vector_graphics,
            hidden=hidden,
            image_count=image_count,
            is_blank=is_blank,
            table_count=table_count,
            title=title,
        )

        page_info.additional_properties = d
        return page_info

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
