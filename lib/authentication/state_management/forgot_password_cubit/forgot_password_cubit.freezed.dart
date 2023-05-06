// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'forgot_password_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$ForgotPasswordState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(String email) resettingPassword,
    required TResult Function(String email) passwordReset,
    required TResult Function(Object failure) errorResettingPassword,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(String email)? resettingPassword,
    TResult? Function(String email)? passwordReset,
    TResult? Function(Object failure)? errorResettingPassword,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(String email)? resettingPassword,
    TResult Function(String email)? passwordReset,
    TResult Function(Object failure)? errorResettingPassword,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(ResettingPasswordState value) resettingPassword,
    required TResult Function(PasswordResetState value) passwordReset,
    required TResult Function(ErrorResettingPasswordState value)
        errorResettingPassword,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(ResettingPasswordState value)? resettingPassword,
    TResult? Function(PasswordResetState value)? passwordReset,
    TResult? Function(ErrorResettingPasswordState value)?
        errorResettingPassword,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(ResettingPasswordState value)? resettingPassword,
    TResult Function(PasswordResetState value)? passwordReset,
    TResult Function(ErrorResettingPasswordState value)? errorResettingPassword,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ForgotPasswordStateCopyWith<$Res> {
  factory $ForgotPasswordStateCopyWith(
          ForgotPasswordState value, $Res Function(ForgotPasswordState) then) =
      _$ForgotPasswordStateCopyWithImpl<$Res, ForgotPasswordState>;
}

