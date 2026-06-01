// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'formatted_block.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$FormattedBlock {

/// Type of block element
@JsonKey(name: 'block_type') BlockType get blockType;/// Inline content within the block
@JsonKey(name: 'inline_content') List<InlineElement> get inlineContent;/// Element attributes (classes, IDs, key-value pairs)
 Attributes? get attributes;/// Nested blocks for containers (blockquotes, list items, divs)
 List<FormattedBlock>? get children;/// Raw code content for code blocks
 String? get code;/// Language identifier for code blocks
 String? get language;/// Heading level (1-6) for headings, or nesting level for lists
 int? get level;
/// Create a copy of FormattedBlock
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FormattedBlockCopyWith<FormattedBlock> get copyWith => _$FormattedBlockCopyWithImpl<FormattedBlock>(this as FormattedBlock, _$identity);

  /// Serializes this FormattedBlock to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FormattedBlock&&(identical(other.blockType, blockType) || other.blockType == blockType)&&const DeepCollectionEquality().equals(other.inlineContent, inlineContent)&&(identical(other.attributes, attributes) || other.attributes == attributes)&&const DeepCollectionEquality().equals(other.children, children)&&(identical(other.code, code) || other.code == code)&&(identical(other.language, language) || other.language == language)&&(identical(other.level, level) || other.level == level));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,blockType,const DeepCollectionEquality().hash(inlineContent),attributes,const DeepCollectionEquality().hash(children),code,language,level);

@override
String toString() {
  return 'FormattedBlock(blockType: $blockType, inlineContent: $inlineContent, attributes: $attributes, children: $children, code: $code, language: $language, level: $level)';
}


}

/// @nodoc
abstract mixin class $FormattedBlockCopyWith<$Res>  {
  factory $FormattedBlockCopyWith(FormattedBlock value, $Res Function(FormattedBlock) _then) = _$FormattedBlockCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'block_type') BlockType blockType,@JsonKey(name: 'inline_content') List<InlineElement> inlineContent, Attributes? attributes, List<FormattedBlock>? children, String? code, String? language, int? level
});


