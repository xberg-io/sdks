from __future__ import annotations

from collections.abc import Mapping
from typing import TYPE_CHECKING, Any, TypeVar, cast

from attrs import define as _attrs_define
from attrs import field as _attrs_field
from typing_extensions import Self

from ..types import UNSET, Unset

if TYPE_CHECKING:
    from ..models.extraction_config import ExtractionConfig
    from ..models.presign_document_input import PresignDocumentInput
    from ..models.webhook_config import WebhookConfig


T = TypeVar("T", bound="PresignUploadRequest")


@_attrs_define
class PresignUploadRequest:
    """Request body for presigning upload URLs

    Attributes:
        documents (list[PresignDocumentInput]): Document metadata (no file data)
        config (ExtractionConfig | None | Unset):
        webhook (None | Unset | WebhookConfig):
    """

    documents: list[PresignDocumentInput]
    config: ExtractionConfig | None | Unset = UNSET
    webhook: None | Unset | WebhookConfig = UNSET
    additional_properties: dict[str, Any] = _attrs_field(init=False, factory=dict)

    def to_dict(self) -> dict[str, Any]:
        from ..models.extraction_config import ExtractionConfig
        from ..models.webhook_config import WebhookConfig

        documents = []
        for documents_item_data in self.documents:
            documents_item = documents_item_data.to_dict()
            documents.append(documents_item)

        config: dict[str, Any] | None | Unset
        if isinstance(self.config, Unset):
            config = UNSET
        elif isinstance(self.config, ExtractionConfig):
            config = self.config.to_dict()
        else:
            config = self.config

        webhook: dict[str, Any] | None | Unset
        if isinstance(self.webhook, Unset):
            webhook = UNSET
        elif isinstance(self.webhook, WebhookConfig):
            webhook = self.webhook.to_dict()
        else:
            webhook = self.webhook

        field_dict: dict[str, Any] = {}
        field_dict.update(self.additional_properties)
        field_dict.update(
            {
                "documents": documents,
            }
        )
        if config is not UNSET:
            field_dict["config"] = config
        if webhook is not UNSET:
            field_dict["webhook"] = webhook

        return field_dict

    @classmethod
    def from_dict(cls, src_dict: Mapping[str, Any]) -> Self:
        from ..models.extraction_config import ExtractionConfig
        from ..models.presign_document_input import PresignDocumentInput
        from ..models.webhook_config import WebhookConfig

        d = dict(src_dict)
        documents = []
        _documents = d.pop("documents")
        for documents_item_data in _documents:
            documents_item = PresignDocumentInput.from_dict(documents_item_data)

            documents.append(documents_item)

        def _parse_config(data: object) -> ExtractionConfig | None | Unset:
            if data is None:
                return data
            if isinstance(data, Unset):
                return data
            try:
                if not isinstance(data, dict):
                    raise TypeError
                config_type_1 = ExtractionConfig.from_dict(data)

                return config_type_1
            except (TypeError, ValueError, AttributeError, KeyError):
                pass
            return cast("ExtractionConfig | None | Unset", data)

        config = _parse_config(d.pop("config", UNSET))

        def _parse_webhook(data: object) -> None | Unset | WebhookConfig:
            if data is None:
                return data
            if isinstance(data, Unset):
                return data
            try:
                if not isinstance(data, dict):
                    raise TypeError
                webhook_type_1 = WebhookConfig.from_dict(data)

                return webhook_type_1
            except (TypeError, ValueError, AttributeError, KeyError):
                pass
            return cast("None | Unset | WebhookConfig", data)

        webhook = _parse_webhook(d.pop("webhook", UNSET))

        presign_upload_request = cls(
            documents=documents,
            config=config,
            webhook=webhook,
        )

        presign_upload_request.additional_properties = d
        return presign_upload_request

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
