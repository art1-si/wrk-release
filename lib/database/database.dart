import 'package:workout_notes_app/data_models/exercise.dart';
import 'package:workout_notes_app/data_models/exercise_log.dart';
import 'package:workout_notes_app/data_models/group_by_model.dart';

abstract class Database {
  Future<void> createExercise(Exercise exercise);
  Future<void> createExerciseLog(ExerciseLog exerciseLog);

  Future<void> upadateExercise(Exercise exercise);
  Future<void> upadateExerciseLog(ExerciseLog exerciseLog);

  Future<void> deleteExercise(Exercise exercise);
  Future<void> deleteExerciseLog(ExerciseLog exerciseLog);

  Stream<List<ExerciseLog>> exerciseLogStream();
  Stream<List<Exercise>> exercisesStream();
  Stream<List<GroupByModel<T>>> groupByValue<T>({
    required Stream<List<T>> data,
    required String Function(T) groupByValue,
    required Function(T) titleBuilder,
    required Function(T) dataID,
  });
}

String documentIdFromCurrentDate() => DateTime.now().toIso8601String();
