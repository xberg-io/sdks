// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'file_extraction_config.dart';

part 'presign_document_input.freezed.dart';
part 'presign_document_input.g.dart';

/// Document metadata for presigned upload (no bytes)
@Freezed()
abstract class PresignDocumentInput with _$PresignDocumentInput {
  const factory PresignDocumentInput({
    /// Original filename
    required String filename,

    /// MIME type of the document
    @JsonKey(name: 'mime_type') required String mimeType,

    /// Per-file extraction config override.
    /// Merged with batch-level `config` at confirm time. None = use batch default.
    FileExtractionConfig? config,
  }) = _PresignDocumentInput;

  factory PresignDocumentInput.fromJson(Map<String, Object?> json) =>
      _$PresignDocumentInputFromJson(json);
}
