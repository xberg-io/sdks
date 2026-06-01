// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'hierarchical_block.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$HierarchicalBlock {

/// The font size of the text in this block
@JsonKey(name: 'font_size') double get fontSize;/// The hierarchy level of this block (H1-H6 or Body).
///
/// Levels correspond to HTML heading tags:.
/// - "h1": Top-level heading.
/// - "h2": Secondary heading.
/// - "h3": Tertiary heading.
/// - "h4": Quaternary heading.
/// - "h5": Quinary heading.
/// - "h6": Senary heading.
/// - "body": Body text (no heading level).
 String get level;/// The text content of this block
 String get text;/// Bounding box information for the block.
///
/// Contains coordinates as (left, top, right, bottom) in PDF units.
 List<double>? get bbox;
/// Create a copy of HierarchicalBlock
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HierarchicalBlockCopyWith<HierarchicalBlock> get copyWith => _$HierarchicalBlockCopyWithImpl<HierarchicalBlock>(this as HierarchicalBlock, _$identity);

  /// Serializes this HierarchicalBlock to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HierarchicalBlock&&(identical(other.fontSize, fontSize) || other.fontSize == fontSize)&&(identical(other.level, level) || other.level == level)&&(identical(other.text, text) || other.text == text)&&const DeepCollectionEquality().equals(other.bbox, bbox));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,fontSize,level,text,const DeepCollectionEquality().hash(bbox));

@override
String toString() {
  return 'HierarchicalBlock(fontSize: $fontSize, level: $level, text: $text, bbox: $bbox)';
}


}

/// @nodoc
abstract mixin class $HierarchicalBlockCopyWith<$Res>  {
  factory $HierarchicalBlockCopyWith(HierarchicalBlock value, $Res Function(HierarchicalBlock) _then) = _$HierarchicalBlockCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'font_size') double fontSize, String level, String text, List<double>? bbox
});




}
/// @nodoc
class _$HierarchicalBlockCopyWithImpl<$Res>
    implements $HierarchicalBlockCopyWith<$Res> {
  _$HierarchicalBlockCopyWithImpl(this._self, this._then);

  final HierarchicalBlock _self;
  final $Res Function(HierarchicalBlock) _then;

/// Create a copy of HierarchicalBlock
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? fontSize = null,Object? level = null,Object? text = null,Object? bbox = freezed,}) {
  return _then(_self.copyWith(
fontSize: null == fontSize ? _self.fontSize : fontSize // ignore: cast_nullable_to_non_nullable
as double,level: null == level ? _self.level : level // ignore: cast_nullable_to_non_nullable
as String,text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,bbox: freezed == bbox ? _self.bbox : bbox // ignore: cast_nullable_to_non_nullable
as List<double>?,
  ));
}

}


/// Adds pattern-matching-related methods to [HierarchicalBlock].
extension HierarchicalBlockPatterns on HierarchicalBlock {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _HierarchicalBlock value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _HierarchicalBlock() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _HierarchicalBlock value)  $default,){
final _that = this;
switch (_that) {
case _HierarchicalBlock():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _HierarchicalBlock value)?  $default,){
final _that = this;
switch (_that) {
case _HierarchicalBlock() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'font_size')  double fontSize,  String level,  String text,  List<double>? bbox)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _HierarchicalBlock() when $default != null:
return $default(_that.fontSize,_that.level,_that.text,_that.bbox);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'font_size')  double fontSize,  String level,  String text,  List<double>? bbox)  $default,) {final _that = this;
switch (_that) {
case _HierarchicalBlock():
return $default(_that.fontSize,_that.level,_that.text,_that.bbox);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'font_size')  double fontSize,  String level,  String text,  List<double>? bbox)?  $default,) {final _that = this;
switch (_that) {
case _HierarchicalBlock() when $default != null:
return $default(_that.fontSize,_that.level,_that.text,_that.bbox);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _HierarchicalBlock implements HierarchicalBlock {
  const _HierarchicalBlock({@JsonKey(name: 'font_size') required this.fontSize, required this.level, required this.text, final  List<double>? bbox}): _bbox = bbox;
  factory _HierarchicalBlock.fromJson(Map<String, dynamic> json) => _$HierarchicalBlockFromJson(json);

/// The font size of the text in this block
@override@JsonKey(name: 'font_size') final  double fontSize;
/// The hierarchy level of this block (H1-H6 or Body).
///
/// Levels correspond to HTML heading tags:.
/// - "h1": Top-level heading.
/// - "h2": Secondary heading.
/// - "h3": Tertiary heading.
/// - "h4": Quaternary heading.
/// - "h5": Quinary heading.
/// - "h6": Senary heading.
/// - "body": Body text (no heading level).
@override final  String level;
/// The text content of this block
@override final  String text;
/// Bounding box information for the block.
///
/// Contains coordinates as (left, top, right, bottom) in PDF units.
 final  List<double>? _bbox;
/// Bounding box information for the block.
///
/// Contains coordinates as (left, top, right, bottom) in PDF units.
@override List<double>? get bbox {
  final value = _bbox;
  if (value == null) return null;
  if (_bbox is EqualUnmodifiableListView) return _bbox;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}


/// Create a copy of HierarchicalBlock
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$HierarchicalBlockCopyWith<_HierarchicalBlock> get copyWith => __$HierarchicalBlockCopyWithImpl<_HierarchicalBlock>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$HierarchicalBlockToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _HierarchicalBlock&&(identical(other.fontSize, fontSize) || other.fontSize == fontSize)&&(identical(other.level, level) || other.level == level)&&(identical(other.text, text) || other.text == text)&&const DeepCollectionEquality().equals(other._bbox, _bbox));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,fontSize,level,text,const DeepCollectionEquality().hash(_bbox));

@override
String toString() {
  return 'HierarchicalBlock(fontSize: $fontSize, level: $level, text: $text, bbox: $bbox)';
}


}

/// @nodoc
abstract mixin class _$HierarchicalBlockCopyWith<$Res> implements $HierarchicalBlockCopyWith<$Res> {
  factory _$HierarchicalBlockCopyWith(_HierarchicalBlock value, $Res Function(_HierarchicalBlock) _then) = __$HierarchicalBlockCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'font_size') double fontSize, String level, String text, List<double>? bbox
});




}
/// @nodoc
class __$HierarchicalBlockCopyWithImpl<$Res>
    implements _$HierarchicalBlockCopyWith<$Res> {
  __$HierarchicalBlockCopyWithImpl(this._self, this._then);

  final _HierarchicalBlock _self;
  final $Res Function(_HierarchicalBlock) _then;

/// Create a copy of HierarchicalBlock
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? fontSize = null,Object? level = null,Object? text = null,Object? bbox = freezed,}) {
  return _then(_HierarchicalBlock(
fontSize: null == fontSize ? _self.fontSize : fontSize // ignore: cast_nullable_to_non_nullable
as double,level: null == level ? _self.level : level // ignore: cast_nullable_to_non_nullable
as String,text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,bbox: freezed == bbox ? _self._bbox : bbox // ignore: cast_nullable_to_non_nullable
as List<double>?,
  ));
}


}

// dart format on