/// @nodoc
class _$ForgotPasswordStateCopyWithImpl<$Res, $Val extends ForgotPasswordState>
    implements $ForgotPasswordStateCopyWith<$Res> {
  _$ForgotPasswordStateCopyWithImpl(this._value, this._then);

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
    extends _$ForgotPasswordStateCopyWithImpl<$Res, _$_Initial>
    implements _$$_InitialCopyWith<$Res> {
  __$$_InitialCopyWithImpl(_$_Initial _value, $Res Function(_$_Initial) _then)
      : super(_value, _then);
}

/// @nodoc

class _$_Initial implements _Initial {
  const _$_Initial();

  @override
  String toString() {
    return 'ForgotPasswordState.initial()';
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
    required TResult Function(String email) resettingPassword,
    required TResult Function(String email) passwordReset,
    required TResult Function(Object failure) errorResettingPassword,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(String email)? resettingPassword,
    TResult? Function(String email)? passwordReset,
    TResult? Function(Object failure)? errorResettingPassword,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(String email)? resettingPassword,
    TResult Function(String email)? passwordReset,
    TResult Function(Object failure)? errorResettingPassword,
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
    required TResult Function(ResettingPasswordState value) resettingPassword,
    required TResult Function(PasswordResetState value) passwordReset,
    required TResult Function(ErrorResettingPasswordState value)
        errorResettingPassword,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(ResettingPasswordState value)? resettingPassword,
    TResult? Function(PasswordResetState value)? passwordReset,
    TResult? Function(ErrorResettingPasswordState value)?
        errorResettingPassword,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(ResettingPasswordState value)? resettingPassword,
    TResult Function(PasswordResetState value)? passwordReset,
    TResult Function(ErrorResettingPasswordState value)? errorResettingPassword,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class _Initial implements ForgotPasswordState {
  const factory _Initial() = _$_Initial;
}

/// @nodoc
abstract class _$$ResettingPasswordStateCopyWith<$Res> {
  factory _$$ResettingPasswordStateCopyWith(_$ResettingPasswordState value,
          $Res Function(_$ResettingPasswordState) then) =
      __$$ResettingPasswordStateCopyWithImpl<$Res>;
  @useResult
  $Res call({String email});
}

/// @nodoc
class __$$ResettingPasswordStateCopyWithImpl<$Res>
    extends _$ForgotPasswordStateCopyWithImpl<$Res, _$ResettingPasswordState>
    implements _$$ResettingPasswordStateCopyWith<$Res> {
  __$$ResettingPasswordStateCopyWithImpl(_$ResettingPasswordState _value,
      $Res Function(_$ResettingPasswordState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? email = null,
  }) {
    return _then(_$ResettingPasswordState(
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$ResettingPasswordState implements ResettingPasswordState {
  const _$ResettingPasswordState({required this.email});

  @override
  final String email;

  @override
  String toString() {
    return 'ForgotPasswordState.resettingPassword(email: $email)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ResettingPasswordState &&
            (identical(other.email, email) || other.email == email));
  }

  @override
  int get hashCode => Object.hash(runtimeType, email);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ResettingPasswordStateCopyWith<_$ResettingPasswordState> get copyWith =>
      __$$ResettingPasswordStateCopyWithImpl<_$ResettingPasswordState>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(String email) resettingPassword,
    required TResult Function(String email) passwordReset,
    required TResult Function(Object failure) errorResettingPassword,
  }) {
    return resettingPassword(email);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(String email)? resettingPassword,
    TResult? Function(String email)? passwordReset,
    TResult? Function(Object failure)? errorResettingPassword,
  }) {
    return resettingPassword?.call(email);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(String email)? resettingPassword,
    TResult Function(String email)? passwordReset,
    TResult Function(Object failure)? errorResettingPassword,
    required TResult orElse(),
  }) {
    if (resettingPassword != null) {
      return resettingPassword(email);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(ResettingPasswordState value) resettingPassword,
    required TResult Function(PasswordResetState value) passwordReset,
    required TResult Function(ErrorResettingPasswordState value)
        errorResettingPassword,
  }) {
    return resettingPassword(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(ResettingPasswordState value)? resettingPassword,
    TResult? Function(PasswordResetState value)? passwordReset,
    TResult? Function(ErrorResettingPasswordState value)?
        errorResettingPassword,
  }) {
    return resettingPassword?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(ResettingPasswordState value)? resettingPassword,
    TResult Function(PasswordResetState value)? passwordReset,
    TResult Function(ErrorResettingPasswordState value)? errorResettingPassword,
    required TResult orElse(),
  }) {
    if (resettingPassword != null) {
      return resettingPassword(this);
    }
    return orElse();
  }
}

abstract class ResettingPasswordState implements ForgotPasswordState {
  const factory ResettingPasswordState({required final String email}) =
      _$ResettingPasswordState;

  String get email;
  @JsonKey(ignore: true)
  _$$ResettingPasswordStateCopyWith<_$ResettingPasswordState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$PasswordResetStateCopyWith<$Res> {
  factory _$$PasswordResetStateCopyWith(_$PasswordResetState value,
          $Res Function(_$PasswordResetState) then) =
      __$$PasswordResetStateCopyWithImpl<$Res>;
  @useResult
  $Res call({String email});
}

/// @nodoc
class __$$PasswordResetStateCopyWithImpl<$Res>
    extends _$ForgotPasswordStateCopyWithImpl<$Res, _$PasswordResetState>
    implements _$$PasswordResetStateCopyWith<$Res> {
  __$$PasswordResetStateCopyWithImpl(
      _$PasswordResetState _value, $Res Function(_$PasswordResetState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? email = null,
  }) {
    return _then(_$PasswordResetState(
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$PasswordResetState implements PasswordResetState {
  const _$PasswordResetState({required this.email});

  @override
  final String email;

  @override
  String toString() {
    return 'ForgotPasswordState.passwordReset(email: $email)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PasswordResetState &&
            (identical(other.email, email) || other.email == email));
  }

  @override
  int get hashCode => Object.hash(runtimeType, email);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PasswordResetStateCopyWith<_$PasswordResetState> get copyWith =>
      __$$PasswordResetStateCopyWithImpl<_$PasswordResetState>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(String email) resettingPassword,
    required TResult Function(String email) passwordReset,
    required TResult Function(Object failure) errorResettingPassword,
  }) {
    return passwordReset(email);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(String email)? resettingPassword,
    TResult? Function(String email)? passwordReset,
    TResult? Function(Object failure)? errorResettingPassword,
  }) {
    return passwordReset?.call(email);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(String email)? resettingPassword,
    TResult Function(String email)? passwordReset,
    TResult Function(Object failure)? errorResettingPassword,
    required TResult orElse(),
  }) {
    if (passwordReset != null) {
      return passwordReset(email);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(ResettingPasswordState value) resettingPassword,
    required TResult Function(PasswordResetState value) passwordReset,
    required TResult Function(ErrorResettingPasswordState value)
        errorResettingPassword,
  }) {
    return passwordReset(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(ResettingPasswordState value)? resettingPassword,
    TResult? Function(PasswordResetState value)? passwordReset,
    TResult? Function(ErrorResettingPasswordState value)?
        errorResettingPassword,
  }) {
    return passwordReset?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(ResettingPasswordState value)? resettingPassword,
    TResult Function(PasswordResetState value)? passwordReset,
    TResult Function(ErrorResettingPasswordState value)? errorResettingPassword,
    required TResult orElse(),
  }) {
    if (passwordReset != null) {
      return passwordReset(this);
    }
    return orElse();
  }
}

