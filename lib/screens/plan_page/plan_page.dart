import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';

import 'package:workout_notes_app/data_models/exercise.dart';
import 'package:workout_notes_app/data_models/workout_plan.dart';
import 'package:workout_notes_app/provider/provider_of_quick_add_button.dart';
import 'package:workout_notes_app/screens/exercises_selector/type_selector_page.dart';

import 'package:workout_notes_app/widgets/exercise_open_container.dart';

class PlanPage extends StatefulWidget {
  final String planName;

  const PlanPage({Key? key, required this.planName}) : super(key: key);
  @override
  _PlanPageState createState() => _PlanPageState();
}

class _PlanPageState extends State<PlanPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).backgroundColor,
        title: Text(widget.planName),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TypeSelectorPage(),
                  ),
                );
              },
              child: Icon(
                Icons.add,
                color: Theme.of(context).accentColor,
              ),
            ),
          ),
        ],
      ),
      body: StreamBuilder<List<WorkoutPlan>>(
        stream: null, //TODO
        builder: (context, AsyncSnapshot<List<WorkoutPlan>> snapshot) {
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Text("NO DATA");
          }
          List<WorkoutPlan> workoutPlan = snapshot.data!
              .where((element) => (element.planName == widget.planName))
              .toList();
          return StreamBuilder(
            stream: null, //TODO
            builder: (context, AsyncSnapshot<List<Exercise>> exerciseSnapshot) {
              if (!exerciseSnapshot.hasData) {
                return Text("NO DATA");
              }
              List planDaysKeys = [];
              var groupedPlanDays = groupBy(
                  workoutPlan, (WorkoutPlan obj) => obj.weekdayForWorkout);
              groupedPlanDays.keys.forEach((element) {
                planDaysKeys.add(element);
              });

              return GroupedListView<WorkoutPlan, String>(
                physics: AlwaysScrollableScrollPhysics(),
                elements: workoutPlan,
                groupBy: (element) => element.weekdayForWorkout
                    .toString(), //TODO change to day name
                groupSeparatorBuilder: (value) {
                  return Padding(
                    padding: const EdgeInsets.only(
                        top: 8.0, left: 8, right: 8, bottom: 0),
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                      ),
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Text(
                            "$value",
                            style: Theme.of(context).textTheme.headline6,
                          ),
                        ),
                      ),
                    ),
                  );
                },
                indexedItemBuilder: (context, workout, index) {
                  List<Exercise> exercisesToPass = <Exercise>[];
                  List<WorkoutPlan> listToCheck = <WorkoutPlan>[];
                  listToCheck = workoutPlan
                      .where((element) =>
                          element.weekdayForWorkout ==
                          workout.weekdayForWorkout)
                      .toList();

                  for (int i = 0; i < listToCheck.length; i++) {
                    var exercise = exerciseSnapshot.data!
                        .where((element) =>
                            element.exerciseName == listToCheck[i].exerciseName)
                        .toList();

                    exercisesToPass.insertAll(i, exercise);
                  }

                  return MyOpenContainer(
                    selectedIndex: exercisesToPass.indexWhere((element) =>
                        element.exerciseName == workout.exerciseName),
                    selectedExercises: exercisesToPass,
                    showPlanDetail: true,
                    planDetail: listToCheck,
                    workout: workout,
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
