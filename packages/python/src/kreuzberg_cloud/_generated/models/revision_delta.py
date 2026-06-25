from __future__ import annotations

from collections.abc import Mapping
from typing import TYPE_CHECKING, Any, TypeVar

from attrs import define as _attrs_define
from attrs import field as _attrs_field
from typing_extensions import Self

if TYPE_CHECKING:
    from ..models.cell_change import CellChange
    from ..models.diff_line_type_0 import DiffLineType0
    from ..models.diff_line_type_1 import DiffLineType1
    from ..models.diff_line_type_2 import DiffLineType2


T = TypeVar("T", bound="RevisionDelta")


@_attrs_define
class RevisionDelta:
    """The content changes that make up a single revision.

    For insertions and deletions the `content` field carries the added/removed
    lines as `DiffLine::Added` / `DiffLine::Removed` entries. For format
    changes, `content` is empty — the property diff is left as a TODO for a
    later enrichment pass.

    Attributes:
            content (list[DiffLineType0 | DiffLineType1 | DiffLineType2]): Line-level content changes for this revision.
            table_changes (list[CellChange]): Cell-level table changes for this revision.
    """

    content: list[DiffLineType0 | DiffLineType1 | DiffLineType2]
    table_changes: list[CellChange]
    additional_properties: dict[str, Any] = _attrs_field(init=False, factory=dict)

    def to_dict(self) -> dict[str, Any]:
        from ..models.diff_line_type_0 import DiffLineType0
        from ..models.diff_line_type_1 import DiffLineType1

        content = []
        for content_item_data in self.content:
            content_item: dict[str, Any]
            if isinstance(content_item_data, DiffLineType0) or isinstance(content_item_data, DiffLineType1):
                content_item = content_item_data.to_dict()
            else:
                content_item = content_item_data.to_dict()

            content.append(content_item)

        table_changes = []
        for table_changes_item_data in self.table_changes:
            table_changes_item = table_changes_item_data.to_dict()
            table_changes.append(table_changes_item)

        field_dict: dict[str, Any] = {}
        field_dict.update(self.additional_properties)
        field_dict.update(
            {
                "content": content,
                "table_changes": table_changes,
            }
        )

        return field_dict

    @classmethod
    def from_dict(cls, src_dict: Mapping[str, Any]) -> Self:
        from ..models.cell_change import CellChange
        from ..models.diff_line_type_0 import DiffLineType0
        from ..models.diff_line_type_1 import DiffLineType1
        from ..models.diff_line_type_2 import DiffLineType2

        d = dict(src_dict)
        content = []
        _content = d.pop("content")
        for content_item_data in _content:

            def _parse_content_item(data: object) -> DiffLineType0 | DiffLineType1 | DiffLineType2:
                try:
                    if not isinstance(data, dict):
                        raise TypeError
                    componentsschemas_diff_line_type_0 = DiffLineType0.from_dict(data)

                    return componentsschemas_diff_line_type_0
                except (TypeError, ValueError, AttributeError, KeyError):
                    pass
                try:
                    if not isinstance(data, dict):
                        raise TypeError
                    componentsschemas_diff_line_type_1 = DiffLineType1.from_dict(data)

                    return componentsschemas_diff_line_type_1
                except (TypeError, ValueError, AttributeError, KeyError):
                    pass
                if not isinstance(data, dict):
                    raise TypeError
                componentsschemas_diff_line_type_2 = DiffLineType2.from_dict(data)

                return componentsschemas_diff_line_type_2

            content_item = _parse_content_item(content_item_data)

            content.append(content_item)

        table_changes = []
        _table_changes = d.pop("table_changes")
        for table_changes_item_data in _table_changes:
            table_changes_item = CellChange.from_dict(table_changes_item_data)

            table_changes.append(table_changes_item)

        revision_delta = cls(
            content=content,
            table_changes=table_changes,
        )

        revision_delta.additional_properties = d
        return revision_delta

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
