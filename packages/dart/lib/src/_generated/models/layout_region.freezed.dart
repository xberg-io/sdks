// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'layout_region.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$LayoutRegion {

/// Fraction of the page area covered by this region (0.0 to 1.0).
@JsonKey(name: 'area_fraction') double get areaFraction;/// Bounding box in document coordinate space.
@JsonKey(name: 'bounding_box') BoundingBox get boundingBox;/// Layout class name (e.g. "picture", "table", "text", "section_header").
@JsonKey(name: 'class_name') String get className;/// Confidence score from the layout detection model (0.0 to 1.0).
 double get confidence;
/// Create a copy of LayoutRegion
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LayoutRegionCopyWith<LayoutRegion> get copyWith => _$LayoutRegionCopyWithImpl<LayoutRegion>(this as LayoutRegion, _$identity);

  /// Serializes this LayoutRegion to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LayoutRegion&&(identical(other.areaFraction, areaFraction) || other.areaFraction == areaFraction)&&(identical(other.boundingBox, boundingBox) || other.boundingBox == boundingBox)&&(identical(other.className, className) || other.className == className)&&(identical(other.confidence, confidence) || other.confidence == confidence));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,areaFraction,boundingBox,className,confidence);

@override
String toString() {
  return 'LayoutRegion(areaFraction: $areaFraction, boundingBox: $boundingBox, className: $className, confidence: $confidence)';
}


}

/// @nodoc
abstract mixin class $LayoutRegionCopyWith<$Res>  {
  factory $LayoutRegionCopyWith(LayoutRegion value, $Res Function(LayoutRegion) _then) = _$LayoutRegionCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'area_fraction') double areaFraction,@JsonKey(name: 'bounding_box') BoundingBox boundingBox,@JsonKey(name: 'class_name') String className, double confidence
});


$BoundingBoxCopyWith<$Res> get boundingBox;

}
/// @nodoc
class _$LayoutRegionCopyWithImpl<$Res>
    implements $LayoutRegionCopyWith<$Res> {
  _$LayoutRegionCopyWithImpl(this._self, this._then);

  final LayoutRegion _self;
  final $Res Function(LayoutRegion) _then;

/// Create a copy of LayoutRegion
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? areaFraction = null,Object? boundingBox = null,Object? className = null,Object? confidence = null,}) {
  return _then(_self.copyWith(
areaFraction: null == areaFraction ? _self.areaFraction : areaFraction // ignore: cast_nullable_to_non_nullable
as double,boundingBox: null == boundingBox ? _self.boundingBox : boundingBox // ignore: cast_nullable_to_non_nullable
as BoundingBox,className: null == className ? _self.className : className // ignore: cast_nullable_to_non_nullable
as String,confidence: null == confidence ? _self.confidence : confidence // ignore: cast_nullable_to_non_nullable
as double,
  ));
}
/// Create a copy of LayoutRegion
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BoundingBoxCopyWith<$Res> get boundingBox {
  
  return $BoundingBoxCopyWith<$Res>(_self.boundingBox, (value) {
    return _then(_self.copyWith(boundingBox: value));
  });
}
}


