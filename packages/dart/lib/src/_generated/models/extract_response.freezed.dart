// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'extract_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ExtractResponse {
  /// Job IDs for tracking (one per document)
  @JsonKey(name: 'job_ids')
  List<String> get jobIds;

  /// Job status
  String get status;

  /// Create a copy of ExtractResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ExtractResponseCopyWith<ExtractResponse> get copyWith =>
      _$ExtractResponseCopyWithImpl<ExtractResponse>(
          this as ExtractResponse, _$identity);

  /// Serializes this ExtractResponse to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ExtractResponse &&
            const DeepCollectionEquality().equals(other.jobIds, jobIds) &&
            (identical(other.status, status) || other.status == status));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(jobIds), status);

  @override
  String toString() {
    return 'ExtractResponse(jobIds: $jobIds, status: $status)';
  }
}

/// @nodoc
abstract mixin class $ExtractResponseCopyWith<$Res> {
  factory $ExtractResponseCopyWith(
          ExtractResponse value, $Res Function(ExtractResponse) _then) =
      _$ExtractResponseCopyWithImpl;
  @useResult
  $Res call({@JsonKey(name: 'job_ids') List<String> jobIds, String status});
}

/// @nodoc
class _$ExtractResponseCopyWithImpl<$Res>
    implements $ExtractResponseCopyWith<$Res> {
  _$ExtractResponseCopyWithImpl(this._self, this._then);

  final ExtractResponse _self;
  final $Res Function(ExtractResponse) _then;

  /// Create a copy of ExtractResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? jobIds = null,
    Object? status = null,
  }) {
    return _then(_self.copyWith(
      jobIds: null == jobIds
          ? _self.jobIds
          : jobIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
      status: null == status
          ? _self.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// Adds pattern-matching-related methods to [ExtractResponse].
extension ExtractResponsePatterns on ExtractResponse {
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

  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_ExtractResponse value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ExtractResponse() when $default != null:
        return $default(_that);
      case _:
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

  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_ExtractResponse value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ExtractResponse():
        return $default(_that);
      case _:
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

  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_ExtractResponse value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ExtractResponse() when $default != null:
        return $default(_that);
      case _:
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

  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(
            @JsonKey(name: 'job_ids') List<String> jobIds, String status)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ExtractResponse() when $default != null:
        return $default(_that.jobIds, _that.status);
      case _:
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

  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(
            @JsonKey(name: 'job_ids') List<String> jobIds, String status)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ExtractResponse():
        return $default(_that.jobIds, _that.status);
      case _:
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

  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(
            @JsonKey(name: 'job_ids') List<String> jobIds, String status)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ExtractResponse() when $default != null:
        return $default(_that.jobIds, _that.status);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _ExtractResponse implements ExtractResponse {
  const _ExtractResponse(
      {@JsonKey(name: 'job_ids') required final List<String> jobIds,
      required this.status})
      : _jobIds = jobIds;
  factory _ExtractResponse.fromJson(Map<String, dynamic> json) =>
      _$ExtractResponseFromJson(json);

  /// Job IDs for tracking (one per document)
  final List<String> _jobIds;

  /// Job IDs for tracking (one per document)
  @override
  @JsonKey(name: 'job_ids')
  List<String> get jobIds {
    if (_jobIds is EqualUnmodifiableListView) return _jobIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_jobIds);
  }

  /// Job status
  @override
  final String status;

  /// Create a copy of ExtractResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ExtractResponseCopyWith<_ExtractResponse> get copyWith =>
      __$ExtractResponseCopyWithImpl<_ExtractResponse>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$ExtractResponseToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ExtractResponse &&
            const DeepCollectionEquality().equals(other._jobIds, _jobIds) &&
            (identical(other.status, status) || other.status == status));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_jobIds), status);

  @override
  String toString() {
    return 'ExtractResponse(jobIds: $jobIds, status: $status)';
  }
}

/// @nodoc
abstract mixin class _$ExtractResponseCopyWith<$Res>
    implements $ExtractResponseCopyWith<$Res> {
  factory _$ExtractResponseCopyWith(
          _ExtractResponse value, $Res Function(_ExtractResponse) _then) =
      __$ExtractResponseCopyWithImpl;
  @override
  @useResult
  $Res call({@JsonKey(name: 'job_ids') List<String> jobIds, String status});
}

/// @nodoc
class __$ExtractResponseCopyWithImpl<$Res>
    implements _$ExtractResponseCopyWith<$Res> {
  __$ExtractResponseCopyWithImpl(this._self, this._then);

  final _ExtractResponse _self;
  final $Res Function(_ExtractResponse) _then;

  /// Create a copy of ExtractResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? jobIds = null,
    Object? status = null,
  }) {
    return _then(_ExtractResponse(
      jobIds: null == jobIds
          ? _self._jobIds
          : jobIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
      status: null == status
          ? _self.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

// dart format on
