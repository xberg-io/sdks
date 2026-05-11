// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'extraction_config.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ExtractionConfig {
  /// Cache namespace for tenant isolation
  @JsonKey(name: 'cache_namespace')
  String? get cacheNamespace;

  /// Per-request cache TTL override in seconds
  @JsonKey(name: 'cache_ttl_secs')
  int? get cacheTtlSecs;

  /// Text chunking configuration
  ChunkingConfig? get chunking;

  /// Content filtering (headers, footers, watermarks)
  @JsonKey(name: 'content_filter')
  ContentFilterConfig? get contentFilter;

  /// Disable OCR entirely
  @JsonKey(name: 'disable_ocr')
  bool? get disableOcr;

  /// Enable quality post-processing
  @JsonKey(name: 'enable_quality_processing')
  bool? get enableQualityProcessing;

  /// Per-file extraction timeout in seconds
  @JsonKey(name: 'extraction_timeout_secs')
  int? get extractionTimeoutSecs;

  /// Force OCR on all pages (bypass native text extraction)
  @JsonKey(name: 'force_ocr')
  bool? get forceOcr;

  /// Force OCR on specific pages (1-indexed)
  @JsonKey(name: 'force_ocr_pages')
  List<int>? get forceOcrPages;

  /// HTML extraction options (flexible JSON)
  @JsonKey(name: 'html_options')
  dynamic get htmlOptions;

  /// Image extraction configuration
  ImageExtractionConfig? get images;

  /// Include structured document tree in output
  @JsonKey(name: 'include_document_structure')
  bool? get includeDocumentStructure;

  /// Keyword extraction configuration (flexible JSON)
  dynamic get keywords;

  /// Language detection configuration
  @JsonKey(name: 'language_detection')
  LanguageDetectionConfig? get languageDetection;

  /// Layout detection configuration
  LayoutDetectionConfig? get layout;

  /// Maximum recursion depth for archive extraction
  @JsonKey(name: 'max_archive_depth')
  int? get maxArchiveDepth;

  /// Maximum concurrent extractions
  @JsonKey(name: 'max_concurrent_extractions')
  int? get maxConcurrentExtractions;

  /// OCR configuration
  OcrConfig? get ocr;

  /// Output text format: "plain", "markdown", "html", "djot", "structured", "json"
  @JsonKey(name: 'output_format')
  String? get outputFormat;

  /// Page extraction configuration
  PageConfig? get pages;

  /// PDF-specific options
  @JsonKey(name: 'pdf_options')
  PdfConfig? get pdfOptions;

  /// Post-processor configuration
  PostProcessorConfig? get postprocessor;

  /// Result format: "unified" or "element_based"
  @JsonKey(name: 'result_format')
  String? get resultFormat;

  /// Security limits (flexible JSON)
  @JsonKey(name: 'security_limits')
  dynamic get securityLimits;

  /// Token reduction configuration
  @JsonKey(name: 'token_reduction')
  TokenReductionConfig? get tokenReduction;

  /// Enable extraction result caching
  @JsonKey(name: 'use_cache')
  bool? get useCache;

  /// Create a copy of ExtractionConfig
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ExtractionConfigCopyWith<ExtractionConfig> get copyWith =>
      _$ExtractionConfigCopyWithImpl<ExtractionConfig>(
          this as ExtractionConfig, _$identity);

  /// Serializes this ExtractionConfig to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ExtractionConfig &&
            (identical(other.cacheNamespace, cacheNamespace) ||
                other.cacheNamespace == cacheNamespace) &&
            (identical(other.cacheTtlSecs, cacheTtlSecs) ||
                other.cacheTtlSecs == cacheTtlSecs) &&
            (identical(other.chunking, chunking) ||
                other.chunking == chunking) &&
            (identical(other.contentFilter, contentFilter) ||
                other.contentFilter == contentFilter) &&
            (identical(other.disableOcr, disableOcr) ||
                other.disableOcr == disableOcr) &&
            (identical(
                    other.enableQualityProcessing, enableQualityProcessing) ||
                other.enableQualityProcessing == enableQualityProcessing) &&
            (identical(other.extractionTimeoutSecs, extractionTimeoutSecs) ||
                other.extractionTimeoutSecs == extractionTimeoutSecs) &&
            (identical(other.forceOcr, forceOcr) ||
                other.forceOcr == forceOcr) &&
            const DeepCollectionEquality()
                .equals(other.forceOcrPages, forceOcrPages) &&
            const DeepCollectionEquality()
                .equals(other.htmlOptions, htmlOptions) &&
            (identical(other.images, images) || other.images == images) &&
            (identical(
                    other.includeDocumentStructure, includeDocumentStructure) ||
                other.includeDocumentStructure == includeDocumentStructure) &&
            const DeepCollectionEquality().equals(other.keywords, keywords) &&
            (identical(other.languageDetection, languageDetection) ||
                other.languageDetection == languageDetection) &&
            (identical(other.layout, layout) || other.layout == layout) &&
            (identical(other.maxArchiveDepth, maxArchiveDepth) ||
                other.maxArchiveDepth == maxArchiveDepth) &&
            (identical(
                    other.maxConcurrentExtractions, maxConcurrentExtractions) ||
                other.maxConcurrentExtractions == maxConcurrentExtractions) &&
            (identical(other.ocr, ocr) || other.ocr == ocr) &&
            (identical(other.outputFormat, outputFormat) ||
                other.outputFormat == outputFormat) &&
            (identical(other.pages, pages) || other.pages == pages) &&
            (identical(other.pdfOptions, pdfOptions) ||
                other.pdfOptions == pdfOptions) &&
            (identical(other.postprocessor, postprocessor) ||
                other.postprocessor == postprocessor) &&
            (identical(other.resultFormat, resultFormat) ||
                other.resultFormat == resultFormat) &&
            const DeepCollectionEquality()
                .equals(other.securityLimits, securityLimits) &&
            (identical(other.tokenReduction, tokenReduction) ||
                other.tokenReduction == tokenReduction) &&
            (identical(other.useCache, useCache) ||
                other.useCache == useCache));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        cacheNamespace,
        cacheTtlSecs,
        chunking,
        contentFilter,
        disableOcr,
        enableQualityProcessing,
        extractionTimeoutSecs,
        forceOcr,
        const DeepCollectionEquality().hash(forceOcrPages),
        const DeepCollectionEquality().hash(htmlOptions),
        images,
        includeDocumentStructure,
        const DeepCollectionEquality().hash(keywords),
        languageDetection,
        layout,
        maxArchiveDepth,
        maxConcurrentExtractions,
        ocr,
        outputFormat,
        pages,
        pdfOptions,
        postprocessor,
        resultFormat,
        const DeepCollectionEquality().hash(securityLimits),
        tokenReduction,
        useCache
      ]);

  @override
  String toString() {
    return 'ExtractionConfig(cacheNamespace: $cacheNamespace, cacheTtlSecs: $cacheTtlSecs, chunking: $chunking, contentFilter: $contentFilter, disableOcr: $disableOcr, enableQualityProcessing: $enableQualityProcessing, extractionTimeoutSecs: $extractionTimeoutSecs, forceOcr: $forceOcr, forceOcrPages: $forceOcrPages, htmlOptions: $htmlOptions, images: $images, includeDocumentStructure: $includeDocumentStructure, keywords: $keywords, languageDetection: $languageDetection, layout: $layout, maxArchiveDepth: $maxArchiveDepth, maxConcurrentExtractions: $maxConcurrentExtractions, ocr: $ocr, outputFormat: $outputFormat, pages: $pages, pdfOptions: $pdfOptions, postprocessor: $postprocessor, resultFormat: $resultFormat, securityLimits: $securityLimits, tokenReduction: $tokenReduction, useCache: $useCache)';
  }
}

