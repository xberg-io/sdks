// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'usage_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$UsageResponse {
  /// Usage breakdown by MIME type
  @JsonKey(name: 'by_mime_type')
  Map<String, UsageByMimeType> get byMimeType;

  /// End of the reporting period (ISO 8601 date)
  @JsonKey(name: 'period_end')
  String get periodEnd;

  /// Start of the reporting period (ISO 8601 date)
  @JsonKey(name: 'period_start')
  String get periodStart;

  /// Total documents processed in the period
  @JsonKey(name: 'total_documents')
  int get totalDocuments;

  /// Total failed extractions in the period
  @JsonKey(name: 'total_failed')
  int get totalFailed;

  /// Total pages extracted in the period
  @JsonKey(name: 'total_pages')
  int get totalPages;

  /// Monthly page quota limit (null = unlimited)
  @JsonKey(name: 'quota_limit')
  int? get quotaLimit;

  /// Remaining pages in monthly quota (null = unlimited)
  @JsonKey(name: 'quota_remaining')
  int? get quotaRemaining;

  /// Create a copy of UsageResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $UsageResponseCopyWith<UsageResponse> get copyWith =>
      _$UsageResponseCopyWithImpl<UsageResponse>(
          this as UsageResponse, _$identity);

  /// Serializes this UsageResponse to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is UsageResponse &&
            const DeepCollectionEquality()
                .equals(other.byMimeType, byMimeType) &&
            (identical(other.periodEnd, periodEnd) ||
                other.periodEnd == periodEnd) &&
            (identical(other.periodStart, periodStart) ||
                other.periodStart == periodStart) &&
            (identical(other.totalDocuments, totalDocuments) ||
                other.totalDocuments == totalDocuments) &&
            (identical(other.totalFailed, totalFailed) ||
                other.totalFailed == totalFailed) &&
            (identical(other.totalPages, totalPages) ||
                other.totalPages == totalPages) &&
            (identical(other.quotaLimit, quotaLimit) ||
                other.quotaLimit == quotaLimit) &&
            (identical(other.quotaRemaining, quotaRemaining) ||
                other.quotaRemaining == quotaRemaining));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(byMimeType),
      periodEnd,
      periodStart,
      totalDocuments,
      totalFailed,
      totalPages,
      quotaLimit,
      quotaRemaining);

  @override
  String toString() {
    return 'UsageResponse(byMimeType: $byMimeType, periodEnd: $periodEnd, periodStart: $periodStart, totalDocuments: $totalDocuments, totalFailed: $totalFailed, totalPages: $totalPages, quotaLimit: $quotaLimit, quotaRemaining: $quotaRemaining)';
  }
}

/// @nodoc
abstract mixin class $UsageResponseCopyWith<$Res> {
  factory $UsageResponseCopyWith(
          UsageResponse value, $Res Function(UsageResponse) _then) =
      _$UsageResponseCopyWithImpl;
  @useResult
  $Res call(
      {@JsonKey(name: 'by_mime_type') Map<String, UsageByMimeType> byMimeType,
      @JsonKey(name: 'period_end') String periodEnd,
      @JsonKey(name: 'period_start') String periodStart,
      @JsonKey(name: 'total_documents') int totalDocuments,
      @JsonKey(name: 'total_failed') int totalFailed,
      @JsonKey(name: 'total_pages') int totalPages,
      @JsonKey(name: 'quota_limit') int? quotaLimit,
      @JsonKey(name: 'quota_remaining') int? quotaRemaining});
}

