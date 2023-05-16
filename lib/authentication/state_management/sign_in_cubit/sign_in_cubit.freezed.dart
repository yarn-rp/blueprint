// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sign_in_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$SignInState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() processing,
    required TResult Function() successful,
    required TResult Function(Object failure) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? processing,
    TResult? Function()? successful,
    TResult? Function(Object failure)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? processing,
    TResult Function()? successful,
    TResult Function(Object failure)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(SignInProcessing value) processing,
    required TResult Function(SignInSuccessful value) successful,
    required TResult Function(SignInError value) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(SignInProcessing value)? processing,
    TResult? Function(SignInSuccessful value)? successful,
    TResult? Function(SignInError value)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(SignInProcessing value)? processing,
    TResult Function(SignInSuccessful value)? successful,
    TResult Function(SignInError value)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SignInStateCopyWith<$Res> {
  factory $SignInStateCopyWith(
          SignInState value, $Res Function(SignInState) then) =
      _$SignInStateCopyWithImpl<$Res, SignInState>;
}

/// @nodoc
class _$SignInStateCopyWithImpl<$Res, $Val extends SignInState>
    implements $SignInStateCopyWith<$Res> {
  _$SignInStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$_InitialCopyWith<$Res> {
  factory _$$_InitialCopyWith(
          _$_Initial value, $Res Function(_$_Initial) then) =
      __$$_InitialCopyWithImpl<$Res>;
}

/// @nodoc
class __$$_InitialCopyWithImpl<$Res>
    extends _$SignInStateCopyWithImpl<$Res, _$_Initial>
    implements _$$_InitialCopyWith<$Res> {
  __$$_InitialCopyWithImpl(_$_Initial _value, $Res Function(_$_Initial) _then)
      : super(_value, _then);
}

/// @nodoc

class _$_Initial implements _Initial {
  const _$_Initial();

  @override
  String toString() {
    return 'SignInState.initial()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$_Initial);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() processing,
    required TResult Function() successful,
    required TResult Function(Object failure) error,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? processing,
    TResult? Function()? successful,
    TResult? Function(Object failure)? error,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? processing,
    TResult Function()? successful,
    TResult Function(Object failure)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(SignInProcessing value) processing,
    required TResult Function(SignInSuccessful value) successful,
    required TResult Function(SignInError value) error,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(SignInProcessing value)? processing,
    TResult? Function(SignInSuccessful value)? successful,
    TResult? Function(SignInError value)? error,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(SignInProcessing value)? processing,
    TResult Function(SignInSuccessful value)? successful,
    TResult Function(SignInError value)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class _Initial implements SignInState {
  const factory _Initial() = _$_Initial;
}

/// @nodoc
abstract class _$$SignInProcessingCopyWith<$Res> {
  factory _$$SignInProcessingCopyWith(
          _$SignInProcessing value, $Res Function(_$SignInProcessing) then) =
      __$$SignInProcessingCopyWithImpl<$Res>;
}

/// @nodoc
class __$$SignInProcessingCopyWithImpl<$Res>
    extends _$SignInStateCopyWithImpl<$Res, _$SignInProcessing>
    implements _$$SignInProcessingCopyWith<$Res> {
  __$$SignInProcessingCopyWithImpl(
      _$SignInProcessing _value, $Res Function(_$SignInProcessing) _then)
      : super(_value, _then);
}

/// @nodoc

class _$SignInProcessing implements SignInProcessing {
  const _$SignInProcessing();

  @override
  String toString() {
    return 'SignInState.processing()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$SignInProcessing);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() processing,
    required TResult Function() successful,
    required TResult Function(Object failure) error,
  }) {
    return processing();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? processing,
    TResult? Function()? successful,
    TResult? Function(Object failure)? error,
  }) {
    return processing?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? processing,
    TResult Function()? successful,
    TResult Function(Object failure)? error,
    required TResult orElse(),
  }) {
    if (processing != null) {
      return processing();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(SignInProcessing value) processing,
    required TResult Function(SignInSuccessful value) successful,
    required TResult Function(SignInError value) error,
  }) {
    return processing(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(SignInProcessing value)? processing,
    TResult? Function(SignInSuccessful value)? successful,
    TResult? Function(SignInError value)? error,
  }) {
    return processing?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(SignInProcessing value)? processing,
    TResult Function(SignInSuccessful value)? successful,
    TResult Function(SignInError value)? error,
    required TResult orElse(),
  }) {
    if (processing != null) {
      return processing(this);
    }
    return orElse();
  }
}

