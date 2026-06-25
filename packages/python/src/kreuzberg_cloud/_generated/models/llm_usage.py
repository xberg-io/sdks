from __future__ import annotations

from collections.abc import Mapping
from typing import Any, TypeVar, cast

from attrs import define as _attrs_define
from attrs import field as _attrs_field
from typing_extensions import Self

from ..types import UNSET, Unset

T = TypeVar("T", bound="LlmUsage")


@_attrs_define
class LlmUsage:
    """Token usage and cost data for a single LLM call made during extraction.

    Populated when VLM OCR, structured extraction, or LLM-based embeddings
    are used. Multiple entries may be present when multiple LLM calls occur
    within one extraction (e.g. VLM OCR + structured extraction).

    Attributes:
            model (str): The LLM model identifier (e.g. "openai/gpt-4o", "anthropic/claude-sonnet-4-20250514").
            source (str): The pipeline stage that triggered this LLM call
                (e.g. "vlm_ocr", "structured_extraction", "embeddings").
            estimated_cost (float | None | Unset): Estimated cost in USD based on the provider's published pricing.
            finish_reason (None | str | Unset): Why the model stopped generating (e.g. "stop", "length", "content_filter").
            input_tokens (int | None | Unset): Number of input/prompt tokens consumed.
            output_tokens (int | None | Unset): Number of output/completion tokens generated.
            total_tokens (int | None | Unset): Total tokens (input + output).
    """

    model: str
    source: str
    estimated_cost: float | None | Unset = UNSET
    finish_reason: None | str | Unset = UNSET
    input_tokens: int | None | Unset = UNSET
    output_tokens: int | None | Unset = UNSET
    total_tokens: int | None | Unset = UNSET
    additional_properties: dict[str, Any] = _attrs_field(init=False, factory=dict)

    def to_dict(self) -> dict[str, Any]:
        model = self.model

        source = self.source

        estimated_cost: float | None | Unset
        if isinstance(self.estimated_cost, Unset):
            estimated_cost = UNSET
        else:
            estimated_cost = self.estimated_cost

        finish_reason: None | str | Unset
        if isinstance(self.finish_reason, Unset):
            finish_reason = UNSET
        else:
            finish_reason = self.finish_reason

        input_tokens: int | None | Unset
        if isinstance(self.input_tokens, Unset):
            input_tokens = UNSET
        else:
            input_tokens = self.input_tokens

        output_tokens: int | None | Unset
        if isinstance(self.output_tokens, Unset):
            output_tokens = UNSET
        else:
            output_tokens = self.output_tokens

        total_tokens: int | None | Unset
        if isinstance(self.total_tokens, Unset):
            total_tokens = UNSET
        else:
            total_tokens = self.total_tokens

        field_dict: dict[str, Any] = {}
        field_dict.update(self.additional_properties)
        field_dict.update(
            {
                "model": model,
                "source": source,
            }
        )
        if estimated_cost is not UNSET:
            field_dict["estimated_cost"] = estimated_cost
        if finish_reason is not UNSET:
            field_dict["finish_reason"] = finish_reason
        if input_tokens is not UNSET:
            field_dict["input_tokens"] = input_tokens
        if output_tokens is not UNSET:
            field_dict["output_tokens"] = output_tokens
        if total_tokens is not UNSET:
            field_dict["total_tokens"] = total_tokens

        return field_dict

    @classmethod
    def from_dict(cls, src_dict: Mapping[str, Any]) -> Self:
        d = dict(src_dict)
        model = d.pop("model")

        source = d.pop("source")

        def _parse_estimated_cost(data: object) -> float | None | Unset:
            if data is None:
                return data
            if isinstance(data, Unset):
                return data
            return cast("float | None | Unset", data)

        estimated_cost = _parse_estimated_cost(d.pop("estimated_cost", UNSET))

        def _parse_finish_reason(data: object) -> None | str | Unset:
            if data is None:
                return data
            if isinstance(data, Unset):
                return data
            return cast("None | str | Unset", data)

        finish_reason = _parse_finish_reason(d.pop("finish_reason", UNSET))

        def _parse_input_tokens(data: object) -> int | None | Unset:
            if data is None:
                return data
            if isinstance(data, Unset):
                return data
            return cast("int | None | Unset", data)

        input_tokens = _parse_input_tokens(d.pop("input_tokens", UNSET))

        def _parse_output_tokens(data: object) -> int | None | Unset:
            if data is None:
                return data
            if isinstance(data, Unset):
                return data
            return cast("int | None | Unset", data)

        output_tokens = _parse_output_tokens(d.pop("output_tokens", UNSET))

        def _parse_total_tokens(data: object) -> int | None | Unset:
            if data is None:
                return data
            if isinstance(data, Unset):
                return data
            return cast("int | None | Unset", data)

        total_tokens = _parse_total_tokens(d.pop("total_tokens", UNSET))

        llm_usage = cls(
            model=model,
            source=source,
            estimated_cost=estimated_cost,
            finish_reason=finish_reason,
            input_tokens=input_tokens,
            output_tokens=output_tokens,
            total_tokens=total_tokens,
        )

        llm_usage.additional_properties = d
        return llm_usage

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
