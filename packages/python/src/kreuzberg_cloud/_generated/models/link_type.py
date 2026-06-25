from typing import Literal, cast

LinkType = Literal["anchor", "email", "external", "internal", "other", "phone"]

LINK_TYPE_VALUES: set[LinkType] = {"anchor", "email", "external", "internal", "other", "phone"}


def check_link_type(value: str) -> LinkType:
    if value in LINK_TYPE_VALUES:
        return cast("LinkType", value)
    raise TypeError(f"Unexpected value {value!r}. Expected one of {LINK_TYPE_VALUES!r}")
