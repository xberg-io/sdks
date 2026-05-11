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
    @JsonKey(name: 'mime_type')
    required String mimeType,
  }) = _DocumentInput;
  
  factory DocumentInput.fromJson(Map<String, Object?> json) => _$DocumentInputFromJson(json);
}
