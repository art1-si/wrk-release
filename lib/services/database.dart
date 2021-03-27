import 'dart:html';

import 'package:flutter/foundation.dart';
import 'package:workout_notes_app/database/asset_db_of_exercises.dart';
import 'package:workout_notes_app/models/exercise_log_model.dart';
import 'package:workout_notes_app/models/exercise_model.dart';
import 'package:workout_notes_app/services/api_path.dart';
import 'package:workout_notes_app/services/firebase_service.dart';

abstract class Database {
  Future<void> createExercise(ExerciseModel exercise);
  Future<void> createExerciseLog(ExerciseLogModel exerciseLog);

  Future<void> upadateExercise(ExerciseModel exercise);
  Future<void> upadateExerciseLog(ExerciseLogModel exerciseLog);

  Future<void> deleteExercise(ExerciseModel exercise);
  Future<void> deleteExerciseLog(ExerciseLogModel exerciseLog);

  Stream<List<ExerciseLogModel>> exerciseLogStream();
  Stream<List<ExerciseModel>> exercisesStream();
}

String documentIdFromCurrentDate() => DateTime.now().toIso8601String();

class FirestoreDatabase implements Database {
  FirestoreDatabase({@required this.uid}) : assert(uid != null);
  final String uid;
  final _service = FirestoreService.instance;

  @override
  Future<void> createExercise(ExerciseModel exercise) async => _service.setData(
        path: APIPath.exercise(exercise.id),
        data: exercise.toMap(),
      );
  @override
  Future<void> createExerciseLog(ExerciseLogModel exerciseLog) async =>
      _service.setData(
        path: APIPath.exerciseLog(uid, exerciseLog.id),
        data: exerciseLog.toMap(),
      );

  @override
  Future<void> upadateExercise(ExerciseModel exercise) async =>
      _service.updateData(
        path: APIPath.exercise(exercise.id),
        data: exercise.toMap(),
      );
  @override
  Future<void> upadateExerciseLog(ExerciseLogModel exerciseLog) async =>
      _service.updateData(
        path: APIPath.exerciseLog(uid, exerciseLog.id),
        data: exerciseLog.toMap(),
      );

  @override
  Future<void> deleteExercise(ExerciseModel exercise) async =>
      _service.deleteData(
        path: APIPath.exercise(exercise.id),
      );
  @override
  Future<void> deleteExerciseLog(ExerciseLogModel exerciseLog) async =>
      _service.deleteData(
        path: APIPath.exerciseLog(uid, exerciseLog.id),
      );

  @override
  Stream<List<ExerciseLogModel>> exerciseLogStream() => _service.collectionStream(path: APIPath.exercisesLog(uid), builder: builder)
  @override
  Stream<List<ExerciseModel>> exercisesStream() {}
}
