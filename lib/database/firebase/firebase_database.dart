import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:uuid/uuid.dart';
import 'package:workout_notes_app/constants/api_path.dart';
import 'package:workout_notes_app/data_models/exercise.dart';
import 'package:workout_notes_app/data_models/exercise_log.dart';
import 'package:workout_notes_app/data_models/group_by_model.dart';
import 'package:workout_notes_app/database/database.dart';
import 'package:workout_notes_app/database/firebase/firebase_service.dart';

class FirestoreDatabase implements Database {
  FirestoreDatabase({required this.uid});
  final String uid;
  final _service = FirestoreService.instance;

  var uuid = Uuid();

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

  @override
  Stream<List<GroupByModel<T>>> groupByValue<T>({
    required Stream<List<T>> data,
    required String Function(T) groupByValue,
    required Function(T) titleBuilder,
    required Function(T) dataID,
  }) {
    return data.map((entries) {
      var entiresToReturn = <GroupByModel<T>>[];

      var groupEntries = groupBy(entries, groupByValue);

      for (var key in groupEntries.keys) {
        entiresToReturn.add(
          GroupByModel<T>(
            title: titleBuilder(groupEntries[key]!.first),
            data: groupEntries[key]!,
            exerciseID: dataID(groupEntries[key]!.first),
          ),
        );
      }
      return entiresToReturn;
    });
    // throw UnimplementedError();
  }
}
