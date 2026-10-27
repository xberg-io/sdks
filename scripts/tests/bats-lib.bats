setup() {
  bats_load_library xberg-bats
  xberg_setup
}

@test "the vendored library matches the checksum pinned in SOURCE" {
  lib="$BATS_TEST_DIRNAME/lib/xberg-bats"
  pinned=$(sed -n 's/^sha256=\([0-9a-f]*\).*/\1/p' "$lib/SOURCE")
  [ -n "$pinned" ]
  run shasum -a 256 "$lib/load.bash"
  xberg_assert_status 0
  [ "${output%% *}" = "$pinned" ]
}

@test "BATS_LIB_PATH resolves to the repository copy" {
  [ "$BATS_LIB_PATH" = "$(cd "$BATS_TEST_DIRNAME/lib" && pwd)" ]
}
