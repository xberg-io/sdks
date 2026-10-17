---
targets: ["pro"]
side_effect: "safe"
requires: []
expect_stdout: "Pro health verified"
---

```python title="Python"
import json
import os

from xberg_io_sdk import XbergClient

with XbergClient(base_url=os.environ["XBERG_BASE_URL"], target="pro", retries=0) as client:
    health = client.pro_healthz()
    snapshot = {
        "status": health.status,
        "tier": health.tier,
        "license": {"state": health.license_.state},
        "rag": {"enabled": health.rag.enabled},
        "auto_tune": {"enabled": health.auto_tune.enabled},
    }
    if snapshot["status"] != "ok":
        raise ValueError("Pro health status mismatch")
    if snapshot["tier"] != "pro" or snapshot["license"]["state"] not in {
        "licensed", "grace", "expired", "invalid", "unlicensed"
    }:
        raise ValueError("Pro health tier or license state mismatch")
    if type(snapshot["rag"]["enabled"]) is not bool or type(snapshot["auto_tune"]["enabled"]) is not bool:
        raise ValueError("Pro health capabilities must be booleans")
    if os.environ.get("XBERG_EXPECTED_PRO_HEALTH_JSON"):
        if snapshot != json.loads(os.environ["XBERG_EXPECTED_PRO_HEALTH_JSON"]):
            raise ValueError("Pro health configured values mismatch")
    print("Pro health verified")
```

```python title="Python async"
import asyncio
import json
import os

from xberg_io_sdk import AsyncXbergClient

async def main():
    async with AsyncXbergClient(base_url=os.environ["XBERG_BASE_URL"], target="pro", retries=0) as client:
        health = await client.pro_healthz()
        snapshot = {
            "status": health.status,
            "tier": health.tier,
            "license": {"state": health.license_.state},
            "rag": {"enabled": health.rag.enabled},
            "auto_tune": {"enabled": health.auto_tune.enabled},
        }
        if snapshot["status"] != "ok":
            raise ValueError("Pro health status mismatch")
        if snapshot["tier"] != "pro" or snapshot["license"]["state"] not in {
            "licensed", "grace", "expired", "invalid", "unlicensed"
        }:
            raise ValueError("Pro health tier or license state mismatch")
        if type(snapshot["rag"]["enabled"]) is not bool or type(snapshot["auto_tune"]["enabled"]) is not bool:
            raise ValueError("Pro health capabilities must be booleans")
        if os.environ.get("XBERG_EXPECTED_PRO_HEALTH_JSON"):
            if snapshot != json.loads(os.environ["XBERG_EXPECTED_PRO_HEALTH_JSON"]):
                raise ValueError("Pro health configured values mismatch")
        print("Pro health verified")


asyncio.run(main())
```
