// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'usage_by_mime_type.dart';

part 'usage_response.freezed.dart';
part 'usage_response.g.dart';

/// Current period usage and quota information.
@Freezed()
abstract class UsageResponse with _$UsageResponse {
  const factory UsageResponse({
    /// Usage breakdown by MIME type
    @JsonKey(name: 'by_mime_type')
    required Map<String, UsageByMimeType> byMimeType,

    /// End of the reporting period (ISO 8601 date)
    @JsonKey(name: 'period_end') required String periodEnd,

    /// Start of the reporting period (ISO 8601 date)
    @JsonKey(name: 'period_start') required String periodStart,

    /// Total documents processed in the period
    @JsonKey(name: 'total_documents') required int totalDocuments,

    /// Total failed extractions in the period
    @JsonKey(name: 'total_failed') required int totalFailed,

    /// Total pages extracted in the period
    @JsonKey(name: 'total_pages') required int totalPages,

    /// Monthly page quota limit (null = unlimited)
    @JsonKey(name: 'quota_limit') int? quotaLimit,

    /// Remaining pages in monthly quota (null = unlimited)
    @JsonKey(name: 'quota_remaining') int? quotaRemaining,
  }) = _UsageResponse;

  factory UsageResponse.fromJson(Map<String, Object?> json) =>
      _$UsageResponseFromJson(json);
}
