import 'package:collection/collection.dart';
import 'package:uuid/uuid.dart';
import 'package:workout_notes_app/data_models/exercise.dart';
import 'package:workout_notes_app/data_models/exercise_log.dart';
import 'package:workout_notes_app/data_models/group_by_model.dart';

import 'package:workout_notes_app/constants/api_path.dart';
import 'package:workout_notes_app/database/firebase/firebase_service.dart';

abstract class Database {
  Future<void> createExercise(Exercise exercise);
  Future<void> createExerciseLog(ExerciseLog exerciseLog);

  Future<void> upadateExercise(Exercise exercise);
  Future<void> upadateExerciseLog(ExerciseLog exerciseLog);

  Future<void> deleteExercise(Exercise exercise);
  Future<void> deleteExerciseLog(ExerciseLog exerciseLog);

  Stream<List<ExerciseLog>> exerciseLogStream();
  Stream<List<Exercise>> exercisesStream();
  Stream<List<GroupByModel<T>>> groupByValue<T>();
}

String documentIdFromCurrentDate() => DateTime.now().toIso8601String();
