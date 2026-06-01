// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ocr_metadata.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$OcrMetadata {

/// OCR language code(s) used
 String get language;/// Output format (e.g., "text", "hocr")
@JsonKey(name: 'output_format') String get outputFormat;/// Tesseract Page Segmentation Mode (PSM)
 int get psm;/// Number of tables detected
@JsonKey(name: 'table_count') int get tableCount;@JsonKey(name: 'table_cols') int? get tableCols;@JsonKey(name: 'table_rows') int? get tableRows;
/// Create a copy of OcrMetadata
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OcrMetadataCopyWith<OcrMetadata> get copyWith => _$OcrMetadataCopyWithImpl<OcrMetadata>(this as OcrMetadata, _$identity);

  /// Serializes this OcrMetadata to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OcrMetadata&&(identical(other.language, language) || other.language == language)&&(identical(other.outputFormat, outputFormat) || other.outputFormat == outputFormat)&&(identical(other.psm, psm) || other.psm == psm)&&(identical(other.tableCount, tableCount) || other.tableCount == tableCount)&&(identical(other.tableCols, tableCols) || other.tableCols == tableCols)&&(identical(other.tableRows, tableRows) || other.tableRows == tableRows));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,language,outputFormat,psm,tableCount,tableCols,tableRows);

@override
String toString() {
  return 'OcrMetadata(language: $language, outputFormat: $outputFormat, psm: $psm, tableCount: $tableCount, tableCols: $tableCols, tableRows: $tableRows)';
}


}

