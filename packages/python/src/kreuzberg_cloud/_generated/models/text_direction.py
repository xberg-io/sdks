from typing import Literal, cast

TextDirection = Literal["auto", "ltr", "rtl"]

TEXT_DIRECTION_VALUES: set[TextDirection] = {"auto", "ltr", "rtl"}


def check_text_direction(value: str) -> TextDirection:
    if value in TEXT_DIRECTION_VALUES:
        return cast("TextDirection", value)
    raise TypeError(f"Unexpected value {value!r}. Expected one of {TEXT_DIRECTION_VALUES!r}")
