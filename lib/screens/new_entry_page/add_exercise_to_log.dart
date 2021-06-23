import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:workout_notes_app/data_models/exercise.dart';
import 'package:workout_notes_app/data_models/exercise_log.dart';
import 'package:workout_notes_app/data_models/workout_plan.dart';

import 'package:workout_notes_app/provider/graph_detail_provider.dart';
import 'package:workout_notes_app/provider/log_values_provider.dart';
import 'package:workout_notes_app/screens/new_entry_page/history_view.dart';
import 'package:workout_notes_app/screens/new_entry_page/log_screen.dart';
import 'package:workout_notes_app/screens/new_entry_page/my_graph_widget.dart';
import 'package:workout_notes_app/screens/new_entry_page/rep_max_view.dart';

class AddExerciseToLog extends StatelessWidget {
  final List<Exercise> selectedExercise;
  final int selectedIndex;
  final bool showPlanDetails;
  final List<WorkoutPlan>? planDetails;
  AddExerciseToLog({
    Key? key,
    required this.selectedExercise,
    required this.showPlanDetails,
    this.planDetails,
    required this.selectedIndex,
  }) : super(key: key);

  int exerciseIndex = 0;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => LogValuesProvider(),
      child: DefaultTabController(
        length: 4,
        child: GestureDetector(
          onTap: () {
            FocusScopeNode currentFocus = FocusScope.of(context);

            if (!currentFocus.hasPrimaryFocus) {
              currentFocus.unfocus();
            }
          },
          child: Scaffold(
            backgroundColor: Theme.of(context).backgroundColor,
            appBar: AppBar(
              actions: [
                GestureDetector(
                  onTap: () {
                    if (exerciseIndex > 0) {}
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Icon(
                      Icons.keyboard_arrow_left,
                      color:
                          (exerciseIndex == 0) ? Colors.white30 : Colors.white,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    if (exerciseIndex < selectedExercise.length - 1) {}
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Icon(
                      Icons.keyboard_arrow_right,
                      color: (exerciseIndex < selectedExercise.length - 1)
                          ? Colors.white
                          : Colors.white30,
                    ),
                  ),
                ),
              ],
              backgroundColor: Theme.of(context).backgroundColor,
              elevation: 0,
              centerTitle: true,
              title: Text(
                "${selectedExercise[exerciseIndex].exerciseName}",
                //style: Theme.of(context).textTheme.headline4,
              ),
              bottom: TabBar(
                  indicatorWeight: 0.1,
                  indicatorColor: Colors.transparent,
                  labelStyle: TextStyle(fontSize: 13),
                  labelColor: Colors.white,
                  unselectedLabelStyle: TextStyle(fontSize: 12),
                  tabs: <Widget>[
                    Text("LOG"),
                    Text("GRAPH"),
                    Text("HISTORY"),
                    Text("%RM"),
                  ]),
            ),
            body: Column(
              children: [
                Divider(
                  thickness: 1,
                ),
                StreamBuilder<List<ExerciseLog>>(
                  stream: null, //TODO
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      Text("Wait");
                    }
                    return Expanded(
                      child: TabBarView(
                        physics: NeverScrollableScrollPhysics(),
                        children: <Widget>[
                          LogScreen(
                            selectedExercise: selectedExercise[exerciseIndex],
                            selectedIndex: selectedIndex,
                            repsValue:
                                selectedExercise[selectedIndex].lastReps!,
                            rpeValue: selectedExercise[selectedIndex].lastRPE!,
                            weightValue:
                                selectedExercise[selectedIndex].lastWeight!,
                          ),
                          ChangeNotifierProvider(
                            create: (context) => GraphDetailProvider(),
                            child: MyGraphWidget(
                              exerciseLog: snapshot.data!,
                            ),
                          ),
                          HistoryView(
                            exerciseLog: snapshot.data!,
                          ),
                          RepMaxView(
                            exerciseLog: snapshot.data!,
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
