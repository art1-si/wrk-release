import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:json_annotation/json_annotation.dart';

part 'workout_plan.freezed.dart';
part 'workout_plan.g.dart';

@freezed
class WorkoutPlan with _$WorkoutPlan {
  const factory WorkoutPlan({
    required int id,
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
    required int orderId,
  }) = _WorkoutPlan;
  factory WorkoutPlan.fromJson(Map<String, dynamic> json) =>
      _$WorkoutPlanFromJson(json);
}
