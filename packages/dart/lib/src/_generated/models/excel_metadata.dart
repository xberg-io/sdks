// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'format_metadata.dart';

part 'excel_metadata.freezed.dart';
part 'excel_metadata.g.dart';

/// Excel/spreadsheet format metadata.
///
/// Identifies the document as a spreadsheet source via the `FormatMetadata::Excel`.
/// discriminant. Sheet count and sheet names are stored inside this struct.
@Freezed()
abstract class ExcelMetadata with _$ExcelMetadata {
  const factory ExcelMetadata({
    /// Number of sheets in the workbook.
    @JsonKey(name: 'sheet_count')
    int? sheetCount,

    /// Names of all sheets in the workbook.
    @JsonKey(name: 'sheet_names')
    List<String>? sheetNames,
  }) = _ExcelMetadata;
  
  factory ExcelMetadata.fromJson(Map<String, Object?> json) => _$ExcelMetadataFromJson(json);
}
