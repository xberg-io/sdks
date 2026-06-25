from __future__ import annotations

from collections.abc import Mapping
from typing import TYPE_CHECKING, Any, TypeVar, cast

from attrs import define as _attrs_define
from attrs import field as _attrs_field
from typing_extensions import Self

from ..types import UNSET, Unset

if TYPE_CHECKING:
    from ..models.file_extraction_config import FileExtractionConfig


T = TypeVar("T", bound="PresignDocumentInput")


@_attrs_define
class PresignDocumentInput:
    """Document metadata for presigned upload (no bytes)

    Attributes:
        filename (str): Original filename
        mime_type (str): MIME type of the document
        config (FileExtractionConfig | None | Unset):
    """

    filename: str
    mime_type: str
    config: FileExtractionConfig | None | Unset = UNSET
    additional_properties: dict[str, Any] = _attrs_field(init=False, factory=dict)

    def to_dict(self) -> dict[str, Any]:
        from ..models.file_extraction_config import FileExtractionConfig

        filename = self.filename

        mime_type = self.mime_type

        config: dict[str, Any] | None | Unset
        if isinstance(self.config, Unset):
            config = UNSET
        elif isinstance(self.config, FileExtractionConfig):
            config = self.config.to_dict()
        else:
            config = self.config

        field_dict: dict[str, Any] = {}
        field_dict.update(self.additional_properties)
        field_dict.update(
            {
                "filename": filename,
                "mime_type": mime_type,
            }
        )
        if config is not UNSET:
            field_dict["config"] = config

        return field_dict

    @classmethod
    def from_dict(cls, src_dict: Mapping[str, Any]) -> Self:
        from ..models.file_extraction_config import FileExtractionConfig

        d = dict(src_dict)
        filename = d.pop("filename")

        mime_type = d.pop("mime_type")

        def _parse_config(data: object) -> FileExtractionConfig | None | Unset:
            if data is None:
                return data
            if isinstance(data, Unset):
                return data
            try:
                if not isinstance(data, dict):
                    raise TypeError
                config_type_1 = FileExtractionConfig.from_dict(data)

                return config_type_1
            except (TypeError, ValueError, AttributeError, KeyError):
                pass
            return cast("FileExtractionConfig | None | Unset", data)

        config = _parse_config(d.pop("config", UNSET))

        presign_document_input = cls(
            filename=filename,
            mime_type=mime_type,
            config=config,
        )

        presign_document_input.additional_properties = d
        return presign_document_input

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
