from typing import Literal, cast

StructuredDataType = Literal["json-ld", "microdata", "rdfa"]

STRUCTURED_DATA_TYPE_VALUES: set[StructuredDataType] = {"json-ld", "microdata", "rdfa"}


def check_structured_data_type(value: str) -> StructuredDataType:
    if value in STRUCTURED_DATA_TYPE_VALUES:
        return cast("StructuredDataType", value)
    raise TypeError(f"Unexpected value {value!r}. Expected one of {STRUCTURED_DATA_TYPE_VALUES!r}")
