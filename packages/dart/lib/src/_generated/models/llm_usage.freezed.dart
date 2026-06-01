// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'llm_usage.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$LlmUsage {

/// The LLM model identifier (e.g. "openai/gpt-4o", "anthropic/claude-sonnet-4-20250514").
 String get model;/// The pipeline stage that triggered this LLM call.
/// (e.g. "vlm_ocr", "structured_extraction", "embeddings").
 String get source;/// Estimated cost in USD based on the provider's published pricing.
@JsonKey(name: 'estimated_cost') double? get estimatedCost;/// Why the model stopped generating (e.g. "stop", "length", "content_filter").
@JsonKey(name: 'finish_reason') String? get finishReason;/// Number of input/prompt tokens consumed.
@JsonKey(name: 'input_tokens') int? get inputTokens;/// Number of output/completion tokens generated.
@JsonKey(name: 'output_tokens') int? get outputTokens;/// Total tokens (input + output).
@JsonKey(name: 'total_tokens') int? get totalTokens;
/// Create a copy of LlmUsage
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LlmUsageCopyWith<LlmUsage> get copyWith => _$LlmUsageCopyWithImpl<LlmUsage>(this as LlmUsage, _$identity);

  /// Serializes this LlmUsage to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LlmUsage&&(identical(other.model, model) || other.model == model)&&(identical(other.source, source) || other.source == source)&&(identical(other.estimatedCost, estimatedCost) || other.estimatedCost == estimatedCost)&&(identical(other.finishReason, finishReason) || other.finishReason == finishReason)&&(identical(other.inputTokens, inputTokens) || other.inputTokens == inputTokens)&&(identical(other.outputTokens, outputTokens) || other.outputTokens == outputTokens)&&(identical(other.totalTokens, totalTokens) || other.totalTokens == totalTokens));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,model,source,estimatedCost,finishReason,inputTokens,outputTokens,totalTokens);

@override
String toString() {
  return 'LlmUsage(model: $model, source: $source, estimatedCost: $estimatedCost, finishReason: $finishReason, inputTokens: $inputTokens, outputTokens: $outputTokens, totalTokens: $totalTokens)';
}


}

