// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ocr_element.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_OcrElement _$OcrElementFromJson(Map<String, dynamic> json) => _OcrElement(
  confidence: OcrConfidence.fromJson(
    json['confidence'] as Map<String, dynamic>,
  ),
  geometry: OcrBoundingGeometry.fromJson(
    json['geometry'] as Map<String, dynamic>,
  ),
  text: json['text'] as String,
  backendMetadata: json['backend_metadata'] as Map<String, dynamic>?,
  level: json['level'] == null
      ? null
      : OcrElementLevel.fromJson(json['level'] as String),
  pageNumber: (json['page_number'] as num?)?.toInt(),
  parentId: json['parent_id'] as String?,
  rotation: json['rotation'] == null
      ? null
      : OcrRotation.fromJson(json['rotation'] as Map<String, dynamic>),
);

Map<String, dynamic> _$OcrElementToJson(_OcrElement instance) =>
    <String, dynamic>{
      'confidence': instance.confidence,
      'geometry': instance.geometry,
      'text': instance.text,
      'backend_metadata': instance.backendMetadata,
      'level': instance.level,
      'page_number': instance.pageNumber,
      'parent_id': instance.parentId,
      'rotation': instance.rotation,
    };
