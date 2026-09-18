---
title: Installation
description: Install the Xberg client for Python, TypeScript or Go, and point it at Enterprise or Pro.
---

One package per language, each carrying a single client that serves both Xberg Enterprise and
Xberg Pro.

| Language | Package | Requires |
| --- | --- | --- |
| Python | [`xberg-io-sdk`](https://pypi.org/project/xberg-io-sdk/) | Python 3.10+ |
| TypeScript / Node.js | [`@xberg-io/sdk`](https://www.npmjs.com/package/@xberg-io/sdk) | Node 22+, ESM only |
| Go | [`github.com/xberg-io/sdks/packages/go`](https://pkg.go.dev/github.com/xberg-io/sdks/packages/go) | Go 1.26+ |

## Python

```sh
pip install xberg-io-sdk
# or
uv add xberg-io-sdk
```

The import name is `xberg_io_sdk`, and the clients are `XbergClient` and `AsyncXbergClient`.

## TypeScript

```sh
pnpm add @xberg-io/sdk
```

The package is ESM only. The client is `XbergClient`; `createClient` is available when you want
the underlying typed fetch client.

## Go

```sh
go get github.com/xberg-io/sdks/packages/go
```

The package name is `xberg`, so import it as
`xberg "github.com/xberg-io/sdks/packages/go"`.

## Choosing a target

Enterprise and Pro are self-hosted and have no default URL — pass the deployment's URL.

You can also pass `target` explicitly (`"enterprise"` or `"pro"`). Omit it and the client reads
the tier once from `GET /healthz` the first time a tier-specific method is called, then caches it
for the client's lifetime. Passing `target` skips that probe entirely, which is worth doing when
you already know what you are talking to.

Calling a method the connected tier does not serve raises a clear tier error rather than issuing a
request that would 404. See [Tier capabilities](/reference/tier-capabilities/) for what each
product serves.
