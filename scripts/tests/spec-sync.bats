setup() {
  bats_load_library xberg-bats
  xberg_setup
  SCRIPT="$BATS_TEST_DIRNAME/../spec-sync.sh"
}

@test "resolve defaults to development and a per-ref branch" {
  run env -u PAYLOAD_REF -u PAYLOAD_VERSION "$SCRIPT" resolve
  xberg_assert_status 0
  xberg_assert_github_output "$(printf '%s\n' ref=development version=latest branch=chore/spec-sync-development)"
}

@test "resolve records a release payload and flattens the tag into the branch name" {
  PAYLOAD_REF=pro-v0.4.3 PAYLOAD_VERSION=0.4.3 run "$SCRIPT" resolve
  xberg_assert_status 0
  xberg_assert_github_output "$(printf '%s\n' ref=pro-v0.4.3 version=0.4.3 branch=chore/spec-sync-pro-v0-4-3)"
}

@test "resolve keeps refs with a slash on one branch segment" {
  PAYLOAD_REF=release/0.10 run "$SCRIPT" resolve
  xberg_assert_status 0
  grep -qx 'branch=chore/spec-sync-release-0-10' "$GITHUB_OUTPUT"
}

@test "resolve rejects a ref that could escape the branch name or a git option" {
  for ref in '../main' '-x' 'a b' 'a;b' '$(id)' ''; do
    : >"$GITHUB_OUTPUT"
    PAYLOAD_REF="$ref" PAYLOAD_VERSION=1 run "$SCRIPT" resolve
    if [ -z "$ref" ]; then
      # an empty payload ref falls back to the default instead of failing
      xberg_assert_status 0
    else
      xberg_assert_status 1
      xberg_assert_output_contains "invalid ref"
      xberg_assert_file "$GITHUB_OUTPUT" ""
    fi
  done
}

@test "resolve rejects a version with shell metacharacters" {
  PAYLOAD_VERSION='1.0; rm -rf /' run "$SCRIPT" resolve
  xberg_assert_status 1
  xberg_assert_output_contains "invalid version"
}

@test "sha records the revision git reports for the upstream checkout" {
  xberg_stub git 'printf "%s\n" "$*" >>"$XBERG_TRACE"' 'echo 99a7284230b2df6200fd91795ad8e1cb09c1869a'
  UPSTREAM_DIR=/work/up run "$SCRIPT" sha
  xberg_assert_status 0
  xberg_assert_github_output "sha=99a7284230b2df6200fd91795ad8e1cb09c1869a"
  xberg_assert_trace "-C /work/up rev-parse HEAD"
}

@test "sha refuses output that is not a full revision" {
  xberg_stub git 'echo not-a-sha'
  UPSTREAM_DIR=/work/up run "$SCRIPT" sha
  xberg_assert_status 1
  xberg_assert_output_contains "unexpected revision"
}

@test "sha fails when the upstream checkout is missing" {
  xberg_stub git 'exit 128'
  UPSTREAM_DIR=/work/up run "$SCRIPT" sha
  xberg_assert_status 1
  xberg_assert_output_contains "cannot resolve HEAD"
}

@test "body reports the ref, commit and coverage gaps without failing" {
  cat >"$XBERG_WORK/coverage.txt" <<'TXT'
task: [spec:coverage] uv run python scripts/spec-coverage.py
enterprise  52/84 reached, 1 excluded, 0 tracked as pending
  enterprise: GET /v1/rooms is in the spec, in no client, and not excluded
TXT
  REF=pro-v0.4.3 VERSION=0.4.3 SHA=99a7284230b2df6200fd91795ad8e1cb09c1869a \
    COVERAGE_FILE="$XBERG_WORK/coverage.txt" BODY_FILE="$XBERG_WORK/body.md" run "$SCRIPT" body
  xberg_assert_status 0
  grep -qx -- '- ref: `pro-v0.4.3`' "$XBERG_WORK/body.md"
  grep -qx -- '- commit: `99a7284230b2df6200fd91795ad8e1cb09c1869a`' "$XBERG_WORK/body.md"
  grep -q 'enterprise: GET /v1/rooms is in the spec, in no client' "$XBERG_WORK/body.md"
  grep -q 'enterprise  52/84 reached' "$XBERG_WORK/body.md"
}

@test "body says there are no gaps when the report lists none" {
  printf 'enterprise  84/84 reached, 0 excluded, 0 tracked as pending\n' >"$XBERG_WORK/coverage.txt"
  REF=development VERSION=latest SHA=99a7284230b2df6200fd91795ad8e1cb09c1869a \
    COVERAGE_FILE="$XBERG_WORK/coverage.txt" BODY_FILE="$XBERG_WORK/body.md" run "$SCRIPT" body
  xberg_assert_status 0
  grep -qx 'Spec coverage: no gaps.' "$XBERG_WORK/body.md"
}

@test "body fails when the coverage run crashed and left no tier rows" {
  printf 'Traceback (most recent call last):\nFileNotFoundError: spec\n' >"$XBERG_WORK/coverage.txt"
  REF=a VERSION=1 SHA=b COVERAGE_FILE="$XBERG_WORK/coverage.txt" BODY_FILE="$XBERG_WORK/body.md" run "$SCRIPT" body
  xberg_assert_status 1
  xberg_assert_output_contains "no tier rows"
  xberg_assert_file_absent "$XBERG_WORK/body.md"
}

@test "body fails when the coverage report is missing" {
  REF=a VERSION=1 SHA=b COVERAGE_FILE="$XBERG_WORK/none.txt" BODY_FILE="$XBERG_WORK/body.md" run "$SCRIPT" body
  xberg_assert_status 1
  xberg_assert_output_contains "does not exist"
}

@test "an unknown subcommand is a usage error" {
  run "$SCRIPT" bogus
  xberg_assert_status 1
  xberg_assert_output_contains "usage:"
}
