from __future__ import annotations

from collections.abc import Mapping
from typing import Any, TypeVar, cast
from uuid import UUID

from attrs import define as _attrs_define
from attrs import field as _attrs_field
from typing_extensions import Self

from ..types import UNSET, Unset

T = TypeVar("T", bound="DocumentInput")


@_attrs_define
class DocumentInput:
    """Document input for JSON extraction requests

    Attributes:
        data (str): Base64-encoded document data
        filename (str): Original filename
        mime_type (str): MIME type of the document
        document_id (None | Unset | UUID): Optional client-supplied document identifier. When provided, this
            extraction is recorded as a version of that logical document and the
            response carries `document_id` + `version_sequence`. Server mints a
            new UUID when absent.
    """

    data: str
    filename: str
    mime_type: str
    document_id: None | Unset | UUID = UNSET
    additional_properties: dict[str, Any] = _attrs_field(init=False, factory=dict)

    def to_dict(self) -> dict[str, Any]:
        data = self.data

        filename = self.filename

        mime_type = self.mime_type

        document_id: None | str | Unset
        if isinstance(self.document_id, Unset):
            document_id = UNSET
        elif isinstance(self.document_id, UUID):
            document_id = str(self.document_id)
        else:
            document_id = self.document_id

        field_dict: dict[str, Any] = {}
        field_dict.update(self.additional_properties)
        field_dict.update(
            {
                "data": data,
                "filename": filename,
                "mime_type": mime_type,
            }
        )
        if document_id is not UNSET:
            field_dict["document_id"] = document_id

        return field_dict

    @classmethod
    def from_dict(cls, src_dict: Mapping[str, Any]) -> Self:
        d = dict(src_dict)
        data = d.pop("data")

        filename = d.pop("filename")

        mime_type = d.pop("mime_type")

        def _parse_document_id(data: object) -> None | Unset | UUID:
            if data is None:
                return data
            if isinstance(data, Unset):
                return data
            try:
                if not isinstance(data, str):
                    raise TypeError
                document_id_type_0 = UUID(data)

                return document_id_type_0
            except (TypeError, ValueError, AttributeError, KeyError):
                pass
            return cast("None | Unset | UUID", data)

        document_id = _parse_document_id(d.pop("document_id", UNSET))

        document_input = cls(
            data=data,
            filename=filename,
            mime_type=mime_type,
            document_id=document_id,
        )

        document_input.additional_properties = d
        return document_input

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
