// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'file_extraction_config.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$FileExtractionConfig {

 ChunkingConfig? get chunking;@JsonKey(name: 'content_filter') ContentFilterConfig? get contentFilter;@JsonKey(name: 'disable_ocr') bool? get disableOcr;@JsonKey(name: 'enable_quality_processing') bool? get enableQualityProcessing;@JsonKey(name: 'extraction_timeout_secs') int? get extractionTimeoutSecs;@JsonKey(name: 'force_ocr') bool? get forceOcr;@JsonKey(name: 'force_ocr_pages') List<int>? get forceOcrPages; ImageExtractionConfig? get images;@JsonKey(name: 'include_document_structure') bool? get includeDocumentStructure;@JsonKey(name: 'language_detection') LanguageDetectionConfig? get languageDetection; OcrConfig? get ocr;@JsonKey(name: 'output_format') String? get outputFormat; PageConfig? get pages; PostProcessorConfig? get postprocessor;@JsonKey(name: 'result_format') String? get resultFormat;@JsonKey(name: 'token_reduction') TokenReductionConfig? get tokenReduction;
/// Create a copy of FileExtractionConfig
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FileExtractionConfigCopyWith<FileExtractionConfig> get copyWith => _$FileExtractionConfigCopyWithImpl<FileExtractionConfig>(this as FileExtractionConfig, _$identity);

  /// Serializes this FileExtractionConfig to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FileExtractionConfig&&(identical(other.chunking, chunking) || other.chunking == chunking)&&(identical(other.contentFilter, contentFilter) || other.contentFilter == contentFilter)&&(identical(other.disableOcr, disableOcr) || other.disableOcr == disableOcr)&&(identical(other.enableQualityProcessing, enableQualityProcessing) || other.enableQualityProcessing == enableQualityProcessing)&&(identical(other.extractionTimeoutSecs, extractionTimeoutSecs) || other.extractionTimeoutSecs == extractionTimeoutSecs)&&(identical(other.forceOcr, forceOcr) || other.forceOcr == forceOcr)&&const DeepCollectionEquality().equals(other.forceOcrPages, forceOcrPages)&&(identical(other.images, images) || other.images == images)&&(identical(other.includeDocumentStructure, includeDocumentStructure) || other.includeDocumentStructure == includeDocumentStructure)&&(identical(other.languageDetection, languageDetection) || other.languageDetection == languageDetection)&&(identical(other.ocr, ocr) || other.ocr == ocr)&&(identical(other.outputFormat, outputFormat) || other.outputFormat == outputFormat)&&(identical(other.pages, pages) || other.pages == pages)&&(identical(other.postprocessor, postprocessor) || other.postprocessor == postprocessor)&&(identical(other.resultFormat, resultFormat) || other.resultFormat == resultFormat)&&(identical(other.tokenReduction, tokenReduction) || other.tokenReduction == tokenReduction));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,chunking,contentFilter,disableOcr,enableQualityProcessing,extractionTimeoutSecs,forceOcr,const DeepCollectionEquality().hash(forceOcrPages),images,includeDocumentStructure,languageDetection,ocr,outputFormat,pages,postprocessor,resultFormat,tokenReduction);

@override
String toString() {
  return 'FileExtractionConfig(chunking: $chunking, contentFilter: $contentFilter, disableOcr: $disableOcr, enableQualityProcessing: $enableQualityProcessing, extractionTimeoutSecs: $extractionTimeoutSecs, forceOcr: $forceOcr, forceOcrPages: $forceOcrPages, images: $images, includeDocumentStructure: $includeDocumentStructure, languageDetection: $languageDetection, ocr: $ocr, outputFormat: $outputFormat, pages: $pages, postprocessor: $postprocessor, resultFormat: $resultFormat, tokenReduction: $tokenReduction)';
}


}

