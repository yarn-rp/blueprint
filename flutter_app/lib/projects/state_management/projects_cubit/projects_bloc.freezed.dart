// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'projects_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$ProjectsState {
  List<Project> get projects => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(List<Project> projects) initial,
    required TResult Function(List<Project> projects) loading,
    required TResult Function(List<Project> projects, Project projectModifying)
        modifyingProject,
    required TResult Function(List<Project> projects) loaded,
    required TResult Function(List<Project> projects, String message) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(List<Project> projects)? initial,
    TResult? Function(List<Project> projects)? loading,
    TResult? Function(List<Project> projects, Project projectModifying)?
        modifyingProject,
    TResult? Function(List<Project> projects)? loaded,
    TResult? Function(List<Project> projects, String message)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(List<Project> projects)? initial,
    TResult Function(List<Project> projects)? loading,
    TResult Function(List<Project> projects, Project projectModifying)?
        modifyingProject,
    TResult Function(List<Project> projects)? loaded,
    TResult Function(List<Project> projects, String message)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ProjectsInitial value) initial,
    required TResult Function(ProjectsLoading value) loading,
    required TResult Function(ProjectsModifyingProject value) modifyingProject,
    required TResult Function(ProjectsLoaded value) loaded,
    required TResult Function(ProjectsError value) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ProjectsInitial value)? initial,
    TResult? Function(ProjectsLoading value)? loading,
    TResult? Function(ProjectsModifyingProject value)? modifyingProject,
    TResult? Function(ProjectsLoaded value)? loaded,
    TResult? Function(ProjectsError value)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ProjectsInitial value)? initial,
    TResult Function(ProjectsLoading value)? loading,
    TResult Function(ProjectsModifyingProject value)? modifyingProject,
    TResult Function(ProjectsLoaded value)? loaded,
    TResult Function(ProjectsError value)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ProjectsStateCopyWith<ProjectsState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProjectsStateCopyWith<$Res> {
  factory $ProjectsStateCopyWith(
          ProjectsState value, $Res Function(ProjectsState) then) =
      _$ProjectsStateCopyWithImpl<$Res, ProjectsState>;
  @useResult
  $Res call({List<Project> projects});
}

/// @nodoc
class _$ProjectsStateCopyWithImpl<$Res, $Val extends ProjectsState>
    implements $ProjectsStateCopyWith<$Res> {
  _$ProjectsStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? projects = null,
  }) {
    return _then(_value.copyWith(
      projects: null == projects
          ? _value.projects
          : projects // ignore: cast_nullable_to_non_nullable
              as List<Project>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ProjectsInitialCopyWith<$Res>
    implements $ProjectsStateCopyWith<$Res> {
  factory _$$ProjectsInitialCopyWith(
          _$ProjectsInitial value, $Res Function(_$ProjectsInitial) then) =
      __$$ProjectsInitialCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<Project> projects});
}

/// @nodoc
class __$$ProjectsInitialCopyWithImpl<$Res>
    extends _$ProjectsStateCopyWithImpl<$Res, _$ProjectsInitial>
    implements _$$ProjectsInitialCopyWith<$Res> {
  __$$ProjectsInitialCopyWithImpl(
      _$ProjectsInitial _value, $Res Function(_$ProjectsInitial) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? projects = null,
  }) {
    return _then(_$ProjectsInitial(
      null == projects
          ? _value._projects
          : projects // ignore: cast_nullable_to_non_nullable
              as List<Project>,
    ));
  }
}

/// @nodoc

class _$ProjectsInitial implements ProjectsInitial {
  const _$ProjectsInitial(final List<Project> projects) : _projects = projects;

