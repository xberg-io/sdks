// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'element.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Element {

/// Unique element identifier
@JsonKey(name: 'element_id') ElementId get elementId;/// Semantic type of this element
@JsonKey(name: 'element_type') ElementType get elementType;/// Metadata about the element
 ElementMetadata get metadata;/// Text content of the element
 String get text;
/// Create a copy of Element
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ElementCopyWith<Element> get copyWith => _$ElementCopyWithImpl<Element>(this as Element, _$identity);

  /// Serializes this Element to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Element&&(identical(other.elementId, elementId) || other.elementId == elementId)&&(identical(other.elementType, elementType) || other.elementType == elementType)&&(identical(other.metadata, metadata) || other.metadata == metadata)&&(identical(other.text, text) || other.text == text));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,elementId,elementType,metadata,text);

@override
String toString() {
  return 'Element(elementId: $elementId, elementType: $elementType, metadata: $metadata, text: $text)';
}


}

/// @nodoc
abstract mixin class $ElementCopyWith<$Res>  {
  factory $ElementCopyWith(Element value, $Res Function(Element) _then) = _$ElementCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'element_id') ElementId elementId,@JsonKey(name: 'element_type') ElementType elementType, ElementMetadata metadata, String text
});


$ElementMetadataCopyWith<$Res> get metadata;

}
/// @nodoc
class _$ElementCopyWithImpl<$Res>
    implements $ElementCopyWith<$Res> {
  _$ElementCopyWithImpl(this._self, this._then);

  final Element _self;
  final $Res Function(Element) _then;

/// Create a copy of Element
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? elementId = null,Object? elementType = null,Object? metadata = null,Object? text = null,}) {
  return _then(_self.copyWith(
elementId: null == elementId ? _self.elementId : elementId // ignore: cast_nullable_to_non_nullable
as ElementId,elementType: null == elementType ? _self.elementType : elementType // ignore: cast_nullable_to_non_nullable
as ElementType,metadata: null == metadata ? _self.metadata : metadata // ignore: cast_nullable_to_non_nullable
as ElementMetadata,text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,
  ));
}
/// Create a copy of Element
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ElementMetadataCopyWith<$Res> get metadata {
  
  return $ElementMetadataCopyWith<$Res>(_self.metadata, (value) {
    return _then(_self.copyWith(metadata: value));
  });
}
}


/// Adds pattern-matching-related methods to [Element].
extension ElementPatterns on Element {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Element value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Element() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Element value)  $default,){
final _that = this;
switch (_that) {
case _Element():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Element value)?  $default,){
final _that = this;
switch (_that) {
case _Element() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'element_id')  ElementId elementId, @JsonKey(name: 'element_type')  ElementType elementType,  ElementMetadata metadata,  String text)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Element() when $default != null:
return $default(_that.elementId,_that.elementType,_that.metadata,_that.text);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'element_id')  ElementId elementId, @JsonKey(name: 'element_type')  ElementType elementType,  ElementMetadata metadata,  String text)  $default,) {final _that = this;
switch (_that) {
case _Element():
return $default(_that.elementId,_that.elementType,_that.metadata,_that.text);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'element_id')  ElementId elementId, @JsonKey(name: 'element_type')  ElementType elementType,  ElementMetadata metadata,  String text)?  $default,) {final _that = this;
switch (_that) {
case _Element() when $default != null:
return $default(_that.elementId,_that.elementType,_that.metadata,_that.text);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Element implements Element {
  const _Element({@JsonKey(name: 'element_id') required this.elementId, @JsonKey(name: 'element_type') required this.elementType, required this.metadata, required this.text});
  factory _Element.fromJson(Map<String, dynamic> json) => _$ElementFromJson(json);

/// Unique element identifier
@override@JsonKey(name: 'element_id') final  ElementId elementId;
/// Semantic type of this element
@override@JsonKey(name: 'element_type') final  ElementType elementType;
/// Metadata about the element
@override final  ElementMetadata metadata;
/// Text content of the element
@override final  String text;

/// Create a copy of Element
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ElementCopyWith<_Element> get copyWith => __$ElementCopyWithImpl<_Element>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ElementToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Element&&(identical(other.elementId, elementId) || other.elementId == elementId)&&(identical(other.elementType, elementType) || other.elementType == elementType)&&(identical(other.metadata, metadata) || other.metadata == metadata)&&(identical(other.text, text) || other.text == text));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,elementId,elementType,metadata,text);

@override
String toString() {
  return 'Element(elementId: $elementId, elementType: $elementType, metadata: $metadata, text: $text)';
}


}

/// @nodoc
abstract mixin class _$ElementCopyWith<$Res> implements $ElementCopyWith<$Res> {
  factory _$ElementCopyWith(_Element value, $Res Function(_Element) _then) = __$ElementCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'element_id') ElementId elementId,@JsonKey(name: 'element_type') ElementType elementType, ElementMetadata metadata, String text
});


@override $ElementMetadataCopyWith<$Res> get metadata;

}
/// @nodoc
class __$ElementCopyWithImpl<$Res>
    implements _$ElementCopyWith<$Res> {
  __$ElementCopyWithImpl(this._self, this._then);

  final _Element _self;
  final $Res Function(_Element) _then;

/// Create a copy of Element
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? elementId = null,Object? elementType = null,Object? metadata = null,Object? text = null,}) {
  return _then(_Element(
elementId: null == elementId ? _self.elementId : elementId // ignore: cast_nullable_to_non_nullable
as ElementId,elementType: null == elementType ? _self.elementType : elementType // ignore: cast_nullable_to_non_nullable
as ElementType,metadata: null == metadata ? _self.metadata : metadata // ignore: cast_nullable_to_non_nullable
as ElementMetadata,text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

/// Create a copy of Element
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ElementMetadataCopyWith<$Res> get metadata {
  
  return $ElementMetadataCopyWith<$Res>(_self.metadata, (value) {
    return _then(_self.copyWith(metadata: value));
  });
}
}

// dart format on