/// @nodoc
abstract mixin class $OcrMetadataCopyWith<$Res>  {
  factory $OcrMetadataCopyWith(OcrMetadata value, $Res Function(OcrMetadata) _then) = _$OcrMetadataCopyWithImpl;
@useResult
$Res call({
 String language,@JsonKey(name: 'output_format') String outputFormat, int psm,@JsonKey(name: 'table_count') int tableCount,@JsonKey(name: 'table_cols') int? tableCols,@JsonKey(name: 'table_rows') int? tableRows
});




}
/// @nodoc
class _$OcrMetadataCopyWithImpl<$Res>
    implements $OcrMetadataCopyWith<$Res> {
  _$OcrMetadataCopyWithImpl(this._self, this._then);

  final OcrMetadata _self;
  final $Res Function(OcrMetadata) _then;

/// Create a copy of OcrMetadata
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? language = null,Object? outputFormat = null,Object? psm = null,Object? tableCount = null,Object? tableCols = freezed,Object? tableRows = freezed,}) {
  return _then(_self.copyWith(
language: null == language ? _self.language : language // ignore: cast_nullable_to_non_nullable
as String,outputFormat: null == outputFormat ? _self.outputFormat : outputFormat // ignore: cast_nullable_to_non_nullable
as String,psm: null == psm ? _self.psm : psm // ignore: cast_nullable_to_non_nullable
as int,tableCount: null == tableCount ? _self.tableCount : tableCount // ignore: cast_nullable_to_non_nullable
as int,tableCols: freezed == tableCols ? _self.tableCols : tableCols // ignore: cast_nullable_to_non_nullable
as int?,tableRows: freezed == tableRows ? _self.tableRows : tableRows // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [OcrMetadata].
extension OcrMetadataPatterns on OcrMetadata {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _OcrMetadata value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _OcrMetadata() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _OcrMetadata value)  $default,){
final _that = this;
switch (_that) {
case _OcrMetadata():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _OcrMetadata value)?  $default,){
final _that = this;
switch (_that) {
case _OcrMetadata() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String language, @JsonKey(name: 'output_format')  String outputFormat,  int psm, @JsonKey(name: 'table_count')  int tableCount, @JsonKey(name: 'table_cols')  int? tableCols, @JsonKey(name: 'table_rows')  int? tableRows)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _OcrMetadata() when $default != null:
return $default(_that.language,_that.outputFormat,_that.psm,_that.tableCount,_that.tableCols,_that.tableRows);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String language, @JsonKey(name: 'output_format')  String outputFormat,  int psm, @JsonKey(name: 'table_count')  int tableCount, @JsonKey(name: 'table_cols')  int? tableCols, @JsonKey(name: 'table_rows')  int? tableRows)  $default,) {final _that = this;
switch (_that) {
case _OcrMetadata():
return $default(_that.language,_that.outputFormat,_that.psm,_that.tableCount,_that.tableCols,_that.tableRows);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String language, @JsonKey(name: 'output_format')  String outputFormat,  int psm, @JsonKey(name: 'table_count')  int tableCount, @JsonKey(name: 'table_cols')  int? tableCols, @JsonKey(name: 'table_rows')  int? tableRows)?  $default,) {final _that = this;
switch (_that) {
case _OcrMetadata() when $default != null:
return $default(_that.language,_that.outputFormat,_that.psm,_that.tableCount,_that.tableCols,_that.tableRows);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _OcrMetadata implements OcrMetadata {
  const _OcrMetadata({required this.language, @JsonKey(name: 'output_format') required this.outputFormat, required this.psm, @JsonKey(name: 'table_count') required this.tableCount, @JsonKey(name: 'table_cols') this.tableCols, @JsonKey(name: 'table_rows') this.tableRows});
  factory _OcrMetadata.fromJson(Map<String, dynamic> json) => _$OcrMetadataFromJson(json);

/// OCR language code(s) used
@override final  String language;
/// Output format (e.g., "text", "hocr")
@override@JsonKey(name: 'output_format') final  String outputFormat;
/// Tesseract Page Segmentation Mode (PSM)
@override final  int psm;
/// Number of tables detected
@override@JsonKey(name: 'table_count') final  int tableCount;
@override@JsonKey(name: 'table_cols') final  int? tableCols;
@override@JsonKey(name: 'table_rows') final  int? tableRows;

/// Create a copy of OcrMetadata
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$OcrMetadataCopyWith<_OcrMetadata> get copyWith => __$OcrMetadataCopyWithImpl<_OcrMetadata>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$OcrMetadataToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _OcrMetadata&&(identical(other.language, language) || other.language == language)&&(identical(other.outputFormat, outputFormat) || other.outputFormat == outputFormat)&&(identical(other.psm, psm) || other.psm == psm)&&(identical(other.tableCount, tableCount) || other.tableCount == tableCount)&&(identical(other.tableCols, tableCols) || other.tableCols == tableCols)&&(identical(other.tableRows, tableRows) || other.tableRows == tableRows));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,language,outputFormat,psm,tableCount,tableCols,tableRows);

@override
String toString() {
  return 'OcrMetadata(language: $language, outputFormat: $outputFormat, psm: $psm, tableCount: $tableCount, tableCols: $tableCols, tableRows: $tableRows)';
}


}

/// @nodoc
abstract mixin class _$OcrMetadataCopyWith<$Res> implements $OcrMetadataCopyWith<$Res> {
  factory _$OcrMetadataCopyWith(_OcrMetadata value, $Res Function(_OcrMetadata) _then) = __$OcrMetadataCopyWithImpl;
@override @useResult
$Res call({
 String language,@JsonKey(name: 'output_format') String outputFormat, int psm,@JsonKey(name: 'table_count') int tableCount,@JsonKey(name: 'table_cols') int? tableCols,@JsonKey(name: 'table_rows') int? tableRows
});




}
/// @nodoc
class __$OcrMetadataCopyWithImpl<$Res>
    implements _$OcrMetadataCopyWith<$Res> {
  __$OcrMetadataCopyWithImpl(this._self, this._then);

  final _OcrMetadata _self;
  final $Res Function(_OcrMetadata) _then;

/// Create a copy of OcrMetadata
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? language = null,Object? outputFormat = null,Object? psm = null,Object? tableCount = null,Object? tableCols = freezed,Object? tableRows = freezed,}) {
  return _then(_OcrMetadata(
language: null == language ? _self.language : language // ignore: cast_nullable_to_non_nullable
as String,outputFormat: null == outputFormat ? _self.outputFormat : outputFormat // ignore: cast_nullable_to_non_nullable
as String,psm: null == psm ? _self.psm : psm // ignore: cast_nullable_to_non_nullable
as int,tableCount: null == tableCount ? _self.tableCount : tableCount // ignore: cast_nullable_to_non_nullable
as int,tableCols: freezed == tableCols ? _self.tableCols : tableCols // ignore: cast_nullable_to_non_nullable
as int?,tableRows: freezed == tableRows ? _self.tableRows : tableRows // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}

// dart format on
