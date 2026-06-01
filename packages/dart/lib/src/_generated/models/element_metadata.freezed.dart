// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'element_metadata.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ElementMetadata {

/// Additional custom metadata
 Map<String, String> get additional;/// Bounding box coordinates if available
 BoundingBox? get coordinates;/// Position index in the element sequence
@JsonKey(name: 'element_index') int? get elementIndex;/// Source filename or document name
 String? get filename;/// Page number (1-indexed)
@JsonKey(name: 'page_number') int? get pageNumber;
/// Create a copy of ElementMetadata
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ElementMetadataCopyWith<ElementMetadata> get copyWith => _$ElementMetadataCopyWithImpl<ElementMetadata>(this as ElementMetadata, _$identity);

  /// Serializes this ElementMetadata to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ElementMetadata&&const DeepCollectionEquality().equals(other.additional, additional)&&(identical(other.coordinates, coordinates) || other.coordinates == coordinates)&&(identical(other.elementIndex, elementIndex) || other.elementIndex == elementIndex)&&(identical(other.filename, filename) || other.filename == filename)&&(identical(other.pageNumber, pageNumber) || other.pageNumber == pageNumber));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(additional),coordinates,elementIndex,filename,pageNumber);

@override
String toString() {
  return 'ElementMetadata(additional: $additional, coordinates: $coordinates, elementIndex: $elementIndex, filename: $filename, pageNumber: $pageNumber)';
}


}

