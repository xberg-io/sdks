from __future__ import annotations

from collections.abc import Mapping
from typing import Any, TypeVar

from attrs import define as _attrs_define
from attrs import field as _attrs_field
from typing_extensions import Self

T = TypeVar("T", bound="ProcessingWarning")


@_attrs_define
class ProcessingWarning:
    """A non-fatal warning from a processing pipeline stage.

    Captures errors from optional features that don't prevent extraction
    but may indicate degraded results.

    Attributes:
            message (str): Human-readable description of what went wrong.
            source (str): The pipeline stage or feature that produced this warning
                (e.g., "embedding", "chunking", "language_detection", "output_format").
    """

    message: str
    source: str
    additional_properties: dict[str, Any] = _attrs_field(init=False, factory=dict)

    def to_dict(self) -> dict[str, Any]:
        message = self.message

        source = self.source

        field_dict: dict[str, Any] = {}
        field_dict.update(self.additional_properties)
        field_dict.update(
            {
                "message": message,
                "source": source,
            }
        )

        return field_dict

    @classmethod
    def from_dict(cls, src_dict: Mapping[str, Any]) -> Self:
        d = dict(src_dict)
        message = d.pop("message")

        source = d.pop("source")

        processing_warning = cls(
            message=message,
            source=source,
        )

        processing_warning.additional_properties = d
        return processing_warning

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
