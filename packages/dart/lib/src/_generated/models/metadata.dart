// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'page_structure.dart';

part 'metadata.freezed.dart';
part 'metadata.g.dart';

/// Document metadata — aligned with kreuzberg::Metadata.
@Freezed()
abstract class Metadata with _$Metadata {
  const factory Metadata({
    @JsonKey(name: 'abstract_text')
    String? abstractText,
    Map<String, dynamic>? additional,
    List<String>? authors,
    String? category,
    @JsonKey(name: 'created_at')
    String? createdAt,
    @JsonKey(name: 'created_by')
    String? createdBy,
    @JsonKey(name: 'document_version')
    String? documentVersion,
    @JsonKey(name: 'extraction_duration_ms')
    int? extractionDurationMs,
    List<String>? keywords,
    String? language,
    @JsonKey(name: 'modified_at')
    String? modifiedAt,
    @JsonKey(name: 'modified_by')
    String? modifiedBy,
    @JsonKey(name: 'output_format')
    String? outputFormat,
    PageStructure? pages,
    String? subject,
    List<String>? tags,
    String? title,
  }) = _Metadata;
  
  factory Metadata.fromJson(Map<String, Object?> json) => _$MetadataFromJson(json);
}
