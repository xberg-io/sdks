// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'error_metadata.freezed.dart';
part 'error_metadata.g.dart';

/// Error metadata (for batch operations).
@Freezed()
abstract class ErrorMetadata with _$ErrorMetadata {
  const factory ErrorMetadata({
    @JsonKey(name: 'error_type')
    required String errorType,
    required String message,
  }) = _ErrorMetadata;
  
  factory ErrorMetadata.fromJson(Map<String, Object?> json) => _$ErrorMetadataFromJson(json);
}
