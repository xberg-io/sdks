---
targets: ["enterprise"]
side_effect: "scratch-project"
requires: []
expect_stdout: "Project lifecycle verified"
---

```go title="Go"
package main

import (
	"context"
	"errors"
	"fmt"
	"os"
	"time"

	xberg "github.com/xberg-io/sdks/packages/go"
)

func run() (result error) {
	client, err := xberg.New(
		xberg.WithAPIKey(os.Getenv("XBERG_API_KEY")),
		xberg.WithBaseURL(os.Getenv("XBERG_BASE_URL")),
		xberg.WithControlPlaneBaseURL(os.Getenv("XBERG_CONTROL_PLANE_URL")),
		xberg.WithControlPlaneToken(os.Getenv("XBERG_CONTROL_PLANE_TOKEN")),
		xberg.WithTarget(xberg.TargetEnterprise),
	)
	if err != nil {
		return err
	}
	context := context.Background()
	project, err := client.BackendCreateProject(context, xberg.CreateProjectRequest{Name: fmt.Sprintf("sdk-snippet-%d", time.Now().UnixNano())})
	if err != nil {
		return err
	}
	defer func() {
		if err := client.DeleteProject(context, project.Id.String(), map[string]string{"erase": "true"}); err != nil {
			result = errors.Join(result, fmt.Errorf("deleting snippet project %s: %w", project.Id, err))
		}
	}()
	name := "snippet-key"
	key, err := client.BackendCreateAPIKey(context, project.Id.String(), xberg.CreateApiKeyRequest{Name: &name})
	if err != nil {
		return err
	}
	defer func() {
		if err := client.BackendRevokeAPIKey(context, project.Id.String(), key.Id.String()); err != nil {
			result = errors.Join(result, fmt.Errorf("revoking snippet key for project %s: %w", project.Id, err))
		}
	}()
	if key.Key == "" {
		return fmt.Errorf("API key creation returned no credential")
	}
	fetched, err := client.GetProject(context, project.Id.String())
	if err != nil {
		return err
	}
	if fetched.Id != project.Id {
		return fmt.Errorf("the fetched project did not match the created project")
	}
	return nil
}

func main() {
	if err := run(); err != nil {
		fmt.Fprintln(os.Stderr, err)
		os.Exit(1)
	}
	fmt.Println("Project lifecycle verified")
}
```
