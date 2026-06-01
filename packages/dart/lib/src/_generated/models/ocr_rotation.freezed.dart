// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ocr_rotation.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$OcrRotation {

/// Rotation angle in degrees (0, 90, 180, 270 for PaddleOCR).
@JsonKey(name: 'angle_degrees') double get angleDegrees;/// Confidence score for the rotation detection.
 double? get confidence;
/// Create a copy of OcrRotation
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OcrRotationCopyWith<OcrRotation> get copyWith => _$OcrRotationCopyWithImpl<OcrRotation>(this as OcrRotation, _$identity);

  /// Serializes this OcrRotation to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OcrRotation&&(identical(other.angleDegrees, angleDegrees) || other.angleDegrees == angleDegrees)&&(identical(other.confidence, confidence) || other.confidence == confidence));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,angleDegrees,confidence);

@override
String toString() {
  return 'OcrRotation(angleDegrees: $angleDegrees, confidence: $confidence)';
}


}

/// @nodoc
abstract mixin class $OcrRotationCopyWith<$Res>  {
  factory $OcrRotationCopyWith(OcrRotation value, $Res Function(OcrRotation) _then) = _$OcrRotationCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'angle_degrees') double angleDegrees, double? confidence
});




}
/// @nodoc
class _$OcrRotationCopyWithImpl<$Res>
    implements $OcrRotationCopyWith<$Res> {
  _$OcrRotationCopyWithImpl(this._self, this._then);

  final OcrRotation _self;
  final $Res Function(OcrRotation) _then;

/// Create a copy of OcrRotation
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? angleDegrees = null,Object? confidence = freezed,}) {
  return _then(_self.copyWith(
angleDegrees: null == angleDegrees ? _self.angleDegrees : angleDegrees // ignore: cast_nullable_to_non_nullable
as double,confidence: freezed == confidence ? _self.confidence : confidence // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}

}


/// Adds pattern-matching-related methods to [OcrRotation].
extension OcrRotationPatterns on OcrRotation {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _OcrRotation value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _OcrRotation() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _OcrRotation value)  $default,){
final _that = this;
switch (_that) {
case _OcrRotation():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _OcrRotation value)?  $default,){
final _that = this;
switch (_that) {
case _OcrRotation() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'angle_degrees')  double angleDegrees,  double? confidence)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _OcrRotation() when $default != null:
return $default(_that.angleDegrees,_that.confidence);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'angle_degrees')  double angleDegrees,  double? confidence)  $default,) {final _that = this;
switch (_that) {
case _OcrRotation():
return $default(_that.angleDegrees,_that.confidence);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'angle_degrees')  double angleDegrees,  double? confidence)?  $default,) {final _that = this;
switch (_that) {
case _OcrRotation() when $default != null:
return $default(_that.angleDegrees,_that.confidence);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _OcrRotation implements OcrRotation {
  const _OcrRotation({@JsonKey(name: 'angle_degrees') required this.angleDegrees, this.confidence});
  factory _OcrRotation.fromJson(Map<String, dynamic> json) => _$OcrRotationFromJson(json);

/// Rotation angle in degrees (0, 90, 180, 270 for PaddleOCR).
@override@JsonKey(name: 'angle_degrees') final  double angleDegrees;
/// Confidence score for the rotation detection.
@override final  double? confidence;

/// Create a copy of OcrRotation
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$OcrRotationCopyWith<_OcrRotation> get copyWith => __$OcrRotationCopyWithImpl<_OcrRotation>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$OcrRotationToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _OcrRotation&&(identical(other.angleDegrees, angleDegrees) || other.angleDegrees == angleDegrees)&&(identical(other.confidence, confidence) || other.confidence == confidence));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,angleDegrees,confidence);

@override
String toString() {
  return 'OcrRotation(angleDegrees: $angleDegrees, confidence: $confidence)';
}


}

/// @nodoc
abstract mixin class _$OcrRotationCopyWith<$Res> implements $OcrRotationCopyWith<$Res> {
  factory _$OcrRotationCopyWith(_OcrRotation value, $Res Function(_OcrRotation) _then) = __$OcrRotationCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'angle_degrees') double angleDegrees, double? confidence
});




}
/// @nodoc
class __$OcrRotationCopyWithImpl<$Res>
    implements _$OcrRotationCopyWith<$Res> {
  __$OcrRotationCopyWithImpl(this._self, this._then);

  final _OcrRotation _self;
  final $Res Function(_OcrRotation) _then;

/// Create a copy of OcrRotation
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? angleDegrees = null,Object? confidence = freezed,}) {
  return _then(_OcrRotation(
angleDegrees: null == angleDegrees ? _self.angleDegrees : angleDegrees // ignore: cast_nullable_to_non_nullable
as double,confidence: freezed == confidence ? _self.confidence : confidence // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}


}

// dart format on
