// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'chunk_metadata.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ChunkMetadata {

/// Byte offset where this chunk ends in the original text (UTF-8 valid boundary).
@JsonKey(name: 'byte_end') int get byteEnd;/// Byte offset where this chunk starts in the original text (UTF-8 valid boundary).
@JsonKey(name: 'byte_start') int get byteStart;/// Zero-based index of this chunk in the document.
@JsonKey(name: 'chunk_index') int get chunkIndex;/// Total number of chunks in the document.
@JsonKey(name: 'total_chunks') int get totalChunks;/// First page number this chunk spans (1-indexed).
///
/// Only populated when page tracking is enabled in extraction configuration.
@JsonKey(name: 'first_page') int? get firstPage;/// Heading context when using Markdown chunker.
///
/// Contains the heading hierarchy this chunk falls under.
/// Only populated when `ChunkerType::Markdown` is used.
@JsonKey(name: 'heading_context') HeadingContext? get headingContext;/// Indices into `ExtractionResult.images` for images on pages covered by this chunk.
///
/// Contains zero-based indices into the top-level `images` collection for every.
/// image whose `page_number` falls within `[first_page, last_page]`.
/// Empty when image extraction is disabled or the chunk spans no pages with images.
@JsonKey(name: 'image_indices') List<int>? get imageIndices;/// Last page number this chunk spans (1-indexed, equal to first_page for single-page chunks).
///
/// Only populated when page tracking is enabled in extraction configuration.
@JsonKey(name: 'last_page') int? get lastPage;/// Number of tokens in this chunk (if available).
///
/// This is calculated by the embedding model's tokenizer if embeddings are enabled.
@JsonKey(name: 'token_count') int? get tokenCount;
/// Create a copy of ChunkMetadata
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChunkMetadataCopyWith<ChunkMetadata> get copyWith => _$ChunkMetadataCopyWithImpl<ChunkMetadata>(this as ChunkMetadata, _$identity);

  /// Serializes this ChunkMetadata to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChunkMetadata&&(identical(other.byteEnd, byteEnd) || other.byteEnd == byteEnd)&&(identical(other.byteStart, byteStart) || other.byteStart == byteStart)&&(identical(other.chunkIndex, chunkIndex) || other.chunkIndex == chunkIndex)&&(identical(other.totalChunks, totalChunks) || other.totalChunks == totalChunks)&&(identical(other.firstPage, firstPage) || other.firstPage == firstPage)&&(identical(other.headingContext, headingContext) || other.headingContext == headingContext)&&const DeepCollectionEquality().equals(other.imageIndices, imageIndices)&&(identical(other.lastPage, lastPage) || other.lastPage == lastPage)&&(identical(other.tokenCount, tokenCount) || other.tokenCount == tokenCount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,byteEnd,byteStart,chunkIndex,totalChunks,firstPage,headingContext,const DeepCollectionEquality().hash(imageIndices),lastPage,tokenCount);

@override
String toString() {
  return 'ChunkMetadata(byteEnd: $byteEnd, byteStart: $byteStart, chunkIndex: $chunkIndex, totalChunks: $totalChunks, firstPage: $firstPage, headingContext: $headingContext, imageIndices: $imageIndices, lastPage: $lastPage, tokenCount: $tokenCount)';
}


}

/// @nodoc
abstract mixin class $ChunkMetadataCopyWith<$Res>  {
  factory $ChunkMetadataCopyWith(ChunkMetadata value, $Res Function(ChunkMetadata) _then) = _$ChunkMetadataCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'byte_end') int byteEnd,@JsonKey(name: 'byte_start') int byteStart,@JsonKey(name: 'chunk_index') int chunkIndex,@JsonKey(name: 'total_chunks') int totalChunks,@JsonKey(name: 'first_page') int? firstPage,@JsonKey(name: 'heading_context') HeadingContext? headingContext,@JsonKey(name: 'image_indices') List<int>? imageIndices,@JsonKey(name: 'last_page') int? lastPage,@JsonKey(name: 'token_count') int? tokenCount
});


