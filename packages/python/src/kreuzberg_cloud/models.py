"""Public models that augment the auto-generated OpenAPI types.

The auto-generated types under :mod:`kreuzberg_cloud._generated.models` are
re-exported from :mod:`kreuzberg_cloud` under friendlier names. Anything in
this module is hand-written — typically because the relevant endpoint is
not part of the published OpenAPI spec yet.
"""

from __future__ import annotations

from dataclasses import dataclass
from typing import TYPE_CHECKING, Any

from dateutil.parser import isoparse

if TYPE_CHECKING:
    from collections.abc import Mapping
    from datetime import datetime


@dataclass(frozen=True, slots=True)
class SandboxKey:
    """Ephemeral API key returned by ``POST /v1/sandbox/key``.

    Used by :meth:`AsyncKreuzbergCloud.from_sandbox` to spin up a zero-friction
    client with a short-lived key (no signup required).
    """

    api_key: str
    expires_at: datetime
    pages_remaining: int

    @classmethod
    def from_dict(cls, payload: Mapping[str, Any]) -> SandboxKey:
        """Parse a sandbox-key API payload into a :class:`SandboxKey`."""
        return cls(
            api_key=str(payload["api_key"]),
            expires_at=isoparse(str(payload["expires_at"])),
            pages_remaining=int(payload["pages_remaining"]),
        )
