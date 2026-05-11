// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'confirm_upload_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ConfirmUploadResponse _$ConfirmUploadResponseFromJson(
        Map<String, dynamic> json) =>
    _ConfirmUploadResponse(
      jobIds:
          (json['job_ids'] as List<dynamic>).map((e) => e as String).toList(),
      status: json['status'] as String,
    );

Map<String, dynamic> _$ConfirmUploadResponseToJson(
        _ConfirmUploadResponse instance) =>
    <String, dynamic>{
      'job_ids': instance.jobIds,
      'status': instance.status,
    };
