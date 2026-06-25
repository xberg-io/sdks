from __future__ import annotations

from collections.abc import Mapping
from typing import TYPE_CHECKING, Any, TypeVar, cast

from attrs import define as _attrs_define
from attrs import field as _attrs_field
from typing_extensions import Self

from ..models.revision_kind import RevisionKind, check_revision_kind
from ..types import UNSET, Unset

if TYPE_CHECKING:
    from ..models.revision_anchor_type_0 import RevisionAnchorType0
    from ..models.revision_anchor_type_1 import RevisionAnchorType1
    from ..models.revision_anchor_type_2 import RevisionAnchorType2
    from ..models.revision_anchor_type_3 import RevisionAnchorType3
    from ..models.revision_anchor_type_4 import RevisionAnchorType4
    from ..models.revision_delta import RevisionDelta


T = TypeVar("T", bound="DocumentRevision")


@_attrs_define
class DocumentRevision:
    """A single tracked change embedded in a document.

    Populated by per-format extractors that understand change-tracking metadata
    (DOCX `w:ins`/`w:del`/`w:rPrChange`, ODT `text:change-*`, …). Every
    extractor defaults to `ExtractionResult.revisions = None` until a
    format-specific implementation is added.

    Attributes:
            delta (RevisionDelta): The content changes that make up a single revision.

                For insertions and deletions the `content` field carries the added/removed
                lines as `DiffLine::Added` / `DiffLine::Removed` entries. For format
                changes, `content` is empty — the property diff is left as a TODO for a
                later enrichment pass.
            kind (RevisionKind): Semantic classification of a tracked change.
            revision_id (str): Format-specific revision identifier.

                For DOCX this is the `w:id` attribute value on the change element
                (e.g. `"42"`). When the attribute is absent a synthetic fallback is
                generated (`"docx-ins-0"`, `"docx-del-3"`, …).
            anchor (None | RevisionAnchorType0 | RevisionAnchorType1 | RevisionAnchorType2 | RevisionAnchorType3 |
                RevisionAnchorType4 | Unset):
            author (None | str | Unset): Display name of the author who made this change, when available.
            timestamp (None | str | Unset): ISO-8601 timestamp of the change, when available.

                Stored as a plain string so this type remains FFI-friendly and
                unconditionally available without the `chrono` optional dep.
                DOCX populates this from the `w:date` attribute (e.g.
                `"2024-03-15T10:30:00Z"`).
    """

    delta: RevisionDelta
    kind: RevisionKind
    revision_id: str
    anchor: (
        None
        | RevisionAnchorType0
        | RevisionAnchorType1
        | RevisionAnchorType2
        | RevisionAnchorType3
        | RevisionAnchorType4
        | Unset
    ) = UNSET
    author: None | str | Unset = UNSET
    timestamp: None | str | Unset = UNSET
    additional_properties: dict[str, Any] = _attrs_field(init=False, factory=dict)

    def to_dict(self) -> dict[str, Any]:
        from ..models.revision_anchor_type_0 import RevisionAnchorType0
        from ..models.revision_anchor_type_1 import RevisionAnchorType1
        from ..models.revision_anchor_type_2 import RevisionAnchorType2
        from ..models.revision_anchor_type_3 import RevisionAnchorType3
        from ..models.revision_anchor_type_4 import RevisionAnchorType4

        delta = self.delta.to_dict()

        kind: str = self.kind

        revision_id = self.revision_id

        anchor: dict[str, Any] | None | Unset
        if isinstance(self.anchor, Unset):
            anchor = UNSET
        elif (
            isinstance(self.anchor, RevisionAnchorType0)
            or isinstance(self.anchor, RevisionAnchorType1)
            or isinstance(self.anchor, RevisionAnchorType2)
            or isinstance(self.anchor, RevisionAnchorType3)
            or isinstance(self.anchor, RevisionAnchorType4)
        ):
            anchor = self.anchor.to_dict()
        else:
            anchor = self.anchor

        author: None | str | Unset
        if isinstance(self.author, Unset):
            author = UNSET
        else:
            author = self.author

        timestamp: None | str | Unset
        if isinstance(self.timestamp, Unset):
            timestamp = UNSET
        else:
            timestamp = self.timestamp

        field_dict: dict[str, Any] = {}
        field_dict.update(self.additional_properties)
        field_dict.update(
            {
                "delta": delta,
                "kind": kind,
                "revision_id": revision_id,
            }
        )
        if anchor is not UNSET:
            field_dict["anchor"] = anchor
        if author is not UNSET:
            field_dict["author"] = author
        if timestamp is not UNSET:
            field_dict["timestamp"] = timestamp

        return field_dict

    @classmethod
    def from_dict(cls, src_dict: Mapping[str, Any]) -> Self:
        from ..models.revision_anchor_type_0 import RevisionAnchorType0
        from ..models.revision_anchor_type_1 import RevisionAnchorType1
        from ..models.revision_anchor_type_2 import RevisionAnchorType2
        from ..models.revision_anchor_type_3 import RevisionAnchorType3
        from ..models.revision_anchor_type_4 import RevisionAnchorType4
        from ..models.revision_delta import RevisionDelta

        d = dict(src_dict)
        delta = RevisionDelta.from_dict(d.pop("delta"))

        kind = check_revision_kind(d.pop("kind"))

        revision_id = d.pop("revision_id")

        def _parse_anchor(
            data: object,
        ) -> (
            None
            | RevisionAnchorType0
            | RevisionAnchorType1
            | RevisionAnchorType2
            | RevisionAnchorType3
            | RevisionAnchorType4
            | Unset
        ):
            if data is None:
                return data
            if isinstance(data, Unset):
                return data
            try:
                if not isinstance(data, dict):
                    raise TypeError
                componentsschemas_revision_anchor_type_0 = RevisionAnchorType0.from_dict(data)

                return componentsschemas_revision_anchor_type_0
            except (TypeError, ValueError, AttributeError, KeyError):
                pass
            try:
                if not isinstance(data, dict):
                    raise TypeError
                componentsschemas_revision_anchor_type_1 = RevisionAnchorType1.from_dict(data)

                return componentsschemas_revision_anchor_type_1
            except (TypeError, ValueError, AttributeError, KeyError):
                pass
            try:
                if not isinstance(data, dict):
                    raise TypeError
                componentsschemas_revision_anchor_type_2 = RevisionAnchorType2.from_dict(data)

                return componentsschemas_revision_anchor_type_2
            except (TypeError, ValueError, AttributeError, KeyError):
                pass
            try:
                if not isinstance(data, dict):
                    raise TypeError
                componentsschemas_revision_anchor_type_3 = RevisionAnchorType3.from_dict(data)

                return componentsschemas_revision_anchor_type_3
            except (TypeError, ValueError, AttributeError, KeyError):
                pass
            try:
                if not isinstance(data, dict):
                    raise TypeError
                componentsschemas_revision_anchor_type_4 = RevisionAnchorType4.from_dict(data)

                return componentsschemas_revision_anchor_type_4
            except (TypeError, ValueError, AttributeError, KeyError):
                pass
            return cast(
                "None | RevisionAnchorType0 | RevisionAnchorType1 | RevisionAnchorType2 | RevisionAnchorType3 | RevisionAnchorType4 | Unset",
                data,
            )

        anchor = _parse_anchor(d.pop("anchor", UNSET))

        def _parse_author(data: object) -> None | str | Unset:
            if data is None:
                return data
            if isinstance(data, Unset):
                return data
            return cast("None | str | Unset", data)

        author = _parse_author(d.pop("author", UNSET))

        def _parse_timestamp(data: object) -> None | str | Unset:
            if data is None:
                return data
            if isinstance(data, Unset):
                return data
            return cast("None | str | Unset", data)

        timestamp = _parse_timestamp(d.pop("timestamp", UNSET))

        document_revision = cls(
            delta=delta,
            kind=kind,
            revision_id=revision_id,
            anchor=anchor,
            author=author,
            timestamp=timestamp,
        )

        document_revision.additional_properties = d
        return document_revision

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
