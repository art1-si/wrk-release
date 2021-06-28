import 'package:collection/collection.dart';
import 'package:workout_notes_app/data_models/exercise.dart';
import 'package:workout_notes_app/data_models/exercise_log.dart';
import 'package:workout_notes_app/data_models/group_by_model.dart';

import 'package:workout_notes_app/services/api_path.dart';
import 'package:workout_notes_app/services/firebase_service.dart';

abstract class Database {
  Future<void> createExercise(Exercise exercise);
  Future<void> createExerciseLog(ExerciseLog exerciseLog);

  Future<void> upadateExercise(Exercise exercise);
  Future<void> upadateExerciseLog(ExerciseLog exerciseLog);

  Future<void> deleteExercise(Exercise exercise);
  Future<void> deleteExerciseLog(ExerciseLog exerciseLog);

  Stream<List<ExerciseLog>> exerciseLogStream();
  Stream<List<Exercise>> exercisesStream();
}

String documentIdFromCurrentDate() => DateTime.now().toIso8601String();

class FirestoreDatabase implements Database {
  FirestoreDatabase({required this.uid});
  final String uid;
  final _service = FirestoreService.instance;

  @override
  Future<void> createExercise(Exercise exercise) async => _service.setData(
        path: APIPath.exercise(exercise.id),
        data: exercise.toJson(),
      );
  @override
  Future<void> createExerciseLog(ExerciseLog exerciseLog) async =>
      _service.setData(
        path: APIPath.exerciseLog(uid, exerciseLog.id),
        data: exerciseLog.toJson(),
      );

  @override
  Future<void> upadateExercise(Exercise exercise) async => _service.updateData(
        path: APIPath.exercise(exercise.id),
        data: exercise.toJson(),
      );
  @override
  Future<void> upadateExerciseLog(ExerciseLog exerciseLog) async =>
      _service.updateData(
        path: APIPath.exerciseLog(uid, exerciseLog.id),
        data: exerciseLog.toJson(),
      );

  @override
  Future<void> deleteExercise(Exercise exercise) async => _service.deleteData(
        path: APIPath.exercise(exercise.id),
      );
  @override
  Future<void> deleteExerciseLog(ExerciseLog exerciseLog) async =>
      _service.deleteData(
        path: APIPath.exerciseLog(uid, exerciseLog.id),
      );

  @override
  Stream<List<ExerciseLog>> exerciseLogStream() => _service.collectionStream(
      path: APIPath.exercisesLog(uid),
      builder: (data, documentID) => ExerciseLog.fromJson(data));
  @override
  Stream<List<Exercise>> exercisesStream() {
    return _service.collectionStream(
      path: APIPath.exercises,
      builder: (data, documentID) => Exercise.fromJson(data),
    );
  }

  Stream<List<GroupByModel<T>>> groupByValue<T>({
    required Stream<List<T>> data,
    required String Function(T) groupByValue,
    required Function(T) titleBuilder,
  }) {
    return data.map((entries) {
      var entiresToReturn = <GroupByModel<T>>[];

      var groupEntries = groupBy(entries, groupByValue);

      for (var key in groupEntries.keys) {
        print(key);
        entiresToReturn.add(
          GroupByModel<T>(
              title: titleBuilder(groupEntries[key]!.first),
              data: groupEntries[key]!),
        );
      }
      return entiresToReturn;
    });
    // throw UnimplementedError();
  }
}
