---
targets: ["enterprise"]
side_effect: "safe"
requires: ["crawl-job"]
expect_stdout: "Subscription canceled"
---

```go title="Go"
package main

import (
	"context"
	"errors"
	"fmt"
	"os"
	"strconv"
	"time"

	xberg "github.com/xberg-io/sdks/packages/go"
)

func run() error {
	client, err := xberg.New(xberg.WithAPIKey(os.Getenv("XBERG_API_KEY")), xberg.WithBaseURL(os.Getenv("XBERG_BASE_URL")), xberg.WithTarget(xberg.TargetEnterprise), xberg.WithTimeout(500*time.Millisecond))
	if err != nil {
		return err
	}
	duration := 30.0
	if value := os.Getenv("XBERG_STREAM_TIMEOUT_SECONDS"); value != "" {
		duration, err = strconv.ParseFloat(value, 64)
		if err != nil {
			return err
		}
	}
	subscriptionContext, cancel := context.WithTimeout(context.Background(), time.Duration(duration*float64(time.Second)))
	defer cancel()
	events, err := client.StreamCrawlEvents(subscriptionContext, os.Getenv("XBERG_CRAWL_JOB_ID"))
	if err != nil {
		return err
	}
	for event, err := range events {
		if err != nil {
			if !errors.Is(subscriptionContext.Err(), context.DeadlineExceeded) {
				return err
			}
			break
		}
		fmt.Println(event.Kind)
	}
	if errors.Is(subscriptionContext.Err(), context.DeadlineExceeded) {
		fmt.Println("Subscription canceled")
	}
	return nil
}

func main() {
	if err := run(); err != nil {
		fmt.Fprintln(os.Stderr, err)
		os.Exit(1)
	}
}
```
