// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'image_metadata.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ImageMetadata {

/// EXIF metadata tags
 Map<String, String> get exif;/// Image format (e.g., "PNG", "JPEG", "TIFF")
 String get format;/// Image height in pixels
 int get height;/// Image width in pixels
 int get width;
/// Create a copy of ImageMetadata
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ImageMetadataCopyWith<ImageMetadata> get copyWith => _$ImageMetadataCopyWithImpl<ImageMetadata>(this as ImageMetadata, _$identity);

  /// Serializes this ImageMetadata to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ImageMetadata&&const DeepCollectionEquality().equals(other.exif, exif)&&(identical(other.format, format) || other.format == format)&&(identical(other.height, height) || other.height == height)&&(identical(other.width, width) || other.width == width));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(exif),format,height,width);

@override
String toString() {
  return 'ImageMetadata(exif: $exif, format: $format, height: $height, width: $width)';
}


}

/// @nodoc
abstract mixin class $ImageMetadataCopyWith<$Res>  {
  factory $ImageMetadataCopyWith(ImageMetadata value, $Res Function(ImageMetadata) _then) = _$ImageMetadataCopyWithImpl;
@useResult
$Res call({
 Map<String, String> exif, String format, int height, int width
});




}
/// @nodoc
class _$ImageMetadataCopyWithImpl<$Res>
    implements $ImageMetadataCopyWith<$Res> {
  _$ImageMetadataCopyWithImpl(this._self, this._then);

  final ImageMetadata _self;
  final $Res Function(ImageMetadata) _then;

/// Create a copy of ImageMetadata
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? exif = null,Object? format = null,Object? height = null,Object? width = null,}) {
  return _then(_self.copyWith(
exif: null == exif ? _self.exif : exif // ignore: cast_nullable_to_non_nullable
as Map<String, String>,format: null == format ? _self.format : format // ignore: cast_nullable_to_non_nullable
as String,height: null == height ? _self.height : height // ignore: cast_nullable_to_non_nullable
as int,width: null == width ? _self.width : width // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [ImageMetadata].
extension ImageMetadataPatterns on ImageMetadata {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ImageMetadata value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ImageMetadata() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ImageMetadata value)  $default,){
final _that = this;
switch (_that) {
case _ImageMetadata():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ImageMetadata value)?  $default,){
final _that = this;
switch (_that) {
case _ImageMetadata() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( Map<String, String> exif,  String format,  int height,  int width)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ImageMetadata() when $default != null:
return $default(_that.exif,_that.format,_that.height,_that.width);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( Map<String, String> exif,  String format,  int height,  int width)  $default,) {final _that = this;
switch (_that) {
case _ImageMetadata():
return $default(_that.exif,_that.format,_that.height,_that.width);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( Map<String, String> exif,  String format,  int height,  int width)?  $default,) {final _that = this;
switch (_that) {
case _ImageMetadata() when $default != null:
return $default(_that.exif,_that.format,_that.height,_that.width);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ImageMetadata implements ImageMetadata {
  const _ImageMetadata({required final  Map<String, String> exif, required this.format, required this.height, required this.width}): _exif = exif;
  factory _ImageMetadata.fromJson(Map<String, dynamic> json) => _$ImageMetadataFromJson(json);

/// EXIF metadata tags
 final  Map<String, String> _exif;
/// EXIF metadata tags
@override Map<String, String> get exif {
  if (_exif is EqualUnmodifiableMapView) return _exif;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_exif);
}

/// Image format (e.g., "PNG", "JPEG", "TIFF")
@override final  String format;
/// Image height in pixels
@override final  int height;
/// Image width in pixels
@override final  int width;

/// Create a copy of ImageMetadata
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ImageMetadataCopyWith<_ImageMetadata> get copyWith => __$ImageMetadataCopyWithImpl<_ImageMetadata>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ImageMetadataToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ImageMetadata&&const DeepCollectionEquality().equals(other._exif, _exif)&&(identical(other.format, format) || other.format == format)&&(identical(other.height, height) || other.height == height)&&(identical(other.width, width) || other.width == width));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_exif),format,height,width);

@override
String toString() {
  return 'ImageMetadata(exif: $exif, format: $format, height: $height, width: $width)';
}


}

/// @nodoc
abstract mixin class _$ImageMetadataCopyWith<$Res> implements $ImageMetadataCopyWith<$Res> {
  factory _$ImageMetadataCopyWith(_ImageMetadata value, $Res Function(_ImageMetadata) _then) = __$ImageMetadataCopyWithImpl;
@override @useResult
$Res call({
 Map<String, String> exif, String format, int height, int width
});




}
/// @nodoc
class __$ImageMetadataCopyWithImpl<$Res>
    implements _$ImageMetadataCopyWith<$Res> {
  __$ImageMetadataCopyWithImpl(this._self, this._then);

  final _ImageMetadata _self;
  final $Res Function(_ImageMetadata) _then;

/// Create a copy of ImageMetadata
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? exif = null,Object? format = null,Object? height = null,Object? width = null,}) {
  return _then(_ImageMetadata(
exif: null == exif ? _self._exif : exif // ignore: cast_nullable_to_non_nullable
as Map<String, String>,format: null == format ? _self.format : format // ignore: cast_nullable_to_non_nullable
as String,height: null == height ? _self.height : height // ignore: cast_nullable_to_non_nullable
as int,width: null == width ? _self.width : width // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
