import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:provider/provider.dart';
import 'package:workout_notes_app/models/exercise_model.dart';
import 'package:workout_notes_app/models/exercise_plan_model.dart';
import 'package:workout_notes_app/provider/exercise_streams.dart';
import 'package:workout_notes_app/provider/plans_stream.dart';
import 'package:workout_notes_app/provider/provider_of_quick_add_button.dart';
import 'package:workout_notes_app/screens/exercises_selector/type_selector_page.dart';

import 'package:workout_notes_app/widgets/exercise_open_container.dart';

class PlanPage extends StatefulWidget {
  final String planName;

  const PlanPage({Key key, this.planName}) : super(key: key);
  @override
  _PlanPageState createState() => _PlanPageState();
}

class _PlanPageState extends State<PlanPage> {
  WorkoutPlanStreams planStreams = WorkoutPlanStreams();
  ExerciseStreams exerciseStreams = ExerciseStreams();

  @override
  void dispose() {
    planStreams.dispose();
    exerciseStreams.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var showButton = Provider.of<ProviderOfQuickAddButton>(context);
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
                showButton.setAddQuickPlanName(widget.planName);
                showButton.setShowButton(true);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => TypeSelectorPage()));
              },
              child: Icon(
                Icons.add,
                color: Theme.of(context).accentColor,
              ),
            ),
          ),
        ],
      ),
      body: StreamBuilder<List<ExercisePlanModel>>(
        stream: planStreams.exercisePlanStream,
        builder: (context, AsyncSnapshot<List<ExercisePlanModel>> snapshot) {
          if (!snapshot.hasData || snapshot.data.isEmpty) {
            return Text("NO DATA");
          }
          List<ExercisePlanModel> workoutPlan = snapshot.data
              .where((element) => (element.planName == widget.planName))
              .toList();
          return StreamBuilder(
            stream: exerciseStreams.exerciseStream,
            builder:
                (context, AsyncSnapshot<List<ExerciseModel>> exerciseSnapshot) {
              if (!exerciseSnapshot.hasData) {
                return Text("NO DATA");
              }
              List planDaysKeys = [];
              var groupedPlanDays =
                  groupBy(workoutPlan, (obj) => obj.weekdayForWorkout);
              groupedPlanDays.keys.forEach((element) {
                planDaysKeys.add(element);
              });

              return GroupedListView<ExercisePlanModel, String>(
                physics: AlwaysScrollableScrollPhysics(),
                elements: workoutPlan,
                groupBy: (element) => element.weekdayForWorkout,
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
                  List<ExerciseModel> exercisesToPass = <ExerciseModel>[];
                  List<ExercisePlanModel> listToCheck = <ExercisePlanModel>[];
                  listToCheck = workoutPlan
                      .where((element) =>
                          element.weekdayForWorkout ==
                          workout.weekdayForWorkout)
                      .toList();

                  for (int i = 0; i < listToCheck.length; i++) {
                    var exercise = exerciseSnapshot.data
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
