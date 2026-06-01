// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'header_metadata.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$HeaderMetadata {

/// Document tree depth at the header element
 int get depth;/// Byte offset in original HTML document
@JsonKey(name: 'html_offset') int get htmlOffset;/// Header level: 1 (h1) through 6 (h6)
 int get level;/// Normalized text content of the header
 String get text;/// HTML id attribute if present
 String? get id;
/// Create a copy of HeaderMetadata
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HeaderMetadataCopyWith<HeaderMetadata> get copyWith => _$HeaderMetadataCopyWithImpl<HeaderMetadata>(this as HeaderMetadata, _$identity);

  /// Serializes this HeaderMetadata to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HeaderMetadata&&(identical(other.depth, depth) || other.depth == depth)&&(identical(other.htmlOffset, htmlOffset) || other.htmlOffset == htmlOffset)&&(identical(other.level, level) || other.level == level)&&(identical(other.text, text) || other.text == text)&&(identical(other.id, id) || other.id == id));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,depth,htmlOffset,level,text,id);

@override
String toString() {
  return 'HeaderMetadata(depth: $depth, htmlOffset: $htmlOffset, level: $level, text: $text, id: $id)';
}


}

/// @nodoc
abstract mixin class $HeaderMetadataCopyWith<$Res>  {
  factory $HeaderMetadataCopyWith(HeaderMetadata value, $Res Function(HeaderMetadata) _then) = _$HeaderMetadataCopyWithImpl;
@useResult
$Res call({
 int depth,@JsonKey(name: 'html_offset') int htmlOffset, int level, String text, String? id
});




}
/// @nodoc
class _$HeaderMetadataCopyWithImpl<$Res>
    implements $HeaderMetadataCopyWith<$Res> {
  _$HeaderMetadataCopyWithImpl(this._self, this._then);

  final HeaderMetadata _self;
  final $Res Function(HeaderMetadata) _then;

/// Create a copy of HeaderMetadata
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? depth = null,Object? htmlOffset = null,Object? level = null,Object? text = null,Object? id = freezed,}) {
  return _then(_self.copyWith(
depth: null == depth ? _self.depth : depth // ignore: cast_nullable_to_non_nullable
as int,htmlOffset: null == htmlOffset ? _self.htmlOffset : htmlOffset // ignore: cast_nullable_to_non_nullable
as int,level: null == level ? _self.level : level // ignore: cast_nullable_to_non_nullable
as int,text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [HeaderMetadata].
extension HeaderMetadataPatterns on HeaderMetadata {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _HeaderMetadata value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _HeaderMetadata() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _HeaderMetadata value)  $default,){
final _that = this;
switch (_that) {
case _HeaderMetadata():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _HeaderMetadata value)?  $default,){
final _that = this;
switch (_that) {
case _HeaderMetadata() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int depth, @JsonKey(name: 'html_offset')  int htmlOffset,  int level,  String text,  String? id)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _HeaderMetadata() when $default != null:
return $default(_that.depth,_that.htmlOffset,_that.level,_that.text,_that.id);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int depth, @JsonKey(name: 'html_offset')  int htmlOffset,  int level,  String text,  String? id)  $default,) {final _that = this;
switch (_that) {
case _HeaderMetadata():
return $default(_that.depth,_that.htmlOffset,_that.level,_that.text,_that.id);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int depth, @JsonKey(name: 'html_offset')  int htmlOffset,  int level,  String text,  String? id)?  $default,) {final _that = this;
switch (_that) {
case _HeaderMetadata() when $default != null:
return $default(_that.depth,_that.htmlOffset,_that.level,_that.text,_that.id);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _HeaderMetadata implements HeaderMetadata {
  const _HeaderMetadata({required this.depth, @JsonKey(name: 'html_offset') required this.htmlOffset, required this.level, required this.text, this.id});
  factory _HeaderMetadata.fromJson(Map<String, dynamic> json) => _$HeaderMetadataFromJson(json);

/// Document tree depth at the header element
@override final  int depth;
/// Byte offset in original HTML document
@override@JsonKey(name: 'html_offset') final  int htmlOffset;
/// Header level: 1 (h1) through 6 (h6)
@override final  int level;
/// Normalized text content of the header
@override final  String text;
/// HTML id attribute if present
@override final  String? id;

/// Create a copy of HeaderMetadata
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$HeaderMetadataCopyWith<_HeaderMetadata> get copyWith => __$HeaderMetadataCopyWithImpl<_HeaderMetadata>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$HeaderMetadataToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _HeaderMetadata&&(identical(other.depth, depth) || other.depth == depth)&&(identical(other.htmlOffset, htmlOffset) || other.htmlOffset == htmlOffset)&&(identical(other.level, level) || other.level == level)&&(identical(other.text, text) || other.text == text)&&(identical(other.id, id) || other.id == id));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,depth,htmlOffset,level,text,id);

@override
String toString() {
  return 'HeaderMetadata(depth: $depth, htmlOffset: $htmlOffset, level: $level, text: $text, id: $id)';
}


}

/// @nodoc
abstract mixin class _$HeaderMetadataCopyWith<$Res> implements $HeaderMetadataCopyWith<$Res> {
  factory _$HeaderMetadataCopyWith(_HeaderMetadata value, $Res Function(_HeaderMetadata) _then) = __$HeaderMetadataCopyWithImpl;
@override @useResult
$Res call({
 int depth,@JsonKey(name: 'html_offset') int htmlOffset, int level, String text, String? id
});




}
/// @nodoc
class __$HeaderMetadataCopyWithImpl<$Res>
    implements _$HeaderMetadataCopyWith<$Res> {
  __$HeaderMetadataCopyWithImpl(this._self, this._then);

  final _HeaderMetadata _self;
  final $Res Function(_HeaderMetadata) _then;

/// Create a copy of HeaderMetadata
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? depth = null,Object? htmlOffset = null,Object? level = null,Object? text = null,Object? id = freezed,}) {
  return _then(_HeaderMetadata(
depth: null == depth ? _self.depth : depth // ignore: cast_nullable_to_non_nullable
as int,htmlOffset: null == htmlOffset ? _self.htmlOffset : htmlOffset // ignore: cast_nullable_to_non_nullable
as int,level: null == level ? _self.level : level // ignore: cast_nullable_to_non_nullable
as int,text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