/// @nodoc
abstract mixin class $ExtractionConfigCopyWith<$Res> {
  factory $ExtractionConfigCopyWith(
          ExtractionConfig value, $Res Function(ExtractionConfig) _then) =
      _$ExtractionConfigCopyWithImpl;
  @useResult
  $Res call(
      {@JsonKey(name: 'cache_namespace') String? cacheNamespace,
      @JsonKey(name: 'cache_ttl_secs') int? cacheTtlSecs,
      ChunkingConfig? chunking,
      @JsonKey(name: 'content_filter') ContentFilterConfig? contentFilter,
      @JsonKey(name: 'disable_ocr') bool? disableOcr,
      @JsonKey(name: 'enable_quality_processing') bool? enableQualityProcessing,
      @JsonKey(name: 'extraction_timeout_secs') int? extractionTimeoutSecs,
      @JsonKey(name: 'force_ocr') bool? forceOcr,
      @JsonKey(name: 'force_ocr_pages') List<int>? forceOcrPages,
      @JsonKey(name: 'html_options') dynamic htmlOptions,
      ImageExtractionConfig? images,
      @JsonKey(name: 'include_document_structure')
      bool? includeDocumentStructure,
      dynamic keywords,
      @JsonKey(name: 'language_detection')
      LanguageDetectionConfig? languageDetection,
      LayoutDetectionConfig? layout,
      @JsonKey(name: 'max_archive_depth') int? maxArchiveDepth,
      @JsonKey(name: 'max_concurrent_extractions')
      int? maxConcurrentExtractions,
      OcrConfig? ocr,
      @JsonKey(name: 'output_format') String? outputFormat,
      PageConfig? pages,
      @JsonKey(name: 'pdf_options') PdfConfig? pdfOptions,
      PostProcessorConfig? postprocessor,
      @JsonKey(name: 'result_format') String? resultFormat,
      @JsonKey(name: 'security_limits') dynamic securityLimits,
      @JsonKey(name: 'token_reduction') TokenReductionConfig? tokenReduction,
      @JsonKey(name: 'use_cache') bool? useCache});

  $ChunkingConfigCopyWith<$Res>? get chunking;
  $ContentFilterConfigCopyWith<$Res>? get contentFilter;
  $ImageExtractionConfigCopyWith<$Res>? get images;
  $LanguageDetectionConfigCopyWith<$Res>? get languageDetection;
  $LayoutDetectionConfigCopyWith<$Res>? get layout;
  $OcrConfigCopyWith<$Res>? get ocr;
  $PageConfigCopyWith<$Res>? get pages;
  $PdfConfigCopyWith<$Res>? get pdfOptions;
  $PostProcessorConfigCopyWith<$Res>? get postprocessor;
  $TokenReductionConfigCopyWith<$Res>? get tokenReduction;
}

