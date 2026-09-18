# Xberg Go SDK

<div align="center">

<img width="3384" height="573" alt="Xberg Enterprise" src="https://github.com/user-attachments/assets/1b6c6ad7-3b6d-4171-b1c9-f2026cc9deb8">

</div>

<div align="center" style="display: flex; flex-wrap: wrap; gap: 8px; justify-content: center; margin: 20px 0;">

<a href="https://pkg.go.dev/github.com/xberg-io/sdks/packages/go"><img src="https://img.shields.io/badge/Go-pkg.go.dev-007ec6?logo=go&logoColor=white" alt="Go Reference"></a>
<a href="https://github.com/xberg-io/sdks/blob/main/LICENSE"><img src="https://img.shields.io/badge/License-MIT-007ec6" alt="License"></a>
<a href="https://docs.sdks.xberg.io"><img src="https://img.shields.io/badge/docs-docs.sdks.xberg.io-007ec6" alt="Documentation"></a>
<a href="https://github.com/xberg-io/sdks/actions/workflows/validate.yml"><img src="https://github.com/xberg-io/sdks/actions/workflows/validate.yml/badge.svg" alt="CI"></a>

</div>

<div align="center" style="margin-top: 20px;">

<a href="https://discord.gg/xt9WY3GnKR"><img height="22" src="https://img.shields.io/badge/Discord-Join%20our%20community-7289da?logo=discord&logoColor=white" alt="Discord"></a>

</div>

