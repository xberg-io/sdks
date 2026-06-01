// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'archive_metadata.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ArchiveMetadata {

/// Total number of files in the archive
@JsonKey(name: 'file_count') int get fileCount;/// List of file paths within the archive
@JsonKey(name: 'file_list') List<String> get fileList;/// Archive format ("ZIP", "TAR", "7Z", etc.)
 String get format;/// Total uncompressed size in bytes
@JsonKey(name: 'total_size') int get totalSize;/// Compressed size in bytes (if available)
@JsonKey(name: 'compressed_size') int? get compressedSize;
/// Create a copy of ArchiveMetadata
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ArchiveMetadataCopyWith<ArchiveMetadata> get copyWith => _$ArchiveMetadataCopyWithImpl<ArchiveMetadata>(this as ArchiveMetadata, _$identity);

  /// Serializes this ArchiveMetadata to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ArchiveMetadata&&(identical(other.fileCount, fileCount) || other.fileCount == fileCount)&&const DeepCollectionEquality().equals(other.fileList, fileList)&&(identical(other.format, format) || other.format == format)&&(identical(other.totalSize, totalSize) || other.totalSize == totalSize)&&(identical(other.compressedSize, compressedSize) || other.compressedSize == compressedSize));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,fileCount,const DeepCollectionEquality().hash(fileList),format,totalSize,compressedSize);

@override
String toString() {
  return 'ArchiveMetadata(fileCount: $fileCount, fileList: $fileList, format: $format, totalSize: $totalSize, compressedSize: $compressedSize)';
}


}

/// @nodoc
abstract mixin class $ArchiveMetadataCopyWith<$Res>  {
  factory $ArchiveMetadataCopyWith(ArchiveMetadata value, $Res Function(ArchiveMetadata) _then) = _$ArchiveMetadataCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'file_count') int fileCount,@JsonKey(name: 'file_list') List<String> fileList, String format,@JsonKey(name: 'total_size') int totalSize,@JsonKey(name: 'compressed_size') int? compressedSize
});




}
/// @nodoc
class _$ArchiveMetadataCopyWithImpl<$Res>
    implements $ArchiveMetadataCopyWith<$Res> {
  _$ArchiveMetadataCopyWithImpl(this._self, this._then);

  final ArchiveMetadata _self;
  final $Res Function(ArchiveMetadata) _then;

/// Create a copy of ArchiveMetadata
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? fileCount = null,Object? fileList = null,Object? format = null,Object? totalSize = null,Object? compressedSize = freezed,}) {
  return _then(_self.copyWith(
fileCount: null == fileCount ? _self.fileCount : fileCount // ignore: cast_nullable_to_non_nullable
as int,fileList: null == fileList ? _self.fileList : fileList // ignore: cast_nullable_to_non_nullable
as List<String>,format: null == format ? _self.format : format // ignore: cast_nullable_to_non_nullable
as String,totalSize: null == totalSize ? _self.totalSize : totalSize // ignore: cast_nullable_to_non_nullable
as int,compressedSize: freezed == compressedSize ? _self.compressedSize : compressedSize // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [ArchiveMetadata].
extension ArchiveMetadataPatterns on ArchiveMetadata {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ArchiveMetadata value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ArchiveMetadata() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ArchiveMetadata value)  $default,){
final _that = this;
switch (_that) {
case _ArchiveMetadata():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ArchiveMetadata value)?  $default,){
final _that = this;
switch (_that) {
case _ArchiveMetadata() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'file_count')  int fileCount, @JsonKey(name: 'file_list')  List<String> fileList,  String format, @JsonKey(name: 'total_size')  int totalSize, @JsonKey(name: 'compressed_size')  int? compressedSize)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ArchiveMetadata() when $default != null:
return $default(_that.fileCount,_that.fileList,_that.format,_that.totalSize,_that.compressedSize);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'file_count')  int fileCount, @JsonKey(name: 'file_list')  List<String> fileList,  String format, @JsonKey(name: 'total_size')  int totalSize, @JsonKey(name: 'compressed_size')  int? compressedSize)  $default,) {final _that = this;
switch (_that) {
case _ArchiveMetadata():
return $default(_that.fileCount,_that.fileList,_that.format,_that.totalSize,_that.compressedSize);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'file_count')  int fileCount, @JsonKey(name: 'file_list')  List<String> fileList,  String format, @JsonKey(name: 'total_size')  int totalSize, @JsonKey(name: 'compressed_size')  int? compressedSize)?  $default,) {final _that = this;
switch (_that) {
case _ArchiveMetadata() when $default != null:
return $default(_that.fileCount,_that.fileList,_that.format,_that.totalSize,_that.compressedSize);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ArchiveMetadata implements ArchiveMetadata {
  const _ArchiveMetadata({@JsonKey(name: 'file_count') required this.fileCount, @JsonKey(name: 'file_list') required final  List<String> fileList, required this.format, @JsonKey(name: 'total_size') required this.totalSize, @JsonKey(name: 'compressed_size') this.compressedSize}): _fileList = fileList;
  factory _ArchiveMetadata.fromJson(Map<String, dynamic> json) => _$ArchiveMetadataFromJson(json);

/// Total number of files in the archive
@override@JsonKey(name: 'file_count') final  int fileCount;
/// List of file paths within the archive
 final  List<String> _fileList;
/// List of file paths within the archive
@override@JsonKey(name: 'file_list') List<String> get fileList {
  if (_fileList is EqualUnmodifiableListView) return _fileList;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_fileList);
}

/// Archive format ("ZIP", "TAR", "7Z", etc.)
@override final  String format;
/// Total uncompressed size in bytes
@override@JsonKey(name: 'total_size') final  int totalSize;
/// Compressed size in bytes (if available)
@override@JsonKey(name: 'compressed_size') final  int? compressedSize;

/// Create a copy of ArchiveMetadata
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ArchiveMetadataCopyWith<_ArchiveMetadata> get copyWith => __$ArchiveMetadataCopyWithImpl<_ArchiveMetadata>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ArchiveMetadataToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ArchiveMetadata&&(identical(other.fileCount, fileCount) || other.fileCount == fileCount)&&const DeepCollectionEquality().equals(other._fileList, _fileList)&&(identical(other.format, format) || other.format == format)&&(identical(other.totalSize, totalSize) || other.totalSize == totalSize)&&(identical(other.compressedSize, compressedSize) || other.compressedSize == compressedSize));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,fileCount,const DeepCollectionEquality().hash(_fileList),format,totalSize,compressedSize);