/// @nodoc
abstract mixin class $LlmUsageCopyWith<$Res>  {
  factory $LlmUsageCopyWith(LlmUsage value, $Res Function(LlmUsage) _then) = _$LlmUsageCopyWithImpl;
@useResult
$Res call({
 String model, String source,@JsonKey(name: 'estimated_cost') double? estimatedCost,@JsonKey(name: 'finish_reason') String? finishReason,@JsonKey(name: 'input_tokens') int? inputTokens,@JsonKey(name: 'output_tokens') int? outputTokens,@JsonKey(name: 'total_tokens') int? totalTokens
});




}
/// @nodoc
class _$LlmUsageCopyWithImpl<$Res>
    implements $LlmUsageCopyWith<$Res> {
  _$LlmUsageCopyWithImpl(this._self, this._then);

  final LlmUsage _self;
  final $Res Function(LlmUsage) _then;

/// Create a copy of LlmUsage
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? model = null,Object? source = null,Object? estimatedCost = freezed,Object? finishReason = freezed,Object? inputTokens = freezed,Object? outputTokens = freezed,Object? totalTokens = freezed,}) {
  return _then(_self.copyWith(
model: null == model ? _self.model : model // ignore: cast_nullable_to_non_nullable
as String,source: null == source ? _self.source : source // ignore: cast_nullable_to_non_nullable
as String,estimatedCost: freezed == estimatedCost ? _self.estimatedCost : estimatedCost // ignore: cast_nullable_to_non_nullable
as double?,finishReason: freezed == finishReason ? _self.finishReason : finishReason // ignore: cast_nullable_to_non_nullable
as String?,inputTokens: freezed == inputTokens ? _self.inputTokens : inputTokens // ignore: cast_nullable_to_non_nullable
as int?,outputTokens: freezed == outputTokens ? _self.outputTokens : outputTokens // ignore: cast_nullable_to_non_nullable
as int?,totalTokens: freezed == totalTokens ? _self.totalTokens : totalTokens // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [LlmUsage].
extension LlmUsagePatterns on LlmUsage {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LlmUsage value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LlmUsage() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LlmUsage value)  $default,){
final _that = this;
switch (_that) {
case _LlmUsage():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LlmUsage value)?  $default,){
final _that = this;
switch (_that) {
case _LlmUsage() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String model,  String source, @JsonKey(name: 'estimated_cost')  double? estimatedCost, @JsonKey(name: 'finish_reason')  String? finishReason, @JsonKey(name: 'input_tokens')  int? inputTokens, @JsonKey(name: 'output_tokens')  int? outputTokens, @JsonKey(name: 'total_tokens')  int? totalTokens)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LlmUsage() when $default != null:
return $default(_that.model,_that.source,_that.estimatedCost,_that.finishReason,_that.inputTokens,_that.outputTokens,_that.totalTokens);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String model,  String source, @JsonKey(name: 'estimated_cost')  double? estimatedCost, @JsonKey(name: 'finish_reason')  String? finishReason, @JsonKey(name: 'input_tokens')  int? inputTokens, @JsonKey(name: 'output_tokens')  int? outputTokens, @JsonKey(name: 'total_tokens')  int? totalTokens)  $default,) {final _that = this;
switch (_that) {
case _LlmUsage():
return $default(_that.model,_that.source,_that.estimatedCost,_that.finishReason,_that.inputTokens,_that.outputTokens,_that.totalTokens);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String model,  String source, @JsonKey(name: 'estimated_cost')  double? estimatedCost, @JsonKey(name: 'finish_reason')  String? finishReason, @JsonKey(name: 'input_tokens')  int? inputTokens, @JsonKey(name: 'output_tokens')  int? outputTokens, @JsonKey(name: 'total_tokens')  int? totalTokens)?  $default,) {final _that = this;
switch (_that) {
case _LlmUsage() when $default != null:
return $default(_that.model,_that.source,_that.estimatedCost,_that.finishReason,_that.inputTokens,_that.outputTokens,_that.totalTokens);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _LlmUsage implements LlmUsage {
  const _LlmUsage({required this.model, required this.source, @JsonKey(name: 'estimated_cost') this.estimatedCost, @JsonKey(name: 'finish_reason') this.finishReason, @JsonKey(name: 'input_tokens') this.inputTokens, @JsonKey(name: 'output_tokens') this.outputTokens, @JsonKey(name: 'total_tokens') this.totalTokens});
  factory _LlmUsage.fromJson(Map<String, dynamic> json) => _$LlmUsageFromJson(json);

/// The LLM model identifier (e.g. "openai/gpt-4o", "anthropic/claude-sonnet-4-20250514").
@override final  String model;
/// The pipeline stage that triggered this LLM call.
/// (e.g. "vlm_ocr", "structured_extraction", "embeddings").
@override final  String source;
/// Estimated cost in USD based on the provider's published pricing.
@override@JsonKey(name: 'estimated_cost') final  double? estimatedCost;
/// Why the model stopped generating (e.g. "stop", "length", "content_filter").
@override@JsonKey(name: 'finish_reason') final  String? finishReason;
/// Number of input/prompt tokens consumed.
@override@JsonKey(name: 'input_tokens') final  int? inputTokens;
/// Number of output/completion tokens generated.
@override@JsonKey(name: 'output_tokens') final  int? outputTokens;
/// Total tokens (input + output).
@override@JsonKey(name: 'total_tokens') final  int? totalTokens;

/// Create a copy of LlmUsage
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LlmUsageCopyWith<_LlmUsage> get copyWith => __$LlmUsageCopyWithImpl<_LlmUsage>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$LlmUsageToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LlmUsage&&(identical(other.model, model) || other.model == model)&&(identical(other.source, source) || other.source == source)&&(identical(other.estimatedCost, estimatedCost) || other.estimatedCost == estimatedCost)&&(identical(other.finishReason, finishReason) || other.finishReason == finishReason)&&(identical(other.inputTokens, inputTokens) || other.inputTokens == inputTokens)&&(identical(other.outputTokens, outputTokens) || other.outputTokens == outputTokens)&&(identical(other.totalTokens, totalTokens) || other.totalTokens == totalTokens));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,model,source,estimatedCost,finishReason,inputTokens,outputTokens,totalTokens);

@override
String toString() {
  return 'LlmUsage(model: $model, source: $source, estimatedCost: $estimatedCost, finishReason: $finishReason, inputTokens: $inputTokens, outputTokens: $outputTokens, totalTokens: $totalTokens)';
}


}

/// @nodoc
abstract mixin class _$LlmUsageCopyWith<$Res> implements $LlmUsageCopyWith<$Res> {
  factory _$LlmUsageCopyWith(_LlmUsage value, $Res Function(_LlmUsage) _then) = __$LlmUsageCopyWithImpl;
@override @useResult
$Res call({
 String model, String source,@JsonKey(name: 'estimated_cost') double? estimatedCost,@JsonKey(name: 'finish_reason') String? finishReason,@JsonKey(name: 'input_tokens') int? inputTokens,@JsonKey(name: 'output_tokens') int? outputTokens,@JsonKey(name: 'total_tokens') int? totalTokens
});




}
/// @nodoc
class __$LlmUsageCopyWithImpl<$Res>
    implements _$LlmUsageCopyWith<$Res> {
  __$LlmUsageCopyWithImpl(this._self, this._then);

  final _LlmUsage _self;
  final $Res Function(_LlmUsage) _then;

/// Create a copy of LlmUsage
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? model = null,Object? source = null,Object? estimatedCost = freezed,Object? finishReason = freezed,Object? inputTokens = freezed,Object? outputTokens = freezed,Object? totalTokens = freezed,}) {
  return _then(_LlmUsage(
model: null == model ? _self.model : model // ignore: cast_nullable_to_non_nullable
as String,source: null == source ? _self.source : source // ignore: cast_nullable_to_non_nullable
as String,estimatedCost: freezed == estimatedCost ? _self.estimatedCost : estimatedCost // ignore: cast_nullable_to_non_nullable
as double?,finishReason: freezed == finishReason ? _self.finishReason : finishReason // ignore: cast_nullable_to_non_nullable
as String?,inputTokens: freezed == inputTokens ? _self.inputTokens : inputTokens // ignore: cast_nullable_to_non_nullable
as int?,outputTokens: freezed == outputTokens ? _self.outputTokens : outputTokens // ignore: cast_nullable_to_non_nullable
as int?,totalTokens: freezed == totalTokens ? _self.totalTokens : totalTokens // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}

// dart format on
