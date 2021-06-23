// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

part of 'workout_plan.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

WorkoutPlan _$WorkoutPlanFromJson(Map<String, dynamic> json) {
  return _WorkoutPlan.fromJson(json);
}

/// @nodoc
class _$WorkoutPlanTearOff {
  const _$WorkoutPlanTearOff();

  _WorkoutPlan call(
      {required int id,
      required String exerciseId,
      required String planName,
      required String exerciseName,
      required int minRepsPerSet,
      required int maxRepsPerSet,
      required int sets,
      required int rpe,
      required String notes,
      required int weekdayForWorkout,
      required double restTime,
      required int orderId}) {
    return _WorkoutPlan(
      id: id,
      exerciseId: exerciseId,
      planName: planName,
      exerciseName: exerciseName,
      minRepsPerSet: minRepsPerSet,
      maxRepsPerSet: maxRepsPerSet,
      sets: sets,
      rpe: rpe,
      notes: notes,
      weekdayForWorkout: weekdayForWorkout,
      restTime: restTime,
      orderId: orderId,
    );
  }

  WorkoutPlan fromJson(Map<String, Object> json) {
    return WorkoutPlan.fromJson(json);
  }
}

/// @nodoc
const $WorkoutPlan = _$WorkoutPlanTearOff();

/// @nodoc
mixin _$WorkoutPlan {
  int get id => throw _privateConstructorUsedError;
  String get exerciseId => throw _privateConstructorUsedError;
  String get planName => throw _privateConstructorUsedError;
  String get exerciseName => throw _privateConstructorUsedError;
  int get minRepsPerSet => throw _privateConstructorUsedError;
  int get maxRepsPerSet => throw _privateConstructorUsedError;
  int get sets => throw _privateConstructorUsedError;
  int get rpe => throw _privateConstructorUsedError;
  String get notes => throw _privateConstructorUsedError;
  int get weekdayForWorkout => throw _privateConstructorUsedError;
  double get restTime => throw _privateConstructorUsedError;
  int get orderId => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $WorkoutPlanCopyWith<WorkoutPlan> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WorkoutPlanCopyWith<$Res> {
  factory $WorkoutPlanCopyWith(
          WorkoutPlan value, $Res Function(WorkoutPlan) then) =
      _$WorkoutPlanCopyWithImpl<$Res>;
  $Res call(
      {int id,
      String exerciseId,
      String planName,
      String exerciseName,
      int minRepsPerSet,
      int maxRepsPerSet,
      int sets,
      int rpe,
      String notes,
      int weekdayForWorkout,
      double restTime,
      int orderId});
}

/// @nodoc
class _$WorkoutPlanCopyWithImpl<$Res> implements $WorkoutPlanCopyWith<$Res> {
  _$WorkoutPlanCopyWithImpl(this._value, this._then);

  final WorkoutPlan _value;
  // ignore: unused_field
  final $Res Function(WorkoutPlan) _then;

  @override
  $Res call({
    Object? id = freezed,
    Object? exerciseId = freezed,
    Object? planName = freezed,
    Object? exerciseName = freezed,
    Object? minRepsPerSet = freezed,
    Object? maxRepsPerSet = freezed,
    Object? sets = freezed,
    Object? rpe = freezed,
    Object? notes = freezed,
    Object? weekdayForWorkout = freezed,
    Object? restTime = freezed,
    Object? orderId = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      exerciseId: exerciseId == freezed
          ? _value.exerciseId
          : exerciseId // ignore: cast_nullable_to_non_nullable
              as String,
      planName: planName == freezed
          ? _value.planName
          : planName // ignore: cast_nullable_to_non_nullable
              as String,
      exerciseName: exerciseName == freezed
          ? _value.exerciseName
          : exerciseName // ignore: cast_nullable_to_non_nullable
              as String,
      minRepsPerSet: minRepsPerSet == freezed
          ? _value.minRepsPerSet
          : minRepsPerSet // ignore: cast_nullable_to_non_nullable
              as int,
      maxRepsPerSet: maxRepsPerSet == freezed
          ? _value.maxRepsPerSet
          : maxRepsPerSet // ignore: cast_nullable_to_non_nullable
              as int,
      sets: sets == freezed
          ? _value.sets
          : sets // ignore: cast_nullable_to_non_nullable
              as int,
      rpe: rpe == freezed
          ? _value.rpe
          : rpe // ignore: cast_nullable_to_non_nullable
              as int,
      notes: notes == freezed
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String,
      weekdayForWorkout: weekdayForWorkout == freezed
          ? _value.weekdayForWorkout
          : weekdayForWorkout // ignore: cast_nullable_to_non_nullable
              as int,
      restTime: restTime == freezed
          ? _value.restTime
          : restTime // ignore: cast_nullable_to_non_nullable
              as double,
      orderId: orderId == freezed
          ? _value.orderId
          : orderId // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
abstract class _$WorkoutPlanCopyWith<$Res>
    implements $WorkoutPlanCopyWith<$Res> {
  factory _$WorkoutPlanCopyWith(
          _WorkoutPlan value, $Res Function(_WorkoutPlan) then) =
      __$WorkoutPlanCopyWithImpl<$Res>;
  @override
  $Res call(
      {int id,
      String exerciseId,
      String planName,
      String exerciseName,
      int minRepsPerSet,
      int maxRepsPerSet,
      int sets,
      int rpe,
      String notes,
      int weekdayForWorkout,
      double restTime,
      int orderId});
}

/// @nodoc
class __$WorkoutPlanCopyWithImpl<$Res> extends _$WorkoutPlanCopyWithImpl<$Res>
    implements _$WorkoutPlanCopyWith<$Res> {
  __$WorkoutPlanCopyWithImpl(
      _WorkoutPlan _value, $Res Function(_WorkoutPlan) _then)
      : super(_value, (v) => _then(v as _WorkoutPlan));

  @override
  _WorkoutPlan get _value => super._value as _WorkoutPlan;

  @override
  $Res call({
    Object? id = freezed,
    Object? exerciseId = freezed,
    Object? planName = freezed,
    Object? exerciseName = freezed,
    Object? minRepsPerSet = freezed,
    Object? maxRepsPerSet = freezed,
    Object? sets = freezed,
    Object? rpe = freezed,
    Object? notes = freezed,
    Object? weekdayForWorkout = freezed,
    Object? restTime = freezed,
    Object? orderId = freezed,
  }) {
    return _then(_WorkoutPlan(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      exerciseId: exerciseId == freezed
          ? _value.exerciseId
          : exerciseId // ignore: cast_nullable_to_non_nullable
              as String,
      planName: planName == freezed
          ? _value.planName
          : planName // ignore: cast_nullable_to_non_nullable
              as String,
      exerciseName: exerciseName == freezed
          ? _value.exerciseName
          : exerciseName // ignore: cast_nullable_to_non_nullable
              as String,
      minRepsPerSet: minRepsPerSet == freezed
          ? _value.minRepsPerSet
          : minRepsPerSet // ignore: cast_nullable_to_non_nullable
              as int,
      maxRepsPerSet: maxRepsPerSet == freezed
          ? _value.maxRepsPerSet
          : maxRepsPerSet // ignore: cast_nullable_to_non_nullable
              as int,
      sets: sets == freezed
          ? _value.sets
          : sets // ignore: cast_nullable_to_non_nullable
              as int,
      rpe: rpe == freezed
          ? _value.rpe
          : rpe // ignore: cast_nullable_to_non_nullable
              as int,
      notes: notes == freezed
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String,
      weekdayForWorkout: weekdayForWorkout == freezed
          ? _value.weekdayForWorkout
          : weekdayForWorkout // ignore: cast_nullable_to_non_nullable
              as int,
      restTime: restTime == freezed
          ? _value.restTime
          : restTime // ignore: cast_nullable_to_non_nullable
              as double,
      orderId: orderId == freezed
          ? _value.orderId
          : orderId // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_WorkoutPlan implements _WorkoutPlan {
  const _$_WorkoutPlan(
      {required this.id,
      required this.exerciseId,
      required this.planName,
      required this.exerciseName,
      required this.minRepsPerSet,
      required this.maxRepsPerSet,
      required this.sets,
      required this.rpe,
      required this.notes,
      required this.weekdayForWorkout,
      required this.restTime,
      required this.orderId});

  factory _$_WorkoutPlan.fromJson(Map<String, dynamic> json) =>
      _$_$_WorkoutPlanFromJson(json);

  @override
  final int id;
  @override
  final String exerciseId;
  @override
  final String planName;
  @override
  final String exerciseName;
  @override
  final int minRepsPerSet;
  @override
  final int maxRepsPerSet;
  @override
  final int sets;
  @override
  final int rpe;
  @override
  final String notes;
  @override
  final int weekdayForWorkout;
  @override
  final double restTime;
  @override
  final int orderId;

  @override
  String toString() {
    return 'WorkoutPlan(id: $id, exerciseId: $exerciseId, planName: $planName, exerciseName: $exerciseName, minRepsPerSet: $minRepsPerSet, maxRepsPerSet: $maxRepsPerSet, sets: $sets, rpe: $rpe, notes: $notes, weekdayForWorkout: $weekdayForWorkout, restTime: $restTime, orderId: $orderId)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _WorkoutPlan &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.exerciseId, exerciseId) ||
                const DeepCollectionEquality()
                    .equals(other.exerciseId, exerciseId)) &&
            (identical(other.planName, planName) ||
                const DeepCollectionEquality()
                    .equals(other.planName, planName)) &&
            (identical(other.exerciseName, exerciseName) ||
                const DeepCollectionEquality()
                    .equals(other.exerciseName, exerciseName)) &&
            (identical(other.minRepsPerSet, minRepsPerSet) ||
                const DeepCollectionEquality()
                    .equals(other.minRepsPerSet, minRepsPerSet)) &&
            (identical(other.maxRepsPerSet, maxRepsPerSet) ||
                const DeepCollectionEquality()
                    .equals(other.maxRepsPerSet, maxRepsPerSet)) &&
            (identical(other.sets, sets) ||
                const DeepCollectionEquality().equals(other.sets, sets)) &&
            (identical(other.rpe, rpe) ||
                const DeepCollectionEquality().equals(other.rpe, rpe)) &&
            (identical(other.notes, notes) ||
                const DeepCollectionEquality().equals(other.notes, notes)) &&
            (identical(other.weekdayForWorkout, weekdayForWorkout) ||
                const DeepCollectionEquality()
                    .equals(other.weekdayForWorkout, weekdayForWorkout)) &&
            (identical(other.restTime, restTime) ||
                const DeepCollectionEquality()
                    .equals(other.restTime, restTime)) &&
            (identical(other.orderId, orderId) ||
                const DeepCollectionEquality().equals(other.orderId, orderId)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(exerciseId) ^
      const DeepCollectionEquality().hash(planName) ^
      const DeepCollectionEquality().hash(exerciseName) ^
      const DeepCollectionEquality().hash(minRepsPerSet) ^
      const DeepCollectionEquality().hash(maxRepsPerSet) ^
      const DeepCollectionEquality().hash(sets) ^
      const DeepCollectionEquality().hash(rpe) ^
      const DeepCollectionEquality().hash(notes) ^
      const DeepCollectionEquality().hash(weekdayForWorkout) ^
      const DeepCollectionEquality().hash(restTime) ^
      const DeepCollectionEquality().hash(orderId);

  @JsonKey(ignore: true)
  @override
  _$WorkoutPlanCopyWith<_WorkoutPlan> get copyWith =>
      __$WorkoutPlanCopyWithImpl<_WorkoutPlan>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_WorkoutPlanToJson(this);
  }
}

abstract class _WorkoutPlan implements WorkoutPlan {
  const factory _WorkoutPlan(
      {required int id,
      required String exerciseId,
      required String planName,
      required String exerciseName,
      required int minRepsPerSet,
      required int maxRepsPerSet,
      required int sets,
      required int rpe,
      required String notes,
      required int weekdayForWorkout,
      required double restTime,
      required int orderId}) = _$_WorkoutPlan;

  factory _WorkoutPlan.fromJson(Map<String, dynamic> json) =
      _$_WorkoutPlan.fromJson;

  @override
  int get id => throw _privateConstructorUsedError;
  @override
  String get exerciseId => throw _privateConstructorUsedError;
  @override
  String get planName => throw _privateConstructorUsedError;
  @override
  String get exerciseName => throw _privateConstructorUsedError;
  @override
  int get minRepsPerSet => throw _privateConstructorUsedError;
  @override
  int get maxRepsPerSet => throw _privateConstructorUsedError;
  @override
  int get sets => throw _privateConstructorUsedError;
  @override
  int get rpe => throw _privateConstructorUsedError;
  @override
  String get notes => throw _privateConstructorUsedError;
  @override
  int get weekdayForWorkout => throw _privateConstructorUsedError;
  @override
  double get restTime => throw _privateConstructorUsedError;
  @override
  int get orderId => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$WorkoutPlanCopyWith<_WorkoutPlan> get copyWith =>
      throw _privateConstructorUsedError;
}
