// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'diff_job_status.dart';

part 'diff_async_accepted.freezed.dart';
part 'diff_async_accepted.g.dart';

/// Response for a submitted async diff job.
@Freezed()
abstract class DiffAsyncAccepted with _$DiffAsyncAccepted {
  const factory DiffAsyncAccepted({
    /// The ID of the diff job for polling.
    @JsonKey(name: 'diff_job_id') required String diffJobId,

    /// Current status of the job.
    required DiffJobStatus status,
  }) = _DiffAsyncAccepted;

  factory DiffAsyncAccepted.fromJson(Map<String, Object?> json) =>
      _$DiffAsyncAcceptedFromJson(json);
}
