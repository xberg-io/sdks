---
targets: ["pro", "enterprise"]
side_effect: "safe"
requires: ["document"]
expect_stdout: "Extraction verified"
---

```python title="Python"
import os
from pathlib import Path

from xberg_io_sdk import XbergClient

with XbergClient(
    api_key=os.environ["XBERG_API_KEY"],
    base_url=os.environ["XBERG_BASE_URL"],
    target=os.environ["XBERG_TARGET"],
) as client:
    job = client.extract_and_wait(file=Path(os.environ["XBERG_DOCUMENT"]))
    result = client.get_job_result(str(job.id))
    if not result.results or "Xberg SDK snippet fixture" not in result.results[0].content:
        raise RuntimeError("The extracted document did not contain the expected text")
    print("Extraction verified")
```
