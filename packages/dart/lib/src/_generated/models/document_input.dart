// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'document_input.freezed.dart';
part 'document_input.g.dart';

/// Document input for JSON extraction requests
@Freezed()
abstract class DocumentInput with _$DocumentInput {
  const factory DocumentInput({
    /// Base64-encoded document data
    required String data,

    /// Original filename
    required String filename,

    /// MIME type of the document
    @JsonKey(name: 'mime_type') required String mimeType,

    /// Optional client-supplied document identifier. When provided, this.
    /// extraction is recorded as a version of that logical document and the.
    /// response carries `document_id` + `version_sequence`. Server mints a.
    /// new UUID when absent.
    @JsonKey(name: 'document_id') String? documentId,
  }) = _DocumentInput;

  factory DocumentInput.fromJson(Map<String, Object?> json) =>
      _$DocumentInputFromJson(json);
}
