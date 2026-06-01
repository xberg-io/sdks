// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'keyword.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Keyword {

/// Algorithm that extracted this keyword.
 KeywordAlgorithm get algorithm;/// Relevance score (higher is better, algorithm-specific range).
 double get score;/// The keyword text.
 String get text;/// Optional positions where keyword appears in text (character offsets).
 List<int>? get positions;
/// Create a copy of Keyword
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$KeywordCopyWith<Keyword> get copyWith => _$KeywordCopyWithImpl<Keyword>(this as Keyword, _$identity);

  /// Serializes this Keyword to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Keyword&&(identical(other.algorithm, algorithm) || other.algorithm == algorithm)&&(identical(other.score, score) || other.score == score)&&(identical(other.text, text) || other.text == text)&&const DeepCollectionEquality().equals(other.positions, positions));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,algorithm,score,text,const DeepCollectionEquality().hash(positions));

@override
String toString() {
  return 'Keyword(algorithm: $algorithm, score: $score, text: $text, positions: $positions)';
}


}

/// @nodoc
abstract mixin class $KeywordCopyWith<$Res>  {
  factory $KeywordCopyWith(Keyword value, $Res Function(Keyword) _then) = _$KeywordCopyWithImpl;
@useResult
$Res call({
 KeywordAlgorithm algorithm, double score, String text, List<int>? positions
});




}
/// @nodoc
class _$KeywordCopyWithImpl<$Res>
    implements $KeywordCopyWith<$Res> {
  _$KeywordCopyWithImpl(this._self, this._then);

  final Keyword _self;
  final $Res Function(Keyword) _then;

/// Create a copy of Keyword
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? algorithm = null,Object? score = null,Object? text = null,Object? positions = freezed,}) {
  return _then(_self.copyWith(
algorithm: null == algorithm ? _self.algorithm : algorithm // ignore: cast_nullable_to_non_nullable
as KeywordAlgorithm,score: null == score ? _self.score : score // ignore: cast_nullable_to_non_nullable
as double,text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,positions: freezed == positions ? _self.positions : positions // ignore: cast_nullable_to_non_nullable
as List<int>?,
  ));
}

}


/// Adds pattern-matching-related methods to [Keyword].
extension KeywordPatterns on Keyword {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Keyword value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Keyword() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Keyword value)  $default,){
final _that = this;
switch (_that) {
case _Keyword():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Keyword value)?  $default,){
final _that = this;
switch (_that) {
case _Keyword() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( KeywordAlgorithm algorithm,  double score,  String text,  List<int>? positions)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Keyword() when $default != null:
return $default(_that.algorithm,_that.score,_that.text,_that.positions);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( KeywordAlgorithm algorithm,  double score,  String text,  List<int>? positions)  $default,) {final _that = this;
switch (_that) {
case _Keyword():
return $default(_that.algorithm,_that.score,_that.text,_that.positions);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( KeywordAlgorithm algorithm,  double score,  String text,  List<int>? positions)?  $default,) {final _that = this;
switch (_that) {
case _Keyword() when $default != null:
return $default(_that.algorithm,_that.score,_that.text,_that.positions);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Keyword implements Keyword {
  const _Keyword({required this.algorithm, required this.score, required this.text, final  List<int>? positions}): _positions = positions;
  factory _Keyword.fromJson(Map<String, dynamic> json) => _$KeywordFromJson(json);

/// Algorithm that extracted this keyword.
@override final  KeywordAlgorithm algorithm;
/// Relevance score (higher is better, algorithm-specific range).
@override final  double score;
/// The keyword text.
@override final  String text;
/// Optional positions where keyword appears in text (character offsets).
 final  List<int>? _positions;
/// Optional positions where keyword appears in text (character offsets).
@override List<int>? get positions {
  final value = _positions;
  if (value == null) return null;
  if (_positions is EqualUnmodifiableListView) return _positions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}


/// Create a copy of Keyword
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$KeywordCopyWith<_Keyword> get copyWith => __$KeywordCopyWithImpl<_Keyword>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$KeywordToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Keyword&&(identical(other.algorithm, algorithm) || other.algorithm == algorithm)&&(identical(other.score, score) || other.score == score)&&(identical(other.text, text) || other.text == text)&&const DeepCollectionEquality().equals(other._positions, _positions));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,algorithm,score,text,const DeepCollectionEquality().hash(_positions));

@override
String toString() {
  return 'Keyword(algorithm: $algorithm, score: $score, text: $text, positions: $positions)';
}


}

/// @nodoc
abstract mixin class _$KeywordCopyWith<$Res> implements $KeywordCopyWith<$Res> {
  factory _$KeywordCopyWith(_Keyword value, $Res Function(_Keyword) _then) = __$KeywordCopyWithImpl;
@override @useResult
$Res call({
 KeywordAlgorithm algorithm, double score, String text, List<int>? positions
});




}
/// @nodoc
class __$KeywordCopyWithImpl<$Res>
    implements _$KeywordCopyWith<$Res> {
  __$KeywordCopyWithImpl(this._self, this._then);

  final _Keyword _self;
  final $Res Function(_Keyword) _then;

/// Create a copy of Keyword
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? algorithm = null,Object? score = null,Object? text = null,Object? positions = freezed,}) {
  return _then(_Keyword(
algorithm: null == algorithm ? _self.algorithm : algorithm // ignore: cast_nullable_to_non_nullable
as KeywordAlgorithm,score: null == score ? _self.score : score // ignore: cast_nullable_to_non_nullable
as double,text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,positions: freezed == positions ? _self._positions : positions // ignore: cast_nullable_to_non_nullable
as List<int>?,
  ));
}


}

// dart format on