abstract class SignInProcessing implements SignInState {
  const factory SignInProcessing() = _$SignInProcessing;
}

/// @nodoc
abstract class _$$SignInSuccessfulCopyWith<$Res> {
  factory _$$SignInSuccessfulCopyWith(
          _$SignInSuccessful value, $Res Function(_$SignInSuccessful) then) =
      __$$SignInSuccessfulCopyWithImpl<$Res>;
}

/// @nodoc
class __$$SignInSuccessfulCopyWithImpl<$Res>
    extends _$SignInStateCopyWithImpl<$Res, _$SignInSuccessful>
    implements _$$SignInSuccessfulCopyWith<$Res> {
  __$$SignInSuccessfulCopyWithImpl(
      _$SignInSuccessful _value, $Res Function(_$SignInSuccessful) _then)
      : super(_value, _then);
}

/// @nodoc

class _$SignInSuccessful implements SignInSuccessful {
  const _$SignInSuccessful();

  @override
  String toString() {
    return 'SignInState.successful()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$SignInSuccessful);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() processing,
    required TResult Function() successful,
    required TResult Function(Object failure) error,
  }) {
    return successful();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? processing,
    TResult? Function()? successful,
    TResult? Function(Object failure)? error,
  }) {
    return successful?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? processing,
    TResult Function()? successful,
    TResult Function(Object failure)? error,
    required TResult orElse(),
  }) {
    if (successful != null) {
      return successful();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(SignInProcessing value) processing,
    required TResult Function(SignInSuccessful value) successful,
    required TResult Function(SignInError value) error,
  }) {
    return successful(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(SignInProcessing value)? processing,
    TResult? Function(SignInSuccessful value)? successful,
    TResult? Function(SignInError value)? error,
  }) {
    return successful?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(SignInProcessing value)? processing,
    TResult Function(SignInSuccessful value)? successful,
    TResult Function(SignInError value)? error,
    required TResult orElse(),
  }) {
    if (successful != null) {
      return successful(this);
    }
    return orElse();
  }
}

abstract class SignInSuccessful implements SignInState {
  const factory SignInSuccessful() = _$SignInSuccessful;
}

/// @nodoc
abstract class _$$SignInErrorCopyWith<$Res> {
  factory _$$SignInErrorCopyWith(
          _$SignInError value, $Res Function(_$SignInError) then) =
      __$$SignInErrorCopyWithImpl<$Res>;
  @useResult
  $Res call({Object failure});
}

/// @nodoc
class __$$SignInErrorCopyWithImpl<$Res>
    extends _$SignInStateCopyWithImpl<$Res, _$SignInError>
    implements _$$SignInErrorCopyWith<$Res> {
  __$$SignInErrorCopyWithImpl(
      _$SignInError _value, $Res Function(_$SignInError) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? failure = null,
  }) {
    return _then(_$SignInError(
      null == failure ? _value.failure : failure,
    ));
  }
}

/// @nodoc

class _$SignInError implements SignInError {
  const _$SignInError(this.failure);

  @override
  final Object failure;

  @override
  String toString() {
    return 'SignInState.error(failure: $failure)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SignInError &&
            const DeepCollectionEquality().equals(other.failure, failure));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(failure));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SignInErrorCopyWith<_$SignInError> get copyWith =>
      __$$SignInErrorCopyWithImpl<_$SignInError>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() processing,
    required TResult Function() successful,
    required TResult Function(Object failure) error,
  }) {
    return error(failure);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? processing,
    TResult? Function()? successful,
    TResult? Function(Object failure)? error,
  }) {
    return error?.call(failure);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? processing,
    TResult Function()? successful,
    TResult Function(Object failure)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(failure);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(SignInProcessing value) processing,
    required TResult Function(SignInSuccessful value) successful,
    required TResult Function(SignInError value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(SignInProcessing value)? processing,
    TResult? Function(SignInSuccessful value)? successful,
    TResult? Function(SignInError value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(SignInProcessing value)? processing,
    TResult Function(SignInSuccessful value)? successful,
    TResult Function(SignInError value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class SignInError implements SignInState {
  const factory SignInError(final Object failure) = _$SignInError;

  Object get failure;
  @JsonKey(ignore: true)
  _$$SignInErrorCopyWith<_$SignInError> get copyWith =>
      throw _privateConstructorUsedError;
}
