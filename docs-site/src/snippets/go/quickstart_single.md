---
targets: ["pro", "enterprise"]
side_effect: "safe"
requires: ["document"]
expect_stdout: "Extraction verified"
---

```go title="Go"
package main

import (
	"context"
	"fmt"
	"os"
	"strings"

	xberg "github.com/xberg-io/sdks/packages/go"
)

func run() error {
	client, err := xberg.New(
		xberg.WithAPIKey(os.Getenv("XBERG_API_KEY")),
		xberg.WithBaseURL(os.Getenv("XBERG_BASE_URL")),
		xberg.WithTarget(xberg.Target(os.Getenv("XBERG_TARGET"))),
	)
	if err != nil {
		return err
	}
	file, err := os.Open(os.Getenv("XBERG_DOCUMENT"))
	if err != nil {
		return err
	}
	defer file.Close()
	job, err := client.ExtractAndWait(context.Background(), xberg.FileSource{Name: "snippet.txt", Reader: file}, nil)
	if err != nil {
		return err
	}
	result, err := client.GetJobResult(context.Background(), job.Id.String())
	if err != nil {
		return err
	}
	if result.Results == nil || len(*result.Results) != 1 || !strings.Contains((*result.Results)[0].Content, "Xberg SDK snippet fixture") {
		return fmt.Errorf("the extracted document did not contain the expected text")
	}
	fmt.Println("Extraction verified")
	return nil
}

func main() {
	if err := run(); err != nil {
		fmt.Fprintln(os.Stderr, err)
		os.Exit(1)
	}
}
```
