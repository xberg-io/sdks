// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'image_metadata_type.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ImageMetadataType {

/// Additional attributes as key-value pairs
 List<List<String>> get attributes;/// Image type classification
@JsonKey(name: 'image_type') ImageType get imageType;/// Image source (URL, data URI, or SVG content)
 String get src;/// Alternative text from alt attribute
 String? get alt;/// Image dimensions as (width, height) if available
 List<int>? get dimensions;/// Title attribute
 String? get title;
/// Create a copy of ImageMetadataType
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ImageMetadataTypeCopyWith<ImageMetadataType> get copyWith => _$ImageMetadataTypeCopyWithImpl<ImageMetadataType>(this as ImageMetadataType, _$identity);

  /// Serializes this ImageMetadataType to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ImageMetadataType&&const DeepCollectionEquality().equals(other.attributes, attributes)&&(identical(other.imageType, imageType) || other.imageType == imageType)&&(identical(other.src, src) || other.src == src)&&(identical(other.alt, alt) || other.alt == alt)&&const DeepCollectionEquality().equals(other.dimensions, dimensions)&&(identical(other.title, title) || other.title == title));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(attributes),imageType,src,alt,const DeepCollectionEquality().hash(dimensions),title);

@override
String toString() {
  return 'ImageMetadataType(attributes: $attributes, imageType: $imageType, src: $src, alt: $alt, dimensions: $dimensions, title: $title)';
}


}

/// @nodoc
abstract mixin class $ImageMetadataTypeCopyWith<$Res>  {
  factory $ImageMetadataTypeCopyWith(ImageMetadataType value, $Res Function(ImageMetadataType) _then) = _$ImageMetadataTypeCopyWithImpl;
@useResult
$Res call({
 List<List<String>> attributes,@JsonKey(name: 'image_type') ImageType imageType, String src, String? alt, List<int>? dimensions, String? title
});




}
/// @nodoc
class _$ImageMetadataTypeCopyWithImpl<$Res>
    implements $ImageMetadataTypeCopyWith<$Res> {
  _$ImageMetadataTypeCopyWithImpl(this._self, this._then);

  final ImageMetadataType _self;
  final $Res Function(ImageMetadataType) _then;

/// Create a copy of ImageMetadataType
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? attributes = null,Object? imageType = null,Object? src = null,Object? alt = freezed,Object? dimensions = freezed,Object? title = freezed,}) {
  return _then(_self.copyWith(
attributes: null == attributes ? _self.attributes : attributes // ignore: cast_nullable_to_non_nullable
as List<List<String>>,imageType: null == imageType ? _self.imageType : imageType // ignore: cast_nullable_to_non_nullable
as ImageType,src: null == src ? _self.src : src // ignore: cast_nullable_to_non_nullable
as String,alt: freezed == alt ? _self.alt : alt // ignore: cast_nullable_to_non_nullable
as String?,dimensions: freezed == dimensions ? _self.dimensions : dimensions // ignore: cast_nullable_to_non_nullable
as List<int>?,title: freezed == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [ImageMetadataType].
extension ImageMetadataTypePatterns on ImageMetadataType {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ImageMetadataType value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ImageMetadataType() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ImageMetadataType value)  $default,){
final _that = this;
switch (_that) {
case _ImageMetadataType():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ImageMetadataType value)?  $default,){
final _that = this;
switch (_that) {
case _ImageMetadataType() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<List<String>> attributes, @JsonKey(name: 'image_type')  ImageType imageType,  String src,  String? alt,  List<int>? dimensions,  String? title)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ImageMetadataType() when $default != null:
return $default(_that.attributes,_that.imageType,_that.src,_that.alt,_that.dimensions,_that.title);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<List<String>> attributes, @JsonKey(name: 'image_type')  ImageType imageType,  String src,  String? alt,  List<int>? dimensions,  String? title)  $default,) {final _that = this;
switch (_that) {
case _ImageMetadataType():
return $default(_that.attributes,_that.imageType,_that.src,_that.alt,_that.dimensions,_that.title);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<List<String>> attributes, @JsonKey(name: 'image_type')  ImageType imageType,  String src,  String? alt,  List<int>? dimensions,  String? title)?  $default,) {final _that = this;
switch (_that) {
case _ImageMetadataType() when $default != null:
return $default(_that.attributes,_that.imageType,_that.src,_that.alt,_that.dimensions,_that.title);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ImageMetadataType implements ImageMetadataType {
  const _ImageMetadataType({required final  List<List<String>> attributes, @JsonKey(name: 'image_type') required this.imageType, required this.src, this.alt, final  List<int>? dimensions, this.title}): _attributes = attributes,_dimensions = dimensions;
  factory _ImageMetadataType.fromJson(Map<String, dynamic> json) => _$ImageMetadataTypeFromJson(json);

/// Additional attributes as key-value pairs
 final  List<List<String>> _attributes;
/// Additional attributes as key-value pairs
@override List<List<String>> get attributes {
  if (_attributes is EqualUnmodifiableListView) return _attributes;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_attributes);
}

/// Image type classification
@override@JsonKey(name: 'image_type') final  ImageType imageType;
/// Image source (URL, data URI, or SVG content)
@override final  String src;
/// Alternative text from alt attribute
@override final  String? alt;
/// Image dimensions as (width, height) if available
 final  List<int>? _dimensions;
/// Image dimensions as (width, height) if available
@override List<int>? get dimensions {
  final value = _dimensions;
  if (value == null) return null;
  if (_dimensions is EqualUnmodifiableListView) return _dimensions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

/// Title attribute
@override final  String? title;

/// Create a copy of ImageMetadataType
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ImageMetadataTypeCopyWith<_ImageMetadataType> get copyWith => __$ImageMetadataTypeCopyWithImpl<_ImageMetadataType>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ImageMetadataTypeToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ImageMetadataType&&const DeepCollectionEquality().equals(other._attributes, _attributes)&&(identical(other.imageType, imageType) || other.imageType == imageType)&&(identical(other.src, src) || other.src == src)&&(identical(other.alt, alt) || other.alt == alt)&&const DeepCollectionEquality().equals(other._dimensions, _dimensions)&&(identical(other.title, title) || other.title == title));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_attributes),imageType,src,alt,const DeepCollectionEquality().hash(_dimensions),title);

@override
String toString() {
  return 'ImageMetadataType(attributes: $attributes, imageType: $imageType, src: $src, alt: $alt, dimensions: $dimensions, title: $title)';
}


}

