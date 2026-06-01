// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'document_submission.freezed.dart';
part 'document_submission.g.dart';

/// Per-document submission metadata
@Freezed()
abstract class DocumentSubmission with _$DocumentSubmission {
  const factory DocumentSubmission({
    /// Job ID for the submitted document
    @JsonKey(name: 'job_id') required String jobId,

    /// Optional document ID from lineage (None for non-lineage jobs)
    @JsonKey(name: 'document_id') String? documentId,

    /// Optional version sequence for lineage (None for non-lineage jobs)
    @JsonKey(name: 'version_sequence') int? versionSequence,
  }) = _DocumentSubmission;

  factory DocumentSubmission.fromJson(Map<String, Object?> json) =>
      _$DocumentSubmissionFromJson(json);
}