/// @nodoc
class _$ExtractionConfigCopyWithImpl<$Res>
    implements $ExtractionConfigCopyWith<$Res> {
  _$ExtractionConfigCopyWithImpl(this._self, this._then);

  final ExtractionConfig _self;
  final $Res Function(ExtractionConfig) _then;

  /// Create a copy of ExtractionConfig
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? cacheNamespace = freezed,
    Object? cacheTtlSecs = freezed,
    Object? chunking = freezed,
    Object? contentFilter = freezed,
    Object? disableOcr = freezed,
    Object? enableQualityProcessing = freezed,
    Object? extractionTimeoutSecs = freezed,
    Object? forceOcr = freezed,
    Object? forceOcrPages = freezed,
    Object? htmlOptions = freezed,
    Object? images = freezed,
    Object? includeDocumentStructure = freezed,
    Object? keywords = freezed,
    Object? languageDetection = freezed,
    Object? layout = freezed,
    Object? maxArchiveDepth = freezed,
    Object? maxConcurrentExtractions = freezed,
    Object? ocr = freezed,
    Object? outputFormat = freezed,
    Object? pages = freezed,
    Object? pdfOptions = freezed,
    Object? postprocessor = freezed,
    Object? resultFormat = freezed,
    Object? securityLimits = freezed,
    Object? tokenReduction = freezed,
    Object? useCache = freezed,
  }) {
    return _then(_self.copyWith(
      cacheNamespace: freezed == cacheNamespace
          ? _self.cacheNamespace
          : cacheNamespace // ignore: cast_nullable_to_non_nullable
              as String?,
      cacheTtlSecs: freezed == cacheTtlSecs
          ? _self.cacheTtlSecs
          : cacheTtlSecs // ignore: cast_nullable_to_non_nullable
              as int?,
      chunking: freezed == chunking
          ? _self.chunking
          : chunking // ignore: cast_nullable_to_non_nullable
              as ChunkingConfig?,
      contentFilter: freezed == contentFilter
          ? _self.contentFilter
          : contentFilter // ignore: cast_nullable_to_non_nullable
              as ContentFilterConfig?,
      disableOcr: freezed == disableOcr
          ? _self.disableOcr
          : disableOcr // ignore: cast_nullable_to_non_nullable
              as bool?,
      enableQualityProcessing: freezed == enableQualityProcessing
          ? _self.enableQualityProcessing
          : enableQualityProcessing // ignore: cast_nullable_to_non_nullable
              as bool?,
      extractionTimeoutSecs: freezed == extractionTimeoutSecs
          ? _self.extractionTimeoutSecs
          : extractionTimeoutSecs // ignore: cast_nullable_to_non_nullable
              as int?,
      forceOcr: freezed == forceOcr
          ? _self.forceOcr
          : forceOcr // ignore: cast_nullable_to_non_nullable
              as bool?,
      forceOcrPages: freezed == forceOcrPages
          ? _self.forceOcrPages
          : forceOcrPages // ignore: cast_nullable_to_non_nullable
              as List<int>?,
      htmlOptions: freezed == htmlOptions
          ? _self.htmlOptions
          : htmlOptions // ignore: cast_nullable_to_non_nullable
              as dynamic,
      images: freezed == images
          ? _self.images
          : images // ignore: cast_nullable_to_non_nullable
              as ImageExtractionConfig?,
      includeDocumentStructure: freezed == includeDocumentStructure
          ? _self.includeDocumentStructure
          : includeDocumentStructure // ignore: cast_nullable_to_non_nullable
              as bool?,
      keywords: freezed == keywords
          ? _self.keywords
          : keywords // ignore: cast_nullable_to_non_nullable
              as dynamic,
      languageDetection: freezed == languageDetection
          ? _self.languageDetection
          : languageDetection // ignore: cast_nullable_to_non_nullable
              as LanguageDetectionConfig?,
      layout: freezed == layout
          ? _self.layout
          : layout // ignore: cast_nullable_to_non_nullable
              as LayoutDetectionConfig?,
      maxArchiveDepth: freezed == maxArchiveDepth
          ? _self.maxArchiveDepth
          : maxArchiveDepth // ignore: cast_nullable_to_non_nullable
              as int?,
      maxConcurrentExtractions: freezed == maxConcurrentExtractions
          ? _self.maxConcurrentExtractions
          : maxConcurrentExtractions // ignore: cast_nullable_to_non_nullable
              as int?,
      ocr: freezed == ocr
          ? _self.ocr
          : ocr // ignore: cast_nullable_to_non_nullable
              as OcrConfig?,
      outputFormat: freezed == outputFormat
          ? _self.outputFormat
          : outputFormat // ignore: cast_nullable_to_non_nullable
              as String?,
      pages: freezed == pages
          ? _self.pages
          : pages // ignore: cast_nullable_to_non_nullable
              as PageConfig?,
      pdfOptions: freezed == pdfOptions
          ? _self.pdfOptions
          : pdfOptions // ignore: cast_nullable_to_non_nullable
              as PdfConfig?,
      postprocessor: freezed == postprocessor
          ? _self.postprocessor
          : postprocessor // ignore: cast_nullable_to_non_nullable
              as PostProcessorConfig?,
      resultFormat: freezed == resultFormat
          ? _self.resultFormat
          : resultFormat // ignore: cast_nullable_to_non_nullable
              as String?,
      securityLimits: freezed == securityLimits
          ? _self.securityLimits
          : securityLimits // ignore: cast_nullable_to_non_nullable
              as dynamic,
      tokenReduction: freezed == tokenReduction
          ? _self.tokenReduction
          : tokenReduction // ignore: cast_nullable_to_non_nullable
              as TokenReductionConfig?,
      useCache: freezed == useCache
          ? _self.useCache
          : useCache // ignore: cast_nullable_to_non_nullable
              as bool?,
    ));
  }

  /// Create a copy of ExtractionConfig
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ChunkingConfigCopyWith<$Res>? get chunking {
    if (_self.chunking == null) {
      return null;
    }

    return $ChunkingConfigCopyWith<$Res>(_self.chunking!, (value) {
      return _then(_self.copyWith(chunking: value));
    });
  }

  /// Create a copy of ExtractionConfig
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ContentFilterConfigCopyWith<$Res>? get contentFilter {
    if (_self.contentFilter == null) {
      return null;
    }

    return $ContentFilterConfigCopyWith<$Res>(_self.contentFilter!, (value) {
      return _then(_self.copyWith(contentFilter: value));
    });
  }

  /// Create a copy of ExtractionConfig
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ImageExtractionConfigCopyWith<$Res>? get images {
    if (_self.images == null) {
      return null;
    }

    return $ImageExtractionConfigCopyWith<$Res>(_self.images!, (value) {
      return _then(_self.copyWith(images: value));
    });
  }

  /// Create a copy of ExtractionConfig
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $LanguageDetectionConfigCopyWith<$Res>? get languageDetection {
    if (_self.languageDetection == null) {
      return null;
    }

    return $LanguageDetectionConfigCopyWith<$Res>(_self.languageDetection!,
        (value) {
      return _then(_self.copyWith(languageDetection: value));
    });
  }

  /// Create a copy of ExtractionConfig
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $LayoutDetectionConfigCopyWith<$Res>? get layout {
    if (_self.layout == null) {
      return null;
    }

    return $LayoutDetectionConfigCopyWith<$Res>(_self.layout!, (value) {
      return _then(_self.copyWith(layout: value));
    });
  }

  /// Create a copy of ExtractionConfig
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $OcrConfigCopyWith<$Res>? get ocr {
    if (_self.ocr == null) {
      return null;
    }

    return $OcrConfigCopyWith<$Res>(_self.ocr!, (value) {
      return _then(_self.copyWith(ocr: value));
    });
  }

  /// Create a copy of ExtractionConfig
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $PageConfigCopyWith<$Res>? get pages {
    if (_self.pages == null) {
      return null;
    }

    return $PageConfigCopyWith<$Res>(_self.pages!, (value) {
      return _then(_self.copyWith(pages: value));
    });
  }

  /// Create a copy of ExtractionConfig
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $PdfConfigCopyWith<$Res>? get pdfOptions {
    if (_self.pdfOptions == null) {
      return null;
    }

    return $PdfConfigCopyWith<$Res>(_self.pdfOptions!, (value) {
      return _then(_self.copyWith(pdfOptions: value));
    });
  }

  /// Create a copy of ExtractionConfig
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $PostProcessorConfigCopyWith<$Res>? get postprocessor {
    if (_self.postprocessor == null) {
      return null;
    }

    return $PostProcessorConfigCopyWith<$Res>(_self.postprocessor!, (value) {
      return _then(_self.copyWith(postprocessor: value));
    });
  }

  /// Create a copy of ExtractionConfig
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $TokenReductionConfigCopyWith<$Res>? get tokenReduction {
    if (_self.tokenReduction == null) {
      return null;
    }

    return $TokenReductionConfigCopyWith<$Res>(_self.tokenReduction!, (value) {
      return _then(_self.copyWith(tokenReduction: value));
    });
  }
}

