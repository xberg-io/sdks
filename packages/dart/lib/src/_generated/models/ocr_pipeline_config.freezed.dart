// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ocr_pipeline_config.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$OcrPipelineConfig {

/// Quality evaluation thresholds for fallback decisions
@JsonKey(name: 'quality_thresholds') OcrQualityThresholds? get qualityThresholds;/// Ordered list of backends to try (sorted by priority descending)
 List<OcrPipelineStage>? get stages;
/// Create a copy of OcrPipelineConfig
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OcrPipelineConfigCopyWith<OcrPipelineConfig> get copyWith => _$OcrPipelineConfigCopyWithImpl<OcrPipelineConfig>(this as OcrPipelineConfig, _$identity);

  /// Serializes this OcrPipelineConfig to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OcrPipelineConfig&&(identical(other.qualityThresholds, qualityThresholds) || other.qualityThresholds == qualityThresholds)&&const DeepCollectionEquality().equals(other.stages, stages));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,qualityThresholds,const DeepCollectionEquality().hash(stages));

@override
String toString() {
  return 'OcrPipelineConfig(qualityThresholds: $qualityThresholds, stages: $stages)';
}


}

/// @nodoc
abstract mixin class $OcrPipelineConfigCopyWith<$Res>  {
  factory $OcrPipelineConfigCopyWith(OcrPipelineConfig value, $Res Function(OcrPipelineConfig) _then) = _$OcrPipelineConfigCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'quality_thresholds') OcrQualityThresholds? qualityThresholds, List<OcrPipelineStage>? stages
});


$OcrQualityThresholdsCopyWith<$Res>? get qualityThresholds;

}
/// @nodoc
class _$OcrPipelineConfigCopyWithImpl<$Res>
    implements $OcrPipelineConfigCopyWith<$Res> {
  _$OcrPipelineConfigCopyWithImpl(this._self, this._then);

  final OcrPipelineConfig _self;
  final $Res Function(OcrPipelineConfig) _then;

/// Create a copy of OcrPipelineConfig
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? qualityThresholds = freezed,Object? stages = freezed,}) {
  return _then(_self.copyWith(
qualityThresholds: freezed == qualityThresholds ? _self.qualityThresholds : qualityThresholds // ignore: cast_nullable_to_non_nullable
as OcrQualityThresholds?,stages: freezed == stages ? _self.stages : stages // ignore: cast_nullable_to_non_nullable
as List<OcrPipelineStage>?,
  ));
}
/// Create a copy of OcrPipelineConfig
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


/// Adds pattern-matching-related methods to [OcrPipelineConfig].
extension OcrPipelineConfigPatterns on OcrPipelineConfig {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _OcrPipelineConfig value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _OcrPipelineConfig() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _OcrPipelineConfig value)  $default,){
final _that = this;
switch (_that) {
case _OcrPipelineConfig():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _OcrPipelineConfig value)?  $default,){
final _that = this;
switch (_that) {
case _OcrPipelineConfig() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'quality_thresholds')  OcrQualityThresholds? qualityThresholds,  List<OcrPipelineStage>? stages)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _OcrPipelineConfig() when $default != null:
return $default(_that.qualityThresholds,_that.stages);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'quality_thresholds')  OcrQualityThresholds? qualityThresholds,  List<OcrPipelineStage>? stages)  $default,) {final _that = this;
switch (_that) {
case _OcrPipelineConfig():
return $default(_that.qualityThresholds,_that.stages);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'quality_thresholds')  OcrQualityThresholds? qualityThresholds,  List<OcrPipelineStage>? stages)?  $default,) {final _that = this;
switch (_that) {
case _OcrPipelineConfig() when $default != null:
return $default(_that.qualityThresholds,_that.stages);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _OcrPipelineConfig implements OcrPipelineConfig {
  const _OcrPipelineConfig({@JsonKey(name: 'quality_thresholds') this.qualityThresholds, final  List<OcrPipelineStage>? stages}): _stages = stages;
  factory _OcrPipelineConfig.fromJson(Map<String, dynamic> json) => _$OcrPipelineConfigFromJson(json);

/// Quality evaluation thresholds for fallback decisions
@override@JsonKey(name: 'quality_thresholds') final  OcrQualityThresholds? qualityThresholds;
/// Ordered list of backends to try (sorted by priority descending)
 final  List<OcrPipelineStage>? _stages;
/// Ordered list of backends to try (sorted by priority descending)
@override List<OcrPipelineStage>? get stages {
  final value = _stages;
  if (value == null) return null;
  if (_stages is EqualUnmodifiableListView) return _stages;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}


/// Create a copy of OcrPipelineConfig
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$OcrPipelineConfigCopyWith<_OcrPipelineConfig> get copyWith => __$OcrPipelineConfigCopyWithImpl<_OcrPipelineConfig>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$OcrPipelineConfigToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _OcrPipelineConfig&&(identical(other.qualityThresholds, qualityThresholds) || other.qualityThresholds == qualityThresholds)&&const DeepCollectionEquality().equals(other._stages, _stages));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,qualityThresholds,const DeepCollectionEquality().hash(_stages));

@override
String toString() {
  return 'OcrPipelineConfig(qualityThresholds: $qualityThresholds, stages: $stages)';
}


}

/// @nodoc
abstract mixin class _$OcrPipelineConfigCopyWith<$Res> implements $OcrPipelineConfigCopyWith<$Res> {
  factory _$OcrPipelineConfigCopyWith(_OcrPipelineConfig value, $Res Function(_OcrPipelineConfig) _then) = __$OcrPipelineConfigCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'quality_thresholds') OcrQualityThresholds? qualityThresholds, List<OcrPipelineStage>? stages
});


@override $OcrQualityThresholdsCopyWith<$Res>? get qualityThresholds;

}
/// @nodoc
class __$OcrPipelineConfigCopyWithImpl<$Res>
    implements _$OcrPipelineConfigCopyWith<$Res> {
  __$OcrPipelineConfigCopyWithImpl(this._self, this._then);

  final _OcrPipelineConfig _self;
  final $Res Function(_OcrPipelineConfig) _then;

/// Create a copy of OcrPipelineConfig
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? qualityThresholds = freezed,Object? stages = freezed,}) {
  return _then(_OcrPipelineConfig(
qualityThresholds: freezed == qualityThresholds ? _self.qualityThresholds : qualityThresholds // ignore: cast_nullable_to_non_nullable
as OcrQualityThresholds?,stages: freezed == stages ? _self._stages : stages // ignore: cast_nullable_to_non_nullable
as List<OcrPipelineStage>?,
  ));
}

/// Create a copy of OcrPipelineConfig
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
