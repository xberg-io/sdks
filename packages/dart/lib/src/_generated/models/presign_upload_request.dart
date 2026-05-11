// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'extraction_config.dart';
import 'presign_document_input.dart';
import 'webhook_config.dart';

part 'presign_upload_request.freezed.dart';
part 'presign_upload_request.g.dart';

/// Request body for presigning upload URLs
@Freezed()
abstract class PresignUploadRequest with _$PresignUploadRequest {
  const factory PresignUploadRequest({
    /// Document metadata (no file data)
    required List<PresignDocumentInput> documents,

    /// Batch-level extraction configuration (applied to all documents)
    ExtractionConfig? config,

    /// Webhook configuration for async result delivery
    WebhookConfig? webhook,
  }) = _PresignUploadRequest;
  
  factory PresignUploadRequest.fromJson(Map<String, Object?> json) => _$PresignUploadRequestFromJson(json);
}
