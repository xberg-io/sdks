// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

/// Job status enumeration (1:1 with domain).
@JsonEnum()
enum JobStatus {
  @JsonValue('awaiting_upload')
  awaitingUpload('awaiting_upload'),
  @JsonValue('pending')
  pending('pending'),
  @JsonValue('processing')
  processing('processing'),
  @JsonValue('chunking')
  chunking('chunking'),
  @JsonValue('aggregating')
  aggregating('aggregating'),
  @JsonValue('completed')
  completed('completed'),
  @JsonValue('partial_success')
  partialSuccess('partial_success'),
  @JsonValue('failed')
  failed('failed'),
  @JsonValue('cancelled')
  cancelled('cancelled'),
  /// Default value for all unparsed values, allows backward compatibility when adding new values on the backend.
  $unknown(null);

  const JobStatus(this.json);

  factory JobStatus.fromJson(String json) => values.firstWhere(
        (e) => e.json == json,
        orElse: () => $unknown,
      );

  final String? json;
  String toJson() {
    final value = json;
    if (value == null) {
      throw StateError('Cannot convert enum value with null JSON representation to String. '
          'This usually happens for \$unknown or @JsonValue(null) entries.');
    }
    return value as String;
  }

  @override
  String toString() => json?.toString() ?? super.toString();
  /// Returns all defined enum values excluding the $unknown value.
  static List<JobStatus> get $valuesDefined => values.where((value) => value != $unknown).toList();
}
