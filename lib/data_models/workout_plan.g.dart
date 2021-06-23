// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'workout_plan.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_WorkoutPlan _$_$_WorkoutPlanFromJson(Map<String, dynamic> json) {
  return _$_WorkoutPlan(
    id: json['id'] as int,
    exerciseId: json['exerciseId'] as String,
    planName: json['planName'] as String,
    exerciseName: json['exerciseName'] as String,
    minRepsPerSet: json['minRepsPerSet'] as int,
    maxRepsPerSet: json['maxRepsPerSet'] as int,
    sets: json['sets'] as int,
    rpe: json['rpe'] as int,
    notes: json['notes'] as String,
    weekdayForWorkout: json['weekdayForWorkout'] as int,
    restTime: (json['restTime'] as num).toDouble(),
    orderId: json['orderId'] as int,
  );
}

Map<String, dynamic> _$_$_WorkoutPlanToJson(_$_WorkoutPlan instance) =>
    <String, dynamic>{
      'id': instance.id,
      'exerciseId': instance.exerciseId,
      'planName': instance.planName,
      'exerciseName': instance.exerciseName,
      'minRepsPerSet': instance.minRepsPerSet,
      'maxRepsPerSet': instance.maxRepsPerSet,
      'sets': instance.sets,
      'rpe': instance.rpe,
      'notes': instance.notes,
      'weekdayForWorkout': instance.weekdayForWorkout,
      'restTime': instance.restTime,
      'orderId': instance.orderId,
    };
