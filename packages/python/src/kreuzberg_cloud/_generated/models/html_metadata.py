from __future__ import annotations

from collections.abc import Mapping
from typing import TYPE_CHECKING, Any, TypeVar, cast

from attrs import define as _attrs_define
from attrs import field as _attrs_field
from typing_extensions import Self

from ..models.text_direction import TextDirection, check_text_direction
from ..types import UNSET, Unset

if TYPE_CHECKING:
    from ..models.header_metadata import HeaderMetadata
    from ..models.html_metadata_meta_tags import HtmlMetadataMetaTags
    from ..models.html_metadata_open_graph import HtmlMetadataOpenGraph
    from ..models.html_metadata_twitter_card import HtmlMetadataTwitterCard
    from ..models.image_metadata_type import ImageMetadataType
    from ..models.link_metadata import LinkMetadata
    from ..models.structured_data import StructuredData


T = TypeVar("T", bound="HtmlMetadata")


@_attrs_define
class HtmlMetadata:
    """HTML metadata extracted from HTML documents.

    Includes document-level metadata, Open Graph data, Twitter Card metadata,
    and extracted structural elements (headers, links, images, structured data).

    Attributes:
            author (None | str | Unset): Document author from `<meta name="author">` tag
            base_href (None | str | Unset): Base URL from `<base href="">` tag for resolving relative URLs
            canonical_url (None | str | Unset): Canonical URL from `<link rel="canonical">` tag
            description (None | str | Unset): Document description from `<meta name="description">` tag
            headers (list[HeaderMetadata] | Unset): Extracted header elements with hierarchy
            images (list[ImageMetadataType] | Unset): Extracted images with source and dimensions
            keywords (list[str] | Unset): Document keywords from `<meta name="keywords">` tag, split on commas
            language (None | str | Unset): Document language from `lang` attribute
            links (list[LinkMetadata] | Unset): Extracted hyperlinks with type classification
            meta_tags (HtmlMetadataMetaTags | Unset): Additional meta tags not covered by specific fields
                Keys are meta name/property attributes, values are content
            open_graph (HtmlMetadataOpenGraph | Unset): Open Graph metadata (og:* properties) for social media
                Keys like "title", "description", "image", "url", etc.
            structured_data (list[StructuredData] | Unset): Extracted structured data blocks
            text_direction (None | TextDirection | Unset):
            title (None | str | Unset): Document title from `<title>` tag
            twitter_card (HtmlMetadataTwitterCard | Unset): Twitter Card metadata (twitter:* properties)
                Keys like "card", "site", "creator", "title", "description", "image", etc.
    """

    author: None | str | Unset = UNSET
    base_href: None | str | Unset = UNSET
    canonical_url: None | str | Unset = UNSET
    description: None | str | Unset = UNSET
    headers: list[HeaderMetadata] | Unset = UNSET
    images: list[ImageMetadataType] | Unset = UNSET
    keywords: list[str] | Unset = UNSET
    language: None | str | Unset = UNSET
    links: list[LinkMetadata] | Unset = UNSET
    meta_tags: HtmlMetadataMetaTags | Unset = UNSET
    open_graph: HtmlMetadataOpenGraph | Unset = UNSET
    structured_data: list[StructuredData] | Unset = UNSET
    text_direction: None | TextDirection | Unset = UNSET
    title: None | str | Unset = UNSET
    twitter_card: HtmlMetadataTwitterCard | Unset = UNSET
    additional_properties: dict[str, Any] = _attrs_field(init=False, factory=dict)

    def to_dict(self) -> dict[str, Any]:
        author: None | str | Unset
        if isinstance(self.author, Unset):
            author = UNSET
        else:
            author = self.author

        base_href: None | str | Unset
        if isinstance(self.base_href, Unset):
            base_href = UNSET
        else:
            base_href = self.base_href

        canonical_url: None | str | Unset
        if isinstance(self.canonical_url, Unset):
            canonical_url = UNSET
        else:
            canonical_url = self.canonical_url

        description: None | str | Unset
        if isinstance(self.description, Unset):
            description = UNSET
        else:
            description = self.description

        headers: list[dict[str, Any]] | Unset = UNSET
        if not isinstance(self.headers, Unset):
            headers = []
            for headers_item_data in self.headers:
                headers_item = headers_item_data.to_dict()
                headers.append(headers_item)

        images: list[dict[str, Any]] | Unset = UNSET
        if not isinstance(self.images, Unset):
            images = []
            for images_item_data in self.images:
                images_item = images_item_data.to_dict()
                images.append(images_item)

        keywords: list[str] | Unset = UNSET
        if not isinstance(self.keywords, Unset):
            keywords = self.keywords

        language: None | str | Unset
        if isinstance(self.language, Unset):
            language = UNSET
        else:
            language = self.language

        links: list[dict[str, Any]] | Unset = UNSET
        if not isinstance(self.links, Unset):
            links = []
            for links_item_data in self.links:
                links_item = links_item_data.to_dict()
                links.append(links_item)

        meta_tags: dict[str, Any] | Unset = UNSET
        if not isinstance(self.meta_tags, Unset):
            meta_tags = self.meta_tags.to_dict()

        open_graph: dict[str, Any] | Unset = UNSET
        if not isinstance(self.open_graph, Unset):
            open_graph = self.open_graph.to_dict()

        structured_data: list[dict[str, Any]] | Unset = UNSET
        if not isinstance(self.structured_data, Unset):
            structured_data = []
            for structured_data_item_data in self.structured_data:
                structured_data_item = structured_data_item_data.to_dict()
                structured_data.append(structured_data_item)

        text_direction: None | str | Unset
        if isinstance(self.text_direction, Unset):
            text_direction = UNSET
        elif isinstance(self.text_direction, str):
            text_direction = self.text_direction
        else:
            text_direction = self.text_direction

        title: None | str | Unset
        if isinstance(self.title, Unset):
            title = UNSET
        else:
            title = self.title

        twitter_card: dict[str, Any] | Unset = UNSET
        if not isinstance(self.twitter_card, Unset):
            twitter_card = self.twitter_card.to_dict()

        field_dict: dict[str, Any] = {}
        field_dict.update(self.additional_properties)
        field_dict.update({})
        if author is not UNSET:
            field_dict["author"] = author
        if base_href is not UNSET:
            field_dict["base_href"] = base_href
        if canonical_url is not UNSET:
            field_dict["canonical_url"] = canonical_url
        if description is not UNSET:
            field_dict["description"] = description
        if headers is not UNSET:
            field_dict["headers"] = headers
        if images is not UNSET:
            field_dict["images"] = images
        if keywords is not UNSET:
            field_dict["keywords"] = keywords
        if language is not UNSET:
            field_dict["language"] = language
        if links is not UNSET:
            field_dict["links"] = links
        if meta_tags is not UNSET:
            field_dict["meta_tags"] = meta_tags
        if open_graph is not UNSET:
            field_dict["open_graph"] = open_graph
        if structured_data is not UNSET:
            field_dict["structured_data"] = structured_data
        if text_direction is not UNSET:
            field_dict["text_direction"] = text_direction
        if title is not UNSET:
            field_dict["title"] = title
        if twitter_card is not UNSET:
            field_dict["twitter_card"] = twitter_card

        return field_dict

    @classmethod
    def from_dict(cls, src_dict: Mapping[str, Any]) -> Self:
        from ..models.header_metadata import HeaderMetadata
        from ..models.html_metadata_meta_tags import HtmlMetadataMetaTags
        from ..models.html_metadata_open_graph import HtmlMetadataOpenGraph
        from ..models.html_metadata_twitter_card import HtmlMetadataTwitterCard
        from ..models.image_metadata_type import ImageMetadataType
        from ..models.link_metadata import LinkMetadata
        from ..models.structured_data import StructuredData

        d = dict(src_dict)

        def _parse_author(data: object) -> None | str | Unset:
            if data is None:
                return data
            if isinstance(data, Unset):
                return data
            return cast("None | str | Unset", data)

        author = _parse_author(d.pop("author", UNSET))

        def _parse_base_href(data: object) -> None | str | Unset:
            if data is None:
                return data
            if isinstance(data, Unset):
                return data
            return cast("None | str | Unset", data)

        base_href = _parse_base_href(d.pop("base_href", UNSET))

        def _parse_canonical_url(data: object) -> None | str | Unset:
            if data is None:
                return data
            if isinstance(data, Unset):
                return data
            return cast("None | str | Unset", data)

        canonical_url = _parse_canonical_url(d.pop("canonical_url", UNSET))

        def _parse_description(data: object) -> None | str | Unset:
            if data is None:
                return data
            if isinstance(data, Unset):
                return data
            return cast("None | str | Unset", data)

        description = _parse_description(d.pop("description", UNSET))

        _headers = d.pop("headers", UNSET)
        headers: list[HeaderMetadata] | Unset = UNSET
        if _headers is not UNSET:
            headers = []
            for headers_item_data in _headers:
                headers_item = HeaderMetadata.from_dict(headers_item_data)

                headers.append(headers_item)

        _images = d.pop("images", UNSET)
        images: list[ImageMetadataType] | Unset = UNSET
        if _images is not UNSET:
            images = []
            for images_item_data in _images:
                images_item = ImageMetadataType.from_dict(images_item_data)

                images.append(images_item)

        keywords = cast("list[str]", d.pop("keywords", UNSET))

        def _parse_language(data: object) -> None | str | Unset:
            if data is None:
                return data
            if isinstance(data, Unset):
                return data
            return cast("None | str | Unset", data)

        language = _parse_language(d.pop("language", UNSET))

        _links = d.pop("links", UNSET)
        links: list[LinkMetadata] | Unset = UNSET
        if _links is not UNSET:
            links = []
            for links_item_data in _links:
                links_item = LinkMetadata.from_dict(links_item_data)

                links.append(links_item)

        _meta_tags = d.pop("meta_tags", UNSET)
        meta_tags: HtmlMetadataMetaTags | Unset
        if isinstance(_meta_tags, Unset):
            meta_tags = UNSET
        else:
            meta_tags = HtmlMetadataMetaTags.from_dict(_meta_tags)

        _open_graph = d.pop("open_graph", UNSET)
        open_graph: HtmlMetadataOpenGraph | Unset
        if isinstance(_open_graph, Unset):
            open_graph = UNSET
        else:
            open_graph = HtmlMetadataOpenGraph.from_dict(_open_graph)

        _structured_data = d.pop("structured_data", UNSET)
        structured_data: list[StructuredData] | Unset = UNSET
        if _structured_data is not UNSET:
            structured_data = []
            for structured_data_item_data in _structured_data:
                structured_data_item = StructuredData.from_dict(structured_data_item_data)

                structured_data.append(structured_data_item)

        def _parse_text_direction(data: object) -> None | TextDirection | Unset:
            if data is None:
                return data
            if isinstance(data, Unset):
                return data
            try:
                if not isinstance(data, str):
                    raise TypeError
                text_direction_type_1 = check_text_direction(data)

                return text_direction_type_1
            except (TypeError, ValueError, AttributeError, KeyError):
                pass
            return cast("None | TextDirection | Unset", data)

        text_direction = _parse_text_direction(d.pop("text_direction", UNSET))

        def _parse_title(data: object) -> None | str | Unset:
            if data is None:
                return data
            if isinstance(data, Unset):
                return data
            return cast("None | str | Unset", data)

        title = _parse_title(d.pop("title", UNSET))

        _twitter_card = d.pop("twitter_card", UNSET)
        twitter_card: HtmlMetadataTwitterCard | Unset
        if isinstance(_twitter_card, Unset):
            twitter_card = UNSET
        else:
            twitter_card = HtmlMetadataTwitterCard.from_dict(_twitter_card)

        html_metadata = cls(
            author=author,
            base_href=base_href,
            canonical_url=canonical_url,
            description=description,
            headers=headers,
            images=images,
            keywords=keywords,
            language=language,
            links=links,
            meta_tags=meta_tags,
            open_graph=open_graph,
            structured_data=structured_data,
            text_direction=text_direction,
            title=title,
            twitter_card=twitter_card,
        )

        html_metadata.additional_properties = d
        return html_metadata

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
