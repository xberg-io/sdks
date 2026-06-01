// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'readiness_checks.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ReadinessChecks _$ReadinessChecksFromJson(Map<String, dynamic> json) =>
    _ReadinessChecks(
      database: json['database'] as String,
      nats: json['nats'] as String,
    );

Map<String, dynamic> _$ReadinessChecksToJson(_ReadinessChecks instance) =>
    <String, dynamic>{'database': instance.database, 'nats': instance.nats};