$HeadingContextCopyWith<$Res>? get headingContext;

}
/// @nodoc
class _$ChunkMetadataCopyWithImpl<$Res>
    implements $ChunkMetadataCopyWith<$Res> {
  _$ChunkMetadataCopyWithImpl(this._self, this._then);

  final ChunkMetadata _self;
  final $Res Function(ChunkMetadata) _then;

/// Create a copy of ChunkMetadata
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? byteEnd = null,Object? byteStart = null,Object? chunkIndex = null,Object? totalChunks = null,Object? firstPage = freezed,Object? headingContext = freezed,Object? imageIndices = freezed,Object? lastPage = freezed,Object? tokenCount = freezed,}) {
  return _then(_self.copyWith(
byteEnd: null == byteEnd ? _self.byteEnd : byteEnd // ignore: cast_nullable_to_non_nullable
as int,byteStart: null == byteStart ? _self.byteStart : byteStart // ignore: cast_nullable_to_non_nullable
as int,chunkIndex: null == chunkIndex ? _self.chunkIndex : chunkIndex // ignore: cast_nullable_to_non_nullable
as int,totalChunks: null == totalChunks ? _self.totalChunks : totalChunks // ignore: cast_nullable_to_non_nullable
as int,firstPage: freezed == firstPage ? _self.firstPage : firstPage // ignore: cast_nullable_to_non_nullable
as int?,headingContext: freezed == headingContext ? _self.headingContext : headingContext // ignore: cast_nullable_to_non_nullable
as HeadingContext?,imageIndices: freezed == imageIndices ? _self.imageIndices : imageIndices // ignore: cast_nullable_to_non_nullable
as List<int>?,lastPage: freezed == lastPage ? _self.lastPage : lastPage // ignore: cast_nullable_to_non_nullable
as int?,tokenCount: freezed == tokenCount ? _self.tokenCount : tokenCount // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}
/// Create a copy of ChunkMetadata
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$HeadingContextCopyWith<$Res>? get headingContext {
    if (_self.headingContext == null) {
    return null;
  }

  return $HeadingContextCopyWith<$Res>(_self.headingContext!, (value) {
    return _then(_self.copyWith(headingContext: value));
  });
}
}


/// Adds pattern-matching-related methods to [ChunkMetadata].
extension ChunkMetadataPatterns on ChunkMetadata {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ChunkMetadata value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ChunkMetadata() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ChunkMetadata value)  $default,){
final _that = this;
switch (_that) {
case _ChunkMetadata():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ChunkMetadata value)?  $default,){
final _that = this;
switch (_that) {
case _ChunkMetadata() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'byte_end')  int byteEnd, @JsonKey(name: 'byte_start')  int byteStart, @JsonKey(name: 'chunk_index')  int chunkIndex, @JsonKey(name: 'total_chunks')  int totalChunks, @JsonKey(name: 'first_page')  int? firstPage, @JsonKey(name: 'heading_context')  HeadingContext? headingContext, @JsonKey(name: 'image_indices')  List<int>? imageIndices, @JsonKey(name: 'last_page')  int? lastPage, @JsonKey(name: 'token_count')  int? tokenCount)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ChunkMetadata() when $default != null:
return $default(_that.byteEnd,_that.byteStart,_that.chunkIndex,_that.totalChunks,_that.firstPage,_that.headingContext,_that.imageIndices,_that.lastPage,_that.tokenCount);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'byte_end')  int byteEnd, @JsonKey(name: 'byte_start')  int byteStart, @JsonKey(name: 'chunk_index')  int chunkIndex, @JsonKey(name: 'total_chunks')  int totalChunks, @JsonKey(name: 'first_page')  int? firstPage, @JsonKey(name: 'heading_context')  HeadingContext? headingContext, @JsonKey(name: 'image_indices')  List<int>? imageIndices, @JsonKey(name: 'last_page')  int? lastPage, @JsonKey(name: 'token_count')  int? tokenCount)  $default,) {final _that = this;
switch (_that) {
case _ChunkMetadata():
return $default(_that.byteEnd,_that.byteStart,_that.chunkIndex,_that.totalChunks,_that.firstPage,_that.headingContext,_that.imageIndices,_that.lastPage,_that.tokenCount);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'byte_end')  int byteEnd, @JsonKey(name: 'byte_start')  int byteStart, @JsonKey(name: 'chunk_index')  int chunkIndex, @JsonKey(name: 'total_chunks')  int totalChunks, @JsonKey(name: 'first_page')  int? firstPage, @JsonKey(name: 'heading_context')  HeadingContext? headingContext, @JsonKey(name: 'image_indices')  List<int>? imageIndices, @JsonKey(name: 'last_page')  int? lastPage, @JsonKey(name: 'token_count')  int? tokenCount)?  $default,) {final _that = this;
switch (_that) {
case _ChunkMetadata() when $default != null:
return $default(_that.byteEnd,_that.byteStart,_that.chunkIndex,_that.totalChunks,_that.firstPage,_that.headingContext,_that.imageIndices,_that.lastPage,_that.tokenCount);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ChunkMetadata implements ChunkMetadata {
  const _ChunkMetadata({@JsonKey(name: 'byte_end') required this.byteEnd, @JsonKey(name: 'byte_start') required this.byteStart, @JsonKey(name: 'chunk_index') required this.chunkIndex, @JsonKey(name: 'total_chunks') required this.totalChunks, @JsonKey(name: 'first_page') this.firstPage, @JsonKey(name: 'heading_context') this.headingContext, @JsonKey(name: 'image_indices') final  List<int>? imageIndices, @JsonKey(name: 'last_page') this.lastPage, @JsonKey(name: 'token_count') this.tokenCount}): _imageIndices = imageIndices;
  factory _ChunkMetadata.fromJson(Map<String, dynamic> json) => _$ChunkMetadataFromJson(json);

/// Byte offset where this chunk ends in the original text (UTF-8 valid boundary).
@override@JsonKey(name: 'byte_end') final  int byteEnd;
/// Byte offset where this chunk starts in the original text (UTF-8 valid boundary).
@override@JsonKey(name: 'byte_start') final  int byteStart;
/// Zero-based index of this chunk in the document.
@override@JsonKey(name: 'chunk_index') final  int chunkIndex;
/// Total number of chunks in the document.
@override@JsonKey(name: 'total_chunks') final  int totalChunks;
/// First page number this chunk spans (1-indexed).
///
/// Only populated when page tracking is enabled in extraction configuration.
@override@JsonKey(name: 'first_page') final  int? firstPage;
/// Heading context when using Markdown chunker.
///
/// Contains the heading hierarchy this chunk falls under.
/// Only populated when `ChunkerType::Markdown` is used.
@override@JsonKey(name: 'heading_context') final  HeadingContext? headingContext;
/// Indices into `ExtractionResult.images` for images on pages covered by this chunk.
///
/// Contains zero-based indices into the top-level `images` collection for every.
/// image whose `page_number` falls within `[first_page, last_page]`.
/// Empty when image extraction is disabled or the chunk spans no pages with images.
 final  List<int>? _imageIndices;
/// Indices into `ExtractionResult.images` for images on pages covered by this chunk.
///
/// Contains zero-based indices into the top-level `images` collection for every.
/// image whose `page_number` falls within `[first_page, last_page]`.
/// Empty when image extraction is disabled or the chunk spans no pages with images.
@override@JsonKey(name: 'image_indices') List<int>? get imageIndices {
  final value = _imageIndices;
  if (value == null) return null;
  if (_imageIndices is EqualUnmodifiableListView) return _imageIndices;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

/// Last page number this chunk spans (1-indexed, equal to first_page for single-page chunks).
///
/// Only populated when page tracking is enabled in extraction configuration.
@override@JsonKey(name: 'last_page') final  int? lastPage;
/// Number of tokens in this chunk (if available).
///
/// This is calculated by the embedding model's tokenizer if embeddings are enabled.
@override@JsonKey(name: 'token_count') final  int? tokenCount;

/// Create a copy of ChunkMetadata
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ChunkMetadataCopyWith<_ChunkMetadata> get copyWith => __$ChunkMetadataCopyWithImpl<_ChunkMetadata>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ChunkMetadataToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ChunkMetadata&&(identical(other.byteEnd, byteEnd) || other.byteEnd == byteEnd)&&(identical(other.byteStart, byteStart) || other.byteStart == byteStart)&&(identical(other.chunkIndex, chunkIndex) || other.chunkIndex == chunkIndex)&&(identical(other.totalChunks, totalChunks) || other.totalChunks == totalChunks)&&(identical(other.firstPage, firstPage) || other.firstPage == firstPage)&&(identical(other.headingContext, headingContext) || other.headingContext == headingContext)&&const DeepCollectionEquality().equals(other._imageIndices, _imageIndices)&&(identical(other.lastPage, lastPage) || other.lastPage == lastPage)&&(identical(other.tokenCount, tokenCount) || other.tokenCount == tokenCount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,byteEnd,byteStart,chunkIndex,totalChunks,firstPage,headingContext,const DeepCollectionEquality().hash(_imageIndices),lastPage,tokenCount);

@override
String toString() {
  return 'ChunkMetadata(byteEnd: $byteEnd, byteStart: $byteStart, chunkIndex: $chunkIndex, totalChunks: $totalChunks, firstPage: $firstPage, headingContext: $headingContext, imageIndices: $imageIndices, lastPage: $lastPage, tokenCount: $tokenCount)';
}


}

/// @nodoc
abstract mixin class _$ChunkMetadataCopyWith<$Res> implements $ChunkMetadataCopyWith<$Res> {
  factory _$ChunkMetadataCopyWith(_ChunkMetadata value, $Res Function(_ChunkMetadata) _then) = __$ChunkMetadataCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'byte_end') int byteEnd,@JsonKey(name: 'byte_start') int byteStart,@JsonKey(name: 'chunk_index') int chunkIndex,@JsonKey(name: 'total_chunks') int totalChunks,@JsonKey(name: 'first_page') int? firstPage,@JsonKey(name: 'heading_context') HeadingContext? headingContext,@JsonKey(name: 'image_indices') List<int>? imageIndices,@JsonKey(name: 'last_page') int? lastPage,@JsonKey(name: 'token_count') int? tokenCount
});


@override $HeadingContextCopyWith<$Res>? get headingContext;

}
/// @nodoc
class __$ChunkMetadataCopyWithImpl<$Res>
    implements _$ChunkMetadataCopyWith<$Res> {
  __$ChunkMetadataCopyWithImpl(this._self, this._then);

  final _ChunkMetadata _self;
  final $Res Function(_ChunkMetadata) _then;

/// Create a copy of ChunkMetadata
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? byteEnd = null,Object? byteStart = null,Object? chunkIndex = null,Object? totalChunks = null,Object? firstPage = freezed,Object? headingContext = freezed,Object? imageIndices = freezed,Object? lastPage = freezed,Object? tokenCount = freezed,}) {
  return _then(_ChunkMetadata(
byteEnd: null == byteEnd ? _self.byteEnd : byteEnd // ignore: cast_nullable_to_non_nullable
as int,byteStart: null == byteStart ? _self.byteStart : byteStart // ignore: cast_nullable_to_non_nullable
as int,chunkIndex: null == chunkIndex ? _self.chunkIndex : chunkIndex // ignore: cast_nullable_to_non_nullable
as int,totalChunks: null == totalChunks ? _self.totalChunks : totalChunks // ignore: cast_nullable_to_non_nullable
as int,firstPage: freezed == firstPage ? _self.firstPage : firstPage // ignore: cast_nullable_to_non_nullable
as int?,headingContext: freezed == headingContext ? _self.headingContext : headingContext // ignore: cast_nullable_to_non_nullable
as HeadingContext?,imageIndices: freezed == imageIndices ? _self._imageIndices : imageIndices // ignore: cast_nullable_to_non_nullable
as List<int>?,lastPage: freezed == lastPage ? _self.lastPage : lastPage // ignore: cast_nullable_to_non_nullable
as int?,tokenCount: freezed == tokenCount ? _self.tokenCount : tokenCount // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

/// Create a copy of ChunkMetadata
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$HeadingContextCopyWith<$Res>? get headingContext {
    if (_self.headingContext == null) {
    return null;
  }

  return $HeadingContextCopyWith<$Res>(_self.headingContext!, (value) {
    return _then(_self.copyWith(headingContext: value));
  });
}
}

// dart format on