/// @nodoc
abstract mixin class $FileExtractionConfigCopyWith<$Res>  {
  factory $FileExtractionConfigCopyWith(FileExtractionConfig value, $Res Function(FileExtractionConfig) _then) = _$FileExtractionConfigCopyWithImpl;
@useResult
$Res call({
 ChunkingConfig? chunking,@JsonKey(name: 'content_filter') ContentFilterConfig? contentFilter,@JsonKey(name: 'disable_ocr') bool? disableOcr,@JsonKey(name: 'enable_quality_processing') bool? enableQualityProcessing,@JsonKey(name: 'extraction_timeout_secs') int? extractionTimeoutSecs,@JsonKey(name: 'force_ocr') bool? forceOcr,@JsonKey(name: 'force_ocr_pages') List<int>? forceOcrPages, ImageExtractionConfig? images,@JsonKey(name: 'include_document_structure') bool? includeDocumentStructure,@JsonKey(name: 'language_detection') LanguageDetectionConfig? languageDetection, OcrConfig? ocr,@JsonKey(name: 'output_format') String? outputFormat, PageConfig? pages, PostProcessorConfig? postprocessor,@JsonKey(name: 'result_format') String? resultFormat,@JsonKey(name: 'token_reduction') TokenReductionConfig? tokenReduction
});


$ChunkingConfigCopyWith<$Res>? get chunking;$ContentFilterConfigCopyWith<$Res>? get contentFilter;$ImageExtractionConfigCopyWith<$Res>? get images;$LanguageDetectionConfigCopyWith<$Res>? get languageDetection;$OcrConfigCopyWith<$Res>? get ocr;$PageConfigCopyWith<$Res>? get pages;$PostProcessorConfigCopyWith<$Res>? get postprocessor;$TokenReductionConfigCopyWith<$Res>? get tokenReduction;

}
/// @nodoc
class _$FileExtractionConfigCopyWithImpl<$Res>
    implements $FileExtractionConfigCopyWith<$Res> {
  _$FileExtractionConfigCopyWithImpl(this._self, this._then);

  final FileExtractionConfig _self;
  final $Res Function(FileExtractionConfig) _then;

/// Create a copy of FileExtractionConfig
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? chunking = freezed,Object? contentFilter = freezed,Object? disableOcr = freezed,Object? enableQualityProcessing = freezed,Object? extractionTimeoutSecs = freezed,Object? forceOcr = freezed,Object? forceOcrPages = freezed,Object? images = freezed,Object? includeDocumentStructure = freezed,Object? languageDetection = freezed,Object? ocr = freezed,Object? outputFormat = freezed,Object? pages = freezed,Object? postprocessor = freezed,Object? resultFormat = freezed,Object? tokenReduction = freezed,}) {
  return _then(_self.copyWith(
chunking: freezed == chunking ? _self.chunking : chunking // ignore: cast_nullable_to_non_nullable
as ChunkingConfig?,contentFilter: freezed == contentFilter ? _self.contentFilter : contentFilter // ignore: cast_nullable_to_non_nullable
as ContentFilterConfig?,disableOcr: freezed == disableOcr ? _self.disableOcr : disableOcr // ignore: cast_nullable_to_non_nullable
as bool?,enableQualityProcessing: freezed == enableQualityProcessing ? _self.enableQualityProcessing : enableQualityProcessing // ignore: cast_nullable_to_non_nullable
as bool?,extractionTimeoutSecs: freezed == extractionTimeoutSecs ? _self.extractionTimeoutSecs : extractionTimeoutSecs // ignore: cast_nullable_to_non_nullable
as int?,forceOcr: freezed == forceOcr ? _self.forceOcr : forceOcr // ignore: cast_nullable_to_non_nullable
as bool?,forceOcrPages: freezed == forceOcrPages ? _self.forceOcrPages : forceOcrPages // ignore: cast_nullable_to_non_nullable
as List<int>?,images: freezed == images ? _self.images : images // ignore: cast_nullable_to_non_nullable
as ImageExtractionConfig?,includeDocumentStructure: freezed == includeDocumentStructure ? _self.includeDocumentStructure : includeDocumentStructure // ignore: cast_nullable_to_non_nullable
as bool?,languageDetection: freezed == languageDetection ? _self.languageDetection : languageDetection // ignore: cast_nullable_to_non_nullable
as LanguageDetectionConfig?,ocr: freezed == ocr ? _self.ocr : ocr // ignore: cast_nullable_to_non_nullable
as OcrConfig?,outputFormat: freezed == outputFormat ? _self.outputFormat : outputFormat // ignore: cast_nullable_to_non_nullable
as String?,pages: freezed == pages ? _self.pages : pages // ignore: cast_nullable_to_non_nullable
as PageConfig?,postprocessor: freezed == postprocessor ? _self.postprocessor : postprocessor // ignore: cast_nullable_to_non_nullable
as PostProcessorConfig?,resultFormat: freezed == resultFormat ? _self.resultFormat : resultFormat // ignore: cast_nullable_to_non_nullable
as String?,tokenReduction: freezed == tokenReduction ? _self.tokenReduction : tokenReduction // ignore: cast_nullable_to_non_nullable
as TokenReductionConfig?,
  ));
}
/// Create a copy of FileExtractionConfig
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
}/// Create a copy of FileExtractionConfig
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
}/// Create a copy of FileExtractionConfig
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
}/// Create a copy of FileExtractionConfig
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LanguageDetectionConfigCopyWith<$Res>? get languageDetection {
    if (_self.languageDetection == null) {
    return null;
  }

  return $LanguageDetectionConfigCopyWith<$Res>(_self.languageDetection!, (value) {
    return _then(_self.copyWith(languageDetection: value));
  });
}/// Create a copy of FileExtractionConfig
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
}/// Create a copy of FileExtractionConfig
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
}/// Create a copy of FileExtractionConfig
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
}/// Create a copy of FileExtractionConfig
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


