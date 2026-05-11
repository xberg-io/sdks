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
    /// Job IDs for tracking (one per document)
    @JsonKey(name: 'job_ids')
    required List<String> jobIds,

    /// Job status
    required String status,
  }) = _ExtractResponse;
  
  factory ExtractResponse.fromJson(Map<String, Object?> json) => _$ExtractResponseFromJson(json);
}
