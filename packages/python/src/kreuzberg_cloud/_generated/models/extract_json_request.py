from __future__ import annotations

from collections.abc import Mapping
from typing import TYPE_CHECKING, Any, TypeVar, cast

from attrs import define as _attrs_define
from attrs import field as _attrs_field
from typing_extensions import Self

from ..types import UNSET, Unset

if TYPE_CHECKING:
    from ..models.crawl_config import CrawlConfig
    from ..models.document_input import DocumentInput
    from ..models.extraction_options import ExtractionOptions
    from ..models.url_input import UrlInput
    from ..models.webhook_config import WebhookConfig


T = TypeVar("T", bound="ExtractJsonRequest")


@_attrs_define
class ExtractJsonRequest:
    """JSON body for `POST /v1/extract`

    Attributes:
        crawl_config (CrawlConfig | None | Unset):
        documents (list[DocumentInput] | Unset): Documents to process
        options (ExtractionOptions | None | Unset):
        urls (list[UrlInput] | Unset): URLs to crawl and extract documents from
        webhook (None | Unset | WebhookConfig):
    """

    crawl_config: CrawlConfig | None | Unset = UNSET
    documents: list[DocumentInput] | Unset = UNSET
    options: ExtractionOptions | None | Unset = UNSET
    urls: list[UrlInput] | Unset = UNSET
    webhook: None | Unset | WebhookConfig = UNSET
    additional_properties: dict[str, Any] = _attrs_field(init=False, factory=dict)

    def to_dict(self) -> dict[str, Any]:
        from ..models.crawl_config import CrawlConfig
        from ..models.extraction_options import ExtractionOptions
        from ..models.webhook_config import WebhookConfig

        crawl_config: dict[str, Any] | None | Unset
        if isinstance(self.crawl_config, Unset):
            crawl_config = UNSET
        elif isinstance(self.crawl_config, CrawlConfig):
            crawl_config = self.crawl_config.to_dict()
        else:
            crawl_config = self.crawl_config

        documents: list[dict[str, Any]] | Unset = UNSET
        if not isinstance(self.documents, Unset):
            documents = []
            for documents_item_data in self.documents:
                documents_item = documents_item_data.to_dict()
                documents.append(documents_item)

        options: dict[str, Any] | None | Unset
        if isinstance(self.options, Unset):
            options = UNSET
        elif isinstance(self.options, ExtractionOptions):
            options = self.options.to_dict()
        else:
            options = self.options

        urls: list[dict[str, Any]] | Unset = UNSET
        if not isinstance(self.urls, Unset):
            urls = []
            for urls_item_data in self.urls:
                urls_item = urls_item_data.to_dict()
                urls.append(urls_item)

        webhook: dict[str, Any] | None | Unset
        if isinstance(self.webhook, Unset):
            webhook = UNSET
        elif isinstance(self.webhook, WebhookConfig):
            webhook = self.webhook.to_dict()
        else:
            webhook = self.webhook

        field_dict: dict[str, Any] = {}
        field_dict.update(self.additional_properties)
        field_dict.update({})
        if crawl_config is not UNSET:
            field_dict["crawl_config"] = crawl_config
        if documents is not UNSET:
            field_dict["documents"] = documents
        if options is not UNSET:
            field_dict["options"] = options
        if urls is not UNSET:
            field_dict["urls"] = urls
        if webhook is not UNSET:
            field_dict["webhook"] = webhook

        return field_dict

    @classmethod
    def from_dict(cls, src_dict: Mapping[str, Any]) -> Self:
        from ..models.crawl_config import CrawlConfig
        from ..models.document_input import DocumentInput
        from ..models.extraction_options import ExtractionOptions
        from ..models.url_input import UrlInput
        from ..models.webhook_config import WebhookConfig

        d = dict(src_dict)

        def _parse_crawl_config(data: object) -> CrawlConfig | None | Unset:
            if data is None:
                return data
            if isinstance(data, Unset):
                return data
            try:
                if not isinstance(data, dict):
                    raise TypeError
                crawl_config_type_1 = CrawlConfig.from_dict(data)

                return crawl_config_type_1
            except (TypeError, ValueError, AttributeError, KeyError):
                pass
            return cast("CrawlConfig | None | Unset", data)

        crawl_config = _parse_crawl_config(d.pop("crawl_config", UNSET))

        _documents = d.pop("documents", UNSET)
        documents: list[DocumentInput] | Unset = UNSET
        if _documents is not UNSET:
            documents = []
            for documents_item_data in _documents:
                documents_item = DocumentInput.from_dict(documents_item_data)

                documents.append(documents_item)

        def _parse_options(data: object) -> ExtractionOptions | None | Unset:
            if data is None:
                return data
            if isinstance(data, Unset):
                return data
            try:
                if not isinstance(data, dict):
                    raise TypeError
                options_type_1 = ExtractionOptions.from_dict(data)

                return options_type_1
            except (TypeError, ValueError, AttributeError, KeyError):
                pass
            return cast("ExtractionOptions | None | Unset", data)

        options = _parse_options(d.pop("options", UNSET))

        _urls = d.pop("urls", UNSET)
        urls: list[UrlInput] | Unset = UNSET
        if _urls is not UNSET:
            urls = []
            for urls_item_data in _urls:
                urls_item = UrlInput.from_dict(urls_item_data)

                urls.append(urls_item)

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

        extract_json_request = cls(
            crawl_config=crawl_config,
            documents=documents,
            options=options,
            urls=urls,
            webhook=webhook,
        )

        extract_json_request.additional_properties = d
        return extract_json_request

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
