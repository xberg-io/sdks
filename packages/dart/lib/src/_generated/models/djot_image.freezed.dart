// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'djot_image.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$DjotImage {

/// Alternative text
 String get alt;/// Image source URL or path
 String get src;/// Element attributes
 Attributes? get attributes;/// Optional title
 String? get title;
/// Create a copy of DjotImage
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DjotImageCopyWith<DjotImage> get copyWith => _$DjotImageCopyWithImpl<DjotImage>(this as DjotImage, _$identity);

  /// Serializes this DjotImage to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DjotImage&&(identical(other.alt, alt) || other.alt == alt)&&(identical(other.src, src) || other.src == src)&&(identical(other.attributes, attributes) || other.attributes == attributes)&&(identical(other.title, title) || other.title == title));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,alt,src,attributes,title);

@override
String toString() {
  return 'DjotImage(alt: $alt, src: $src, attributes: $attributes, title: $title)';
}


}

/// @nodoc
abstract mixin class $DjotImageCopyWith<$Res>  {
  factory $DjotImageCopyWith(DjotImage value, $Res Function(DjotImage) _then) = _$DjotImageCopyWithImpl;
@useResult
$Res call({
 String alt, String src, Attributes? attributes, String? title
});


$AttributesCopyWith<$Res>? get attributes;

}
/// @nodoc
class _$DjotImageCopyWithImpl<$Res>
    implements $DjotImageCopyWith<$Res> {
  _$DjotImageCopyWithImpl(this._self, this._then);

  final DjotImage _self;
  final $Res Function(DjotImage) _then;

/// Create a copy of DjotImage
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? alt = null,Object? src = null,Object? attributes = freezed,Object? title = freezed,}) {
  return _then(_self.copyWith(
alt: null == alt ? _self.alt : alt // ignore: cast_nullable_to_non_nullable
as String,src: null == src ? _self.src : src // ignore: cast_nullable_to_non_nullable
as String,attributes: freezed == attributes ? _self.attributes : attributes // ignore: cast_nullable_to_non_nullable
as Attributes?,title: freezed == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of DjotImage
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AttributesCopyWith<$Res>? get attributes {
    if (_self.attributes == null) {
    return null;
  }

  return $AttributesCopyWith<$Res>(_self.attributes!, (value) {
    return _then(_self.copyWith(attributes: value));
  });
}
}


/// Adds pattern-matching-related methods to [DjotImage].
extension DjotImagePatterns on DjotImage {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DjotImage value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DjotImage() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DjotImage value)  $default,){
final _that = this;
switch (_that) {
case _DjotImage():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DjotImage value)?  $default,){
final _that = this;
switch (_that) {
case _DjotImage() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String alt,  String src,  Attributes? attributes,  String? title)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DjotImage() when $default != null:
return $default(_that.alt,_that.src,_that.attributes,_that.title);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String alt,  String src,  Attributes? attributes,  String? title)  $default,) {final _that = this;
switch (_that) {
case _DjotImage():
return $default(_that.alt,_that.src,_that.attributes,_that.title);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String alt,  String src,  Attributes? attributes,  String? title)?  $default,) {final _that = this;
switch (_that) {
case _DjotImage() when $default != null:
return $default(_that.alt,_that.src,_that.attributes,_that.title);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _DjotImage implements DjotImage {
  const _DjotImage({required this.alt, required this.src, this.attributes, this.title});
  factory _DjotImage.fromJson(Map<String, dynamic> json) => _$DjotImageFromJson(json);

/// Alternative text
@override final  String alt;
/// Image source URL or path
@override final  String src;
/// Element attributes
@override final  Attributes? attributes;
/// Optional title
@override final  String? title;

/// Create a copy of DjotImage
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DjotImageCopyWith<_DjotImage> get copyWith => __$DjotImageCopyWithImpl<_DjotImage>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DjotImageToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DjotImage&&(identical(other.alt, alt) || other.alt == alt)&&(identical(other.src, src) || other.src == src)&&(identical(other.attributes, attributes) || other.attributes == attributes)&&(identical(other.title, title) || other.title == title));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,alt,src,attributes,title);

@override
String toString() {
  return 'DjotImage(alt: $alt, src: $src, attributes: $attributes, title: $title)';
}


}

/// @nodoc
abstract mixin class _$DjotImageCopyWith<$Res> implements $DjotImageCopyWith<$Res> {
  factory _$DjotImageCopyWith(_DjotImage value, $Res Function(_DjotImage) _then) = __$DjotImageCopyWithImpl;
@override @useResult
$Res call({
 String alt, String src, Attributes? attributes, String? title
});


@override $AttributesCopyWith<$Res>? get attributes;

}
/// @nodoc
class __$DjotImageCopyWithImpl<$Res>
    implements _$DjotImageCopyWith<$Res> {
  __$DjotImageCopyWithImpl(this._self, this._then);

  final _DjotImage _self;
  final $Res Function(_DjotImage) _then;

/// Create a copy of DjotImage
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? alt = null,Object? src = null,Object? attributes = freezed,Object? title = freezed,}) {
  return _then(_DjotImage(
alt: null == alt ? _self.alt : alt // ignore: cast_nullable_to_non_nullable
as String,src: null == src ? _self.src : src // ignore: cast_nullable_to_non_nullable
as String,attributes: freezed == attributes ? _self.attributes : attributes // ignore: cast_nullable_to_non_nullable
as Attributes?,title: freezed == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of DjotImage
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AttributesCopyWith<$Res>? get attributes {
    if (_self.attributes == null) {
    return null;
  }

  return $AttributesCopyWith<$Res>(_self.attributes!, (value) {
    return _then(_self.copyWith(attributes: value));
  });
}
}

// dart format on
