from __future__ import annotations

from collections.abc import Mapping
from typing import Any, TypeVar, cast

from attrs import define as _attrs_define
from attrs import field as _attrs_field
from typing_extensions import Self

from ..types import UNSET, Unset

T = TypeVar("T", bound="EmailMetadata")


@_attrs_define
class EmailMetadata:
    """Email metadata extracted from .eml and .msg files.

    Includes sender/recipient information, message ID, and attachment list.

    Attributes:
            attachments (list[str]): List of attachment filenames
            bcc_emails (list[str]): BCC recipients
            cc_emails (list[str]): CC recipients
            to_emails (list[str]): Primary recipients
            from_email (None | str | Unset): Sender's email address
            from_name (None | str | Unset): Sender's display name
            message_id (None | str | Unset): Message-ID header value
    """

    attachments: list[str]
    bcc_emails: list[str]
    cc_emails: list[str]
    to_emails: list[str]
    from_email: None | str | Unset = UNSET
    from_name: None | str | Unset = UNSET
    message_id: None | str | Unset = UNSET
    additional_properties: dict[str, Any] = _attrs_field(init=False, factory=dict)

    def to_dict(self) -> dict[str, Any]:
        attachments = self.attachments

        bcc_emails = self.bcc_emails

        cc_emails = self.cc_emails

        to_emails = self.to_emails

        from_email: None | str | Unset
        if isinstance(self.from_email, Unset):
            from_email = UNSET
        else:
            from_email = self.from_email

        from_name: None | str | Unset
        if isinstance(self.from_name, Unset):
            from_name = UNSET
        else:
            from_name = self.from_name

        message_id: None | str | Unset
        if isinstance(self.message_id, Unset):
            message_id = UNSET
        else:
            message_id = self.message_id

        field_dict: dict[str, Any] = {}
        field_dict.update(self.additional_properties)
        field_dict.update(
            {
                "attachments": attachments,
                "bcc_emails": bcc_emails,
                "cc_emails": cc_emails,
                "to_emails": to_emails,
            }
        )
        if from_email is not UNSET:
            field_dict["from_email"] = from_email
        if from_name is not UNSET:
            field_dict["from_name"] = from_name
        if message_id is not UNSET:
            field_dict["message_id"] = message_id

        return field_dict

    @classmethod
    def from_dict(cls, src_dict: Mapping[str, Any]) -> Self:
        d = dict(src_dict)
        attachments = cast("list[str]", d.pop("attachments"))

        bcc_emails = cast("list[str]", d.pop("bcc_emails"))

        cc_emails = cast("list[str]", d.pop("cc_emails"))

        to_emails = cast("list[str]", d.pop("to_emails"))

        def _parse_from_email(data: object) -> None | str | Unset:
            if data is None:
                return data
            if isinstance(data, Unset):
                return data
            return cast("None | str | Unset", data)

        from_email = _parse_from_email(d.pop("from_email", UNSET))

        def _parse_from_name(data: object) -> None | str | Unset:
            if data is None:
                return data
            if isinstance(data, Unset):
                return data
            return cast("None | str | Unset", data)

        from_name = _parse_from_name(d.pop("from_name", UNSET))

        def _parse_message_id(data: object) -> None | str | Unset:
            if data is None:
                return data
            if isinstance(data, Unset):
                return data
            return cast("None | str | Unset", data)

        message_id = _parse_message_id(d.pop("message_id", UNSET))

        email_metadata = cls(
            attachments=attachments,
            bcc_emails=bcc_emails,
            cc_emails=cc_emails,
            to_emails=to_emails,
            from_email=from_email,
            from_name=from_name,
            message_id=message_id,
        )

        email_metadata.additional_properties = d
        return email_metadata

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
