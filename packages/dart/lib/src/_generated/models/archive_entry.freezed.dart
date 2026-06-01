// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'archive_entry.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ArchiveEntry {

/// Detected MIME type of the file.
@JsonKey(name: 'mime_type') String get mimeType;/// Archive-relative file path (e.g. "folder/document.pdf").
 String get path;/// Full extraction result for this file.
 ExtractionResult get result;
/// Create a copy of ArchiveEntry
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ArchiveEntryCopyWith<ArchiveEntry> get copyWith => _$ArchiveEntryCopyWithImpl<ArchiveEntry>(this as ArchiveEntry, _$identity);

  /// Serializes this ArchiveEntry to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ArchiveEntry&&(identical(other.mimeType, mimeType) || other.mimeType == mimeType)&&(identical(other.path, path) || other.path == path)&&(identical(other.result, result) || other.result == result));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,mimeType,path,result);

@override
String toString() {
  return 'ArchiveEntry(mimeType: $mimeType, path: $path, result: $result)';
}


}

/// @nodoc
abstract mixin class $ArchiveEntryCopyWith<$Res>  {
  factory $ArchiveEntryCopyWith(ArchiveEntry value, $Res Function(ArchiveEntry) _then) = _$ArchiveEntryCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'mime_type') String mimeType, String path, ExtractionResult result
});


$ExtractionResultCopyWith<$Res> get result;

}
/// @nodoc
class _$ArchiveEntryCopyWithImpl<$Res>
    implements $ArchiveEntryCopyWith<$Res> {
  _$ArchiveEntryCopyWithImpl(this._self, this._then);

  final ArchiveEntry _self;
  final $Res Function(ArchiveEntry) _then;

/// Create a copy of ArchiveEntry
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? mimeType = null,Object? path = null,Object? result = null,}) {
  return _then(_self.copyWith(
mimeType: null == mimeType ? _self.mimeType : mimeType // ignore: cast_nullable_to_non_nullable
as String,path: null == path ? _self.path : path // ignore: cast_nullable_to_non_nullable
as String,result: null == result ? _self.result : result // ignore: cast_nullable_to_non_nullable
as ExtractionResult,
  ));
}
/// Create a copy of ArchiveEntry
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ExtractionResultCopyWith<$Res> get result {
  
  return $ExtractionResultCopyWith<$Res>(_self.result, (value) {
    return _then(_self.copyWith(result: value));
  });
}
}


/// Adds pattern-matching-related methods to [ArchiveEntry].
extension ArchiveEntryPatterns on ArchiveEntry {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ArchiveEntry value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ArchiveEntry() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ArchiveEntry value)  $default,){
final _that = this;
switch (_that) {
case _ArchiveEntry():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ArchiveEntry value)?  $default,){
final _that = this;
switch (_that) {
case _ArchiveEntry() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'mime_type')  String mimeType,  String path,  ExtractionResult result)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ArchiveEntry() when $default != null:
return $default(_that.mimeType,_that.path,_that.result);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'mime_type')  String mimeType,  String path,  ExtractionResult result)  $default,) {final _that = this;
switch (_that) {
case _ArchiveEntry():
return $default(_that.mimeType,_that.path,_that.result);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'mime_type')  String mimeType,  String path,  ExtractionResult result)?  $default,) {final _that = this;
switch (_that) {
case _ArchiveEntry() when $default != null:
return $default(_that.mimeType,_that.path,_that.result);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ArchiveEntry implements ArchiveEntry {
  const _ArchiveEntry({@JsonKey(name: 'mime_type') required this.mimeType, required this.path, required this.result});
  factory _ArchiveEntry.fromJson(Map<String, dynamic> json) => _$ArchiveEntryFromJson(json);

/// Detected MIME type of the file.
@override@JsonKey(name: 'mime_type') final  String mimeType;
/// Archive-relative file path (e.g. "folder/document.pdf").
@override final  String path;
/// Full extraction result for this file.
@override final  ExtractionResult result;

/// Create a copy of ArchiveEntry
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ArchiveEntryCopyWith<_ArchiveEntry> get copyWith => __$ArchiveEntryCopyWithImpl<_ArchiveEntry>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ArchiveEntryToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ArchiveEntry&&(identical(other.mimeType, mimeType) || other.mimeType == mimeType)&&(identical(other.path, path) || other.path == path)&&(identical(other.result, result) || other.result == result));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,mimeType,path,result);

@override
String toString() {
  return 'ArchiveEntry(mimeType: $mimeType, path: $path, result: $result)';
}


}

/// @nodoc
abstract mixin class _$ArchiveEntryCopyWith<$Res> implements $ArchiveEntryCopyWith<$Res> {
  factory _$ArchiveEntryCopyWith(_ArchiveEntry value, $Res Function(_ArchiveEntry) _then) = __$ArchiveEntryCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'mime_type') String mimeType, String path, ExtractionResult result
});


@override $ExtractionResultCopyWith<$Res> get result;

}
/// @nodoc
class __$ArchiveEntryCopyWithImpl<$Res>
    implements _$ArchiveEntryCopyWith<$Res> {
  __$ArchiveEntryCopyWithImpl(this._self, this._then);

  final _ArchiveEntry _self;
  final $Res Function(_ArchiveEntry) _then;

/// Create a copy of ArchiveEntry
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? mimeType = null,Object? path = null,Object? result = null,}) {
  return _then(_ArchiveEntry(
mimeType: null == mimeType ? _self.mimeType : mimeType // ignore: cast_nullable_to_non_nullable
as String,path: null == path ? _self.path : path // ignore: cast_nullable_to_non_nullable
as String,result: null == result ? _self.result : result // ignore: cast_nullable_to_non_nullable
as ExtractionResult,
  ));
}

/// Create a copy of ArchiveEntry
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ExtractionResultCopyWith<$Res> get result {
  
  return $ExtractionResultCopyWith<$Res>(_self.result, (value) {
    return _then(_self.copyWith(result: value));
  });
}
}

// dart format on
