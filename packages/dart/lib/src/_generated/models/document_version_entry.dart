// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'document_version_entry.freezed.dart';
part 'document_version_entry.g.dart';

/// Entry in the document versions list.
@Freezed()
abstract class DocumentVersionEntry with _$DocumentVersionEntry {
  const factory DocumentVersionEntry({
    /// Number of billable pages.
    @JsonKey(name: 'billable_pages') required int billablePages,

    /// SHA-256 hash of the extracted content.
    @JsonKey(name: 'content_hash') required String contentHash,

    /// When the job was created.
    @JsonKey(name: 'created_at') required String createdAt,

    /// File size in bytes.
    @JsonKey(name: 'file_size_bytes') required int fileSizeBytes,

    /// Original filename.
    required String filename,

    /// Job ID for this version.
    @JsonKey(name: 'job_id') required String jobId,

    /// MIME type of the uploaded file.
    @JsonKey(name: 'mime_type') required String mimeType,

    /// Number of pages extracted.
    @JsonKey(name: 'pages_extracted') required int pagesExtracted,

    /// Job status.
    required String status,

    /// Version sequence number (incrementing per document).
    @JsonKey(name: 'version_sequence') required int versionSequence,

    /// When processing completed (only set for completed/failed jobs).
    @JsonKey(name: 'processing_completed_at') String? processingCompletedAt,
  }) = _DocumentVersionEntry;

  factory DocumentVersionEntry.fromJson(Map<String, Object?> json) =>
      _$DocumentVersionEntryFromJson(json);
}
