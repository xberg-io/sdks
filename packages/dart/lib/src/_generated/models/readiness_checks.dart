// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'readiness_checks.freezed.dart';
part 'readiness_checks.g.dart';

/// Individual dependency check results
@Freezed()
abstract class ReadinessChecks with _$ReadinessChecks {
  const factory ReadinessChecks({
    /// Database connectivity
    required String database,

    /// NATS connectivity
    required String nats,
  }) = _ReadinessChecks;

  factory ReadinessChecks.fromJson(Map<String, Object?> json) =>
      _$ReadinessChecksFromJson(json);
}
