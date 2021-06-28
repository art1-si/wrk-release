import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:json_annotation/json_annotation.dart';

part 'exercise_log.freezed.dart';
part 'exercise_log.g.dart';

@freezed
class ExerciseLog with _$ExerciseLog {
  const factory ExerciseLog({
    required String id,
    required String exerciseID,
    required String exerciseName,
    required String exerciseType,
    required double weight,
    required int reps,
    required int? setCount,
    required String dateCreated,
    required int exerciseRPE,
    String? notes,
  }) = _ExerciseLog;
  factory ExerciseLog.fromJson(Map<String, dynamic> json) =>
      _$ExerciseLogFromJson(json);
}