/// Adds pattern-matching-related methods to [ExtractionConfig].
extension ExtractionConfigPatterns on ExtractionConfig {
  /// A variant of `map` that fallback to returning `orElse`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_ExtractionConfig value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ExtractionConfig() when $default != null:
        return $default(_that);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// Callbacks receives the raw object, upcasted.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case final Subclass2 value:
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_ExtractionConfig value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ExtractionConfig():
        return $default(_that);
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `map` that fallback to returning `null`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_ExtractionConfig value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ExtractionConfig() when $default != null:
        return $default(_that);
      case _:
        return null;
    }
  }

  /// A variant of `when` that fallback to an `orElse` callback.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(
            @JsonKey(name: 'cache_namespace') String? cacheNamespace,
            @JsonKey(name: 'cache_ttl_secs') int? cacheTtlSecs,
            ChunkingConfig? chunking,
            @JsonKey(name: 'content_filter') ContentFilterConfig? contentFilter,
            @JsonKey(name: 'disable_ocr') bool? disableOcr,
            @JsonKey(name: 'enable_quality_processing')
            bool? enableQualityProcessing,
            @JsonKey(name: 'extraction_timeout_secs')
            int? extractionTimeoutSecs,
            @JsonKey(name: 'force_ocr') bool? forceOcr,
            @JsonKey(name: 'force_ocr_pages') List<int>? forceOcrPages,
            @JsonKey(name: 'html_options') dynamic htmlOptions,
            ImageExtractionConfig? images,
            @JsonKey(name: 'include_document_structure')
            bool? includeDocumentStructure,
            dynamic keywords,
            @JsonKey(name: 'language_detection')
            LanguageDetectionConfig? languageDetection,
            LayoutDetectionConfig? layout,
            @JsonKey(name: 'max_archive_depth') int? maxArchiveDepth,
            @JsonKey(name: 'max_concurrent_extractions')
            int? maxConcurrentExtractions,
            OcrConfig? ocr,
            @JsonKey(name: 'output_format') String? outputFormat,
            PageConfig? pages,
            @JsonKey(name: 'pdf_options') PdfConfig? pdfOptions,
            PostProcessorConfig? postprocessor,
            @JsonKey(name: 'result_format') String? resultFormat,
            @JsonKey(name: 'security_limits') dynamic securityLimits,
            @JsonKey(name: 'token_reduction')
            TokenReductionConfig? tokenReduction,
            @JsonKey(name: 'use_cache') bool? useCache)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ExtractionConfig() when $default != null:
        return $default(
            _that.cacheNamespace,
            _that.cacheTtlSecs,
            _that.chunking,
            _that.contentFilter,
            _that.disableOcr,
            _that.enableQualityProcessing,
            _that.extractionTimeoutSecs,
            _that.forceOcr,
            _that.forceOcrPages,
            _that.htmlOptions,
            _that.images,
            _that.includeDocumentStructure,
            _that.keywords,
            _that.languageDetection,
            _that.layout,
            _that.maxArchiveDepth,
            _that.maxConcurrentExtractions,
            _that.ocr,
            _that.outputFormat,
            _that.pages,
            _that.pdfOptions,
            _that.postprocessor,
            _that.resultFormat,
            _that.securityLimits,
            _that.tokenReduction,
            _that.useCache);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// As opposed to `map`, this offers destructuring.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case Subclass2(:final field2):
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(
            @JsonKey(name: 'cache_namespace') String? cacheNamespace,
            @JsonKey(name: 'cache_ttl_secs') int? cacheTtlSecs,
            ChunkingConfig? chunking,
            @JsonKey(name: 'content_filter') ContentFilterConfig? contentFilter,
            @JsonKey(name: 'disable_ocr') bool? disableOcr,
            @JsonKey(name: 'enable_quality_processing')
            bool? enableQualityProcessing,
            @JsonKey(name: 'extraction_timeout_secs')
            int? extractionTimeoutSecs,
            @JsonKey(name: 'force_ocr') bool? forceOcr,
            @JsonKey(name: 'force_ocr_pages') List<int>? forceOcrPages,
            @JsonKey(name: 'html_options') dynamic htmlOptions,
            ImageExtractionConfig? images,
            @JsonKey(name: 'include_document_structure')
            bool? includeDocumentStructure,
            dynamic keywords,
            @JsonKey(name: 'language_detection')
            LanguageDetectionConfig? languageDetection,
            LayoutDetectionConfig? layout,
            @JsonKey(name: 'max_archive_depth') int? maxArchiveDepth,
            @JsonKey(name: 'max_concurrent_extractions')
            int? maxConcurrentExtractions,
            OcrConfig? ocr,
            @JsonKey(name: 'output_format') String? outputFormat,
            PageConfig? pages,
            @JsonKey(name: 'pdf_options') PdfConfig? pdfOptions,
            PostProcessorConfig? postprocessor,
            @JsonKey(name: 'result_format') String? resultFormat,
            @JsonKey(name: 'security_limits') dynamic securityLimits,
            @JsonKey(name: 'token_reduction')
            TokenReductionConfig? tokenReduction,
            @JsonKey(name: 'use_cache') bool? useCache)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ExtractionConfig():
        return $default(
            _that.cacheNamespace,
            _that.cacheTtlSecs,
            _that.chunking,
            _that.contentFilter,
            _that.disableOcr,
            _that.enableQualityProcessing,
            _that.extractionTimeoutSecs,
            _that.forceOcr,
            _that.forceOcrPages,
            _that.htmlOptions,
            _that.images,
            _that.includeDocumentStructure,
            _that.keywords,
            _that.languageDetection,
            _that.layout,
            _that.maxArchiveDepth,
            _that.maxConcurrentExtractions,
            _that.ocr,
            _that.outputFormat,
            _that.pages,
            _that.pdfOptions,
            _that.postprocessor,
            _that.resultFormat,
            _that.securityLimits,
            _that.tokenReduction,
            _that.useCache);
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `when` that fallback to returning `null`
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(
            @JsonKey(name: 'cache_namespace') String? cacheNamespace,
            @JsonKey(name: 'cache_ttl_secs') int? cacheTtlSecs,
            ChunkingConfig? chunking,
            @JsonKey(name: 'content_filter') ContentFilterConfig? contentFilter,
            @JsonKey(name: 'disable_ocr') bool? disableOcr,
            @JsonKey(name: 'enable_quality_processing')
            bool? enableQualityProcessing,
            @JsonKey(name: 'extraction_timeout_secs')
            int? extractionTimeoutSecs,
            @JsonKey(name: 'force_ocr') bool? forceOcr,
            @JsonKey(name: 'force_ocr_pages') List<int>? forceOcrPages,
            @JsonKey(name: 'html_options') dynamic htmlOptions,
            ImageExtractionConfig? images,
            @JsonKey(name: 'include_document_structure')
            bool? includeDocumentStructure,
            dynamic keywords,
            @JsonKey(name: 'language_detection')
            LanguageDetectionConfig? languageDetection,
            LayoutDetectionConfig? layout,
            @JsonKey(name: 'max_archive_depth') int? maxArchiveDepth,
            @JsonKey(name: 'max_concurrent_extractions')
            int? maxConcurrentExtractions,
            OcrConfig? ocr,
            @JsonKey(name: 'output_format') String? outputFormat,
            PageConfig? pages,
            @JsonKey(name: 'pdf_options') PdfConfig? pdfOptions,
            PostProcessorConfig? postprocessor,
            @JsonKey(name: 'result_format') String? resultFormat,
            @JsonKey(name: 'security_limits') dynamic securityLimits,
            @JsonKey(name: 'token_reduction')
            TokenReductionConfig? tokenReduction,
            @JsonKey(name: 'use_cache') bool? useCache)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ExtractionConfig() when $default != null:
        return $default(
            _that.cacheNamespace,
            _that.cacheTtlSecs,
            _that.chunking,
            _that.contentFilter,
            _that.disableOcr,
            _that.enableQualityProcessing,
            _that.extractionTimeoutSecs,
            _that.forceOcr,
            _that.forceOcrPages,
            _that.htmlOptions,
            _that.images,
            _that.includeDocumentStructure,
            _that.keywords,
            _that.languageDetection,
            _that.layout,
            _that.maxArchiveDepth,
            _that.maxConcurrentExtractions,
            _that.ocr,
            _that.outputFormat,
            _that.pages,
            _that.pdfOptions,
            _that.postprocessor,
            _that.resultFormat,
            _that.securityLimits,
            _that.tokenReduction,
            _that.useCache);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _ExtractionConfig implements ExtractionConfig {
  const _ExtractionConfig(
      {@JsonKey(name: 'cache_namespace') this.cacheNamespace,
      @JsonKey(name: 'cache_ttl_secs') this.cacheTtlSecs,
      this.chunking,
      @JsonKey(name: 'content_filter') this.contentFilter,
      @JsonKey(name: 'disable_ocr') this.disableOcr,
      @JsonKey(name: 'enable_quality_processing') this.enableQualityProcessing,
      @JsonKey(name: 'extraction_timeout_secs') this.extractionTimeoutSecs,
      @JsonKey(name: 'force_ocr') this.forceOcr,
      @JsonKey(name: 'force_ocr_pages') final List<int>? forceOcrPages,
      @JsonKey(name: 'html_options') this.htmlOptions,
      this.images,
      @JsonKey(name: 'include_document_structure')
      this.includeDocumentStructure,
      this.keywords,
      @JsonKey(name: 'language_detection') this.languageDetection,
      this.layout,
      @JsonKey(name: 'max_archive_depth') this.maxArchiveDepth,
      @JsonKey(name: 'max_concurrent_extractions')
      this.maxConcurrentExtractions,
      this.ocr,
      @JsonKey(name: 'output_format') this.outputFormat,
      this.pages,
      @JsonKey(name: 'pdf_options') this.pdfOptions,
      this.postprocessor,
      @JsonKey(name: 'result_format') this.resultFormat,
      @JsonKey(name: 'security_limits') this.securityLimits,
      @JsonKey(name: 'token_reduction') this.tokenReduction,
      @JsonKey(name: 'use_cache') this.useCache})
      : _forceOcrPages = forceOcrPages;
  factory _ExtractionConfig.fromJson(Map<String, dynamic> json) =>
      _$ExtractionConfigFromJson(json);

  /// Cache namespace for tenant isolation
  @override
  @JsonKey(name: 'cache_namespace')
  final String? cacheNamespace;

  /// Per-request cache TTL override in seconds
  @override
  @JsonKey(name: 'cache_ttl_secs')
  final int? cacheTtlSecs;

  /// Text chunking configuration
  @override
  final ChunkingConfig? chunking;

  /// Content filtering (headers, footers, watermarks)
  @override
  @JsonKey(name: 'content_filter')
  final ContentFilterConfig? contentFilter;

  /// Disable OCR entirely
  @override
  @JsonKey(name: 'disable_ocr')
  final bool? disableOcr;

  /// Enable quality post-processing
  @override
  @JsonKey(name: 'enable_quality_processing')
  final bool? enableQualityProcessing;

  /// Per-file extraction timeout in seconds
  @override
  @JsonKey(name: 'extraction_timeout_secs')
  final int? extractionTimeoutSecs;

  /// Force OCR on all pages (bypass native text extraction)
  @override
  @JsonKey(name: 'force_ocr')
  final bool? forceOcr;

  /// Force OCR on specific pages (1-indexed)
  final List<int>? _forceOcrPages;

  /// Force OCR on specific pages (1-indexed)
  @override
  @JsonKey(name: 'force_ocr_pages')
  List<int>? get forceOcrPages {
    final value = _forceOcrPages;
    if (value == null) return null;
    if (_forceOcrPages is EqualUnmodifiableListView) return _forceOcrPages;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  /// HTML extraction options (flexible JSON)
  @override
  @JsonKey(name: 'html_options')
  final dynamic htmlOptions;

  /// Image extraction configuration
  @override
  final ImageExtractionConfig? images;

  /// Include structured document tree in output
  @override
  @JsonKey(name: 'include_document_structure')
  final bool? includeDocumentStructure;

  /// Keyword extraction configuration (flexible JSON)
  @override
  final dynamic keywords;

  /// Language detection configuration
  @override
  @JsonKey(name: 'language_detection')
  final LanguageDetectionConfig? languageDetection;

  /// Layout detection configuration
  @override
  final LayoutDetectionConfig? layout;

  /// Maximum recursion depth for archive extraction
  @override
  @JsonKey(name: 'max_archive_depth')
  final int? maxArchiveDepth;

  /// Maximum concurrent extractions
  @override
  @JsonKey(name: 'max_concurrent_extractions')
  final int? maxConcurrentExtractions;

  /// OCR configuration
  @override
  final OcrConfig? ocr;

  /// Output text format: "plain", "markdown", "html", "djot", "structured", "json"
  @override
  @JsonKey(name: 'output_format')
  final String? outputFormat;

  /// Page extraction configuration
  @override
  final PageConfig? pages;

  /// PDF-specific options
  @override
  @JsonKey(name: 'pdf_options')
  final PdfConfig? pdfOptions;

  /// Post-processor configuration
  @override
  final PostProcessorConfig? postprocessor;

  /// Result format: "unified" or "element_based"
  @override
  @JsonKey(name: 'result_format')
  final String? resultFormat;

  /// Security limits (flexible JSON)
  @override
  @JsonKey(name: 'security_limits')
  final dynamic securityLimits;

  /// Token reduction configuration
  @override
  @JsonKey(name: 'token_reduction')
  final TokenReductionConfig? tokenReduction;

  /// Enable extraction result caching
  @override
  @JsonKey(name: 'use_cache')
  final bool? useCache;

  /// Create a copy of ExtractionConfig
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ExtractionConfigCopyWith<_ExtractionConfig> get copyWith =>
      __$ExtractionConfigCopyWithImpl<_ExtractionConfig>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$ExtractionConfigToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ExtractionConfig &&
            (identical(other.cacheNamespace, cacheNamespace) ||
                other.cacheNamespace == cacheNamespace) &&
            (identical(other.cacheTtlSecs, cacheTtlSecs) ||
                other.cacheTtlSecs == cacheTtlSecs) &&
            (identical(other.chunking, chunking) ||
                other.chunking == chunking) &&
            (identical(other.contentFilter, contentFilter) ||
                other.contentFilter == contentFilter) &&
            (identical(other.disableOcr, disableOcr) ||
                other.disableOcr == disableOcr) &&
            (identical(
                    other.enableQualityProcessing, enableQualityProcessing) ||
                other.enableQualityProcessing == enableQualityProcessing) &&
            (identical(other.extractionTimeoutSecs, extractionTimeoutSecs) ||
                other.extractionTimeoutSecs == extractionTimeoutSecs) &&
            (identical(other.forceOcr, forceOcr) ||
                other.forceOcr == forceOcr) &&
            const DeepCollectionEquality()
                .equals(other._forceOcrPages, _forceOcrPages) &&
            const DeepCollectionEquality()
                .equals(other.htmlOptions, htmlOptions) &&
            (identical(other.images, images) || other.images == images) &&
            (identical(
                    other.includeDocumentStructure, includeDocumentStructure) ||
                other.includeDocumentStructure == includeDocumentStructure) &&
            const DeepCollectionEquality().equals(other.keywords, keywords) &&
            (identical(other.languageDetection, languageDetection) ||
                other.languageDetection == languageDetection) &&
            (identical(other.layout, layout) || other.layout == layout) &&
            (identical(other.maxArchiveDepth, maxArchiveDepth) ||
                other.maxArchiveDepth == maxArchiveDepth) &&
            (identical(
                    other.maxConcurrentExtractions, maxConcurrentExtractions) ||
                other.maxConcurrentExtractions == maxConcurrentExtractions) &&
            (identical(other.ocr, ocr) || other.ocr == ocr) &&
            (identical(other.outputFormat, outputFormat) ||
                other.outputFormat == outputFormat) &&
            (identical(other.pages, pages) || other.pages == pages) &&
            (identical(other.pdfOptions, pdfOptions) ||
                other.pdfOptions == pdfOptions) &&
            (identical(other.postprocessor, postprocessor) ||
                other.postprocessor == postprocessor) &&
            (identical(other.resultFormat, resultFormat) ||
                other.resultFormat == resultFormat) &&
            const DeepCollectionEquality()
                .equals(other.securityLimits, securityLimits) &&
            (identical(other.tokenReduction, tokenReduction) ||
                other.tokenReduction == tokenReduction) &&
            (identical(other.useCache, useCache) ||
                other.useCache == useCache));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        cacheNamespace,
        cacheTtlSecs,
        chunking,
        contentFilter,
        disableOcr,
        enableQualityProcessing,
        extractionTimeoutSecs,
        forceOcr,
        const DeepCollectionEquality().hash(_forceOcrPages),
        const DeepCollectionEquality().hash(htmlOptions),
        images,
        includeDocumentStructure,
        const DeepCollectionEquality().hash(keywords),
        languageDetection,
        layout,
        maxArchiveDepth,
        maxConcurrentExtractions,
        ocr,
        outputFormat,
        pages,
        pdfOptions,
        postprocessor,
        resultFormat,
        const DeepCollectionEquality().hash(securityLimits),
        tokenReduction,
        useCache
      ]);

  @override
  String toString() {
    return 'ExtractionConfig(cacheNamespace: $cacheNamespace, cacheTtlSecs: $cacheTtlSecs, chunking: $chunking, contentFilter: $contentFilter, disableOcr: $disableOcr, enableQualityProcessing: $enableQualityProcessing, extractionTimeoutSecs: $extractionTimeoutSecs, forceOcr: $forceOcr, forceOcrPages: $forceOcrPages, htmlOptions: $htmlOptions, images: $images, includeDocumentStructure: $includeDocumentStructure, keywords: $keywords, languageDetection: $languageDetection, layout: $layout, maxArchiveDepth: $maxArchiveDepth, maxConcurrentExtractions: $maxConcurrentExtractions, ocr: $ocr, outputFormat: $outputFormat, pages: $pages, pdfOptions: $pdfOptions, postprocessor: $postprocessor, resultFormat: $resultFormat, securityLimits: $securityLimits, tokenReduction: $tokenReduction, useCache: $useCache)';
  }
}

