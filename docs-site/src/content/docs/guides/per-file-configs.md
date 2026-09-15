---
title: Per-file configs
description: Override extraction config for one document in a batch, and how it merges.
---

## The precedence chain

A batch has one `options.extraction_config` shared by every document in it. A single document
within that batch can override it with its own `config` — a `FileExtractionConfig`. Precedence,
highest to lowest:

1. The per-file `config` on that document
2. The batch-level `options.extraction_config`
3. A curated or saved preset
4. The project default

The preset and project default are already folded into the batch-level config by the time a
per-file override is applied. **The merge is shallow over top-level fields**: a field the per-file
config sets replaces the batch-level value outright — it does not deep-merge into a nested object —
and a field it leaves unset falls through to whatever the batch level carries. Omitting `config`
entirely means "use the batch default" for every field.

`FileExtractionConfig` carries the same per-file knobs as `options.extraction_config` — `ocr`,
`pages`, `chunking`, `content_filter`, `layout`, `keywords`, `language_detection`,
`structured_extraction`, `postprocessor`, `images`, `pdf_options`, `html_options`, `disable_ocr`,
`force_ocr`, `force_ocr_pages`, `enable_quality_processing`, `token_reduction`,
`extraction_timeout_secs` (1–600, default 600, clamped down rather than rejected above the
ceiling), `output_format`, `result_format` and `include_document_structure` — 21 in all.
Batch-only fields — `use_cache`, `cache_namespace`, `cache_ttl_secs`,
`max_concurrent_extractions`, `security_limits`, `max_archive_depth`,
`max_embedded_file_bytes` — are not valid here; they apply to the whole request and have no
per-file equivalent.

## On the wire

Two equivalent shapes carry a per-file override, depending on how you submit the batch:

- **JSON**: each entry in `documents[]` may carry its own `config`.
- **Multipart**: a text part named `config-<filename>` whose value is the JSON-encoded config,
  mirroring the existing `document_id-<filename>` lineage convention.

## Using it

All three clients submit extractions as multipart, so they carry a per-file override as the
`config-<filename>` part. Pass one config per document: `config` on the single-document call,
and a list parallel to the files on the batch call.

```python title="Python"
from pathlib import Path

from xberg_io_sdk import XbergClient

with XbergClient(api_key="kz_...", base_url="https://xberg.example.com") as client:
    # One document, one override.
    job = client.extract(
        file=Path("invoice.pdf"),
        options={"extraction_config": {"disable_ocr": True}},
        config={"force_ocr": True},
    )

    # A batch: one entry per file, in the same order. None means "no override
    # for this one", so it falls through to options.extraction_config.
    jobs = client.extract_batch(
        [Path("scanned.pdf"), Path("digital.pdf")],
        options={"extraction_config": {"disable_ocr": True}},
        configs=[{"force_ocr": True}, None],
    )
```

`config` and each entry of `configs` accept a plain dict or a typed
`FileExtractionConfig`. `AsyncXbergClient` takes the same arguments, and
`extract_and_wait` accepts `config` as well.

```ts title="TypeScript"
const job = await client.extract({
  file: invoicePdf,
  options: { extraction_config: { disable_ocr: true } },
  config: { force_ocr: true },
});

const jobs = await client.extractBatch({
  files: [scannedPdf, digitalPdf],
  options: { extraction_config: { disable_ocr: true } },
  // One entry per file, in the same order; null means no override.
  configs: [{ force_ocr: true }, null],
});
```

