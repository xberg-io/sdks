// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ocr_bounding_geometry.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
OcrBoundingGeometry _$OcrBoundingGeometryFromJson(
  Map<String, dynamic> json
) {
        switch (json['type']) {
                  case 'rectangle':
          return OcrBoundingGeometryRectangle.fromJson(
            json
          );
                case 'quadrilateral':
          return OcrBoundingGeometryQuadrilateral.fromJson(
            json
          );
        
          default:
            throw CheckedFromJsonException(
  json,
  'type',
  'OcrBoundingGeometry',
  'Invalid union type "${json['type']}"!'
);
        }
      
}

/// @nodoc
mixin _$OcrBoundingGeometry {



  /// Serializes this OcrBoundingGeometry to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OcrBoundingGeometry);
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'OcrBoundingGeometry()';
}


}

/// @nodoc
class $OcrBoundingGeometryCopyWith<$Res>  {
$OcrBoundingGeometryCopyWith(OcrBoundingGeometry _, $Res Function(OcrBoundingGeometry) __);
}


/// Adds pattern-matching-related methods to [OcrBoundingGeometry].
extension OcrBoundingGeometryPatterns on OcrBoundingGeometry {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( OcrBoundingGeometryRectangle value)?  rectangle,TResult Function( OcrBoundingGeometryQuadrilateral value)?  quadrilateral,required TResult orElse(),}){
final _that = this;
switch (_that) {
case OcrBoundingGeometryRectangle() when rectangle != null:
return rectangle(_that);case OcrBoundingGeometryQuadrilateral() when quadrilateral != null:
return quadrilateral(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( OcrBoundingGeometryRectangle value)  rectangle,required TResult Function( OcrBoundingGeometryQuadrilateral value)  quadrilateral,}){
final _that = this;
switch (_that) {
case OcrBoundingGeometryRectangle():
return rectangle(_that);case OcrBoundingGeometryQuadrilateral():
return quadrilateral(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( OcrBoundingGeometryRectangle value)?  rectangle,TResult? Function( OcrBoundingGeometryQuadrilateral value)?  quadrilateral,}){
final _that = this;
switch (_that) {
case OcrBoundingGeometryRectangle() when rectangle != null:
return rectangle(_that);case OcrBoundingGeometryQuadrilateral() when quadrilateral != null:
return quadrilateral(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( int left,  int top,  int width,  int height)?  rectangle,TResult Function( List<List<int>> points)?  quadrilateral,required TResult orElse(),}) {final _that = this;
switch (_that) {
case OcrBoundingGeometryRectangle() when rectangle != null:
return rectangle(_that.left,_that.top,_that.width,_that.height);case OcrBoundingGeometryQuadrilateral() when quadrilateral != null:
return quadrilateral(_that.points);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( int left,  int top,  int width,  int height)  rectangle,required TResult Function( List<List<int>> points)  quadrilateral,}) {final _that = this;
switch (_that) {
case OcrBoundingGeometryRectangle():
return rectangle(_that.left,_that.top,_that.width,_that.height);case OcrBoundingGeometryQuadrilateral():
return quadrilateral(_that.points);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( int left,  int top,  int width,  int height)?  rectangle,TResult? Function( List<List<int>> points)?  quadrilateral,}) {final _that = this;
switch (_that) {
case OcrBoundingGeometryRectangle() when rectangle != null:
return rectangle(_that.left,_that.top,_that.width,_that.height);case OcrBoundingGeometryQuadrilateral() when quadrilateral != null:
return quadrilateral(_that.points);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class OcrBoundingGeometryRectangle implements OcrBoundingGeometry {
  const OcrBoundingGeometryRectangle({required this.left, required this.top, required this.width, required this.height, final  String? $type}): $type = $type ?? 'rectangle';
  factory OcrBoundingGeometryRectangle.fromJson(Map<String, dynamic> json) => _$OcrBoundingGeometryRectangleFromJson(json);

/// Left x-coordinate in pixels.
 final  int left;
/// Top y-coordinate in pixels.
 final  int top;
/// Width in pixels.
 final  int width;
/// Height in pixels.
 final  int height;

@JsonKey(name: 'type')
final String $type;


/// Create a copy of OcrBoundingGeometry
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OcrBoundingGeometryRectangleCopyWith<OcrBoundingGeometryRectangle> get copyWith => _$OcrBoundingGeometryRectangleCopyWithImpl<OcrBoundingGeometryRectangle>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$OcrBoundingGeometryRectangleToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OcrBoundingGeometryRectangle&&(identical(other.left, left) || other.left == left)&&(identical(other.top, top) || other.top == top)&&(identical(other.width, width) || other.width == width)&&(identical(other.height, height) || other.height == height));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,left,top,width,height);

@override
String toString() {
  return 'OcrBoundingGeometry.rectangle(left: $left, top: $top, width: $width, height: $height)';
}


}

/// @nodoc
abstract mixin class $OcrBoundingGeometryRectangleCopyWith<$Res> implements $OcrBoundingGeometryCopyWith<$Res> {
  factory $OcrBoundingGeometryRectangleCopyWith(OcrBoundingGeometryRectangle value, $Res Function(OcrBoundingGeometryRectangle) _then) = _$OcrBoundingGeometryRectangleCopyWithImpl;
@useResult
$Res call({
 int left, int top, int width, int height
});




}
/// @nodoc
class _$OcrBoundingGeometryRectangleCopyWithImpl<$Res>
    implements $OcrBoundingGeometryRectangleCopyWith<$Res> {
  _$OcrBoundingGeometryRectangleCopyWithImpl(this._self, this._then);

  final OcrBoundingGeometryRectangle _self;
  final $Res Function(OcrBoundingGeometryRectangle) _then;

/// Create a copy of OcrBoundingGeometry
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? left = null,Object? top = null,Object? width = null,Object? height = null,}) {
  return _then(OcrBoundingGeometryRectangle(
left: null == left ? _self.left : left // ignore: cast_nullable_to_non_nullable
as int,top: null == top ? _self.top : top // ignore: cast_nullable_to_non_nullable
as int,width: null == width ? _self.width : width // ignore: cast_nullable_to_non_nullable
as int,height: null == height ? _self.height : height // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc
@JsonSerializable()

class OcrBoundingGeometryQuadrilateral implements OcrBoundingGeometry {
  const OcrBoundingGeometryQuadrilateral({required final  List<List<int>> points, final  String? $type}): _points = points,$type = $type ?? 'quadrilateral';
  factory OcrBoundingGeometryQuadrilateral.fromJson(Map<String, dynamic> json) => _$OcrBoundingGeometryQuadrilateralFromJson(json);

/// Four corner points as `[[x, y], ...]` in clockwise order.
 final  List<List<int>> _points;
/// Four corner points as `[[x, y], ...]` in clockwise order.
 List<List<int>> get points {
  if (_points is EqualUnmodifiableListView) return _points;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_points);
}


@JsonKey(name: 'type')
final String $type;


/// Create a copy of OcrBoundingGeometry
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OcrBoundingGeometryQuadrilateralCopyWith<OcrBoundingGeometryQuadrilateral> get copyWith => _$OcrBoundingGeometryQuadrilateralCopyWithImpl<OcrBoundingGeometryQuadrilateral>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$OcrBoundingGeometryQuadrilateralToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OcrBoundingGeometryQuadrilateral&&const DeepCollectionEquality().equals(other._points, _points));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_points));

@override
String toString() {
  return 'OcrBoundingGeometry.quadrilateral(points: $points)';
}


}

/// @nodoc
abstract mixin class $OcrBoundingGeometryQuadrilateralCopyWith<$Res> implements $OcrBoundingGeometryCopyWith<$Res> {
  factory $OcrBoundingGeometryQuadrilateralCopyWith(OcrBoundingGeometryQuadrilateral value, $Res Function(OcrBoundingGeometryQuadrilateral) _then) = _$OcrBoundingGeometryQuadrilateralCopyWithImpl;
@useResult
$Res call({
 List<List<int>> points
});




}
/// @nodoc
class _$OcrBoundingGeometryQuadrilateralCopyWithImpl<$Res>
    implements $OcrBoundingGeometryQuadrilateralCopyWith<$Res> {
  _$OcrBoundingGeometryQuadrilateralCopyWithImpl(this._self, this._then);

  final OcrBoundingGeometryQuadrilateral _self;
  final $Res Function(OcrBoundingGeometryQuadrilateral) _then;

/// Create a copy of OcrBoundingGeometry
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? points = null,}) {
  return _then(OcrBoundingGeometryQuadrilateral(
points: null == points ? _self._points : points // ignore: cast_nullable_to_non_nullable
as List<List<int>>,
  ));
}


}

// dart format on