$AttributesCopyWith<$Res>? get attributes;

}
/// @nodoc
class _$FormattedBlockCopyWithImpl<$Res>
    implements $FormattedBlockCopyWith<$Res> {
  _$FormattedBlockCopyWithImpl(this._self, this._then);

  final FormattedBlock _self;
  final $Res Function(FormattedBlock) _then;

/// Create a copy of FormattedBlock
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? blockType = null,Object? inlineContent = null,Object? attributes = freezed,Object? children = freezed,Object? code = freezed,Object? language = freezed,Object? level = freezed,}) {
  return _then(_self.copyWith(
blockType: null == blockType ? _self.blockType : blockType // ignore: cast_nullable_to_non_nullable
as BlockType,inlineContent: null == inlineContent ? _self.inlineContent : inlineContent // ignore: cast_nullable_to_non_nullable
as List<InlineElement>,attributes: freezed == attributes ? _self.attributes : attributes // ignore: cast_nullable_to_non_nullable
as Attributes?,children: freezed == children ? _self.children : children // ignore: cast_nullable_to_non_nullable
as List<FormattedBlock>?,code: freezed == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String?,language: freezed == language ? _self.language : language // ignore: cast_nullable_to_non_nullable
as String?,level: freezed == level ? _self.level : level // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}
/// Create a copy of FormattedBlock
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


/// Adds pattern-matching-related methods to [FormattedBlock].
extension FormattedBlockPatterns on FormattedBlock {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FormattedBlock value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FormattedBlock() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FormattedBlock value)  $default,){
final _that = this;
switch (_that) {
case _FormattedBlock():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FormattedBlock value)?  $default,){
final _that = this;
switch (_that) {
case _FormattedBlock() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'block_type')  BlockType blockType, @JsonKey(name: 'inline_content')  List<InlineElement> inlineContent,  Attributes? attributes,  List<FormattedBlock>? children,  String? code,  String? language,  int? level)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FormattedBlock() when $default != null:
return $default(_that.blockType,_that.inlineContent,_that.attributes,_that.children,_that.code,_that.language,_that.level);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'block_type')  BlockType blockType, @JsonKey(name: 'inline_content')  List<InlineElement> inlineContent,  Attributes? attributes,  List<FormattedBlock>? children,  String? code,  String? language,  int? level)  $default,) {final _that = this;
switch (_that) {
case _FormattedBlock():
return $default(_that.blockType,_that.inlineContent,_that.attributes,_that.children,_that.code,_that.language,_that.level);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'block_type')  BlockType blockType, @JsonKey(name: 'inline_content')  List<InlineElement> inlineContent,  Attributes? attributes,  List<FormattedBlock>? children,  String? code,  String? language,  int? level)?  $default,) {final _that = this;
switch (_that) {
case _FormattedBlock() when $default != null:
return $default(_that.blockType,_that.inlineContent,_that.attributes,_that.children,_that.code,_that.language,_that.level);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _FormattedBlock implements FormattedBlock {
  const _FormattedBlock({@JsonKey(name: 'block_type') required this.blockType, @JsonKey(name: 'inline_content') required final  List<InlineElement> inlineContent, this.attributes, final  List<FormattedBlock>? children, this.code, this.language, this.level}): _inlineContent = inlineContent,_children = children;
  factory _FormattedBlock.fromJson(Map<String, dynamic> json) => _$FormattedBlockFromJson(json);

/// Type of block element
@override@JsonKey(name: 'block_type') final  BlockType blockType;
/// Inline content within the block
 final  List<InlineElement> _inlineContent;
/// Inline content within the block
@override@JsonKey(name: 'inline_content') List<InlineElement> get inlineContent {
  if (_inlineContent is EqualUnmodifiableListView) return _inlineContent;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_inlineContent);
}

/// Element attributes (classes, IDs, key-value pairs)
@override final  Attributes? attributes;
/// Nested blocks for containers (blockquotes, list items, divs)
 final  List<FormattedBlock>? _children;
/// Nested blocks for containers (blockquotes, list items, divs)
@override List<FormattedBlock>? get children {
  final value = _children;
  if (value == null) return null;
  if (_children is EqualUnmodifiableListView) return _children;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

/// Raw code content for code blocks
@override final  String? code;
/// Language identifier for code blocks
@override final  String? language;
/// Heading level (1-6) for headings, or nesting level for lists
@override final  int? level;

/// Create a copy of FormattedBlock
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FormattedBlockCopyWith<_FormattedBlock> get copyWith => __$FormattedBlockCopyWithImpl<_FormattedBlock>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$FormattedBlockToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FormattedBlock&&(identical(other.blockType, blockType) || other.blockType == blockType)&&const DeepCollectionEquality().equals(other._inlineContent, _inlineContent)&&(identical(other.attributes, attributes) || other.attributes == attributes)&&const DeepCollectionEquality().equals(other._children, _children)&&(identical(other.code, code) || other.code == code)&&(identical(other.language, language) || other.language == language)&&(identical(other.level, level) || other.level == level));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,blockType,const DeepCollectionEquality().hash(_inlineContent),attributes,const DeepCollectionEquality().hash(_children),code,language,level);

@override
String toString() {
  return 'FormattedBlock(blockType: $blockType, inlineContent: $inlineContent, attributes: $attributes, children: $children, code: $code, language: $language, level: $level)';
}


}

/// @nodoc
abstract mixin class _$FormattedBlockCopyWith<$Res> implements $FormattedBlockCopyWith<$Res> {
  factory _$FormattedBlockCopyWith(_FormattedBlock value, $Res Function(_FormattedBlock) _then) = __$FormattedBlockCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'block_type') BlockType blockType,@JsonKey(name: 'inline_content') List<InlineElement> inlineContent, Attributes? attributes, List<FormattedBlock>? children, String? code, String? language, int? level
});


@override $AttributesCopyWith<$Res>? get attributes;

}
/// @nodoc
class __$FormattedBlockCopyWithImpl<$Res>
    implements _$FormattedBlockCopyWith<$Res> {
  __$FormattedBlockCopyWithImpl(this._self, this._then);

  final _FormattedBlock _self;
  final $Res Function(_FormattedBlock) _then;

/// Create a copy of FormattedBlock
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? blockType = null,Object? inlineContent = null,Object? attributes = freezed,Object? children = freezed,Object? code = freezed,Object? language = freezed,Object? level = freezed,}) {
  return _then(_FormattedBlock(
blockType: null == blockType ? _self.blockType : blockType // ignore: cast_nullable_to_non_nullable
as BlockType,inlineContent: null == inlineContent ? _self._inlineContent : inlineContent // ignore: cast_nullable_to_non_nullable
as List<InlineElement>,attributes: freezed == attributes ? _self.attributes : attributes // ignore: cast_nullable_to_non_nullable
as Attributes?,children: freezed == children ? _self._children : children // ignore: cast_nullable_to_non_nullable
as List<FormattedBlock>?,code: freezed == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String?,language: freezed == language ? _self.language : language // ignore: cast_nullable_to_non_nullable
as String?,level: freezed == level ? _self.level : level // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

/// Create a copy of FormattedBlock
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
