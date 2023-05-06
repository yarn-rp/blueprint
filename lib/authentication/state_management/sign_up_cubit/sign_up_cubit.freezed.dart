// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sign_up_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$SignUpState {
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
    required TResult Function(SignUpProcessing value) processing,
    required TResult Function(SignUpSuccessful value) successful,
    required TResult Function(SignUpError value) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(SignUpProcessing value)? processing,
    TResult? Function(SignUpSuccessful value)? successful,
    TResult? Function(SignUpError value)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(SignUpProcessing value)? processing,
    TResult Function(SignUpSuccessful value)? successful,
    TResult Function(SignUpError value)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SignUpStateCopyWith<$Res> {
  factory $SignUpStateCopyWith(
          SignUpState value, $Res Function(SignUpState) then) =
      _$SignUpStateCopyWithImpl<$Res, SignUpState>;
}

/// @nodoc
class _$SignUpStateCopyWithImpl<$Res, $Val extends SignUpState>
    implements $SignUpStateCopyWith<$Res> {
  _$SignUpStateCopyWithImpl(this._value, this._then);

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
    extends _$SignUpStateCopyWithImpl<$Res, _$_Initial>
    implements _$$_InitialCopyWith<$Res> {
  __$$_InitialCopyWithImpl(_$_Initial _value, $Res Function(_$_Initial) _then)
      : super(_value, _then);
}

/// @nodoc

class _$_Initial implements _Initial {
  const _$_Initial();

  @override
  String toString() {
    return 'SignUpState.initial()';
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
    required TResult Function(SignUpProcessing value) processing,
    required TResult Function(SignUpSuccessful value) successful,
    required TResult Function(SignUpError value) error,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(SignUpProcessing value)? processing,
    TResult? Function(SignUpSuccessful value)? successful,
    TResult? Function(SignUpError value)? error,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(SignUpProcessing value)? processing,
    TResult Function(SignUpSuccessful value)? successful,
    TResult Function(SignUpError value)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class _Initial implements SignUpState {
  const factory _Initial() = _$_Initial;
}

/// @nodoc
abstract class _$$SignUpProcessingCopyWith<$Res> {
  factory _$$SignUpProcessingCopyWith(
          _$SignUpProcessing value, $Res Function(_$SignUpProcessing) then) =
      __$$SignUpProcessingCopyWithImpl<$Res>;
}

/// @nodoc
class __$$SignUpProcessingCopyWithImpl<$Res>
    extends _$SignUpStateCopyWithImpl<$Res, _$SignUpProcessing>
    implements _$$SignUpProcessingCopyWith<$Res> {
  __$$SignUpProcessingCopyWithImpl(
      _$SignUpProcessing _value, $Res Function(_$SignUpProcessing) _then)
      : super(_value, _then);
}

/// @nodoc

class _$SignUpProcessing implements SignUpProcessing {
  const _$SignUpProcessing();

  @override
  String toString() {
    return 'SignUpState.processing()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$SignUpProcessing);
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
    required TResult Function(SignUpProcessing value) processing,
    required TResult Function(SignUpSuccessful value) successful,
    required TResult Function(SignUpError value) error,
  }) {
    return processing(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(SignUpProcessing value)? processing,
    TResult? Function(SignUpSuccessful value)? successful,
    TResult? Function(SignUpError value)? error,
  }) {
    return processing?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(SignUpProcessing value)? processing,
    TResult Function(SignUpSuccessful value)? successful,
    TResult Function(SignUpError value)? error,
    required TResult orElse(),
  }) {
    if (processing != null) {
      return processing(this);
    }
    return orElse();
  }
}

abstract class SignUpProcessing implements SignUpState {
  const factory SignUpProcessing() = _$SignUpProcessing;
}

/// @nodoc
abstract class _$$SignUpSuccessfulCopyWith<$Res> {
  factory _$$SignUpSuccessfulCopyWith(
          _$SignUpSuccessful value, $Res Function(_$SignUpSuccessful) then) =
      __$$SignUpSuccessfulCopyWithImpl<$Res>;
}

/// @nodoc
class __$$SignUpSuccessfulCopyWithImpl<$Res>
    extends _$SignUpStateCopyWithImpl<$Res, _$SignUpSuccessful>
    implements _$$SignUpSuccessfulCopyWith<$Res> {
  __$$SignUpSuccessfulCopyWithImpl(
      _$SignUpSuccessful _value, $Res Function(_$SignUpSuccessful) _then)
      : super(_value, _then);
}

/// @nodoc

class _$SignUpSuccessful implements SignUpSuccessful {
  const _$SignUpSuccessful();

  @override
  String toString() {
    return 'SignUpState.successful()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$SignUpSuccessful);
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
    required TResult Function(SignUpProcessing value) processing,
    required TResult Function(SignUpSuccessful value) successful,
    required TResult Function(SignUpError value) error,
  }) {
    return successful(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(SignUpProcessing value)? processing,
    TResult? Function(SignUpSuccessful value)? successful,
    TResult? Function(SignUpError value)? error,
  }) {
    return successful?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(SignUpProcessing value)? processing,
    TResult Function(SignUpSuccessful value)? successful,
    TResult Function(SignUpError value)? error,
    required TResult orElse(),
  }) {
    if (successful != null) {
      return successful(this);
    }
    return orElse();
  }
}

abstract class SignUpSuccessful implements SignUpState {
  const factory SignUpSuccessful() = _$SignUpSuccessful;
}

/// @nodoc
abstract class _$$SignUpErrorCopyWith<$Res> {
  factory _$$SignUpErrorCopyWith(
          _$SignUpError value, $Res Function(_$SignUpError) then) =
      __$$SignUpErrorCopyWithImpl<$Res>;
  @useResult
  $Res call({Object failure});
}

/// @nodoc
class __$$SignUpErrorCopyWithImpl<$Res>
    extends _$SignUpStateCopyWithImpl<$Res, _$SignUpError>
    implements _$$SignUpErrorCopyWith<$Res> {
  __$$SignUpErrorCopyWithImpl(
      _$SignUpError _value, $Res Function(_$SignUpError) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? failure = null,
  }) {
    return _then(_$SignUpError(
      null == failure ? _value.failure : failure,
    ));
  }
}

/// @nodoc

class _$SignUpError implements SignUpError {
  const _$SignUpError(this.failure);

  @override
  final Object failure;

  @override
  String toString() {
    return 'SignUpState.error(failure: $failure)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SignUpError &&
            const DeepCollectionEquality().equals(other.failure, failure));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(failure));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SignUpErrorCopyWith<_$SignUpError> get copyWith =>
      __$$SignUpErrorCopyWithImpl<_$SignUpError>(this, _$identity);

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
    required TResult Function(SignUpProcessing value) processing,
    required TResult Function(SignUpSuccessful value) successful,
    required TResult Function(SignUpError value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(SignUpProcessing value)? processing,
    TResult? Function(SignUpSuccessful value)? successful,
    TResult? Function(SignUpError value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(SignUpProcessing value)? processing,
    TResult Function(SignUpSuccessful value)? successful,
    TResult Function(SignUpError value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class SignUpError implements SignUpState {
  const factory SignUpError(final Object failure) = _$SignUpError;

  Object get failure;
  @JsonKey(ignore: true)
  _$$SignUpErrorCopyWith<_$SignUpError> get copyWith =>
      throw _privateConstructorUsedError;
}
