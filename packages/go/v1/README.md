# kreuzbergcloud

Official Go client for the [Kreuzberg Cloud](https://kreuzberg.cloud)
document-processing API.

```sh
go get github.com/kreuzberg-dev/kreuzberg-cloud-sdk/go/v1
```

Requires Go 1.26+.

## Usage

```go
package main

import (
    "context"
    "log"

    kreuzbergcloud "github.com/kreuzberg-dev/kreuzberg-cloud-sdk/go/v1"
)

func main() {
    client, err := kreuzbergcloud.New(
        kreuzbergcloud.WithAPIKey("..."),
    )
    if err != nil {
        log.Fatal(err)
    }
    _ = client
    _ = context.Background()
}
```

## License

MIT — © Kreuzberg, Inc.
