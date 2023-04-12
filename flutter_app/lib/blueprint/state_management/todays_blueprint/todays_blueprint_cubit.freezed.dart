// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'todays_blueprint_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

TodaysBlueprintState _$TodaysBlueprintStateFromJson(Map<String, dynamic> json) {
  switch (json['runtimeType']) {
    case 'initial':
      return _Initial.fromJson(json);
    case 'loading':
      return _Loading.fromJson(json);
    case 'loaded':
      return _Loaded.fromJson(json);
    case 'error':
      return _Error.fromJson(json);

    default:
      throw CheckedFromJsonException(
          json,
          'runtimeType',
          'TodaysBlueprintState',
          'Invalid union type "${json['runtimeType']}"!');
  }
}

/// @nodoc
mixin _$TodaysBlueprintState {
  List<CalendarEvent> get calendarEvents => throw _privateConstructorUsedError;
  DateTime get addedAt => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            List<CalendarEvent> calendarEvents, DateTime addedAt)
        initial,
    required TResult Function(
            List<CalendarEvent> calendarEvents, DateTime addedAt)
        loading,
    required TResult Function(
            List<CalendarEvent> calendarEvents, DateTime addedAt)
        loaded,
    required TResult Function(
            String error, List<CalendarEvent> calendarEvents, DateTime addedAt)
        error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(List<CalendarEvent> calendarEvents, DateTime addedAt)?
        initial,
    TResult? Function(List<CalendarEvent> calendarEvents, DateTime addedAt)?
        loading,
    TResult? Function(List<CalendarEvent> calendarEvents, DateTime addedAt)?
        loaded,
    TResult? Function(
            String error, List<CalendarEvent> calendarEvents, DateTime addedAt)?
        error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(List<CalendarEvent> calendarEvents, DateTime addedAt)?
        initial,
    TResult Function(List<CalendarEvent> calendarEvents, DateTime addedAt)?
        loading,
    TResult Function(List<CalendarEvent> calendarEvents, DateTime addedAt)?
        loaded,
    TResult Function(
            String error, List<CalendarEvent> calendarEvents, DateTime addedAt)?
        error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Loaded value) loaded,
    required TResult Function(_Error value) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Loaded value)? loaded,
    TResult? Function(_Error value)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Loaded value)? loaded,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TodaysBlueprintStateCopyWith<TodaysBlueprintState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TodaysBlueprintStateCopyWith<$Res> {
  factory $TodaysBlueprintStateCopyWith(TodaysBlueprintState value,
          $Res Function(TodaysBlueprintState) then) =
      _$TodaysBlueprintStateCopyWithImpl<$Res, TodaysBlueprintState>;
  @useResult
  $Res call({List<CalendarEvent> calendarEvents, DateTime addedAt});
}