  final List<Project> _projects;
  @override
  List<Project> get projects {
    if (_projects is EqualUnmodifiableListView) return _projects;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_projects);
  }

  @override
  String toString() {
    return 'ProjectsState.initial(projects: $projects)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProjectsInitial &&
            const DeepCollectionEquality().equals(other._projects, _projects));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_projects));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ProjectsInitialCopyWith<_$ProjectsInitial> get copyWith =>
      __$$ProjectsInitialCopyWithImpl<_$ProjectsInitial>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(List<Project> projects) initial,
    required TResult Function(List<Project> projects) loading,
    required TResult Function(List<Project> projects, Project projectModifying)
        modifyingProject,
    required TResult Function(List<Project> projects) loaded,
    required TResult Function(List<Project> projects, String message) error,
  }) {
    return initial(projects);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(List<Project> projects)? initial,
    TResult? Function(List<Project> projects)? loading,
    TResult? Function(List<Project> projects, Project projectModifying)?
        modifyingProject,
    TResult? Function(List<Project> projects)? loaded,
    TResult? Function(List<Project> projects, String message)? error,
  }) {
    return initial?.call(projects);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(List<Project> projects)? initial,
    TResult Function(List<Project> projects)? loading,
    TResult Function(List<Project> projects, Project projectModifying)?
        modifyingProject,
    TResult Function(List<Project> projects)? loaded,
    TResult Function(List<Project> projects, String message)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(projects);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ProjectsInitial value) initial,
    required TResult Function(ProjectsLoading value) loading,
    required TResult Function(ProjectsModifyingProject value) modifyingProject,
    required TResult Function(ProjectsLoaded value) loaded,
    required TResult Function(ProjectsError value) error,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ProjectsInitial value)? initial,
    TResult? Function(ProjectsLoading value)? loading,
    TResult? Function(ProjectsModifyingProject value)? modifyingProject,
    TResult? Function(ProjectsLoaded value)? loaded,
    TResult? Function(ProjectsError value)? error,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ProjectsInitial value)? initial,
    TResult Function(ProjectsLoading value)? loading,
    TResult Function(ProjectsModifyingProject value)? modifyingProject,
    TResult Function(ProjectsLoaded value)? loaded,
    TResult Function(ProjectsError value)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class ProjectsInitial implements ProjectsState {
  const factory ProjectsInitial(final List<Project> projects) =
      _$ProjectsInitial;

  @override
  List<Project> get projects;
  @override
  @JsonKey(ignore: true)
  _$$ProjectsInitialCopyWith<_$ProjectsInitial> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ProjectsLoadingCopyWith<$Res>
    implements $ProjectsStateCopyWith<$Res> {
  factory _$$ProjectsLoadingCopyWith(
          _$ProjectsLoading value, $Res Function(_$ProjectsLoading) then) =
      __$$ProjectsLoadingCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<Project> projects});
}

/// @nodoc
class __$$ProjectsLoadingCopyWithImpl<$Res>
    extends _$ProjectsStateCopyWithImpl<$Res, _$ProjectsLoading>
    implements _$$ProjectsLoadingCopyWith<$Res> {
  __$$ProjectsLoadingCopyWithImpl(
      _$ProjectsLoading _value, $Res Function(_$ProjectsLoading) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? projects = null,
  }) {
    return _then(_$ProjectsLoading(
      null == projects
          ? _value._projects
          : projects // ignore: cast_nullable_to_non_nullable
              as List<Project>,
    ));
  }
}

/// @nodoc

class _$ProjectsLoading implements ProjectsLoading {
  const _$ProjectsLoading(final List<Project> projects) : _projects = projects;

  final List<Project> _projects;
  @override
  List<Project> get projects {
    if (_projects is EqualUnmodifiableListView) return _projects;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_projects);
  }

  @override
  String toString() {
    return 'ProjectsState.loading(projects: $projects)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProjectsLoading &&
            const DeepCollectionEquality().equals(other._projects, _projects));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_projects));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ProjectsLoadingCopyWith<_$ProjectsLoading> get copyWith =>
      __$$ProjectsLoadingCopyWithImpl<_$ProjectsLoading>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(List<Project> projects) initial,
    required TResult Function(List<Project> projects) loading,
    required TResult Function(List<Project> projects, Project projectModifying)
        modifyingProject,
    required TResult Function(List<Project> projects) loaded,
    required TResult Function(List<Project> projects, String message) error,
  }) {
    return loading(projects);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(List<Project> projects)? initial,
    TResult? Function(List<Project> projects)? loading,
    TResult? Function(List<Project> projects, Project projectModifying)?
        modifyingProject,
    TResult? Function(List<Project> projects)? loaded,
    TResult? Function(List<Project> projects, String message)? error,
  }) {
    return loading?.call(projects);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(List<Project> projects)? initial,
    TResult Function(List<Project> projects)? loading,
    TResult Function(List<Project> projects, Project projectModifying)?
        modifyingProject,
    TResult Function(List<Project> projects)? loaded,
    TResult Function(List<Project> projects, String message)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(projects);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ProjectsInitial value) initial,
    required TResult Function(ProjectsLoading value) loading,
    required TResult Function(ProjectsModifyingProject value) modifyingProject,
    required TResult Function(ProjectsLoaded value) loaded,
    required TResult Function(ProjectsError value) error,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ProjectsInitial value)? initial,
    TResult? Function(ProjectsLoading value)? loading,
    TResult? Function(ProjectsModifyingProject value)? modifyingProject,
    TResult? Function(ProjectsLoaded value)? loaded,
    TResult? Function(ProjectsError value)? error,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ProjectsInitial value)? initial,
    TResult Function(ProjectsLoading value)? loading,
    TResult Function(ProjectsModifyingProject value)? modifyingProject,
    TResult Function(ProjectsLoaded value)? loaded,
    TResult Function(ProjectsError value)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class ProjectsLoading implements ProjectsState {
  const factory ProjectsLoading(final List<Project> projects) =
      _$ProjectsLoading;

  @override
  List<Project> get projects;
  @override
  @JsonKey(ignore: true)
  _$$ProjectsLoadingCopyWith<_$ProjectsLoading> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ProjectsModifyingProjectCopyWith<$Res>
    implements $ProjectsStateCopyWith<$Res> {
  factory _$$ProjectsModifyingProjectCopyWith(_$ProjectsModifyingProject value,
          $Res Function(_$ProjectsModifyingProject) then) =
      __$$ProjectsModifyingProjectCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<Project> projects, Project projectModifying});
}