abstract class PasswordResetState implements ForgotPasswordState {
  const factory PasswordResetState({required final String email}) =
      _$PasswordResetState;

  String get email;
  @JsonKey(ignore: true)
  _$$PasswordResetStateCopyWith<_$PasswordResetState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ErrorResettingPasswordStateCopyWith<$Res> {
  factory _$$ErrorResettingPasswordStateCopyWith(
          _$ErrorResettingPasswordState value,
          $Res Function(_$ErrorResettingPasswordState) then) =
      __$$ErrorResettingPasswordStateCopyWithImpl<$Res>;
  @useResult
  $Res call({Object failure});
}

/// @nodoc
class __$$ErrorResettingPasswordStateCopyWithImpl<$Res>
    extends _$ForgotPasswordStateCopyWithImpl<$Res,
        _$ErrorResettingPasswordState>
    implements _$$ErrorResettingPasswordStateCopyWith<$Res> {
  __$$ErrorResettingPasswordStateCopyWithImpl(
      _$ErrorResettingPasswordState _value,
      $Res Function(_$ErrorResettingPasswordState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? failure = null,
  }) {
    return _then(_$ErrorResettingPasswordState(
      null == failure ? _value.failure : failure,
    ));
  }
}

/// @nodoc

class _$ErrorResettingPasswordState implements ErrorResettingPasswordState {
  const _$ErrorResettingPasswordState(this.failure);

  @override
  final Object failure;

  @override
  String toString() {
    return 'ForgotPasswordState.errorResettingPassword(failure: $failure)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ErrorResettingPasswordState &&
            const DeepCollectionEquality().equals(other.failure, failure));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(failure));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ErrorResettingPasswordStateCopyWith<_$ErrorResettingPasswordState>
      get copyWith => __$$ErrorResettingPasswordStateCopyWithImpl<
          _$ErrorResettingPasswordState>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(String email) resettingPassword,
    required TResult Function(String email) passwordReset,
    required TResult Function(Object failure) errorResettingPassword,
  }) {
    return errorResettingPassword(failure);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(String email)? resettingPassword,
    TResult? Function(String email)? passwordReset,
    TResult? Function(Object failure)? errorResettingPassword,
  }) {
    return errorResettingPassword?.call(failure);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(String email)? resettingPassword,
    TResult Function(String email)? passwordReset,
    TResult Function(Object failure)? errorResettingPassword,
    required TResult orElse(),
  }) {
    if (errorResettingPassword != null) {
      return errorResettingPassword(failure);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(ResettingPasswordState value) resettingPassword,
    required TResult Function(PasswordResetState value) passwordReset,
    required TResult Function(ErrorResettingPasswordState value)
        errorResettingPassword,
  }) {
    return errorResettingPassword(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(ResettingPasswordState value)? resettingPassword,
    TResult? Function(PasswordResetState value)? passwordReset,
    TResult? Function(ErrorResettingPasswordState value)?
        errorResettingPassword,
  }) {
    return errorResettingPassword?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(ResettingPasswordState value)? resettingPassword,
    TResult Function(PasswordResetState value)? passwordReset,
    TResult Function(ErrorResettingPasswordState value)? errorResettingPassword,
    required TResult orElse(),
  }) {
    if (errorResettingPassword != null) {
      return errorResettingPassword(this);
    }
    return orElse();
  }
}

abstract class ErrorResettingPasswordState implements ForgotPasswordState {
  const factory ErrorResettingPasswordState(final Object failure) =
      _$ErrorResettingPasswordState;

  Object get failure;
  @JsonKey(ignore: true)
  _$$ErrorResettingPasswordStateCopyWith<_$ErrorResettingPasswordState>
      get copyWith => throw _privateConstructorUsedError;
}