```go title="Go"
// Every FileExtractionConfig field is a pointer, so an unset field stays unset
// rather than sending a zero value the server would read as an override.
forceOCR := true

job, err := client.Extract(ctx,
    xberg.FileSource{Name: "invoice.pdf", Reader: invoice},
    &xberg.ExtractOptions{
        Extraction: &xberg.ExtractionOptions{
            ExtractionConfig: &map[string]any{"disable_ocr": true},
        },
        Configs: []*xberg.FileExtractionConfig{{ForceOcr: &forceOCR}},
    },
)

// A batch: Configs is positionally parallel to the files, and a nil entry
// means no override for that document.
jobs, err := client.ExtractBatch(ctx,
    []xberg.FileSource{
        {Name: "scanned.pdf", Reader: scanned},
        {Name: "digital.pdf", Reader: digital},
    },
    &xberg.ExtractOptions{
        Configs: []*xberg.FileExtractionConfig{{ForceOcr: &forceOCR}, nil},
    },
)
```

The client sends what you gave it and nothing more. It does not merge your override into the
batch-level config, does not validate the fields against the batch-only list above, and does not
reorder anything: the precedence chain at the top of this page is resolved by the server.

## One filename, one override

Because the part is keyed on the filename, a multipart request has exactly one
`config-<filename>` slot per name. Two documents submitted under the same filename therefore
cannot carry different overrides — which is the shape a directed extraction takes, where the same
document goes in several times under different instructions.

Rather than send whichever override happened to be written last and drop the other with no signal,
all three clients reject that batch before any bytes go out, with an error naming the file — the
Python wording:

```text
per-file config conflict for 'invoice.pdf': the same filename appears more than once in this
batch with different configs, but a multipart request carries at most one config part per
filename. Give the copies distinct filenames.
```

Give the copies distinct filenames (`invoice-ocr.pdf`, `invoice-raw.pdf`) and each gets its own
part. Repeating a filename is still fine when the overrides are identical, or when none of the
copies carries one — those cases are unambiguous, and a single part covers them.

Two smaller cases to know about:

- A `configs` list whose length differs from the file list is rejected the same way, rather than
  silently pairing the entries it can.
- A document passed as raw bytes has no filename of its own, so Python and TypeScript both name it
  `upload.bin`; two of them in one batch collide under that name. Pass a path, a `File`, or a named
  stream when you need per-file overrides. Go has no such case: `FileSource.Name` is required.

## Reaching the JSON form

The `documents[]` array keys a config positionally, not by name, so the JSON form has no such
limitation. No client convenience method builds it — the three clients submit multipart — so a
batch that genuinely needs two different overrides for one filename either renames the copies or
posts the JSON body directly, against the base URL and credentials the client already resolved.

```python title="Python"
import base64

import httpx

response = httpx.post(
    "https://xberg.example.com/v1/extract",
    headers={"Authorization": "Bearer kz_..."},
    json={
        "documents": [
            {
                "filename": "invoice.pdf",
                "mime_type": "application/pdf",
                "data": base64.b64encode(invoice_bytes).decode(),
                "config": {"force_ocr": True},
            },
            {
                "filename": "invoice.pdf",
                "mime_type": "application/pdf",
                "data": base64.b64encode(invoice_bytes).decode(),
                "config": {"disable_ocr": True},
            },
        ],
        "options": {"extraction_config": {"disable_ocr": True}},
    },
)
response.raise_for_status()
job_ids = response.json()["job_ids"]
```

TypeScript reaches the same shape through `client.raw`, the underlying openapi-fetch client typed
over this spec:

```ts title="TypeScript"
const { data, error } = await client.raw.POST("/v1/extract", {
  body: {
    documents: [
      { filename: "invoice.pdf", mime_type: "application/pdf", data: invoiceBase64, config: { force_ocr: true } },
      { filename: "invoice.pdf", mime_type: "application/pdf", data: invoiceBase64, config: { disable_ocr: true } },
    ],
    options: { extraction_config: { disable_ocr: true } },
  },
});
if (error) throw error;
const jobIds = data.job_ids;
```

Go has no generated JSON extract-request type, so the equivalent is a hand-built body posted with
`client.HTTPClient()` against `client.BaseURL()`. Both accessors are public, but the API key is
not read back out of either client — keep it in the environment variable or secret store you read
it from when constructing the client, rather than a second source of truth.