/// @nodoc
class _$TodaysBlueprintStateCopyWithImpl<$Res,
        $Val extends TodaysBlueprintState>
    implements $TodaysBlueprintStateCopyWith<$Res> {
  _$TodaysBlueprintStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? calendarEvents = null,
    Object? addedAt = null,
  }) {
    return _then(_value.copyWith(
      calendarEvents: null == calendarEvents
          ? _value.calendarEvents
          : calendarEvents // ignore: cast_nullable_to_non_nullable
              as List<CalendarEvent>,
      addedAt: null == addedAt
          ? _value.addedAt
          : addedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_InitialCopyWith<$Res>
    implements $TodaysBlueprintStateCopyWith<$Res> {
  factory _$$_InitialCopyWith(
          _$_Initial value, $Res Function(_$_Initial) then) =
      __$$_InitialCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<CalendarEvent> calendarEvents, DateTime addedAt});
}

/// @nodoc
class __$$_InitialCopyWithImpl<$Res>
    extends _$TodaysBlueprintStateCopyWithImpl<$Res, _$_Initial>
    implements _$$_InitialCopyWith<$Res> {
  __$$_InitialCopyWithImpl(_$_Initial _value, $Res Function(_$_Initial) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? calendarEvents = null,
    Object? addedAt = null,
  }) {
    return _then(_$_Initial(
      calendarEvents: null == calendarEvents
          ? _value._calendarEvents
          : calendarEvents // ignore: cast_nullable_to_non_nullable
              as List<CalendarEvent>,
      addedAt: null == addedAt
          ? _value.addedAt
          : addedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Initial extends _Initial {
  const _$_Initial(
      {required final List<CalendarEvent> calendarEvents,
      required this.addedAt,
      final String? $type})
      : _calendarEvents = calendarEvents,
        $type = $type ?? 'initial',
        super._();

  factory _$_Initial.fromJson(Map<String, dynamic> json) =>
      _$$_InitialFromJson(json);

  final List<CalendarEvent> _calendarEvents;
  @override
  List<CalendarEvent> get calendarEvents {
    if (_calendarEvents is EqualUnmodifiableListView) return _calendarEvents;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_calendarEvents);
  }

  @override
  final DateTime addedAt;

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'TodaysBlueprintState.initial(calendarEvents: $calendarEvents, addedAt: $addedAt)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Initial &&
            const DeepCollectionEquality()
                .equals(other._calendarEvents, _calendarEvents) &&
            (identical(other.addedAt, addedAt) || other.addedAt == addedAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType,
      const DeepCollectionEquality().hash(_calendarEvents), addedAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_InitialCopyWith<_$_Initial> get copyWith =>
      __$$_InitialCopyWithImpl<_$_Initial>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            List<CalendarEvent> calendarEvents, DateTime addedAt)
        initial,
    required TResult Function(
            List<CalendarEvent> calendarEvents, DateTime addedAt)
        loading,
    required TResult Function(
            List<CalendarEvent> calendarEvents, DateTime addedAt)
        loaded,
    required TResult Function(
            String error, List<CalendarEvent> calendarEvents, DateTime addedAt)
        error,
  }) {
    return initial(calendarEvents, addedAt);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(List<CalendarEvent> calendarEvents, DateTime addedAt)?
        initial,
    TResult? Function(List<CalendarEvent> calendarEvents, DateTime addedAt)?
        loading,
    TResult? Function(List<CalendarEvent> calendarEvents, DateTime addedAt)?
        loaded,
    TResult? Function(
            String error, List<CalendarEvent> calendarEvents, DateTime addedAt)?
        error,
  }) {
    return initial?.call(calendarEvents, addedAt);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(List<CalendarEvent> calendarEvents, DateTime addedAt)?
        initial,
    TResult Function(List<CalendarEvent> calendarEvents, DateTime addedAt)?
        loading,
    TResult Function(List<CalendarEvent> calendarEvents, DateTime addedAt)?
        loaded,
    TResult Function(
            String error, List<CalendarEvent> calendarEvents, DateTime addedAt)?
        error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(calendarEvents, addedAt);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Loaded value) loaded,
    required TResult Function(_Error value) error,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Loaded value)? loaded,
    TResult? Function(_Error value)? error,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Loaded value)? loaded,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$_InitialToJson(
      this,
    );
  }
}

abstract class _Initial extends TodaysBlueprintState {
  const factory _Initial(
      {required final List<CalendarEvent> calendarEvents,
      required final DateTime addedAt}) = _$_Initial;
  const _Initial._() : super._();

  factory _Initial.fromJson(Map<String, dynamic> json) = _$_Initial.fromJson;

  @override
  List<CalendarEvent> get calendarEvents;
  @override
  DateTime get addedAt;
  @override
  @JsonKey(ignore: true)
  _$$_InitialCopyWith<_$_Initial> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$_LoadingCopyWith<$Res>
    implements $TodaysBlueprintStateCopyWith<$Res> {
  factory _$$_LoadingCopyWith(
          _$_Loading value, $Res Function(_$_Loading) then) =
      __$$_LoadingCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<CalendarEvent> calendarEvents, DateTime addedAt});
}

