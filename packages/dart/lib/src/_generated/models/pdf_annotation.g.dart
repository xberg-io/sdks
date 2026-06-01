// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pdf_annotation.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PdfAnnotation _$PdfAnnotationFromJson(Map<String, dynamic> json) =>
    _PdfAnnotation(
      annotationType: PdfAnnotationType.fromJson(
        json['annotation_type'] as String,
      ),
      pageNumber: (json['page_number'] as num).toInt(),
      boundingBox: json['bounding_box'] == null
          ? null
          : BoundingBox.fromJson(json['bounding_box'] as Map<String, dynamic>),
      content: json['content'] as String?,
    );

Map<String, dynamic> _$PdfAnnotationToJson(_PdfAnnotation instance) =>
    <String, dynamic>{
      'annotation_type': instance.annotationType,
      'page_number': instance.pageNumber,
      'bounding_box': instance.boundingBox,
      'content': instance.content,
    };
