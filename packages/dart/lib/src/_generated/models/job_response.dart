// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'extraction_result.dart';
import 'job_status.dart';

part 'job_response.freezed.dart';
part 'job_response.g.dart';

/// Response for job status query
@Freezed()
abstract class JobResponse with _$JobResponse {
  const factory JobResponse({
    /// Job creation timestamp (RFC3339)
    @JsonKey(name: 'created_at') required DateTime createdAt,

    /// Original filename
    required String filename,

    /// Unique job identifier (UUID)
    required String id,

    /// Job status
    required JobStatus status,

    /// Server-side processing duration in milliseconds (only present when completed)
    @JsonKey(name: 'processing_time_ms') int? processingTimeMs,

    /// Extraction result (only present when status is completed/partial_success)
    ExtractionResult? result,
  }) = _JobResponse;

  factory JobResponse.fromJson(Map<String, Object?> json) =>
      _$JobResponseFromJson(json);
}
