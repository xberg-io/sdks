// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'usage_by_mime_type.freezed.dart';
part 'usage_by_mime_type.g.dart';

/// Usage statistics broken down by MIME type.
@Freezed()
abstract class UsageByMimeType with _$UsageByMimeType {
  const factory UsageByMimeType({
    /// Number of documents of this MIME type processed
    required int documents,

    /// Number of failed extractions for this MIME type
    required int failed,

    /// Total pages extracted from documents of this MIME type
    required int pages,
  }) = _UsageByMimeType;
  
  factory UsageByMimeType.fromJson(Map<String, Object?> json) => _$UsageByMimeTypeFromJson(json);
}
