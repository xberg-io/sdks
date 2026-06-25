package kreuzbergcloud_test

import (
	"errors"
	"testing"

	kreuzbergcloud "github.com/xberg-io/sdks/go"
)

// mustClient builds a Client with the given options, failing the test on
// configuration errors. Used to keep test bodies focused on assertions.
func mustClient(t *testing.T, opts ...kreuzbergcloud.Option) *kreuzbergcloud.Client {
	t.Helper()
	client, err := kreuzbergcloud.New(opts...)
	if err != nil {
		t.Fatalf("kreuzbergcloud.New: %v", err)
	}
	return client
}

// asError is a generic wrapper around errors.As that returns a bool, so test
// bodies can write `if !asError(err, &target)` without juggling pointer types.
func asError[T error](err error, target *T) bool {
	return errors.As(err, target)
}
