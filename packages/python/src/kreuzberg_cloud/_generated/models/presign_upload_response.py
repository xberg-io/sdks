from __future__ import annotations

from collections.abc import Mapping
from typing import TYPE_CHECKING, Any, TypeVar

from attrs import define as _attrs_define
from attrs import field as _attrs_field
from typing_extensions import Self

if TYPE_CHECKING:
    from ..models.presigned_upload_info import PresignedUploadInfo


T = TypeVar("T", bound="PresignUploadResponse")


@_attrs_define
class PresignUploadResponse:
    """Response from presign endpoint

    Attributes:
        batch_id (str): Batch ID — pass this to the confirm endpoint
        uploads (list[PresignedUploadInfo]): Per-document upload URLs
    """

    batch_id: str
    uploads: list[PresignedUploadInfo]
    additional_properties: dict[str, Any] = _attrs_field(init=False, factory=dict)

    def to_dict(self) -> dict[str, Any]:
        batch_id = self.batch_id

        uploads = []
        for uploads_item_data in self.uploads:
            uploads_item = uploads_item_data.to_dict()
            uploads.append(uploads_item)

        field_dict: dict[str, Any] = {}
        field_dict.update(self.additional_properties)
        field_dict.update(
            {
                "batch_id": batch_id,
                "uploads": uploads,
            }
        )

        return field_dict

    @classmethod
    def from_dict(cls, src_dict: Mapping[str, Any]) -> Self:
        from ..models.presigned_upload_info import PresignedUploadInfo

        d = dict(src_dict)
        batch_id = d.pop("batch_id")

        uploads = []
        _uploads = d.pop("uploads")
        for uploads_item_data in _uploads:
            uploads_item = PresignedUploadInfo.from_dict(uploads_item_data)

            uploads.append(uploads_item)

        presign_upload_response = cls(
            batch_id=batch_id,
            uploads=uploads,
        )

        presign_upload_response.additional_properties = d
        return presign_upload_response

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
