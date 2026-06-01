// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'revision_anchor.dart';
import 'revision_delta.dart';
import 'revision_kind.dart';

part 'document_revision.freezed.dart';
part 'document_revision.g.dart';

/// A single tracked change embedded in a document.
///
/// Populated by per-format extractors that understand change-tracking metadata.
/// (DOCX `w:ins`/`w:del`/`w:rPrChange`, ODT `text:change-*`, …). Every.
/// extractor defaults to `ExtractionResult.revisions = None` until a.
/// format-specific implementation is added.
@Freezed()
abstract class DocumentRevision with _$DocumentRevision {
  const factory DocumentRevision({
    /// The content changes that make up this revision.
    required RevisionDelta delta,

    /// Semantic kind of this revision.
    required RevisionKind kind,

    /// Format-specific revision identifier.
    ///
    /// For DOCX this is the `w:id` attribute value on the change element.
    /// (e.g. `"42"`). When the attribute is absent a synthetic fallback is.
    /// generated (`"docx-ins-0"`, `"docx-del-3"`, …).
    @JsonKey(name: 'revision_id')
    required String revisionId,

    /// Best-effort document location for this revision.
    ///
    /// Resolution is format-dependent and may be `None` when the location.
    /// cannot be determined (e.g. changes inside table cells before.
    /// table-cell anchor support is added).
    RevisionAnchor? anchor,

    /// Display name of the author who made this change, when available.
    String? author,

    /// ISO-8601 timestamp of the change, when available.
    ///
    /// Stored as a plain string so this type remains FFI-friendly and.
    /// unconditionally available without the `chrono` optional dep.
    /// DOCX populates this from the `w:date` attribute (e.g.
    /// `"2024-03-15T10:30:00Z"`).
    String? timestamp,
  }) = _DocumentRevision;
  
  factory DocumentRevision.fromJson(Map<String, Object?> json) => _$DocumentRevisionFromJson(json);
}
