---
title: RAG, auto-tune and saved presets
description: Retrieval collections, tuning extraction against ground truth, and reusable presets.
---

RAG and auto-tune are part of the shared surface — identical routes on both tiers — but both are
**licence-gated**, not tier-gated: whether they respond depends on the connected instance's
licence entitlement, not on whether it is Enterprise or Pro. A licence without the entitlement
gets a normal authorization error, not a tier error.

## Saved presets

A saved preset is a project-scoped, user-authored extraction configuration, distinct from the
curated read-only presets `presets()`/`presets`/`Presets` lists. Both tiers serve it at
`/v1/saved_presets`.

```python title="Python"
created = client.create_saved_preset({"name": "invoices", "extraction_config": {"preset": "invoice"}})
preset = client.get_saved_preset(created.id)
client.update_saved_preset(created.id, {"name": "invoices-v2", "extraction_config": {"preset": "invoice"}})
client.delete_saved_preset(created.id)
```

```ts title="TypeScript"
const created = await client.createSavedPreset({ name: "invoices", extraction_config: { preset: "invoice" } });
const preset = await client.getSavedPreset(created.id);
await client.deleteSavedPreset(created.id);
```

```go title="Go"
created, err := client.CreateSavedPreset(ctx, xberg.CreateSavedPresetRequest{Name: "invoices"})
preset, err := client.GetSavedPreset(ctx, created.Id.String())
err = client.DeleteSavedPreset(ctx, created.Id.String())
```

Reference a saved preset from an extraction with `options.saved_preset_id`; it is mutually
exclusive with `options.preset` (a curated preset id).

## Auto-tune

Auto-tune searches for an extraction configuration that best matches ground truth you supply,
across a set of sample documents. Submit is multipart: a JSON `request` part (the documents and
their ground truth, plus optional `budget`/`search`/`routing`) alongside one `file` part per
document, matched by filename.

```python title="Python"
from pathlib import Path

job = client.submit_auto_tune(
    {
        "documents": [
            {
                "filename": "invoice.pdf",
                "ground_truth_kind": "structured",
                "ground_truth": '{"schema": {...}, "expected": {...}}',
            },
        ],
    },
    files=[Path("invoice.pdf")],
)
status = client.get_auto_tune_status(job.auto_tune_job_id)
```

```ts title="TypeScript"
const job = await client.submitAutoTune({
  request: {
    documents: [
      { filename: "invoice.pdf", ground_truth_kind: "structured", ground_truth: groundTruthJson },
    ],
  },
  files: [{ name: "invoice.pdf", data: invoiceBytes, mimeType: "application/pdf" }],
});
const status = await client.getAutoTuneStatus(job.auto_tune_job_id);
```

```go title="Go"
job, err := client.SubmitAutoTune(ctx, xberg.CreateAutoTuneJobRequest{
    Documents: []xberg.AutoTuneDocumentInput{
        {Filename: "invoice.pdf", GroundTruthKind: xberg.GroundTruthKind("structured"), GroundTruth: groundTruthJSON},
    },
}, []xberg.FileSource{{Name: "invoice.pdf", Reader: invoiceFile}})
status, err := client.GetAutoTuneStatus(ctx, job.AutoTuneJobId)
```

`ground_truth_kind` is one of `markdown`, `plaintext` or `structured`. For `structured`,
`ground_truth` is a JSON **string** encoding `{"schema": ..., "expected": ...}` — both the schema
and the expected output are required.

Poll with `get_auto_tune_status`/`getAutoTuneStatus`/`GetAutoTuneStatus` until the job completes,
then fetch the leaderboard and winning configuration:

```python title="Python"
result = client.get_auto_tune_result(job.auto_tune_job_id)
profile = client.promote_auto_tune_profile(job.auto_tune_job_id, {"name": "invoices-tuned"})
```

Promoting writes a named, reusable **tuning profile** — list and manage those with
`list_tuning_profiles`/`get_tuning_profile`/`delete_tuning_profile` (and their TypeScript/Go
equivalents). `get_auto_tune_capabilities`/`getAutoTuneCapabilities`/`GetAutoTuneCapabilities`
reports which OCR backends and knobs the connected deployment can search over — check it before
building a search config the deployment cannot honor.

## RAG

The RAG surface manages vector collections, ingests documents into them, and retrieves chunks.
All three clients return the decoded response body untyped (`Any` in Python, `unknown` in
TypeScript, `json.RawMessage` in Go) — the schemas are still converging across tiers, so decode
against whichever fields you need.

```python title="Python"
client.create_rag_collection({"name": "policies", "embedding_dim": 384})
client.add_rag_documents("policies", {"documents": [{"id": "doc-1", "text": "..."}]})
hits = client.rag_retrieve("policies", {"query": "refund window", "top_k": 5})
client.delete_rag_collection("policies")
```

```ts title="TypeScript"
await client.createRagCollection({ name: "policies", embedding_dim: 384 });
await client.addRagDocuments("policies", { documents: [{ id: "doc-1", text: "..." }] });
const hits = await client.ragRetrieve("policies", { query: "refund window", top_k: 5 });
await client.deleteRagCollection("policies");
```

```go title="Go"
_, err := client.CreateRagCollection(ctx, map[string]any{"name": "policies", "embedding_dim": 384})
_, err = client.AddRagDocuments(ctx, "policies", map[string]any{
    "documents": []map[string]any{{"id": "doc-1", "text": "..."}},
})
hits, err := client.RagRetrieve(ctx, "policies", map[string]any{"query": "refund window", "top_k": 5})
err = client.DeleteRagCollection(ctx, "policies")
```

`retrieve`'s `mode` defaults to `hybrid`; pass `"vector"`, `"full_text"` or a BYO `query_vector`
matching the collection's `embedding_dim`. `top_k` is `1..=200` (default 10); `rerank` is
three-state — omit it for the collection default, set it to `null` to disable reranking for this
call, or supply a `RerankerSpec` to override it.

Long-running collection operations — ingest, reindex, embedding migration — return a job you poll
with `get_rag_job`/`getRagJob`/`GetRagJob` (or, for migrations specifically,
`get_rag_migration_job`/`getRagMigrationJob`/`GetRagMigrationJob`), the same terminal-status
contract as extraction jobs.

Pro also exposes a per-project RAG default via `get_rag_config`/`set_rag_config` — see
[the control plane guide](/guides/control-plane/).
