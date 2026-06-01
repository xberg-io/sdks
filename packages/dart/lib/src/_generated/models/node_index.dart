// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

/// Newtype for node indices into the `DocumentStructure::nodes` array.
///
/// Uses `u32` for cross-platform consistency (WASM is 32-bit) and to avoid.
/// confusion with page numbers or other `usize` values.
typedef NodeIndex = int;
