from __future__ import annotations

from collections.abc import Mapping
from typing import Any, TypeVar, cast

from attrs import define as _attrs_define
from attrs import field as _attrs_field
from typing_extensions import Self

from ..types import UNSET, Unset

T = TypeVar("T", bound="EmbeddingConfig")


@_attrs_define
class EmbeddingConfig:
    """Embedding generation configuration for chunks.

    Attributes:
        batch_size (int | None | Unset): Batch size for embedding generation
        model (Any | Unset): Model configuration (flexible JSON: {"type":"preset","name":"balanced"})
        normalize (bool | None | Unset): Normalize embedding vectors
        show_download_progress (bool | None | Unset): Show model download progress
    """

    batch_size: int | None | Unset = UNSET
    model: Any | Unset = UNSET
    normalize: bool | None | Unset = UNSET
    show_download_progress: bool | None | Unset = UNSET
    additional_properties: dict[str, Any] = _attrs_field(init=False, factory=dict)

    def to_dict(self) -> dict[str, Any]:
        batch_size: int | None | Unset
        if isinstance(self.batch_size, Unset):
            batch_size = UNSET
        else:
            batch_size = self.batch_size

        model = self.model

        normalize: bool | None | Unset
        if isinstance(self.normalize, Unset):
            normalize = UNSET
        else:
            normalize = self.normalize

        show_download_progress: bool | None | Unset
        if isinstance(self.show_download_progress, Unset):
            show_download_progress = UNSET
        else:
            show_download_progress = self.show_download_progress

        field_dict: dict[str, Any] = {}
        field_dict.update(self.additional_properties)
        field_dict.update({})
        if batch_size is not UNSET:
            field_dict["batch_size"] = batch_size
        if model is not UNSET:
            field_dict["model"] = model
        if normalize is not UNSET:
            field_dict["normalize"] = normalize
        if show_download_progress is not UNSET:
            field_dict["show_download_progress"] = show_download_progress

        return field_dict

    @classmethod
    def from_dict(cls, src_dict: Mapping[str, Any]) -> Self:
        d = dict(src_dict)

        def _parse_batch_size(data: object) -> int | None | Unset:
            if data is None:
                return data
            if isinstance(data, Unset):
                return data
            return cast("int | None | Unset", data)

        batch_size = _parse_batch_size(d.pop("batch_size", UNSET))

        model = d.pop("model", UNSET)

        def _parse_normalize(data: object) -> bool | None | Unset:
            if data is None:
                return data
            if isinstance(data, Unset):
                return data
            return cast("bool | None | Unset", data)

        normalize = _parse_normalize(d.pop("normalize", UNSET))

        def _parse_show_download_progress(data: object) -> bool | None | Unset:
            if data is None:
                return data
            if isinstance(data, Unset):
                return data
            return cast("bool | None | Unset", data)

        show_download_progress = _parse_show_download_progress(d.pop("show_download_progress", UNSET))

        embedding_config = cls(
            batch_size=batch_size,
            model=model,
            normalize=normalize,
            show_download_progress=show_download_progress,
        )

        embedding_config.additional_properties = d
        return embedding_config

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