/// @nodoc
class __$$_LoadingCopyWithImpl<$Res>
    extends _$TodaysBlueprintStateCopyWithImpl<$Res, _$_Loading>
    implements _$$_LoadingCopyWith<$Res> {
  __$$_LoadingCopyWithImpl(_$_Loading _value, $Res Function(_$_Loading) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? calendarEvents = null,
    Object? addedAt = null,
  }) {
    return _then(_$_Loading(
      calendarEvents: null == calendarEvents
          ? _value._calendarEvents
          : calendarEvents // ignore: cast_nullable_to_non_nullable
              as List<CalendarEvent>,
      addedAt: null == addedAt
          ? _value.addedAt
          : addedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Loading extends _Loading {
  const _$_Loading(
      {required final List<CalendarEvent> calendarEvents,
      required this.addedAt,
      final String? $type})
      : _calendarEvents = calendarEvents,
        $type = $type ?? 'loading',
        super._();

  factory _$_Loading.fromJson(Map<String, dynamic> json) =>
      _$$_LoadingFromJson(json);

  final List<CalendarEvent> _calendarEvents;
  @override
  List<CalendarEvent> get calendarEvents {
    if (_calendarEvents is EqualUnmodifiableListView) return _calendarEvents;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_calendarEvents);
  }

  @override
  final DateTime addedAt;

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'TodaysBlueprintState.loading(calendarEvents: $calendarEvents, addedAt: $addedAt)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Loading &&
            const DeepCollectionEquality()
                .equals(other._calendarEvents, _calendarEvents) &&
            (identical(other.addedAt, addedAt) || other.addedAt == addedAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType,
      const DeepCollectionEquality().hash(_calendarEvents), addedAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_LoadingCopyWith<_$_Loading> get copyWith =>
      __$$_LoadingCopyWithImpl<_$_Loading>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            List<CalendarEvent> calendarEvents, DateTime addedAt)
        initial,
    required TResult Function(
            List<CalendarEvent> calendarEvents, DateTime addedAt)
        loading,
    required TResult Function(
            List<CalendarEvent> calendarEvents, DateTime addedAt)
        loaded,
    required TResult Function(
            String error, List<CalendarEvent> calendarEvents, DateTime addedAt)
        error,
  }) {
    return loading(calendarEvents, addedAt);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(List<CalendarEvent> calendarEvents, DateTime addedAt)?
        initial,
    TResult? Function(List<CalendarEvent> calendarEvents, DateTime addedAt)?
        loading,
    TResult? Function(List<CalendarEvent> calendarEvents, DateTime addedAt)?
        loaded,
    TResult? Function(
            String error, List<CalendarEvent> calendarEvents, DateTime addedAt)?
        error,
  }) {
    return loading?.call(calendarEvents, addedAt);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(List<CalendarEvent> calendarEvents, DateTime addedAt)?
        initial,
    TResult Function(List<CalendarEvent> calendarEvents, DateTime addedAt)?
        loading,
    TResult Function(List<CalendarEvent> calendarEvents, DateTime addedAt)?
        loaded,
    TResult Function(
            String error, List<CalendarEvent> calendarEvents, DateTime addedAt)?
        error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(calendarEvents, addedAt);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Loaded value) loaded,
    required TResult Function(_Error value) error,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Loaded value)? loaded,
    TResult? Function(_Error value)? error,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Loaded value)? loaded,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$_LoadingToJson(
      this,
    );
  }
}

abstract class _Loading extends TodaysBlueprintState {
  const factory _Loading(
      {required final List<CalendarEvent> calendarEvents,
      required final DateTime addedAt}) = _$_Loading;
  const _Loading._() : super._();

  factory _Loading.fromJson(Map<String, dynamic> json) = _$_Loading.fromJson;

  @override
  List<CalendarEvent> get calendarEvents;
  @override
  DateTime get addedAt;
  @override
  @JsonKey(ignore: true)
  _$$_LoadingCopyWith<_$_Loading> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$_LoadedCopyWith<$Res>
    implements $TodaysBlueprintStateCopyWith<$Res> {
  factory _$$_LoadedCopyWith(_$_Loaded value, $Res Function(_$_Loaded) then) =
      __$$_LoadedCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<CalendarEvent> calendarEvents, DateTime addedAt});
}

