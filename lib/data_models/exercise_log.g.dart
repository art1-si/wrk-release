// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'exercise_log.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_ExerciseLog _$$_ExerciseLogFromJson(Map<String, dynamic> json) =>
    _$_ExerciseLog(
      id: json['id'] as String,
      exerciseID: json['exerciseID'] as String,
      exerciseName: json['exerciseName'] as String,
      exerciseType: json['exerciseType'] as String,
      weight: (json['weight'] as num).toDouble(),
      reps: json['reps'] as int,
      dateCreated: json['dateCreated'] as String,
      exerciseRPE: json['exerciseRPE'] as int,
    );

Map<String, dynamic> _$$_ExerciseLogToJson(_$_ExerciseLog instance) =>
    <String, dynamic>{
      'id': instance.id,
      'exerciseID': instance.exerciseID,
      'exerciseName': instance.exerciseName,
      'exerciseType': instance.exerciseType,
      'weight': instance.weight,
      'reps': instance.reps,
      'dateCreated': instance.dateCreated,
      'exerciseRPE': instance.exerciseRPE,
    };
