// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'extract_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ExtractResponse _$ExtractResponseFromJson(Map<String, dynamic> json) =>
    _ExtractResponse(
      jobIds:
          (json['job_ids'] as List<dynamic>).map((e) => e as String).toList(),
      status: json['status'] as String,
    );

Map<String, dynamic> _$ExtractResponseToJson(_ExtractResponse instance) =>
    <String, dynamic>{
      'job_ids': instance.jobIds,
      'status': instance.status,
    };
