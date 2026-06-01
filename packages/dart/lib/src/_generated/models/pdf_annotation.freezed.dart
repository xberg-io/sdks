// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'pdf_annotation.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PdfAnnotation {

/// The type of annotation.
@JsonKey(name: 'annotation_type') PdfAnnotationType get annotationType;/// Page number where the annotation appears (1-indexed).
@JsonKey(name: 'page_number') int get pageNumber;/// Bounding box of the annotation on the page.
@JsonKey(name: 'bounding_box') BoundingBox? get boundingBox;/// Text content of the annotation (e.g., comment text, link URL).
 String? get content;
/// Create a copy of PdfAnnotation
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PdfAnnotationCopyWith<PdfAnnotation> get copyWith => _$PdfAnnotationCopyWithImpl<PdfAnnotation>(this as PdfAnnotation, _$identity);

  /// Serializes this PdfAnnotation to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PdfAnnotation&&(identical(other.annotationType, annotationType) || other.annotationType == annotationType)&&(identical(other.pageNumber, pageNumber) || other.pageNumber == pageNumber)&&(identical(other.boundingBox, boundingBox) || other.boundingBox == boundingBox)&&(identical(other.content, content) || other.content == content));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,annotationType,pageNumber,boundingBox,content);

@override
String toString() {
  return 'PdfAnnotation(annotationType: $annotationType, pageNumber: $pageNumber, boundingBox: $boundingBox, content: $content)';
}


}

/// @nodoc
abstract mixin class $PdfAnnotationCopyWith<$Res>  {
  factory $PdfAnnotationCopyWith(PdfAnnotation value, $Res Function(PdfAnnotation) _then) = _$PdfAnnotationCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'annotation_type') PdfAnnotationType annotationType,@JsonKey(name: 'page_number') int pageNumber,@JsonKey(name: 'bounding_box') BoundingBox? boundingBox, String? content
});


