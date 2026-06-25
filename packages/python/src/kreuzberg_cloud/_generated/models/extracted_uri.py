from __future__ import annotations

from collections.abc import Mapping
from typing import Any, TypeVar, cast

from attrs import define as _attrs_define
from attrs import field as _attrs_field
from typing_extensions import Self

from ..models.uri_kind import UriKind, check_uri_kind
from ..types import UNSET, Unset

T = TypeVar("T", bound="ExtractedUri")


@_attrs_define
class ExtractedUri:
    """A URI extracted from a document.

    Represents any link, reference, or resource pointer found during extraction.
    The `kind` field classifies the URI semantically, while `label` carries
    optional human-readable display text.

    Attributes:
            kind (UriKind): Semantic classification of an extracted URI.
            url (str): The URL or path string.
            label (None | str | Unset): Optional display text / label for the link.
            page (int | None | Unset): Optional page number where the URI was found (1-indexed).
    """

    kind: UriKind
    url: str
    label: None | str | Unset = UNSET
    page: int | None | Unset = UNSET
    additional_properties: dict[str, Any] = _attrs_field(init=False, factory=dict)

    def to_dict(self) -> dict[str, Any]:
        kind: str = self.kind

        url = self.url

        label: None | str | Unset
        if isinstance(self.label, Unset):
            label = UNSET
        else:
            label = self.label

        page: int | None | Unset
        if isinstance(self.page, Unset):
            page = UNSET
        else:
            page = self.page

        field_dict: dict[str, Any] = {}
        field_dict.update(self.additional_properties)
        field_dict.update(
            {
                "kind": kind,
                "url": url,
            }
        )
        if label is not UNSET:
            field_dict["label"] = label
        if page is not UNSET:
            field_dict["page"] = page

        return field_dict

    @classmethod
    def from_dict(cls, src_dict: Mapping[str, Any]) -> Self:
        d = dict(src_dict)
        kind = check_uri_kind(d.pop("kind"))

        url = d.pop("url")

        def _parse_label(data: object) -> None | str | Unset:
            if data is None:
                return data
            if isinstance(data, Unset):
                return data
            return cast("None | str | Unset", data)

        label = _parse_label(d.pop("label", UNSET))

        def _parse_page(data: object) -> int | None | Unset:
            if data is None:
                return data
            if isinstance(data, Unset):
                return data
            return cast("int | None | Unset", data)

        page = _parse_page(d.pop("page", UNSET))

        extracted_uri = cls(
            kind=kind,
            url=url,
            label=label,
            page=page,
        )

        extracted_uri.additional_properties = d
        return extracted_uri

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
