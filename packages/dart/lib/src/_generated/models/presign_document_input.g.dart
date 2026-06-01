// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'presign_document_input.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PresignDocumentInput _$PresignDocumentInputFromJson(
  Map<String, dynamic> json,
) => _PresignDocumentInput(
  filename: json['filename'] as String,
  mimeType: json['mime_type'] as String,
  config: json['config'] == null
      ? null
      : FileExtractionConfig.fromJson(json['config'] as Map<String, dynamic>),
);

Map<String, dynamic> _$PresignDocumentInputToJson(
  _PresignDocumentInput instance,
) => <String, dynamic>{
  'filename': instance.filename,
  'mime_type': instance.mimeType,
  'config': instance.config,
};
