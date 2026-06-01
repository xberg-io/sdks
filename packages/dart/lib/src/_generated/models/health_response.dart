// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'health_response.freezed.dart';
part 'health_response.g.dart';

/// Health check response for liveness probes
@Freezed()
abstract class HealthResponse with _$HealthResponse {
  const factory HealthResponse({
    /// Service status
    required String status,
  }) = _HealthResponse;

  factory HealthResponse.fromJson(Map<String, Object?> json) =>
      _$HealthResponseFromJson(json);
}