$BoundingBoxCopyWith<$Res>? get boundingBox;

}
/// @nodoc
class _$PdfAnnotationCopyWithImpl<$Res>
    implements $PdfAnnotationCopyWith<$Res> {
  _$PdfAnnotationCopyWithImpl(this._self, this._then);

  final PdfAnnotation _self;
  final $Res Function(PdfAnnotation) _then;

/// Create a copy of PdfAnnotation
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? annotationType = null,Object? pageNumber = null,Object? boundingBox = freezed,Object? content = freezed,}) {
  return _then(_self.copyWith(
annotationType: null == annotationType ? _self.annotationType : annotationType // ignore: cast_nullable_to_non_nullable
as PdfAnnotationType,pageNumber: null == pageNumber ? _self.pageNumber : pageNumber // ignore: cast_nullable_to_non_nullable
as int,boundingBox: freezed == boundingBox ? _self.boundingBox : boundingBox // ignore: cast_nullable_to_non_nullable
as BoundingBox?,content: freezed == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of PdfAnnotation
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BoundingBoxCopyWith<$Res>? get boundingBox {
    if (_self.boundingBox == null) {
    return null;
  }

  return $BoundingBoxCopyWith<$Res>(_self.boundingBox!, (value) {
    return _then(_self.copyWith(boundingBox: value));
  });
}
}


/// Adds pattern-matching-related methods to [PdfAnnotation].
extension PdfAnnotationPatterns on PdfAnnotation {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PdfAnnotation value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PdfAnnotation() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PdfAnnotation value)  $default,){
final _that = this;
switch (_that) {
case _PdfAnnotation():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PdfAnnotation value)?  $default,){
final _that = this;
switch (_that) {
case _PdfAnnotation() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'annotation_type')  PdfAnnotationType annotationType, @JsonKey(name: 'page_number')  int pageNumber, @JsonKey(name: 'bounding_box')  BoundingBox? boundingBox,  String? content)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PdfAnnotation() when $default != null:
return $default(_that.annotationType,_that.pageNumber,_that.boundingBox,_that.content);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'annotation_type')  PdfAnnotationType annotationType, @JsonKey(name: 'page_number')  int pageNumber, @JsonKey(name: 'bounding_box')  BoundingBox? boundingBox,  String? content)  $default,) {final _that = this;
switch (_that) {
case _PdfAnnotation():
return $default(_that.annotationType,_that.pageNumber,_that.boundingBox,_that.content);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'annotation_type')  PdfAnnotationType annotationType, @JsonKey(name: 'page_number')  int pageNumber, @JsonKey(name: 'bounding_box')  BoundingBox? boundingBox,  String? content)?  $default,) {final _that = this;
switch (_that) {
case _PdfAnnotation() when $default != null:
return $default(_that.annotationType,_that.pageNumber,_that.boundingBox,_that.content);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PdfAnnotation implements PdfAnnotation {
  const _PdfAnnotation({@JsonKey(name: 'annotation_type') required this.annotationType, @JsonKey(name: 'page_number') required this.pageNumber, @JsonKey(name: 'bounding_box') this.boundingBox, this.content});
  factory _PdfAnnotation.fromJson(Map<String, dynamic> json) => _$PdfAnnotationFromJson(json);

/// The type of annotation.
@override@JsonKey(name: 'annotation_type') final  PdfAnnotationType annotationType;
/// Page number where the annotation appears (1-indexed).
@override@JsonKey(name: 'page_number') final  int pageNumber;
/// Bounding box of the annotation on the page.
@override@JsonKey(name: 'bounding_box') final  BoundingBox? boundingBox;
/// Text content of the annotation (e.g., comment text, link URL).
@override final  String? content;

/// Create a copy of PdfAnnotation
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PdfAnnotationCopyWith<_PdfAnnotation> get copyWith => __$PdfAnnotationCopyWithImpl<_PdfAnnotation>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PdfAnnotationToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PdfAnnotation&&(identical(other.annotationType, annotationType) || other.annotationType == annotationType)&&(identical(other.pageNumber, pageNumber) || other.pageNumber == pageNumber)&&(identical(other.boundingBox, boundingBox) || other.boundingBox == boundingBox)&&(identical(other.content, content) || other.content == content));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,annotationType,pageNumber,boundingBox,content);

@override
String toString() {
  return 'PdfAnnotation(annotationType: $annotationType, pageNumber: $pageNumber, boundingBox: $boundingBox, content: $content)';
}


}

/// @nodoc
abstract mixin class _$PdfAnnotationCopyWith<$Res> implements $PdfAnnotationCopyWith<$Res> {
  factory _$PdfAnnotationCopyWith(_PdfAnnotation value, $Res Function(_PdfAnnotation) _then) = __$PdfAnnotationCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'annotation_type') PdfAnnotationType annotationType,@JsonKey(name: 'page_number') int pageNumber,@JsonKey(name: 'bounding_box') BoundingBox? boundingBox, String? content
});


@override $BoundingBoxCopyWith<$Res>? get boundingBox;

}
/// @nodoc
class __$PdfAnnotationCopyWithImpl<$Res>
    implements _$PdfAnnotationCopyWith<$Res> {
  __$PdfAnnotationCopyWithImpl(this._self, this._then);

  final _PdfAnnotation _self;
  final $Res Function(_PdfAnnotation) _then;

/// Create a copy of PdfAnnotation
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? annotationType = null,Object? pageNumber = null,Object? boundingBox = freezed,Object? content = freezed,}) {
  return _then(_PdfAnnotation(
annotationType: null == annotationType ? _self.annotationType : annotationType // ignore: cast_nullable_to_non_nullable
as PdfAnnotationType,pageNumber: null == pageNumber ? _self.pageNumber : pageNumber // ignore: cast_nullable_to_non_nullable
as int,boundingBox: freezed == boundingBox ? _self.boundingBox : boundingBox // ignore: cast_nullable_to_non_nullable
as BoundingBox?,content: freezed == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of PdfAnnotation
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BoundingBoxCopyWith<$Res>? get boundingBox {
    if (_self.boundingBox == null) {
    return null;
  }

  return $BoundingBoxCopyWith<$Res>(_self.boundingBox!, (value) {
    return _then(_self.copyWith(boundingBox: value));
  });
}
}

// dart format on
