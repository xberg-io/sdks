// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'readiness_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ReadinessResponse _$ReadinessResponseFromJson(Map<String, dynamic> json) =>
    _ReadinessResponse(
      checks: ReadinessChecks.fromJson(json['checks'] as Map<String, dynamic>),
      status: json['status'] as String,
    );

Map<String, dynamic> _$ReadinessResponseToJson(_ReadinessResponse instance) =>
    <String, dynamic>{
      'checks': instance.checks,
      'status': instance.status,
    };