/// @nodoc
class __$$ProjectsModifyingProjectCopyWithImpl<$Res>
    extends _$ProjectsStateCopyWithImpl<$Res, _$ProjectsModifyingProject>
    implements _$$ProjectsModifyingProjectCopyWith<$Res> {
  __$$ProjectsModifyingProjectCopyWithImpl(_$ProjectsModifyingProject _value,
      $Res Function(_$ProjectsModifyingProject) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? projects = null,
    Object? projectModifying = null,
  }) {
    return _then(_$ProjectsModifyingProject(
      null == projects
          ? _value._projects
          : projects // ignore: cast_nullable_to_non_nullable
              as List<Project>,
      null == projectModifying
          ? _value.projectModifying
          : projectModifying // ignore: cast_nullable_to_non_nullable
              as Project,
    ));
  }
}

/// @nodoc

class _$ProjectsModifyingProject implements ProjectsModifyingProject {
  const _$ProjectsModifyingProject(
      final List<Project> projects, this.projectModifying)
      : _projects = projects;

  final List<Project> _projects;
  @override
  List<Project> get projects {
    if (_projects is EqualUnmodifiableListView) return _projects;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_projects);
  }

  @override
  final Project projectModifying;

  @override
  String toString() {
    return 'ProjectsState.modifyingProject(projects: $projects, projectModifying: $projectModifying)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProjectsModifyingProject &&
            const DeepCollectionEquality().equals(other._projects, _projects) &&
            (identical(other.projectModifying, projectModifying) ||
                other.projectModifying == projectModifying));
  }

  @override
  int get hashCode => Object.hash(runtimeType,
      const DeepCollectionEquality().hash(_projects), projectModifying);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ProjectsModifyingProjectCopyWith<_$ProjectsModifyingProject>
      get copyWith =>
          __$$ProjectsModifyingProjectCopyWithImpl<_$ProjectsModifyingProject>(
              this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(List<Project> projects) initial,
    required TResult Function(List<Project> projects) loading,
    required TResult Function(List<Project> projects, Project projectModifying)
        modifyingProject,
    required TResult Function(List<Project> projects) loaded,
    required TResult Function(List<Project> projects, String message) error,
  }) {
    return modifyingProject(projects, projectModifying);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(List<Project> projects)? initial,
    TResult? Function(List<Project> projects)? loading,
    TResult? Function(List<Project> projects, Project projectModifying)?
        modifyingProject,
    TResult? Function(List<Project> projects)? loaded,
    TResult? Function(List<Project> projects, String message)? error,
  }) {
    return modifyingProject?.call(projects, projectModifying);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(List<Project> projects)? initial,
    TResult Function(List<Project> projects)? loading,
    TResult Function(List<Project> projects, Project projectModifying)?
        modifyingProject,
    TResult Function(List<Project> projects)? loaded,
    TResult Function(List<Project> projects, String message)? error,
    required TResult orElse(),
  }) {
    if (modifyingProject != null) {
      return modifyingProject(projects, projectModifying);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ProjectsInitial value) initial,
    required TResult Function(ProjectsLoading value) loading,
    required TResult Function(ProjectsModifyingProject value) modifyingProject,
    required TResult Function(ProjectsLoaded value) loaded,
    required TResult Function(ProjectsError value) error,
  }) {
    return modifyingProject(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ProjectsInitial value)? initial,
    TResult? Function(ProjectsLoading value)? loading,
    TResult? Function(ProjectsModifyingProject value)? modifyingProject,
    TResult? Function(ProjectsLoaded value)? loaded,
    TResult? Function(ProjectsError value)? error,
  }) {
    return modifyingProject?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ProjectsInitial value)? initial,
    TResult Function(ProjectsLoading value)? loading,
    TResult Function(ProjectsModifyingProject value)? modifyingProject,
    TResult Function(ProjectsLoaded value)? loaded,
    TResult Function(ProjectsError value)? error,
    required TResult orElse(),
  }) {
    if (modifyingProject != null) {
      return modifyingProject(this);
    }
    return orElse();
  }
}

