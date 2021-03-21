import 'dart:async';
import 'package:rxdart/rxdart.dart';
import 'package:workout_notes_app/database/asset_db_of_exercises.dart';
import 'package:workout_notes_app/models/exercise_model.dart';

class ExerciseStreams {
  ExerciseListDb db = ExerciseListDb();

  final _exerciseStream = BehaviorSubject<List<ExerciseModel>>();
  final _exerciseByTypeStream = BehaviorSubject<List<ExerciseModel>>();
  final _exerciseTypeStream = StreamController<List<ExerciseModel>>.broadcast();

  Stream<List<ExerciseModel>> get exerciseStream => _exerciseStream.stream;
  StreamSink<List<ExerciseModel>> get addToExerciseStream =>
      _exerciseStream.sink;

  Stream<List<ExerciseModel>> get exerciseByTypeStream =>
      _exerciseByTypeStream.stream;
  StreamSink<List<ExerciseModel>> get addToExerciseByTypeStream =>
      _exerciseByTypeStream.sink;

  Stream<List<ExerciseModel>> get exerciseTypeStream =>
      _exerciseTypeStream.stream;
  StreamSink<List<ExerciseModel>> get addToExerciseTypeStream =>
      _exerciseTypeStream.sink;

  ExerciseStreams() {
    addExercisesToStream();
    addExercisesTypeToStream();
  }

  void addExercisesByTypeToStream(String type) async {
    List<ExerciseModel> exercisesToStream = <ExerciseModel>[];
    List exercisesFromDb = await db.getExercisesByType(type);
    exercisesFromDb.forEach((exercise) {
      exercisesToStream.add(ExerciseModel.map(exercise));
    });
    addToExerciseByTypeStream.add(exercisesToStream);
  }

  void addExercisesToStream() async {
    List<ExerciseModel> exercisesToStream = <ExerciseModel>[];
    List exercisesFromDb = await db.getExercises();
    exercisesFromDb.forEach((exercise) {
      exercisesToStream.add(ExerciseModel.map(exercise));
    });
    addToExerciseStream.add(exercisesToStream);
  }

  void addExercisesTypeToStream() async {
    List<ExerciseModel> exercisesTypeToStream = <ExerciseModel>[];
    List exercisesTypeFromDb = await db.getExercisesType();
    exercisesTypeFromDb.forEach((exerciseType) {
      exercisesTypeToStream.add(ExerciseModel.map(exerciseType));
    });
    addToExerciseTypeStream.add(exercisesTypeToStream);
  }

  void dispose() {
    _exerciseStream.close();
    _exerciseTypeStream.close();
    _exerciseByTypeStream.close();
  }
}
