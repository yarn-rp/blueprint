// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'tasks_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$TasksState {
  List<Task> get tasks => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(List<Task> tasks) initial,
    required TResult Function(List<Task> tasks) loading,
    required TResult Function(List<Task> tasks) loaded,
    required TResult Function(List<Task> tasks, String message) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(List<Task> tasks)? initial,
    TResult? Function(List<Task> tasks)? loading,
    TResult? Function(List<Task> tasks)? loaded,
    TResult? Function(List<Task> tasks, String message)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(List<Task> tasks)? initial,
    TResult Function(List<Task> tasks)? loading,
    TResult Function(List<Task> tasks)? loaded,
    TResult Function(List<Task> tasks, String message)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(TasksInitial value) initial,
    required TResult Function(TasksLoading value) loading,
    required TResult Function(TasksLoaded value) loaded,
    required TResult Function(TasksError value) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(TasksInitial value)? initial,
    TResult? Function(TasksLoading value)? loading,
    TResult? Function(TasksLoaded value)? loaded,
    TResult? Function(TasksError value)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(TasksInitial value)? initial,
    TResult Function(TasksLoading value)? loading,
    TResult Function(TasksLoaded value)? loaded,
    TResult Function(TasksError value)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $TasksStateCopyWith<TasksState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TasksStateCopyWith<$Res> {
  factory $TasksStateCopyWith(
          TasksState value, $Res Function(TasksState) then) =
      _$TasksStateCopyWithImpl<$Res, TasksState>;
  @useResult
  $Res call({List<Task> tasks});
}

/// @nodoc
class _$TasksStateCopyWithImpl<$Res, $Val extends TasksState>
    implements $TasksStateCopyWith<$Res> {
  _$TasksStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? tasks = null,
  }) {
    return _then(_value.copyWith(
      tasks: null == tasks
          ? _value.tasks
          : tasks // ignore: cast_nullable_to_non_nullable
              as List<Task>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TasksInitialCopyWith<$Res>
    implements $TasksStateCopyWith<$Res> {
  factory _$$TasksInitialCopyWith(
          _$TasksInitial value, $Res Function(_$TasksInitial) then) =
      __$$TasksInitialCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<Task> tasks});
}

/// @nodoc
class __$$TasksInitialCopyWithImpl<$Res>
    extends _$TasksStateCopyWithImpl<$Res, _$TasksInitial>
    implements _$$TasksInitialCopyWith<$Res> {
  __$$TasksInitialCopyWithImpl(
      _$TasksInitial _value, $Res Function(_$TasksInitial) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? tasks = null,
  }) {
    return _then(_$TasksInitial(
      null == tasks
          ? _value._tasks
          : tasks // ignore: cast_nullable_to_non_nullable
              as List<Task>,
    ));
  }
}

/// @nodoc

class _$TasksInitial implements TasksInitial {
  const _$TasksInitial(final List<Task> tasks) : _tasks = tasks;

  final List<Task> _tasks;
  @override
  List<Task> get tasks {
    if (_tasks is EqualUnmodifiableListView) return _tasks;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_tasks);
  }

  @override
  String toString() {
    return 'TasksState.initial(tasks: $tasks)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TasksInitial &&
            const DeepCollectionEquality().equals(other._tasks, _tasks));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_tasks));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TasksInitialCopyWith<_$TasksInitial> get copyWith =>
      __$$TasksInitialCopyWithImpl<_$TasksInitial>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(List<Task> tasks) initial,
    required TResult Function(List<Task> tasks) loading,
    required TResult Function(List<Task> tasks) loaded,
    required TResult Function(List<Task> tasks, String message) error,
  }) {
    return initial(tasks);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(List<Task> tasks)? initial,
    TResult? Function(List<Task> tasks)? loading,
    TResult? Function(List<Task> tasks)? loaded,
    TResult? Function(List<Task> tasks, String message)? error,
  }) {
    return initial?.call(tasks);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(List<Task> tasks)? initial,
    TResult Function(List<Task> tasks)? loading,
    TResult Function(List<Task> tasks)? loaded,
    TResult Function(List<Task> tasks, String message)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(tasks);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(TasksInitial value) initial,
    required TResult Function(TasksLoading value) loading,
    required TResult Function(TasksLoaded value) loaded,
    required TResult Function(TasksError value) error,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(TasksInitial value)? initial,
    TResult? Function(TasksLoading value)? loading,
    TResult? Function(TasksLoaded value)? loaded,
    TResult? Function(TasksError value)? error,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(TasksInitial value)? initial,
    TResult Function(TasksLoading value)? loading,
    TResult Function(TasksLoaded value)? loaded,
    TResult Function(TasksError value)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class TasksInitial implements TasksState {
  const factory TasksInitial(final List<Task> tasks) = _$TasksInitial;

  @override
  List<Task> get tasks;
  @override
  @JsonKey(ignore: true)
  _$$TasksInitialCopyWith<_$TasksInitial> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$TasksLoadingCopyWith<$Res>
    implements $TasksStateCopyWith<$Res> {
  factory _$$TasksLoadingCopyWith(
          _$TasksLoading value, $Res Function(_$TasksLoading) then) =
      __$$TasksLoadingCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<Task> tasks});
}

