// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'format_metadata.dart';

part 'csv_metadata.freezed.dart';
part 'csv_metadata.g.dart';

/// CSV/TSV file metadata.
@Freezed()
abstract class CsvMetadata with _$CsvMetadata {
  const factory CsvMetadata({
    @JsonKey(name: 'column_count')
    required int columnCount,
    @JsonKey(name: 'has_header')
    required bool hasHeader,
    @JsonKey(name: 'row_count')
    required int rowCount,
    @JsonKey(name: 'column_types')
    List<String>? columnTypes,
    String? delimiter,
  }) = _CsvMetadata;
  
  factory CsvMetadata.fromJson(Map<String, Object?> json) => _$CsvMetadataFromJson(json);
}