Official Go client for the [Xberg Enterprise](https://xberg.io) and
Xberg Pro document-processing APIs. One `Client` speaks to either product.

```sh
go get github.com/xberg-io/sdks/packages/go
```

Requires Go 1.26+.

## Dual-target client

The shared surface — extraction, jobs, audit, the curated preset registry, and
the RAG API — is written once and works against either product. Tier-specific
methods are capability-gated: they probe the connected instance (`GET
/healthz`'s `tier`, or an explicit target set via `WithTarget`) and return a
typed `*TierError` instead of a raw 404 when invoked against the wrong tier.

- **Enterprise and Pro** are self-hosted and require `WithBaseURL`.

```go
// Enterprise:
client, _ := xberg.New(
    xberg.WithBaseURL(os.Getenv("XBERG_BASE_URL")),
    xberg.WithAPIKey(os.Getenv("XBERG_API_KEY")),
)

// Pro (explicit base URL required):
pro, _ := xberg.New(
    xberg.WithTarget(xberg.TargetPro),
    xberg.WithBaseURL("https://pro.example.com"),
    xberg.WithAPIKey(os.Getenv("XBERG_API_KEY")),
)
```

Shared methods: `Extract`, `ExtractBatch`, `GetJob`, `GetJobResult`, `CancelJob`,
`ListJobs`, `WaitForJob`, `WaitForJobs`, `ExtractAndWait`, `Audit`, the curated
preset registry (`Presets`, `GetPreset`, `GetPresetSample`), saved presets
(`ListSavedPresets`, `CreateSavedPreset`, `GetSavedPreset`, `UpdateSavedPreset`,
`DeleteSavedPreset`), auto-tune (`ListAutoTuneJobs`, `SubmitAutoTune`,
`GetAutoTuneCapabilities`, `GetAutoTuneStatus`, `DeleteAutoTuneJob`,
`StopAutoTuneJob`, `PromoteAutoTuneProfile`, `GetAutoTuneResult`) and its
tuning-profile registry (`ListTuningProfiles`, `GetTuningProfile`,
`DeleteTuningProfile`), and the RAG surface (`ListRagCollections`,
`RagRetrieve`, `DeleteRagCollection`, `DeleteRagDocuments`,
`ListManagedEmbeddingPresets`, …). Pro-only: `AuthConfig`, `Login`,
`GetLicenseInfo`, `PutLocalUpload`, `GetRagConfig`/`SetRagConfig`, and the
control plane — projects
(`ListProjects`, `CreateProject`), API keys (`ListAPIKeys`, `CreateAPIKey`,
`RevokeAPIKey`) and integrations (`ListIntegrations`, `CreateIntegration`,
`GetIntegration`, `DeleteIntegration`, `ConnectIntegration`,
`DisconnectIntegration`, `ListIntegrationDocuments`, `FetchIntegrationDocument`).
Enterprise-only: `GetDocument`, `Versions`, `Diff`, `GetDiffJob`,
`ListExtractionEvents`, and the webhook-subscription delivery history
(`ListSubscriptionDeliveries`, `GetSubscriptionDelivery`). Available on both
tiers, though earlier releases wrongly gated them to Enterprise: `GetJobPage`,
enrichment (`SubmitEnrich`, `GetEnrichStatus`), uploads
(`PresignUpload`/`ConfirmUpload`), `Usage`, and `StreamCrawlEvents`.

Saved presets are served by both products at `/v1/saved_presets`; the method
names and payloads are identical either way.

### Deliberate exclusions

A few endpoints in the two specs are intentionally not surfaced:

- `GET /readyz` — an infrastructure readiness probe for orchestrators, not
  client surface. (`GET /healthz` *is* used: it is how an untargeted client
  discovers the tier.)
- Pro's `GET /v1/oauth/callback` and `DELETE /auth/account` — browser redirect
  and cookie-session flows that a bearer-token client cannot drive. Pro's
  `POST /auth/login` is exposed because it exchanges a verified OIDC ID token
  for a session JWT over a plain JSON request.

## Quickstart — explicit API key

```go
package main

import (
    "context"
    "fmt"
    "log"
    "os"

    xberg "github.com/xberg-io/sdks/packages/go"
)

func main() {
    ctx := context.Background()
    client, err := xberg.New(
        xberg.WithBaseURL(os.Getenv("XBERG_BASE_URL")),
        xberg.WithAPIKey(os.Getenv("XBERG_API_KEY")),
    )
    if err != nil {
        log.Fatal(err)
    }
    file, err := os.Open("invoice.pdf")
    if err != nil {
        log.Fatal(err)
    }
    defer file.Close()

    job, err := client.ExtractAndWait(
        ctx,
        xberg.FileSource{Name: "invoice.pdf", Reader: file},
        nil,
    )
    if err != nil {
        log.Fatal(err)
    }
    if job.Result != nil {
        fmt.Println(job.Result.Content)
    }
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

    xberg "github.com/xberg-io/sdks/packages/go"
)

func main() {
    ctx := context.Background()
    client, err := xberg.New(
        xberg.WithBaseURL(os.Getenv("XBERG_BASE_URL")),
        xberg.WithAPIKey(os.Getenv("XBERG_API_KEY")),
    )
    if err != nil {
        log.Fatal(err)
    }

    paths := []string{"invoice-a.pdf", "invoice-b.pdf"}
    var sources []xberg.FileSource
    for _, path := range paths {
        f, err := os.Open(path)
        if err != nil {
            log.Fatal(err)
        }
        defer f.Close()
        sources = append(sources, xberg.FileSource{Name: path, Reader: f})
    }

    jobs, err := client.ExtractBatch(ctx, sources, nil)
    if err != nil {
        log.Fatal(err)
    }
    ids := make([]string, len(jobs))
    for i, job := range jobs {
        ids[i] = job.Id.String()
    }
    results, err := client.WaitForJobs(ctx, ids, nil)
    if err != nil {
        log.Fatal(err)
    }
    for i, job := range results {
        length := 0
        if job.Result != nil {
            length = len(job.Result.Content)
        }
        fmt.Printf("%s -> %d chars\n", paths[i], length)
    }
}
```

## Errors

Every non-2xx response is mapped to a typed error. Use `errors.As` to
discriminate:

```go
import "errors"

job, err := client.ExtractAndWait(ctx, file, nil)
var rateLimited *xberg.RateLimitError
if errors.As(err, &rateLimited) {
    time.Sleep(rateLimited.RetryAfter)
}
```

The full hierarchy is `XbergError` (base) plus `AuthError`, `ValidationError`,
`NotFoundError`, `RateLimitError`, `ServerError`, `TimeoutError` (for
`WaitForJob` deadline expiry, distinct from context cancellation), and
`TierError` (a tier-specific method called against the wrong product tier).
Every subtype — including `TimeoutError` and `TierError`, which do not
originate from an HTTP response — embeds `XbergError`, so a single
`errors.As(err, &xberg.XbergError{})` catches any error this package raises.

## Documentation

- SDK docs: <https://docs.sdks.xberg.io>
- Product overview: <https://xberg.io>
- OpenAPI spec: [`spec/api/openapi.yaml`](https://github.com/xberg-io/sdks/blob/main/spec/api/openapi.yaml)

## License

MIT — © Kreuzberg, Inc.
