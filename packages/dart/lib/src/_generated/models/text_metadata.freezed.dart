// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'text_metadata.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TextMetadata {

/// Number of characters
@JsonKey(name: 'character_count') int get characterCount;/// Number of lines in the document
@JsonKey(name: 'line_count') int get lineCount;/// Number of words
@JsonKey(name: 'word_count') int get wordCount;/// Code blocks as (language, code) tuples (for Markdown files)
@JsonKey(name: 'code_blocks') List<List<String>>? get codeBlocks;/// Markdown headers (headings text only, for Markdown files)
 List<String>? get headers;/// Markdown links as (text, url) tuples (for Markdown files)
 List<List<String>>? get links;
/// Create a copy of TextMetadata
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TextMetadataCopyWith<TextMetadata> get copyWith => _$TextMetadataCopyWithImpl<TextMetadata>(this as TextMetadata, _$identity);

  /// Serializes this TextMetadata to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TextMetadata&&(identical(other.characterCount, characterCount) || other.characterCount == characterCount)&&(identical(other.lineCount, lineCount) || other.lineCount == lineCount)&&(identical(other.wordCount, wordCount) || other.wordCount == wordCount)&&const DeepCollectionEquality().equals(other.codeBlocks, codeBlocks)&&const DeepCollectionEquality().equals(other.headers, headers)&&const DeepCollectionEquality().equals(other.links, links));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,characterCount,lineCount,wordCount,const DeepCollectionEquality().hash(codeBlocks),const DeepCollectionEquality().hash(headers),const DeepCollectionEquality().hash(links));

@override
String toString() {
  return 'TextMetadata(characterCount: $characterCount, lineCount: $lineCount, wordCount: $wordCount, codeBlocks: $codeBlocks, headers: $headers, links: $links)';
}


}

/// @nodoc
abstract mixin class $TextMetadataCopyWith<$Res>  {
  factory $TextMetadataCopyWith(TextMetadata value, $Res Function(TextMetadata) _then) = _$TextMetadataCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'character_count') int characterCount,@JsonKey(name: 'line_count') int lineCount,@JsonKey(name: 'word_count') int wordCount,@JsonKey(name: 'code_blocks') List<List<String>>? codeBlocks, List<String>? headers, List<List<String>>? links
});




}
/// @nodoc
class _$TextMetadataCopyWithImpl<$Res>
    implements $TextMetadataCopyWith<$Res> {
  _$TextMetadataCopyWithImpl(this._self, this._then);

  final TextMetadata _self;
  final $Res Function(TextMetadata) _then;

/// Create a copy of TextMetadata
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? characterCount = null,Object? lineCount = null,Object? wordCount = null,Object? codeBlocks = freezed,Object? headers = freezed,Object? links = freezed,}) {
  return _then(_self.copyWith(
characterCount: null == characterCount ? _self.characterCount : characterCount // ignore: cast_nullable_to_non_nullable
as int,lineCount: null == lineCount ? _self.lineCount : lineCount // ignore: cast_nullable_to_non_nullable
as int,wordCount: null == wordCount ? _self.wordCount : wordCount // ignore: cast_nullable_to_non_nullable
as int,codeBlocks: freezed == codeBlocks ? _self.codeBlocks : codeBlocks // ignore: cast_nullable_to_non_nullable
as List<List<String>>?,headers: freezed == headers ? _self.headers : headers // ignore: cast_nullable_to_non_nullable
as List<String>?,links: freezed == links ? _self.links : links // ignore: cast_nullable_to_non_nullable
as List<List<String>>?,
  ));
}

}


