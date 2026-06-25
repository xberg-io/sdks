from __future__ import annotations

import datetime
from collections.abc import Mapping
from typing import Any, TypeVar

from attrs import define as _attrs_define
from attrs import field as _attrs_field
from dateutil.parser import isoparse
from typing_extensions import Self

T = TypeVar("T", bound="CreateSandboxKeyResponse")


@_attrs_define
class CreateSandboxKeyResponse:
    """Sandbox key response

    Attributes:
        api_key (str): The sandbox API key (use in Authorization: Bearer header) Example:
            sk_sandbox_ABC123DEF456GHI789JKL012MNO345PQR678STU901VWX234.
        expires_at (datetime.datetime): When the key expires (RFC3339 format) Example: 2025-12-21T10:00:00Z.
        pages_remaining (int): Page extraction quota for this key Example: 50.
    """

    api_key: str
    expires_at: datetime.datetime
    pages_remaining: int
    additional_properties: dict[str, Any] = _attrs_field(init=False, factory=dict)

    def to_dict(self) -> dict[str, Any]:
        api_key = self.api_key

        expires_at = self.expires_at.isoformat()

        pages_remaining = self.pages_remaining

        field_dict: dict[str, Any] = {}
        field_dict.update(self.additional_properties)
        field_dict.update(
            {
                "api_key": api_key,
                "expires_at": expires_at,
                "pages_remaining": pages_remaining,
            }
        )

        return field_dict

    @classmethod
    def from_dict(cls, src_dict: Mapping[str, Any]) -> Self:
        d = dict(src_dict)
        api_key = d.pop("api_key")

        expires_at = isoparse(d.pop("expires_at"))

        pages_remaining = d.pop("pages_remaining")

        create_sandbox_key_response = cls(
            api_key=api_key,
            expires_at=expires_at,
            pages_remaining=pages_remaining,
        )

        create_sandbox_key_response.additional_properties = d
        return create_sandbox_key_response

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
