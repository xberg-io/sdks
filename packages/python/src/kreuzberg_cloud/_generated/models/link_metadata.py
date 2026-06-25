from __future__ import annotations

from collections.abc import Mapping
from typing import Any, TypeVar, cast

from attrs import define as _attrs_define
from attrs import field as _attrs_field
from typing_extensions import Self

from ..models.link_type import LinkType, check_link_type
from ..types import UNSET, Unset

T = TypeVar("T", bound="LinkMetadata")


@_attrs_define
class LinkMetadata:
    """Link element metadata.

    Attributes:
        attributes (list[list[str]]): Additional attributes as key-value pairs
        href (str): The href URL value
        link_type (LinkType): Link type classification.
        rel (list[str]): Rel attribute values
        text (str): Link text content (normalized)
        title (None | str | Unset): Optional title attribute
    """

    attributes: list[list[str]]
    href: str
    link_type: LinkType
    rel: list[str]
    text: str
    title: None | str | Unset = UNSET
    additional_properties: dict[str, Any] = _attrs_field(init=False, factory=dict)

    def to_dict(self) -> dict[str, Any]:
        attributes = []
        for attributes_item_data in self.attributes:
            attributes_item = attributes_item_data

            attributes.append(attributes_item)

        href = self.href

        link_type: str = self.link_type

        rel = self.rel

        text = self.text

        title: None | str | Unset
        if isinstance(self.title, Unset):
            title = UNSET
        else:
            title = self.title

        field_dict: dict[str, Any] = {}
        field_dict.update(self.additional_properties)
        field_dict.update(
            {
                "attributes": attributes,
                "href": href,
                "link_type": link_type,
                "rel": rel,
                "text": text,
            }
        )
        if title is not UNSET:
            field_dict["title"] = title

        return field_dict

    @classmethod
    def from_dict(cls, src_dict: Mapping[str, Any]) -> Self:
        d = dict(src_dict)
        attributes = []
        _attributes = d.pop("attributes")
        for attributes_item_data in _attributes:
            attributes_item = cast("list[str]", attributes_item_data)

            attributes.append(attributes_item)

        href = d.pop("href")

        link_type = check_link_type(d.pop("link_type"))

        rel = cast("list[str]", d.pop("rel"))

        text = d.pop("text")

        def _parse_title(data: object) -> None | str | Unset:
            if data is None:
                return data
            if isinstance(data, Unset):
                return data
            return cast("None | str | Unset", data)

        title = _parse_title(d.pop("title", UNSET))

        link_metadata = cls(
            attributes=attributes,
            href=href,
            link_type=link_type,
            rel=rel,
            text=text,
            title=title,
        )

        link_metadata.additional_properties = d
        return link_metadata

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
