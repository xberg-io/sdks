from typing import Literal, cast

KeywordAlgorithm = Literal["rake", "yake"]

KEYWORD_ALGORITHM_VALUES: set[KeywordAlgorithm] = {"rake", "yake"}


def check_keyword_algorithm(value: str) -> KeywordAlgorithm:
    if value in KEYWORD_ALGORITHM_VALUES:
        return cast("KeywordAlgorithm", value)
    raise TypeError(f"Unexpected value {value!r}. Expected one of {KEYWORD_ALGORITHM_VALUES!r}")
