// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'readiness_checks.dart';

part 'readiness_response.freezed.dart';
part 'readiness_response.g.dart';

/// Readiness check response with dependency status
@Freezed()
abstract class ReadinessResponse with _$ReadinessResponse {
  const factory ReadinessResponse({
    /// Dependency check results
    required ReadinessChecks checks,

    /// Overall readiness status
    required String status,
  }) = _ReadinessResponse;

  factory ReadinessResponse.fromJson(Map<String, Object?> json) =>
      _$ReadinessResponseFromJson(json);
}
