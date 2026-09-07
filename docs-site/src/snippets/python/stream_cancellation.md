---
targets: ["enterprise"]
side_effect: "safe"
requires: ["crawl-job"]
expect_stdout: "Subscription canceled"
---

```python title="Python"
import asyncio
import os
from contextlib import aclosing

from xberg_io_sdk import AsyncXbergClient


async def main():
    async with AsyncXbergClient(
        api_key=os.environ["XBERG_API_KEY"],
        base_url=os.environ["XBERG_BASE_URL"],
        target="enterprise",
        timeout=0.5,
    ) as client:

        async def consume():
            async with aclosing(client.stream_crawl_events(os.environ["XBERG_CRAWL_JOB_ID"])) as events:
                async for event in events:
                    print(event.kind)

        try:
            await asyncio.wait_for(consume(), timeout=float(os.environ.get("XBERG_STREAM_TIMEOUT_SECONDS", "30")))
        except asyncio.TimeoutError:
            print("Subscription canceled")


asyncio.run(main())
```
