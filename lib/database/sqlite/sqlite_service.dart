import 'dart:async';
import 'dart:convert';
import 'package:rxdart/rxdart.dart';
import 'package:collection/collection.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workout_notes_app/data_models/group_by_model.dart';
import 'package:workout_notes_app/data_models/exercise_log.dart';
import 'package:workout_notes_app/data_models/exercise.dart';
import 'package:workout_notes_app/database/database.dart';
import 'package:workout_notes_app/database/sqlite/exercise_const.dart';
import 'package:workout_notes_app/database/sqlite/sql_crud.dart';

final sqlDatabase = Provider.autoDispose((ref) {
  final _exerciseService = ref.watch(exerciseSQLCrud);
  final _exerciseLogService = ref.watch(exerciseLogSQLCrud);
  final _sqlDatabase = SqliteDatabase(
    exercisesDatabase: _exerciseService,
    exerciseLogDatabase: _exerciseLogService,
  );
  ref.onDispose(() {
    _sqlDatabase.dispose();
  });

  return _sqlDatabase;
});

class SqliteDatabase implements Database {
  SqliteDatabase(
      {required this.exercisesDatabase, required this.exerciseLogDatabase});

  final SQLCrud exercisesDatabase;

  final SQLCrud exerciseLogDatabase;

  final _exerciseLog = BehaviorSubject<List<ExerciseLog>>();
  final _exercise = BehaviorSubject<List<Exercise>>();

  @override
  Future<void> createExercise(Exercise exercise) async {
    await exercisesDatabase.createEntry(entry: exercise.toJson());
    exercisesStream();
  }

  @override
  Future<void> createExerciseLog(ExerciseLog exerciseLog) async {
    await exerciseLogDatabase.createEntry(entry: exerciseLog.toJson());
    exerciseLogStream();
  }

  @override
  Future<void> deleteExercise(Exercise exercise) async {
    await exercisesDatabase.deleteEntry(exercise.id);
    exercisesStream();
  }

  @override
  Future<void> deleteExerciseLog(ExerciseLog exerciseLog) async {
    await exerciseLogDatabase.deleteEntry(exerciseLog.id);

    exerciseLogStream();
  }

  @override
  Stream<List<ExerciseLog>> exerciseLogStream() {
    print("fetch data exerciseLog");
    final _result = exerciseLogDatabase.fetchEntries(
        entryBuilder: (entry) => ExerciseLog.fromJson(entry));
    _exerciseLog.sink.addStream(_result.asStream());
    return _exerciseLog.stream;
  }

  @override
  Stream<List<Exercise>> exercisesStream() {
    print("fetch data exercise");
    final _result = exercisesDatabase.fetchEntries(
        entryBuilder: (entry) => Exercise.fromJson(entry));
    _result.whenComplete(
        () => _exercise.sink.addStream(Stream.fromFuture(_result)));

    return _exercise;
  }

  @override
  Future<void> upadateExercise(Exercise exercise) async {
    await exerciseLogDatabase.updateEntry(
      entry: exercise.toJson(),
      elementId: exercise.id,
    );
  }

  @override
  Future<void> upadateExerciseLog(ExerciseLog exerciseLog) async {
    await exerciseLogDatabase.updateEntry(
      entry: exerciseLog.toJson(),
      elementId: exerciseLog.id,
    );
    exerciseLogStream();
  }

  @override
  Stream<List<GroupByModel<T>>> groupByValue<T>(
      {required Stream<List<T>> data,
      required String Function(T p1) groupByValue,
      required Function(T p1) titleBuilder,
      required Function(T p1) dataID}) {
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
  }

  void dispose() {
    _exerciseLog.close();
    _exercise.close();
  }
}
