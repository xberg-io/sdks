from __future__ import annotations

from collections.abc import Mapping
from typing import TYPE_CHECKING, Any, TypeVar, cast

from attrs import define as _attrs_define
from attrs import field as _attrs_field
from typing_extensions import Self

from ..types import UNSET, Unset

if TYPE_CHECKING:
    from ..models.crawl_config import CrawlConfig


T = TypeVar("T", bound="UrlInput")


@_attrs_define
class UrlInput:
    """URL input for crawl-based extraction

    Attributes:
        url (str): URL to crawl and extract documents from
        crawl_config (CrawlConfig | None | Unset):
    """

    url: str
    crawl_config: CrawlConfig | None | Unset = UNSET
    additional_properties: dict[str, Any] = _attrs_field(init=False, factory=dict)

    def to_dict(self) -> dict[str, Any]:
        from ..models.crawl_config import CrawlConfig

        url = self.url

        crawl_config: dict[str, Any] | None | Unset
        if isinstance(self.crawl_config, Unset):
            crawl_config = UNSET
        elif isinstance(self.crawl_config, CrawlConfig):
            crawl_config = self.crawl_config.to_dict()
        else:
            crawl_config = self.crawl_config

        field_dict: dict[str, Any] = {}
        field_dict.update(self.additional_properties)
        field_dict.update(
            {
                "url": url,
            }
        )
        if crawl_config is not UNSET:
            field_dict["crawl_config"] = crawl_config

        return field_dict

    @classmethod
    def from_dict(cls, src_dict: Mapping[str, Any]) -> Self:
        from ..models.crawl_config import CrawlConfig

        d = dict(src_dict)
        url = d.pop("url")

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

        url_input = cls(
            url=url,
            crawl_config=crawl_config,
        )

        url_input.additional_properties = d
        return url_input

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