/// @nodoc
class __$$TasksLoadingCopyWithImpl<$Res>
    extends _$TasksStateCopyWithImpl<$Res, _$TasksLoading>
    implements _$$TasksLoadingCopyWith<$Res> {
  __$$TasksLoadingCopyWithImpl(
      _$TasksLoading _value, $Res Function(_$TasksLoading) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? tasks = null,
  }) {
    return _then(_$TasksLoading(
      null == tasks
          ? _value._tasks
          : tasks // ignore: cast_nullable_to_non_nullable
              as List<Task>,
    ));
  }
}

/// @nodoc

class _$TasksLoading implements TasksLoading {
  const _$TasksLoading(final List<Task> tasks) : _tasks = tasks;

  final List<Task> _tasks;
  @override
  List<Task> get tasks {
    if (_tasks is EqualUnmodifiableListView) return _tasks;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_tasks);
  }

  @override
  String toString() {
    return 'TasksState.loading(tasks: $tasks)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TasksLoading &&
            const DeepCollectionEquality().equals(other._tasks, _tasks));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_tasks));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TasksLoadingCopyWith<_$TasksLoading> get copyWith =>
      __$$TasksLoadingCopyWithImpl<_$TasksLoading>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(List<Task> tasks) initial,
    required TResult Function(List<Task> tasks) loading,
    required TResult Function(List<Task> tasks) loaded,
    required TResult Function(List<Task> tasks, String message) error,
  }) {
    return loading(tasks);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(List<Task> tasks)? initial,
    TResult? Function(List<Task> tasks)? loading,
    TResult? Function(List<Task> tasks)? loaded,
    TResult? Function(List<Task> tasks, String message)? error,
  }) {
    return loading?.call(tasks);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(List<Task> tasks)? initial,
    TResult Function(List<Task> tasks)? loading,
    TResult Function(List<Task> tasks)? loaded,
    TResult Function(List<Task> tasks, String message)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(tasks);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(TasksInitial value) initial,
    required TResult Function(TasksLoading value) loading,
    required TResult Function(TasksLoaded value) loaded,
    required TResult Function(TasksError value) error,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(TasksInitial value)? initial,
    TResult? Function(TasksLoading value)? loading,
    TResult? Function(TasksLoaded value)? loaded,
    TResult? Function(TasksError value)? error,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(TasksInitial value)? initial,
    TResult Function(TasksLoading value)? loading,
    TResult Function(TasksLoaded value)? loaded,
    TResult Function(TasksError value)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class TasksLoading implements TasksState {
  const factory TasksLoading(final List<Task> tasks) = _$TasksLoading;

  @override
  List<Task> get tasks;
  @override
  @JsonKey(ignore: true)
  _$$TasksLoadingCopyWith<_$TasksLoading> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$TasksLoadedCopyWith<$Res>
    implements $TasksStateCopyWith<$Res> {
  factory _$$TasksLoadedCopyWith(
          _$TasksLoaded value, $Res Function(_$TasksLoaded) then) =
      __$$TasksLoadedCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<Task> tasks});
}

/// @nodoc
class __$$TasksLoadedCopyWithImpl<$Res>
    extends _$TasksStateCopyWithImpl<$Res, _$TasksLoaded>
    implements _$$TasksLoadedCopyWith<$Res> {
  __$$TasksLoadedCopyWithImpl(
      _$TasksLoaded _value, $Res Function(_$TasksLoaded) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? tasks = null,
  }) {
    return _then(_$TasksLoaded(
      null == tasks
          ? _value._tasks
          : tasks // ignore: cast_nullable_to_non_nullable
              as List<Task>,
    ));
  }
}

/// @nodoc

class _$TasksLoaded implements TasksLoaded {
  const _$TasksLoaded(final List<Task> tasks) : _tasks = tasks;

