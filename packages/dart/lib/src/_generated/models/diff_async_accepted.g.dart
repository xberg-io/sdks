// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'diff_async_accepted.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_DiffAsyncAccepted _$DiffAsyncAcceptedFromJson(Map<String, dynamic> json) =>
    _DiffAsyncAccepted(
      diffJobId: json['diff_job_id'] as String,
      status: DiffJobStatus.fromJson(json['status'] as String),
    );

Map<String, dynamic> _$DiffAsyncAcceptedToJson(_DiffAsyncAccepted instance) =>
    <String, dynamic>{
      'diff_job_id': instance.diffJobId,
      'status': instance.status,
    };
