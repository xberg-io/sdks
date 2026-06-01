// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'document_relationship.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$DocumentRelationship {

/// Semantic kind of the relationship.
 RelationshipKind get kind;/// Source node index (the referencing node).
 NodeIndex get source;/// Target node index (the referenced node).
 NodeIndex get target;
/// Create a copy of DocumentRelationship
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DocumentRelationshipCopyWith<DocumentRelationship> get copyWith => _$DocumentRelationshipCopyWithImpl<DocumentRelationship>(this as DocumentRelationship, _$identity);

  /// Serializes this DocumentRelationship to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DocumentRelationship&&(identical(other.kind, kind) || other.kind == kind)&&(identical(other.source, source) || other.source == source)&&(identical(other.target, target) || other.target == target));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,kind,source,target);

@override
String toString() {
  return 'DocumentRelationship(kind: $kind, source: $source, target: $target)';
}


}

/// @nodoc
abstract mixin class $DocumentRelationshipCopyWith<$Res>  {
  factory $DocumentRelationshipCopyWith(DocumentRelationship value, $Res Function(DocumentRelationship) _then) = _$DocumentRelationshipCopyWithImpl;
@useResult
$Res call({
 RelationshipKind kind, NodeIndex source, NodeIndex target
});




}
/// @nodoc
class _$DocumentRelationshipCopyWithImpl<$Res>
    implements $DocumentRelationshipCopyWith<$Res> {
  _$DocumentRelationshipCopyWithImpl(this._self, this._then);

  final DocumentRelationship _self;
  final $Res Function(DocumentRelationship) _then;

/// Create a copy of DocumentRelationship
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? kind = null,Object? source = null,Object? target = null,}) {
  return _then(_self.copyWith(
kind: null == kind ? _self.kind : kind // ignore: cast_nullable_to_non_nullable
as RelationshipKind,source: null == source ? _self.source : source // ignore: cast_nullable_to_non_nullable
as NodeIndex,target: null == target ? _self.target : target // ignore: cast_nullable_to_non_nullable
as NodeIndex,
  ));
}

}


/// Adds pattern-matching-related methods to [DocumentRelationship].
extension DocumentRelationshipPatterns on DocumentRelationship {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DocumentRelationship value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DocumentRelationship() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DocumentRelationship value)  $default,){
final _that = this;
switch (_that) {
case _DocumentRelationship():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DocumentRelationship value)?  $default,){
final _that = this;
switch (_that) {
case _DocumentRelationship() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( RelationshipKind kind,  NodeIndex source,  NodeIndex target)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DocumentRelationship() when $default != null:
return $default(_that.kind,_that.source,_that.target);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( RelationshipKind kind,  NodeIndex source,  NodeIndex target)  $default,) {final _that = this;
switch (_that) {
case _DocumentRelationship():
return $default(_that.kind,_that.source,_that.target);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( RelationshipKind kind,  NodeIndex source,  NodeIndex target)?  $default,) {final _that = this;
switch (_that) {
case _DocumentRelationship() when $default != null:
return $default(_that.kind,_that.source,_that.target);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _DocumentRelationship implements DocumentRelationship {
  const _DocumentRelationship({required this.kind, required this.source, required this.target});
  factory _DocumentRelationship.fromJson(Map<String, dynamic> json) => _$DocumentRelationshipFromJson(json);

/// Semantic kind of the relationship.
@override final  RelationshipKind kind;
/// Source node index (the referencing node).
@override final  NodeIndex source;
/// Target node index (the referenced node).
@override final  NodeIndex target;

/// Create a copy of DocumentRelationship
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DocumentRelationshipCopyWith<_DocumentRelationship> get copyWith => __$DocumentRelationshipCopyWithImpl<_DocumentRelationship>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DocumentRelationshipToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DocumentRelationship&&(identical(other.kind, kind) || other.kind == kind)&&(identical(other.source, source) || other.source == source)&&(identical(other.target, target) || other.target == target));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,kind,source,target);

@override
String toString() {
  return 'DocumentRelationship(kind: $kind, source: $source, target: $target)';
}


}

/// @nodoc
abstract mixin class _$DocumentRelationshipCopyWith<$Res> implements $DocumentRelationshipCopyWith<$Res> {
  factory _$DocumentRelationshipCopyWith(_DocumentRelationship value, $Res Function(_DocumentRelationship) _then) = __$DocumentRelationshipCopyWithImpl;
@override @useResult
$Res call({
 RelationshipKind kind, NodeIndex source, NodeIndex target
});




}
/// @nodoc
class __$DocumentRelationshipCopyWithImpl<$Res>
    implements _$DocumentRelationshipCopyWith<$Res> {
  __$DocumentRelationshipCopyWithImpl(this._self, this._then);

  final _DocumentRelationship _self;
  final $Res Function(_DocumentRelationship) _then;

/// Create a copy of DocumentRelationship
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? kind = null,Object? source = null,Object? target = null,}) {
  return _then(_DocumentRelationship(
kind: null == kind ? _self.kind : kind // ignore: cast_nullable_to_non_nullable
as RelationshipKind,source: null == source ? _self.source : source // ignore: cast_nullable_to_non_nullable
as NodeIndex,target: null == target ? _self.target : target // ignore: cast_nullable_to_non_nullable
as NodeIndex,
  ));
}


}

// dart format on