/// @nodoc
class _$UsageResponseCopyWithImpl<$Res>
    implements $UsageResponseCopyWith<$Res> {
  _$UsageResponseCopyWithImpl(this._self, this._then);

  final UsageResponse _self;
  final $Res Function(UsageResponse) _then;

  /// Create a copy of UsageResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? byMimeType = null,
    Object? periodEnd = null,
    Object? periodStart = null,
    Object? totalDocuments = null,
    Object? totalFailed = null,
    Object? totalPages = null,
    Object? quotaLimit = freezed,
    Object? quotaRemaining = freezed,
  }) {
    return _then(_self.copyWith(
      byMimeType: null == byMimeType
          ? _self.byMimeType
          : byMimeType // ignore: cast_nullable_to_non_nullable
              as Map<String, UsageByMimeType>,
      periodEnd: null == periodEnd
          ? _self.periodEnd
          : periodEnd // ignore: cast_nullable_to_non_nullable
              as String,
      periodStart: null == periodStart
          ? _self.periodStart
          : periodStart // ignore: cast_nullable_to_non_nullable
              as String,
      totalDocuments: null == totalDocuments
          ? _self.totalDocuments
          : totalDocuments // ignore: cast_nullable_to_non_nullable
              as int,
      totalFailed: null == totalFailed
          ? _self.totalFailed
          : totalFailed // ignore: cast_nullable_to_non_nullable
              as int,
      totalPages: null == totalPages
          ? _self.totalPages
          : totalPages // ignore: cast_nullable_to_non_nullable
              as int,
      quotaLimit: freezed == quotaLimit
          ? _self.quotaLimit
          : quotaLimit // ignore: cast_nullable_to_non_nullable
              as int?,
      quotaRemaining: freezed == quotaRemaining
          ? _self.quotaRemaining
          : quotaRemaining // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// Adds pattern-matching-related methods to [UsageResponse].
extension UsageResponsePatterns on UsageResponse {
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
    TResult Function(_UsageResponse value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _UsageResponse() when $default != null:
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
    TResult Function(_UsageResponse value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _UsageResponse():
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
    TResult? Function(_UsageResponse value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _UsageResponse() when $default != null:
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
            @JsonKey(name: 'by_mime_type')
            Map<String, UsageByMimeType> byMimeType,
            @JsonKey(name: 'period_end') String periodEnd,
            @JsonKey(name: 'period_start') String periodStart,
            @JsonKey(name: 'total_documents') int totalDocuments,
            @JsonKey(name: 'total_failed') int totalFailed,
            @JsonKey(name: 'total_pages') int totalPages,
            @JsonKey(name: 'quota_limit') int? quotaLimit,
            @JsonKey(name: 'quota_remaining') int? quotaRemaining)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _UsageResponse() when $default != null:
        return $default(
            _that.byMimeType,
            _that.periodEnd,
            _that.periodStart,
            _that.totalDocuments,
            _that.totalFailed,
            _that.totalPages,
            _that.quotaLimit,
            _that.quotaRemaining);
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
            @JsonKey(name: 'by_mime_type')
            Map<String, UsageByMimeType> byMimeType,
            @JsonKey(name: 'period_end') String periodEnd,
            @JsonKey(name: 'period_start') String periodStart,
            @JsonKey(name: 'total_documents') int totalDocuments,
            @JsonKey(name: 'total_failed') int totalFailed,
            @JsonKey(name: 'total_pages') int totalPages,
            @JsonKey(name: 'quota_limit') int? quotaLimit,
            @JsonKey(name: 'quota_remaining') int? quotaRemaining)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _UsageResponse():
        return $default(
            _that.byMimeType,
            _that.periodEnd,
            _that.periodStart,
            _that.totalDocuments,
            _that.totalFailed,
            _that.totalPages,
            _that.quotaLimit,
            _that.quotaRemaining);
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
            @JsonKey(name: 'by_mime_type')
            Map<String, UsageByMimeType> byMimeType,
            @JsonKey(name: 'period_end') String periodEnd,
            @JsonKey(name: 'period_start') String periodStart,
            @JsonKey(name: 'total_documents') int totalDocuments,
            @JsonKey(name: 'total_failed') int totalFailed,
            @JsonKey(name: 'total_pages') int totalPages,
            @JsonKey(name: 'quota_limit') int? quotaLimit,
            @JsonKey(name: 'quota_remaining') int? quotaRemaining)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _UsageResponse() when $default != null:
        return $default(
            _that.byMimeType,
            _that.periodEnd,
            _that.periodStart,
            _that.totalDocuments,
            _that.totalFailed,
            _that.totalPages,
            _that.quotaLimit,
            _that.quotaRemaining);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _UsageResponse implements UsageResponse {
  const _UsageResponse(
      {@JsonKey(name: 'by_mime_type')
      required final Map<String, UsageByMimeType> byMimeType,
      @JsonKey(name: 'period_end') required this.periodEnd,
      @JsonKey(name: 'period_start') required this.periodStart,
      @JsonKey(name: 'total_documents') required this.totalDocuments,
      @JsonKey(name: 'total_failed') required this.totalFailed,
      @JsonKey(name: 'total_pages') required this.totalPages,
      @JsonKey(name: 'quota_limit') this.quotaLimit,
      @JsonKey(name: 'quota_remaining') this.quotaRemaining})
      : _byMimeType = byMimeType;
  factory _UsageResponse.fromJson(Map<String, dynamic> json) =>
      _$UsageResponseFromJson(json);

  /// Usage breakdown by MIME type
  final Map<String, UsageByMimeType> _byMimeType;

  /// Usage breakdown by MIME type
  @override
  @JsonKey(name: 'by_mime_type')
  Map<String, UsageByMimeType> get byMimeType {
    if (_byMimeType is EqualUnmodifiableMapView) return _byMimeType;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_byMimeType);
  }

  /// End of the reporting period (ISO 8601 date)
  @override
  @JsonKey(name: 'period_end')
  final String periodEnd;

  /// Start of the reporting period (ISO 8601 date)
  @override
  @JsonKey(name: 'period_start')
  final String periodStart;

  /// Total documents processed in the period
  @override
  @JsonKey(name: 'total_documents')
  final int totalDocuments;

  /// Total failed extractions in the period
  @override
  @JsonKey(name: 'total_failed')
  final int totalFailed;

  /// Total pages extracted in the period
  @override
  @JsonKey(name: 'total_pages')
  final int totalPages;

  /// Monthly page quota limit (null = unlimited)
  @override
  @JsonKey(name: 'quota_limit')
  final int? quotaLimit;

  /// Remaining pages in monthly quota (null = unlimited)
  @override
  @JsonKey(name: 'quota_remaining')
  final int? quotaRemaining;

  /// Create a copy of UsageResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$UsageResponseCopyWith<_UsageResponse> get copyWith =>
      __$UsageResponseCopyWithImpl<_UsageResponse>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$UsageResponseToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _UsageResponse &&
            const DeepCollectionEquality()
                .equals(other._byMimeType, _byMimeType) &&
            (identical(other.periodEnd, periodEnd) ||
                other.periodEnd == periodEnd) &&
            (identical(other.periodStart, periodStart) ||
                other.periodStart == periodStart) &&
            (identical(other.totalDocuments, totalDocuments) ||
                other.totalDocuments == totalDocuments) &&
            (identical(other.totalFailed, totalFailed) ||
                other.totalFailed == totalFailed) &&
            (identical(other.totalPages, totalPages) ||
                other.totalPages == totalPages) &&
            (identical(other.quotaLimit, quotaLimit) ||
                other.quotaLimit == quotaLimit) &&
            (identical(other.quotaRemaining, quotaRemaining) ||
                other.quotaRemaining == quotaRemaining));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_byMimeType),
      periodEnd,
      periodStart,
      totalDocuments,
      totalFailed,
      totalPages,
      quotaLimit,
      quotaRemaining);

  @override
  String toString() {
    return 'UsageResponse(byMimeType: $byMimeType, periodEnd: $periodEnd, periodStart: $periodStart, totalDocuments: $totalDocuments, totalFailed: $totalFailed, totalPages: $totalPages, quotaLimit: $quotaLimit, quotaRemaining: $quotaRemaining)';
  }
}

