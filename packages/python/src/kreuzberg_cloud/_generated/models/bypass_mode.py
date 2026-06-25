from typing import Literal, cast

BypassMode = Literal["byo", "managed"]

BYPASS_MODE_VALUES: set[BypassMode] = {"byo", "managed"}


def check_bypass_mode(value: str) -> BypassMode:
    if value in BYPASS_MODE_VALUES:
        return cast("BypassMode", value)
    raise TypeError(f"Unexpected value {value!r}. Expected one of {BYPASS_MODE_VALUES!r}")
