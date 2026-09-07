---
targets: ["enterprise"]
side_effect: "scratch-project"
requires: []
expect_stdout: "Project lifecycle verified"
---

```python title="Python"
import os
from uuid import uuid4

from xberg_io_sdk import XbergClient

with XbergClient(
    api_key=os.environ["XBERG_API_KEY"],
    base_url=os.environ["XBERG_BASE_URL"],
    control_plane_base_url=os.environ["XBERG_CONTROL_PLANE_URL"],
    control_plane_token=os.environ["XBERG_CONTROL_PLANE_TOKEN"],
    target="enterprise",
) as client:
    project = client.backend_create_project({"name": f"sdk-snippet-{uuid4()}"})
    try:
        key = client.backend_create_api_key(str(project.id), {"name": "snippet-key", "scope": "write"})
        try:
            if not key.key:
                raise RuntimeError("API key creation returned no credential")
            fetched = client.get_project(str(project.id))
            if fetched.id != project.id:
                raise RuntimeError("The fetched project did not match the created project")
        finally:
            client.backend_revoke_api_key(str(project.id), str(key.id))
    finally:
        client.delete_project(str(project.id), erase=True)
    print("Project lifecycle verified")
```
