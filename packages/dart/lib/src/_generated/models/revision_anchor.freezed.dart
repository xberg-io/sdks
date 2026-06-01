// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'revision_anchor.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
RevisionAnchor _$RevisionAnchorFromJson(
  Map<String, dynamic> json
) {
        switch (json['type']) {
                  case 'paragraph':
          return RevisionAnchorParagraph.fromJson(
            json
          );
                case 'table_cell':
          return RevisionAnchorTableCell.fromJson(
            json
          );
                case 'page':
          return RevisionAnchorPage.fromJson(
            json
          );
                case 'slide':
          return RevisionAnchorSlide.fromJson(
            json
          );
                case 'sheet':
          return RevisionAnchorSheet.fromJson(
            json
          );
        
          default:
            throw CheckedFromJsonException(
  json,
  'type',
  'RevisionAnchor',
  'Invalid union type "${json['type']}"!'
);
        }
      
}

/// @nodoc
mixin _$RevisionAnchor {



  /// Serializes this RevisionAnchor to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RevisionAnchor);
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'RevisionAnchor()';
}


}

/// @nodoc
class $RevisionAnchorCopyWith<$Res>  {
$RevisionAnchorCopyWith(RevisionAnchor _, $Res Function(RevisionAnchor) __);
}


/// Adds pattern-matching-related methods to [RevisionAnchor].
extension RevisionAnchorPatterns on RevisionAnchor {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( RevisionAnchorParagraph value)?  paragraph,TResult Function( RevisionAnchorTableCell value)?  tableCell,TResult Function( RevisionAnchorPage value)?  page,TResult Function( RevisionAnchorSlide value)?  slide,TResult Function( RevisionAnchorSheet value)?  sheet,required TResult orElse(),}){
final _that = this;
switch (_that) {
case RevisionAnchorParagraph() when paragraph != null:
return paragraph(_that);case RevisionAnchorTableCell() when tableCell != null:
return tableCell(_that);case RevisionAnchorPage() when page != null:
return page(_that);case RevisionAnchorSlide() when slide != null:
return slide(_that);case RevisionAnchorSheet() when sheet != null:
return sheet(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( RevisionAnchorParagraph value)  paragraph,required TResult Function( RevisionAnchorTableCell value)  tableCell,required TResult Function( RevisionAnchorPage value)  page,required TResult Function( RevisionAnchorSlide value)  slide,required TResult Function( RevisionAnchorSheet value)  sheet,}){
final _that = this;
switch (_that) {
case RevisionAnchorParagraph():
return paragraph(_that);case RevisionAnchorTableCell():
return tableCell(_that);case RevisionAnchorPage():
return page(_that);case RevisionAnchorSlide():
return slide(_that);case RevisionAnchorSheet():
return sheet(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( RevisionAnchorParagraph value)?  paragraph,TResult? Function( RevisionAnchorTableCell value)?  tableCell,TResult? Function( RevisionAnchorPage value)?  page,TResult? Function( RevisionAnchorSlide value)?  slide,TResult? Function( RevisionAnchorSheet value)?  sheet,}){
final _that = this;
switch (_that) {
case RevisionAnchorParagraph() when paragraph != null:
return paragraph(_that);case RevisionAnchorTableCell() when tableCell != null:
return tableCell(_that);case RevisionAnchorPage() when page != null:
return page(_that);case RevisionAnchorSlide() when slide != null:
return slide(_that);case RevisionAnchorSheet() when sheet != null:
return sheet(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( int index)?  paragraph,TResult Function( int row,  int col, @JsonKey(name: 'table_index')  int tableIndex)?  tableCell,TResult Function( int index)?  page,TResult Function( int index)?  slide,TResult Function( int index,  String? name)?  sheet,required TResult orElse(),}) {final _that = this;
switch (_that) {
case RevisionAnchorParagraph() when paragraph != null:
return paragraph(_that.index);case RevisionAnchorTableCell() when tableCell != null:
return tableCell(_that.row,_that.col,_that.tableIndex);case RevisionAnchorPage() when page != null:
return page(_that.index);case RevisionAnchorSlide() when slide != null:
return slide(_that.index);case RevisionAnchorSheet() when sheet != null:
return sheet(_that.index,_that.name);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( int index)  paragraph,required TResult Function( int row,  int col, @JsonKey(name: 'table_index')  int tableIndex)  tableCell,required TResult Function( int index)  page,required TResult Function( int index)  slide,required TResult Function( int index,  String? name)  sheet,}) {final _that = this;
switch (_that) {
case RevisionAnchorParagraph():
return paragraph(_that.index);case RevisionAnchorTableCell():
return tableCell(_that.row,_that.col,_that.tableIndex);case RevisionAnchorPage():
return page(_that.index);case RevisionAnchorSlide():
return slide(_that.index);case RevisionAnchorSheet():
return sheet(_that.index,_that.name);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( int index)?  paragraph,TResult? Function( int row,  int col, @JsonKey(name: 'table_index')  int tableIndex)?  tableCell,TResult? Function( int index)?  page,TResult? Function( int index)?  slide,TResult? Function( int index,  String? name)?  sheet,}) {final _that = this;
switch (_that) {
case RevisionAnchorParagraph() when paragraph != null:
return paragraph(_that.index);case RevisionAnchorTableCell() when tableCell != null:
return tableCell(_that.row,_that.col,_that.tableIndex);case RevisionAnchorPage() when page != null:
return page(_that.index);case RevisionAnchorSlide() when slide != null:
return slide(_that.index);case RevisionAnchorSheet() when sheet != null:
return sheet(_that.index,_that.name);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class RevisionAnchorParagraph implements RevisionAnchor {
  const RevisionAnchorParagraph({required this.index, final  String? $type}): $type = $type ?? 'paragraph';
  factory RevisionAnchorParagraph.fromJson(Map<String, dynamic> json) => _$RevisionAnchorParagraphFromJson(json);

/// Zero-based index of the paragraph in document order.
 final  int index;

@JsonKey(name: 'type')
final String $type;


/// Create a copy of RevisionAnchor
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RevisionAnchorParagraphCopyWith<RevisionAnchorParagraph> get copyWith => _$RevisionAnchorParagraphCopyWithImpl<RevisionAnchorParagraph>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RevisionAnchorParagraphToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RevisionAnchorParagraph&&(identical(other.index, index) || other.index == index));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,index);

@override
String toString() {
  return 'RevisionAnchor.paragraph(index: $index)';
}


}

/// @nodoc
abstract mixin class $RevisionAnchorParagraphCopyWith<$Res> implements $RevisionAnchorCopyWith<$Res> {
  factory $RevisionAnchorParagraphCopyWith(RevisionAnchorParagraph value, $Res Function(RevisionAnchorParagraph) _then) = _$RevisionAnchorParagraphCopyWithImpl;
@useResult
$Res call({
 int index
});




}
/// @nodoc
class _$RevisionAnchorParagraphCopyWithImpl<$Res>
    implements $RevisionAnchorParagraphCopyWith<$Res> {
  _$RevisionAnchorParagraphCopyWithImpl(this._self, this._then);

  final RevisionAnchorParagraph _self;
  final $Res Function(RevisionAnchorParagraph) _then;

/// Create a copy of RevisionAnchor
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? index = null,}) {
  return _then(RevisionAnchorParagraph(
index: null == index ? _self.index : index // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc
@JsonSerializable()

class RevisionAnchorTableCell implements RevisionAnchor {
  const RevisionAnchorTableCell({required this.row, required this.col, @JsonKey(name: 'table_index') required this.tableIndex, final  String? $type}): $type = $type ?? 'table_cell';
  factory RevisionAnchorTableCell.fromJson(Map<String, dynamic> json) => _$RevisionAnchorTableCellFromJson(json);

/// Zero-based row index within the table.
 final  int row;
/// Zero-based column index within the table.
 final  int col;
/// Zero-based index of the table in document order.
@JsonKey(name: 'table_index') final  int tableIndex;

@JsonKey(name: 'type')
final String $type;


/// Create a copy of RevisionAnchor
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RevisionAnchorTableCellCopyWith<RevisionAnchorTableCell> get copyWith => _$RevisionAnchorTableCellCopyWithImpl<RevisionAnchorTableCell>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RevisionAnchorTableCellToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RevisionAnchorTableCell&&(identical(other.row, row) || other.row == row)&&(identical(other.col, col) || other.col == col)&&(identical(other.tableIndex, tableIndex) || other.tableIndex == tableIndex));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,row,col,tableIndex);

@override
String toString() {
  return 'RevisionAnchor.tableCell(row: $row, col: $col, tableIndex: $tableIndex)';
}


}

/// @nodoc
abstract mixin class $RevisionAnchorTableCellCopyWith<$Res> implements $RevisionAnchorCopyWith<$Res> {
  factory $RevisionAnchorTableCellCopyWith(RevisionAnchorTableCell value, $Res Function(RevisionAnchorTableCell) _then) = _$RevisionAnchorTableCellCopyWithImpl;
@useResult
$Res call({
 int row, int col,@JsonKey(name: 'table_index') int tableIndex
});




}
/// @nodoc
class _$RevisionAnchorTableCellCopyWithImpl<$Res>
    implements $RevisionAnchorTableCellCopyWith<$Res> {
  _$RevisionAnchorTableCellCopyWithImpl(this._self, this._then);

  final RevisionAnchorTableCell _self;
  final $Res Function(RevisionAnchorTableCell) _then;

/// Create a copy of RevisionAnchor
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? row = null,Object? col = null,Object? tableIndex = null,}) {
  return _then(RevisionAnchorTableCell(
row: null == row ? _self.row : row // ignore: cast_nullable_to_non_nullable
as int,col: null == col ? _self.col : col // ignore: cast_nullable_to_non_nullable
as int,tableIndex: null == tableIndex ? _self.tableIndex : tableIndex // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc
@JsonSerializable()

class RevisionAnchorPage implements RevisionAnchor {
  const RevisionAnchorPage({required this.index, final  String? $type}): $type = $type ?? 'page';
  factory RevisionAnchorPage.fromJson(Map<String, dynamic> json) => _$RevisionAnchorPageFromJson(json);

/// Zero-based page index.
 final  int index;

@JsonKey(name: 'type')
final String $type;


/// Create a copy of RevisionAnchor
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RevisionAnchorPageCopyWith<RevisionAnchorPage> get copyWith => _$RevisionAnchorPageCopyWithImpl<RevisionAnchorPage>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RevisionAnchorPageToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RevisionAnchorPage&&(identical(other.index, index) || other.index == index));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,index);

@override
String toString() {
  return 'RevisionAnchor.page(index: $index)';
}


}

/// @nodoc
abstract mixin class $RevisionAnchorPageCopyWith<$Res> implements $RevisionAnchorCopyWith<$Res> {
  factory $RevisionAnchorPageCopyWith(RevisionAnchorPage value, $Res Function(RevisionAnchorPage) _then) = _$RevisionAnchorPageCopyWithImpl;
@useResult
$Res call({
 int index
});




}
/// @nodoc
class _$RevisionAnchorPageCopyWithImpl<$Res>
    implements $RevisionAnchorPageCopyWith<$Res> {
  _$RevisionAnchorPageCopyWithImpl(this._self, this._then);

  final RevisionAnchorPage _self;
  final $Res Function(RevisionAnchorPage) _then;

/// Create a copy of RevisionAnchor
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? index = null,}) {
  return _then(RevisionAnchorPage(
index: null == index ? _self.index : index // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc
@JsonSerializable()

class RevisionAnchorSlide implements RevisionAnchor {
  const RevisionAnchorSlide({required this.index, final  String? $type}): $type = $type ?? 'slide';
  factory RevisionAnchorSlide.fromJson(Map<String, dynamic> json) => _$RevisionAnchorSlideFromJson(json);

/// Zero-based slide index.
 final  int index;

@JsonKey(name: 'type')
final String $type;


/// Create a copy of RevisionAnchor
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RevisionAnchorSlideCopyWith<RevisionAnchorSlide> get copyWith => _$RevisionAnchorSlideCopyWithImpl<RevisionAnchorSlide>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RevisionAnchorSlideToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RevisionAnchorSlide&&(identical(other.index, index) || other.index == index));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,index);

@override
String toString() {
  return 'RevisionAnchor.slide(index: $index)';
}


}

/// @nodoc
abstract mixin class $RevisionAnchorSlideCopyWith<$Res> implements $RevisionAnchorCopyWith<$Res> {
  factory $RevisionAnchorSlideCopyWith(RevisionAnchorSlide value, $Res Function(RevisionAnchorSlide) _then) = _$RevisionAnchorSlideCopyWithImpl;
@useResult
$Res call({
 int index
});




}
/// @nodoc
class _$RevisionAnchorSlideCopyWithImpl<$Res>
    implements $RevisionAnchorSlideCopyWith<$Res> {
  _$RevisionAnchorSlideCopyWithImpl(this._self, this._then);

  final RevisionAnchorSlide _self;
  final $Res Function(RevisionAnchorSlide) _then;

/// Create a copy of RevisionAnchor
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? index = null,}) {
  return _then(RevisionAnchorSlide(
index: null == index ? _self.index : index // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc
@JsonSerializable()

class RevisionAnchorSheet implements RevisionAnchor {
  const RevisionAnchorSheet({required this.index, this.name, final  String? $type}): $type = $type ?? 'sheet';
  factory RevisionAnchorSheet.fromJson(Map<String, dynamic> json) => _$RevisionAnchorSheetFromJson(json);

/// Zero-based sheet index.
 final  int index;
/// Sheet display name when available.
 final  String? name;

@JsonKey(name: 'type')
final String $type;


/// Create a copy of RevisionAnchor
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RevisionAnchorSheetCopyWith<RevisionAnchorSheet> get copyWith => _$RevisionAnchorSheetCopyWithImpl<RevisionAnchorSheet>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RevisionAnchorSheetToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RevisionAnchorSheet&&(identical(other.index, index) || other.index == index)&&(identical(other.name, name) || other.name == name));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,index,name);

@override
String toString() {
  return 'RevisionAnchor.sheet(index: $index, name: $name)';
}


}

/// @nodoc
abstract mixin class $RevisionAnchorSheetCopyWith<$Res> implements $RevisionAnchorCopyWith<$Res> {
  factory $RevisionAnchorSheetCopyWith(RevisionAnchorSheet value, $Res Function(RevisionAnchorSheet) _then) = _$RevisionAnchorSheetCopyWithImpl;
@useResult
$Res call({
 int index, String? name
});




}
/// @nodoc
class _$RevisionAnchorSheetCopyWithImpl<$Res>
    implements $RevisionAnchorSheetCopyWith<$Res> {
  _$RevisionAnchorSheetCopyWithImpl(this._self, this._then);

  final RevisionAnchorSheet _self;
  final $Res Function(RevisionAnchorSheet) _then;

/// Create a copy of RevisionAnchor
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? index = null,Object? name = freezed,}) {
  return _then(RevisionAnchorSheet(
index: null == index ? _self.index : index // ignore: cast_nullable_to_non_nullable
as int,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
