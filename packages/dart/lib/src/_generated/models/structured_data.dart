// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'structured_data_type.dart';

part 'structured_data.freezed.dart';
part 'structured_data.g.dart';

/// Structured data (Schema.org, microdata, RDFa) block.
@Freezed()
abstract class StructuredData with _$StructuredData {
  const factory StructuredData({
    /// Type of structured data
    @JsonKey(name: 'data_type') required StructuredDataType dataType,

    /// Raw JSON string representation
    @JsonKey(name: 'raw_json') required String rawJson,

    /// Schema type if detectable (e.g., "Article", "Event", "Product")
    @JsonKey(name: 'schema_type') String? schemaType,
  }) = _StructuredData;

  factory StructuredData.fromJson(Map<String, Object?> json) =>
      _$StructuredDataFromJson(json);
}
