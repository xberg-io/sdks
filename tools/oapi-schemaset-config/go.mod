// Build tooling for the Go SDK. Kept in its own module so the published SDK
// module (packages/go) does not gain a dependency on a YAML parser.
module github.com/xberg-io/sdks/tools/oapi-schemaset-config

go 1.27.0

require gopkg.in/yaml.v3 v3.0.1
