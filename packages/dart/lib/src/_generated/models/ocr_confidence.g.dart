// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ocr_confidence.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_OcrConfidence _$OcrConfidenceFromJson(Map<String, dynamic> json) =>
    _OcrConfidence(
      recognition: (json['recognition'] as num).toDouble(),
      detection: (json['detection'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$OcrConfidenceToJson(_OcrConfidence instance) =>
    <String, dynamic>{
      'recognition': instance.recognition,
      'detection': instance.detection,
    };
