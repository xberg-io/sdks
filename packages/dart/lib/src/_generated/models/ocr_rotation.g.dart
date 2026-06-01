// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ocr_rotation.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_OcrRotation _$OcrRotationFromJson(Map<String, dynamic> json) => _OcrRotation(
  angleDegrees: (json['angle_degrees'] as num).toDouble(),
  confidence: (json['confidence'] as num?)?.toDouble(),
);

Map<String, dynamic> _$OcrRotationToJson(_OcrRotation instance) =>
    <String, dynamic>{
      'angle_degrees': instance.angleDegrees,
      'confidence': instance.confidence,
    };
