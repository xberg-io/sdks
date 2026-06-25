from __future__ import annotations

from collections.abc import Mapping
from typing import Any, TypeVar, cast

from attrs import define as _attrs_define
from attrs import field as _attrs_field
from typing_extensions import Self

from ..types import UNSET, Unset

T = TypeVar("T", bound="OcrQualityThresholds")


@_attrs_define
class OcrQualityThresholds:
    """Quality thresholds for OCR fallback decisions.

    Attributes:
        alnum_ws_ratio_threshold (float | None | Unset):
        critical_fragmented_word_ratio (float | None | Unset):
        max_fragmented_word_ratio (float | None | Unset):
        min_alnum_ratio (float | None | Unset):
        min_avg_word_length (float | None | Unset):
        min_consecutive_repeat_ratio (float | None | Unset):
        min_garbage_chars (int | None | Unset):
        min_meaningful_word_len (int | None | Unset):
        min_meaningful_words (int | None | Unset):
        min_non_whitespace_per_page (float | None | Unset):
        min_total_non_whitespace (int | None | Unset):
        min_words_for_avg_length_check (int | None | Unset):
        min_words_for_repeat_check (int | None | Unset):
        non_text_min_chars (int | None | Unset):
        pipeline_min_quality (float | None | Unset):
        substantive_min_chars (int | None | Unset):
    """

    alnum_ws_ratio_threshold: float | None | Unset = UNSET
    critical_fragmented_word_ratio: float | None | Unset = UNSET
    max_fragmented_word_ratio: float | None | Unset = UNSET
    min_alnum_ratio: float | None | Unset = UNSET
    min_avg_word_length: float | None | Unset = UNSET
    min_consecutive_repeat_ratio: float | None | Unset = UNSET
    min_garbage_chars: int | None | Unset = UNSET
    min_meaningful_word_len: int | None | Unset = UNSET
    min_meaningful_words: int | None | Unset = UNSET
    min_non_whitespace_per_page: float | None | Unset = UNSET
    min_total_non_whitespace: int | None | Unset = UNSET
    min_words_for_avg_length_check: int | None | Unset = UNSET
    min_words_for_repeat_check: int | None | Unset = UNSET
    non_text_min_chars: int | None | Unset = UNSET
    pipeline_min_quality: float | None | Unset = UNSET
    substantive_min_chars: int | None | Unset = UNSET
    additional_properties: dict[str, Any] = _attrs_field(init=False, factory=dict)

    def to_dict(self) -> dict[str, Any]:
        alnum_ws_ratio_threshold: float | None | Unset
        if isinstance(self.alnum_ws_ratio_threshold, Unset):
            alnum_ws_ratio_threshold = UNSET
        else:
            alnum_ws_ratio_threshold = self.alnum_ws_ratio_threshold

        critical_fragmented_word_ratio: float | None | Unset
        if isinstance(self.critical_fragmented_word_ratio, Unset):
            critical_fragmented_word_ratio = UNSET
        else:
            critical_fragmented_word_ratio = self.critical_fragmented_word_ratio

        max_fragmented_word_ratio: float | None | Unset
        if isinstance(self.max_fragmented_word_ratio, Unset):
            max_fragmented_word_ratio = UNSET
        else:
            max_fragmented_word_ratio = self.max_fragmented_word_ratio

        min_alnum_ratio: float | None | Unset
        if isinstance(self.min_alnum_ratio, Unset):
            min_alnum_ratio = UNSET
        else:
            min_alnum_ratio = self.min_alnum_ratio

        min_avg_word_length: float | None | Unset
        if isinstance(self.min_avg_word_length, Unset):
            min_avg_word_length = UNSET
        else:
            min_avg_word_length = self.min_avg_word_length

        min_consecutive_repeat_ratio: float | None | Unset
        if isinstance(self.min_consecutive_repeat_ratio, Unset):
            min_consecutive_repeat_ratio = UNSET
        else:
            min_consecutive_repeat_ratio = self.min_consecutive_repeat_ratio

        min_garbage_chars: int | None | Unset
        if isinstance(self.min_garbage_chars, Unset):
            min_garbage_chars = UNSET
        else:
            min_garbage_chars = self.min_garbage_chars

        min_meaningful_word_len: int | None | Unset
        if isinstance(self.min_meaningful_word_len, Unset):
            min_meaningful_word_len = UNSET
        else:
            min_meaningful_word_len = self.min_meaningful_word_len

        min_meaningful_words: int | None | Unset
        if isinstance(self.min_meaningful_words, Unset):
            min_meaningful_words = UNSET
        else:
            min_meaningful_words = self.min_meaningful_words

        min_non_whitespace_per_page: float | None | Unset
        if isinstance(self.min_non_whitespace_per_page, Unset):
            min_non_whitespace_per_page = UNSET
        else:
            min_non_whitespace_per_page = self.min_non_whitespace_per_page

        min_total_non_whitespace: int | None | Unset
        if isinstance(self.min_total_non_whitespace, Unset):
            min_total_non_whitespace = UNSET
        else:
            min_total_non_whitespace = self.min_total_non_whitespace

        min_words_for_avg_length_check: int | None | Unset
        if isinstance(self.min_words_for_avg_length_check, Unset):
            min_words_for_avg_length_check = UNSET
        else:
            min_words_for_avg_length_check = self.min_words_for_avg_length_check

        min_words_for_repeat_check: int | None | Unset
        if isinstance(self.min_words_for_repeat_check, Unset):
            min_words_for_repeat_check = UNSET
        else:
            min_words_for_repeat_check = self.min_words_for_repeat_check

        non_text_min_chars: int | None | Unset
        if isinstance(self.non_text_min_chars, Unset):
            non_text_min_chars = UNSET
        else:
            non_text_min_chars = self.non_text_min_chars

        pipeline_min_quality: float | None | Unset
        if isinstance(self.pipeline_min_quality, Unset):
            pipeline_min_quality = UNSET
        else:
            pipeline_min_quality = self.pipeline_min_quality

        substantive_min_chars: int | None | Unset
        if isinstance(self.substantive_min_chars, Unset):
            substantive_min_chars = UNSET
        else:
            substantive_min_chars = self.substantive_min_chars

        field_dict: dict[str, Any] = {}
        field_dict.update(self.additional_properties)
        field_dict.update({})
        if alnum_ws_ratio_threshold is not UNSET:
            field_dict["alnum_ws_ratio_threshold"] = alnum_ws_ratio_threshold
        if critical_fragmented_word_ratio is not UNSET:
            field_dict["critical_fragmented_word_ratio"] = critical_fragmented_word_ratio
        if max_fragmented_word_ratio is not UNSET:
            field_dict["max_fragmented_word_ratio"] = max_fragmented_word_ratio
        if min_alnum_ratio is not UNSET:
            field_dict["min_alnum_ratio"] = min_alnum_ratio
        if min_avg_word_length is not UNSET:
            field_dict["min_avg_word_length"] = min_avg_word_length
        if min_consecutive_repeat_ratio is not UNSET:
            field_dict["min_consecutive_repeat_ratio"] = min_consecutive_repeat_ratio
        if min_garbage_chars is not UNSET:
            field_dict["min_garbage_chars"] = min_garbage_chars
        if min_meaningful_word_len is not UNSET:
            field_dict["min_meaningful_word_len"] = min_meaningful_word_len
        if min_meaningful_words is not UNSET:
            field_dict["min_meaningful_words"] = min_meaningful_words
        if min_non_whitespace_per_page is not UNSET:
            field_dict["min_non_whitespace_per_page"] = min_non_whitespace_per_page
        if min_total_non_whitespace is not UNSET:
            field_dict["min_total_non_whitespace"] = min_total_non_whitespace
        if min_words_for_avg_length_check is not UNSET:
            field_dict["min_words_for_avg_length_check"] = min_words_for_avg_length_check
        if min_words_for_repeat_check is not UNSET:
            field_dict["min_words_for_repeat_check"] = min_words_for_repeat_check
        if non_text_min_chars is not UNSET:
            field_dict["non_text_min_chars"] = non_text_min_chars
        if pipeline_min_quality is not UNSET:
            field_dict["pipeline_min_quality"] = pipeline_min_quality
        if substantive_min_chars is not UNSET:
            field_dict["substantive_min_chars"] = substantive_min_chars

        return field_dict

    @classmethod
    def from_dict(cls, src_dict: Mapping[str, Any]) -> Self:
        d = dict(src_dict)

        def _parse_alnum_ws_ratio_threshold(data: object) -> float | None | Unset:
            if data is None:
                return data
            if isinstance(data, Unset):
                return data
            return cast("float | None | Unset", data)

        alnum_ws_ratio_threshold = _parse_alnum_ws_ratio_threshold(d.pop("alnum_ws_ratio_threshold", UNSET))

        def _parse_critical_fragmented_word_ratio(data: object) -> float | None | Unset:
            if data is None:
                return data
            if isinstance(data, Unset):
                return data
            return cast("float | None | Unset", data)

        critical_fragmented_word_ratio = _parse_critical_fragmented_word_ratio(
            d.pop("critical_fragmented_word_ratio", UNSET)
        )

        def _parse_max_fragmented_word_ratio(data: object) -> float | None | Unset:
            if data is None:
                return data
            if isinstance(data, Unset):
                return data
            return cast("float | None | Unset", data)

        max_fragmented_word_ratio = _parse_max_fragmented_word_ratio(d.pop("max_fragmented_word_ratio", UNSET))

        def _parse_min_alnum_ratio(data: object) -> float | None | Unset:
            if data is None:
                return data
            if isinstance(data, Unset):
                return data
            return cast("float | None | Unset", data)

        min_alnum_ratio = _parse_min_alnum_ratio(d.pop("min_alnum_ratio", UNSET))

        def _parse_min_avg_word_length(data: object) -> float | None | Unset:
            if data is None:
                return data
            if isinstance(data, Unset):
                return data
            return cast("float | None | Unset", data)

        min_avg_word_length = _parse_min_avg_word_length(d.pop("min_avg_word_length", UNSET))

        def _parse_min_consecutive_repeat_ratio(data: object) -> float | None | Unset:
            if data is None:
                return data
            if isinstance(data, Unset):
                return data
            return cast("float | None | Unset", data)

        min_consecutive_repeat_ratio = _parse_min_consecutive_repeat_ratio(d.pop("min_consecutive_repeat_ratio", UNSET))

        def _parse_min_garbage_chars(data: object) -> int | None | Unset:
            if data is None:
                return data
            if isinstance(data, Unset):
                return data
            return cast("int | None | Unset", data)

        min_garbage_chars = _parse_min_garbage_chars(d.pop("min_garbage_chars", UNSET))

        def _parse_min_meaningful_word_len(data: object) -> int | None | Unset:
            if data is None:
                return data
            if isinstance(data, Unset):
                return data
            return cast("int | None | Unset", data)

        min_meaningful_word_len = _parse_min_meaningful_word_len(d.pop("min_meaningful_word_len", UNSET))

        def _parse_min_meaningful_words(data: object) -> int | None | Unset:
            if data is None:
                return data
            if isinstance(data, Unset):
                return data
            return cast("int | None | Unset", data)

        min_meaningful_words = _parse_min_meaningful_words(d.pop("min_meaningful_words", UNSET))

        def _parse_min_non_whitespace_per_page(data: object) -> float | None | Unset:
            if data is None:
                return data
            if isinstance(data, Unset):
                return data
            return cast("float | None | Unset", data)

        min_non_whitespace_per_page = _parse_min_non_whitespace_per_page(d.pop("min_non_whitespace_per_page", UNSET))

        def _parse_min_total_non_whitespace(data: object) -> int | None | Unset:
            if data is None:
                return data
            if isinstance(data, Unset):
                return data
            return cast("int | None | Unset", data)

        min_total_non_whitespace = _parse_min_total_non_whitespace(d.pop("min_total_non_whitespace", UNSET))

        def _parse_min_words_for_avg_length_check(data: object) -> int | None | Unset:
            if data is None:
                return data
            if isinstance(data, Unset):
                return data
            return cast("int | None | Unset", data)

        min_words_for_avg_length_check = _parse_min_words_for_avg_length_check(
            d.pop("min_words_for_avg_length_check", UNSET)
        )

        def _parse_min_words_for_repeat_check(data: object) -> int | None | Unset:
            if data is None:
                return data
            if isinstance(data, Unset):
                return data
            return cast("int | None | Unset", data)

        min_words_for_repeat_check = _parse_min_words_for_repeat_check(d.pop("min_words_for_repeat_check", UNSET))

        def _parse_non_text_min_chars(data: object) -> int | None | Unset:
            if data is None:
                return data
            if isinstance(data, Unset):
                return data
            return cast("int | None | Unset", data)

        non_text_min_chars = _parse_non_text_min_chars(d.pop("non_text_min_chars", UNSET))

        def _parse_pipeline_min_quality(data: object) -> float | None | Unset:
            if data is None:
                return data
            if isinstance(data, Unset):
                return data
            return cast("float | None | Unset", data)

        pipeline_min_quality = _parse_pipeline_min_quality(d.pop("pipeline_min_quality", UNSET))

        def _parse_substantive_min_chars(data: object) -> int | None | Unset:
            if data is None:
                return data
            if isinstance(data, Unset):
                return data
            return cast("int | None | Unset", data)

        substantive_min_chars = _parse_substantive_min_chars(d.pop("substantive_min_chars", UNSET))

        ocr_quality_thresholds = cls(
            alnum_ws_ratio_threshold=alnum_ws_ratio_threshold,
            critical_fragmented_word_ratio=critical_fragmented_word_ratio,
            max_fragmented_word_ratio=max_fragmented_word_ratio,
            min_alnum_ratio=min_alnum_ratio,
            min_avg_word_length=min_avg_word_length,
            min_consecutive_repeat_ratio=min_consecutive_repeat_ratio,
            min_garbage_chars=min_garbage_chars,
            min_meaningful_word_len=min_meaningful_word_len,
            min_meaningful_words=min_meaningful_words,
            min_non_whitespace_per_page=min_non_whitespace_per_page,
            min_total_non_whitespace=min_total_non_whitespace,
            min_words_for_avg_length_check=min_words_for_avg_length_check,
            min_words_for_repeat_check=min_words_for_repeat_check,
            non_text_min_chars=non_text_min_chars,
            pipeline_min_quality=pipeline_min_quality,
            substantive_min_chars=substantive_min_chars,
        )

        ocr_quality_thresholds.additional_properties = d
        return ocr_quality_thresholds

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
