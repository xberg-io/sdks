// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'extraction_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ExtractionConfig _$ExtractionConfigFromJson(Map<String, dynamic> json) =>
    _ExtractionConfig(
      cacheNamespace: json['cache_namespace'] as String?,
      cacheTtlSecs: (json['cache_ttl_secs'] as num?)?.toInt(),
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
      htmlOptions: json['html_options'],
      images: json['images'] == null
          ? null
          : ImageExtractionConfig.fromJson(
              json['images'] as Map<String, dynamic>),
      includeDocumentStructure: json['include_document_structure'] as bool?,
      keywords: json['keywords'],
      languageDetection: json['language_detection'] == null
          ? null
          : LanguageDetectionConfig.fromJson(
              json['language_detection'] as Map<String, dynamic>),
      layout: json['layout'] == null
          ? null
          : LayoutDetectionConfig.fromJson(
              json['layout'] as Map<String, dynamic>),
      maxArchiveDepth: (json['max_archive_depth'] as num?)?.toInt(),
      maxConcurrentExtractions:
          (json['max_concurrent_extractions'] as num?)?.toInt(),
      ocr: json['ocr'] == null
          ? null
          : OcrConfig.fromJson(json['ocr'] as Map<String, dynamic>),
      outputFormat: json['output_format'] as String?,
      pages: json['pages'] == null
          ? null
          : PageConfig.fromJson(json['pages'] as Map<String, dynamic>),
      pdfOptions: json['pdf_options'] == null
          ? null
          : PdfConfig.fromJson(json['pdf_options'] as Map<String, dynamic>),
      postprocessor: json['postprocessor'] == null
          ? null
          : PostProcessorConfig.fromJson(
              json['postprocessor'] as Map<String, dynamic>),
      resultFormat: json['result_format'] as String?,
      securityLimits: json['security_limits'],
      tokenReduction: json['token_reduction'] == null
          ? null
          : TokenReductionConfig.fromJson(
              json['token_reduction'] as Map<String, dynamic>),
      useCache: json['use_cache'] as bool?,
    );

Map<String, dynamic> _$ExtractionConfigToJson(_ExtractionConfig instance) =>
    <String, dynamic>{
      'cache_namespace': instance.cacheNamespace,
      'cache_ttl_secs': instance.cacheTtlSecs,
      'chunking': instance.chunking,
      'content_filter': instance.contentFilter,
      'disable_ocr': instance.disableOcr,
      'enable_quality_processing': instance.enableQualityProcessing,
      'extraction_timeout_secs': instance.extractionTimeoutSecs,
      'force_ocr': instance.forceOcr,
      'force_ocr_pages': instance.forceOcrPages,
      'html_options': instance.htmlOptions,
      'images': instance.images,
      'include_document_structure': instance.includeDocumentStructure,
      'keywords': instance.keywords,
      'language_detection': instance.languageDetection,
      'layout': instance.layout,
      'max_archive_depth': instance.maxArchiveDepth,
      'max_concurrent_extractions': instance.maxConcurrentExtractions,
      'ocr': instance.ocr,
      'output_format': instance.outputFormat,
      'pages': instance.pages,
      'pdf_options': instance.pdfOptions,
      'postprocessor': instance.postprocessor,
      'result_format': instance.resultFormat,
      'security_limits': instance.securityLimits,
      'token_reduction': instance.tokenReduction,
      'use_cache': instance.useCache,
    };
