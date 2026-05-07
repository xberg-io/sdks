# kreuzberg-cloud

Official Python client for the [Kreuzberg Cloud](https://kreuzberg.cloud)
document-processing API.

- httpx-based, fully async (sync wrappers also exposed)
- Generated from the upstream OpenAPI 3.1 spec
- Type-annotated end to end, `py.typed` shipped

## Install

```sh
pip install kreuzberg-cloud
# or
uv add kreuzberg-cloud
```

Requires Python 3.10+.

## Usage

```python
from kreuzberg_cloud import AsyncKreuzbergCloud

async def main() -> None:
    async with AsyncKreuzbergCloud(api_key="...") as client:
        job = await client.extract(file_path="invoice.pdf")
        result = await client.wait_for_job(job.id)
        print(result.text)
```

A blocking client is also available as `KreuzbergCloud` for sync code paths.

## License

MIT — © Kreuzberg, Inc.
