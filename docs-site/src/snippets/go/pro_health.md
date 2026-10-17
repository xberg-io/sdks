---
targets: ["pro"]
side_effect: "safe"
requires: []
expect_stdout: "Pro health verified"
---

```go title="Go"
package main

import (
 "context"
 "encoding/json"
 "fmt"
 "os"
 "reflect"

 xberg "github.com/xberg-io/sdks/packages/go"
)

func run() error {
 client, err := xberg.New(xberg.WithBaseURL(os.Getenv("XBERG_BASE_URL")),
  xberg.WithTarget(xberg.TargetPro), xberg.WithRetries(0))
 if err != nil { return err }
 health, err := client.ProHealthz(context.Background())
 if err != nil { return err }
 if health.Status != "ok" { return fmt.Errorf("Pro health status mismatch") }
 if health.Tier != "pro" { return fmt.Errorf("Pro health tier mismatch") }
 switch health.License.State {
 case "licensed", "grace", "expired", "invalid", "unlicensed":
 default: return fmt.Errorf("Pro health license state mismatch")
 }
 snapshot := map[string]any{
  "status": health.Status, "tier": health.Tier,
  "license": map[string]any{"state": health.License.State},
  "rag": map[string]any{"enabled": health.Rag.Enabled},
  "auto_tune": map[string]any{"enabled": health.AutoTune.Enabled},
 }
 if expectedJSON := os.Getenv("XBERG_EXPECTED_PRO_HEALTH_JSON"); expectedJSON != "" {
  var expected map[string]any
  if err := json.Unmarshal([]byte(expectedJSON), &expected); err != nil { return err }
  if !reflect.DeepEqual(snapshot, expected) { return fmt.Errorf("Pro health configured values mismatch") }
 }
 fmt.Println("Pro health verified")
 return nil
}

func main() {
 if err := run(); err != nil {
  fmt.Fprintln(os.Stderr, err)
  os.Exit(1)
 }
}
```