@override
String toString() {
  return 'ArchiveMetadata(fileCount: $fileCount, fileList: $fileList, format: $format, totalSize: $totalSize, compressedSize: $compressedSize)';
}


}

/// @nodoc
abstract mixin class _$ArchiveMetadataCopyWith<$Res> implements $ArchiveMetadataCopyWith<$Res> {
  factory _$ArchiveMetadataCopyWith(_ArchiveMetadata value, $Res Function(_ArchiveMetadata) _then) = __$ArchiveMetadataCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'file_count') int fileCount,@JsonKey(name: 'file_list') List<String> fileList, String format,@JsonKey(name: 'total_size') int totalSize,@JsonKey(name: 'compressed_size') int? compressedSize
});




}
/// @nodoc
class __$ArchiveMetadataCopyWithImpl<$Res>
    implements _$ArchiveMetadataCopyWith<$Res> {
  __$ArchiveMetadataCopyWithImpl(this._self, this._then);

  final _ArchiveMetadata _self;
  final $Res Function(_ArchiveMetadata) _then;

/// Create a copy of ArchiveMetadata
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? fileCount = null,Object? fileList = null,Object? format = null,Object? totalSize = null,Object? compressedSize = freezed,}) {
  return _then(_ArchiveMetadata(
fileCount: null == fileCount ? _self.fileCount : fileCount // ignore: cast_nullable_to_non_nullable
as int,fileList: null == fileList ? _self._fileList : fileList // ignore: cast_nullable_to_non_nullable
as List<String>,format: null == format ? _self.format : format // ignore: cast_nullable_to_non_nullable
as String,totalSize: null == totalSize ? _self.totalSize : totalSize // ignore: cast_nullable_to_non_nullable
as int,compressedSize: freezed == compressedSize ? _self.compressedSize : compressedSize // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}

// dart format on