/// Adds pattern-matching-related methods to [TextMetadata].
extension TextMetadataPatterns on TextMetadata {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TextMetadata value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TextMetadata() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TextMetadata value)  $default,){
final _that = this;
switch (_that) {
case _TextMetadata():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TextMetadata value)?  $default,){
final _that = this;
switch (_that) {
case _TextMetadata() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'character_count')  int characterCount, @JsonKey(name: 'line_count')  int lineCount, @JsonKey(name: 'word_count')  int wordCount, @JsonKey(name: 'code_blocks')  List<List<String>>? codeBlocks,  List<String>? headers,  List<List<String>>? links)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TextMetadata() when $default != null:
return $default(_that.characterCount,_that.lineCount,_that.wordCount,_that.codeBlocks,_that.headers,_that.links);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'character_count')  int characterCount, @JsonKey(name: 'line_count')  int lineCount, @JsonKey(name: 'word_count')  int wordCount, @JsonKey(name: 'code_blocks')  List<List<String>>? codeBlocks,  List<String>? headers,  List<List<String>>? links)  $default,) {final _that = this;
switch (_that) {
case _TextMetadata():
return $default(_that.characterCount,_that.lineCount,_that.wordCount,_that.codeBlocks,_that.headers,_that.links);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'character_count')  int characterCount, @JsonKey(name: 'line_count')  int lineCount, @JsonKey(name: 'word_count')  int wordCount, @JsonKey(name: 'code_blocks')  List<List<String>>? codeBlocks,  List<String>? headers,  List<List<String>>? links)?  $default,) {final _that = this;
switch (_that) {
case _TextMetadata() when $default != null:
return $default(_that.characterCount,_that.lineCount,_that.wordCount,_that.codeBlocks,_that.headers,_that.links);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TextMetadata implements TextMetadata {
  const _TextMetadata({@JsonKey(name: 'character_count') required this.characterCount, @JsonKey(name: 'line_count') required this.lineCount, @JsonKey(name: 'word_count') required this.wordCount, @JsonKey(name: 'code_blocks') final  List<List<String>>? codeBlocks, final  List<String>? headers, final  List<List<String>>? links}): _codeBlocks = codeBlocks,_headers = headers,_links = links;
  factory _TextMetadata.fromJson(Map<String, dynamic> json) => _$TextMetadataFromJson(json);

/// Number of characters
@override@JsonKey(name: 'character_count') final  int characterCount;
/// Number of lines in the document
@override@JsonKey(name: 'line_count') final  int lineCount;
/// Number of words
@override@JsonKey(name: 'word_count') final  int wordCount;
/// Code blocks as (language, code) tuples (for Markdown files)
 final  List<List<String>>? _codeBlocks;
/// Code blocks as (language, code) tuples (for Markdown files)
@override@JsonKey(name: 'code_blocks') List<List<String>>? get codeBlocks {
  final value = _codeBlocks;
  if (value == null) return null;
  if (_codeBlocks is EqualUnmodifiableListView) return _codeBlocks;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

/// Markdown headers (headings text only, for Markdown files)
 final  List<String>? _headers;
/// Markdown headers (headings text only, for Markdown files)
@override List<String>? get headers {
  final value = _headers;
  if (value == null) return null;
  if (_headers is EqualUnmodifiableListView) return _headers;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

/// Markdown links as (text, url) tuples (for Markdown files)
 final  List<List<String>>? _links;
/// Markdown links as (text, url) tuples (for Markdown files)
@override List<List<String>>? get links {
  final value = _links;
  if (value == null) return null;
  if (_links is EqualUnmodifiableListView) return _links;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}


/// Create a copy of TextMetadata
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TextMetadataCopyWith<_TextMetadata> get copyWith => __$TextMetadataCopyWithImpl<_TextMetadata>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TextMetadataToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TextMetadata&&(identical(other.characterCount, characterCount) || other.characterCount == characterCount)&&(identical(other.lineCount, lineCount) || other.lineCount == lineCount)&&(identical(other.wordCount, wordCount) || other.wordCount == wordCount)&&const DeepCollectionEquality().equals(other._codeBlocks, _codeBlocks)&&const DeepCollectionEquality().equals(other._headers, _headers)&&const DeepCollectionEquality().equals(other._links, _links));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,characterCount,lineCount,wordCount,const DeepCollectionEquality().hash(_codeBlocks),const DeepCollectionEquality().hash(_headers),const DeepCollectionEquality().hash(_links));

@override
String toString() {
  return 'TextMetadata(characterCount: $characterCount, lineCount: $lineCount, wordCount: $wordCount, codeBlocks: $codeBlocks, headers: $headers, links: $links)';
}


}

/// @nodoc
abstract mixin class _$TextMetadataCopyWith<$Res> implements $TextMetadataCopyWith<$Res> {
  factory _$TextMetadataCopyWith(_TextMetadata value, $Res Function(_TextMetadata) _then) = __$TextMetadataCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'character_count') int characterCount,@JsonKey(name: 'line_count') int lineCount,@JsonKey(name: 'word_count') int wordCount,@JsonKey(name: 'code_blocks') List<List<String>>? codeBlocks, List<String>? headers, List<List<String>>? links
});




}
/// @nodoc
class __$TextMetadataCopyWithImpl<$Res>
    implements _$TextMetadataCopyWith<$Res> {
  __$TextMetadataCopyWithImpl(this._self, this._then);

  final _TextMetadata _self;
  final $Res Function(_TextMetadata) _then;

/// Create a copy of TextMetadata
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? characterCount = null,Object? lineCount = null,Object? wordCount = null,Object? codeBlocks = freezed,Object? headers = freezed,Object? links = freezed,}) {
  return _then(_TextMetadata(
characterCount: null == characterCount ? _self.characterCount : characterCount // ignore: cast_nullable_to_non_nullable
as int,lineCount: null == lineCount ? _self.lineCount : lineCount // ignore: cast_nullable_to_non_nullable
as int,wordCount: null == wordCount ? _self.wordCount : wordCount // ignore: cast_nullable_to_non_nullable
as int,codeBlocks: freezed == codeBlocks ? _self._codeBlocks : codeBlocks // ignore: cast_nullable_to_non_nullable
as List<List<String>>?,headers: freezed == headers ? _self._headers : headers // ignore: cast_nullable_to_non_nullable
as List<String>?,links: freezed == links ? _self._links : links // ignore: cast_nullable_to_non_nullable
as List<List<String>>?,
  ));
}


}

// dart format on
