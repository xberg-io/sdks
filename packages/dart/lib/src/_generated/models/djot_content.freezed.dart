// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'djot_content.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$DjotContent {

/// Structured block-level content
 List<FormattedBlock> get blocks;/// Footnote definitions
 List<Footnote> get footnotes;/// Extracted images with metadata
 List<DjotImage> get images;/// Extracted links with URLs
 List<DjotLink> get links;/// Metadata from YAML frontmatter
 Metadata get metadata;/// Plain text representation for backwards compatibility
@JsonKey(name: 'plain_text') String get plainText;/// Extracted tables as structured data
 List<Table> get tables;/// Attributes mapped by element identifier (if present)
 dynamic get attributes;
/// Create a copy of DjotContent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DjotContentCopyWith<DjotContent> get copyWith => _$DjotContentCopyWithImpl<DjotContent>(this as DjotContent, _$identity);

  /// Serializes this DjotContent to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DjotContent&&const DeepCollectionEquality().equals(other.blocks, blocks)&&const DeepCollectionEquality().equals(other.footnotes, footnotes)&&const DeepCollectionEquality().equals(other.images, images)&&const DeepCollectionEquality().equals(other.links, links)&&(identical(other.metadata, metadata) || other.metadata == metadata)&&(identical(other.plainText, plainText) || other.plainText == plainText)&&const DeepCollectionEquality().equals(other.tables, tables)&&const DeepCollectionEquality().equals(other.attributes, attributes));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(blocks),const DeepCollectionEquality().hash(footnotes),const DeepCollectionEquality().hash(images),const DeepCollectionEquality().hash(links),metadata,plainText,const DeepCollectionEquality().hash(tables),const DeepCollectionEquality().hash(attributes));

@override
String toString() {
  return 'DjotContent(blocks: $blocks, footnotes: $footnotes, images: $images, links: $links, metadata: $metadata, plainText: $plainText, tables: $tables, attributes: $attributes)';
}


}

/// @nodoc
abstract mixin class $DjotContentCopyWith<$Res>  {
  factory $DjotContentCopyWith(DjotContent value, $Res Function(DjotContent) _then) = _$DjotContentCopyWithImpl;
@useResult
$Res call({
 List<FormattedBlock> blocks, List<Footnote> footnotes, List<DjotImage> images, List<DjotLink> links, Metadata metadata,@JsonKey(name: 'plain_text') String plainText, List<Table> tables, dynamic attributes
});


$MetadataCopyWith<$Res> get metadata;

}
/// @nodoc
class _$DjotContentCopyWithImpl<$Res>
    implements $DjotContentCopyWith<$Res> {
  _$DjotContentCopyWithImpl(this._self, this._then);

  final DjotContent _self;
  final $Res Function(DjotContent) _then;

/// Create a copy of DjotContent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? blocks = null,Object? footnotes = null,Object? images = null,Object? links = null,Object? metadata = null,Object? plainText = null,Object? tables = null,Object? attributes = freezed,}) {
  return _then(_self.copyWith(
blocks: null == blocks ? _self.blocks : blocks // ignore: cast_nullable_to_non_nullable
as List<FormattedBlock>,footnotes: null == footnotes ? _self.footnotes : footnotes // ignore: cast_nullable_to_non_nullable
as List<Footnote>,images: null == images ? _self.images : images // ignore: cast_nullable_to_non_nullable
as List<DjotImage>,links: null == links ? _self.links : links // ignore: cast_nullable_to_non_nullable
as List<DjotLink>,metadata: null == metadata ? _self.metadata : metadata // ignore: cast_nullable_to_non_nullable
as Metadata,plainText: null == plainText ? _self.plainText : plainText // ignore: cast_nullable_to_non_nullable
as String,tables: null == tables ? _self.tables : tables // ignore: cast_nullable_to_non_nullable
as List<Table>,attributes: freezed == attributes ? _self.attributes : attributes // ignore: cast_nullable_to_non_nullable
as dynamic,
  ));
}
/// Create a copy of DjotContent
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MetadataCopyWith<$Res> get metadata {
  
  return $MetadataCopyWith<$Res>(_self.metadata, (value) {
    return _then(_self.copyWith(metadata: value));
  });
}
}


/// Adds pattern-matching-related methods to [DjotContent].
extension DjotContentPatterns on DjotContent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DjotContent value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DjotContent() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DjotContent value)  $default,){
final _that = this;
switch (_that) {
case _DjotContent():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DjotContent value)?  $default,){
final _that = this;
switch (_that) {
case _DjotContent() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<FormattedBlock> blocks,  List<Footnote> footnotes,  List<DjotImage> images,  List<DjotLink> links,  Metadata metadata, @JsonKey(name: 'plain_text')  String plainText,  List<Table> tables,  dynamic attributes)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DjotContent() when $default != null:
return $default(_that.blocks,_that.footnotes,_that.images,_that.links,_that.metadata,_that.plainText,_that.tables,_that.attributes);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<FormattedBlock> blocks,  List<Footnote> footnotes,  List<DjotImage> images,  List<DjotLink> links,  Metadata metadata, @JsonKey(name: 'plain_text')  String plainText,  List<Table> tables,  dynamic attributes)  $default,) {final _that = this;
switch (_that) {
case _DjotContent():
return $default(_that.blocks,_that.footnotes,_that.images,_that.links,_that.metadata,_that.plainText,_that.tables,_that.attributes);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<FormattedBlock> blocks,  List<Footnote> footnotes,  List<DjotImage> images,  List<DjotLink> links,  Metadata metadata, @JsonKey(name: 'plain_text')  String plainText,  List<Table> tables,  dynamic attributes)?  $default,) {final _that = this;
switch (_that) {
case _DjotContent() when $default != null:
return $default(_that.blocks,_that.footnotes,_that.images,_that.links,_that.metadata,_that.plainText,_that.tables,_that.attributes);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _DjotContent implements DjotContent {
  const _DjotContent({required final  List<FormattedBlock> blocks, required final  List<Footnote> footnotes, required final  List<DjotImage> images, required final  List<DjotLink> links, required this.metadata, @JsonKey(name: 'plain_text') required this.plainText, required final  List<Table> tables, this.attributes}): _blocks = blocks,_footnotes = footnotes,_images = images,_links = links,_tables = tables;
  factory _DjotContent.fromJson(Map<String, dynamic> json) => _$DjotContentFromJson(json);

/// Structured block-level content
 final  List<FormattedBlock> _blocks;
/// Structured block-level content
@override List<FormattedBlock> get blocks {
  if (_blocks is EqualUnmodifiableListView) return _blocks;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_blocks);
}

/// Footnote definitions
 final  List<Footnote> _footnotes;
/// Footnote definitions
@override List<Footnote> get footnotes {
  if (_footnotes is EqualUnmodifiableListView) return _footnotes;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_footnotes);
}

/// Extracted images with metadata
 final  List<DjotImage> _images;
/// Extracted images with metadata
@override List<DjotImage> get images {
  if (_images is EqualUnmodifiableListView) return _images;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_images);
}

