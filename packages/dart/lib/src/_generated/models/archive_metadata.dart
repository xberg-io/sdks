// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'format_metadata.dart';

part 'archive_metadata.freezed.dart';
part 'archive_metadata.g.dart';

/// Archive (ZIP/TAR/7Z) metadata.
///
/// Extracted from compressed archive files containing file lists and size information.
@Freezed()
abstract class ArchiveMetadata with _$ArchiveMetadata {
  const factory ArchiveMetadata({
    /// Total number of files in the archive
    @JsonKey(name: 'file_count') required int fileCount,

    /// List of file paths within the archive
    @JsonKey(name: 'file_list') required List<String> fileList,

    /// Archive format ("ZIP", "TAR", "7Z", etc.)
    required String format,

    /// Total uncompressed size in bytes
    @JsonKey(name: 'total_size') required int totalSize,

    /// Compressed size in bytes (if available)
    @JsonKey(name: 'compressed_size') int? compressedSize,
  }) = _ArchiveMetadata;

  factory ArchiveMetadata.fromJson(Map<String, Object?> json) =>
      _$ArchiveMetadataFromJson(json);
}
