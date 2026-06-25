from __future__ import annotations

from collections.abc import Mapping
from typing import TYPE_CHECKING, Any, TypeVar, cast

from attrs import define as _attrs_define
from attrs import field as _attrs_field
from typing_extensions import Self

from ..types import UNSET, Unset

if TYPE_CHECKING:
    from ..models.embedding_config import EmbeddingConfig


T = TypeVar("T", bound="ChunkingConfig")


@_attrs_define
class ChunkingConfig:
    """Text chunking configuration.

    Attributes:
        chunker_type (None | str | Unset): Chunker type: "text", "markdown", "yaml"
        embedding (EmbeddingConfig | None | Unset):
        max_characters (int | None | Unset): Maximum chunk size in characters
        overlap (int | None | Unset): Overlap between adjacent chunks in characters
        preset (None | str | Unset): Preset name (overrides other settings)
        trim (bool | None | Unset): Trim whitespace from chunk boundaries
    """

    chunker_type: None | str | Unset = UNSET
    embedding: EmbeddingConfig | None | Unset = UNSET
    max_characters: int | None | Unset = UNSET
    overlap: int | None | Unset = UNSET
    preset: None | str | Unset = UNSET
    trim: bool | None | Unset = UNSET
    additional_properties: dict[str, Any] = _attrs_field(init=False, factory=dict)

    def to_dict(self) -> dict[str, Any]:
        from ..models.embedding_config import EmbeddingConfig

        chunker_type: None | str | Unset
        if isinstance(self.chunker_type, Unset):
            chunker_type = UNSET
        else:
            chunker_type = self.chunker_type

        embedding: dict[str, Any] | None | Unset
        if isinstance(self.embedding, Unset):
            embedding = UNSET
        elif isinstance(self.embedding, EmbeddingConfig):
            embedding = self.embedding.to_dict()
        else:
            embedding = self.embedding

        max_characters: int | None | Unset
        if isinstance(self.max_characters, Unset):
            max_characters = UNSET
        else:
            max_characters = self.max_characters

        overlap: int | None | Unset
        if isinstance(self.overlap, Unset):
            overlap = UNSET
        else:
            overlap = self.overlap

        preset: None | str | Unset
        if isinstance(self.preset, Unset):
            preset = UNSET
        else:
            preset = self.preset

        trim: bool | None | Unset
        if isinstance(self.trim, Unset):
            trim = UNSET
        else:
            trim = self.trim

        field_dict: dict[str, Any] = {}
        field_dict.update(self.additional_properties)
        field_dict.update({})
        if chunker_type is not UNSET:
            field_dict["chunker_type"] = chunker_type
        if embedding is not UNSET:
            field_dict["embedding"] = embedding
        if max_characters is not UNSET:
            field_dict["max_characters"] = max_characters
        if overlap is not UNSET:
            field_dict["overlap"] = overlap
        if preset is not UNSET:
            field_dict["preset"] = preset
        if trim is not UNSET:
            field_dict["trim"] = trim

        return field_dict

    @classmethod
    def from_dict(cls, src_dict: Mapping[str, Any]) -> Self:
        from ..models.embedding_config import EmbeddingConfig

        d = dict(src_dict)

        def _parse_chunker_type(data: object) -> None | str | Unset:
            if data is None:
                return data
            if isinstance(data, Unset):
                return data
            return cast("None | str | Unset", data)

        chunker_type = _parse_chunker_type(d.pop("chunker_type", UNSET))

        def _parse_embedding(data: object) -> EmbeddingConfig | None | Unset:
            if data is None:
                return data
            if isinstance(data, Unset):
                return data
            try:
                if not isinstance(data, dict):
                    raise TypeError
                embedding_type_1 = EmbeddingConfig.from_dict(data)

                return embedding_type_1
            except (TypeError, ValueError, AttributeError, KeyError):
                pass
            return cast("EmbeddingConfig | None | Unset", data)

        embedding = _parse_embedding(d.pop("embedding", UNSET))

        def _parse_max_characters(data: object) -> int | None | Unset:
            if data is None:
                return data
            if isinstance(data, Unset):
                return data
            return cast("int | None | Unset", data)

        max_characters = _parse_max_characters(d.pop("max_characters", UNSET))

        def _parse_overlap(data: object) -> int | None | Unset:
            if data is None:
                return data
            if isinstance(data, Unset):
                return data
            return cast("int | None | Unset", data)

        overlap = _parse_overlap(d.pop("overlap", UNSET))

        def _parse_preset(data: object) -> None | str | Unset:
            if data is None:
                return data
            if isinstance(data, Unset):
                return data
            return cast("None | str | Unset", data)

        preset = _parse_preset(d.pop("preset", UNSET))

        def _parse_trim(data: object) -> bool | None | Unset:
            if data is None:
                return data
            if isinstance(data, Unset):
                return data
            return cast("bool | None | Unset", data)

        trim = _parse_trim(d.pop("trim", UNSET))

        chunking_config = cls(
            chunker_type=chunker_type,
            embedding=embedding,
            max_characters=max_characters,
            overlap=overlap,
            preset=preset,
            trim=trim,
        )

        chunking_config.additional_properties = d
        return chunking_config

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