abstract class ProjectsModifyingProject implements ProjectsState {
  const factory ProjectsModifyingProject(
          final List<Project> projects, final Project projectModifying) =
      _$ProjectsModifyingProject;

  @override
  List<Project> get projects;
  Project get projectModifying;
  @override
  @JsonKey(ignore: true)
  _$$ProjectsModifyingProjectCopyWith<_$ProjectsModifyingProject>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ProjectsLoadedCopyWith<$Res>
    implements $ProjectsStateCopyWith<$Res> {
  factory _$$ProjectsLoadedCopyWith(
          _$ProjectsLoaded value, $Res Function(_$ProjectsLoaded) then) =
      __$$ProjectsLoadedCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<Project> projects});
}

/// @nodoc
class __$$ProjectsLoadedCopyWithImpl<$Res>
    extends _$ProjectsStateCopyWithImpl<$Res, _$ProjectsLoaded>
    implements _$$ProjectsLoadedCopyWith<$Res> {
  __$$ProjectsLoadedCopyWithImpl(
      _$ProjectsLoaded _value, $Res Function(_$ProjectsLoaded) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? projects = null,
  }) {
    return _then(_$ProjectsLoaded(
      null == projects
          ? _value._projects
          : projects // ignore: cast_nullable_to_non_nullable
              as List<Project>,
    ));
  }
}

/// @nodoc

class _$ProjectsLoaded implements ProjectsLoaded {
  const _$ProjectsLoaded(final List<Project> projects) : _projects = projects;

  final List<Project> _projects;
  @override
  List<Project> get projects {
    if (_projects is EqualUnmodifiableListView) return _projects;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_projects);
  }

  @override
  String toString() {
    return 'ProjectsState.loaded(projects: $projects)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProjectsLoaded &&
            const DeepCollectionEquality().equals(other._projects, _projects));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_projects));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ProjectsLoadedCopyWith<_$ProjectsLoaded> get copyWith =>
      __$$ProjectsLoadedCopyWithImpl<_$ProjectsLoaded>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(List<Project> projects) initial,
    required TResult Function(List<Project> projects) loading,
    required TResult Function(List<Project> projects, Project projectModifying)
        modifyingProject,
    required TResult Function(List<Project> projects) loaded,
    required TResult Function(List<Project> projects, String message) error,
  }) {
    return loaded(projects);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(List<Project> projects)? initial,
    TResult? Function(List<Project> projects)? loading,
    TResult? Function(List<Project> projects, Project projectModifying)?
        modifyingProject,
    TResult? Function(List<Project> projects)? loaded,
    TResult? Function(List<Project> projects, String message)? error,
  }) {
    return loaded?.call(projects);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(List<Project> projects)? initial,
    TResult Function(List<Project> projects)? loading,
    TResult Function(List<Project> projects, Project projectModifying)?
        modifyingProject,
    TResult Function(List<Project> projects)? loaded,
    TResult Function(List<Project> projects, String message)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(projects);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ProjectsInitial value) initial,
    required TResult Function(ProjectsLoading value) loading,
    required TResult Function(ProjectsModifyingProject value) modifyingProject,
    required TResult Function(ProjectsLoaded value) loaded,
    required TResult Function(ProjectsError value) error,
  }) {
    return loaded(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ProjectsInitial value)? initial,
    TResult? Function(ProjectsLoading value)? loading,
    TResult? Function(ProjectsModifyingProject value)? modifyingProject,
    TResult? Function(ProjectsLoaded value)? loaded,
    TResult? Function(ProjectsError value)? error,
  }) {
    return loaded?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ProjectsInitial value)? initial,
    TResult Function(ProjectsLoading value)? loading,
    TResult Function(ProjectsModifyingProject value)? modifyingProject,
    TResult Function(ProjectsLoaded value)? loaded,
    TResult Function(ProjectsError value)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(this);
    }
    return orElse();
  }
}