/// @nodoc
abstract mixin class $ElementMetadataCopyWith<$Res>  {
  factory $ElementMetadataCopyWith(ElementMetadata value, $Res Function(ElementMetadata) _then) = _$ElementMetadataCopyWithImpl;
@useResult
$Res call({
 Map<String, String> additional, BoundingBox? coordinates,@JsonKey(name: 'element_index') int? elementIndex, String? filename,@JsonKey(name: 'page_number') int? pageNumber
});


$BoundingBoxCopyWith<$Res>? get coordinates;

}
/// @nodoc
class _$ElementMetadataCopyWithImpl<$Res>
    implements $ElementMetadataCopyWith<$Res> {
  _$ElementMetadataCopyWithImpl(this._self, this._then);

  final ElementMetadata _self;
  final $Res Function(ElementMetadata) _then;

/// Create a copy of ElementMetadata
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? additional = null,Object? coordinates = freezed,Object? elementIndex = freezed,Object? filename = freezed,Object? pageNumber = freezed,}) {
  return _then(_self.copyWith(
additional: null == additional ? _self.additional : additional // ignore: cast_nullable_to_non_nullable
as Map<String, String>,coordinates: freezed == coordinates ? _self.coordinates : coordinates // ignore: cast_nullable_to_non_nullable
as BoundingBox?,elementIndex: freezed == elementIndex ? _self.elementIndex : elementIndex // ignore: cast_nullable_to_non_nullable
as int?,filename: freezed == filename ? _self.filename : filename // ignore: cast_nullable_to_non_nullable
as String?,pageNumber: freezed == pageNumber ? _self.pageNumber : pageNumber // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}
/// Create a copy of ElementMetadata
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BoundingBoxCopyWith<$Res>? get coordinates {
    if (_self.coordinates == null) {
    return null;
  }

  return $BoundingBoxCopyWith<$Res>(_self.coordinates!, (value) {
    return _then(_self.copyWith(coordinates: value));
  });
}
}


/// Adds pattern-matching-related methods to [ElementMetadata].
extension ElementMetadataPatterns on ElementMetadata {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ElementMetadata value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ElementMetadata() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ElementMetadata value)  $default,){
final _that = this;
switch (_that) {
case _ElementMetadata():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ElementMetadata value)?  $default,){
final _that = this;
switch (_that) {
case _ElementMetadata() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( Map<String, String> additional,  BoundingBox? coordinates, @JsonKey(name: 'element_index')  int? elementIndex,  String? filename, @JsonKey(name: 'page_number')  int? pageNumber)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ElementMetadata() when $default != null:
return $default(_that.additional,_that.coordinates,_that.elementIndex,_that.filename,_that.pageNumber);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( Map<String, String> additional,  BoundingBox? coordinates, @JsonKey(name: 'element_index')  int? elementIndex,  String? filename, @JsonKey(name: 'page_number')  int? pageNumber)  $default,) {final _that = this;
switch (_that) {
case _ElementMetadata():
return $default(_that.additional,_that.coordinates,_that.elementIndex,_that.filename,_that.pageNumber);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( Map<String, String> additional,  BoundingBox? coordinates, @JsonKey(name: 'element_index')  int? elementIndex,  String? filename, @JsonKey(name: 'page_number')  int? pageNumber)?  $default,) {final _that = this;
switch (_that) {
case _ElementMetadata() when $default != null:
return $default(_that.additional,_that.coordinates,_that.elementIndex,_that.filename,_that.pageNumber);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ElementMetadata implements ElementMetadata {
  const _ElementMetadata({required final  Map<String, String> additional, this.coordinates, @JsonKey(name: 'element_index') this.elementIndex, this.filename, @JsonKey(name: 'page_number') this.pageNumber}): _additional = additional;
  factory _ElementMetadata.fromJson(Map<String, dynamic> json) => _$ElementMetadataFromJson(json);

/// Additional custom metadata
 final  Map<String, String> _additional;
/// Additional custom metadata
@override Map<String, String> get additional {
  if (_additional is EqualUnmodifiableMapView) return _additional;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_additional);
}

/// Bounding box coordinates if available
@override final  BoundingBox? coordinates;
/// Position index in the element sequence
@override@JsonKey(name: 'element_index') final  int? elementIndex;
/// Source filename or document name
@override final  String? filename;
/// Page number (1-indexed)
@override@JsonKey(name: 'page_number') final  int? pageNumber;

/// Create a copy of ElementMetadata
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ElementMetadataCopyWith<_ElementMetadata> get copyWith => __$ElementMetadataCopyWithImpl<_ElementMetadata>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ElementMetadataToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ElementMetadata&&const DeepCollectionEquality().equals(other._additional, _additional)&&(identical(other.coordinates, coordinates) || other.coordinates == coordinates)&&(identical(other.elementIndex, elementIndex) || other.elementIndex == elementIndex)&&(identical(other.filename, filename) || other.filename == filename)&&(identical(other.pageNumber, pageNumber) || other.pageNumber == pageNumber));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_additional),coordinates,elementIndex,filename,pageNumber);

@override
String toString() {
  return 'ElementMetadata(additional: $additional, coordinates: $coordinates, elementIndex: $elementIndex, filename: $filename, pageNumber: $pageNumber)';
}


}

/// @nodoc
abstract mixin class _$ElementMetadataCopyWith<$Res> implements $ElementMetadataCopyWith<$Res> {
  factory _$ElementMetadataCopyWith(_ElementMetadata value, $Res Function(_ElementMetadata) _then) = __$ElementMetadataCopyWithImpl;
@override @useResult
$Res call({
 Map<String, String> additional, BoundingBox? coordinates,@JsonKey(name: 'element_index') int? elementIndex, String? filename,@JsonKey(name: 'page_number') int? pageNumber
});


@override $BoundingBoxCopyWith<$Res>? get coordinates;

}
/// @nodoc
class __$ElementMetadataCopyWithImpl<$Res>
    implements _$ElementMetadataCopyWith<$Res> {
  __$ElementMetadataCopyWithImpl(this._self, this._then);

  final _ElementMetadata _self;
  final $Res Function(_ElementMetadata) _then;

/// Create a copy of ElementMetadata
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? additional = null,Object? coordinates = freezed,Object? elementIndex = freezed,Object? filename = freezed,Object? pageNumber = freezed,}) {
  return _then(_ElementMetadata(
additional: null == additional ? _self._additional : additional // ignore: cast_nullable_to_non_nullable
as Map<String, String>,coordinates: freezed == coordinates ? _self.coordinates : coordinates // ignore: cast_nullable_to_non_nullable
as BoundingBox?,elementIndex: freezed == elementIndex ? _self.elementIndex : elementIndex // ignore: cast_nullable_to_non_nullable
as int?,filename: freezed == filename ? _self.filename : filename // ignore: cast_nullable_to_non_nullable
as String?,pageNumber: freezed == pageNumber ? _self.pageNumber : pageNumber // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

/// Create a copy of ElementMetadata
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BoundingBoxCopyWith<$Res>? get coordinates {
    if (_self.coordinates == null) {
    return null;
  }

  return $BoundingBoxCopyWith<$Res>(_self.coordinates!, (value) {
    return _then(_self.copyWith(coordinates: value));
  });
}
}

// dart format on
