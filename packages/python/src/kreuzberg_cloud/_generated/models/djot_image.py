from __future__ import annotations

from collections.abc import Mapping
from typing import TYPE_CHECKING, Any, TypeVar, cast

from attrs import define as _attrs_define
from attrs import field as _attrs_field
from typing_extensions import Self

from ..types import UNSET, Unset

if TYPE_CHECKING:
    from ..models.attributes import Attributes


T = TypeVar("T", bound="DjotImage")


@_attrs_define
class DjotImage:
    """Image element in Djot.

    Attributes:
        alt (str): Alternative text
        src (str): Image source URL or path
        attributes (Attributes | None | Unset):
        title (None | str | Unset): Optional title
    """

    alt: str
    src: str
    attributes: Attributes | None | Unset = UNSET
    title: None | str | Unset = UNSET
    additional_properties: dict[str, Any] = _attrs_field(init=False, factory=dict)

    def to_dict(self) -> dict[str, Any]:
        from ..models.attributes import Attributes

        alt = self.alt

        src = self.src

        attributes: dict[str, Any] | None | Unset
        if isinstance(self.attributes, Unset):
            attributes = UNSET
        elif isinstance(self.attributes, Attributes):
            attributes = self.attributes.to_dict()
        else:
            attributes = self.attributes

        title: None | str | Unset
        if isinstance(self.title, Unset):
            title = UNSET
        else:
            title = self.title

        field_dict: dict[str, Any] = {}
        field_dict.update(self.additional_properties)
        field_dict.update(
            {
                "alt": alt,
                "src": src,
            }
        )
        if attributes is not UNSET:
            field_dict["attributes"] = attributes
        if title is not UNSET:
            field_dict["title"] = title

        return field_dict

    @classmethod
    def from_dict(cls, src_dict: Mapping[str, Any]) -> Self:
        from ..models.attributes import Attributes

        d = dict(src_dict)
        alt = d.pop("alt")

        src = d.pop("src")

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

        def _parse_title(data: object) -> None | str | Unset:
            if data is None:
                return data
            if isinstance(data, Unset):
                return data
            return cast("None | str | Unset", data)

        title = _parse_title(d.pop("title", UNSET))

        djot_image = cls(
            alt=alt,
            src=src,
            attributes=attributes,
            title=title,
        )

        djot_image.additional_properties = d
        return djot_image

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
