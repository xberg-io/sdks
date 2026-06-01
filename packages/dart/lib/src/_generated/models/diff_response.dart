// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'diff_response.freezed.dart';
part 'diff_response.g.dart';

/// Response envelope for a computed diff between two extraction results.
@Freezed()
abstract class DiffResponse with _$DiffResponse {
  const factory DiffResponse({
    /// Timestamp when the diff was computed.
    @JsonKey(name: 'computed_at') required DateTime computedAt,

    /// The computed diff between the two extraction results.
    ///
    /// Serialized to the wire as the full `kreuzberg::diff::ExtractionDiff`.
    /// shape. The OpenAPI schema declares this as an opaque object because.
    /// the underlying type recurses through `EmbeddedDiff -> Box<ExtractionDiff>`.
    /// and utoipa's schema collector goes into a stack-overflow on inlined.
    /// recursion. SDKs that want a typed surface here should decode the.
    /// JSON manually against kreuzberg's published schema.
    required dynamic diff,

    /// Document ID being diffed.
    @JsonKey(name: 'document_id') required String documentId,

    /// Job ID of the "from" (older) version.
    @JsonKey(name: 'from_job_id') required String fromJobId,

    /// Version sequence number of the "from" version.
    @JsonKey(name: 'from_version') required int fromVersion,

    /// Job ID of the "to" (newer) version.
    @JsonKey(name: 'to_job_id') required String toJobId,

    /// Version sequence number of the "to" version.
    @JsonKey(name: 'to_version') required int toVersion,
  }) = _DiffResponse;

  factory DiffResponse.fromJson(Map<String, Object?> json) =>
      _$DiffResponseFromJson(json);
}
