# kreuzbergcloud

Official Go client for the [Kreuzberg Cloud](https://kreuzberg.cloud)
document-processing API.

```sh
go get github.com/kreuzberg-dev/kreuzberg-cloud-sdk/go/v1
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

    kreuzbergcloud "github.com/kreuzberg-dev/kreuzberg-cloud-sdk/go/v1"
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

    kreuzbergcloud "github.com/kreuzberg-dev/kreuzberg-cloud-sdk/go/v1"
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

    kreuzbergcloud "github.com/kreuzberg-dev/kreuzberg-cloud-sdk/go/v1"
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
- OpenAPI spec: <https://api.kreuzberg.cloud/api-doc/openapi.json>

## License

MIT — © Kreuzberg, Inc.
