// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'blueprint_item.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

BlueprintItem _$BlueprintItemFromJson(Map<String, dynamic> json) {
  switch (json['runtimeType']) {
    case 'event':
      return EventBlueprintItem.fromJson(json);
    case 'task':
      return TaskBlueprintItem.fromJson(json);

    default:
      throw CheckedFromJsonException(json, 'runtimeType', 'BlueprintItem',
          'Invalid union type "${json['runtimeType']}"!');
  }
}

/// @nodoc
mixin _$BlueprintItem {
  Object get value => throw _privateConstructorUsedError;
  String get id => throw _privateConstructorUsedError;
  @TimestampConverter()
  DateTime get startTime => throw _privateConstructorUsedError;
  @TimestampConverter()
  DateTime get endTime => throw _privateConstructorUsedError;
  bool get isPreview => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            Event value,
            String id,
            @TimestampConverter() DateTime startTime,
            @TimestampConverter() DateTime endTime,
            bool isPreview)
        event,
    required TResult Function(
            Task value,
            String id,
            @TimestampConverter() DateTime startTime,
            @TimestampConverter() DateTime endTime,
            bool isPreview)
        task,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            Event value,
            String id,
            @TimestampConverter() DateTime startTime,
            @TimestampConverter() DateTime endTime,
            bool isPreview)?
        event,
    TResult? Function(
            Task value,
            String id,
            @TimestampConverter() DateTime startTime,
            @TimestampConverter() DateTime endTime,
            bool isPreview)?
        task,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            Event value,
            String id,
            @TimestampConverter() DateTime startTime,
            @TimestampConverter() DateTime endTime,
            bool isPreview)?
        event,
    TResult Function(
            Task value,
            String id,
            @TimestampConverter() DateTime startTime,
            @TimestampConverter() DateTime endTime,
            bool isPreview)?
        task,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(EventBlueprintItem value) event,
    required TResult Function(TaskBlueprintItem value) task,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(EventBlueprintItem value)? event,
    TResult? Function(TaskBlueprintItem value)? task,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(EventBlueprintItem value)? event,
    TResult Function(TaskBlueprintItem value)? task,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $BlueprintItemCopyWith<BlueprintItem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BlueprintItemCopyWith<$Res> {
  factory $BlueprintItemCopyWith(
          BlueprintItem value, $Res Function(BlueprintItem) then) =
      _$BlueprintItemCopyWithImpl<$Res, BlueprintItem>;
  @useResult
  $Res call(
      {String id,
      @TimestampConverter() DateTime startTime,
      @TimestampConverter() DateTime endTime,
      bool isPreview});
}

/// @nodoc
class _$BlueprintItemCopyWithImpl<$Res, $Val extends BlueprintItem>
    implements $BlueprintItemCopyWith<$Res> {
  _$BlueprintItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? startTime = null,
    Object? endTime = null,
    Object? isPreview = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      startTime: null == startTime
          ? _value.startTime
          : startTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      endTime: null == endTime
          ? _value.endTime
          : endTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      isPreview: null == isPreview
          ? _value.isPreview
          : isPreview // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$EventBlueprintItemImplCopyWith<$Res>
    implements $BlueprintItemCopyWith<$Res> {
  factory _$$EventBlueprintItemImplCopyWith(_$EventBlueprintItemImpl value,
          $Res Function(_$EventBlueprintItemImpl) then) =
      __$$EventBlueprintItemImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {Event value,
      String id,
      @TimestampConverter() DateTime startTime,
      @TimestampConverter() DateTime endTime,
      bool isPreview});
}

