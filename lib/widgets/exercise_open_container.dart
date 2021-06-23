import 'package:flutter/material.dart';
import 'package:workout_notes_app/data_models/exercise.dart';
import 'package:workout_notes_app/data_models/workout_plan.dart';

import 'package:workout_notes_app/screens/new_entry_page/add_exercise_to_log.dart';

import 'package:workout_notes_app/widgets/closed_container.dart';

class MyOpenContainer extends StatelessWidget {
  final int selectedIndex;
  final List<Exercise> selectedExercises;
  final bool showPlanDetail;
  final List<WorkoutPlan> planDetail;
  final WorkoutPlan workout;

  MyOpenContainer({
    Key? key,
    required this.selectedIndex,
    required this.selectedExercises,
    required this.showPlanDetail,
    required this.planDetail,
    required this.workout,
  }) : super(key: key);

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
      onLongPress: () => null, //TODO: on press open container widget
      child: MyClosedContainer(
        workout: workout,
      ),
    );
  }
}
