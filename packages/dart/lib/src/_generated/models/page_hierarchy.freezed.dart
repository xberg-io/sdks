// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'page_hierarchy.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PageHierarchy {

/// Number of hierarchy blocks on this page
@JsonKey(name: 'block_count') int get blockCount;/// Hierarchical blocks with heading levels
 List<HierarchicalBlock>? get blocks;
/// Create a copy of PageHierarchy
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PageHierarchyCopyWith<PageHierarchy> get copyWith => _$PageHierarchyCopyWithImpl<PageHierarchy>(this as PageHierarchy, _$identity);

  /// Serializes this PageHierarchy to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PageHierarchy&&(identical(other.blockCount, blockCount) || other.blockCount == blockCount)&&const DeepCollectionEquality().equals(other.blocks, blocks));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,blockCount,const DeepCollectionEquality().hash(blocks));

@override
String toString() {
  return 'PageHierarchy(blockCount: $blockCount, blocks: $blocks)';
}


}

/// @nodoc
abstract mixin class $PageHierarchyCopyWith<$Res>  {
  factory $PageHierarchyCopyWith(PageHierarchy value, $Res Function(PageHierarchy) _then) = _$PageHierarchyCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'block_count') int blockCount, List<HierarchicalBlock>? blocks
});




}
/// @nodoc
class _$PageHierarchyCopyWithImpl<$Res>
    implements $PageHierarchyCopyWith<$Res> {
  _$PageHierarchyCopyWithImpl(this._self, this._then);

  final PageHierarchy _self;
  final $Res Function(PageHierarchy) _then;

/// Create a copy of PageHierarchy
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? blockCount = null,Object? blocks = freezed,}) {
  return _then(_self.copyWith(
blockCount: null == blockCount ? _self.blockCount : blockCount // ignore: cast_nullable_to_non_nullable
as int,blocks: freezed == blocks ? _self.blocks : blocks // ignore: cast_nullable_to_non_nullable
as List<HierarchicalBlock>?,
  ));
}

}


/// Adds pattern-matching-related methods to [PageHierarchy].
extension PageHierarchyPatterns on PageHierarchy {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PageHierarchy value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PageHierarchy() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PageHierarchy value)  $default,){
final _that = this;
switch (_that) {
case _PageHierarchy():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PageHierarchy value)?  $default,){
final _that = this;
switch (_that) {
case _PageHierarchy() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'block_count')  int blockCount,  List<HierarchicalBlock>? blocks)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PageHierarchy() when $default != null:
return $default(_that.blockCount,_that.blocks);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'block_count')  int blockCount,  List<HierarchicalBlock>? blocks)  $default,) {final _that = this;
switch (_that) {
case _PageHierarchy():
return $default(_that.blockCount,_that.blocks);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'block_count')  int blockCount,  List<HierarchicalBlock>? blocks)?  $default,) {final _that = this;
switch (_that) {
case _PageHierarchy() when $default != null:
return $default(_that.blockCount,_that.blocks);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PageHierarchy implements PageHierarchy {
  const _PageHierarchy({@JsonKey(name: 'block_count') required this.blockCount, final  List<HierarchicalBlock>? blocks}): _blocks = blocks;
  factory _PageHierarchy.fromJson(Map<String, dynamic> json) => _$PageHierarchyFromJson(json);

/// Number of hierarchy blocks on this page
@override@JsonKey(name: 'block_count') final  int blockCount;
/// Hierarchical blocks with heading levels
 final  List<HierarchicalBlock>? _blocks;
/// Hierarchical blocks with heading levels
@override List<HierarchicalBlock>? get blocks {
  final value = _blocks;
  if (value == null) return null;
  if (_blocks is EqualUnmodifiableListView) return _blocks;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}


/// Create a copy of PageHierarchy
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PageHierarchyCopyWith<_PageHierarchy> get copyWith => __$PageHierarchyCopyWithImpl<_PageHierarchy>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PageHierarchyToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PageHierarchy&&(identical(other.blockCount, blockCount) || other.blockCount == blockCount)&&const DeepCollectionEquality().equals(other._blocks, _blocks));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,blockCount,const DeepCollectionEquality().hash(_blocks));

@override
String toString() {
  return 'PageHierarchy(blockCount: $blockCount, blocks: $blocks)';
}


}

/// @nodoc
abstract mixin class _$PageHierarchyCopyWith<$Res> implements $PageHierarchyCopyWith<$Res> {
  factory _$PageHierarchyCopyWith(_PageHierarchy value, $Res Function(_PageHierarchy) _then) = __$PageHierarchyCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'block_count') int blockCount, List<HierarchicalBlock>? blocks
});




}
/// @nodoc
class __$PageHierarchyCopyWithImpl<$Res>
    implements _$PageHierarchyCopyWith<$Res> {
  __$PageHierarchyCopyWithImpl(this._self, this._then);

  final _PageHierarchy _self;
  final $Res Function(_PageHierarchy) _then;

/// Create a copy of PageHierarchy
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? blockCount = null,Object? blocks = freezed,}) {
  return _then(_PageHierarchy(
blockCount: null == blockCount ? _self.blockCount : blockCount // ignore: cast_nullable_to_non_nullable
as int,blocks: freezed == blocks ? _self._blocks : blocks // ignore: cast_nullable_to_non_nullable
as List<HierarchicalBlock>?,
  ));
}


}

// dart format on