/// Adds pattern-matching-related methods to [LayoutRegion].
extension LayoutRegionPatterns on LayoutRegion {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LayoutRegion value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LayoutRegion() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LayoutRegion value)  $default,){
final _that = this;
switch (_that) {
case _LayoutRegion():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LayoutRegion value)?  $default,){
final _that = this;
switch (_that) {
case _LayoutRegion() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'area_fraction')  double areaFraction, @JsonKey(name: 'bounding_box')  BoundingBox boundingBox, @JsonKey(name: 'class_name')  String className,  double confidence)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LayoutRegion() when $default != null:
return $default(_that.areaFraction,_that.boundingBox,_that.className,_that.confidence);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'area_fraction')  double areaFraction, @JsonKey(name: 'bounding_box')  BoundingBox boundingBox, @JsonKey(name: 'class_name')  String className,  double confidence)  $default,) {final _that = this;
switch (_that) {
case _LayoutRegion():
return $default(_that.areaFraction,_that.boundingBox,_that.className,_that.confidence);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'area_fraction')  double areaFraction, @JsonKey(name: 'bounding_box')  BoundingBox boundingBox, @JsonKey(name: 'class_name')  String className,  double confidence)?  $default,) {final _that = this;
switch (_that) {
case _LayoutRegion() when $default != null:
return $default(_that.areaFraction,_that.boundingBox,_that.className,_that.confidence);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _LayoutRegion implements LayoutRegion {
  const _LayoutRegion({@JsonKey(name: 'area_fraction') required this.areaFraction, @JsonKey(name: 'bounding_box') required this.boundingBox, @JsonKey(name: 'class_name') required this.className, required this.confidence});
  factory _LayoutRegion.fromJson(Map<String, dynamic> json) => _$LayoutRegionFromJson(json);

/// Fraction of the page area covered by this region (0.0 to 1.0).
@override@JsonKey(name: 'area_fraction') final  double areaFraction;
/// Bounding box in document coordinate space.
@override@JsonKey(name: 'bounding_box') final  BoundingBox boundingBox;
/// Layout class name (e.g. "picture", "table", "text", "section_header").
@override@JsonKey(name: 'class_name') final  String className;
/// Confidence score from the layout detection model (0.0 to 1.0).
@override final  double confidence;

/// Create a copy of LayoutRegion
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LayoutRegionCopyWith<_LayoutRegion> get copyWith => __$LayoutRegionCopyWithImpl<_LayoutRegion>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$LayoutRegionToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LayoutRegion&&(identical(other.areaFraction, areaFraction) || other.areaFraction == areaFraction)&&(identical(other.boundingBox, boundingBox) || other.boundingBox == boundingBox)&&(identical(other.className, className) || other.className == className)&&(identical(other.confidence, confidence) || other.confidence == confidence));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,areaFraction,boundingBox,className,confidence);

@override
String toString() {
  return 'LayoutRegion(areaFraction: $areaFraction, boundingBox: $boundingBox, className: $className, confidence: $confidence)';
}


}

/// @nodoc
abstract mixin class _$LayoutRegionCopyWith<$Res> implements $LayoutRegionCopyWith<$Res> {
  factory _$LayoutRegionCopyWith(_LayoutRegion value, $Res Function(_LayoutRegion) _then) = __$LayoutRegionCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'area_fraction') double areaFraction,@JsonKey(name: 'bounding_box') BoundingBox boundingBox,@JsonKey(name: 'class_name') String className, double confidence
});


@override $BoundingBoxCopyWith<$Res> get boundingBox;

}
/// @nodoc
class __$LayoutRegionCopyWithImpl<$Res>
    implements _$LayoutRegionCopyWith<$Res> {
  __$LayoutRegionCopyWithImpl(this._self, this._then);

  final _LayoutRegion _self;
  final $Res Function(_LayoutRegion) _then;

/// Create a copy of LayoutRegion
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? areaFraction = null,Object? boundingBox = null,Object? className = null,Object? confidence = null,}) {
  return _then(_LayoutRegion(
areaFraction: null == areaFraction ? _self.areaFraction : areaFraction // ignore: cast_nullable_to_non_nullable
as double,boundingBox: null == boundingBox ? _self.boundingBox : boundingBox // ignore: cast_nullable_to_non_nullable
as BoundingBox,className: null == className ? _self.className : className // ignore: cast_nullable_to_non_nullable
as String,confidence: null == confidence ? _self.confidence : confidence // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

/// Create a copy of LayoutRegion
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BoundingBoxCopyWith<$Res> get boundingBox {
  
  return $BoundingBoxCopyWith<$Res>(_self.boundingBox, (value) {
    return _then(_self.copyWith(boundingBox: value));
  });
}
}

// dart format on
