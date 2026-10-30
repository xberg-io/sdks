---
status: accepted
date: 2026-05-07
decision-makers: ["Na'aman Hirschfeld"]
---

# Hand-written clients over per-language generators

## Context and Problem Statement

The SDKs are generated from OpenAPI 3.1 specs, but a generated client alone gives no job polling, retry and backoff,
typed error hierarchy, and every regeneration overwrites what is in it. The scaffold had to
pick a generator for each language and decide where the user-facing API lives.

## Considered Options

* A hand-written client in each language over code from that language's own OpenAPI generator: openapi-python-client
  for Python, openapi-typescript with the openapi-fetch runtime for TypeScript, oapi-codegen for Go

No alternatives were recorded.

## Decision Outcome

Chosen option: "A hand-written client in each language over code from that language's own OpenAPI generator:
openapi-python-client for Python, openapi-typescript with the openapi-fetch runtime for TypeScript, oapi-codegen for
Go", because it keeps the wire types in step with the spec by regeneration while the methods, retries and errors
users call stay in code that regeneration never touches.

* The generators produce types: Python's client imports only the generated models, Go generates `models: true`
  only, and TypeScript types an openapi-fetch client over the generated schema, exposed as the raw client.
* The hand-written layer owns the requests, the error hierarchy, retry, job waiting and the tier gate (ADR-0002).
  The first ergonomic methods and error hierarchies came in 483ab1b, 60b4cb2, fb44260 and 70489bd (2026-05-09).
* Generated code is never hand-edited; a fix goes to the spec or the generator, then `mise run generate`.
* Go started on hand-written interim types because oapi-codegen could not yet generate the 3.1 spec (99e810a). The
  Go models have been generated since 285925f (2026-07-31).

### Consequences

* Good, because a spec sync changes the types without rewriting the methods users depend on.
* Good, because each package depends only on its own ecosystem's generator and runtime.
* Bad, because the same method surface, error mapping and retry rules are written three times and can diverge, as
  362168a found when Go alone did not retry transport failures.
* Bad, because each generator brings its own gaps, which the repository patches around: for example
  `scripts/prepare-python-spec.py` names inline union branches for openapi-python-client, and
  `scripts/patch-python-compat.py` backports its output to Python 3.10.

### Confirmation

* `README.md:34` to `README.md:36` name the codegen for each package.
* `mise-tasks/python/generate.sh:14`, `packages/typescript/package.json:63` and `package.json:69`,
  `packages/go/go.mod:31` and `packages/go/oapi-codegen-api.yaml:9`.
* `CONTRIBUTING.md:35` and `.ai-rulez/context/area-map.md:16` ("hand-written clients over generated code ... never
  hand-edit them").
* `scripts/spec-coverage.py` (`mise run spec:coverage`) fails when a spec operation is in no client and not
  deliberately excluded.