  final List<Task> _tasks;
  @override
  List<Task> get tasks {
    if (_tasks is EqualUnmodifiableListView) return _tasks;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_tasks);
  }

  @override
  String toString() {
    return 'TasksState.loaded(tasks: $tasks)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TasksLoaded &&
            const DeepCollectionEquality().equals(other._tasks, _tasks));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_tasks));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TasksLoadedCopyWith<_$TasksLoaded> get copyWith =>
      __$$TasksLoadedCopyWithImpl<_$TasksLoaded>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(List<Task> tasks) initial,
    required TResult Function(List<Task> tasks) loading,
    required TResult Function(List<Task> tasks) loaded,
    required TResult Function(List<Task> tasks, String message) error,
  }) {
    return loaded(tasks);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(List<Task> tasks)? initial,
    TResult? Function(List<Task> tasks)? loading,
    TResult? Function(List<Task> tasks)? loaded,
    TResult? Function(List<Task> tasks, String message)? error,
  }) {
    return loaded?.call(tasks);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(List<Task> tasks)? initial,
    TResult Function(List<Task> tasks)? loading,
    TResult Function(List<Task> tasks)? loaded,
    TResult Function(List<Task> tasks, String message)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(tasks);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(TasksInitial value) initial,
    required TResult Function(TasksLoading value) loading,
    required TResult Function(TasksLoaded value) loaded,
    required TResult Function(TasksError value) error,
  }) {
    return loaded(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(TasksInitial value)? initial,
    TResult? Function(TasksLoading value)? loading,
    TResult? Function(TasksLoaded value)? loaded,
    TResult? Function(TasksError value)? error,
  }) {
    return loaded?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(TasksInitial value)? initial,
    TResult Function(TasksLoading value)? loading,
    TResult Function(TasksLoaded value)? loaded,
    TResult Function(TasksError value)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(this);
    }
    return orElse();
  }
}

abstract class TasksLoaded implements TasksState {
  const factory TasksLoaded(final List<Task> tasks) = _$TasksLoaded;

  @override
  List<Task> get tasks;
  @override
  @JsonKey(ignore: true)
  _$$TasksLoadedCopyWith<_$TasksLoaded> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$TasksErrorCopyWith<$Res>
    implements $TasksStateCopyWith<$Res> {
  factory _$$TasksErrorCopyWith(
          _$TasksError value, $Res Function(_$TasksError) then) =
      __$$TasksErrorCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<Task> tasks, String message});
}

/// @nodoc
class __$$TasksErrorCopyWithImpl<$Res>
    extends _$TasksStateCopyWithImpl<$Res, _$TasksError>
    implements _$$TasksErrorCopyWith<$Res> {
  __$$TasksErrorCopyWithImpl(
      _$TasksError _value, $Res Function(_$TasksError) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? tasks = null,
    Object? message = null,
  }) {
    return _then(_$TasksError(
      null == tasks
          ? _value._tasks
          : tasks // ignore: cast_nullable_to_non_nullable
              as List<Task>,
      null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$TasksError implements TasksError {
  const _$TasksError(final List<Task> tasks, this.message) : _tasks = tasks;

  final List<Task> _tasks;
  @override
  List<Task> get tasks {
    if (_tasks is EqualUnmodifiableListView) return _tasks;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_tasks);
  }

  @override
  final String message;

  @override
  String toString() {
    return 'TasksState.error(tasks: $tasks, message: $message)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TasksError &&
            const DeepCollectionEquality().equals(other._tasks, _tasks) &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_tasks), message);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TasksErrorCopyWith<_$TasksError> get copyWith =>
      __$$TasksErrorCopyWithImpl<_$TasksError>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(List<Task> tasks) initial,
    required TResult Function(List<Task> tasks) loading,
    required TResult Function(List<Task> tasks) loaded,
    required TResult Function(List<Task> tasks, String message) error,
  }) {
    return error(tasks, message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(List<Task> tasks)? initial,
    TResult? Function(List<Task> tasks)? loading,
    TResult? Function(List<Task> tasks)? loaded,
    TResult? Function(List<Task> tasks, String message)? error,
  }) {
    return error?.call(tasks, message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(List<Task> tasks)? initial,
    TResult Function(List<Task> tasks)? loading,
    TResult Function(List<Task> tasks)? loaded,
    TResult Function(List<Task> tasks, String message)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(tasks, message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(TasksInitial value) initial,
    required TResult Function(TasksLoading value) loading,
    required TResult Function(TasksLoaded value) loaded,
    required TResult Function(TasksError value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(TasksInitial value)? initial,
    TResult? Function(TasksLoading value)? loading,
    TResult? Function(TasksLoaded value)? loaded,
    TResult? Function(TasksError value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(TasksInitial value)? initial,
    TResult Function(TasksLoading value)? loading,
    TResult Function(TasksLoaded value)? loaded,
    TResult Function(TasksError value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class TasksError implements TasksState {
  const factory TasksError(final List<Task> tasks, final String message) =
      _$TasksError;

  @override
  List<Task> get tasks;
  String get message;
  @override
  @JsonKey(ignore: true)
  _$$TasksErrorCopyWith<_$TasksError> get copyWith =>
      throw _privateConstructorUsedError;
}
