from typing import Literal, cast

UriKind = Literal["anchor", "citation", "email", "hyperlink", "image", "reference"]

URI_KIND_VALUES: set[UriKind] = {"anchor", "citation", "email", "hyperlink", "image", "reference"}


def check_uri_kind(value: str) -> UriKind:
    if value in URI_KIND_VALUES:
        return cast("UriKind", value)
    raise TypeError(f"Unexpected value {value!r}. Expected one of {URI_KIND_VALUES!r}")
