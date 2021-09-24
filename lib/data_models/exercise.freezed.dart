// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'exercise.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Exercise _$ExerciseFromJson(Map<String, dynamic> json) {
  return _Exercise.fromJson(json);
}

/// @nodoc
class _$ExerciseTearOff {
  const _$ExerciseTearOff();

  _Exercise call(
      {required String id,
      required String exerciseName,
      required String exerciseType,
      double? lastWeight,
      int? lastReps,
      int? lastRPE}) {
    return _Exercise(
      id: id,
      exerciseName: exerciseName,
      exerciseType: exerciseType,
      lastWeight: lastWeight,
      lastReps: lastReps,
      lastRPE: lastRPE,
    );
  }

  Exercise fromJson(Map<String, Object> json) {
    return Exercise.fromJson(json);
  }
}

/// @nodoc
const $Exercise = _$ExerciseTearOff();

/// @nodoc
mixin _$Exercise {
  String get id => throw _privateConstructorUsedError;
  String get exerciseName => throw _privateConstructorUsedError;
  String get exerciseType => throw _privateConstructorUsedError;
  double? get lastWeight => throw _privateConstructorUsedError;
  int? get lastReps => throw _privateConstructorUsedError;
  int? get lastRPE => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ExerciseCopyWith<Exercise> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ExerciseCopyWith<$Res> {
  factory $ExerciseCopyWith(Exercise value, $Res Function(Exercise) then) =
      _$ExerciseCopyWithImpl<$Res>;
  $Res call(
      {String id,
      String exerciseName,
      String exerciseType,
      double? lastWeight,
      int? lastReps,
      int? lastRPE});
}

/// @nodoc
class _$ExerciseCopyWithImpl<$Res> implements $ExerciseCopyWith<$Res> {
  _$ExerciseCopyWithImpl(this._value, this._then);

  final Exercise _value;
  // ignore: unused_field
  final $Res Function(Exercise) _then;

  @override
  $Res call({
    Object? id = freezed,
    Object? exerciseName = freezed,
    Object? exerciseType = freezed,
    Object? lastWeight = freezed,
    Object? lastReps = freezed,
    Object? lastRPE = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      exerciseName: exerciseName == freezed
          ? _value.exerciseName
          : exerciseName // ignore: cast_nullable_to_non_nullable
              as String,
      exerciseType: exerciseType == freezed
          ? _value.exerciseType
          : exerciseType // ignore: cast_nullable_to_non_nullable
              as String,
      lastWeight: lastWeight == freezed
          ? _value.lastWeight
          : lastWeight // ignore: cast_nullable_to_non_nullable
              as double?,
      lastReps: lastReps == freezed
          ? _value.lastReps
          : lastReps // ignore: cast_nullable_to_non_nullable
              as int?,
      lastRPE: lastRPE == freezed
          ? _value.lastRPE
          : lastRPE // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
abstract class _$ExerciseCopyWith<$Res> implements $ExerciseCopyWith<$Res> {
  factory _$ExerciseCopyWith(_Exercise value, $Res Function(_Exercise) then) =
      __$ExerciseCopyWithImpl<$Res>;
  @override
  $Res call(
      {String id,
      String exerciseName,
      String exerciseType,
      double? lastWeight,
      int? lastReps,
      int? lastRPE});
}

/// @nodoc
class __$ExerciseCopyWithImpl<$Res> extends _$ExerciseCopyWithImpl<$Res>
    implements _$ExerciseCopyWith<$Res> {
  __$ExerciseCopyWithImpl(_Exercise _value, $Res Function(_Exercise) _then)
      : super(_value, (v) => _then(v as _Exercise));

  @override
  _Exercise get _value => super._value as _Exercise;

  @override
  $Res call({
    Object? id = freezed,
    Object? exerciseName = freezed,
    Object? exerciseType = freezed,
    Object? lastWeight = freezed,
    Object? lastReps = freezed,
    Object? lastRPE = freezed,
  }) {
    return _then(_Exercise(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      exerciseName: exerciseName == freezed
          ? _value.exerciseName
          : exerciseName // ignore: cast_nullable_to_non_nullable
              as String,
      exerciseType: exerciseType == freezed
          ? _value.exerciseType
          : exerciseType // ignore: cast_nullable_to_non_nullable
              as String,
      lastWeight: lastWeight == freezed
          ? _value.lastWeight
          : lastWeight // ignore: cast_nullable_to_non_nullable
              as double?,
      lastReps: lastReps == freezed
          ? _value.lastReps
          : lastReps // ignore: cast_nullable_to_non_nullable
              as int?,
      lastRPE: lastRPE == freezed
          ? _value.lastRPE
          : lastRPE // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Exercise implements _Exercise {
  const _$_Exercise(
      {required this.id,
      required this.exerciseName,
      required this.exerciseType,
      this.lastWeight,
      this.lastReps,
      this.lastRPE});

  factory _$_Exercise.fromJson(Map<String, dynamic> json) =>
      _$$_ExerciseFromJson(json);

  @override
  final String id;
  @override
  final String exerciseName;
  @override
  final String exerciseType;
  @override
  final double? lastWeight;
  @override
  final int? lastReps;
  @override
  final int? lastRPE;

  @override
  String toString() {
    return 'Exercise(id: $id, exerciseName: $exerciseName, exerciseType: $exerciseType, lastWeight: $lastWeight, lastReps: $lastReps, lastRPE: $lastRPE)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _Exercise &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.exerciseName, exerciseName) ||
                const DeepCollectionEquality()
                    .equals(other.exerciseName, exerciseName)) &&
            (identical(other.exerciseType, exerciseType) ||
                const DeepCollectionEquality()
                    .equals(other.exerciseType, exerciseType)) &&
            (identical(other.lastWeight, lastWeight) ||
                const DeepCollectionEquality()
                    .equals(other.lastWeight, lastWeight)) &&
            (identical(other.lastReps, lastReps) ||
                const DeepCollectionEquality()
                    .equals(other.lastReps, lastReps)) &&
            (identical(other.lastRPE, lastRPE) ||
                const DeepCollectionEquality().equals(other.lastRPE, lastRPE)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(exerciseName) ^
      const DeepCollectionEquality().hash(exerciseType) ^
      const DeepCollectionEquality().hash(lastWeight) ^
      const DeepCollectionEquality().hash(lastReps) ^
      const DeepCollectionEquality().hash(lastRPE);

  @JsonKey(ignore: true)
  @override
  _$ExerciseCopyWith<_Exercise> get copyWith =>
      __$ExerciseCopyWithImpl<_Exercise>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ExerciseToJson(this);
  }
}

abstract class _Exercise implements Exercise {
  const factory _Exercise(
      {required String id,
      required String exerciseName,
      required String exerciseType,
      double? lastWeight,
      int? lastReps,
      int? lastRPE}) = _$_Exercise;

  factory _Exercise.fromJson(Map<String, dynamic> json) = _$_Exercise.fromJson;

  @override
  String get id => throw _privateConstructorUsedError;
  @override
  String get exerciseName => throw _privateConstructorUsedError;
  @override
  String get exerciseType => throw _privateConstructorUsedError;
  @override
  double? get lastWeight => throw _privateConstructorUsedError;
  @override
  int? get lastReps => throw _privateConstructorUsedError;
  @override
  int? get lastRPE => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$ExerciseCopyWith<_Exercise> get copyWith =>
      throw _privateConstructorUsedError;
}
