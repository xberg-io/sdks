# kreuzbergcloud

<div align="center">

<img width="3384" height="573" alt="Kreuzberg Cloud" src="https://github.com/user-attachments/assets/1b6c6ad7-3b6d-4171-b1c9-f2026cc9deb8">

</div>

<div align="center" style="display: flex; flex-wrap: wrap; gap: 8px; justify-content: center; margin: 20px 0;">

<a href="https://pypi.org/project/kreuzberg-cloud-sdk/"><img src="https://img.shields.io/pypi/v/kreuzberg-cloud-sdk?label=PyPI&color=007ec6" alt="PyPI"></a>
<a href="https://www.npmjs.com/package/@kreuzberg/cloud"><img src="https://img.shields.io/npm/v/%40kreuzberg%2Fcloud?label=npm&color=007ec6" alt="npm"></a>
<a href="https://pkg.go.dev/github.com/kreuzberg-dev/kreuzberg-cloud-sdk/go"><img src="https://img.shields.io/badge/Go-pkg.go.dev-007ec6?logo=go&logoColor=white" alt="Go Reference"></a>
<a href="https://github.com/kreuzberg-dev/kreuzberg-cloud-sdk/blob/main/LICENSE"><img src="https://img.shields.io/badge/License-MIT-blue.svg" alt="License"></a>
<a href="https://docs.kreuzberg.cloud"><img src="https://img.shields.io/badge/docs-kreuzberg.cloud-007ec6" alt="Documentation"></a>
<a href="https://github.com/kreuzberg-dev/kreuzberg-cloud-sdk/actions/workflows/validate.yml"><img src="https://github.com/kreuzberg-dev/kreuzberg-cloud-sdk/actions/workflows/validate.yml/badge.svg" alt="CI"></a>

</div>

<div align="center" style="margin-top: 20px;">

<a href="https://discord.gg/xt9WY3GnKR"><img height="22" src="https://img.shields.io/badge/Discord-Join%20our%20community-7289da?logo=discord&logoColor=white" alt="Discord"></a>

</div>

Official Go client for the [Kreuzberg Cloud](https://kreuzberg.cloud)
document-processing API.

```sh
go get github.com/kreuzberg-dev/kreuzberg-cloud-sdk/go
```

Requires Go 1.26+.

> **Status.** This is a hand-written interim client covering the operations
> the v1 docs Quickstart needs: `Extract`, `ExtractBatch`, `GetJob`,
> `WaitForJob`, `WaitForJobs`, `ExtractAndWait`, and `CreateSandboxKey`. It
> will be replaced with generated bindings when
> [oapi-codegen](https://github.com/oapi-codegen/oapi-codegen) gains OpenAPI
> 3.1 support; the public surface above will be preserved.

## Quickstart — explicit API key

```go
package main

import (
    "context"
    "fmt"
    "log"
    "os"

    kreuzbergcloud "github.com/kreuzberg-dev/kreuzberg-cloud-sdk/go"
)

func main() {
    ctx := context.Background()
    client, err := kreuzbergcloud.New(
        kreuzbergcloud.WithAPIKey(os.Getenv("KREUZBERG_API_KEY")),
    )
    if err != nil {
        log.Fatal(err)
    }
    file, err := os.Open("invoice.pdf")
    if err != nil {
        log.Fatal(err)
    }
    defer file.Close()

    result, err := client.ExtractAndWait(
        ctx,
        kreuzbergcloud.FileSource{Name: "invoice.pdf", Reader: file},
        nil,
    )
    if err != nil {
        log.Fatal(err)
    }
    fmt.Println(result.Content)
}
```

## Batch extraction with parallel waits

```go
package main

import (
    "context"
    "fmt"
    "log"
    "os"

    kreuzbergcloud "github.com/kreuzberg-dev/kreuzberg-cloud-sdk/go"
)

func main() {
    ctx := context.Background()
    client, err := kreuzbergcloud.New(
        kreuzbergcloud.WithAPIKey(os.Getenv("KREUZBERG_API_KEY")),
    )
    if err != nil {
        log.Fatal(err)
    }

    paths := []string{"invoice-a.pdf", "invoice-b.pdf"}
    var sources []kreuzbergcloud.FileSource
    for _, path := range paths {
        f, err := os.Open(path)
        if err != nil {
            log.Fatal(err)
        }
        defer f.Close()
        sources = append(sources, kreuzbergcloud.FileSource{Name: path, Reader: f})
    }

    jobs, err := client.ExtractBatch(ctx, sources, nil)
    if err != nil {
        log.Fatal(err)
    }
    ids := make([]string, len(jobs))
    for i, job := range jobs {
        ids[i] = job.ID
    }
    results, err := client.WaitForJobs(ctx, ids, nil)
    if err != nil {
        log.Fatal(err)
    }
    for i, result := range results {
        fmt.Printf("%s -> %d chars\n", paths[i], len(result.Content))
    }
}
```

## Zero-friction sandbox

`FromSandbox` mints a short-lived anonymous API key and hands back a fully
configured client. Useful for demos, docs, and getting-started experiences —
not for production traffic.

```go
package main

import (
    "context"
    "fmt"
    "log"
    "os"

    kreuzbergcloud "github.com/kreuzberg-dev/kreuzberg-cloud-sdk/go"
)

func main() {
    ctx := context.Background()
    client, err := kreuzbergcloud.FromSandbox(ctx)
    if err != nil {
        log.Fatal(err)
    }
    file, err := os.Open("invoice.pdf")
    if err != nil {
        log.Fatal(err)
    }
    defer file.Close()
    result, err := client.ExtractAndWait(
        ctx,
        kreuzbergcloud.FileSource{Name: "invoice.pdf", Reader: file},
        nil,
    )
    if err != nil {
        log.Fatal(err)
    }
    fmt.Println(result.Content)
}
```

## Errors

Every non-2xx response is mapped to a typed error. Use `errors.As` to
discriminate:

```go
import "errors"

result, err := client.ExtractAndWait(ctx, file, nil)
var rateLimited *kreuzbergcloud.RateLimitError
if errors.As(err, &rateLimited) {
    time.Sleep(rateLimited.RetryAfter)
}
```

The full hierarchy is `APIError` (base) plus `AuthError`, `ValidationError`,
`NotFoundError`, `RateLimitError`, `ServerError`, and `TimeoutError` (for
`WaitForJob` deadline expiry, distinct from context cancellation).

## Documentation

- API reference: <https://docs.kreuzberg.cloud>
- OpenAPI spec: <https://api.kreuzberg.dev/api-doc/openapi.json>

## License

MIT — © Kreuzberg, Inc.
