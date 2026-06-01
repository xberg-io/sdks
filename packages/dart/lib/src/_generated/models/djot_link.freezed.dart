// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'djot_link.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$DjotLink {

/// Link text content
 String get text;/// Link URL
 String get url;/// Element attributes
 Attributes? get attributes;/// Optional title
 String? get title;
/// Create a copy of DjotLink
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DjotLinkCopyWith<DjotLink> get copyWith => _$DjotLinkCopyWithImpl<DjotLink>(this as DjotLink, _$identity);

  /// Serializes this DjotLink to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DjotLink&&(identical(other.text, text) || other.text == text)&&(identical(other.url, url) || other.url == url)&&(identical(other.attributes, attributes) || other.attributes == attributes)&&(identical(other.title, title) || other.title == title));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,text,url,attributes,title);

@override
String toString() {
  return 'DjotLink(text: $text, url: $url, attributes: $attributes, title: $title)';
}


}

/// @nodoc
abstract mixin class $DjotLinkCopyWith<$Res>  {
  factory $DjotLinkCopyWith(DjotLink value, $Res Function(DjotLink) _then) = _$DjotLinkCopyWithImpl;
@useResult
$Res call({
 String text, String url, Attributes? attributes, String? title
});


$AttributesCopyWith<$Res>? get attributes;

}
/// @nodoc
class _$DjotLinkCopyWithImpl<$Res>
    implements $DjotLinkCopyWith<$Res> {
  _$DjotLinkCopyWithImpl(this._self, this._then);

  final DjotLink _self;
  final $Res Function(DjotLink) _then;

/// Create a copy of DjotLink
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? text = null,Object? url = null,Object? attributes = freezed,Object? title = freezed,}) {
  return _then(_self.copyWith(
text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,attributes: freezed == attributes ? _self.attributes : attributes // ignore: cast_nullable_to_non_nullable
as Attributes?,title: freezed == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of DjotLink
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


/// Adds pattern-matching-related methods to [DjotLink].
extension DjotLinkPatterns on DjotLink {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DjotLink value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DjotLink() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DjotLink value)  $default,){
final _that = this;
switch (_that) {
case _DjotLink():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DjotLink value)?  $default,){
final _that = this;
switch (_that) {
case _DjotLink() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String text,  String url,  Attributes? attributes,  String? title)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DjotLink() when $default != null:
return $default(_that.text,_that.url,_that.attributes,_that.title);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String text,  String url,  Attributes? attributes,  String? title)  $default,) {final _that = this;
switch (_that) {
case _DjotLink():
return $default(_that.text,_that.url,_that.attributes,_that.title);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String text,  String url,  Attributes? attributes,  String? title)?  $default,) {final _that = this;
switch (_that) {
case _DjotLink() when $default != null:
return $default(_that.text,_that.url,_that.attributes,_that.title);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _DjotLink implements DjotLink {
  const _DjotLink({required this.text, required this.url, this.attributes, this.title});
  factory _DjotLink.fromJson(Map<String, dynamic> json) => _$DjotLinkFromJson(json);

/// Link text content
@override final  String text;
/// Link URL
@override final  String url;
/// Element attributes
@override final  Attributes? attributes;
/// Optional title
@override final  String? title;

/// Create a copy of DjotLink
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DjotLinkCopyWith<_DjotLink> get copyWith => __$DjotLinkCopyWithImpl<_DjotLink>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DjotLinkToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DjotLink&&(identical(other.text, text) || other.text == text)&&(identical(other.url, url) || other.url == url)&&(identical(other.attributes, attributes) || other.attributes == attributes)&&(identical(other.title, title) || other.title == title));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,text,url,attributes,title);

@override
String toString() {
  return 'DjotLink(text: $text, url: $url, attributes: $attributes, title: $title)';
}


}

/// @nodoc
abstract mixin class _$DjotLinkCopyWith<$Res> implements $DjotLinkCopyWith<$Res> {
  factory _$DjotLinkCopyWith(_DjotLink value, $Res Function(_DjotLink) _then) = __$DjotLinkCopyWithImpl;
@override @useResult
$Res call({
 String text, String url, Attributes? attributes, String? title
});


@override $AttributesCopyWith<$Res>? get attributes;

}
/// @nodoc
class __$DjotLinkCopyWithImpl<$Res>
    implements _$DjotLinkCopyWith<$Res> {
  __$DjotLinkCopyWithImpl(this._self, this._then);

  final _DjotLink _self;
  final $Res Function(_DjotLink) _then;

/// Create a copy of DjotLink
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? text = null,Object? url = null,Object? attributes = freezed,Object? title = freezed,}) {
  return _then(_DjotLink(
text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,attributes: freezed == attributes ? _self.attributes : attributes // ignore: cast_nullable_to_non_nullable
as Attributes?,title: freezed == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of DjotLink
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
