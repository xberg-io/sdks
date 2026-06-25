from typing import Literal, cast

ChunkType = Literal[
    "code_block",
    "definitions",
    "diagram",
    "formula",
    "heading",
    "image",
    "operative_clause",
    "org_chart",
    "party_list",
    "schedule",
    "signature_block",
    "table_like",
    "unknown",
]

CHUNK_TYPE_VALUES: set[ChunkType] = {
    "code_block",
    "definitions",
    "diagram",
    "formula",
    "heading",
    "image",
    "operative_clause",
    "org_chart",
    "party_list",
    "schedule",
    "signature_block",
    "table_like",
    "unknown",
}


def check_chunk_type(value: str) -> ChunkType:
    if value in CHUNK_TYPE_VALUES:
        return cast("ChunkType", value)
    raise TypeError(f"Unexpected value {value!r}. Expected one of {CHUNK_TYPE_VALUES!r}")
