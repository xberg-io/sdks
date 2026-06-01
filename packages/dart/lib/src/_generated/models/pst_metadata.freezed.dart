// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'pst_metadata.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PstMetadata {

@JsonKey(name: 'message_count') int get messageCount;
/// Create a copy of PstMetadata
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PstMetadataCopyWith<PstMetadata> get copyWith => _$PstMetadataCopyWithImpl<PstMetadata>(this as PstMetadata, _$identity);

  /// Serializes this PstMetadata to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PstMetadata&&(identical(other.messageCount, messageCount) || other.messageCount == messageCount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,messageCount);

@override
String toString() {
  return 'PstMetadata(messageCount: $messageCount)';
}


}

/// @nodoc
abstract mixin class $PstMetadataCopyWith<$Res>  {
  factory $PstMetadataCopyWith(PstMetadata value, $Res Function(PstMetadata) _then) = _$PstMetadataCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'message_count') int messageCount
});




}
/// @nodoc
class _$PstMetadataCopyWithImpl<$Res>
    implements $PstMetadataCopyWith<$Res> {
  _$PstMetadataCopyWithImpl(this._self, this._then);

  final PstMetadata _self;
  final $Res Function(PstMetadata) _then;

/// Create a copy of PstMetadata
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? messageCount = null,}) {
  return _then(_self.copyWith(
messageCount: null == messageCount ? _self.messageCount : messageCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [PstMetadata].
extension PstMetadataPatterns on PstMetadata {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PstMetadata value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PstMetadata() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PstMetadata value)  $default,){
final _that = this;
switch (_that) {
case _PstMetadata():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PstMetadata value)?  $default,){
final _that = this;
switch (_that) {
case _PstMetadata() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'message_count')  int messageCount)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PstMetadata() when $default != null:
return $default(_that.messageCount);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'message_count')  int messageCount)  $default,) {final _that = this;
switch (_that) {
case _PstMetadata():
return $default(_that.messageCount);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'message_count')  int messageCount)?  $default,) {final _that = this;
switch (_that) {
case _PstMetadata() when $default != null:
return $default(_that.messageCount);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PstMetadata implements PstMetadata {
  const _PstMetadata({@JsonKey(name: 'message_count') required this.messageCount});
  factory _PstMetadata.fromJson(Map<String, dynamic> json) => _$PstMetadataFromJson(json);

@override@JsonKey(name: 'message_count') final  int messageCount;

/// Create a copy of PstMetadata
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PstMetadataCopyWith<_PstMetadata> get copyWith => __$PstMetadataCopyWithImpl<_PstMetadata>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PstMetadataToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PstMetadata&&(identical(other.messageCount, messageCount) || other.messageCount == messageCount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,messageCount);

@override
String toString() {
  return 'PstMetadata(messageCount: $messageCount)';
}


}

/// @nodoc
abstract mixin class _$PstMetadataCopyWith<$Res> implements $PstMetadataCopyWith<$Res> {
  factory _$PstMetadataCopyWith(_PstMetadata value, $Res Function(_PstMetadata) _then) = __$PstMetadataCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'message_count') int messageCount
});




}
/// @nodoc
class __$PstMetadataCopyWithImpl<$Res>
    implements _$PstMetadataCopyWith<$Res> {
  __$PstMetadataCopyWithImpl(this._self, this._then);

  final _PstMetadata _self;
  final $Res Function(_PstMetadata) _then;

/// Create a copy of PstMetadata
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? messageCount = null,}) {
  return _then(_PstMetadata(
messageCount: null == messageCount ? _self.messageCount : messageCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
