from __future__ import annotations

from collections.abc import Mapping
from typing import TYPE_CHECKING, Any, TypeVar, cast

from attrs import define as _attrs_define
from attrs import field as _attrs_field
from typing_extensions import Self

from ..types import UNSET, Unset

if TYPE_CHECKING:
    from ..models.layout_region import LayoutRegion
    from ..models.page_hierarchy import PageHierarchy
    from ..models.table import Table


T = TypeVar("T", bound="PageContent")


@_attrs_define
class PageContent:
    """Content for a single page/slide.

    When page extraction is enabled, documents are split into per-page content
    with associated tables and images mapped to each page.

    # Performance

    Uses Arc-wrapped tables and images for memory efficiency:
    - `Vec<Arc<Table>>` enables zero-copy sharing of table data
    - `Vec<Arc<ExtractedImage>>` enables zero-copy sharing of image data
    - Maintains exact JSON compatibility via custom Serialize/Deserialize

    This reduces memory overhead for documents with shared tables/images
    by avoiding redundant copies during serialization.

    Attributes:
            content (str): Text content for this page
            page_number (int): Page number (1-indexed)
            hierarchy (None | PageHierarchy | Unset):
            image_indices (list[int] | Unset): Indices into `ExtractionResult.images` for images found on this page.

                Each value is a zero-based index into the top-level `images` collection.
                Only populated when `extract_images = true` in the extraction config.
            is_blank (bool | None | Unset): Whether this page is blank (no meaningful text content)

                Determined during extraction based on text content analysis.
                A page is blank if it has fewer than 3 non-whitespace characters
                and contains no tables or images.
            layout_regions (list[LayoutRegion] | None | Unset): Layout detection regions for this page (when layout
                detection is enabled).

                Contains detected layout regions with class, confidence, bounding box,
                and area fraction. Only populated when layout detection is configured.
            section_name (None | str | Unset): Section name this slide belongs to (PPTX only).

                PowerPoint sections group slides into logical chapters (`<p:sectionLst>` in
                `ppt/presentation.xml`). Only populated when the source is a PPTX file and
                the slide belongs to a named section.
            sheet_name (None | str | Unset): Sheet name for this page (XLSX/ODS only).

                Each spreadsheet sheet maps to one `PageContent` entry. This field carries the
                sheet's display name as it appears in the workbook. `None` for all non-spreadsheet
                formats and for sheets with an empty name.
            speaker_notes (None | str | Unset): Speaker notes for this slide (PPTX only).

                Contains the text from the slide's notes pane (`ppt/notesSlides/notesSlide{N}.xml`).
                Only populated when the source is a PPTX file and notes are present.
            tables (list[Table] | Unset): Tables found on this page (uses Arc for memory efficiency)

                Serializes as Vec<Table> for JSON compatibility while maintaining
                Arc semantics in-memory for zero-copy sharing.
    """

    content: str
    page_number: int
    hierarchy: None | PageHierarchy | Unset = UNSET
    image_indices: list[int] | Unset = UNSET
    is_blank: bool | None | Unset = UNSET
    layout_regions: list[LayoutRegion] | None | Unset = UNSET
    section_name: None | str | Unset = UNSET
    sheet_name: None | str | Unset = UNSET
    speaker_notes: None | str | Unset = UNSET
    tables: list[Table] | Unset = UNSET
    additional_properties: dict[str, Any] = _attrs_field(init=False, factory=dict)

    def to_dict(self) -> dict[str, Any]:
        from ..models.page_hierarchy import PageHierarchy

        content = self.content

        page_number = self.page_number

        hierarchy: dict[str, Any] | None | Unset
        if isinstance(self.hierarchy, Unset):
            hierarchy = UNSET
        elif isinstance(self.hierarchy, PageHierarchy):
            hierarchy = self.hierarchy.to_dict()
        else:
            hierarchy = self.hierarchy

        image_indices: list[int] | Unset = UNSET
        if not isinstance(self.image_indices, Unset):
            image_indices = self.image_indices

        is_blank: bool | None | Unset
        if isinstance(self.is_blank, Unset):
            is_blank = UNSET
        else:
            is_blank = self.is_blank

        layout_regions: list[dict[str, Any]] | None | Unset
        if isinstance(self.layout_regions, Unset):
            layout_regions = UNSET
        elif isinstance(self.layout_regions, list):
            layout_regions = []
            for layout_regions_type_0_item_data in self.layout_regions:
                layout_regions_type_0_item = layout_regions_type_0_item_data.to_dict()
                layout_regions.append(layout_regions_type_0_item)

        else:
            layout_regions = self.layout_regions

        section_name: None | str | Unset
        if isinstance(self.section_name, Unset):
            section_name = UNSET
        else:
            section_name = self.section_name

        sheet_name: None | str | Unset
        if isinstance(self.sheet_name, Unset):
            sheet_name = UNSET
        else:
            sheet_name = self.sheet_name

        speaker_notes: None | str | Unset
        if isinstance(self.speaker_notes, Unset):
            speaker_notes = UNSET
        else:
            speaker_notes = self.speaker_notes

        tables: list[dict[str, Any]] | Unset = UNSET
        if not isinstance(self.tables, Unset):
            tables = []
            for tables_item_data in self.tables:
                tables_item = tables_item_data.to_dict()
                tables.append(tables_item)

        field_dict: dict[str, Any] = {}
        field_dict.update(self.additional_properties)
        field_dict.update(
            {
                "content": content,
                "page_number": page_number,
            }
        )
        if hierarchy is not UNSET:
            field_dict["hierarchy"] = hierarchy
        if image_indices is not UNSET:
            field_dict["image_indices"] = image_indices
        if is_blank is not UNSET:
            field_dict["is_blank"] = is_blank
        if layout_regions is not UNSET:
            field_dict["layout_regions"] = layout_regions
        if section_name is not UNSET:
            field_dict["section_name"] = section_name
        if sheet_name is not UNSET:
            field_dict["sheet_name"] = sheet_name
        if speaker_notes is not UNSET:
            field_dict["speaker_notes"] = speaker_notes
        if tables is not UNSET:
            field_dict["tables"] = tables

        return field_dict

    @classmethod
    def from_dict(cls, src_dict: Mapping[str, Any]) -> Self:
        from ..models.layout_region import LayoutRegion
        from ..models.page_hierarchy import PageHierarchy
        from ..models.table import Table

        d = dict(src_dict)
        content = d.pop("content")

        page_number = d.pop("page_number")

        def _parse_hierarchy(data: object) -> None | PageHierarchy | Unset:
            if data is None:
                return data
            if isinstance(data, Unset):
                return data
            try:
                if not isinstance(data, dict):
                    raise TypeError
                hierarchy_type_1 = PageHierarchy.from_dict(data)

                return hierarchy_type_1
            except (TypeError, ValueError, AttributeError, KeyError):
                pass
            return cast("None | PageHierarchy | Unset", data)

        hierarchy = _parse_hierarchy(d.pop("hierarchy", UNSET))

        image_indices = cast("list[int]", d.pop("image_indices", UNSET))

        def _parse_is_blank(data: object) -> bool | None | Unset:
            if data is None:
                return data
            if isinstance(data, Unset):
                return data
            return cast("bool | None | Unset", data)

        is_blank = _parse_is_blank(d.pop("is_blank", UNSET))

        def _parse_layout_regions(data: object) -> list[LayoutRegion] | None | Unset:
            if data is None:
                return data
            if isinstance(data, Unset):
                return data
            try:
                if not isinstance(data, list):
                    raise TypeError
                layout_regions_type_0 = []
                _layout_regions_type_0 = data
                for layout_regions_type_0_item_data in _layout_regions_type_0:
                    layout_regions_type_0_item = LayoutRegion.from_dict(layout_regions_type_0_item_data)

                    layout_regions_type_0.append(layout_regions_type_0_item)

                return layout_regions_type_0
            except (TypeError, ValueError, AttributeError, KeyError):
                pass
            return cast("list[LayoutRegion] | None | Unset", data)

        layout_regions = _parse_layout_regions(d.pop("layout_regions", UNSET))

        def _parse_section_name(data: object) -> None | str | Unset:
            if data is None:
                return data
            if isinstance(data, Unset):
                return data
            return cast("None | str | Unset", data)

        section_name = _parse_section_name(d.pop("section_name", UNSET))

        def _parse_sheet_name(data: object) -> None | str | Unset:
            if data is None:
                return data
            if isinstance(data, Unset):
                return data
            return cast("None | str | Unset", data)

        sheet_name = _parse_sheet_name(d.pop("sheet_name", UNSET))

        def _parse_speaker_notes(data: object) -> None | str | Unset:
            if data is None:
                return data
            if isinstance(data, Unset):
                return data
            return cast("None | str | Unset", data)

        speaker_notes = _parse_speaker_notes(d.pop("speaker_notes", UNSET))

        _tables = d.pop("tables", UNSET)
        tables: list[Table] | Unset = UNSET
        if _tables is not UNSET:
            tables = []
            for tables_item_data in _tables:
                tables_item = Table.from_dict(tables_item_data)

                tables.append(tables_item)

        page_content = cls(
            content=content,
            page_number=page_number,
            hierarchy=hierarchy,
            image_indices=image_indices,
            is_blank=is_blank,
            layout_regions=layout_regions,
            section_name=section_name,
            sheet_name=sheet_name,
            speaker_notes=speaker_notes,
            tables=tables,
        )

        page_content.additional_properties = d
        return page_content

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
