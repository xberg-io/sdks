// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'presigned_upload_info.freezed.dart';
part 'presigned_upload_info.g.dart';

/// Info about a single presigned upload
@Freezed()
abstract class PresignedUploadInfo with _$PresignedUploadInfo {
  const factory PresignedUploadInfo({
    /// Seconds until the URL expires
    @JsonKey(name: 'expires_in_secs') required int expiresInSecs,

    /// Job ID for this document
    @JsonKey(name: 'job_id') required String jobId,

    /// HTTP method to use (PUT)
    required String method,

    /// Storage object key
    @JsonKey(name: 'object_key') required String objectKey,

    /// Presigned URL to upload the document to
    @JsonKey(name: 'upload_url') required String uploadUrl,
  }) = _PresignedUploadInfo;

  factory PresignedUploadInfo.fromJson(Map<String, Object?> json) =>
      _$PresignedUploadInfoFromJson(json);
}