/// @nodoc
class __$$_LoadedCopyWithImpl<$Res>
    extends _$TodaysBlueprintStateCopyWithImpl<$Res, _$_Loaded>
    implements _$$_LoadedCopyWith<$Res> {
  __$$_LoadedCopyWithImpl(_$_Loaded _value, $Res Function(_$_Loaded) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? calendarEvents = null,
    Object? addedAt = null,
  }) {
    return _then(_$_Loaded(
      calendarEvents: null == calendarEvents
          ? _value._calendarEvents
          : calendarEvents // ignore: cast_nullable_to_non_nullable
              as List<CalendarEvent>,
      addedAt: null == addedAt
          ? _value.addedAt
          : addedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Loaded extends _Loaded {
  const _$_Loaded(
      {required final List<CalendarEvent> calendarEvents,
      required this.addedAt,
      final String? $type})
      : _calendarEvents = calendarEvents,
        $type = $type ?? 'loaded',
        super._();

  factory _$_Loaded.fromJson(Map<String, dynamic> json) =>
      _$$_LoadedFromJson(json);

  final List<CalendarEvent> _calendarEvents;
  @override
  List<CalendarEvent> get calendarEvents {
    if (_calendarEvents is EqualUnmodifiableListView) return _calendarEvents;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_calendarEvents);
  }

  @override
  final DateTime addedAt;

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'TodaysBlueprintState.loaded(calendarEvents: $calendarEvents, addedAt: $addedAt)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Loaded &&
            const DeepCollectionEquality()
                .equals(other._calendarEvents, _calendarEvents) &&
            (identical(other.addedAt, addedAt) || other.addedAt == addedAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType,
      const DeepCollectionEquality().hash(_calendarEvents), addedAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_LoadedCopyWith<_$_Loaded> get copyWith =>
      __$$_LoadedCopyWithImpl<_$_Loaded>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            List<CalendarEvent> calendarEvents, DateTime addedAt)
        initial,
    required TResult Function(
            List<CalendarEvent> calendarEvents, DateTime addedAt)
        loading,
    required TResult Function(
            List<CalendarEvent> calendarEvents, DateTime addedAt)
        loaded,
    required TResult Function(
            String error, List<CalendarEvent> calendarEvents, DateTime addedAt)
        error,
  }) {
    return loaded(calendarEvents, addedAt);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(List<CalendarEvent> calendarEvents, DateTime addedAt)?
        initial,
    TResult? Function(List<CalendarEvent> calendarEvents, DateTime addedAt)?
        loading,
    TResult? Function(List<CalendarEvent> calendarEvents, DateTime addedAt)?
        loaded,
    TResult? Function(
            String error, List<CalendarEvent> calendarEvents, DateTime addedAt)?
        error,
  }) {
    return loaded?.call(calendarEvents, addedAt);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(List<CalendarEvent> calendarEvents, DateTime addedAt)?
        initial,
    TResult Function(List<CalendarEvent> calendarEvents, DateTime addedAt)?
        loading,
    TResult Function(List<CalendarEvent> calendarEvents, DateTime addedAt)?
        loaded,
    TResult Function(
            String error, List<CalendarEvent> calendarEvents, DateTime addedAt)?
        error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(calendarEvents, addedAt);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Loaded value) loaded,
    required TResult Function(_Error value) error,
  }) {
    return loaded(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Loaded value)? loaded,
    TResult? Function(_Error value)? error,
  }) {
    return loaded?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Loaded value)? loaded,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$_LoadedToJson(
      this,
    );
  }
}

abstract class _Loaded extends TodaysBlueprintState {
  const factory _Loaded(
      {required final List<CalendarEvent> calendarEvents,
      required final DateTime addedAt}) = _$_Loaded;
  const _Loaded._() : super._();

  factory _Loaded.fromJson(Map<String, dynamic> json) = _$_Loaded.fromJson;

  @override
  List<CalendarEvent> get calendarEvents;
  @override
  DateTime get addedAt;
  @override
  @JsonKey(ignore: true)
  _$$_LoadedCopyWith<_$_Loaded> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$_ErrorCopyWith<$Res>
    implements $TodaysBlueprintStateCopyWith<$Res> {
  factory _$$_ErrorCopyWith(_$_Error value, $Res Function(_$_Error) then) =
      __$$_ErrorCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String error, List<CalendarEvent> calendarEvents, DateTime addedAt});
}

