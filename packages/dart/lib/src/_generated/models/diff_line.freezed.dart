// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'diff_line.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
DiffLine _$DiffLineFromJson(
  Map<String, dynamic> json
) {
        switch (json['kind']) {
                  case 'context':
          return DiffLineContext.fromJson(
            json
          );
                case 'added':
          return DiffLineAdded.fromJson(
            json
          );
                case 'removed':
          return DiffLineRemoved.fromJson(
            json
          );
        
          default:
            throw CheckedFromJsonException(
  json,
  'kind',
  'DiffLine',
  'Invalid union type "${json['kind']}"!'
);
        }
      
}

/// @nodoc
mixin _$DiffLine {

 String get text;
/// Create a copy of DiffLine
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DiffLineCopyWith<DiffLine> get copyWith => _$DiffLineCopyWithImpl<DiffLine>(this as DiffLine, _$identity);

  /// Serializes this DiffLine to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DiffLine&&(identical(other.text, text) || other.text == text));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,text);

@override
String toString() {
  return 'DiffLine(text: $text)';
}


}

/// @nodoc
abstract mixin class $DiffLineCopyWith<$Res>  {
  factory $DiffLineCopyWith(DiffLine value, $Res Function(DiffLine) _then) = _$DiffLineCopyWithImpl;
@useResult
$Res call({
 String text
});




}
/// @nodoc
class _$DiffLineCopyWithImpl<$Res>
    implements $DiffLineCopyWith<$Res> {
  _$DiffLineCopyWithImpl(this._self, this._then);

  final DiffLine _self;
  final $Res Function(DiffLine) _then;

/// Create a copy of DiffLine
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? text = null,}) {
  return _then(_self.copyWith(
text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [DiffLine].
extension DiffLinePatterns on DiffLine {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( DiffLineContext value)?  context,TResult Function( DiffLineAdded value)?  added,TResult Function( DiffLineRemoved value)?  removed,required TResult orElse(),}){
final _that = this;
switch (_that) {
case DiffLineContext() when context != null:
return context(_that);case DiffLineAdded() when added != null:
return added(_that);case DiffLineRemoved() when removed != null:
return removed(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( DiffLineContext value)  context,required TResult Function( DiffLineAdded value)  added,required TResult Function( DiffLineRemoved value)  removed,}){
final _that = this;
switch (_that) {
case DiffLineContext():
return context(_that);case DiffLineAdded():
return added(_that);case DiffLineRemoved():
return removed(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( DiffLineContext value)?  context,TResult? Function( DiffLineAdded value)?  added,TResult? Function( DiffLineRemoved value)?  removed,}){
final _that = this;
switch (_that) {
case DiffLineContext() when context != null:
return context(_that);case DiffLineAdded() when added != null:
return added(_that);case DiffLineRemoved() when removed != null:
return removed(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( String text)?  context,TResult Function( String text)?  added,TResult Function( String text)?  removed,required TResult orElse(),}) {final _that = this;
switch (_that) {
case DiffLineContext() when context != null:
return context(_that.text);case DiffLineAdded() when added != null:
return added(_that.text);case DiffLineRemoved() when removed != null:
return removed(_that.text);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( String text)  context,required TResult Function( String text)  added,required TResult Function( String text)  removed,}) {final _that = this;
switch (_that) {
case DiffLineContext():
return context(_that.text);case DiffLineAdded():
return added(_that.text);case DiffLineRemoved():
return removed(_that.text);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( String text)?  context,TResult? Function( String text)?  added,TResult? Function( String text)?  removed,}) {final _that = this;
switch (_that) {
case DiffLineContext() when context != null:
return context(_that.text);case DiffLineAdded() when added != null:
return added(_that.text);case DiffLineRemoved() when removed != null:
return removed(_that.text);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class DiffLineContext implements DiffLine {
  const DiffLineContext({required this.text, final  String? $type}): $type = $type ?? 'context';
  factory DiffLineContext.fromJson(Map<String, dynamic> json) => _$DiffLineContextFromJson(json);

@override final  String text;

@JsonKey(name: 'kind')
final String $type;


/// Create a copy of DiffLine
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DiffLineContextCopyWith<DiffLineContext> get copyWith => _$DiffLineContextCopyWithImpl<DiffLineContext>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DiffLineContextToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DiffLineContext&&(identical(other.text, text) || other.text == text));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,text);

@override
String toString() {
  return 'DiffLine.context(text: $text)';
}


}

/// @nodoc
abstract mixin class $DiffLineContextCopyWith<$Res> implements $DiffLineCopyWith<$Res> {
  factory $DiffLineContextCopyWith(DiffLineContext value, $Res Function(DiffLineContext) _then) = _$DiffLineContextCopyWithImpl;
@override @useResult
$Res call({
 String text
});




}
/// @nodoc
class _$DiffLineContextCopyWithImpl<$Res>
    implements $DiffLineContextCopyWith<$Res> {
  _$DiffLineContextCopyWithImpl(this._self, this._then);

  final DiffLineContext _self;
  final $Res Function(DiffLineContext) _then;

/// Create a copy of DiffLine
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? text = null,}) {
  return _then(DiffLineContext(
text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
@JsonSerializable()

class DiffLineAdded implements DiffLine {
  const DiffLineAdded({required this.text, final  String? $type}): $type = $type ?? 'added';
  factory DiffLineAdded.fromJson(Map<String, dynamic> json) => _$DiffLineAddedFromJson(json);

@override final  String text;

@JsonKey(name: 'kind')
final String $type;


/// Create a copy of DiffLine
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DiffLineAddedCopyWith<DiffLineAdded> get copyWith => _$DiffLineAddedCopyWithImpl<DiffLineAdded>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DiffLineAddedToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DiffLineAdded&&(identical(other.text, text) || other.text == text));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,text);

@override
String toString() {
  return 'DiffLine.added(text: $text)';
}


}

/// @nodoc
abstract mixin class $DiffLineAddedCopyWith<$Res> implements $DiffLineCopyWith<$Res> {
  factory $DiffLineAddedCopyWith(DiffLineAdded value, $Res Function(DiffLineAdded) _then) = _$DiffLineAddedCopyWithImpl;
@override @useResult
$Res call({
 String text
});




}
/// @nodoc
class _$DiffLineAddedCopyWithImpl<$Res>
    implements $DiffLineAddedCopyWith<$Res> {
  _$DiffLineAddedCopyWithImpl(this._self, this._then);

  final DiffLineAdded _self;
  final $Res Function(DiffLineAdded) _then;

/// Create a copy of DiffLine
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? text = null,}) {
  return _then(DiffLineAdded(
text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
@JsonSerializable()

class DiffLineRemoved implements DiffLine {
  const DiffLineRemoved({required this.text, final  String? $type}): $type = $type ?? 'removed';
  factory DiffLineRemoved.fromJson(Map<String, dynamic> json) => _$DiffLineRemovedFromJson(json);

@override final  String text;

@JsonKey(name: 'kind')
final String $type;


/// Create a copy of DiffLine
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DiffLineRemovedCopyWith<DiffLineRemoved> get copyWith => _$DiffLineRemovedCopyWithImpl<DiffLineRemoved>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DiffLineRemovedToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DiffLineRemoved&&(identical(other.text, text) || other.text == text));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,text);

@override
String toString() {
  return 'DiffLine.removed(text: $text)';
}


}

/// @nodoc
abstract mixin class $DiffLineRemovedCopyWith<$Res> implements $DiffLineCopyWith<$Res> {
  factory $DiffLineRemovedCopyWith(DiffLineRemoved value, $Res Function(DiffLineRemoved) _then) = _$DiffLineRemovedCopyWithImpl;
@override @useResult
$Res call({
 String text
});




}
/// @nodoc
class _$DiffLineRemovedCopyWithImpl<$Res>
    implements $DiffLineRemovedCopyWith<$Res> {
  _$DiffLineRemovedCopyWithImpl(this._self, this._then);

  final DiffLineRemoved _self;
  final $Res Function(DiffLineRemoved) _then;

/// Create a copy of DiffLine
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? text = null,}) {
  return _then(DiffLineRemoved(
text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
