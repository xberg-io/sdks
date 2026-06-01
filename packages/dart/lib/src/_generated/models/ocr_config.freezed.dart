// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ocr_config.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$OcrConfig {

/// Automatic page rotation detection
@JsonKey(name: 'auto_rotate') bool? get autoRotate;/// OCR backend: "tesseract", "easyocr", or "vlm"
 String? get backend;/// Structured OCR element extraction
@JsonKey(name: 'element_config') OcrElementConfig? get elementConfig;/// Language code (e.g., "eng", "deu", "fra")
 String? get language;/// OCR output format override
@JsonKey(name: 'output_format') String? get outputFormat;/// Multi-backend OCR pipeline with quality-based fallback
 OcrPipelineConfig? get pipeline;/// Quality thresholds for OCR fallback decisions
@JsonKey(name: 'quality_thresholds') OcrQualityThresholds? get qualityThresholds;/// Tesseract-specific configuration (flexible JSON with 20+ fields)
@JsonKey(name: 'tesseract_config') dynamic get tesseractConfig;/// VLM (Vision Language Model) configuration
@JsonKey(name: 'vlm_config') dynamic get vlmConfig;/// Custom Jinja2 prompt template for VLM OCR
@JsonKey(name: 'vlm_prompt') String? get vlmPrompt;
/// Create a copy of OcrConfig
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OcrConfigCopyWith<OcrConfig> get copyWith => _$OcrConfigCopyWithImpl<OcrConfig>(this as OcrConfig, _$identity);

  /// Serializes this OcrConfig to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OcrConfig&&(identical(other.autoRotate, autoRotate) || other.autoRotate == autoRotate)&&(identical(other.backend, backend) || other.backend == backend)&&(identical(other.elementConfig, elementConfig) || other.elementConfig == elementConfig)&&(identical(other.language, language) || other.language == language)&&(identical(other.outputFormat, outputFormat) || other.outputFormat == outputFormat)&&(identical(other.pipeline, pipeline) || other.pipeline == pipeline)&&(identical(other.qualityThresholds, qualityThresholds) || other.qualityThresholds == qualityThresholds)&&const DeepCollectionEquality().equals(other.tesseractConfig, tesseractConfig)&&const DeepCollectionEquality().equals(other.vlmConfig, vlmConfig)&&(identical(other.vlmPrompt, vlmPrompt) || other.vlmPrompt == vlmPrompt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,autoRotate,backend,elementConfig,language,outputFormat,pipeline,qualityThresholds,const DeepCollectionEquality().hash(tesseractConfig),const DeepCollectionEquality().hash(vlmConfig),vlmPrompt);

@override
String toString() {
  return 'OcrConfig(autoRotate: $autoRotate, backend: $backend, elementConfig: $elementConfig, language: $language, outputFormat: $outputFormat, pipeline: $pipeline, qualityThresholds: $qualityThresholds, tesseractConfig: $tesseractConfig, vlmConfig: $vlmConfig, vlmPrompt: $vlmPrompt)';
}


}

/// @nodoc
abstract mixin class $OcrConfigCopyWith<$Res>  {
  factory $OcrConfigCopyWith(OcrConfig value, $Res Function(OcrConfig) _then) = _$OcrConfigCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'auto_rotate') bool? autoRotate, String? backend,@JsonKey(name: 'element_config') OcrElementConfig? elementConfig, String? language,@JsonKey(name: 'output_format') String? outputFormat, OcrPipelineConfig? pipeline,@JsonKey(name: 'quality_thresholds') OcrQualityThresholds? qualityThresholds,@JsonKey(name: 'tesseract_config') dynamic tesseractConfig,@JsonKey(name: 'vlm_config') dynamic vlmConfig,@JsonKey(name: 'vlm_prompt') String? vlmPrompt
});


