// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'file_extraction_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_FileExtractionConfig _$FileExtractionConfigFromJson(
        Map<String, dynamic> json) =>
    _FileExtractionConfig(
      chunking: json['chunking'] == null
          ? null
          : ChunkingConfig.fromJson(json['chunking'] as Map<String, dynamic>),
      contentFilter: json['content_filter'] == null
          ? null
          : ContentFilterConfig.fromJson(
              json['content_filter'] as Map<String, dynamic>),
      disableOcr: json['disable_ocr'] as bool?,
      enableQualityProcessing: json['enable_quality_processing'] as bool?,
      extractionTimeoutSecs: (json['extraction_timeout_secs'] as num?)?.toInt(),
      forceOcr: json['force_ocr'] as bool?,
      forceOcrPages: (json['force_ocr_pages'] as List<dynamic>?)
          ?.map((e) => (e as num).toInt())
          .toList(),
      images: json['images'] == null
          ? null
          : ImageExtractionConfig.fromJson(
              json['images'] as Map<String, dynamic>),
      includeDocumentStructure: json['include_document_structure'] as bool?,
      languageDetection: json['language_detection'] == null
          ? null
          : LanguageDetectionConfig.fromJson(
              json['language_detection'] as Map<String, dynamic>),
      ocr: json['ocr'] == null
          ? null
          : OcrConfig.fromJson(json['ocr'] as Map<String, dynamic>),
      outputFormat: json['output_format'] as String?,
      pages: json['pages'] == null
          ? null
          : PageConfig.fromJson(json['pages'] as Map<String, dynamic>),
      postprocessor: json['postprocessor'] == null
          ? null
          : PostProcessorConfig.fromJson(
              json['postprocessor'] as Map<String, dynamic>),
      resultFormat: json['result_format'] as String?,
      tokenReduction: json['token_reduction'] == null
          ? null
          : TokenReductionConfig.fromJson(
              json['token_reduction'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$FileExtractionConfigToJson(
        _FileExtractionConfig instance) =>
    <String, dynamic>{
      'chunking': instance.chunking,
      'content_filter': instance.contentFilter,
      'disable_ocr': instance.disableOcr,
      'enable_quality_processing': instance.enableQualityProcessing,
      'extraction_timeout_secs': instance.extractionTimeoutSecs,
      'force_ocr': instance.forceOcr,
      'force_ocr_pages': instance.forceOcrPages,
      'images': instance.images,
      'include_document_structure': instance.includeDocumentStructure,
      'language_detection': instance.languageDetection,
      'ocr': instance.ocr,
      'output_format': instance.outputFormat,
      'pages': instance.pages,
      'postprocessor': instance.postprocessor,
      'result_format': instance.resultFormat,
      'token_reduction': instance.tokenReduction,
    };