abstract class ProjectsLoaded implements ProjectsState {
  const factory ProjectsLoaded(final List<Project> projects) = _$ProjectsLoaded;

  @override
  List<Project> get projects;
  @override
  @JsonKey(ignore: true)
  _$$ProjectsLoadedCopyWith<_$ProjectsLoaded> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ProjectsErrorCopyWith<$Res>
    implements $ProjectsStateCopyWith<$Res> {
  factory _$$ProjectsErrorCopyWith(
          _$ProjectsError value, $Res Function(_$ProjectsError) then) =
      __$$ProjectsErrorCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<Project> projects, String message});
}

/// @nodoc
class __$$ProjectsErrorCopyWithImpl<$Res>
    extends _$ProjectsStateCopyWithImpl<$Res, _$ProjectsError>
    implements _$$ProjectsErrorCopyWith<$Res> {
  __$$ProjectsErrorCopyWithImpl(
      _$ProjectsError _value, $Res Function(_$ProjectsError) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? projects = null,
    Object? message = null,
  }) {
    return _then(_$ProjectsError(
      null == projects
          ? _value._projects
          : projects // ignore: cast_nullable_to_non_nullable
              as List<Project>,
      null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$ProjectsError implements ProjectsError {
  const _$ProjectsError(final List<Project> projects, this.message)
      : _projects = projects;

  final List<Project> _projects;
  @override
  List<Project> get projects {
    if (_projects is EqualUnmodifiableListView) return _projects;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_projects);
  }

  @override
  final String message;

  @override
  String toString() {
    return 'ProjectsState.error(projects: $projects, message: $message)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProjectsError &&
            const DeepCollectionEquality().equals(other._projects, _projects) &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_projects), message);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ProjectsErrorCopyWith<_$ProjectsError> get copyWith =>
      __$$ProjectsErrorCopyWithImpl<_$ProjectsError>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(List<Project> projects) initial,
    required TResult Function(List<Project> projects) loading,
    required TResult Function(List<Project> projects, Project projectModifying)
        modifyingProject,
    required TResult Function(List<Project> projects) loaded,
    required TResult Function(List<Project> projects, String message) error,
  }) {
    return error(projects, message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(List<Project> projects)? initial,
    TResult? Function(List<Project> projects)? loading,
    TResult? Function(List<Project> projects, Project projectModifying)?
        modifyingProject,
    TResult? Function(List<Project> projects)? loaded,
    TResult? Function(List<Project> projects, String message)? error,
  }) {
    return error?.call(projects, message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(List<Project> projects)? initial,
    TResult Function(List<Project> projects)? loading,
    TResult Function(List<Project> projects, Project projectModifying)?
        modifyingProject,
    TResult Function(List<Project> projects)? loaded,
    TResult Function(List<Project> projects, String message)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(projects, message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ProjectsInitial value) initial,
    required TResult Function(ProjectsLoading value) loading,
    required TResult Function(ProjectsModifyingProject value) modifyingProject,
    required TResult Function(ProjectsLoaded value) loaded,
    required TResult Function(ProjectsError value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ProjectsInitial value)? initial,
    TResult? Function(ProjectsLoading value)? loading,
    TResult? Function(ProjectsModifyingProject value)? modifyingProject,
    TResult? Function(ProjectsLoaded value)? loaded,
    TResult? Function(ProjectsError value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ProjectsInitial value)? initial,
    TResult Function(ProjectsLoading value)? loading,
    TResult Function(ProjectsModifyingProject value)? modifyingProject,
    TResult Function(ProjectsLoaded value)? loaded,
    TResult Function(ProjectsError value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class ProjectsError implements ProjectsState {
  const factory ProjectsError(
      final List<Project> projects, final String message) = _$ProjectsError;

  @override
  List<Project> get projects;
  String get message;
  @override
  @JsonKey(ignore: true)
  _$$ProjectsErrorCopyWith<_$ProjectsError> get copyWith =>
      throw _privateConstructorUsedError;
}
