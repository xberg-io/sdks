// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'extracted_image.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ExtractedImage _$ExtractedImageFromJson(
  Map<String, dynamic> json,
) => _ExtractedImage(
  data: (json['data'] as List<dynamic>).map((e) => (e as num).toInt()).toList(),
  format: json['format'] as String,
  imageIndex: (json['image_index'] as num).toInt(),
  bitsPerComponent: (json['bits_per_component'] as num?)?.toInt(),
  boundingBox: json['bounding_box'] == null
      ? null
      : BoundingBox.fromJson(json['bounding_box'] as Map<String, dynamic>),
  clusterId: (json['cluster_id'] as num?)?.toInt(),
  colorspace: json['colorspace'] as String?,
  description: json['description'] as String?,
  height: (json['height'] as num?)?.toInt(),
  imageKind: json['image_kind'] == null
      ? null
      : ImageKind.fromJson(json['image_kind'] as String),
  isMask: json['is_mask'] as bool?,
  kindConfidence: (json['kind_confidence'] as num?)?.toDouble(),
  ocrResult: json['ocr_result'] == null
      ? null
      : ExtractionResult.fromJson(json['ocr_result'] as Map<String, dynamic>),
  pageNumber: (json['page_number'] as num?)?.toInt(),
  sourcePath: json['source_path'] as String?,
  width: (json['width'] as num?)?.toInt(),
);

Map<String, dynamic> _$ExtractedImageToJson(_ExtractedImage instance) =>
    <String, dynamic>{
      'data': instance.data,
      'format': instance.format,
      'image_index': instance.imageIndex,
      'bits_per_component': instance.bitsPerComponent,
      'bounding_box': instance.boundingBox,
      'cluster_id': instance.clusterId,
      'colorspace': instance.colorspace,
      'description': instance.description,
      'height': instance.height,
      'image_kind': instance.imageKind,
      'is_mask': instance.isMask,
      'kind_confidence': instance.kindConfidence,
      'ocr_result': instance.ocrResult,
      'page_number': instance.pageNumber,
      'source_path': instance.sourcePath,
      'width': instance.width,
    };
