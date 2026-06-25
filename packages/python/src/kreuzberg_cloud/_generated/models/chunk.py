from __future__ import annotations

from collections.abc import Mapping
from typing import TYPE_CHECKING, Any, TypeVar, cast

from attrs import define as _attrs_define
from attrs import field as _attrs_field
from typing_extensions import Self

from ..models.chunk_type import ChunkType, check_chunk_type
from ..types import UNSET, Unset

if TYPE_CHECKING:
    from ..models.chunk_metadata import ChunkMetadata


T = TypeVar("T", bound="Chunk")


@_attrs_define
class Chunk:
    """A text chunk with optional embedding and metadata.

    Chunks are created when chunking is enabled in `ExtractionConfig`. Each chunk
    contains the text content, optional embedding vector (if embedding generation
    is configured), and metadata about its position in the document.

    Attributes:
            content (str): The text content of this chunk.
            metadata (ChunkMetadata): Metadata about a chunk's position in the original document.
            chunk_type (ChunkType | Unset): Semantic structural classification of a text chunk.

                Assigned by the heuristic classifier in `chunking::classifier`.
                Defaults to `Unknown` when no rule matches.
                Designed to be extended in future versions without breaking changes.
            embedding (list[float] | None | Unset): Optional embedding vector for this chunk.

                Only populated when `EmbeddingConfig` is provided in chunking configuration.
                The dimensionality depends on the chosen embedding model.
    """

    content: str
    metadata: ChunkMetadata
    chunk_type: ChunkType | Unset = UNSET
    embedding: list[float] | None | Unset = UNSET
    additional_properties: dict[str, Any] = _attrs_field(init=False, factory=dict)

    def to_dict(self) -> dict[str, Any]:
        content = self.content

        metadata = self.metadata.to_dict()

        chunk_type: str | Unset = UNSET
        if not isinstance(self.chunk_type, Unset):
            chunk_type = self.chunk_type

        embedding: list[float] | None | Unset
        if isinstance(self.embedding, Unset):
            embedding = UNSET
        elif isinstance(self.embedding, list):
            embedding = self.embedding

        else:
            embedding = self.embedding

        field_dict: dict[str, Any] = {}
        field_dict.update(self.additional_properties)
        field_dict.update(
            {
                "content": content,
                "metadata": metadata,
            }
        )
        if chunk_type is not UNSET:
            field_dict["chunk_type"] = chunk_type
        if embedding is not UNSET:
            field_dict["embedding"] = embedding

        return field_dict

    @classmethod
    def from_dict(cls, src_dict: Mapping[str, Any]) -> Self:
        from ..models.chunk_metadata import ChunkMetadata

        d = dict(src_dict)
        content = d.pop("content")

        metadata = ChunkMetadata.from_dict(d.pop("metadata"))

        _chunk_type = d.pop("chunk_type", UNSET)
        chunk_type: ChunkType | Unset
        if isinstance(_chunk_type, Unset):
            chunk_type = UNSET
        else:
            chunk_type = check_chunk_type(_chunk_type)

        def _parse_embedding(data: object) -> list[float] | None | Unset:
            if data is None:
                return data
            if isinstance(data, Unset):
                return data
            try:
                if not isinstance(data, list):
                    raise TypeError
                embedding_type_0 = cast("list[float]", data)

                return embedding_type_0
            except (TypeError, ValueError, AttributeError, KeyError):
                pass
            return cast("list[float] | None | Unset", data)

        embedding = _parse_embedding(d.pop("embedding", UNSET))

        chunk = cls(
            content=content,
            metadata=metadata,
            chunk_type=chunk_type,
            embedding=embedding,
        )

        chunk.additional_properties = d
        return chunk

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
