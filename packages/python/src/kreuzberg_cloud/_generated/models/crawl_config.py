from __future__ import annotations

from collections.abc import Mapping
from typing import TYPE_CHECKING, Any, TypeVar, cast

from attrs import define as _attrs_define
from attrs import field as _attrs_field
from typing_extensions import Self

from ..types import UNSET, Unset

if TYPE_CHECKING:
    from ..models.browser_overrides import BrowserOverrides
    from ..models.bypass_request_override import BypassRequestOverride
    from ..models.proxy_override import ProxyOverride


T = TypeVar("T", bound="CrawlConfig")


@_attrs_define
class CrawlConfig:
    """Crawl policy configuration — controls URL crawling behavior.

    Example:
        {'max_depth': 2, 'max_pages': 100, 'max_concurrent': 10, 'stay_on_domain': True, 'allow_subdomains': True,
            'respect_robots_txt': True}

    Attributes:
        allow_subdomains (bool | None | Unset): Allow subdomains of the seed domain (default: true) Example: True.
        allowed_file_types (list[str] | Unset): MIME types of documents to extract (default: all supported by kreuzberg)
            Example: ['application/pdf', 'text/html'].
        browser (BrowserOverrides | None | Unset):
        bypass (BypassRequestOverride | None | Unset):
        document_url_depth (int | None | Unset): Max depth for URL-following from documents (default: 1, max: 3)
            Example: 1.
        exclude_paths (list[str] | Unset): Regex patterns — skip URLs matching these Example: ['/admin/.*', '/login'].
        extract_page_content (bool | None | Unset): Also extract the HTML page content as markdown (default: false)
        follow_document_urls (bool | None | Unset): Follow URLs discovered inside extracted documents (default: false)
        include_paths (list[str] | Unset): Regex patterns — only crawl URLs matching these Example: ['/docs/.*',
            '/blog/.*'].
        max_concurrent (int | None | Unset): Maximum concurrent requests (default: 10) Example: 10.
        max_depth (int | None | Unset): Maximum crawl depth from seed URL (default: 2, max: 5) Example: 2.
        max_pages (int | None | Unset): Maximum pages to crawl (default: 100, max: 10000) Example: 100.
        output_mode (None | str | Unset): Output mode (default: "extract").
            - "scrape":  single-page fetch, no recursion, no extraction
            - "crawl":   multi-page crawl, no extraction (raw content returned)
            - "extract": multi-page crawl + extract each discovered document Example: extract.
        proxy (None | ProxyOverride | Unset):
        request_timeout_secs (int | None | Unset): Per-request timeout in seconds (default: 30) Example: 30.
        respect_robots_txt (bool | None | Unset): Respect robots.txt (default: true) Example: True.
        stay_on_domain (bool | None | Unset): Stay on the same domain as seed URL (default: true) Example: True.
        strategy (None | str | Unset): Crawl strategy: "bfs" (default), "dfs", "best_first", "adaptive" Example: bfs.
        user_agent (None | str | Unset): Custom User-Agent string Example: KreuzbergBot/1.0.
    """

    allow_subdomains: bool | None | Unset = UNSET
    allowed_file_types: list[str] | Unset = UNSET
    browser: BrowserOverrides | None | Unset = UNSET
    bypass: BypassRequestOverride | None | Unset = UNSET
    document_url_depth: int | None | Unset = UNSET
    exclude_paths: list[str] | Unset = UNSET
    extract_page_content: bool | None | Unset = UNSET
    follow_document_urls: bool | None | Unset = UNSET
    include_paths: list[str] | Unset = UNSET
    max_concurrent: int | None | Unset = UNSET
    max_depth: int | None | Unset = UNSET
    max_pages: int | None | Unset = UNSET
    output_mode: None | str | Unset = UNSET
    proxy: None | ProxyOverride | Unset = UNSET
    request_timeout_secs: int | None | Unset = UNSET
    respect_robots_txt: bool | None | Unset = UNSET
    stay_on_domain: bool | None | Unset = UNSET
    strategy: None | str | Unset = UNSET
    user_agent: None | str | Unset = UNSET
    additional_properties: dict[str, Any] = _attrs_field(init=False, factory=dict)

    def to_dict(self) -> dict[str, Any]:
        from ..models.browser_overrides import BrowserOverrides
        from ..models.bypass_request_override import BypassRequestOverride
        from ..models.proxy_override import ProxyOverride

        allow_subdomains: bool | None | Unset
        if isinstance(self.allow_subdomains, Unset):
            allow_subdomains = UNSET
        else:
            allow_subdomains = self.allow_subdomains

        allowed_file_types: list[str] | Unset = UNSET
        if not isinstance(self.allowed_file_types, Unset):
            allowed_file_types = self.allowed_file_types

        browser: dict[str, Any] | None | Unset
        if isinstance(self.browser, Unset):
            browser = UNSET
        elif isinstance(self.browser, BrowserOverrides):
            browser = self.browser.to_dict()
        else:
            browser = self.browser

        bypass: dict[str, Any] | None | Unset
        if isinstance(self.bypass, Unset):
            bypass = UNSET
        elif isinstance(self.bypass, BypassRequestOverride):
            bypass = self.bypass.to_dict()
        else:
            bypass = self.bypass

        document_url_depth: int | None | Unset
        if isinstance(self.document_url_depth, Unset):
            document_url_depth = UNSET
        else:
            document_url_depth = self.document_url_depth

        exclude_paths: list[str] | Unset = UNSET
        if not isinstance(self.exclude_paths, Unset):
            exclude_paths = self.exclude_paths

        extract_page_content: bool | None | Unset
        if isinstance(self.extract_page_content, Unset):
            extract_page_content = UNSET
        else:
            extract_page_content = self.extract_page_content

        follow_document_urls: bool | None | Unset
        if isinstance(self.follow_document_urls, Unset):
            follow_document_urls = UNSET
        else:
            follow_document_urls = self.follow_document_urls

        include_paths: list[str] | Unset = UNSET
        if not isinstance(self.include_paths, Unset):
            include_paths = self.include_paths

        max_concurrent: int | None | Unset
        if isinstance(self.max_concurrent, Unset):
            max_concurrent = UNSET
        else:
            max_concurrent = self.max_concurrent

        max_depth: int | None | Unset
        if isinstance(self.max_depth, Unset):
            max_depth = UNSET
        else:
            max_depth = self.max_depth

        max_pages: int | None | Unset
        if isinstance(self.max_pages, Unset):
            max_pages = UNSET
        else:
            max_pages = self.max_pages

        output_mode: None | str | Unset
        if isinstance(self.output_mode, Unset):
            output_mode = UNSET
        else:
            output_mode = self.output_mode

        proxy: dict[str, Any] | None | Unset
        if isinstance(self.proxy, Unset):
            proxy = UNSET
        elif isinstance(self.proxy, ProxyOverride):
            proxy = self.proxy.to_dict()
        else:
            proxy = self.proxy

        request_timeout_secs: int | None | Unset
        if isinstance(self.request_timeout_secs, Unset):
            request_timeout_secs = UNSET
        else:
            request_timeout_secs = self.request_timeout_secs

        respect_robots_txt: bool | None | Unset
        if isinstance(self.respect_robots_txt, Unset):
            respect_robots_txt = UNSET
        else:
            respect_robots_txt = self.respect_robots_txt

        stay_on_domain: bool | None | Unset
        if isinstance(self.stay_on_domain, Unset):
            stay_on_domain = UNSET
        else:
            stay_on_domain = self.stay_on_domain

        strategy: None | str | Unset
        if isinstance(self.strategy, Unset):
            strategy = UNSET
        else:
            strategy = self.strategy

        user_agent: None | str | Unset
        if isinstance(self.user_agent, Unset):
            user_agent = UNSET
        else:
            user_agent = self.user_agent

        field_dict: dict[str, Any] = {}
        field_dict.update(self.additional_properties)
        field_dict.update({})
        if allow_subdomains is not UNSET:
            field_dict["allow_subdomains"] = allow_subdomains
        if allowed_file_types is not UNSET:
            field_dict["allowed_file_types"] = allowed_file_types
        if browser is not UNSET:
            field_dict["browser"] = browser
        if bypass is not UNSET:
            field_dict["bypass"] = bypass
        if document_url_depth is not UNSET:
            field_dict["document_url_depth"] = document_url_depth
        if exclude_paths is not UNSET:
            field_dict["exclude_paths"] = exclude_paths
        if extract_page_content is not UNSET:
            field_dict["extract_page_content"] = extract_page_content
        if follow_document_urls is not UNSET:
            field_dict["follow_document_urls"] = follow_document_urls
        if include_paths is not UNSET:
            field_dict["include_paths"] = include_paths
        if max_concurrent is not UNSET:
            field_dict["max_concurrent"] = max_concurrent
        if max_depth is not UNSET:
            field_dict["max_depth"] = max_depth
        if max_pages is not UNSET:
            field_dict["max_pages"] = max_pages
        if output_mode is not UNSET:
            field_dict["output_mode"] = output_mode
        if proxy is not UNSET:
            field_dict["proxy"] = proxy
        if request_timeout_secs is not UNSET:
            field_dict["request_timeout_secs"] = request_timeout_secs
        if respect_robots_txt is not UNSET:
            field_dict["respect_robots_txt"] = respect_robots_txt
        if stay_on_domain is not UNSET:
            field_dict["stay_on_domain"] = stay_on_domain
        if strategy is not UNSET:
            field_dict["strategy"] = strategy
        if user_agent is not UNSET:
            field_dict["user_agent"] = user_agent

        return field_dict

    @classmethod
    def from_dict(cls, src_dict: Mapping[str, Any]) -> Self:
        from ..models.browser_overrides import BrowserOverrides
        from ..models.bypass_request_override import BypassRequestOverride
        from ..models.proxy_override import ProxyOverride

        d = dict(src_dict)

        def _parse_allow_subdomains(data: object) -> bool | None | Unset:
            if data is None:
                return data
            if isinstance(data, Unset):
                return data
            return cast("bool | None | Unset", data)

        allow_subdomains = _parse_allow_subdomains(d.pop("allow_subdomains", UNSET))

        allowed_file_types = cast("list[str]", d.pop("allowed_file_types", UNSET))

        def _parse_browser(data: object) -> BrowserOverrides | None | Unset:
            if data is None:
                return data
            if isinstance(data, Unset):
                return data
            try:
                if not isinstance(data, dict):
                    raise TypeError
                browser_type_1 = BrowserOverrides.from_dict(data)

                return browser_type_1
            except (TypeError, ValueError, AttributeError, KeyError):
                pass
            return cast("BrowserOverrides | None | Unset", data)

        browser = _parse_browser(d.pop("browser", UNSET))

        def _parse_bypass(data: object) -> BypassRequestOverride | None | Unset:
            if data is None:
                return data
            if isinstance(data, Unset):
                return data
            try:
                if not isinstance(data, dict):
                    raise TypeError
                bypass_type_1 = BypassRequestOverride.from_dict(data)

                return bypass_type_1
            except (TypeError, ValueError, AttributeError, KeyError):
                pass
            return cast("BypassRequestOverride | None | Unset", data)

        bypass = _parse_bypass(d.pop("bypass", UNSET))

        def _parse_document_url_depth(data: object) -> int | None | Unset:
            if data is None:
                return data
            if isinstance(data, Unset):
                return data
            return cast("int | None | Unset", data)

        document_url_depth = _parse_document_url_depth(d.pop("document_url_depth", UNSET))

        exclude_paths = cast("list[str]", d.pop("exclude_paths", UNSET))

        def _parse_extract_page_content(data: object) -> bool | None | Unset:
            if data is None:
                return data
            if isinstance(data, Unset):
                return data
            return cast("bool | None | Unset", data)

        extract_page_content = _parse_extract_page_content(d.pop("extract_page_content", UNSET))

        def _parse_follow_document_urls(data: object) -> bool | None | Unset:
            if data is None:
                return data
            if isinstance(data, Unset):
                return data
            return cast("bool | None | Unset", data)

        follow_document_urls = _parse_follow_document_urls(d.pop("follow_document_urls", UNSET))

        include_paths = cast("list[str]", d.pop("include_paths", UNSET))

        def _parse_max_concurrent(data: object) -> int | None | Unset:
            if data is None:
                return data
            if isinstance(data, Unset):
                return data
            return cast("int | None | Unset", data)

        max_concurrent = _parse_max_concurrent(d.pop("max_concurrent", UNSET))

        def _parse_max_depth(data: object) -> int | None | Unset:
            if data is None:
                return data
            if isinstance(data, Unset):
                return data
            return cast("int | None | Unset", data)

        max_depth = _parse_max_depth(d.pop("max_depth", UNSET))

        def _parse_max_pages(data: object) -> int | None | Unset:
            if data is None:
                return data
            if isinstance(data, Unset):
                return data
            return cast("int | None | Unset", data)

        max_pages = _parse_max_pages(d.pop("max_pages", UNSET))

        def _parse_output_mode(data: object) -> None | str | Unset:
            if data is None:
                return data
            if isinstance(data, Unset):
                return data
            return cast("None | str | Unset", data)

        output_mode = _parse_output_mode(d.pop("output_mode", UNSET))

        def _parse_proxy(data: object) -> None | ProxyOverride | Unset:
            if data is None:
                return data
            if isinstance(data, Unset):
                return data
            try:
                if not isinstance(data, dict):
                    raise TypeError
                proxy_type_1 = ProxyOverride.from_dict(data)

                return proxy_type_1
            except (TypeError, ValueError, AttributeError, KeyError):
                pass
            return cast("None | ProxyOverride | Unset", data)

        proxy = _parse_proxy(d.pop("proxy", UNSET))

        def _parse_request_timeout_secs(data: object) -> int | None | Unset:
            if data is None:
                return data
            if isinstance(data, Unset):
                return data
            return cast("int | None | Unset", data)

        request_timeout_secs = _parse_request_timeout_secs(d.pop("request_timeout_secs", UNSET))

        def _parse_respect_robots_txt(data: object) -> bool | None | Unset:
            if data is None:
                return data
            if isinstance(data, Unset):
                return data
            return cast("bool | None | Unset", data)

        respect_robots_txt = _parse_respect_robots_txt(d.pop("respect_robots_txt", UNSET))

        def _parse_stay_on_domain(data: object) -> bool | None | Unset:
            if data is None:
                return data
            if isinstance(data, Unset):
                return data
            return cast("bool | None | Unset", data)

        stay_on_domain = _parse_stay_on_domain(d.pop("stay_on_domain", UNSET))

        def _parse_strategy(data: object) -> None | str | Unset:
            if data is None:
                return data
            if isinstance(data, Unset):
                return data
            return cast("None | str | Unset", data)

        strategy = _parse_strategy(d.pop("strategy", UNSET))

        def _parse_user_agent(data: object) -> None | str | Unset:
            if data is None:
                return data
            if isinstance(data, Unset):
                return data
            return cast("None | str | Unset", data)

        user_agent = _parse_user_agent(d.pop("user_agent", UNSET))

        crawl_config = cls(
            allow_subdomains=allow_subdomains,
            allowed_file_types=allowed_file_types,
            browser=browser,
            bypass=bypass,
            document_url_depth=document_url_depth,
            exclude_paths=exclude_paths,
            extract_page_content=extract_page_content,
            follow_document_urls=follow_document_urls,
            include_paths=include_paths,
            max_concurrent=max_concurrent,
            max_depth=max_depth,
            max_pages=max_pages,
            output_mode=output_mode,
            proxy=proxy,
            request_timeout_secs=request_timeout_secs,
            respect_robots_txt=respect_robots_txt,
            stay_on_domain=stay_on_domain,
            strategy=strategy,
            user_agent=user_agent,
        )

        crawl_config.additional_properties = d
        return crawl_config

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
