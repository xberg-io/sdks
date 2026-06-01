// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ocr_element.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$OcrElement {

/// Confidence scores for detection and recognition.
 OcrConfidence get confidence;/// Bounding geometry (rectangle or quadrilateral).
 OcrBoundingGeometry get geometry;/// The recognized text content.
 String get text;/// Backend-specific metadata that doesn't fit the unified schema.
@JsonKey(name: 'backend_metadata') Map<String, dynamic>? get backendMetadata;/// Hierarchical level (word, line, block, page).
 OcrElementLevel? get level;/// Page number (1-indexed).
@JsonKey(name: 'page_number') int? get pageNumber;/// Parent element ID for hierarchical relationships.
///
/// Only used for Tesseract output which has word -> line -> block hierarchy.
@JsonKey(name: 'parent_id') String? get parentId;/// Rotation information (if detected).
 OcrRotation? get rotation;
/// Create a copy of OcrElement
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OcrElementCopyWith<OcrElement> get copyWith => _$OcrElementCopyWithImpl<OcrElement>(this as OcrElement, _$identity);

  /// Serializes this OcrElement to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OcrElement&&(identical(other.confidence, confidence) || other.confidence == confidence)&&(identical(other.geometry, geometry) || other.geometry == geometry)&&(identical(other.text, text) || other.text == text)&&const DeepCollectionEquality().equals(other.backendMetadata, backendMetadata)&&(identical(other.level, level) || other.level == level)&&(identical(other.pageNumber, pageNumber) || other.pageNumber == pageNumber)&&(identical(other.parentId, parentId) || other.parentId == parentId)&&(identical(other.rotation, rotation) || other.rotation == rotation));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,confidence,geometry,text,const DeepCollectionEquality().hash(backendMetadata),level,pageNumber,parentId,rotation);

@override
String toString() {
  return 'OcrElement(confidence: $confidence, geometry: $geometry, text: $text, backendMetadata: $backendMetadata, level: $level, pageNumber: $pageNumber, parentId: $parentId, rotation: $rotation)';
}


}

/// @nodoc
abstract mixin class $OcrElementCopyWith<$Res>  {
  factory $OcrElementCopyWith(OcrElement value, $Res Function(OcrElement) _then) = _$OcrElementCopyWithImpl;
@useResult
$Res call({
 OcrConfidence confidence, OcrBoundingGeometry geometry, String text,@JsonKey(name: 'backend_metadata') Map<String, dynamic>? backendMetadata, OcrElementLevel? level,@JsonKey(name: 'page_number') int? pageNumber,@JsonKey(name: 'parent_id') String? parentId, OcrRotation? rotation
});


$OcrConfidenceCopyWith<$Res> get confidence;$OcrBoundingGeometryCopyWith<$Res> get geometry;$OcrRotationCopyWith<$Res>? get rotation;

}
/// @nodoc
class _$OcrElementCopyWithImpl<$Res>
    implements $OcrElementCopyWith<$Res> {
  _$OcrElementCopyWithImpl(this._self, this._then);

  final OcrElement _self;
  final $Res Function(OcrElement) _then;

/// Create a copy of OcrElement
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? confidence = null,Object? geometry = null,Object? text = null,Object? backendMetadata = freezed,Object? level = freezed,Object? pageNumber = freezed,Object? parentId = freezed,Object? rotation = freezed,}) {
  return _then(_self.copyWith(
confidence: null == confidence ? _self.confidence : confidence // ignore: cast_nullable_to_non_nullable
as OcrConfidence,geometry: null == geometry ? _self.geometry : geometry // ignore: cast_nullable_to_non_nullable
as OcrBoundingGeometry,text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,backendMetadata: freezed == backendMetadata ? _self.backendMetadata : backendMetadata // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,level: freezed == level ? _self.level : level // ignore: cast_nullable_to_non_nullable
as OcrElementLevel?,pageNumber: freezed == pageNumber ? _self.pageNumber : pageNumber // ignore: cast_nullable_to_non_nullable
as int?,parentId: freezed == parentId ? _self.parentId : parentId // ignore: cast_nullable_to_non_nullable
as String?,rotation: freezed == rotation ? _self.rotation : rotation // ignore: cast_nullable_to_non_nullable
as OcrRotation?,
  ));
}
/// Create a copy of OcrElement
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$OcrConfidenceCopyWith<$Res> get confidence {
  
  return $OcrConfidenceCopyWith<$Res>(_self.confidence, (value) {
    return _then(_self.copyWith(confidence: value));
  });
}/// Create a copy of OcrElement
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$OcrBoundingGeometryCopyWith<$Res> get geometry {
  
  return $OcrBoundingGeometryCopyWith<$Res>(_self.geometry, (value) {
    return _then(_self.copyWith(geometry: value));
  });
}/// Create a copy of OcrElement
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$OcrRotationCopyWith<$Res>? get rotation {
    if (_self.rotation == null) {
    return null;
  }

  return $OcrRotationCopyWith<$Res>(_self.rotation!, (value) {
    return _then(_self.copyWith(rotation: value));
  });
}
}


