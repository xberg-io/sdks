// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'presigned_upload_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PresignedUploadInfo _$PresignedUploadInfoFromJson(Map<String, dynamic> json) =>
    _PresignedUploadInfo(
      expiresInSecs: (json['expires_in_secs'] as num).toInt(),
      jobId: json['job_id'] as String,
      method: json['method'] as String,
      objectKey: json['object_key'] as String,
      uploadUrl: json['upload_url'] as String,
    );

Map<String, dynamic> _$PresignedUploadInfoToJson(
        _PresignedUploadInfo instance) =>
    <String, dynamic>{
      'expires_in_secs': instance.expiresInSecs,
      'job_id': instance.jobId,
      'method': instance.method,
      'object_key': instance.objectKey,
      'upload_url': instance.uploadUrl,
    };