/// @nodoc
class __$$EventBlueprintItemImplCopyWithImpl<$Res>
    extends _$BlueprintItemCopyWithImpl<$Res, _$EventBlueprintItemImpl>
    implements _$$EventBlueprintItemImplCopyWith<$Res> {
  __$$EventBlueprintItemImplCopyWithImpl(_$EventBlueprintItemImpl _value,
      $Res Function(_$EventBlueprintItemImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? value = null,
    Object? id = null,
    Object? startTime = null,
    Object? endTime = null,
    Object? isPreview = null,
  }) {
    return _then(_$EventBlueprintItemImpl(
      value: null == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as Event,
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      startTime: null == startTime
          ? _value.startTime
          : startTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      endTime: null == endTime
          ? _value.endTime
          : endTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      isPreview: null == isPreview
          ? _value.isPreview
          : isPreview // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$EventBlueprintItemImpl extends EventBlueprintItem {
  const _$EventBlueprintItemImpl(
      {required this.value,
      required this.id,
      @TimestampConverter() required this.startTime,
      @TimestampConverter() required this.endTime,
      this.isPreview = false,
      final String? $type})
      : $type = $type ?? 'event',
        super._();

  factory _$EventBlueprintItemImpl.fromJson(Map<String, dynamic> json) =>
      _$$EventBlueprintItemImplFromJson(json);

  @override
  final Event value;
  @override
  final String id;
  @override
  @TimestampConverter()
  final DateTime startTime;
  @override
  @TimestampConverter()
  final DateTime endTime;
  @override
  @JsonKey()
  final bool isPreview;

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'BlueprintItem.event(value: $value, id: $id, startTime: $startTime, endTime: $endTime, isPreview: $isPreview)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EventBlueprintItemImpl &&
            (identical(other.value, value) || other.value == value) &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.startTime, startTime) ||
                other.startTime == startTime) &&
            (identical(other.endTime, endTime) || other.endTime == endTime) &&
            (identical(other.isPreview, isPreview) ||
                other.isPreview == isPreview));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, value, id, startTime, endTime, isPreview);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$EventBlueprintItemImplCopyWith<_$EventBlueprintItemImpl> get copyWith =>
      __$$EventBlueprintItemImplCopyWithImpl<_$EventBlueprintItemImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            Event value,
            String id,
            @TimestampConverter() DateTime startTime,
            @TimestampConverter() DateTime endTime,
            bool isPreview)
        event,
    required TResult Function(
            Task value,
            String id,
            @TimestampConverter() DateTime startTime,
            @TimestampConverter() DateTime endTime,
            bool isPreview)
        task,
  }) {
    return event(value, id, startTime, endTime, isPreview);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            Event value,
            String id,
            @TimestampConverter() DateTime startTime,
            @TimestampConverter() DateTime endTime,
            bool isPreview)?
        event,
    TResult? Function(
            Task value,
            String id,
            @TimestampConverter() DateTime startTime,
            @TimestampConverter() DateTime endTime,
            bool isPreview)?
        task,
  }) {
    return event?.call(value, id, startTime, endTime, isPreview);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            Event value,
            String id,
            @TimestampConverter() DateTime startTime,
            @TimestampConverter() DateTime endTime,
            bool isPreview)?
        event,
    TResult Function(
            Task value,
            String id,
            @TimestampConverter() DateTime startTime,
            @TimestampConverter() DateTime endTime,
            bool isPreview)?
        task,
    required TResult orElse(),
  }) {
    if (event != null) {
      return event(value, id, startTime, endTime, isPreview);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(EventBlueprintItem value) event,
    required TResult Function(TaskBlueprintItem value) task,
  }) {
    return event(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(EventBlueprintItem value)? event,
    TResult? Function(TaskBlueprintItem value)? task,
  }) {
    return event?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(EventBlueprintItem value)? event,
    TResult Function(TaskBlueprintItem value)? task,
    required TResult orElse(),
  }) {
    if (event != null) {
      return event(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$EventBlueprintItemImplToJson(
      this,
    );
  }
}

abstract class EventBlueprintItem extends BlueprintItem {
  const factory EventBlueprintItem(
      {required final Event value,
      required final String id,
      @TimestampConverter() required final DateTime startTime,
      @TimestampConverter() required final DateTime endTime,
      final bool isPreview}) = _$EventBlueprintItemImpl;
  const EventBlueprintItem._() : super._();

  factory EventBlueprintItem.fromJson(Map<String, dynamic> json) =
      _$EventBlueprintItemImpl.fromJson;

  @override
  Event get value;
  @override
  String get id;
  @override
  @TimestampConverter()
  DateTime get startTime;
  @override
  @TimestampConverter()
  DateTime get endTime;
  @override
  bool get isPreview;
  @override
  @JsonKey(ignore: true)
  _$$EventBlueprintItemImplCopyWith<_$EventBlueprintItemImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$TaskBlueprintItemImplCopyWith<$Res>
    implements $BlueprintItemCopyWith<$Res> {
  factory _$$TaskBlueprintItemImplCopyWith(_$TaskBlueprintItemImpl value,
          $Res Function(_$TaskBlueprintItemImpl) then) =
      __$$TaskBlueprintItemImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {Task value,
      String id,
      @TimestampConverter() DateTime startTime,
      @TimestampConverter() DateTime endTime,
      bool isPreview});
}

/// @nodoc
class __$$TaskBlueprintItemImplCopyWithImpl<$Res>
    extends _$BlueprintItemCopyWithImpl<$Res, _$TaskBlueprintItemImpl>
    implements _$$TaskBlueprintItemImplCopyWith<$Res> {
  __$$TaskBlueprintItemImplCopyWithImpl(_$TaskBlueprintItemImpl _value,
      $Res Function(_$TaskBlueprintItemImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? value = null,
    Object? id = null,
    Object? startTime = null,
    Object? endTime = null,
    Object? isPreview = null,
  }) {
    return _then(_$TaskBlueprintItemImpl(
      value: null == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as Task,
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      startTime: null == startTime
          ? _value.startTime
          : startTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      endTime: null == endTime
          ? _value.endTime
          : endTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      isPreview: null == isPreview
          ? _value.isPreview
          : isPreview // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TaskBlueprintItemImpl extends TaskBlueprintItem {
  const _$TaskBlueprintItemImpl(
      {required this.value,
      required this.id,
      @TimestampConverter() required this.startTime,
      @TimestampConverter() required this.endTime,
      this.isPreview = false,
      final String? $type})
      : $type = $type ?? 'task',
        super._();

  factory _$TaskBlueprintItemImpl.fromJson(Map<String, dynamic> json) =>
      _$$TaskBlueprintItemImplFromJson(json);

  @override
  final Task value;
  @override
  final String id;
  @override
  @TimestampConverter()
  final DateTime startTime;
  @override
  @TimestampConverter()
  final DateTime endTime;
  @override
  @JsonKey()
  final bool isPreview;

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'BlueprintItem.task(value: $value, id: $id, startTime: $startTime, endTime: $endTime, isPreview: $isPreview)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TaskBlueprintItemImpl &&
            (identical(other.value, value) || other.value == value) &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.startTime, startTime) ||
                other.startTime == startTime) &&
            (identical(other.endTime, endTime) || other.endTime == endTime) &&
            (identical(other.isPreview, isPreview) ||
                other.isPreview == isPreview));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, value, id, startTime, endTime, isPreview);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TaskBlueprintItemImplCopyWith<_$TaskBlueprintItemImpl> get copyWith =>
      __$$TaskBlueprintItemImplCopyWithImpl<_$TaskBlueprintItemImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            Event value,
            String id,
            @TimestampConverter() DateTime startTime,
            @TimestampConverter() DateTime endTime,
            bool isPreview)
        event,
    required TResult Function(
            Task value,
            String id,
            @TimestampConverter() DateTime startTime,
            @TimestampConverter() DateTime endTime,
            bool isPreview)
        task,
  }) {
    return task(value, id, startTime, endTime, isPreview);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            Event value,
            String id,
            @TimestampConverter() DateTime startTime,
            @TimestampConverter() DateTime endTime,
            bool isPreview)?
        event,
    TResult? Function(
            Task value,
            String id,
            @TimestampConverter() DateTime startTime,
            @TimestampConverter() DateTime endTime,
            bool isPreview)?
        task,
  }) {
    return task?.call(value, id, startTime, endTime, isPreview);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            Event value,
            String id,
            @TimestampConverter() DateTime startTime,
            @TimestampConverter() DateTime endTime,
            bool isPreview)?
        event,
    TResult Function(
            Task value,
            String id,
            @TimestampConverter() DateTime startTime,
            @TimestampConverter() DateTime endTime,
            bool isPreview)?
        task,
    required TResult orElse(),
  }) {
    if (task != null) {
      return task(value, id, startTime, endTime, isPreview);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(EventBlueprintItem value) event,
    required TResult Function(TaskBlueprintItem value) task,
  }) {
    return task(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(EventBlueprintItem value)? event,
    TResult? Function(TaskBlueprintItem value)? task,
  }) {
    return task?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(EventBlueprintItem value)? event,
    TResult Function(TaskBlueprintItem value)? task,
    required TResult orElse(),
  }) {
    if (task != null) {
      return task(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$TaskBlueprintItemImplToJson(
      this,
    );
  }
}

abstract class TaskBlueprintItem extends BlueprintItem {
  const factory TaskBlueprintItem(
      {required final Task value,
      required final String id,
      @TimestampConverter() required final DateTime startTime,
      @TimestampConverter() required final DateTime endTime,
      final bool isPreview}) = _$TaskBlueprintItemImpl;
  const TaskBlueprintItem._() : super._();

  factory TaskBlueprintItem.fromJson(Map<String, dynamic> json) =
      _$TaskBlueprintItemImpl.fromJson;

  @override
  Task get value;
  @override
  String get id;
  @override
  @TimestampConverter()
  DateTime get startTime;
  @override
  @TimestampConverter()
  DateTime get endTime;
  @override
  bool get isPreview;
  @override
  @JsonKey(ignore: true)
  _$$TaskBlueprintItemImplCopyWith<_$TaskBlueprintItemImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