$OcrElementConfigCopyWith<$Res>? get elementConfig;$OcrPipelineConfigCopyWith<$Res>? get pipeline;$OcrQualityThresholdsCopyWith<$Res>? get qualityThresholds;

}
/// @nodoc
class _$OcrConfigCopyWithImpl<$Res>
    implements $OcrConfigCopyWith<$Res> {
  _$OcrConfigCopyWithImpl(this._self, this._then);

  final OcrConfig _self;
  final $Res Function(OcrConfig) _then;

/// Create a copy of OcrConfig
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? autoRotate = freezed,Object? backend = freezed,Object? elementConfig = freezed,Object? language = freezed,Object? outputFormat = freezed,Object? pipeline = freezed,Object? qualityThresholds = freezed,Object? tesseractConfig = freezed,Object? vlmConfig = freezed,Object? vlmPrompt = freezed,}) {
  return _then(_self.copyWith(
autoRotate: freezed == autoRotate ? _self.autoRotate : autoRotate // ignore: cast_nullable_to_non_nullable
as bool?,backend: freezed == backend ? _self.backend : backend // ignore: cast_nullable_to_non_nullable
as String?,elementConfig: freezed == elementConfig ? _self.elementConfig : elementConfig // ignore: cast_nullable_to_non_nullable
as OcrElementConfig?,language: freezed == language ? _self.language : language // ignore: cast_nullable_to_non_nullable
as String?,outputFormat: freezed == outputFormat ? _self.outputFormat : outputFormat // ignore: cast_nullable_to_non_nullable
as String?,pipeline: freezed == pipeline ? _self.pipeline : pipeline // ignore: cast_nullable_to_non_nullable
as OcrPipelineConfig?,qualityThresholds: freezed == qualityThresholds ? _self.qualityThresholds : qualityThresholds // ignore: cast_nullable_to_non_nullable
as OcrQualityThresholds?,tesseractConfig: freezed == tesseractConfig ? _self.tesseractConfig : tesseractConfig // ignore: cast_nullable_to_non_nullable
as dynamic,vlmConfig: freezed == vlmConfig ? _self.vlmConfig : vlmConfig // ignore: cast_nullable_to_non_nullable
as dynamic,vlmPrompt: freezed == vlmPrompt ? _self.vlmPrompt : vlmPrompt // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of OcrConfig
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$OcrElementConfigCopyWith<$Res>? get elementConfig {
    if (_self.elementConfig == null) {
    return null;
  }

  return $OcrElementConfigCopyWith<$Res>(_self.elementConfig!, (value) {
    return _then(_self.copyWith(elementConfig: value));
  });
}/// Create a copy of OcrConfig
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$OcrPipelineConfigCopyWith<$Res>? get pipeline {
    if (_self.pipeline == null) {
    return null;
  }

  return $OcrPipelineConfigCopyWith<$Res>(_self.pipeline!, (value) {
    return _then(_self.copyWith(pipeline: value));
  });
}/// Create a copy of OcrConfig
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$OcrQualityThresholdsCopyWith<$Res>? get qualityThresholds {
    if (_self.qualityThresholds == null) {
    return null;
  }

  return $OcrQualityThresholdsCopyWith<$Res>(_self.qualityThresholds!, (value) {
    return _then(_self.copyWith(qualityThresholds: value));
  });
}
}


/// Adds pattern-matching-related methods to [OcrConfig].
extension OcrConfigPatterns on OcrConfig {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _OcrConfig value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _OcrConfig() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _OcrConfig value)  $default,){
final _that = this;
switch (_that) {
case _OcrConfig():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _OcrConfig value)?  $default,){
final _that = this;
switch (_that) {
case _OcrConfig() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'auto_rotate')  bool? autoRotate,  String? backend, @JsonKey(name: 'element_config')  OcrElementConfig? elementConfig,  String? language, @JsonKey(name: 'output_format')  String? outputFormat,  OcrPipelineConfig? pipeline, @JsonKey(name: 'quality_thresholds')  OcrQualityThresholds? qualityThresholds, @JsonKey(name: 'tesseract_config')  dynamic tesseractConfig, @JsonKey(name: 'vlm_config')  dynamic vlmConfig, @JsonKey(name: 'vlm_prompt')  String? vlmPrompt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _OcrConfig() when $default != null:
return $default(_that.autoRotate,_that.backend,_that.elementConfig,_that.language,_that.outputFormat,_that.pipeline,_that.qualityThresholds,_that.tesseractConfig,_that.vlmConfig,_that.vlmPrompt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'auto_rotate')  bool? autoRotate,  String? backend, @JsonKey(name: 'element_config')  OcrElementConfig? elementConfig,  String? language, @JsonKey(name: 'output_format')  String? outputFormat,  OcrPipelineConfig? pipeline, @JsonKey(name: 'quality_thresholds')  OcrQualityThresholds? qualityThresholds, @JsonKey(name: 'tesseract_config')  dynamic tesseractConfig, @JsonKey(name: 'vlm_config')  dynamic vlmConfig, @JsonKey(name: 'vlm_prompt')  String? vlmPrompt)  $default,) {final _that = this;
switch (_that) {
case _OcrConfig():
return $default(_that.autoRotate,_that.backend,_that.elementConfig,_that.language,_that.outputFormat,_that.pipeline,_that.qualityThresholds,_that.tesseractConfig,_that.vlmConfig,_that.vlmPrompt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'auto_rotate')  bool? autoRotate,  String? backend, @JsonKey(name: 'element_config')  OcrElementConfig? elementConfig,  String? language, @JsonKey(name: 'output_format')  String? outputFormat,  OcrPipelineConfig? pipeline, @JsonKey(name: 'quality_thresholds')  OcrQualityThresholds? qualityThresholds, @JsonKey(name: 'tesseract_config')  dynamic tesseractConfig, @JsonKey(name: 'vlm_config')  dynamic vlmConfig, @JsonKey(name: 'vlm_prompt')  String? vlmPrompt)?  $default,) {final _that = this;
switch (_that) {
case _OcrConfig() when $default != null:
return $default(_that.autoRotate,_that.backend,_that.elementConfig,_that.language,_that.outputFormat,_that.pipeline,_that.qualityThresholds,_that.tesseractConfig,_that.vlmConfig,_that.vlmPrompt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _OcrConfig implements OcrConfig {
  const _OcrConfig({@JsonKey(name: 'auto_rotate') this.autoRotate, this.backend, @JsonKey(name: 'element_config') this.elementConfig, this.language, @JsonKey(name: 'output_format') this.outputFormat, this.pipeline, @JsonKey(name: 'quality_thresholds') this.qualityThresholds, @JsonKey(name: 'tesseract_config') this.tesseractConfig, @JsonKey(name: 'vlm_config') this.vlmConfig, @JsonKey(name: 'vlm_prompt') this.vlmPrompt});
  factory _OcrConfig.fromJson(Map<String, dynamic> json) => _$OcrConfigFromJson(json);

/// Automatic page rotation detection
@override@JsonKey(name: 'auto_rotate') final  bool? autoRotate;
/// OCR backend: "tesseract", "easyocr", or "vlm"
@override final  String? backend;
/// Structured OCR element extraction
@override@JsonKey(name: 'element_config') final  OcrElementConfig? elementConfig;
/// Language code (e.g., "eng", "deu", "fra")
@override final  String? language;
/// OCR output format override
@override@JsonKey(name: 'output_format') final  String? outputFormat;
/// Multi-backend OCR pipeline with quality-based fallback
@override final  OcrPipelineConfig? pipeline;
/// Quality thresholds for OCR fallback decisions
@override@JsonKey(name: 'quality_thresholds') final  OcrQualityThresholds? qualityThresholds;
/// Tesseract-specific configuration (flexible JSON with 20+ fields)
@override@JsonKey(name: 'tesseract_config') final  dynamic tesseractConfig;
/// VLM (Vision Language Model) configuration
@override@JsonKey(name: 'vlm_config') final  dynamic vlmConfig;
/// Custom Jinja2 prompt template for VLM OCR
@override@JsonKey(name: 'vlm_prompt') final  String? vlmPrompt;

/// Create a copy of OcrConfig
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$OcrConfigCopyWith<_OcrConfig> get copyWith => __$OcrConfigCopyWithImpl<_OcrConfig>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$OcrConfigToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _OcrConfig&&(identical(other.autoRotate, autoRotate) || other.autoRotate == autoRotate)&&(identical(other.backend, backend) || other.backend == backend)&&(identical(other.elementConfig, elementConfig) || other.elementConfig == elementConfig)&&(identical(other.language, language) || other.language == language)&&(identical(other.outputFormat, outputFormat) || other.outputFormat == outputFormat)&&(identical(other.pipeline, pipeline) || other.pipeline == pipeline)&&(identical(other.qualityThresholds, qualityThresholds) || other.qualityThresholds == qualityThresholds)&&const DeepCollectionEquality().equals(other.tesseractConfig, tesseractConfig)&&const DeepCollectionEquality().equals(other.vlmConfig, vlmConfig)&&(identical(other.vlmPrompt, vlmPrompt) || other.vlmPrompt == vlmPrompt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,autoRotate,backend,elementConfig,language,outputFormat,pipeline,qualityThresholds,const DeepCollectionEquality().hash(tesseractConfig),const DeepCollectionEquality().hash(vlmConfig),vlmPrompt);

@override
String toString() {
  return 'OcrConfig(autoRotate: $autoRotate, backend: $backend, elementConfig: $elementConfig, language: $language, outputFormat: $outputFormat, pipeline: $pipeline, qualityThresholds: $qualityThresholds, tesseractConfig: $tesseractConfig, vlmConfig: $vlmConfig, vlmPrompt: $vlmPrompt)';
}


}

/// @nodoc
abstract mixin class _$OcrConfigCopyWith<$Res> implements $OcrConfigCopyWith<$Res> {
  factory _$OcrConfigCopyWith(_OcrConfig value, $Res Function(_OcrConfig) _then) = __$OcrConfigCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'auto_rotate') bool? autoRotate, String? backend,@JsonKey(name: 'element_config') OcrElementConfig? elementConfig, String? language,@JsonKey(name: 'output_format') String? outputFormat, OcrPipelineConfig? pipeline,@JsonKey(name: 'quality_thresholds') OcrQualityThresholds? qualityThresholds,@JsonKey(name: 'tesseract_config') dynamic tesseractConfig,@JsonKey(name: 'vlm_config') dynamic vlmConfig,@JsonKey(name: 'vlm_prompt') String? vlmPrompt
});


@override $OcrElementConfigCopyWith<$Res>? get elementConfig;@override $OcrPipelineConfigCopyWith<$Res>? get pipeline;@override $OcrQualityThresholdsCopyWith<$Res>? get qualityThresholds;

}
/// @nodoc
class __$OcrConfigCopyWithImpl<$Res>
    implements _$OcrConfigCopyWith<$Res> {
  __$OcrConfigCopyWithImpl(this._self, this._then);

  final _OcrConfig _self;
  final $Res Function(_OcrConfig) _then;

/// Create a copy of OcrConfig
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? autoRotate = freezed,Object? backend = freezed,Object? elementConfig = freezed,Object? language = freezed,Object? outputFormat = freezed,Object? pipeline = freezed,Object? qualityThresholds = freezed,Object? tesseractConfig = freezed,Object? vlmConfig = freezed,Object? vlmPrompt = freezed,}) {
  return _then(_OcrConfig(
autoRotate: freezed == autoRotate ? _self.autoRotate : autoRotate // ignore: cast_nullable_to_non_nullable
as bool?,backend: freezed == backend ? _self.backend : backend // ignore: cast_nullable_to_non_nullable
as String?,elementConfig: freezed == elementConfig ? _self.elementConfig : elementConfig // ignore: cast_nullable_to_non_nullable
as OcrElementConfig?,language: freezed == language ? _self.language : language // ignore: cast_nullable_to_non_nullable
as String?,outputFormat: freezed == outputFormat ? _self.outputFormat : outputFormat // ignore: cast_nullable_to_non_nullable
as String?,pipeline: freezed == pipeline ? _self.pipeline : pipeline // ignore: cast_nullable_to_non_nullable
as OcrPipelineConfig?,qualityThresholds: freezed == qualityThresholds ? _self.qualityThresholds : qualityThresholds // ignore: cast_nullable_to_non_nullable
as OcrQualityThresholds?,tesseractConfig: freezed == tesseractConfig ? _self.tesseractConfig : tesseractConfig // ignore: cast_nullable_to_non_nullable
as dynamic,vlmConfig: freezed == vlmConfig ? _self.vlmConfig : vlmConfig // ignore: cast_nullable_to_non_nullable
as dynamic,vlmPrompt: freezed == vlmPrompt ? _self.vlmPrompt : vlmPrompt // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of OcrConfig
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$OcrElementConfigCopyWith<$Res>? get elementConfig {
    if (_self.elementConfig == null) {
    return null;
  }

  return $OcrElementConfigCopyWith<$Res>(_self.elementConfig!, (value) {
    return _then(_self.copyWith(elementConfig: value));
  });
}/// Create a copy of OcrConfig
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$OcrPipelineConfigCopyWith<$Res>? get pipeline {
    if (_self.pipeline == null) {
    return null;
  }

  return $OcrPipelineConfigCopyWith<$Res>(_self.pipeline!, (value) {
    return _then(_self.copyWith(pipeline: value));
  });
}/// Create a copy of OcrConfig
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$OcrQualityThresholdsCopyWith<$Res>? get qualityThresholds {
    if (_self.qualityThresholds == null) {
    return null;
  }

  return $OcrQualityThresholdsCopyWith<$Res>(_self.qualityThresholds!, (value) {
    return _then(_self.copyWith(qualityThresholds: value));
  });
}
}

// dart format on
