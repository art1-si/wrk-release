import 'package:flutter/material.dart';
import 'package:workout_notes_app/database/workout_plan_database.dart';
import 'package:workout_notes_app/models/exercise_model.dart';
import 'package:workout_notes_app/models/exercise_plan_model.dart';
import 'package:workout_notes_app/provider/plans_stream.dart';
import 'package:workout_notes_app/screens/add_exercise_to_log.dart';
import 'package:workout_notes_app/widgets/closed_container.dart';

class MyOpenContainer extends StatelessWidget {
  final int selectedIndex;
  final List<ExerciseModel> selectedExercises;
  final bool showPlanDetail;
  final List<ExercisePlanModel> planDetail;
  final ExercisePlanModel workout;

  MyOpenContainer(
      {Key key,
      this.selectedIndex,
      this.selectedExercises,
      this.showPlanDetail,
      this.planDetail,
      this.workout})
      : super(key: key);
  final WorkoutPlanDatabase planDb = WorkoutPlanDatabase();
  final WorkoutPlanStreams planStreams = WorkoutPlanStreams();
  _deleteOnLongPress(int id) {
    planDb.deleteExercise(id);
    planStreams.fetchWorkoutPlanFromDb();
  }

  Route _animatedRoute() {
    return PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            AddExerciseToLog(
              selectedIndex: selectedIndex,
              selectedExercise: selectedExercises,
              showPlanDetails: showPlanDetail,
              planDetails: planDetail,
            ),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          var begin = Offset(1.0, 0.0);
          var end = Offset.zero;
          var curve = Curves.easeInCubic;
          var tween =
              Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

          var offsetAnimation = animation.drive(tween);
          return SlideTransition(
            position: offsetAnimation,
            child: child,
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    print("myOpenContainer");
    return GestureDetector(
      onTap: () => Navigator.of(context).push(
        _animatedRoute(),
      ),
      onLongPress: () => _deleteOnLongPress(workout.id),
      child: MyClosedContainer(
        workout: workout,
      ),
    );
  }
}
