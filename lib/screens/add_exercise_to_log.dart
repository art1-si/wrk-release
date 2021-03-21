import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:workout_notes_app/database/asset_db_of_exercises.dart';
import 'package:workout_notes_app/database/exercise_db.dart';
import 'package:workout_notes_app/models/exercise_log_model.dart';
import 'package:workout_notes_app/models/exercise_model.dart';
import 'package:workout_notes_app/models/exercise_plan_model.dart';
import 'package:workout_notes_app/provider/exercise_log_stream.dart';
import 'package:workout_notes_app/provider/graph_detail_provider.dart';
import 'package:workout_notes_app/provider/log_values_provider.dart';
import 'package:workout_notes_app/widgets/history_view.dart';
import 'package:workout_notes_app/widgets/log_screen.dart';
import 'package:workout_notes_app/widgets/my_graph_widget.dart';
import 'package:workout_notes_app/widgets/rep_max_view.dart';

class AddExerciseToLog extends StatefulWidget {
  final List<ExerciseModel> selectedExercise;
  final int selectedIndex;
  final bool showPlanDetails;
  final List<ExercisePlanModel> planDetails;
  AddExerciseToLog(
      {Key key,
      this.selectedExercise,
      this.showPlanDetails,
      this.planDetails,
      this.selectedIndex})
      : super(key: key);
  @override
  _AddExerciseToLogState createState() => _AddExerciseToLogState();
}

class _AddExerciseToLogState extends State<AddExerciseToLog> {
  ExerciseListDb db = ExerciseListDb();

  ExerciseLogStreams exerciseLogStream = ExerciseLogStreams();
  ExerciseLogDatabase logDb = ExerciseLogDatabase();

  int exerciseIndex = 0;
  @override
  void initState() {
    exerciseIndex = widget.selectedIndex;
    super.initState();
  }

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
                    if (exerciseIndex > 0) {
                      setState(
                        () {
                          exerciseIndex--;
                        },
                      );
                    }
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
                    if (exerciseIndex < widget.selectedExercise.length - 1) {
                      setState(
                        () {
                          exerciseIndex++;

                          print(
                              "${widget.selectedExercise[exerciseIndex].lastWeight}");
                        },
                      );
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Icon(
                      Icons.keyboard_arrow_right,
                      color:
                          (exerciseIndex < widget.selectedExercise.length - 1)
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
                "${widget.selectedExercise[exerciseIndex].exerciseName}",
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
                StreamBuilder<List<ExerciseLogModel>>(
                  stream: exerciseLogStream.getLogToExercise(
                      widget.selectedExercise[exerciseIndex].exerciseName),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      Text("Wait");
                    }
                    return Expanded(
                      child: TabBarView(
                        physics: NeverScrollableScrollPhysics(),
                        children: <Widget>[
                          LogScreen(
                            selectedExercise:
                                widget.selectedExercise[exerciseIndex],
                            showPlanDetails: widget.showPlanDetails,
                            planDetails: (widget.showPlanDetails)
                                ? widget.planDetails[exerciseIndex]
                                : null,
                            selectedIndex: widget.selectedIndex,
                            repsValue: widget
                                .selectedExercise[widget.selectedIndex]
                                .lastReps,
                            rpeValue: widget
                                .selectedExercise[widget.selectedIndex].lastRPE,
                            weightValue: widget
                                .selectedExercise[widget.selectedIndex]
                                .lastWeight,
                          ),
                          ChangeNotifierProvider(
                            create: (context) => GraphDetailProvider(),
                            child: MyGraphWidget(
                              exerciseLog: snapshot.data,
                            ),
                          ),
                          HistoryView(
                            exerciseLog: snapshot.data,
                          ),
                          RepMaxView(
                            exerciseLog: snapshot.data,
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
