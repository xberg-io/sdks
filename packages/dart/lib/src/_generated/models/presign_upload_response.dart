// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'presigned_upload_info.dart';

part 'presign_upload_response.freezed.dart';
part 'presign_upload_response.g.dart';

/// Response from presign endpoint
@Freezed()
abstract class PresignUploadResponse with _$PresignUploadResponse {
  const factory PresignUploadResponse({
    /// Batch ID — pass this to the confirm endpoint
    @JsonKey(name: 'batch_id') required String batchId,

    /// Per-document upload URLs
    required List<PresignedUploadInfo> uploads,
  }) = _PresignUploadResponse;

  factory PresignUploadResponse.fromJson(Map<String, Object?> json) =>
      _$PresignUploadResponseFromJson(json);
}
