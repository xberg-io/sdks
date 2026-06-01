// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'page_boundary.freezed.dart';
part 'page_boundary.g.dart';

/// Byte offset boundary for a page.
///
/// Tracks where a specific page's content starts and ends in the main content string,.
/// enabling mapping from byte positions to page numbers. Offsets are guaranteed to be.
/// at valid UTF-8 character boundaries when using standard String methods (push_str, push, etc.).
@Freezed()
abstract class PageBoundary with _$PageBoundary {
  const factory PageBoundary({
    /// Byte offset where this page ends in the content string (UTF-8 valid boundary, exclusive)
    @JsonKey(name: 'byte_end') required int byteEnd,

    /// Byte offset where this page starts in the content string (UTF-8 valid boundary, inclusive)
    @JsonKey(name: 'byte_start') required int byteStart,

    /// Page number (1-indexed)
    @JsonKey(name: 'page_number') required int pageNumber,
  }) = _PageBoundary;

  factory PageBoundary.fromJson(Map<String, Object?> json) =>
      _$PageBoundaryFromJson(json);
}
