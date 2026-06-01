// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'link_metadata.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$LinkMetadata {

/// Additional attributes as key-value pairs
 List<List<String>> get attributes;/// The href URL value
 String get href;/// Link type classification
@JsonKey(name: 'link_type') LinkType get linkType;/// Rel attribute values
 List<String> get rel;/// Link text content (normalized)
 String get text;/// Optional title attribute
 String? get title;
/// Create a copy of LinkMetadata
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LinkMetadataCopyWith<LinkMetadata> get copyWith => _$LinkMetadataCopyWithImpl<LinkMetadata>(this as LinkMetadata, _$identity);

  /// Serializes this LinkMetadata to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LinkMetadata&&const DeepCollectionEquality().equals(other.attributes, attributes)&&(identical(other.href, href) || other.href == href)&&(identical(other.linkType, linkType) || other.linkType == linkType)&&const DeepCollectionEquality().equals(other.rel, rel)&&(identical(other.text, text) || other.text == text)&&(identical(other.title, title) || other.title == title));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(attributes),href,linkType,const DeepCollectionEquality().hash(rel),text,title);

@override
String toString() {
  return 'LinkMetadata(attributes: $attributes, href: $href, linkType: $linkType, rel: $rel, text: $text, title: $title)';
}


}

/// @nodoc
abstract mixin class $LinkMetadataCopyWith<$Res>  {
  factory $LinkMetadataCopyWith(LinkMetadata value, $Res Function(LinkMetadata) _then) = _$LinkMetadataCopyWithImpl;
@useResult
$Res call({
 List<List<String>> attributes, String href,@JsonKey(name: 'link_type') LinkType linkType, List<String> rel, String text, String? title
});




}
/// @nodoc
class _$LinkMetadataCopyWithImpl<$Res>
    implements $LinkMetadataCopyWith<$Res> {
  _$LinkMetadataCopyWithImpl(this._self, this._then);

  final LinkMetadata _self;
  final $Res Function(LinkMetadata) _then;

/// Create a copy of LinkMetadata
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? attributes = null,Object? href = null,Object? linkType = null,Object? rel = null,Object? text = null,Object? title = freezed,}) {
  return _then(_self.copyWith(
attributes: null == attributes ? _self.attributes : attributes // ignore: cast_nullable_to_non_nullable
as List<List<String>>,href: null == href ? _self.href : href // ignore: cast_nullable_to_non_nullable
as String,linkType: null == linkType ? _self.linkType : linkType // ignore: cast_nullable_to_non_nullable
as LinkType,rel: null == rel ? _self.rel : rel // ignore: cast_nullable_to_non_nullable
as List<String>,text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,title: freezed == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [LinkMetadata].
extension LinkMetadataPatterns on LinkMetadata {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LinkMetadata value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LinkMetadata() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LinkMetadata value)  $default,){
final _that = this;
switch (_that) {
case _LinkMetadata():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LinkMetadata value)?  $default,){
final _that = this;
switch (_that) {
case _LinkMetadata() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<List<String>> attributes,  String href, @JsonKey(name: 'link_type')  LinkType linkType,  List<String> rel,  String text,  String? title)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LinkMetadata() when $default != null:
return $default(_that.attributes,_that.href,_that.linkType,_that.rel,_that.text,_that.title);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<List<String>> attributes,  String href, @JsonKey(name: 'link_type')  LinkType linkType,  List<String> rel,  String text,  String? title)  $default,) {final _that = this;
switch (_that) {
case _LinkMetadata():
return $default(_that.attributes,_that.href,_that.linkType,_that.rel,_that.text,_that.title);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<List<String>> attributes,  String href, @JsonKey(name: 'link_type')  LinkType linkType,  List<String> rel,  String text,  String? title)?  $default,) {final _that = this;
switch (_that) {
case _LinkMetadata() when $default != null:
return $default(_that.attributes,_that.href,_that.linkType,_that.rel,_that.text,_that.title);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _LinkMetadata implements LinkMetadata {
  const _LinkMetadata({required final  List<List<String>> attributes, required this.href, @JsonKey(name: 'link_type') required this.linkType, required final  List<String> rel, required this.text, this.title}): _attributes = attributes,_rel = rel;
  factory _LinkMetadata.fromJson(Map<String, dynamic> json) => _$LinkMetadataFromJson(json);

/// Additional attributes as key-value pairs
 final  List<List<String>> _attributes;
/// Additional attributes as key-value pairs
@override List<List<String>> get attributes {
  if (_attributes is EqualUnmodifiableListView) return _attributes;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_attributes);
}

/// The href URL value
@override final  String href;
/// Link type classification
@override@JsonKey(name: 'link_type') final  LinkType linkType;
/// Rel attribute values
 final  List<String> _rel;
/// Rel attribute values
@override List<String> get rel {
  if (_rel is EqualUnmodifiableListView) return _rel;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_rel);
}

/// Link text content (normalized)
@override final  String text;
/// Optional title attribute
@override final  String? title;

/// Create a copy of LinkMetadata
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LinkMetadataCopyWith<_LinkMetadata> get copyWith => __$LinkMetadataCopyWithImpl<_LinkMetadata>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$LinkMetadataToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LinkMetadata&&const DeepCollectionEquality().equals(other._attributes, _attributes)&&(identical(other.href, href) || other.href == href)&&(identical(other.linkType, linkType) || other.linkType == linkType)&&const DeepCollectionEquality().equals(other._rel, _rel)&&(identical(other.text, text) || other.text == text)&&(identical(other.title, title) || other.title == title));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_attributes),href,linkType,const DeepCollectionEquality().hash(_rel),text,title);

@override
String toString() {
  return 'LinkMetadata(attributes: $attributes, href: $href, linkType: $linkType, rel: $rel, text: $text, title: $title)';
}


}

/// @nodoc
abstract mixin class _$LinkMetadataCopyWith<$Res> implements $LinkMetadataCopyWith<$Res> {
  factory _$LinkMetadataCopyWith(_LinkMetadata value, $Res Function(_LinkMetadata) _then) = __$LinkMetadataCopyWithImpl;
@override @useResult
$Res call({
 List<List<String>> attributes, String href,@JsonKey(name: 'link_type') LinkType linkType, List<String> rel, String text, String? title
});




}
/// @nodoc
class __$LinkMetadataCopyWithImpl<$Res>
    implements _$LinkMetadataCopyWith<$Res> {
  __$LinkMetadataCopyWithImpl(this._self, this._then);

  final _LinkMetadata _self;
  final $Res Function(_LinkMetadata) _then;

/// Create a copy of LinkMetadata
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? attributes = null,Object? href = null,Object? linkType = null,Object? rel = null,Object? text = null,Object? title = freezed,}) {
  return _then(_LinkMetadata(
attributes: null == attributes ? _self._attributes : attributes // ignore: cast_nullable_to_non_nullable
as List<List<String>>,href: null == href ? _self.href : href // ignore: cast_nullable_to_non_nullable
as String,linkType: null == linkType ? _self.linkType : linkType // ignore: cast_nullable_to_non_nullable
as LinkType,rel: null == rel ? _self._rel : rel // ignore: cast_nullable_to_non_nullable
as List<String>,text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,title: freezed == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