/// @nodoc
abstract mixin class _$UsageResponseCopyWith<$Res>
    implements $UsageResponseCopyWith<$Res> {
  factory _$UsageResponseCopyWith(
          _UsageResponse value, $Res Function(_UsageResponse) _then) =
      __$UsageResponseCopyWithImpl;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'by_mime_type') Map<String, UsageByMimeType> byMimeType,
      @JsonKey(name: 'period_end') String periodEnd,
      @JsonKey(name: 'period_start') String periodStart,
      @JsonKey(name: 'total_documents') int totalDocuments,
      @JsonKey(name: 'total_failed') int totalFailed,
      @JsonKey(name: 'total_pages') int totalPages,
      @JsonKey(name: 'quota_limit') int? quotaLimit,
      @JsonKey(name: 'quota_remaining') int? quotaRemaining});
}

/// @nodoc
class __$UsageResponseCopyWithImpl<$Res>
    implements _$UsageResponseCopyWith<$Res> {
  __$UsageResponseCopyWithImpl(this._self, this._then);

  final _UsageResponse _self;
  final $Res Function(_UsageResponse) _then;

  /// Create a copy of UsageResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? byMimeType = null,
    Object? periodEnd = null,
    Object? periodStart = null,
    Object? totalDocuments = null,
    Object? totalFailed = null,
    Object? totalPages = null,
    Object? quotaLimit = freezed,
    Object? quotaRemaining = freezed,
  }) {
    return _then(_UsageResponse(
      byMimeType: null == byMimeType
          ? _self._byMimeType
          : byMimeType // ignore: cast_nullable_to_non_nullable
              as Map<String, UsageByMimeType>,
      periodEnd: null == periodEnd
          ? _self.periodEnd
          : periodEnd // ignore: cast_nullable_to_non_nullable
              as String,
      periodStart: null == periodStart
          ? _self.periodStart
          : periodStart // ignore: cast_nullable_to_non_nullable
              as String,
      totalDocuments: null == totalDocuments
          ? _self.totalDocuments
          : totalDocuments // ignore: cast_nullable_to_non_nullable
              as int,
      totalFailed: null == totalFailed
          ? _self.totalFailed
          : totalFailed // ignore: cast_nullable_to_non_nullable
              as int,
      totalPages: null == totalPages
          ? _self.totalPages
          : totalPages // ignore: cast_nullable_to_non_nullable
              as int,
      quotaLimit: freezed == quotaLimit
          ? _self.quotaLimit
          : quotaLimit // ignore: cast_nullable_to_non_nullable
              as int?,
      quotaRemaining: freezed == quotaRemaining
          ? _self.quotaRemaining
          : quotaRemaining // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

// dart format on