/// @nodoc
abstract mixin class _$ImageMetadataTypeCopyWith<$Res> implements $ImageMetadataTypeCopyWith<$Res> {
  factory _$ImageMetadataTypeCopyWith(_ImageMetadataType value, $Res Function(_ImageMetadataType) _then) = __$ImageMetadataTypeCopyWithImpl;
@override @useResult
$Res call({
 List<List<String>> attributes,@JsonKey(name: 'image_type') ImageType imageType, String src, String? alt, List<int>? dimensions, String? title
});




}
/// @nodoc
class __$ImageMetadataTypeCopyWithImpl<$Res>
    implements _$ImageMetadataTypeCopyWith<$Res> {
  __$ImageMetadataTypeCopyWithImpl(this._self, this._then);

  final _ImageMetadataType _self;
  final $Res Function(_ImageMetadataType) _then;

/// Create a copy of ImageMetadataType
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? attributes = null,Object? imageType = null,Object? src = null,Object? alt = freezed,Object? dimensions = freezed,Object? title = freezed,}) {
  return _then(_ImageMetadataType(
attributes: null == attributes ? _self._attributes : attributes // ignore: cast_nullable_to_non_nullable
as List<List<String>>,imageType: null == imageType ? _self.imageType : imageType // ignore: cast_nullable_to_non_nullable
as ImageType,src: null == src ? _self.src : src // ignore: cast_nullable_to_non_nullable
as String,alt: freezed == alt ? _self.alt : alt // ignore: cast_nullable_to_non_nullable
as String?,dimensions: freezed == dimensions ? _self._dimensions : dimensions // ignore: cast_nullable_to_non_nullable
as List<int>?,title: freezed == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
