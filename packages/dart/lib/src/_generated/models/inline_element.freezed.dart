// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'inline_element.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$InlineElement {

/// Text content
 String get content;/// Type of inline element
@JsonKey(name: 'element_type') InlineType get elementType;/// Element attributes
 Attributes? get attributes;/// Additional metadata (e.g., href for links, src/alt for images)
 Map<String, String>? get metadata;
/// Create a copy of InlineElement
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$InlineElementCopyWith<InlineElement> get copyWith => _$InlineElementCopyWithImpl<InlineElement>(this as InlineElement, _$identity);

  /// Serializes this InlineElement to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is InlineElement&&(identical(other.content, content) || other.content == content)&&(identical(other.elementType, elementType) || other.elementType == elementType)&&(identical(other.attributes, attributes) || other.attributes == attributes)&&const DeepCollectionEquality().equals(other.metadata, metadata));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,content,elementType,attributes,const DeepCollectionEquality().hash(metadata));

@override
String toString() {
  return 'InlineElement(content: $content, elementType: $elementType, attributes: $attributes, metadata: $metadata)';
}


}

/// @nodoc
abstract mixin class $InlineElementCopyWith<$Res>  {
  factory $InlineElementCopyWith(InlineElement value, $Res Function(InlineElement) _then) = _$InlineElementCopyWithImpl;
@useResult
$Res call({
 String content,@JsonKey(name: 'element_type') InlineType elementType, Attributes? attributes, Map<String, String>? metadata
});


$AttributesCopyWith<$Res>? get attributes;

}
/// @nodoc
class _$InlineElementCopyWithImpl<$Res>
    implements $InlineElementCopyWith<$Res> {
  _$InlineElementCopyWithImpl(this._self, this._then);

  final InlineElement _self;
  final $Res Function(InlineElement) _then;

/// Create a copy of InlineElement
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? content = null,Object? elementType = null,Object? attributes = freezed,Object? metadata = freezed,}) {
  return _then(_self.copyWith(
content: null == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as String,elementType: null == elementType ? _self.elementType : elementType // ignore: cast_nullable_to_non_nullable
as InlineType,attributes: freezed == attributes ? _self.attributes : attributes // ignore: cast_nullable_to_non_nullable
as Attributes?,metadata: freezed == metadata ? _self.metadata : metadata // ignore: cast_nullable_to_non_nullable
as Map<String, String>?,
  ));
}
/// Create a copy of InlineElement
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


/// Adds pattern-matching-related methods to [InlineElement].
extension InlineElementPatterns on InlineElement {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _InlineElement value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _InlineElement() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _InlineElement value)  $default,){
final _that = this;
switch (_that) {
case _InlineElement():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _InlineElement value)?  $default,){
final _that = this;
switch (_that) {
case _InlineElement() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String content, @JsonKey(name: 'element_type')  InlineType elementType,  Attributes? attributes,  Map<String, String>? metadata)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _InlineElement() when $default != null:
return $default(_that.content,_that.elementType,_that.attributes,_that.metadata);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String content, @JsonKey(name: 'element_type')  InlineType elementType,  Attributes? attributes,  Map<String, String>? metadata)  $default,) {final _that = this;
switch (_that) {
case _InlineElement():
return $default(_that.content,_that.elementType,_that.attributes,_that.metadata);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String content, @JsonKey(name: 'element_type')  InlineType elementType,  Attributes? attributes,  Map<String, String>? metadata)?  $default,) {final _that = this;
switch (_that) {
case _InlineElement() when $default != null:
return $default(_that.content,_that.elementType,_that.attributes,_that.metadata);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _InlineElement implements InlineElement {
  const _InlineElement({required this.content, @JsonKey(name: 'element_type') required this.elementType, this.attributes, final  Map<String, String>? metadata}): _metadata = metadata;
  factory _InlineElement.fromJson(Map<String, dynamic> json) => _$InlineElementFromJson(json);

/// Text content
@override final  String content;
/// Type of inline element
@override@JsonKey(name: 'element_type') final  InlineType elementType;
/// Element attributes
@override final  Attributes? attributes;
/// Additional metadata (e.g., href for links, src/alt for images)
 final  Map<String, String>? _metadata;
/// Additional metadata (e.g., href for links, src/alt for images)
@override Map<String, String>? get metadata {
  final value = _metadata;
  if (value == null) return null;
  if (_metadata is EqualUnmodifiableMapView) return _metadata;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}


/// Create a copy of InlineElement
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$InlineElementCopyWith<_InlineElement> get copyWith => __$InlineElementCopyWithImpl<_InlineElement>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$InlineElementToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _InlineElement&&(identical(other.content, content) || other.content == content)&&(identical(other.elementType, elementType) || other.elementType == elementType)&&(identical(other.attributes, attributes) || other.attributes == attributes)&&const DeepCollectionEquality().equals(other._metadata, _metadata));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,content,elementType,attributes,const DeepCollectionEquality().hash(_metadata));

@override
String toString() {
  return 'InlineElement(content: $content, elementType: $elementType, attributes: $attributes, metadata: $metadata)';
}


}

/// @nodoc
abstract mixin class _$InlineElementCopyWith<$Res> implements $InlineElementCopyWith<$Res> {
  factory _$InlineElementCopyWith(_InlineElement value, $Res Function(_InlineElement) _then) = __$InlineElementCopyWithImpl;
@override @useResult
$Res call({
 String content,@JsonKey(name: 'element_type') InlineType elementType, Attributes? attributes, Map<String, String>? metadata
});


@override $AttributesCopyWith<$Res>? get attributes;

}
/// @nodoc
class __$InlineElementCopyWithImpl<$Res>
    implements _$InlineElementCopyWith<$Res> {
  __$InlineElementCopyWithImpl(this._self, this._then);

  final _InlineElement _self;
  final $Res Function(_InlineElement) _then;

/// Create a copy of InlineElement
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? content = null,Object? elementType = null,Object? attributes = freezed,Object? metadata = freezed,}) {
  return _then(_InlineElement(
content: null == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as String,elementType: null == elementType ? _self.elementType : elementType // ignore: cast_nullable_to_non_nullable
as InlineType,attributes: freezed == attributes ? _self.attributes : attributes // ignore: cast_nullable_to_non_nullable
as Attributes?,metadata: freezed == metadata ? _self._metadata : metadata // ignore: cast_nullable_to_non_nullable
as Map<String, String>?,
  ));
}

/// Create a copy of InlineElement
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
