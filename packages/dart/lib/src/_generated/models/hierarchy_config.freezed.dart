// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'hierarchy_config.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$HierarchyConfig {

/// Enable hierarchy detection
 bool? get enabled;/// Include bounding boxes
@JsonKey(name: 'include_bbox') bool? get includeBbox;/// Number of font-size clusters for heading levels
@JsonKey(name: 'k_clusters') int? get kClusters;/// OCR coverage threshold
@JsonKey(name: 'ocr_coverage_threshold') double? get ocrCoverageThreshold;
/// Create a copy of HierarchyConfig
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HierarchyConfigCopyWith<HierarchyConfig> get copyWith => _$HierarchyConfigCopyWithImpl<HierarchyConfig>(this as HierarchyConfig, _$identity);

  /// Serializes this HierarchyConfig to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HierarchyConfig&&(identical(other.enabled, enabled) || other.enabled == enabled)&&(identical(other.includeBbox, includeBbox) || other.includeBbox == includeBbox)&&(identical(other.kClusters, kClusters) || other.kClusters == kClusters)&&(identical(other.ocrCoverageThreshold, ocrCoverageThreshold) || other.ocrCoverageThreshold == ocrCoverageThreshold));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,enabled,includeBbox,kClusters,ocrCoverageThreshold);

@override
String toString() {
  return 'HierarchyConfig(enabled: $enabled, includeBbox: $includeBbox, kClusters: $kClusters, ocrCoverageThreshold: $ocrCoverageThreshold)';
}


}

/// @nodoc
abstract mixin class $HierarchyConfigCopyWith<$Res>  {
  factory $HierarchyConfigCopyWith(HierarchyConfig value, $Res Function(HierarchyConfig) _then) = _$HierarchyConfigCopyWithImpl;
@useResult
$Res call({
 bool? enabled,@JsonKey(name: 'include_bbox') bool? includeBbox,@JsonKey(name: 'k_clusters') int? kClusters,@JsonKey(name: 'ocr_coverage_threshold') double? ocrCoverageThreshold
});




}
/// @nodoc
class _$HierarchyConfigCopyWithImpl<$Res>
    implements $HierarchyConfigCopyWith<$Res> {
  _$HierarchyConfigCopyWithImpl(this._self, this._then);

  final HierarchyConfig _self;
  final $Res Function(HierarchyConfig) _then;

/// Create a copy of HierarchyConfig
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? enabled = freezed,Object? includeBbox = freezed,Object? kClusters = freezed,Object? ocrCoverageThreshold = freezed,}) {
  return _then(_self.copyWith(
enabled: freezed == enabled ? _self.enabled : enabled // ignore: cast_nullable_to_non_nullable
as bool?,includeBbox: freezed == includeBbox ? _self.includeBbox : includeBbox // ignore: cast_nullable_to_non_nullable
as bool?,kClusters: freezed == kClusters ? _self.kClusters : kClusters // ignore: cast_nullable_to_non_nullable
as int?,ocrCoverageThreshold: freezed == ocrCoverageThreshold ? _self.ocrCoverageThreshold : ocrCoverageThreshold // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}

}


/// Adds pattern-matching-related methods to [HierarchyConfig].
extension HierarchyConfigPatterns on HierarchyConfig {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _HierarchyConfig value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _HierarchyConfig() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _HierarchyConfig value)  $default,){
final _that = this;
switch (_that) {
case _HierarchyConfig():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _HierarchyConfig value)?  $default,){
final _that = this;
switch (_that) {
case _HierarchyConfig() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool? enabled, @JsonKey(name: 'include_bbox')  bool? includeBbox, @JsonKey(name: 'k_clusters')  int? kClusters, @JsonKey(name: 'ocr_coverage_threshold')  double? ocrCoverageThreshold)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _HierarchyConfig() when $default != null:
return $default(_that.enabled,_that.includeBbox,_that.kClusters,_that.ocrCoverageThreshold);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool? enabled, @JsonKey(name: 'include_bbox')  bool? includeBbox, @JsonKey(name: 'k_clusters')  int? kClusters, @JsonKey(name: 'ocr_coverage_threshold')  double? ocrCoverageThreshold)  $default,) {final _that = this;
switch (_that) {
case _HierarchyConfig():
return $default(_that.enabled,_that.includeBbox,_that.kClusters,_that.ocrCoverageThreshold);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool? enabled, @JsonKey(name: 'include_bbox')  bool? includeBbox, @JsonKey(name: 'k_clusters')  int? kClusters, @JsonKey(name: 'ocr_coverage_threshold')  double? ocrCoverageThreshold)?  $default,) {final _that = this;
switch (_that) {
case _HierarchyConfig() when $default != null:
return $default(_that.enabled,_that.includeBbox,_that.kClusters,_that.ocrCoverageThreshold);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _HierarchyConfig implements HierarchyConfig {
  const _HierarchyConfig({this.enabled, @JsonKey(name: 'include_bbox') this.includeBbox, @JsonKey(name: 'k_clusters') this.kClusters, @JsonKey(name: 'ocr_coverage_threshold') this.ocrCoverageThreshold});
  factory _HierarchyConfig.fromJson(Map<String, dynamic> json) => _$HierarchyConfigFromJson(json);

/// Enable hierarchy detection
@override final  bool? enabled;
/// Include bounding boxes
@override@JsonKey(name: 'include_bbox') final  bool? includeBbox;
/// Number of font-size clusters for heading levels
@override@JsonKey(name: 'k_clusters') final  int? kClusters;
/// OCR coverage threshold
@override@JsonKey(name: 'ocr_coverage_threshold') final  double? ocrCoverageThreshold;

/// Create a copy of HierarchyConfig
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$HierarchyConfigCopyWith<_HierarchyConfig> get copyWith => __$HierarchyConfigCopyWithImpl<_HierarchyConfig>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$HierarchyConfigToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _HierarchyConfig&&(identical(other.enabled, enabled) || other.enabled == enabled)&&(identical(other.includeBbox, includeBbox) || other.includeBbox == includeBbox)&&(identical(other.kClusters, kClusters) || other.kClusters == kClusters)&&(identical(other.ocrCoverageThreshold, ocrCoverageThreshold) || other.ocrCoverageThreshold == ocrCoverageThreshold));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,enabled,includeBbox,kClusters,ocrCoverageThreshold);

@override
String toString() {
  return 'HierarchyConfig(enabled: $enabled, includeBbox: $includeBbox, kClusters: $kClusters, ocrCoverageThreshold: $ocrCoverageThreshold)';
}


}

