from __future__ import annotations

from collections.abc import Mapping
from typing import Any, TypeVar

from attrs import define as _attrs_define
from attrs import field as _attrs_field
from typing_extensions import Self

T = TypeVar("T", bound="PresignedUploadInfo")


@_attrs_define
class PresignedUploadInfo:
    """Info about a single presigned upload

    Attributes:
        expires_in_secs (int): Seconds until the URL expires
        job_id (str): Job ID for this document
        method (str): HTTP method to use (PUT)
        object_key (str): Storage object key
        upload_url (str): Presigned URL to upload the document to
    """

    expires_in_secs: int
    job_id: str
    method: str
    object_key: str
    upload_url: str
    additional_properties: dict[str, Any] = _attrs_field(init=False, factory=dict)

    def to_dict(self) -> dict[str, Any]:
        expires_in_secs = self.expires_in_secs

        job_id = self.job_id

        method = self.method

        object_key = self.object_key

        upload_url = self.upload_url

        field_dict: dict[str, Any] = {}
        field_dict.update(self.additional_properties)
        field_dict.update(
            {
                "expires_in_secs": expires_in_secs,
                "job_id": job_id,
                "method": method,
                "object_key": object_key,
                "upload_url": upload_url,
            }
        )

        return field_dict

    @classmethod
    def from_dict(cls, src_dict: Mapping[str, Any]) -> Self:
        d = dict(src_dict)
        expires_in_secs = d.pop("expires_in_secs")

        job_id = d.pop("job_id")

        method = d.pop("method")

        object_key = d.pop("object_key")

        upload_url = d.pop("upload_url")

        presigned_upload_info = cls(
            expires_in_secs=expires_in_secs,
            job_id=job_id,
            method=method,
            object_key=object_key,
            upload_url=upload_url,
        )

        presigned_upload_info.additional_properties = d
        return presigned_upload_info

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
