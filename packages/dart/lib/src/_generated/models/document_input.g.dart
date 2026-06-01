// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'document_input.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_DocumentInput _$DocumentInputFromJson(Map<String, dynamic> json) =>
    _DocumentInput(
      data: json['data'] as String,
      filename: json['filename'] as String,
      mimeType: json['mime_type'] as String,
      documentId: json['document_id'] as String?,
    );

Map<String, dynamic> _$DocumentInputToJson(_DocumentInput instance) =>
    <String, dynamic>{
      'data': instance.data,
      'filename': instance.filename,
      'mime_type': instance.mimeType,
      'document_id': instance.documentId,
    };
