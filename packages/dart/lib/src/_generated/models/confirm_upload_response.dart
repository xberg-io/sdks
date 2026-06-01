// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'confirm_upload_response.freezed.dart';
part 'confirm_upload_response.g.dart';

/// Response from confirm endpoint
@Freezed()
abstract class ConfirmUploadResponse with _$ConfirmUploadResponse {
  const factory ConfirmUploadResponse({
    /// Job IDs that are now queued for processing
    @JsonKey(name: 'job_ids') required List<String> jobIds,

    /// Status of the jobs
    required String status,
  }) = _ConfirmUploadResponse;

  factory ConfirmUploadResponse.fromJson(Map<String, Object?> json) =>
      _$ConfirmUploadResponseFromJson(json);
}
