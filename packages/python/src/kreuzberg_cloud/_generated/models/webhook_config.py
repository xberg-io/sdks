from __future__ import annotations

from collections.abc import Mapping
from typing import TYPE_CHECKING, Any, TypeVar, cast

from attrs import define as _attrs_define
from attrs import field as _attrs_field
from typing_extensions import Self

from ..types import UNSET, Unset

if TYPE_CHECKING:
    from ..models.webhook_config_metadata_type_0 import WebhookConfigMetadataType0


T = TypeVar("T", bound="WebhookConfig")


@_attrs_define
class WebhookConfig:
    """Webhook configuration for async delivery

    Attributes:
        url (str): URL to deliver results to
        metadata (None | Unset | WebhookConfigMetadataType0): Optional key-value metadata to include in the webhook
            payload
        secret (None | str | Unset): Optional HMAC secret for signing the webhook payload
    """

    url: str
    metadata: None | Unset | WebhookConfigMetadataType0 = UNSET
    secret: None | str | Unset = UNSET
    additional_properties: dict[str, Any] = _attrs_field(init=False, factory=dict)

    def to_dict(self) -> dict[str, Any]:
        from ..models.webhook_config_metadata_type_0 import WebhookConfigMetadataType0

        url = self.url

        metadata: dict[str, Any] | None | Unset
        if isinstance(self.metadata, Unset):
            metadata = UNSET
        elif isinstance(self.metadata, WebhookConfigMetadataType0):
            metadata = self.metadata.to_dict()
        else:
            metadata = self.metadata

        secret: None | str | Unset
        if isinstance(self.secret, Unset):
            secret = UNSET
        else:
            secret = self.secret

        field_dict: dict[str, Any] = {}
        field_dict.update(self.additional_properties)
        field_dict.update(
            {
                "url": url,
            }
        )
        if metadata is not UNSET:
            field_dict["metadata"] = metadata
        if secret is not UNSET:
            field_dict["secret"] = secret

        return field_dict

    @classmethod
    def from_dict(cls, src_dict: Mapping[str, Any]) -> Self:
        from ..models.webhook_config_metadata_type_0 import WebhookConfigMetadataType0

        d = dict(src_dict)
        url = d.pop("url")

        def _parse_metadata(data: object) -> None | Unset | WebhookConfigMetadataType0:
            if data is None:
                return data
            if isinstance(data, Unset):
                return data
            try:
                if not isinstance(data, dict):
                    raise TypeError
                metadata_type_0 = WebhookConfigMetadataType0.from_dict(data)

                return metadata_type_0
            except (TypeError, ValueError, AttributeError, KeyError):
                pass
            return cast("None | Unset | WebhookConfigMetadataType0", data)

        metadata = _parse_metadata(d.pop("metadata", UNSET))

        def _parse_secret(data: object) -> None | str | Unset:
            if data is None:
                return data
            if isinstance(data, Unset):
                return data
            return cast("None | str | Unset", data)

        secret = _parse_secret(d.pop("secret", UNSET))

        webhook_config = cls(
            url=url,
            metadata=metadata,
            secret=secret,
        )

        webhook_config.additional_properties = d
        return webhook_config

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
