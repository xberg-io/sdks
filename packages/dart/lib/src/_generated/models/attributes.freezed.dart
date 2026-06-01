// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'attributes.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Attributes {

/// CSS classes (.class1 .class2)
 List<String>? get classes;/// Element ID (#identifier)
 String? get id;/// Key-value pairs (key="value")
@JsonKey(name: 'key_values') List<List<String>>? get keyValues;
/// Create a copy of Attributes
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AttributesCopyWith<Attributes> get copyWith => _$AttributesCopyWithImpl<Attributes>(this as Attributes, _$identity);

  /// Serializes this Attributes to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Attributes&&const DeepCollectionEquality().equals(other.classes, classes)&&(identical(other.id, id) || other.id == id)&&const DeepCollectionEquality().equals(other.keyValues, keyValues));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(classes),id,const DeepCollectionEquality().hash(keyValues));

@override
String toString() {
  return 'Attributes(classes: $classes, id: $id, keyValues: $keyValues)';
}


}

/// @nodoc
abstract mixin class $AttributesCopyWith<$Res>  {
  factory $AttributesCopyWith(Attributes value, $Res Function(Attributes) _then) = _$AttributesCopyWithImpl;
@useResult
$Res call({
 List<String>? classes, String? id,@JsonKey(name: 'key_values') List<List<String>>? keyValues
});




}
/// @nodoc
class _$AttributesCopyWithImpl<$Res>
    implements $AttributesCopyWith<$Res> {
  _$AttributesCopyWithImpl(this._self, this._then);

  final Attributes _self;
  final $Res Function(Attributes) _then;

/// Create a copy of Attributes
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? classes = freezed,Object? id = freezed,Object? keyValues = freezed,}) {
  return _then(_self.copyWith(
classes: freezed == classes ? _self.classes : classes // ignore: cast_nullable_to_non_nullable
as List<String>?,id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,keyValues: freezed == keyValues ? _self.keyValues : keyValues // ignore: cast_nullable_to_non_nullable
as List<List<String>>?,
  ));
}

}


/// Adds pattern-matching-related methods to [Attributes].
extension AttributesPatterns on Attributes {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Attributes value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Attributes() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Attributes value)  $default,){
final _that = this;
switch (_that) {
case _Attributes():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Attributes value)?  $default,){
final _that = this;
switch (_that) {
case _Attributes() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<String>? classes,  String? id, @JsonKey(name: 'key_values')  List<List<String>>? keyValues)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Attributes() when $default != null:
return $default(_that.classes,_that.id,_that.keyValues);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<String>? classes,  String? id, @JsonKey(name: 'key_values')  List<List<String>>? keyValues)  $default,) {final _that = this;
switch (_that) {
case _Attributes():
return $default(_that.classes,_that.id,_that.keyValues);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<String>? classes,  String? id, @JsonKey(name: 'key_values')  List<List<String>>? keyValues)?  $default,) {final _that = this;
switch (_that) {
case _Attributes() when $default != null:
return $default(_that.classes,_that.id,_that.keyValues);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Attributes implements Attributes {
  const _Attributes({final  List<String>? classes, this.id, @JsonKey(name: 'key_values') final  List<List<String>>? keyValues}): _classes = classes,_keyValues = keyValues;
  factory _Attributes.fromJson(Map<String, dynamic> json) => _$AttributesFromJson(json);

/// CSS classes (.class1 .class2)
 final  List<String>? _classes;
/// CSS classes (.class1 .class2)
@override List<String>? get classes {
  final value = _classes;
  if (value == null) return null;
  if (_classes is EqualUnmodifiableListView) return _classes;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

/// Element ID (#identifier)
@override final  String? id;
/// Key-value pairs (key="value")
 final  List<List<String>>? _keyValues;
/// Key-value pairs (key="value")
@override@JsonKey(name: 'key_values') List<List<String>>? get keyValues {
  final value = _keyValues;
  if (value == null) return null;
  if (_keyValues is EqualUnmodifiableListView) return _keyValues;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}


/// Create a copy of Attributes
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AttributesCopyWith<_Attributes> get copyWith => __$AttributesCopyWithImpl<_Attributes>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AttributesToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Attributes&&const DeepCollectionEquality().equals(other._classes, _classes)&&(identical(other.id, id) || other.id == id)&&const DeepCollectionEquality().equals(other._keyValues, _keyValues));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_classes),id,const DeepCollectionEquality().hash(_keyValues));

@override
String toString() {
  return 'Attributes(classes: $classes, id: $id, keyValues: $keyValues)';
}


}

/// @nodoc
abstract mixin class _$AttributesCopyWith<$Res> implements $AttributesCopyWith<$Res> {
  factory _$AttributesCopyWith(_Attributes value, $Res Function(_Attributes) _then) = __$AttributesCopyWithImpl;
@override @useResult
$Res call({
 List<String>? classes, String? id,@JsonKey(name: 'key_values') List<List<String>>? keyValues
});




}
/// @nodoc
class __$AttributesCopyWithImpl<$Res>
    implements _$AttributesCopyWith<$Res> {
  __$AttributesCopyWithImpl(this._self, this._then);

  final _Attributes _self;
  final $Res Function(_Attributes) _then;

/// Create a copy of Attributes
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? classes = freezed,Object? id = freezed,Object? keyValues = freezed,}) {
  return _then(_Attributes(
classes: freezed == classes ? _self._classes : classes // ignore: cast_nullable_to_non_nullable
as List<String>?,id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,keyValues: freezed == keyValues ? _self._keyValues : keyValues // ignore: cast_nullable_to_non_nullable
as List<List<String>>?,
  ));
}


}

// dart format on
