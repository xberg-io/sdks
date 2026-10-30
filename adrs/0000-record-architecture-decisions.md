---
status: accepted
date: 2026-10-30
decision-makers: ["Na'aman Hirschfeld"]
---

# Record architecture decisions

## Context and Problem Statement

The SDKs' lasting choices (one dual-target client, client-side tier gating, the vendored specs, the committed Go
sources, the language set) are spread across commit messages, `~keep` comments in `mise.toml` and the workflows,
`.ai-rulez/context/area-map.md` and the docs site. Nothing records what was rejected or marks when a choice
changed. The org keeps its own decisions in a MADR log checked by adrlint:
[org ADR-0000 (Record architecture decisions)](https://github.com/xberg-io/agent-conventions/blob/main/adrs/0000-record-architecture-decisions.md).

## Considered Options

* A repository log of MADR records in `adrs/`, checked by adrlint, citing the org log for org-wide decisions

No alternatives were recorded.

## Decision Outcome

Chosen option: "A repository log of MADR records in `adrs/`, checked by adrlint, citing the org log for org-wide
decisions", because org ADR-0000 asks each repository to keep its own decisions and its deviations from an org
record in its own log.

Records follow MADR 4 as `adrlint new` writes it, numbered from 0000. ADRs 0001 to 0007 are seed records: decisions
already in force, dated to the commit that made them. Org-wide decisions (the polyrepo, licensing, the mise baseline
and tasks, poly, ai-rulez, action pins, the Starlight docs site) are cited as `org ADR-NNNN`, not restated. The index
is the docs-site page `docs-site/src/content/docs/reference/adr-index.md`, outside the log, because adrlint lints
every Markdown file in `adrs/`.

### Consequences

* Good, because a later change to one of these decisions supersedes or amends a record instead of drifting from
  a comment.
* Good, because adrlint checks the shape and numbering of every record and, once locked, its immutability.
* Bad, because a decision now lives both in the code comment that applies it and in the record that explains it,
  and the two can drift.

### Confirmation

`.adrlint.toml` sets `dir = "adrs"` and `start = 0`; `adrlint lint` and `adrlint format --check` exit 0 on `adrs/`.
`.github/workflows/validate.yml:29` turns on `check-adrs` in the reusable validate workflow.

## More Information

* [MADR](https://adr.github.io/madr/)
* [adrlint](https://github.com/Goldziher/adrlint)
* [Org decision log](https://github.com/xberg-io/agent-conventions/tree/main/adrs)
