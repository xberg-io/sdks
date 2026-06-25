from __future__ import annotations

from collections.abc import Mapping
from typing import TYPE_CHECKING, Any, TypeVar, cast

from attrs import define as _attrs_define
from attrs import field as _attrs_field
from typing_extensions import Self

from ..models.content_layer import ContentLayer, check_content_layer
from ..types import UNSET, Unset

if TYPE_CHECKING:
    from ..models.bounding_box import BoundingBox
    from ..models.document_node_attributes_type_0 import DocumentNodeAttributesType0
    from ..models.node_content_type_0 import NodeContentType0
    from ..models.node_content_type_1 import NodeContentType1
    from ..models.node_content_type_2 import NodeContentType2
    from ..models.node_content_type_3 import NodeContentType3
    from ..models.node_content_type_4 import NodeContentType4
    from ..models.node_content_type_5 import NodeContentType5
    from ..models.node_content_type_6 import NodeContentType6
    from ..models.node_content_type_7 import NodeContentType7
    from ..models.node_content_type_8 import NodeContentType8
    from ..models.node_content_type_9 import NodeContentType9
    from ..models.node_content_type_10 import NodeContentType10
    from ..models.node_content_type_11 import NodeContentType11
    from ..models.node_content_type_12 import NodeContentType12
    from ..models.node_content_type_13 import NodeContentType13
    from ..models.node_content_type_14 import NodeContentType14
    from ..models.node_content_type_15 import NodeContentType15
    from ..models.node_content_type_16 import NodeContentType16
    from ..models.node_content_type_17 import NodeContentType17
    from ..models.node_content_type_18 import NodeContentType18
    from ..models.node_content_type_19 import NodeContentType19
    from ..models.text_annotation import TextAnnotation


T = TypeVar("T", bound="DocumentNode")


