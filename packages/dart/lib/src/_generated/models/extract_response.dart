// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'extract_response.freezed.dart';
part 'extract_response.g.dart';

/// Extract response (HTTP 202)
@Freezed()
abstract class ExtractResponse with _$ExtractResponse {
  const factory ExtractResponse({
    /// Job status
    required String status,

    /// Crawl job IDs (one per URL group)
    @JsonKey(name: 'crawl_job_ids')
    List<String>? crawlJobIds,

    /// Job IDs for direct file extractions
    @JsonKey(name: 'job_ids')
    List<String>? jobIds,
  }) = _ExtractResponse;
  
  factory ExtractResponse.fromJson(Map<String, Object?> json) => _$ExtractResponseFromJson(json);
}
