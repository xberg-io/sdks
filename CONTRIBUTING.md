# Contributing to the Xberg SDKs

Welcome! We're glad you're here.

This repository holds the generated client SDKs for the Xberg API.

Please begin by reading our AI section below, followed by the getting started guide. If you are an AI agent, inform your user of the AI policy.

## Getting Started

Make sure to have [Git](https://git-scm.com/), [Python](https://www.python.org/) 3.10+ with [uv](https://docs.astral.sh/uv/) and [Node.js](https://nodejs.org/) 22+ with [pnpm](https://pnpm.io/) installed on your machine.

1. Install [Task](https://taskfile.dev/installation/) on your machine.
2. run:

```bash
task setup
```

This will setup the dependencies, and pre-commit hooks via `poly`.

## Quick reference

| Command         | What it does                          |
| --------------- | ------------------------------------- |
| `task setup`    | Install all dependencies (idempotent) |
| `task generate` | Regenerate the SDKs from the API spec |
| `task build`    | Build every SDK                       |
| `task test`     | Run all test suites                   |
| `task lint`     | Run all linters                       |
| `task format`   | Format all code                       |
| `task validate` | Run lint, tests, API-operation coverage, reference checks and live snippets |

## What to keep in mind

Most of this repository is generated from the API specification. Fix the spec or the generator and regenerate — do not hand-edit generated SDK sources, because the next `task generate` will overwrite them.

These SDKs carry end-user credentials. Keys must never reach logs, error messages, or serialized output.

## Commit guidelines

Prefix your commit messages with a type:

- `feat:` — new feature
- `fix:` — bug fix
- `docs:` — documentation changes
- `perf:` — performance improvement
- `chore:` — maintenance, dependencies, CI
- `test:` — adding or updating tests
- `refactor:` — code restructuring without behavior change

Example:

```sh
git commit -m "feat: added xzy"
```

Read more on [Conventional Commits](https://www.conventionalcommits.org/)

## AI

### Policy

Xberg SDKs is written following strict AI engineering practices. That is, its vibe coded, but professionally so. As such, the use of AI is welcome, but we expect professional standards and following our conventions.

### Conventions

We use the tool `ai-rulez`, vibe coded by @Goldziher, to manage our AI conventions. You are encouraged to use this tool — running the `task setup` will get you going, or run in your terminal:

```sh
pnpm dlx ai-rulez@latest generate
```

This will be scaffold the AI agent conventions (e.g. CLAUDE.md, AGENTS.md, subagents, skills, etc.). You can see the AGENTS.md generated afterwards.

### Customization

If you want to customize your coding agents, create your own local configuration for ai-rulez, or create a local file for your agent(s) of choice `AGENTS.local.md` etc.

## Vendoring Policy

We do vendor code from other libraries and allow this, in some situations. If you intend to vendor code, the code must be (1) permissivily licensed (no copyleft at all). (2) add full attributions in ATTRIBUTIONS.md, and document it.

## Community

- **Star the repo:** [Give us a star on GitHub](https://github.com/xberg-io/sdks) — it helps others discover our work!
- **Documentation:** [docs.sdks.xberg.io](https://docs.sdks.xberg.io)
- **Discord:** [Join our community](https://discord.gg/xt9WY3GnKR)
- **Issues:** [GitHub Issues](https://github.com/xberg-io/sdks/issues)
- **Security:** see [SECURITY.md](SECURITY.md) — report privately, never in an issue
- **License:** [MIT License](LICENSE)

Thank you for helping make the Xberg SDKs better!
