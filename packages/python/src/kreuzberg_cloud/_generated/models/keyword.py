from __future__ import annotations

from collections.abc import Mapping
from typing import Any, TypeVar, cast

from attrs import define as _attrs_define
from attrs import field as _attrs_field
from typing_extensions import Self

from ..models.keyword_algorithm import KeywordAlgorithm, check_keyword_algorithm
from ..types import UNSET, Unset

T = TypeVar("T", bound="Keyword")


@_attrs_define
class Keyword:
    """Extracted keyword with metadata.

    Attributes:
        algorithm (KeywordAlgorithm): Keyword algorithm selection.
        score (float): Relevance score (higher is better, algorithm-specific range).
        text (str): The keyword text.
        positions (list[int] | None | Unset): Optional positions where keyword appears in text (character offsets).
    """

    algorithm: KeywordAlgorithm
    score: float
    text: str
    positions: list[int] | None | Unset = UNSET
    additional_properties: dict[str, Any] = _attrs_field(init=False, factory=dict)

    def to_dict(self) -> dict[str, Any]:
        algorithm: str = self.algorithm

        score = self.score

        text = self.text

        positions: list[int] | None | Unset
        if isinstance(self.positions, Unset):
            positions = UNSET
        elif isinstance(self.positions, list):
            positions = self.positions

        else:
            positions = self.positions

        field_dict: dict[str, Any] = {}
        field_dict.update(self.additional_properties)
        field_dict.update(
            {
                "algorithm": algorithm,
                "score": score,
                "text": text,
            }
        )
        if positions is not UNSET:
            field_dict["positions"] = positions

        return field_dict

    @classmethod
    def from_dict(cls, src_dict: Mapping[str, Any]) -> Self:
        d = dict(src_dict)
        algorithm = check_keyword_algorithm(d.pop("algorithm"))

        score = d.pop("score")

        text = d.pop("text")

        def _parse_positions(data: object) -> list[int] | None | Unset:
            if data is None:
                return data
            if isinstance(data, Unset):
                return data
            try:
                if not isinstance(data, list):
                    raise TypeError
                positions_type_0 = cast("list[int]", data)

                return positions_type_0
            except (TypeError, ValueError, AttributeError, KeyError):
                pass
            return cast("list[int] | None | Unset", data)

        positions = _parse_positions(d.pop("positions", UNSET))

        keyword = cls(
            algorithm=algorithm,
            score=score,
            text=text,
            positions=positions,
        )

        keyword.additional_properties = d
        return keyword

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
