// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

part of 'exercise_log.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

ExerciseLog _$ExerciseLogFromJson(Map<String, dynamic> json) {
  return _ExerciseLog.fromJson(json);
}

/// @nodoc
class _$ExerciseLogTearOff {
  const _$ExerciseLogTearOff();

  _ExerciseLog call(
      {required String id,
      required String exerciseID,
      required String exerciseName,
      required String exerciseType,
      required double weight,
      required int reps,
      required int setCount,
      required String dateCreated,
      required int exerciseRPE,
      String? notes}) {
    return _ExerciseLog(
      id: id,
      exerciseID: exerciseID,
      exerciseName: exerciseName,
      exerciseType: exerciseType,
      weight: weight,
      reps: reps,
      setCount: setCount,
      dateCreated: dateCreated,
      exerciseRPE: exerciseRPE,
      notes: notes,
    );
  }

  ExerciseLog fromJson(Map<String, Object> json) {
    return ExerciseLog.fromJson(json);
  }
}

/// @nodoc
const $ExerciseLog = _$ExerciseLogTearOff();

/// @nodoc
mixin _$ExerciseLog {
  String get id => throw _privateConstructorUsedError;
  String get exerciseID => throw _privateConstructorUsedError;
  String get exerciseName => throw _privateConstructorUsedError;
  String get exerciseType => throw _privateConstructorUsedError;
  double get weight => throw _privateConstructorUsedError;
  int get reps => throw _privateConstructorUsedError;
  int get setCount => throw _privateConstructorUsedError;
  String get dateCreated => throw _privateConstructorUsedError;
  int get exerciseRPE => throw _privateConstructorUsedError;
  String? get notes => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ExerciseLogCopyWith<ExerciseLog> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ExerciseLogCopyWith<$Res> {
  factory $ExerciseLogCopyWith(
          ExerciseLog value, $Res Function(ExerciseLog) then) =
      _$ExerciseLogCopyWithImpl<$Res>;
  $Res call(
      {String id,
      String exerciseID,
      String exerciseName,
      String exerciseType,
      double weight,
      int reps,
      int setCount,
      String dateCreated,
      int exerciseRPE,
      String? notes});
}

/// @nodoc
class _$ExerciseLogCopyWithImpl<$Res> implements $ExerciseLogCopyWith<$Res> {
  _$ExerciseLogCopyWithImpl(this._value, this._then);

  final ExerciseLog _value;
  // ignore: unused_field
  final $Res Function(ExerciseLog) _then;

  @override
  $Res call({
    Object? id = freezed,
    Object? exerciseID = freezed,
    Object? exerciseName = freezed,
    Object? exerciseType = freezed,
    Object? weight = freezed,
    Object? reps = freezed,
    Object? setCount = freezed,
    Object? dateCreated = freezed,
    Object? exerciseRPE = freezed,
    Object? notes = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      exerciseID: exerciseID == freezed
          ? _value.exerciseID
          : exerciseID // ignore: cast_nullable_to_non_nullable
              as String,
      exerciseName: exerciseName == freezed
          ? _value.exerciseName
          : exerciseName // ignore: cast_nullable_to_non_nullable
              as String,
      exerciseType: exerciseType == freezed
          ? _value.exerciseType
          : exerciseType // ignore: cast_nullable_to_non_nullable
              as String,
      weight: weight == freezed
          ? _value.weight
          : weight // ignore: cast_nullable_to_non_nullable
              as double,
      reps: reps == freezed
          ? _value.reps
          : reps // ignore: cast_nullable_to_non_nullable
              as int,
      setCount: setCount == freezed
          ? _value.setCount
          : setCount // ignore: cast_nullable_to_non_nullable
              as int,
      dateCreated: dateCreated == freezed
          ? _value.dateCreated
          : dateCreated // ignore: cast_nullable_to_non_nullable
              as String,
      exerciseRPE: exerciseRPE == freezed
          ? _value.exerciseRPE
          : exerciseRPE // ignore: cast_nullable_to_non_nullable
              as int,
      notes: notes == freezed
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
abstract class _$ExerciseLogCopyWith<$Res>
    implements $ExerciseLogCopyWith<$Res> {
  factory _$ExerciseLogCopyWith(
          _ExerciseLog value, $Res Function(_ExerciseLog) then) =
      __$ExerciseLogCopyWithImpl<$Res>;
  @override
  $Res call(
      {String id,
      String exerciseID,
      String exerciseName,
      String exerciseType,
      double weight,
      int reps,
      int setCount,
      String dateCreated,
      int exerciseRPE,
      String? notes});
}

/// @nodoc
class __$ExerciseLogCopyWithImpl<$Res> extends _$ExerciseLogCopyWithImpl<$Res>
    implements _$ExerciseLogCopyWith<$Res> {
  __$ExerciseLogCopyWithImpl(
      _ExerciseLog _value, $Res Function(_ExerciseLog) _then)
      : super(_value, (v) => _then(v as _ExerciseLog));

  @override
  _ExerciseLog get _value => super._value as _ExerciseLog;

  @override
  $Res call({
    Object? id = freezed,
    Object? exerciseID = freezed,
    Object? exerciseName = freezed,
    Object? exerciseType = freezed,
    Object? weight = freezed,
    Object? reps = freezed,
    Object? setCount = freezed,
    Object? dateCreated = freezed,
    Object? exerciseRPE = freezed,
    Object? notes = freezed,
  }) {
    return _then(_ExerciseLog(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      exerciseID: exerciseID == freezed
          ? _value.exerciseID
          : exerciseID // ignore: cast_nullable_to_non_nullable
              as String,
      exerciseName: exerciseName == freezed
          ? _value.exerciseName
          : exerciseName // ignore: cast_nullable_to_non_nullable
              as String,
      exerciseType: exerciseType == freezed
          ? _value.exerciseType
          : exerciseType // ignore: cast_nullable_to_non_nullable
              as String,
      weight: weight == freezed
          ? _value.weight
          : weight // ignore: cast_nullable_to_non_nullable
              as double,
      reps: reps == freezed
          ? _value.reps
          : reps // ignore: cast_nullable_to_non_nullable
              as int,
      setCount: setCount == freezed
          ? _value.setCount
          : setCount // ignore: cast_nullable_to_non_nullable
              as int,
      dateCreated: dateCreated == freezed
          ? _value.dateCreated
          : dateCreated // ignore: cast_nullable_to_non_nullable
              as String,
      exerciseRPE: exerciseRPE == freezed
          ? _value.exerciseRPE
          : exerciseRPE // ignore: cast_nullable_to_non_nullable
              as int,
      notes: notes == freezed
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_ExerciseLog implements _ExerciseLog {
  const _$_ExerciseLog(
      {required this.id,
      required this.exerciseID,
      required this.exerciseName,
      required this.exerciseType,
      required this.weight,
      required this.reps,
      required this.setCount,
      required this.dateCreated,
      required this.exerciseRPE,
      this.notes});

  factory _$_ExerciseLog.fromJson(Map<String, dynamic> json) =>
      _$_$_ExerciseLogFromJson(json);

  @override
  final String id;
  @override
  final String exerciseID;
  @override
  final String exerciseName;
  @override
  final String exerciseType;
  @override
  final double weight;
  @override
  final int reps;
  @override
  final int setCount;
  @override
  final String dateCreated;
  @override
  final int exerciseRPE;
  @override
  final String? notes;

  @override
  String toString() {
    return 'ExerciseLog(id: $id, exerciseID: $exerciseID, exerciseName: $exerciseName, exerciseType: $exerciseType, weight: $weight, reps: $reps, setCount: $setCount, dateCreated: $dateCreated, exerciseRPE: $exerciseRPE, notes: $notes)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _ExerciseLog &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.exerciseID, exerciseID) ||
                const DeepCollectionEquality()
                    .equals(other.exerciseID, exerciseID)) &&
            (identical(other.exerciseName, exerciseName) ||
                const DeepCollectionEquality()
                    .equals(other.exerciseName, exerciseName)) &&
            (identical(other.exerciseType, exerciseType) ||
                const DeepCollectionEquality()
                    .equals(other.exerciseType, exerciseType)) &&
            (identical(other.weight, weight) ||
                const DeepCollectionEquality().equals(other.weight, weight)) &&
            (identical(other.reps, reps) ||
                const DeepCollectionEquality().equals(other.reps, reps)) &&
            (identical(other.setCount, setCount) ||
                const DeepCollectionEquality()
                    .equals(other.setCount, setCount)) &&
            (identical(other.dateCreated, dateCreated) ||
                const DeepCollectionEquality()
                    .equals(other.dateCreated, dateCreated)) &&
            (identical(other.exerciseRPE, exerciseRPE) ||
                const DeepCollectionEquality()
                    .equals(other.exerciseRPE, exerciseRPE)) &&
            (identical(other.notes, notes) ||
                const DeepCollectionEquality().equals(other.notes, notes)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(exerciseID) ^
      const DeepCollectionEquality().hash(exerciseName) ^
      const DeepCollectionEquality().hash(exerciseType) ^
      const DeepCollectionEquality().hash(weight) ^
      const DeepCollectionEquality().hash(reps) ^
      const DeepCollectionEquality().hash(setCount) ^
      const DeepCollectionEquality().hash(dateCreated) ^
      const DeepCollectionEquality().hash(exerciseRPE) ^
      const DeepCollectionEquality().hash(notes);

  @JsonKey(ignore: true)
  @override
  _$ExerciseLogCopyWith<_ExerciseLog> get copyWith =>
      __$ExerciseLogCopyWithImpl<_ExerciseLog>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_ExerciseLogToJson(this);
  }
}

abstract class _ExerciseLog implements ExerciseLog {
  const factory _ExerciseLog(
      {required String id,
      required String exerciseID,
      required String exerciseName,
      required String exerciseType,
      required double weight,
      required int reps,
      required int setCount,
      required String dateCreated,
      required int exerciseRPE,
      String? notes}) = _$_ExerciseLog;

  factory _ExerciseLog.fromJson(Map<String, dynamic> json) =
      _$_ExerciseLog.fromJson;

  @override
  String get id => throw _privateConstructorUsedError;
  @override
  String get exerciseID => throw _privateConstructorUsedError;
  @override
  String get exerciseName => throw _privateConstructorUsedError;
  @override
  String get exerciseType => throw _privateConstructorUsedError;
  @override
  double get weight => throw _privateConstructorUsedError;
  @override
  int get reps => throw _privateConstructorUsedError;
  @override
  int get setCount => throw _privateConstructorUsedError;
  @override
  String get dateCreated => throw _privateConstructorUsedError;
  @override
  int get exerciseRPE => throw _privateConstructorUsedError;
  @override
  String? get notes => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$ExerciseLogCopyWith<_ExerciseLog> get copyWith =>
      throw _privateConstructorUsedError;
}
