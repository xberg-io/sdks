// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pdf_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PdfConfig _$PdfConfigFromJson(Map<String, dynamic> json) => _PdfConfig(
  bottomMarginFraction: (json['bottom_margin_fraction'] as num?)?.toDouble(),
  extractAnnotations: json['extract_annotations'] as bool?,
  extractImages: json['extract_images'] as bool?,
  extractMetadata: json['extract_metadata'] as bool?,
  hierarchy: json['hierarchy'] == null
      ? null
      : HierarchyConfig.fromJson(json['hierarchy'] as Map<String, dynamic>),
  passwords: (json['passwords'] as List<dynamic>?)
      ?.map((e) => e as String)
      .toList(),
  topMarginFraction: (json['top_margin_fraction'] as num?)?.toDouble(),
);

Map<String, dynamic> _$PdfConfigToJson(_PdfConfig instance) =>
    <String, dynamic>{
      'bottom_margin_fraction': instance.bottomMarginFraction,
      'extract_annotations': instance.extractAnnotations,
      'extract_images': instance.extractImages,
      'extract_metadata': instance.extractMetadata,
      'hierarchy': instance.hierarchy,
      'passwords': instance.passwords,
      'top_margin_fraction': instance.topMarginFraction,
    };
