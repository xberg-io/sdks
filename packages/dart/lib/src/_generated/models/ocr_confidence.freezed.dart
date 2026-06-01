// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ocr_confidence.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$OcrConfidence {

/// Recognition confidence: how confident about the text content.
///
/// Range: 0.0 to 1.0.
 double get recognition;/// Detection confidence: how confident the OCR engine is that text exists here.
///
/// PaddleOCR provides this as `box_score`, Tesseract doesn't have a direct equivalent.
/// Range: 0.0 to 1.0 (or None if not available).
 double? get detection;
/// Create a copy of OcrConfidence
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OcrConfidenceCopyWith<OcrConfidence> get copyWith => _$OcrConfidenceCopyWithImpl<OcrConfidence>(this as OcrConfidence, _$identity);

  /// Serializes this OcrConfidence to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OcrConfidence&&(identical(other.recognition, recognition) || other.recognition == recognition)&&(identical(other.detection, detection) || other.detection == detection));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,recognition,detection);

@override
String toString() {
  return 'OcrConfidence(recognition: $recognition, detection: $detection)';
}


}

/// @nodoc
abstract mixin class $OcrConfidenceCopyWith<$Res>  {
  factory $OcrConfidenceCopyWith(OcrConfidence value, $Res Function(OcrConfidence) _then) = _$OcrConfidenceCopyWithImpl;
@useResult
$Res call({
 double recognition, double? detection
});




}
/// @nodoc
class _$OcrConfidenceCopyWithImpl<$Res>
    implements $OcrConfidenceCopyWith<$Res> {
  _$OcrConfidenceCopyWithImpl(this._self, this._then);

  final OcrConfidence _self;
  final $Res Function(OcrConfidence) _then;

/// Create a copy of OcrConfidence
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? recognition = null,Object? detection = freezed,}) {
  return _then(_self.copyWith(
recognition: null == recognition ? _self.recognition : recognition // ignore: cast_nullable_to_non_nullable
as double,detection: freezed == detection ? _self.detection : detection // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}

}


/// Adds pattern-matching-related methods to [OcrConfidence].
extension OcrConfidencePatterns on OcrConfidence {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _OcrConfidence value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _OcrConfidence() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _OcrConfidence value)  $default,){
final _that = this;
switch (_that) {
case _OcrConfidence():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _OcrConfidence value)?  $default,){
final _that = this;
switch (_that) {
case _OcrConfidence() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( double recognition,  double? detection)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _OcrConfidence() when $default != null:
return $default(_that.recognition,_that.detection);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( double recognition,  double? detection)  $default,) {final _that = this;
switch (_that) {
case _OcrConfidence():
return $default(_that.recognition,_that.detection);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( double recognition,  double? detection)?  $default,) {final _that = this;
switch (_that) {
case _OcrConfidence() when $default != null:
return $default(_that.recognition,_that.detection);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _OcrConfidence implements OcrConfidence {
  const _OcrConfidence({required this.recognition, this.detection});
  factory _OcrConfidence.fromJson(Map<String, dynamic> json) => _$OcrConfidenceFromJson(json);

/// Recognition confidence: how confident about the text content.
///
/// Range: 0.0 to 1.0.
@override final  double recognition;
/// Detection confidence: how confident the OCR engine is that text exists here.
///
/// PaddleOCR provides this as `box_score`, Tesseract doesn't have a direct equivalent.
/// Range: 0.0 to 1.0 (or None if not available).
@override final  double? detection;

/// Create a copy of OcrConfidence
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$OcrConfidenceCopyWith<_OcrConfidence> get copyWith => __$OcrConfidenceCopyWithImpl<_OcrConfidence>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$OcrConfidenceToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _OcrConfidence&&(identical(other.recognition, recognition) || other.recognition == recognition)&&(identical(other.detection, detection) || other.detection == detection));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,recognition,detection);

@override
String toString() {
  return 'OcrConfidence(recognition: $recognition, detection: $detection)';
}


}

/// @nodoc
abstract mixin class _$OcrConfidenceCopyWith<$Res> implements $OcrConfidenceCopyWith<$Res> {
  factory _$OcrConfidenceCopyWith(_OcrConfidence value, $Res Function(_OcrConfidence) _then) = __$OcrConfidenceCopyWithImpl;
@override @useResult
$Res call({
 double recognition, double? detection
});




}
/// @nodoc
class __$OcrConfidenceCopyWithImpl<$Res>
    implements _$OcrConfidenceCopyWith<$Res> {
  __$OcrConfidenceCopyWithImpl(this._self, this._then);

  final _OcrConfidence _self;
  final $Res Function(_OcrConfidence) _then;

/// Create a copy of OcrConfidence
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? recognition = null,Object? detection = freezed,}) {
  return _then(_OcrConfidence(
recognition: null == recognition ? _self.recognition : recognition // ignore: cast_nullable_to_non_nullable
as double,detection: freezed == detection ? _self.detection : detection // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}


}

// dart format on
