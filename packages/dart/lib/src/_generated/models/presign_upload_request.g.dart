// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'presign_upload_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PresignUploadRequest _$PresignUploadRequestFromJson(
  Map<String, dynamic> json,
) => _PresignUploadRequest(
  documents: (json['documents'] as List<dynamic>)
      .map((e) => PresignDocumentInput.fromJson(e as Map<String, dynamic>))
      .toList(),
  config: json['config'] == null
      ? null
      : ExtractionConfig.fromJson(json['config'] as Map<String, dynamic>),
  webhook: json['webhook'] == null
      ? null
      : WebhookConfig.fromJson(json['webhook'] as Map<String, dynamic>),
);

Map<String, dynamic> _$PresignUploadRequestToJson(
  _PresignUploadRequest instance,
) => <String, dynamic>{
  'documents': instance.documents,
  'config': instance.config,
  'webhook': instance.webhook,
};