/// @nodoc
abstract mixin class _$ExtractionConfigCopyWith<$Res>
    implements $ExtractionConfigCopyWith<$Res> {
  factory _$ExtractionConfigCopyWith(
          _ExtractionConfig value, $Res Function(_ExtractionConfig) _then) =
      __$ExtractionConfigCopyWithImpl;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'cache_namespace') String? cacheNamespace,
      @JsonKey(name: 'cache_ttl_secs') int? cacheTtlSecs,
      ChunkingConfig? chunking,
      @JsonKey(name: 'content_filter') ContentFilterConfig? contentFilter,
      @JsonKey(name: 'disable_ocr') bool? disableOcr,
      @JsonKey(name: 'enable_quality_processing') bool? enableQualityProcessing,
      @JsonKey(name: 'extraction_timeout_secs') int? extractionTimeoutSecs,
      @JsonKey(name: 'force_ocr') bool? forceOcr,
      @JsonKey(name: 'force_ocr_pages') List<int>? forceOcrPages,
      @JsonKey(name: 'html_options') dynamic htmlOptions,
      ImageExtractionConfig? images,
      @JsonKey(name: 'include_document_structure')
      bool? includeDocumentStructure,
      dynamic keywords,
      @JsonKey(name: 'language_detection')
      LanguageDetectionConfig? languageDetection,
      LayoutDetectionConfig? layout,
      @JsonKey(name: 'max_archive_depth') int? maxArchiveDepth,
      @JsonKey(name: 'max_concurrent_extractions')
      int? maxConcurrentExtractions,
      OcrConfig? ocr,
      @JsonKey(name: 'output_format') String? outputFormat,
      PageConfig? pages,
      @JsonKey(name: 'pdf_options') PdfConfig? pdfOptions,
      PostProcessorConfig? postprocessor,
      @JsonKey(name: 'result_format') String? resultFormat,
      @JsonKey(name: 'security_limits') dynamic securityLimits,
      @JsonKey(name: 'token_reduction') TokenReductionConfig? tokenReduction,
      @JsonKey(name: 'use_cache') bool? useCache});

  @override
  $ChunkingConfigCopyWith<$Res>? get chunking;
  @override
  $ContentFilterConfigCopyWith<$Res>? get contentFilter;
  @override
  $ImageExtractionConfigCopyWith<$Res>? get images;
  @override
  $LanguageDetectionConfigCopyWith<$Res>? get languageDetection;
  @override
  $LayoutDetectionConfigCopyWith<$Res>? get layout;
  @override
  $OcrConfigCopyWith<$Res>? get ocr;
  @override
  $PageConfigCopyWith<$Res>? get pages;
  @override
  $PdfConfigCopyWith<$Res>? get pdfOptions;
  @override
  $PostProcessorConfigCopyWith<$Res>? get postprocessor;
  @override
  $TokenReductionConfigCopyWith<$Res>? get tokenReduction;
}

