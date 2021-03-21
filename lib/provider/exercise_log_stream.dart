import 'dart:async';
import 'package:rxdart/rxdart.dart';
import 'package:workout_notes_app/database/exercise_db.dart';
import 'package:workout_notes_app/models/exercise_log_model.dart';

class ExerciseLogStreams {
  ExerciseLogDatabase db = ExerciseLogDatabase();

  final _exerciseLogStream = BehaviorSubject<List<ExerciseLogModel>>();

  Stream<List<ExerciseLogModel>> get exereciseLogStream =>
      _exerciseLogStream.stream;
  StreamSink<List<ExerciseLogModel>> get addToExerciseLogStream =>
      _exerciseLogStream.sink;

  ExerciseLogStreams() {
    addExercieLogToStream();
  }

  void addExercieLogToStream() async {
    List<ExerciseLogModel> exerciseLogToStream = <ExerciseLogModel>[];
    List exerciseLogFromDb = await db.getExercises();
    exerciseLogFromDb.forEach((exercise) {
      exerciseLogToStream.add(ExerciseLogModel.map(exercise));
    });
    addToExerciseLogStream.add(exerciseLogToStream);
  }

  void deleteSelectedLog(int id) {
    db.deleteExercise(id);
    return addExercieLogToStream();
  }

  Stream<List<ExerciseLogModel>> getLogToExercise(String exercise) {
    return _exerciseLogStream.stream.map<List<ExerciseLogModel>>(
        (list) => list.where((item) => item.exerciseName == exercise).toList());
  }

  Stream<List<ExerciseLogModel>> getLogToDate(String date) {
    print("stream is working with date $date");
    return _exerciseLogStream.stream.map<List<ExerciseLogModel>>(
        (list) => list.where((item) => item.dateCreated == date).toList());
  }

  void dispose() {
    _exerciseLogStream.close();
  }
}
