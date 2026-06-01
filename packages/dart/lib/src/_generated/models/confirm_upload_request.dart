// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'confirm_upload_request.freezed.dart';
part 'confirm_upload_request.g.dart';

/// Request body for confirming uploads
@Freezed()
abstract class ConfirmUploadRequest with _$ConfirmUploadRequest {
  const factory ConfirmUploadRequest({
    /// Batch ID from the presign response
    @JsonKey(name: 'batch_id') required String batchId,
  }) = _ConfirmUploadRequest;

  factory ConfirmUploadRequest.fromJson(Map<String, Object?> json) =>
      _$ConfirmUploadRequestFromJson(json);
}
