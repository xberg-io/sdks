// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'xml_metadata.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$XmlMetadata {

/// Total number of XML elements processed
@JsonKey(name: 'element_count') int get elementCount;/// List of unique element tag names (sorted)
@JsonKey(name: 'unique_elements') List<String> get uniqueElements;
/// Create a copy of XmlMetadata
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$XmlMetadataCopyWith<XmlMetadata> get copyWith => _$XmlMetadataCopyWithImpl<XmlMetadata>(this as XmlMetadata, _$identity);

  /// Serializes this XmlMetadata to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is XmlMetadata&&(identical(other.elementCount, elementCount) || other.elementCount == elementCount)&&const DeepCollectionEquality().equals(other.uniqueElements, uniqueElements));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,elementCount,const DeepCollectionEquality().hash(uniqueElements));

@override
String toString() {
  return 'XmlMetadata(elementCount: $elementCount, uniqueElements: $uniqueElements)';
}


}

/// @nodoc
abstract mixin class $XmlMetadataCopyWith<$Res>  {
  factory $XmlMetadataCopyWith(XmlMetadata value, $Res Function(XmlMetadata) _then) = _$XmlMetadataCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'element_count') int elementCount,@JsonKey(name: 'unique_elements') List<String> uniqueElements
});




}
/// @nodoc
class _$XmlMetadataCopyWithImpl<$Res>
    implements $XmlMetadataCopyWith<$Res> {
  _$XmlMetadataCopyWithImpl(this._self, this._then);

  final XmlMetadata _self;
  final $Res Function(XmlMetadata) _then;

/// Create a copy of XmlMetadata
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? elementCount = null,Object? uniqueElements = null,}) {
  return _then(_self.copyWith(
elementCount: null == elementCount ? _self.elementCount : elementCount // ignore: cast_nullable_to_non_nullable
as int,uniqueElements: null == uniqueElements ? _self.uniqueElements : uniqueElements // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}

}


/// Adds pattern-matching-related methods to [XmlMetadata].
extension XmlMetadataPatterns on XmlMetadata {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _XmlMetadata value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _XmlMetadata() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _XmlMetadata value)  $default,){
final _that = this;
switch (_that) {
case _XmlMetadata():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _XmlMetadata value)?  $default,){
final _that = this;
switch (_that) {
case _XmlMetadata() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'element_count')  int elementCount, @JsonKey(name: 'unique_elements')  List<String> uniqueElements)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _XmlMetadata() when $default != null:
return $default(_that.elementCount,_that.uniqueElements);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'element_count')  int elementCount, @JsonKey(name: 'unique_elements')  List<String> uniqueElements)  $default,) {final _that = this;
switch (_that) {
case _XmlMetadata():
return $default(_that.elementCount,_that.uniqueElements);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'element_count')  int elementCount, @JsonKey(name: 'unique_elements')  List<String> uniqueElements)?  $default,) {final _that = this;
switch (_that) {
case _XmlMetadata() when $default != null:
return $default(_that.elementCount,_that.uniqueElements);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _XmlMetadata implements XmlMetadata {
  const _XmlMetadata({@JsonKey(name: 'element_count') required this.elementCount, @JsonKey(name: 'unique_elements') required final  List<String> uniqueElements}): _uniqueElements = uniqueElements;
  factory _XmlMetadata.fromJson(Map<String, dynamic> json) => _$XmlMetadataFromJson(json);

/// Total number of XML elements processed
@override@JsonKey(name: 'element_count') final  int elementCount;
/// List of unique element tag names (sorted)
 final  List<String> _uniqueElements;
/// List of unique element tag names (sorted)
@override@JsonKey(name: 'unique_elements') List<String> get uniqueElements {
  if (_uniqueElements is EqualUnmodifiableListView) return _uniqueElements;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_uniqueElements);
}


/// Create a copy of XmlMetadata
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$XmlMetadataCopyWith<_XmlMetadata> get copyWith => __$XmlMetadataCopyWithImpl<_XmlMetadata>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$XmlMetadataToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _XmlMetadata&&(identical(other.elementCount, elementCount) || other.elementCount == elementCount)&&const DeepCollectionEquality().equals(other._uniqueElements, _uniqueElements));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,elementCount,const DeepCollectionEquality().hash(_uniqueElements));

@override
String toString() {
  return 'XmlMetadata(elementCount: $elementCount, uniqueElements: $uniqueElements)';
}


}

/// @nodoc
abstract mixin class _$XmlMetadataCopyWith<$Res> implements $XmlMetadataCopyWith<$Res> {
  factory _$XmlMetadataCopyWith(_XmlMetadata value, $Res Function(_XmlMetadata) _then) = __$XmlMetadataCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'element_count') int elementCount,@JsonKey(name: 'unique_elements') List<String> uniqueElements
});




}
/// @nodoc
class __$XmlMetadataCopyWithImpl<$Res>
    implements _$XmlMetadataCopyWith<$Res> {
  __$XmlMetadataCopyWithImpl(this._self, this._then);

  final _XmlMetadata _self;
  final $Res Function(_XmlMetadata) _then;

/// Create a copy of XmlMetadata
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? elementCount = null,Object? uniqueElements = null,}) {
  return _then(_XmlMetadata(
elementCount: null == elementCount ? _self.elementCount : elementCount // ignore: cast_nullable_to_non_nullable
as int,uniqueElements: null == uniqueElements ? _self._uniqueElements : uniqueElements // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}


}

// dart format on
