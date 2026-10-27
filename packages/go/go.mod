module github.com/xberg-io/sdks/packages/go

go 1.27.0

require (
	github.com/google/uuid v1.6.0
	github.com/oapi-codegen/runtime v1.8.0
	golang.org/x/sync v0.24.0
)

require (
	github.com/apapsch/go-jsonmerge/v2 v2.0.0 // indirect
	// ~keep yaml-jsonpath v0.3.2 requires YAML v3 nodes; newer go-yit switches to incompatible YAML v4 nodes.
	github.com/dprotaso/go-yit v0.0.0-20220510233725-9ba8df137936 // indirect
	github.com/getkin/kin-openapi v0.149.0 // indirect
	github.com/go-openapi/jsonpointer v1.0.2 // indirect
	github.com/oapi-codegen/oapi-codegen/v2 v2.8.1 // indirect
	github.com/oasdiff/yaml v0.1.1 // indirect
	github.com/oasdiff/yaml3 v0.0.14 // indirect
	github.com/santhosh-tekuri/jsonschema/v6 v6.0.3 // indirect
	github.com/speakeasy-api/jsonpath v0.6.3 // indirect
	github.com/speakeasy-api/openapi v1.25.5 // indirect
	github.com/vmware-labs/yaml-jsonpath v0.3.2 // indirect
	go.yaml.in/yaml/v3 v3.0.5 // indirect
	golang.org/x/mod v0.42.0 // indirect
	golang.org/x/text v0.43.0 // indirect
	golang.org/x/tools v0.52.0 // indirect
	gopkg.in/yaml.v3 v3.0.1 // indirect
)

tool github.com/oapi-codegen/oapi-codegen/v2/cmd/oapi-codegen
