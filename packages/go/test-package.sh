#!/usr/bin/env bash
set -euo pipefail
root=$(git rev-parse --show-toplevel)
package_dir=$(mktemp -d)
trap 'rm -rf "$package_dir"' EXIT
mkdir "$package_dir/sdk" "$package_dir/consumer"
git -C "$root" archive HEAD packages/go | tar -x -C "$package_dir/sdk" --strip-components=2
for generated in generated_api.go generated_pro.go generated_backend.go; do
  test -s "$package_dir/sdk/$generated"
done
cd "$package_dir/consumer"
export GOWORK=off
go mod init consumer.example/sdk
go mod edit -replace "github.com/xberg-io/sdks/packages/go=$package_dir/sdk"
cat > main.go <<'GO'
package main

import xberg "github.com/xberg-io/sdks/packages/go"

func main() {
    _ = xberg.JobResult{Results: &[]xberg.JobResultDocument{{Content: "consumer"}}}
    _ = xberg.CrawlEventKindComplete
}
GO
go mod tidy
go build ./...
