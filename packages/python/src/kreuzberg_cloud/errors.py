"""Public exception hierarchy for the kreuzberg-cloud client."""

from __future__ import annotations

from typing import Any


class KreuzbergCloudError(Exception):
    """Base exception raised for any kreuzberg-cloud client error."""

    def __init__(self, message: str, *, status_code: int | None = None, payload: Any | None = None) -> None:
        super().__init__(message)
        self.status_code = status_code
        self.payload = payload
