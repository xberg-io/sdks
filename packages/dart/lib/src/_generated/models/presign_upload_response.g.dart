// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'presign_upload_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PresignUploadResponse _$PresignUploadResponseFromJson(
  Map<String, dynamic> json,
) => _PresignUploadResponse(
  batchId: json['batch_id'] as String,
  uploads: (json['uploads'] as List<dynamic>)
      .map((e) => PresignedUploadInfo.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$PresignUploadResponseToJson(
  _PresignUploadResponse instance,
) => <String, dynamic>{
  'batch_id': instance.batchId,
  'uploads': instance.uploads,
};