/// Adds pattern-matching-related methods to [OcrElement].
extension OcrElementPatterns on OcrElement {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _OcrElement value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _OcrElement() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _OcrElement value)  $default,){
final _that = this;
switch (_that) {
case _OcrElement():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _OcrElement value)?  $default,){
final _that = this;
switch (_that) {
case _OcrElement() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( OcrConfidence confidence,  OcrBoundingGeometry geometry,  String text, @JsonKey(name: 'backend_metadata')  Map<String, dynamic>? backendMetadata,  OcrElementLevel? level, @JsonKey(name: 'page_number')  int? pageNumber, @JsonKey(name: 'parent_id')  String? parentId,  OcrRotation? rotation)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _OcrElement() when $default != null:
return $default(_that.confidence,_that.geometry,_that.text,_that.backendMetadata,_that.level,_that.pageNumber,_that.parentId,_that.rotation);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( OcrConfidence confidence,  OcrBoundingGeometry geometry,  String text, @JsonKey(name: 'backend_metadata')  Map<String, dynamic>? backendMetadata,  OcrElementLevel? level, @JsonKey(name: 'page_number')  int? pageNumber, @JsonKey(name: 'parent_id')  String? parentId,  OcrRotation? rotation)  $default,) {final _that = this;
switch (_that) {
case _OcrElement():
return $default(_that.confidence,_that.geometry,_that.text,_that.backendMetadata,_that.level,_that.pageNumber,_that.parentId,_that.rotation);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( OcrConfidence confidence,  OcrBoundingGeometry geometry,  String text, @JsonKey(name: 'backend_metadata')  Map<String, dynamic>? backendMetadata,  OcrElementLevel? level, @JsonKey(name: 'page_number')  int? pageNumber, @JsonKey(name: 'parent_id')  String? parentId,  OcrRotation? rotation)?  $default,) {final _that = this;
switch (_that) {
case _OcrElement() when $default != null:
return $default(_that.confidence,_that.geometry,_that.text,_that.backendMetadata,_that.level,_that.pageNumber,_that.parentId,_that.rotation);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _OcrElement implements OcrElement {
  const _OcrElement({required this.confidence, required this.geometry, required this.text, @JsonKey(name: 'backend_metadata') final  Map<String, dynamic>? backendMetadata, this.level, @JsonKey(name: 'page_number') this.pageNumber, @JsonKey(name: 'parent_id') this.parentId, this.rotation}): _backendMetadata = backendMetadata;
  factory _OcrElement.fromJson(Map<String, dynamic> json) => _$OcrElementFromJson(json);

/// Confidence scores for detection and recognition.
@override final  OcrConfidence confidence;
/// Bounding geometry (rectangle or quadrilateral).
@override final  OcrBoundingGeometry geometry;
/// The recognized text content.
@override final  String text;
/// Backend-specific metadata that doesn't fit the unified schema.
 final  Map<String, dynamic>? _backendMetadata;
/// Backend-specific metadata that doesn't fit the unified schema.
@override@JsonKey(name: 'backend_metadata') Map<String, dynamic>? get backendMetadata {
  final value = _backendMetadata;
  if (value == null) return null;
  if (_backendMetadata is EqualUnmodifiableMapView) return _backendMetadata;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}

/// Hierarchical level (word, line, block, page).
@override final  OcrElementLevel? level;
/// Page number (1-indexed).
@override@JsonKey(name: 'page_number') final  int? pageNumber;
/// Parent element ID for hierarchical relationships.
///
/// Only used for Tesseract output which has word -> line -> block hierarchy.
@override@JsonKey(name: 'parent_id') final  String? parentId;
/// Rotation information (if detected).
@override final  OcrRotation? rotation;

/// Create a copy of OcrElement
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$OcrElementCopyWith<_OcrElement> get copyWith => __$OcrElementCopyWithImpl<_OcrElement>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$OcrElementToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _OcrElement&&(identical(other.confidence, confidence) || other.confidence == confidence)&&(identical(other.geometry, geometry) || other.geometry == geometry)&&(identical(other.text, text) || other.text == text)&&const DeepCollectionEquality().equals(other._backendMetadata, _backendMetadata)&&(identical(other.level, level) || other.level == level)&&(identical(other.pageNumber, pageNumber) || other.pageNumber == pageNumber)&&(identical(other.parentId, parentId) || other.parentId == parentId)&&(identical(other.rotation, rotation) || other.rotation == rotation));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,confidence,geometry,text,const DeepCollectionEquality().hash(_backendMetadata),level,pageNumber,parentId,rotation);

@override
String toString() {
  return 'OcrElement(confidence: $confidence, geometry: $geometry, text: $text, backendMetadata: $backendMetadata, level: $level, pageNumber: $pageNumber, parentId: $parentId, rotation: $rotation)';
}


}

/// @nodoc
abstract mixin class _$OcrElementCopyWith<$Res> implements $OcrElementCopyWith<$Res> {
  factory _$OcrElementCopyWith(_OcrElement value, $Res Function(_OcrElement) _then) = __$OcrElementCopyWithImpl;
@override @useResult
$Res call({
 OcrConfidence confidence, OcrBoundingGeometry geometry, String text,@JsonKey(name: 'backend_metadata') Map<String, dynamic>? backendMetadata, OcrElementLevel? level,@JsonKey(name: 'page_number') int? pageNumber,@JsonKey(name: 'parent_id') String? parentId, OcrRotation? rotation
});


@override $OcrConfidenceCopyWith<$Res> get confidence;@override $OcrBoundingGeometryCopyWith<$Res> get geometry;@override $OcrRotationCopyWith<$Res>? get rotation;

}
/// @nodoc
class __$OcrElementCopyWithImpl<$Res>
    implements _$OcrElementCopyWith<$Res> {
  __$OcrElementCopyWithImpl(this._self, this._then);

  final _OcrElement _self;
  final $Res Function(_OcrElement) _then;

/// Create a copy of OcrElement
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? confidence = null,Object? geometry = null,Object? text = null,Object? backendMetadata = freezed,Object? level = freezed,Object? pageNumber = freezed,Object? parentId = freezed,Object? rotation = freezed,}) {
  return _then(_OcrElement(
confidence: null == confidence ? _self.confidence : confidence // ignore: cast_nullable_to_non_nullable
as OcrConfidence,geometry: null == geometry ? _self.geometry : geometry // ignore: cast_nullable_to_non_nullable
as OcrBoundingGeometry,text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,backendMetadata: freezed == backendMetadata ? _self._backendMetadata : backendMetadata // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,level: freezed == level ? _self.level : level // ignore: cast_nullable_to_non_nullable
as OcrElementLevel?,pageNumber: freezed == pageNumber ? _self.pageNumber : pageNumber // ignore: cast_nullable_to_non_nullable
as int?,parentId: freezed == parentId ? _self.parentId : parentId // ignore: cast_nullable_to_non_nullable
as String?,rotation: freezed == rotation ? _self.rotation : rotation // ignore: cast_nullable_to_non_nullable
as OcrRotation?,
  ));
}

/// Create a copy of OcrElement
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$OcrConfidenceCopyWith<$Res> get confidence {
  
  return $OcrConfidenceCopyWith<$Res>(_self.confidence, (value) {
    return _then(_self.copyWith(confidence: value));
  });
}/// Create a copy of OcrElement
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$OcrBoundingGeometryCopyWith<$Res> get geometry {
  
  return $OcrBoundingGeometryCopyWith<$Res>(_self.geometry, (value) {
    return _then(_self.copyWith(geometry: value));
  });
}/// Create a copy of OcrElement
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$OcrRotationCopyWith<$Res>? get rotation {
    if (_self.rotation == null) {
    return null;
  }

  return $OcrRotationCopyWith<$Res>(_self.rotation!, (value) {
    return _then(_self.copyWith(rotation: value));
  });
}
}

// dart format on