/// @nodoc
class __$$_ErrorCopyWithImpl<$Res>
    extends _$TodaysBlueprintStateCopyWithImpl<$Res, _$_Error>
    implements _$$_ErrorCopyWith<$Res> {
  __$$_ErrorCopyWithImpl(_$_Error _value, $Res Function(_$_Error) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? error = null,
    Object? calendarEvents = null,
    Object? addedAt = null,
  }) {
    return _then(_$_Error(
      error: null == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String,
      calendarEvents: null == calendarEvents
          ? _value._calendarEvents
          : calendarEvents // ignore: cast_nullable_to_non_nullable
              as List<CalendarEvent>,
      addedAt: null == addedAt
          ? _value.addedAt
          : addedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Error extends _Error {
  const _$_Error(
      {required this.error,
      required final List<CalendarEvent> calendarEvents,
      required this.addedAt,
      final String? $type})
      : _calendarEvents = calendarEvents,
        $type = $type ?? 'error',
        super._();

  factory _$_Error.fromJson(Map<String, dynamic> json) =>
      _$$_ErrorFromJson(json);

  @override
  final String error;
  final List<CalendarEvent> _calendarEvents;
  @override
  List<CalendarEvent> get calendarEvents {
    if (_calendarEvents is EqualUnmodifiableListView) return _calendarEvents;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_calendarEvents);
  }

  @override
  final DateTime addedAt;

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'TodaysBlueprintState.error(error: $error, calendarEvents: $calendarEvents, addedAt: $addedAt)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Error &&
            (identical(other.error, error) || other.error == error) &&
            const DeepCollectionEquality()
                .equals(other._calendarEvents, _calendarEvents) &&
            (identical(other.addedAt, addedAt) || other.addedAt == addedAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, error,
      const DeepCollectionEquality().hash(_calendarEvents), addedAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ErrorCopyWith<_$_Error> get copyWith =>
      __$$_ErrorCopyWithImpl<_$_Error>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            List<CalendarEvent> calendarEvents, DateTime addedAt)
        initial,
    required TResult Function(
            List<CalendarEvent> calendarEvents, DateTime addedAt)
        loading,
    required TResult Function(
            List<CalendarEvent> calendarEvents, DateTime addedAt)
        loaded,
    required TResult Function(
            String error, List<CalendarEvent> calendarEvents, DateTime addedAt)
        error,
  }) {
    return error(this.error, calendarEvents, addedAt);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(List<CalendarEvent> calendarEvents, DateTime addedAt)?
        initial,
    TResult? Function(List<CalendarEvent> calendarEvents, DateTime addedAt)?
        loading,
    TResult? Function(List<CalendarEvent> calendarEvents, DateTime addedAt)?
        loaded,
    TResult? Function(
            String error, List<CalendarEvent> calendarEvents, DateTime addedAt)?
        error,
  }) {
    return error?.call(this.error, calendarEvents, addedAt);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(List<CalendarEvent> calendarEvents, DateTime addedAt)?
        initial,
    TResult Function(List<CalendarEvent> calendarEvents, DateTime addedAt)?
        loading,
    TResult Function(List<CalendarEvent> calendarEvents, DateTime addedAt)?
        loaded,
    TResult Function(
            String error, List<CalendarEvent> calendarEvents, DateTime addedAt)?
        error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this.error, calendarEvents, addedAt);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Loaded value) loaded,
    required TResult Function(_Error value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Loaded value)? loaded,
    TResult? Function(_Error value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Loaded value)? loaded,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$_ErrorToJson(
      this,
    );
  }
}

abstract class _Error extends TodaysBlueprintState {
  const factory _Error(
      {required final String error,
      required final List<CalendarEvent> calendarEvents,
      required final DateTime addedAt}) = _$_Error;
  const _Error._() : super._();

  factory _Error.fromJson(Map<String, dynamic> json) = _$_Error.fromJson;

  String get error;
  @override
  List<CalendarEvent> get calendarEvents;
  @override
  DateTime get addedAt;
  @override
  @JsonKey(ignore: true)
  _$$_ErrorCopyWith<_$_Error> get copyWith =>
      throw _privateConstructorUsedError;
}
