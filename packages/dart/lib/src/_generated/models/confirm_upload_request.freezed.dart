// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'confirm_upload_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ConfirmUploadRequest {

/// Batch ID from the presign response
@JsonKey(name: 'batch_id') String get batchId;
/// Create a copy of ConfirmUploadRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ConfirmUploadRequestCopyWith<ConfirmUploadRequest> get copyWith => _$ConfirmUploadRequestCopyWithImpl<ConfirmUploadRequest>(this as ConfirmUploadRequest, _$identity);

  /// Serializes this ConfirmUploadRequest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ConfirmUploadRequest&&(identical(other.batchId, batchId) || other.batchId == batchId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,batchId);

@override
String toString() {
  return 'ConfirmUploadRequest(batchId: $batchId)';
}


}

/// @nodoc
abstract mixin class $ConfirmUploadRequestCopyWith<$Res>  {
  factory $ConfirmUploadRequestCopyWith(ConfirmUploadRequest value, $Res Function(ConfirmUploadRequest) _then) = _$ConfirmUploadRequestCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'batch_id') String batchId
});




}
/// @nodoc
class _$ConfirmUploadRequestCopyWithImpl<$Res>
    implements $ConfirmUploadRequestCopyWith<$Res> {
  _$ConfirmUploadRequestCopyWithImpl(this._self, this._then);

  final ConfirmUploadRequest _self;
  final $Res Function(ConfirmUploadRequest) _then;

/// Create a copy of ConfirmUploadRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? batchId = null,}) {
  return _then(_self.copyWith(
batchId: null == batchId ? _self.batchId : batchId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [ConfirmUploadRequest].
extension ConfirmUploadRequestPatterns on ConfirmUploadRequest {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ConfirmUploadRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ConfirmUploadRequest() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ConfirmUploadRequest value)  $default,){
final _that = this;
switch (_that) {
case _ConfirmUploadRequest():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ConfirmUploadRequest value)?  $default,){
final _that = this;
switch (_that) {
case _ConfirmUploadRequest() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'batch_id')  String batchId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ConfirmUploadRequest() when $default != null:
return $default(_that.batchId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'batch_id')  String batchId)  $default,) {final _that = this;
switch (_that) {
case _ConfirmUploadRequest():
return $default(_that.batchId);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'batch_id')  String batchId)?  $default,) {final _that = this;
switch (_that) {
case _ConfirmUploadRequest() when $default != null:
return $default(_that.batchId);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ConfirmUploadRequest implements ConfirmUploadRequest {
  const _ConfirmUploadRequest({@JsonKey(name: 'batch_id') required this.batchId});
  factory _ConfirmUploadRequest.fromJson(Map<String, dynamic> json) => _$ConfirmUploadRequestFromJson(json);

/// Batch ID from the presign response
@override@JsonKey(name: 'batch_id') final  String batchId;

/// Create a copy of ConfirmUploadRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ConfirmUploadRequestCopyWith<_ConfirmUploadRequest> get copyWith => __$ConfirmUploadRequestCopyWithImpl<_ConfirmUploadRequest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ConfirmUploadRequestToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ConfirmUploadRequest&&(identical(other.batchId, batchId) || other.batchId == batchId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,batchId);

@override
String toString() {
  return 'ConfirmUploadRequest(batchId: $batchId)';
}


}

/// @nodoc
abstract mixin class _$ConfirmUploadRequestCopyWith<$Res> implements $ConfirmUploadRequestCopyWith<$Res> {
  factory _$ConfirmUploadRequestCopyWith(_ConfirmUploadRequest value, $Res Function(_ConfirmUploadRequest) _then) = __$ConfirmUploadRequestCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'batch_id') String batchId
});




}
/// @nodoc
class __$ConfirmUploadRequestCopyWithImpl<$Res>
    implements _$ConfirmUploadRequestCopyWith<$Res> {
  __$ConfirmUploadRequestCopyWithImpl(this._self, this._then);

  final _ConfirmUploadRequest _self;
  final $Res Function(_ConfirmUploadRequest) _then;

/// Create a copy of ConfirmUploadRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? batchId = null,}) {
  return _then(_ConfirmUploadRequest(
batchId: null == batchId ? _self.batchId : batchId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
