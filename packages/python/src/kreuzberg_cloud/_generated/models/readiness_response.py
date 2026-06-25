from __future__ import annotations

from collections.abc import Mapping
from typing import TYPE_CHECKING, Any, TypeVar

from attrs import define as _attrs_define
from attrs import field as _attrs_field
from typing_extensions import Self

if TYPE_CHECKING:
    from ..models.readiness_checks import ReadinessChecks


T = TypeVar("T", bound="ReadinessResponse")


@_attrs_define
class ReadinessResponse:
    """Readiness check response with dependency status

    Attributes:
        checks (ReadinessChecks): Individual dependency check results
        status (str): Overall readiness status Example: ready.
    """

    checks: ReadinessChecks
    status: str
    additional_properties: dict[str, Any] = _attrs_field(init=False, factory=dict)

    def to_dict(self) -> dict[str, Any]:
        checks = self.checks.to_dict()

        status = self.status

        field_dict: dict[str, Any] = {}
        field_dict.update(self.additional_properties)
        field_dict.update(
            {
                "checks": checks,
                "status": status,
            }
        )

        return field_dict

    @classmethod
    def from_dict(cls, src_dict: Mapping[str, Any]) -> Self:
        from ..models.readiness_checks import ReadinessChecks

        d = dict(src_dict)
        checks = ReadinessChecks.from_dict(d.pop("checks"))

        status = d.pop("status")

        readiness_response = cls(
            checks=checks,
            status=status,
        )

        readiness_response.additional_properties = d
        return readiness_response

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
