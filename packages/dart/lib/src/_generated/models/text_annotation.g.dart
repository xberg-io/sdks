// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'text_annotation.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TextAnnotation _$TextAnnotationFromJson(Map<String, dynamic> json) =>
    _TextAnnotation(
      end: (json['end'] as num).toInt(),
      kind: AnnotationKind.fromJson(json['kind'] as Map<String, dynamic>),
      start: (json['start'] as num).toInt(),
    );

Map<String, dynamic> _$TextAnnotationToJson(_TextAnnotation instance) =>
    <String, dynamic>{
      'end': instance.end,
      'kind': instance.kind,
      'start': instance.start,
    };
