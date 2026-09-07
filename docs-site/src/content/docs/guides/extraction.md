---
title: Extracting documents
description: Single documents, batches, and the options that shape a result.
---

## Submitting

`POST /v1/extract` accepts up to **10 documents** per request on both tiers, as either
`application/json` with base64 bytes or `multipart/form-data` with raw bytes. The SDK extraction methods use
multipart, avoiding the base64 expansion required by JSON uploads.

The response is **202** with one job id per document — never the extracted content. Extraction is
asynchronous on both tiers precisely so a large document cannot ride on a single HTTP request.

## Batches

A batch is a fan-out, not a single unit of work: each document becomes its own job with its own id
and its own result. That matters for failure handling — one document failing does not discard the
others, and each job reports its own status.

Batch wait helpers wait on every job. Python waits sequentially; TypeScript and Go wait concurrently.

## Reading results

`GET /v1/jobs/{id}/result` returns the job's documents. Each carries `content`, `mime_type`,
`metadata`, `tables` and `counts` — the last being `{pages, tables, images}`. Read the `results`
collection inside the job-result envelope; the envelope is not itself an extracted document.

A job can end `partial_success`: some documents extracted, others did not. The per-document errors
list says which, and why.

## Document versions on Enterprise

Supply a stable UUID to associate later extractions with the same document. Python accepts
`document_id` on `extract` and `extract_and_wait`; TypeScript accepts `documentId` on `extract`
and `extractAndWait`. Go uses `ExtractOptions.DocumentIDs`, with one entry for a single file.

For batches, supply one entry per file using Python `document_ids`, TypeScript `documentIds`, or
Go `ExtractOptions.DocumentIDs`. Use `None`, `null`, or `nil` for files without lineage. Duplicate
filenames must carry the same ID, including whether the ID is absent; use distinct filenames to
assign different IDs. Invalid IDs and conflicting assignments fail before the SDK reads file data.

These options require Enterprise. Omitting IDs preserves ordinary extraction on either tier.
