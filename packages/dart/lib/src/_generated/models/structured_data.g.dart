// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'structured_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_StructuredData _$StructuredDataFromJson(Map<String, dynamic> json) =>
    _StructuredData(
      dataType: StructuredDataType.fromJson(json['data_type'] as String),
      rawJson: json['raw_json'] as String,
      schemaType: json['schema_type'] as String?,
    );

Map<String, dynamic> _$StructuredDataToJson(_StructuredData instance) =>
    <String, dynamic>{
      'data_type': instance.dataType,
      'raw_json': instance.rawJson,
      'schema_type': instance.schemaType,
    };
