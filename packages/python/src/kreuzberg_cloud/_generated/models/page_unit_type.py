from typing import Literal, cast

PageUnitType = Literal["page", "sheet", "slide"]

PAGE_UNIT_TYPE_VALUES: set[PageUnitType] = {"page", "sheet", "slide"}


def check_page_unit_type(value: str) -> PageUnitType:
    if value in PAGE_UNIT_TYPE_VALUES:
        return cast("PageUnitType", value)
    raise TypeError(f"Unexpected value {value!r}. Expected one of {PAGE_UNIT_TYPE_VALUES!r}")
