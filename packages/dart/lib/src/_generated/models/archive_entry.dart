// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'extraction_result.dart';

part 'archive_entry.freezed.dart';
part 'archive_entry.g.dart';

/// A single file extracted from an archive.
///
/// When archives (ZIP, TAR, 7Z, GZIP) are extracted with recursive extraction.
/// enabled, each processable file produces its own full `ExtractionResult`.
@Freezed()
abstract class ArchiveEntry with _$ArchiveEntry {
  const factory ArchiveEntry({
    /// Detected MIME type of the file.
    @JsonKey(name: 'mime_type')
    required String mimeType,

    /// Archive-relative file path (e.g. "folder/document.pdf").
    required String path,

    /// Full extraction result for this file.
    required ExtractionResult result,
  }) = _ArchiveEntry;
  
  factory ArchiveEntry.fromJson(Map<String, Object?> json) => _$ArchiveEntryFromJson(json);
}