/// Extracted links with URLs
 final  List<DjotLink> _links;
/// Extracted links with URLs
@override List<DjotLink> get links {
  if (_links is EqualUnmodifiableListView) return _links;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_links);
}

/// Metadata from YAML frontmatter
@override final  Metadata metadata;
/// Plain text representation for backwards compatibility
@override@JsonKey(name: 'plain_text') final  String plainText;
/// Extracted tables as structured data
 final  List<Table> _tables;
/// Extracted tables as structured data
@override List<Table> get tables {
  if (_tables is EqualUnmodifiableListView) return _tables;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_tables);
}

/// Attributes mapped by element identifier (if present)
@override final  dynamic attributes;

/// Create a copy of DjotContent
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DjotContentCopyWith<_DjotContent> get copyWith => __$DjotContentCopyWithImpl<_DjotContent>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DjotContentToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DjotContent&&const DeepCollectionEquality().equals(other._blocks, _blocks)&&const DeepCollectionEquality().equals(other._footnotes, _footnotes)&&const DeepCollectionEquality().equals(other._images, _images)&&const DeepCollectionEquality().equals(other._links, _links)&&(identical(other.metadata, metadata) || other.metadata == metadata)&&(identical(other.plainText, plainText) || other.plainText == plainText)&&const DeepCollectionEquality().equals(other._tables, _tables)&&const DeepCollectionEquality().equals(other.attributes, attributes));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_blocks),const DeepCollectionEquality().hash(_footnotes),const DeepCollectionEquality().hash(_images),const DeepCollectionEquality().hash(_links),metadata,plainText,const DeepCollectionEquality().hash(_tables),const DeepCollectionEquality().hash(attributes));

@override
String toString() {
  return 'DjotContent(blocks: $blocks, footnotes: $footnotes, images: $images, links: $links, metadata: $metadata, plainText: $plainText, tables: $tables, attributes: $attributes)';
}


}

/// @nodoc
abstract mixin class _$DjotContentCopyWith<$Res> implements $DjotContentCopyWith<$Res> {
  factory _$DjotContentCopyWith(_DjotContent value, $Res Function(_DjotContent) _then) = __$DjotContentCopyWithImpl;
@override @useResult
$Res call({
 List<FormattedBlock> blocks, List<Footnote> footnotes, List<DjotImage> images, List<DjotLink> links, Metadata metadata,@JsonKey(name: 'plain_text') String plainText, List<Table> tables, dynamic attributes
});


@override $MetadataCopyWith<$Res> get metadata;

}
/// @nodoc
class __$DjotContentCopyWithImpl<$Res>
    implements _$DjotContentCopyWith<$Res> {
  __$DjotContentCopyWithImpl(this._self, this._then);

  final _DjotContent _self;
  final $Res Function(_DjotContent) _then;

/// Create a copy of DjotContent
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? blocks = null,Object? footnotes = null,Object? images = null,Object? links = null,Object? metadata = null,Object? plainText = null,Object? tables = null,Object? attributes = freezed,}) {
  return _then(_DjotContent(
blocks: null == blocks ? _self._blocks : blocks // ignore: cast_nullable_to_non_nullable
as List<FormattedBlock>,footnotes: null == footnotes ? _self._footnotes : footnotes // ignore: cast_nullable_to_non_nullable
as List<Footnote>,images: null == images ? _self._images : images // ignore: cast_nullable_to_non_nullable
as List<DjotImage>,links: null == links ? _self._links : links // ignore: cast_nullable_to_non_nullable
as List<DjotLink>,metadata: null == metadata ? _self.metadata : metadata // ignore: cast_nullable_to_non_nullable
as Metadata,plainText: null == plainText ? _self.plainText : plainText // ignore: cast_nullable_to_non_nullable
as String,tables: null == tables ? _self._tables : tables // ignore: cast_nullable_to_non_nullable
as List<Table>,attributes: freezed == attributes ? _self.attributes : attributes // ignore: cast_nullable_to_non_nullable
as dynamic,
  ));
}

/// Create a copy of DjotContent
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MetadataCopyWith<$Res> get metadata {
  
  return $MetadataCopyWith<$Res>(_self.metadata, (value) {
    return _then(_self.copyWith(metadata: value));
  });
}
}

// dart format on