/// @nodoc
abstract mixin class _$HierarchyConfigCopyWith<$Res> implements $HierarchyConfigCopyWith<$Res> {
  factory _$HierarchyConfigCopyWith(_HierarchyConfig value, $Res Function(_HierarchyConfig) _then) = __$HierarchyConfigCopyWithImpl;
@override @useResult
$Res call({
 bool? enabled,@JsonKey(name: 'include_bbox') bool? includeBbox,@JsonKey(name: 'k_clusters') int? kClusters,@JsonKey(name: 'ocr_coverage_threshold') double? ocrCoverageThreshold
});




}
/// @nodoc
class __$HierarchyConfigCopyWithImpl<$Res>
    implements _$HierarchyConfigCopyWith<$Res> {
  __$HierarchyConfigCopyWithImpl(this._self, this._then);

  final _HierarchyConfig _self;
  final $Res Function(_HierarchyConfig) _then;

/// Create a copy of HierarchyConfig
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? enabled = freezed,Object? includeBbox = freezed,Object? kClusters = freezed,Object? ocrCoverageThreshold = freezed,}) {
  return _then(_HierarchyConfig(
enabled: freezed == enabled ? _self.enabled : enabled // ignore: cast_nullable_to_non_nullable
as bool?,includeBbox: freezed == includeBbox ? _self.includeBbox : includeBbox // ignore: cast_nullable_to_non_nullable
as bool?,kClusters: freezed == kClusters ? _self.kClusters : kClusters // ignore: cast_nullable_to_non_nullable
as int?,ocrCoverageThreshold: freezed == ocrCoverageThreshold ? _self.ocrCoverageThreshold : ocrCoverageThreshold // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}


}

// dart format on
