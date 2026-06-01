// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'error_response.freezed.dart';
part 'error_response.g.dart';

/// Error response
@Freezed()
abstract class ErrorResponse with _$ErrorResponse {
  const factory ErrorResponse({
    /// Error message
    required String error,
  }) = _ErrorResponse;

  factory ErrorResponse.fromJson(Map<String, Object?> json) =>
      _$ErrorResponseFromJson(json);
}
