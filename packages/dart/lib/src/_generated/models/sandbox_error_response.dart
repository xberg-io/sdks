// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'sandbox_error_response.freezed.dart';
part 'sandbox_error_response.g.dart';

/// Error response for sandbox key endpoint
@Freezed()
abstract class SandboxErrorResponse with _$SandboxErrorResponse {
  const factory SandboxErrorResponse({
    /// Error code
    required String error,

    /// Human-readable error message
    required String message,
  }) = _SandboxErrorResponse;

  factory SandboxErrorResponse.fromJson(Map<String, Object?> json) =>
      _$SandboxErrorResponseFromJson(json);
}
