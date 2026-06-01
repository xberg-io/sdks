// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'revision_delta.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$RevisionDelta {

/// Line-level content changes for this revision.
 List<DiffLine> get content;/// Cell-level table changes for this revision.
@JsonKey(name: 'table_changes') List<CellChange> get tableChanges;
/// Create a copy of RevisionDelta
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RevisionDeltaCopyWith<RevisionDelta> get copyWith => _$RevisionDeltaCopyWithImpl<RevisionDelta>(this as RevisionDelta, _$identity);

  /// Serializes this RevisionDelta to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RevisionDelta&&const DeepCollectionEquality().equals(other.content, content)&&const DeepCollectionEquality().equals(other.tableChanges, tableChanges));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(content),const DeepCollectionEquality().hash(tableChanges));

@override
String toString() {
  return 'RevisionDelta(content: $content, tableChanges: $tableChanges)';
}


}

/// @nodoc
abstract mixin class $RevisionDeltaCopyWith<$Res>  {
  factory $RevisionDeltaCopyWith(RevisionDelta value, $Res Function(RevisionDelta) _then) = _$RevisionDeltaCopyWithImpl;
@useResult
$Res call({
 List<DiffLine> content,@JsonKey(name: 'table_changes') List<CellChange> tableChanges
});




}
/// @nodoc
class _$RevisionDeltaCopyWithImpl<$Res>
    implements $RevisionDeltaCopyWith<$Res> {
  _$RevisionDeltaCopyWithImpl(this._self, this._then);

  final RevisionDelta _self;
  final $Res Function(RevisionDelta) _then;

/// Create a copy of RevisionDelta
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? content = null,Object? tableChanges = null,}) {
  return _then(_self.copyWith(
content: null == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as List<DiffLine>,tableChanges: null == tableChanges ? _self.tableChanges : tableChanges // ignore: cast_nullable_to_non_nullable
as List<CellChange>,
  ));
}

}


/// Adds pattern-matching-related methods to [RevisionDelta].
extension RevisionDeltaPatterns on RevisionDelta {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RevisionDelta value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RevisionDelta() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RevisionDelta value)  $default,){
final _that = this;
switch (_that) {
case _RevisionDelta():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RevisionDelta value)?  $default,){
final _that = this;
switch (_that) {
case _RevisionDelta() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<DiffLine> content, @JsonKey(name: 'table_changes')  List<CellChange> tableChanges)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RevisionDelta() when $default != null:
return $default(_that.content,_that.tableChanges);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<DiffLine> content, @JsonKey(name: 'table_changes')  List<CellChange> tableChanges)  $default,) {final _that = this;
switch (_that) {
case _RevisionDelta():
return $default(_that.content,_that.tableChanges);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<DiffLine> content, @JsonKey(name: 'table_changes')  List<CellChange> tableChanges)?  $default,) {final _that = this;
switch (_that) {
case _RevisionDelta() when $default != null:
return $default(_that.content,_that.tableChanges);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _RevisionDelta implements RevisionDelta {
  const _RevisionDelta({required final  List<DiffLine> content, @JsonKey(name: 'table_changes') required final  List<CellChange> tableChanges}): _content = content,_tableChanges = tableChanges;
  factory _RevisionDelta.fromJson(Map<String, dynamic> json) => _$RevisionDeltaFromJson(json);

/// Line-level content changes for this revision.
 final  List<DiffLine> _content;
/// Line-level content changes for this revision.
@override List<DiffLine> get content {
  if (_content is EqualUnmodifiableListView) return _content;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_content);
}

/// Cell-level table changes for this revision.
 final  List<CellChange> _tableChanges;
/// Cell-level table changes for this revision.
@override@JsonKey(name: 'table_changes') List<CellChange> get tableChanges {
  if (_tableChanges is EqualUnmodifiableListView) return _tableChanges;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_tableChanges);
}


/// Create a copy of RevisionDelta
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RevisionDeltaCopyWith<_RevisionDelta> get copyWith => __$RevisionDeltaCopyWithImpl<_RevisionDelta>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RevisionDeltaToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RevisionDelta&&const DeepCollectionEquality().equals(other._content, _content)&&const DeepCollectionEquality().equals(other._tableChanges, _tableChanges));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_content),const DeepCollectionEquality().hash(_tableChanges));

@override
String toString() {
  return 'RevisionDelta(content: $content, tableChanges: $tableChanges)';
}


}

/// @nodoc
abstract mixin class _$RevisionDeltaCopyWith<$Res> implements $RevisionDeltaCopyWith<$Res> {
  factory _$RevisionDeltaCopyWith(_RevisionDelta value, $Res Function(_RevisionDelta) _then) = __$RevisionDeltaCopyWithImpl;
@override @useResult
$Res call({
 List<DiffLine> content,@JsonKey(name: 'table_changes') List<CellChange> tableChanges
});




}
/// @nodoc
class __$RevisionDeltaCopyWithImpl<$Res>
    implements _$RevisionDeltaCopyWith<$Res> {
  __$RevisionDeltaCopyWithImpl(this._self, this._then);

  final _RevisionDelta _self;
  final $Res Function(_RevisionDelta) _then;

/// Create a copy of RevisionDelta
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? content = null,Object? tableChanges = null,}) {
  return _then(_RevisionDelta(
content: null == content ? _self._content : content // ignore: cast_nullable_to_non_nullable
as List<DiffLine>,tableChanges: null == tableChanges ? _self._tableChanges : tableChanges // ignore: cast_nullable_to_non_nullable
as List<CellChange>,
  ));
}


}

// dart format on
