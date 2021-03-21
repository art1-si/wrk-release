import 'dart:async';

import 'package:rxdart/rxdart.dart';
import 'package:workout_notes_app/database/workout_plan_database.dart';
import 'package:workout_notes_app/models/exercise_plan_model.dart';

class WorkoutPlanStreams {
  WorkoutPlanDatabase db = WorkoutPlanDatabase();

  final _workoutPlanStream = BehaviorSubject<List<ExercisePlanModel>>();
  final _workoutPlanNamesStream = BehaviorSubject<List<ExercisePlanModel>>();

  Stream<List<ExercisePlanModel>> get exercisePlanStream =>
      _workoutPlanStream.stream;
  StreamSink<List<ExercisePlanModel>> get toExercisePlanStream =>
      _workoutPlanStream.sink;

  Stream<List<ExercisePlanModel>> get planNamesStream =>
      _workoutPlanNamesStream.stream;
  StreamSink<List<ExercisePlanModel>> get toPlanNamesStream =>
      _workoutPlanNamesStream.sink;

  WorkoutPlanStreams() {
    fetchWorkoutPlanFromDb();
    fetchWorkoutNamesFromDb();
  }

  void fetchWorkoutPlanFromDb() async {
    List<ExercisePlanModel> workoutPlanToStream = <ExercisePlanModel>[];
    List workoutPlanFromDb = await db.getExercises();
    workoutPlanFromDb.forEach((element) {
      workoutPlanToStream.add(ExercisePlanModel.map(element));
    });
    toExercisePlanStream.add(workoutPlanToStream);
  }

  void fetchWorkoutNamesFromDb() async {
    List<ExercisePlanModel> workoutPlanToStream = <ExercisePlanModel>[];
    List workoutPlanFromDb = await db.getPlanNames();
    workoutPlanFromDb.forEach((element) {
      workoutPlanToStream.add(ExercisePlanModel.map(element));
    });
    toPlanNamesStream.add(workoutPlanToStream);
  }

  void dispose() {
    _workoutPlanStream.close();
    _workoutPlanNamesStream.close();
  }
}
