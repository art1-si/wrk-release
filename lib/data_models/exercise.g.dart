// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'exercise.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

// ignore: non_constant_identifier_names
_$_Exercise _$_$_ExerciseFromJson(Map<String, dynamic> json) {
  return _$_Exercise(
    id: json['id'] as String,
    exerciseName: json['exerciseName'] as String,
    exerciseType: json['exerciseType'] as String,
    lastWeight: (json['lastWeight'] as num?)?.toDouble(),
    lastReps: json['lastReps'] as int?,
    lastRPE: json['lastRPE'] as int?,
  );
}

// ignore: non_constant_identifier_names
Map<String, dynamic> _$_$_ExerciseToJson(_$_Exercise instance) =>
    <String, dynamic>{
      'id': instance.id,
      'exerciseName': instance.exerciseName,
      'exerciseType': instance.exerciseType,
      'lastWeight': instance.lastWeight,
      'lastReps': instance.lastReps,
      'lastRPE': instance.lastRPE,
    };
