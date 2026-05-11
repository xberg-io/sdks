// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'page_content.freezed.dart';
part 'page_content.g.dart';

/// Per-page content.
@Freezed()
abstract class PageContent with _$PageContent {
  const factory PageContent({
    /// Page number (0-indexed)
    @JsonKey(name: 'page_number')
    required int pageNumber,

    /// Extracted text for this page
    String? content,

    /// Whether the page is blank
    @JsonKey(name: 'is_blank')
    bool? isBlank,
  }) = _PageContent;
  
  factory PageContent.fromJson(Map<String, Object?> json) => _$PageContentFromJson(json);
}