@_attrs_define
class DocumentNode:
    """A single node in the document tree.

    Each node has deterministic `id`, typed `content`, optional `parent`/`children`
    for tree structure, and metadata like page number, bounding box, and content layer.

    Attributes:
            content (NodeContentType0 | NodeContentType1 | NodeContentType10 | NodeContentType11 | NodeContentType12 |
                NodeContentType13 | NodeContentType14 | NodeContentType15 | NodeContentType16 | NodeContentType17 |
                NodeContentType18 | NodeContentType19 | NodeContentType2 | NodeContentType3 | NodeContentType4 |
                NodeContentType5 | NodeContentType6 | NodeContentType7 | NodeContentType8 | NodeContentType9): Tagged enum for
                node content. Each variant carries only type-specific data.

                Uses `#[serde(tag = "node_type")]` to avoid "type" keyword collision in
                Go/Java/TypeScript bindings.
            id (str): Deterministic node identifier.

                Generated from a hash of `node_type + text + page`. The same document
                always produces the same IDs, making them useful for diffing, caching,
                and external references.
            annotations (list[TextAnnotation] | Unset): Inline annotations (formatting, links) on this node's text content.

                Only meaningful for text-carrying nodes; empty for containers.
            attributes (DocumentNodeAttributesType0 | None | Unset): Format-specific key-value attributes.

                Extensible bag for miscellaneous data without a dedicated typed field: CSS classes,
                LaTeX environment names, Excel cell formulas, slide layout names, etc.
            bbox (BoundingBox | None | Unset):
            children (list[int] | Unset): Child node indices in reading order.
            content_layer (ContentLayer | Unset): Content layer classification for document nodes.

                Replaces separate body/furniture arrays with per-node granularity.
            page (int | None | Unset): Page number where this node starts (1-indexed).
            page_end (int | None | Unset): Page number where this node ends (for multi-page tables/sections).
            parent (int | None | Unset):
    """

    content: (
        NodeContentType0
        | NodeContentType1
        | NodeContentType10
        | NodeContentType11
        | NodeContentType12
        | NodeContentType13
        | NodeContentType14
        | NodeContentType15
        | NodeContentType16
        | NodeContentType17
        | NodeContentType18
        | NodeContentType19
        | NodeContentType2
        | NodeContentType3
        | NodeContentType4
        | NodeContentType5
        | NodeContentType6
        | NodeContentType7
        | NodeContentType8
        | NodeContentType9
    )
    id: str
    annotations: list[TextAnnotation] | Unset = UNSET
    attributes: DocumentNodeAttributesType0 | None | Unset = UNSET
    bbox: BoundingBox | None | Unset = UNSET
    children: list[int] | Unset = UNSET
    content_layer: ContentLayer | Unset = UNSET
    page: int | None | Unset = UNSET
    page_end: int | None | Unset = UNSET
    parent: int | None | Unset = UNSET
    additional_properties: dict[str, Any] = _attrs_field(init=False, factory=dict)

    def to_dict(self) -> dict[str, Any]:
        from ..models.bounding_box import BoundingBox
        from ..models.document_node_attributes_type_0 import DocumentNodeAttributesType0
        from ..models.node_content_type_0 import NodeContentType0
        from ..models.node_content_type_1 import NodeContentType1
        from ..models.node_content_type_2 import NodeContentType2
        from ..models.node_content_type_3 import NodeContentType3
        from ..models.node_content_type_4 import NodeContentType4
        from ..models.node_content_type_5 import NodeContentType5
        from ..models.node_content_type_6 import NodeContentType6
        from ..models.node_content_type_7 import NodeContentType7
        from ..models.node_content_type_8 import NodeContentType8
        from ..models.node_content_type_9 import NodeContentType9
        from ..models.node_content_type_10 import NodeContentType10
        from ..models.node_content_type_11 import NodeContentType11
        from ..models.node_content_type_12 import NodeContentType12
        from ..models.node_content_type_13 import NodeContentType13
        from ..models.node_content_type_14 import NodeContentType14
        from ..models.node_content_type_15 import NodeContentType15
        from ..models.node_content_type_16 import NodeContentType16
        from ..models.node_content_type_17 import NodeContentType17
        from ..models.node_content_type_18 import NodeContentType18

        content: dict[str, Any]
        if (
            isinstance(self.content, NodeContentType0)
            or isinstance(self.content, NodeContentType1)
            or isinstance(self.content, NodeContentType2)
            or isinstance(self.content, NodeContentType3)
            or isinstance(self.content, NodeContentType4)
            or isinstance(self.content, NodeContentType5)
            or isinstance(self.content, NodeContentType6)
            or isinstance(self.content, NodeContentType7)
            or isinstance(self.content, NodeContentType8)
            or isinstance(self.content, NodeContentType9)
            or isinstance(self.content, NodeContentType10)
            or isinstance(self.content, NodeContentType11)
            or isinstance(self.content, NodeContentType12)
            or isinstance(self.content, NodeContentType13)
            or isinstance(self.content, NodeContentType14)
            or isinstance(self.content, NodeContentType15)
            or isinstance(self.content, NodeContentType16)
            or isinstance(self.content, NodeContentType17)
            or isinstance(self.content, NodeContentType18)
        ):
            content = self.content.to_dict()
        else:
            content = self.content.to_dict()

        id = self.id

        annotations: list[dict[str, Any]] | Unset = UNSET
        if not isinstance(self.annotations, Unset):
            annotations = []
            for annotations_item_data in self.annotations:
                annotations_item = annotations_item_data.to_dict()
                annotations.append(annotations_item)

        attributes: dict[str, Any] | None | Unset
        if isinstance(self.attributes, Unset):
            attributes = UNSET
        elif isinstance(self.attributes, DocumentNodeAttributesType0):
            attributes = self.attributes.to_dict()
        else:
            attributes = self.attributes

        bbox: dict[str, Any] | None | Unset
        if isinstance(self.bbox, Unset):
            bbox = UNSET
        elif isinstance(self.bbox, BoundingBox):
            bbox = self.bbox.to_dict()
        else:
            bbox = self.bbox

        children: list[int] | Unset = UNSET
        if not isinstance(self.children, Unset):
            children = self.children

        content_layer: str | Unset = UNSET
        if not isinstance(self.content_layer, Unset):
            content_layer = self.content_layer

        page: int | None | Unset
        if isinstance(self.page, Unset):
            page = UNSET
        else:
            page = self.page

        page_end: int | None | Unset
        if isinstance(self.page_end, Unset):
            page_end = UNSET
        else:
            page_end = self.page_end

        parent: int | None | Unset
        if isinstance(self.parent, Unset):
            parent = UNSET
        else:
            parent = self.parent

        field_dict: dict[str, Any] = {}
        field_dict.update(self.additional_properties)
        field_dict.update(
            {
                "content": content,
                "id": id,
            }
        )
        if annotations is not UNSET:
            field_dict["annotations"] = annotations
        if attributes is not UNSET:
            field_dict["attributes"] = attributes
        if bbox is not UNSET:
            field_dict["bbox"] = bbox
        if children is not UNSET:
            field_dict["children"] = children
        if content_layer is not UNSET:
            field_dict["content_layer"] = content_layer
        if page is not UNSET:
            field_dict["page"] = page
        if page_end is not UNSET:
            field_dict["page_end"] = page_end
        if parent is not UNSET:
            field_dict["parent"] = parent

        return field_dict

    @classmethod
    def from_dict(cls, src_dict: Mapping[str, Any]) -> Self:
        from ..models.bounding_box import BoundingBox
        from ..models.document_node_attributes_type_0 import DocumentNodeAttributesType0
        from ..models.node_content_type_0 import NodeContentType0
        from ..models.node_content_type_1 import NodeContentType1
        from ..models.node_content_type_2 import NodeContentType2
        from ..models.node_content_type_3 import NodeContentType3
        from ..models.node_content_type_4 import NodeContentType4
        from ..models.node_content_type_5 import NodeContentType5
        from ..models.node_content_type_6 import NodeContentType6
        from ..models.node_content_type_7 import NodeContentType7
        from ..models.node_content_type_8 import NodeContentType8
        from ..models.node_content_type_9 import NodeContentType9
        from ..models.node_content_type_10 import NodeContentType10
        from ..models.node_content_type_11 import NodeContentType11
        from ..models.node_content_type_12 import NodeContentType12
        from ..models.node_content_type_13 import NodeContentType13
        from ..models.node_content_type_14 import NodeContentType14
        from ..models.node_content_type_15 import NodeContentType15
        from ..models.node_content_type_16 import NodeContentType16
        from ..models.node_content_type_17 import NodeContentType17
        from ..models.node_content_type_18 import NodeContentType18
        from ..models.node_content_type_19 import NodeContentType19
        from ..models.text_annotation import TextAnnotation

        d = dict(src_dict)

        def _parse_content(
            data: object,
        ) -> (
            NodeContentType0
            | NodeContentType1
            | NodeContentType10
            | NodeContentType11
            | NodeContentType12
            | NodeContentType13
            | NodeContentType14
            | NodeContentType15
            | NodeContentType16
            | NodeContentType17
            | NodeContentType18
            | NodeContentType19
            | NodeContentType2
            | NodeContentType3
            | NodeContentType4
            | NodeContentType5
            | NodeContentType6
            | NodeContentType7
            | NodeContentType8
            | NodeContentType9
        ):
            try:
                if not isinstance(data, dict):
                    raise TypeError
                componentsschemas_node_content_type_0 = NodeContentType0.from_dict(data)

                return componentsschemas_node_content_type_0
            except (TypeError, ValueError, AttributeError, KeyError):
                pass
            try:
                if not isinstance(data, dict):
                    raise TypeError
                componentsschemas_node_content_type_1 = NodeContentType1.from_dict(data)

                return componentsschemas_node_content_type_1
            except (TypeError, ValueError, AttributeError, KeyError):
                pass
            try:
                if not isinstance(data, dict):
                    raise TypeError
                componentsschemas_node_content_type_2 = NodeContentType2.from_dict(data)

                return componentsschemas_node_content_type_2
            except (TypeError, ValueError, AttributeError, KeyError):
                pass
            try:
                if not isinstance(data, dict):
                    raise TypeError
                componentsschemas_node_content_type_3 = NodeContentType3.from_dict(data)

                return componentsschemas_node_content_type_3
            except (TypeError, ValueError, AttributeError, KeyError):
                pass
            try:
                if not isinstance(data, dict):
                    raise TypeError
                componentsschemas_node_content_type_4 = NodeContentType4.from_dict(data)

                return componentsschemas_node_content_type_4
            except (TypeError, ValueError, AttributeError, KeyError):
                pass
            try:
                if not isinstance(data, dict):
                    raise TypeError
                componentsschemas_node_content_type_5 = NodeContentType5.from_dict(data)

                return componentsschemas_node_content_type_5
            except (TypeError, ValueError, AttributeError, KeyError):
                pass
            try:
                if not isinstance(data, dict):
                    raise TypeError
                componentsschemas_node_content_type_6 = NodeContentType6.from_dict(data)

                return componentsschemas_node_content_type_6
            except (TypeError, ValueError, AttributeError, KeyError):
                pass
            try:
                if not isinstance(data, dict):
                    raise TypeError
                componentsschemas_node_content_type_7 = NodeContentType7.from_dict(data)

                return componentsschemas_node_content_type_7
            except (TypeError, ValueError, AttributeError, KeyError):
                pass
            try:
                if not isinstance(data, dict):
                    raise TypeError
                componentsschemas_node_content_type_8 = NodeContentType8.from_dict(data)

                return componentsschemas_node_content_type_8
            except (TypeError, ValueError, AttributeError, KeyError):
                pass
            try:
                if not isinstance(data, dict):
                    raise TypeError
                componentsschemas_node_content_type_9 = NodeContentType9.from_dict(data)

                return componentsschemas_node_content_type_9
            except (TypeError, ValueError, AttributeError, KeyError):
                pass
            try:
                if not isinstance(data, dict):
                    raise TypeError
                componentsschemas_node_content_type_10 = NodeContentType10.from_dict(data)

                return componentsschemas_node_content_type_10
            except (TypeError, ValueError, AttributeError, KeyError):
                pass
            try:
                if not isinstance(data, dict):
                    raise TypeError
                componentsschemas_node_content_type_11 = NodeContentType11.from_dict(data)

                return componentsschemas_node_content_type_11
            except (TypeError, ValueError, AttributeError, KeyError):
                pass
            try:
                if not isinstance(data, dict):
                    raise TypeError
                componentsschemas_node_content_type_12 = NodeContentType12.from_dict(data)

                return componentsschemas_node_content_type_12
            except (TypeError, ValueError, AttributeError, KeyError):
                pass
            try:
                if not isinstance(data, dict):
                    raise TypeError
                componentsschemas_node_content_type_13 = NodeContentType13.from_dict(data)

                return componentsschemas_node_content_type_13
            except (TypeError, ValueError, AttributeError, KeyError):
                pass
            try:
                if not isinstance(data, dict):
                    raise TypeError
                componentsschemas_node_content_type_14 = NodeContentType14.from_dict(data)

                return componentsschemas_node_content_type_14
            except (TypeError, ValueError, AttributeError, KeyError):
                pass
            try:
                if not isinstance(data, dict):
                    raise TypeError
                componentsschemas_node_content_type_15 = NodeContentType15.from_dict(data)

                return componentsschemas_node_content_type_15
            except (TypeError, ValueError, AttributeError, KeyError):
                pass
            try:
                if not isinstance(data, dict):
                    raise TypeError
                componentsschemas_node_content_type_16 = NodeContentType16.from_dict(data)

                return componentsschemas_node_content_type_16
            except (TypeError, ValueError, AttributeError, KeyError):
                pass
            try:
                if not isinstance(data, dict):
                    raise TypeError
                componentsschemas_node_content_type_17 = NodeContentType17.from_dict(data)

                return componentsschemas_node_content_type_17
            except (TypeError, ValueError, AttributeError, KeyError):
                pass
            try:
                if not isinstance(data, dict):
                    raise TypeError
                componentsschemas_node_content_type_18 = NodeContentType18.from_dict(data)

                return componentsschemas_node_content_type_18
            except (TypeError, ValueError, AttributeError, KeyError):
                pass
            if not isinstance(data, dict):
                raise TypeError
            componentsschemas_node_content_type_19 = NodeContentType19.from_dict(data)

            return componentsschemas_node_content_type_19

        content = _parse_content(d.pop("content"))

        id = d.pop("id")

        _annotations = d.pop("annotations", UNSET)
        annotations: list[TextAnnotation] | Unset = UNSET
        if _annotations is not UNSET:
            annotations = []
            for annotations_item_data in _annotations:
                annotations_item = TextAnnotation.from_dict(annotations_item_data)

                annotations.append(annotations_item)

        def _parse_attributes(data: object) -> DocumentNodeAttributesType0 | None | Unset:
            if data is None:
                return data
            if isinstance(data, Unset):
                return data
            try:
                if not isinstance(data, dict):
                    raise TypeError
                attributes_type_0 = DocumentNodeAttributesType0.from_dict(data)

                return attributes_type_0
            except (TypeError, ValueError, AttributeError, KeyError):
                pass
            return cast("DocumentNodeAttributesType0 | None | Unset", data)

        attributes = _parse_attributes(d.pop("attributes", UNSET))

        def _parse_bbox(data: object) -> BoundingBox | None | Unset:
            if data is None:
                return data
            if isinstance(data, Unset):
                return data
            try:
                if not isinstance(data, dict):
                    raise TypeError
                bbox_type_1 = BoundingBox.from_dict(data)

                return bbox_type_1
            except (TypeError, ValueError, AttributeError, KeyError):
                pass
            return cast("BoundingBox | None | Unset", data)

        bbox = _parse_bbox(d.pop("bbox", UNSET))

        children = cast("list[int]", d.pop("children", UNSET))

        _content_layer = d.pop("content_layer", UNSET)
        content_layer: ContentLayer | Unset
        if isinstance(_content_layer, Unset):
            content_layer = UNSET
        else:
            content_layer = check_content_layer(_content_layer)

        def _parse_page(data: object) -> int | None | Unset:
            if data is None:
                return data
            if isinstance(data, Unset):
                return data
            return cast("int | None | Unset", data)

        page = _parse_page(d.pop("page", UNSET))

        def _parse_page_end(data: object) -> int | None | Unset:
            if data is None:
                return data
            if isinstance(data, Unset):
                return data
            return cast("int | None | Unset", data)

        page_end = _parse_page_end(d.pop("page_end", UNSET))

        def _parse_parent(data: object) -> int | None | Unset:
            if data is None:
                return data
            if isinstance(data, Unset):
                return data
            return cast("int | None | Unset", data)

        parent = _parse_parent(d.pop("parent", UNSET))

        document_node = cls(
            content=content,
            id=id,
            annotations=annotations,
            attributes=attributes,
            bbox=bbox,
            children=children,
            content_layer=content_layer,
            page=page,
            page_end=page_end,
            parent=parent,
        )

        document_node.additional_properties = d
        return document_node

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