/// @nodoc
class __$ExtractionConfigCopyWithImpl<$Res>
    implements _$ExtractionConfigCopyWith<$Res> {
  __$ExtractionConfigCopyWithImpl(this._self, this._then);

  final _ExtractionConfig _self;
  final $Res Function(_ExtractionConfig) _then;

  /// Create a copy of ExtractionConfig
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? cacheNamespace = freezed,
    Object? cacheTtlSecs = freezed,
    Object? chunking = freezed,
    Object? contentFilter = freezed,
    Object? disableOcr = freezed,
    Object? enableQualityProcessing = freezed,
    Object? extractionTimeoutSecs = freezed,
    Object? forceOcr = freezed,
    Object? forceOcrPages = freezed,
    Object? htmlOptions = freezed,
    Object? images = freezed,
    Object? includeDocumentStructure = freezed,
    Object? keywords = freezed,
    Object? languageDetection = freezed,
    Object? layout = freezed,
    Object? maxArchiveDepth = freezed,
    Object? maxConcurrentExtractions = freezed,
    Object? ocr = freezed,
    Object? outputFormat = freezed,
    Object? pages = freezed,
    Object? pdfOptions = freezed,
    Object? postprocessor = freezed,
    Object? resultFormat = freezed,
    Object? securityLimits = freezed,
    Object? tokenReduction = freezed,
    Object? useCache = freezed,
  }) {
    return _then(_ExtractionConfig(
      cacheNamespace: freezed == cacheNamespace
          ? _self.cacheNamespace
          : cacheNamespace // ignore: cast_nullable_to_non_nullable
              as String?,
      cacheTtlSecs: freezed == cacheTtlSecs
          ? _self.cacheTtlSecs
          : cacheTtlSecs // ignore: cast_nullable_to_non_nullable
              as int?,
      chunking: freezed == chunking
          ? _self.chunking
          : chunking // ignore: cast_nullable_to_non_nullable
              as ChunkingConfig?,
      contentFilter: freezed == contentFilter
          ? _self.contentFilter
          : contentFilter // ignore: cast_nullable_to_non_nullable
              as ContentFilterConfig?,
      disableOcr: freezed == disableOcr
          ? _self.disableOcr
          : disableOcr // ignore: cast_nullable_to_non_nullable
              as bool?,
      enableQualityProcessing: freezed == enableQualityProcessing
          ? _self.enableQualityProcessing
          : enableQualityProcessing // ignore: cast_nullable_to_non_nullable
              as bool?,
      extractionTimeoutSecs: freezed == extractionTimeoutSecs
          ? _self.extractionTimeoutSecs
          : extractionTimeoutSecs // ignore: cast_nullable_to_non_nullable
              as int?,
      forceOcr: freezed == forceOcr
          ? _self.forceOcr
          : forceOcr // ignore: cast_nullable_to_non_nullable
              as bool?,
      forceOcrPages: freezed == forceOcrPages
          ? _self._forceOcrPages
          : forceOcrPages // ignore: cast_nullable_to_non_nullable
              as List<int>?,
      htmlOptions: freezed == htmlOptions
          ? _self.htmlOptions
          : htmlOptions // ignore: cast_nullable_to_non_nullable
              as dynamic,
      images: freezed == images
          ? _self.images
          : images // ignore: cast_nullable_to_non_nullable
              as ImageExtractionConfig?,
      includeDocumentStructure: freezed == includeDocumentStructure
          ? _self.includeDocumentStructure
          : includeDocumentStructure // ignore: cast_nullable_to_non_nullable
              as bool?,
      keywords: freezed == keywords
          ? _self.keywords
          : keywords // ignore: cast_nullable_to_non_nullable
              as dynamic,
      languageDetection: freezed == languageDetection
          ? _self.languageDetection
          : languageDetection // ignore: cast_nullable_to_non_nullable
              as LanguageDetectionConfig?,
      layout: freezed == layout
          ? _self.layout
          : layout // ignore: cast_nullable_to_non_nullable
              as LayoutDetectionConfig?,
      maxArchiveDepth: freezed == maxArchiveDepth
          ? _self.maxArchiveDepth
          : maxArchiveDepth // ignore: cast_nullable_to_non_nullable
              as int?,
      maxConcurrentExtractions: freezed == maxConcurrentExtractions
          ? _self.maxConcurrentExtractions
          : maxConcurrentExtractions // ignore: cast_nullable_to_non_nullable
              as int?,
      ocr: freezed == ocr
          ? _self.ocr
          : ocr // ignore: cast_nullable_to_non_nullable
              as OcrConfig?,
      outputFormat: freezed == outputFormat
          ? _self.outputFormat
          : outputFormat // ignore: cast_nullable_to_non_nullable
              as String?,
      pages: freezed == pages
          ? _self.pages
          : pages // ignore: cast_nullable_to_non_nullable
              as PageConfig?,
      pdfOptions: freezed == pdfOptions
          ? _self.pdfOptions
          : pdfOptions // ignore: cast_nullable_to_non_nullable
              as PdfConfig?,
      postprocessor: freezed == postprocessor
          ? _self.postprocessor
          : postprocessor // ignore: cast_nullable_to_non_nullable
              as PostProcessorConfig?,
      resultFormat: freezed == resultFormat
          ? _self.resultFormat
          : resultFormat // ignore: cast_nullable_to_non_nullable
              as String?,
      securityLimits: freezed == securityLimits
          ? _self.securityLimits
          : securityLimits // ignore: cast_nullable_to_non_nullable
              as dynamic,
      tokenReduction: freezed == tokenReduction
          ? _self.tokenReduction
          : tokenReduction // ignore: cast_nullable_to_non_nullable
              as TokenReductionConfig?,
      useCache: freezed == useCache
          ? _self.useCache
          : useCache // ignore: cast_nullable_to_non_nullable
              as bool?,
    ));
  }

  /// Create a copy of ExtractionConfig
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ChunkingConfigCopyWith<$Res>? get chunking {
    if (_self.chunking == null) {
      return null;
    }

    return $ChunkingConfigCopyWith<$Res>(_self.chunking!, (value) {
      return _then(_self.copyWith(chunking: value));
    });
  }

  /// Create a copy of ExtractionConfig
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ContentFilterConfigCopyWith<$Res>? get contentFilter {
    if (_self.contentFilter == null) {
      return null;
    }

    return $ContentFilterConfigCopyWith<$Res>(_self.contentFilter!, (value) {
      return _then(_self.copyWith(contentFilter: value));
    });
  }

  /// Create a copy of ExtractionConfig
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ImageExtractionConfigCopyWith<$Res>? get images {
    if (_self.images == null) {
      return null;
    }

    return $ImageExtractionConfigCopyWith<$Res>(_self.images!, (value) {
      return _then(_self.copyWith(images: value));
    });
  }

  /// Create a copy of ExtractionConfig
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $LanguageDetectionConfigCopyWith<$Res>? get languageDetection {
    if (_self.languageDetection == null) {
      return null;
    }

    return $LanguageDetectionConfigCopyWith<$Res>(_self.languageDetection!,
        (value) {
      return _then(_self.copyWith(languageDetection: value));
    });
  }

  /// Create a copy of ExtractionConfig
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $LayoutDetectionConfigCopyWith<$Res>? get layout {
    if (_self.layout == null) {
      return null;
    }

    return $LayoutDetectionConfigCopyWith<$Res>(_self.layout!, (value) {
      return _then(_self.copyWith(layout: value));
    });
  }

  /// Create a copy of ExtractionConfig
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $OcrConfigCopyWith<$Res>? get ocr {
    if (_self.ocr == null) {
      return null;
    }

    return $OcrConfigCopyWith<$Res>(_self.ocr!, (value) {
      return _then(_self.copyWith(ocr: value));
    });
  }

  /// Create a copy of ExtractionConfig
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $PageConfigCopyWith<$Res>? get pages {
    if (_self.pages == null) {
      return null;
    }

    return $PageConfigCopyWith<$Res>(_self.pages!, (value) {
      return _then(_self.copyWith(pages: value));
    });
  }

  /// Create a copy of ExtractionConfig
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $PdfConfigCopyWith<$Res>? get pdfOptions {
    if (_self.pdfOptions == null) {
      return null;
    }

    return $PdfConfigCopyWith<$Res>(_self.pdfOptions!, (value) {
      return _then(_self.copyWith(pdfOptions: value));
    });
  }

  /// Create a copy of ExtractionConfig
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $PostProcessorConfigCopyWith<$Res>? get postprocessor {
    if (_self.postprocessor == null) {
      return null;
    }

    return $PostProcessorConfigCopyWith<$Res>(_self.postprocessor!, (value) {
      return _then(_self.copyWith(postprocessor: value));
    });
  }

  /// Create a copy of ExtractionConfig
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $TokenReductionConfigCopyWith<$Res>? get tokenReduction {
    if (_self.tokenReduction == null) {
      return null;
    }

    return $TokenReductionConfigCopyWith<$Res>(_self.tokenReduction!, (value) {
      return _then(_self.copyWith(tokenReduction: value));
    });
  }
}

// dart format on