/// Adds pattern-matching-related methods to [FileExtractionConfig].
extension FileExtractionConfigPatterns on FileExtractionConfig {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FileExtractionConfig value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FileExtractionConfig() when $default != null:
return $default(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FileExtractionConfig value)  $default,){
final _that = this;
switch (_that) {
case _FileExtractionConfig():
return $default(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FileExtractionConfig value)?  $default,){
final _that = this;
switch (_that) {
case _FileExtractionConfig() when $default != null:
return $default(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( ChunkingConfig? chunking, @JsonKey(name: 'content_filter')  ContentFilterConfig? contentFilter, @JsonKey(name: 'disable_ocr')  bool? disableOcr, @JsonKey(name: 'enable_quality_processing')  bool? enableQualityProcessing, @JsonKey(name: 'extraction_timeout_secs')  int? extractionTimeoutSecs, @JsonKey(name: 'force_ocr')  bool? forceOcr, @JsonKey(name: 'force_ocr_pages')  List<int>? forceOcrPages,  ImageExtractionConfig? images, @JsonKey(name: 'include_document_structure')  bool? includeDocumentStructure, @JsonKey(name: 'language_detection')  LanguageDetectionConfig? languageDetection,  OcrConfig? ocr, @JsonKey(name: 'output_format')  String? outputFormat,  PageConfig? pages,  PostProcessorConfig? postprocessor, @JsonKey(name: 'result_format')  String? resultFormat, @JsonKey(name: 'token_reduction')  TokenReductionConfig? tokenReduction)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FileExtractionConfig() when $default != null:
return $default(_that.chunking,_that.contentFilter,_that.disableOcr,_that.enableQualityProcessing,_that.extractionTimeoutSecs,_that.forceOcr,_that.forceOcrPages,_that.images,_that.includeDocumentStructure,_that.languageDetection,_that.ocr,_that.outputFormat,_that.pages,_that.postprocessor,_that.resultFormat,_that.tokenReduction);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( ChunkingConfig? chunking, @JsonKey(name: 'content_filter')  ContentFilterConfig? contentFilter, @JsonKey(name: 'disable_ocr')  bool? disableOcr, @JsonKey(name: 'enable_quality_processing')  bool? enableQualityProcessing, @JsonKey(name: 'extraction_timeout_secs')  int? extractionTimeoutSecs, @JsonKey(name: 'force_ocr')  bool? forceOcr, @JsonKey(name: 'force_ocr_pages')  List<int>? forceOcrPages,  ImageExtractionConfig? images, @JsonKey(name: 'include_document_structure')  bool? includeDocumentStructure, @JsonKey(name: 'language_detection')  LanguageDetectionConfig? languageDetection,  OcrConfig? ocr, @JsonKey(name: 'output_format')  String? outputFormat,  PageConfig? pages,  PostProcessorConfig? postprocessor, @JsonKey(name: 'result_format')  String? resultFormat, @JsonKey(name: 'token_reduction')  TokenReductionConfig? tokenReduction)  $default,) {final _that = this;
switch (_that) {
case _FileExtractionConfig():
return $default(_that.chunking,_that.contentFilter,_that.disableOcr,_that.enableQualityProcessing,_that.extractionTimeoutSecs,_that.forceOcr,_that.forceOcrPages,_that.images,_that.includeDocumentStructure,_that.languageDetection,_that.ocr,_that.outputFormat,_that.pages,_that.postprocessor,_that.resultFormat,_that.tokenReduction);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( ChunkingConfig? chunking, @JsonKey(name: 'content_filter')  ContentFilterConfig? contentFilter, @JsonKey(name: 'disable_ocr')  bool? disableOcr, @JsonKey(name: 'enable_quality_processing')  bool? enableQualityProcessing, @JsonKey(name: 'extraction_timeout_secs')  int? extractionTimeoutSecs, @JsonKey(name: 'force_ocr')  bool? forceOcr, @JsonKey(name: 'force_ocr_pages')  List<int>? forceOcrPages,  ImageExtractionConfig? images, @JsonKey(name: 'include_document_structure')  bool? includeDocumentStructure, @JsonKey(name: 'language_detection')  LanguageDetectionConfig? languageDetection,  OcrConfig? ocr, @JsonKey(name: 'output_format')  String? outputFormat,  PageConfig? pages,  PostProcessorConfig? postprocessor, @JsonKey(name: 'result_format')  String? resultFormat, @JsonKey(name: 'token_reduction')  TokenReductionConfig? tokenReduction)?  $default,) {final _that = this;
switch (_that) {
case _FileExtractionConfig() when $default != null:
return $default(_that.chunking,_that.contentFilter,_that.disableOcr,_that.enableQualityProcessing,_that.extractionTimeoutSecs,_that.forceOcr,_that.forceOcrPages,_that.images,_that.includeDocumentStructure,_that.languageDetection,_that.ocr,_that.outputFormat,_that.pages,_that.postprocessor,_that.resultFormat,_that.tokenReduction);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _FileExtractionConfig implements FileExtractionConfig {
  const _FileExtractionConfig({this.chunking, @JsonKey(name: 'content_filter') this.contentFilter, @JsonKey(name: 'disable_ocr') this.disableOcr, @JsonKey(name: 'enable_quality_processing') this.enableQualityProcessing, @JsonKey(name: 'extraction_timeout_secs') this.extractionTimeoutSecs, @JsonKey(name: 'force_ocr') this.forceOcr, @JsonKey(name: 'force_ocr_pages') final  List<int>? forceOcrPages, this.images, @JsonKey(name: 'include_document_structure') this.includeDocumentStructure, @JsonKey(name: 'language_detection') this.languageDetection, this.ocr, @JsonKey(name: 'output_format') this.outputFormat, this.pages, this.postprocessor, @JsonKey(name: 'result_format') this.resultFormat, @JsonKey(name: 'token_reduction') this.tokenReduction}): _forceOcrPages = forceOcrPages;
  factory _FileExtractionConfig.fromJson(Map<String, dynamic> json) => _$FileExtractionConfigFromJson(json);

@override final  ChunkingConfig? chunking;
@override@JsonKey(name: 'content_filter') final  ContentFilterConfig? contentFilter;
@override@JsonKey(name: 'disable_ocr') final  bool? disableOcr;
@override@JsonKey(name: 'enable_quality_processing') final  bool? enableQualityProcessing;
@override@JsonKey(name: 'extraction_timeout_secs') final  int? extractionTimeoutSecs;
@override@JsonKey(name: 'force_ocr') final  bool? forceOcr;
 final  List<int>? _forceOcrPages;
@override@JsonKey(name: 'force_ocr_pages') List<int>? get forceOcrPages {
  final value = _forceOcrPages;
  if (value == null) return null;
  if (_forceOcrPages is EqualUnmodifiableListView) return _forceOcrPages;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

@override final  ImageExtractionConfig? images;
@override@JsonKey(name: 'include_document_structure') final  bool? includeDocumentStructure;
@override@JsonKey(name: 'language_detection') final  LanguageDetectionConfig? languageDetection;
@override final  OcrConfig? ocr;
@override@JsonKey(name: 'output_format') final  String? outputFormat;
@override final  PageConfig? pages;
@override final  PostProcessorConfig? postprocessor;
@override@JsonKey(name: 'result_format') final  String? resultFormat;
@override@JsonKey(name: 'token_reduction') final  TokenReductionConfig? tokenReduction;

/// Create a copy of FileExtractionConfig
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FileExtractionConfigCopyWith<_FileExtractionConfig> get copyWith => __$FileExtractionConfigCopyWithImpl<_FileExtractionConfig>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$FileExtractionConfigToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FileExtractionConfig&&(identical(other.chunking, chunking) || other.chunking == chunking)&&(identical(other.contentFilter, contentFilter) || other.contentFilter == contentFilter)&&(identical(other.disableOcr, disableOcr) || other.disableOcr == disableOcr)&&(identical(other.enableQualityProcessing, enableQualityProcessing) || other.enableQualityProcessing == enableQualityProcessing)&&(identical(other.extractionTimeoutSecs, extractionTimeoutSecs) || other.extractionTimeoutSecs == extractionTimeoutSecs)&&(identical(other.forceOcr, forceOcr) || other.forceOcr == forceOcr)&&const DeepCollectionEquality().equals(other._forceOcrPages, _forceOcrPages)&&(identical(other.images, images) || other.images == images)&&(identical(other.includeDocumentStructure, includeDocumentStructure) || other.includeDocumentStructure == includeDocumentStructure)&&(identical(other.languageDetection, languageDetection) || other.languageDetection == languageDetection)&&(identical(other.ocr, ocr) || other.ocr == ocr)&&(identical(other.outputFormat, outputFormat) || other.outputFormat == outputFormat)&&(identical(other.pages, pages) || other.pages == pages)&&(identical(other.postprocessor, postprocessor) || other.postprocessor == postprocessor)&&(identical(other.resultFormat, resultFormat) || other.resultFormat == resultFormat)&&(identical(other.tokenReduction, tokenReduction) || other.tokenReduction == tokenReduction));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,chunking,contentFilter,disableOcr,enableQualityProcessing,extractionTimeoutSecs,forceOcr,const DeepCollectionEquality().hash(_forceOcrPages),images,includeDocumentStructure,languageDetection,ocr,outputFormat,pages,postprocessor,resultFormat,tokenReduction);

@override
String toString() {
  return 'FileExtractionConfig(chunking: $chunking, contentFilter: $contentFilter, disableOcr: $disableOcr, enableQualityProcessing: $enableQualityProcessing, extractionTimeoutSecs: $extractionTimeoutSecs, forceOcr: $forceOcr, forceOcrPages: $forceOcrPages, images: $images, includeDocumentStructure: $includeDocumentStructure, languageDetection: $languageDetection, ocr: $ocr, outputFormat: $outputFormat, pages: $pages, postprocessor: $postprocessor, resultFormat: $resultFormat, tokenReduction: $tokenReduction)';
}


}

/// @nodoc
abstract mixin class _$FileExtractionConfigCopyWith<$Res> implements $FileExtractionConfigCopyWith<$Res> {
  factory _$FileExtractionConfigCopyWith(_FileExtractionConfig value, $Res Function(_FileExtractionConfig) _then) = __$FileExtractionConfigCopyWithImpl;
@override @useResult
$Res call({
 ChunkingConfig? chunking,@JsonKey(name: 'content_filter') ContentFilterConfig? contentFilter,@JsonKey(name: 'disable_ocr') bool? disableOcr,@JsonKey(name: 'enable_quality_processing') bool? enableQualityProcessing,@JsonKey(name: 'extraction_timeout_secs') int? extractionTimeoutSecs,@JsonKey(name: 'force_ocr') bool? forceOcr,@JsonKey(name: 'force_ocr_pages') List<int>? forceOcrPages, ImageExtractionConfig? images,@JsonKey(name: 'include_document_structure') bool? includeDocumentStructure,@JsonKey(name: 'language_detection') LanguageDetectionConfig? languageDetection, OcrConfig? ocr,@JsonKey(name: 'output_format') String? outputFormat, PageConfig? pages, PostProcessorConfig? postprocessor,@JsonKey(name: 'result_format') String? resultFormat,@JsonKey(name: 'token_reduction') TokenReductionConfig? tokenReduction
});


@override $ChunkingConfigCopyWith<$Res>? get chunking;@override $ContentFilterConfigCopyWith<$Res>? get contentFilter;@override $ImageExtractionConfigCopyWith<$Res>? get images;@override $LanguageDetectionConfigCopyWith<$Res>? get languageDetection;@override $OcrConfigCopyWith<$Res>? get ocr;@override $PageConfigCopyWith<$Res>? get pages;@override $PostProcessorConfigCopyWith<$Res>? get postprocessor;@override $TokenReductionConfigCopyWith<$Res>? get tokenReduction;

}
/// @nodoc
class __$FileExtractionConfigCopyWithImpl<$Res>
    implements _$FileExtractionConfigCopyWith<$Res> {
  __$FileExtractionConfigCopyWithImpl(this._self, this._then);

  final _FileExtractionConfig _self;
  final $Res Function(_FileExtractionConfig) _then;

/// Create a copy of FileExtractionConfig
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? chunking = freezed,Object? contentFilter = freezed,Object? disableOcr = freezed,Object? enableQualityProcessing = freezed,Object? extractionTimeoutSecs = freezed,Object? forceOcr = freezed,Object? forceOcrPages = freezed,Object? images = freezed,Object? includeDocumentStructure = freezed,Object? languageDetection = freezed,Object? ocr = freezed,Object? outputFormat = freezed,Object? pages = freezed,Object? postprocessor = freezed,Object? resultFormat = freezed,Object? tokenReduction = freezed,}) {
  return _then(_FileExtractionConfig(
chunking: freezed == chunking ? _self.chunking : chunking // ignore: cast_nullable_to_non_nullable
as ChunkingConfig?,contentFilter: freezed == contentFilter ? _self.contentFilter : contentFilter // ignore: cast_nullable_to_non_nullable
as ContentFilterConfig?,disableOcr: freezed == disableOcr ? _self.disableOcr : disableOcr // ignore: cast_nullable_to_non_nullable
as bool?,enableQualityProcessing: freezed == enableQualityProcessing ? _self.enableQualityProcessing : enableQualityProcessing // ignore: cast_nullable_to_non_nullable
as bool?,extractionTimeoutSecs: freezed == extractionTimeoutSecs ? _self.extractionTimeoutSecs : extractionTimeoutSecs // ignore: cast_nullable_to_non_nullable
as int?,forceOcr: freezed == forceOcr ? _self.forceOcr : forceOcr // ignore: cast_nullable_to_non_nullable
as bool?,forceOcrPages: freezed == forceOcrPages ? _self._forceOcrPages : forceOcrPages // ignore: cast_nullable_to_non_nullable
as List<int>?,images: freezed == images ? _self.images : images // ignore: cast_nullable_to_non_nullable
as ImageExtractionConfig?,includeDocumentStructure: freezed == includeDocumentStructure ? _self.includeDocumentStructure : includeDocumentStructure // ignore: cast_nullable_to_non_nullable
as bool?,languageDetection: freezed == languageDetection ? _self.languageDetection : languageDetection // ignore: cast_nullable_to_non_nullable
as LanguageDetectionConfig?,ocr: freezed == ocr ? _self.ocr : ocr // ignore: cast_nullable_to_non_nullable
as OcrConfig?,outputFormat: freezed == outputFormat ? _self.outputFormat : outputFormat // ignore: cast_nullable_to_non_nullable
as String?,pages: freezed == pages ? _self.pages : pages // ignore: cast_nullable_to_non_nullable
as PageConfig?,postprocessor: freezed == postprocessor ? _self.postprocessor : postprocessor // ignore: cast_nullable_to_non_nullable
as PostProcessorConfig?,resultFormat: freezed == resultFormat ? _self.resultFormat : resultFormat // ignore: cast_nullable_to_non_nullable
as String?,tokenReduction: freezed == tokenReduction ? _self.tokenReduction : tokenReduction // ignore: cast_nullable_to_non_nullable
as TokenReductionConfig?,
  ));
}

/// Create a copy of FileExtractionConfig
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
}/// Create a copy of FileExtractionConfig
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
}/// Create a copy of FileExtractionConfig
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
}/// Create a copy of FileExtractionConfig
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LanguageDetectionConfigCopyWith<$Res>? get languageDetection {
    if (_self.languageDetection == null) {
    return null;
  }

  return $LanguageDetectionConfigCopyWith<$Res>(_self.languageDetection!, (value) {
    return _then(_self.copyWith(languageDetection: value));
  });
}/// Create a copy of FileExtractionConfig
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
}/// Create a copy of FileExtractionConfig
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
}/// Create a copy of FileExtractionConfig
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
}/// Create a copy of FileExtractionConfig
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
