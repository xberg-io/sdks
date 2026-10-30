setup() {
  bats_load_library xberg-bats
  xberg_setup
  REPO_ROOT="$(cd "$BATS_TEST_DIRNAME/../.." && pwd -P)"
}

@test "enterprise wrapper preserves argument boundaries" {
  xberg_stub uv 'printf "<%s>\n" "$@"'
  run bash "$REPO_ROOT/scripts/enterprise-stack.sh" --tier pro 'two words'
  xberg_assert_status 0
  xberg_assert_output "$(printf '<%s>\n' run --project "$REPO_ROOT" python "$REPO_ROOT/scripts/enterprise-stack.py" --tier pro 'two words')"
}

@test "Pro contract wrapper forwards URL and reports uv failures" {
  xberg_stub_trace uv
  run bash "$REPO_ROOT/scripts/pro-contract-check.sh" https://example.test
  xberg_assert_status 0
  xberg_assert_trace "uv run --project $REPO_ROOT python $REPO_ROOT/scripts/live-sdk-contracts.py verify --tier pro --base-url https://example.test"
  xberg_stub_exit uv 29
  run bash "$REPO_ROOT/scripts/pro-contract-check.sh"
  xberg_assert_status 29
}

@test "Pro project key requires an explicit operator credential" {
  xberg_stub uv 'printf must-not-run; exit 99'
  run env -u XBERG_ADMIN_KEY bash "$REPO_ROOT/scripts/pro-project-key.sh"
  xberg_assert_status 1
  xberg_assert_output_contains 'XBERG_ADMIN_KEY is required'
  [[ "$output" != *must-not-run* ]]
}

@test "Pro project key forwards credential in environment and defaults its URL" {
  xberg_stub uv 'test "${XBERG_ADMIN_KEY:-}" = fixture-operator; printf "<%s>\n" "$@"'
  run env XBERG_ADMIN_KEY=fixture-operator bash "$REPO_ROOT/scripts/pro-project-key.sh"
  xberg_assert_status 0
  xberg_assert_output "$(printf '<%s>\n' run --project "$REPO_ROOT" python "$REPO_ROOT/scripts/live-sdk-contracts.py" pro-key --base-url http://127.0.0.1:8080)"
}

@test "TypeScript generation keeps all three schemas separate before alignment" {
  mkdir -p "$XBERG_WORK/packages/typescript/scripts"
  cp "$REPO_ROOT/packages/typescript/scripts/generate.sh" "$XBERG_WORK/packages/typescript/scripts/"
  xberg_stub_trace pnpm
  xberg_stub_trace node
  run bash "$XBERG_WORK/packages/typescript/scripts/generate.sh"
  xberg_assert_status 0
  expected=""
  for schema in api pro backend; do
    expected+="pnpm exec openapi-typescript $XBERG_WORK/spec/$schema/openapi.yaml -o $XBERG_WORK/packages/typescript/src/_generated/$schema.d.ts --empty-objects-unknown"$'\n'
  done
  expected+="node $XBERG_WORK/packages/typescript/scripts/align-generated.mjs $XBERG_WORK/packages/typescript/src/_generated"
  xberg_assert_trace "$expected"
}

@test "TypeScript generation does not align after code generation fails" {
  xberg_stub_exit pnpm 32
  xberg_stub_trace node
  mkdir -p "$XBERG_WORK/packages/typescript/scripts"
  cp "$REPO_ROOT/packages/typescript/scripts/generate.sh" "$XBERG_WORK/packages/typescript/scripts/"
  run bash "$XBERG_WORK/packages/typescript/scripts/generate.sh"
  xberg_assert_status 32
  xberg_assert_trace_empty
}

archive_fixture() {
  mkdir -p "$XBERG_WORK/archive/packages/go/testdata/public-v0.8.0"
  for file in generated_api.go generated_pro.go generated_backend.go; do
    printf 'package xberg\n' >"$XBERG_WORK/archive/packages/go/$file"
  done
  for ((i = 0; i < ${1:-720}; i++)); do
    printf '_ xberg.Type\n'
  done >"$XBERG_WORK/archive/packages/go/testdata/public-v0.8.0/contract.go"
  export SDK_ARCHIVE="$XBERG_WORK/sdk.tar"
  tar -cf "$SDK_ARCHIVE" -C "$XBERG_WORK/archive" packages
  xberg_stub git 'if [ "$1" = rev-parse ]; then printf "%s\n" "$REPO_ROOT"; else cat "$SDK_ARCHIVE"; fi'
  export REPO_ROOT
  xberg_stub go 'printf "%s:%s\n" "$GOWORK" "$*" >>"$XBERG_TRACE"'
}

@test "Go package consumer uses committed sources with workspace resolution disabled" {
  archive_fixture
  run bash "$REPO_ROOT/packages/go/test-package.sh"
  xberg_assert_status 0
  xberg_assert_output_contains 'expected 720, actual 720'
  mapfile -t calls <"$XBERG_TRACE"
  [ "${#calls[@]}" -eq 4 ]
  [ "${calls[0]}" = 'off:mod init consumer.example/sdk' ]
  [[ "${calls[1]}" == off:mod\ edit\ -replace\ github.com/xberg-io/sdks/packages/go=*'/sdk' ]]
  [ "${calls[2]}" = 'off:mod tidy' ]
  [ "${calls[3]}" = 'off:build ./...' ]
}

@test "Go package consumer rejects an incomplete public contract before building" {
  archive_fixture 719
  run bash "$REPO_ROOT/packages/go/test-package.sh"
  xberg_assert_status 1
  xberg_assert_output_contains 'expected 720, actual 719'
  [ "$(wc -l <"$XBERG_TRACE" | tr -d ' ')" -eq 2 ]
}

@test "shared helper sync checks pinned bytes and rejects content drift" {
  xberg_stub_curl_file "$BATS_TEST_DIRNAME/lib/xberg-bats/load.bash"
  export BATS_LIB_REF=d922e0d1126e82b39b2eb8d3be899d7fe7345190
  export BATS_LIB_DEST="$XBERG_WORK/lib"
  run bash "$REPO_ROOT/scripts/sync-bats-lib.sh" sync
  xberg_assert_status 0
  run bash "$REPO_ROOT/scripts/sync-bats-lib.sh" --check
  xberg_assert_status 0
  printf 'changed\n' >>"$BATS_LIB_DEST/load.bash"
  run bash "$REPO_ROOT/scripts/sync-bats-lib.sh" --check
  xberg_assert_status 1
  xberg_assert_output_contains 'has drifted'
}
