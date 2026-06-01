// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'error_metadata.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ErrorMetadata _$ErrorMetadataFromJson(Map<String, dynamic> json) =>
    _ErrorMetadata(
      errorType: json['error_type'] as String,
      message: json['message'] as String,
    );

Map<String, dynamic> _$ErrorMetadataToJson(_ErrorMetadata instance) =>
    <String, dynamic>{
      'error_type': instance.errorType,
      'message': instance.message,
    };
