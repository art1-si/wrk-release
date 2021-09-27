import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workout_notes_app/data_models/exercise.dart';
import 'package:workout_notes_app/data_models/exercise_log.dart';
import 'package:workout_notes_app/screens/home_page/service/entries_view_model.dart';
import 'package:workout_notes_app/screens/new_entry_page/tabs/history_page/history_view.dart';
import 'package:workout_notes_app/screens/new_entry_page/tabs/create_entry/log_screen.dart';
import 'package:workout_notes_app/screens/new_entry_page/services/add_exercise_log_page_view_model.dart';
import 'package:workout_notes_app/screens/new_entry_page/tabs/graph_page.dart/my_graph_widget.dart';
import 'package:workout_notes_app/screens/new_entry_page/tabs/rep_max_view.dart';
import 'package:workout_notes_app/theme/app_theme.dart';
import 'package:workout_notes_app/widgets/center_progress_indicator.dart';

class AddExerciseToLog extends ConsumerWidget {
  AddExerciseToLog({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final exerciseProvider = watch(addExerciseLogProvider);
    final _exerciseLogStream = watch(exerciseLogStream);

    return DefaultTabController(
      length: 4,
      child: GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);

          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
        },
        child: Container(
          color: AppTheme.of(context).primary,
          child: SafeArea(
            child: Scaffold(
              backgroundColor: AppTheme.of(context).background,
              appBar: AppBar(
                actions: [
                  GestureDetector(
                    onTap: () {
                      if (!exerciseProvider.indexIsOnZero) {
                        context.read(addExerciseLogProvider).previousExercise();
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Icon(
                        Icons.keyboard_arrow_left,
                        color: (exerciseProvider.indexIsOnZero)
                            ? Colors.white30
                            : Colors.white,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      if (!exerciseProvider.indexReachedEnd) {
                        context.read(addExerciseLogProvider).nextExercise();
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Icon(
                        Icons.keyboard_arrow_right,
                        color: (exerciseProvider.indexReachedEnd)
                            ? Colors.white30
                            : Colors.white,
                      ),
                    ),
                  ),
                ],
                backgroundColor: AppTheme.of(context).background,
                elevation: 0,
                centerTitle: true,
                title: Text(
                  exerciseProvider.selectedExercise.exerciseName,
                  //style: Theme.of(context).textTheme.headline4,
                ),
                bottom: _bottom(),
              ),
              body: _exerciseLogStream.when(
                data: (exerciseLog) {
                  return _body(
                    context: context,
                    exerciseLog: exerciseLog,
                    exercise: exerciseProvider.selectedExercise,
                  );
                },
                loading: () => CenterProgressIndicator(),
                error: (error, __) => Center(
                  child: Text("Something went wrong\nerror"),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  _bottom() {
    return TabBar(
        indicatorWeight: 0.1,
        indicatorColor: Colors.transparent,
        labelStyle: TextStyle(fontSize: 16),
        labelColor: Colors.white,
        unselectedLabelStyle: TextStyle(fontSize: 14),
        tabs: <Widget>[
          SizedBox(
            height: 40,
            child: Center(child: Text("LOG")),
          ),
          SizedBox(
            height: 40,
            child: Center(child: Text("GRAPH")),
          ),
          SizedBox(
            height: 40,
            child: Center(child: Text("HISTORY")),
          ),
          SizedBox(
            height: 40,
            child: Center(child: Text("%RM")),
          ),
        ]);
  }

  Widget _body({
    required List<ExerciseLog> exerciseLog,
    required Exercise exercise,
    required BuildContext context,
  }) {
    return Column(
      children: [
        Divider(
          height: 20,
          thickness: 1,
          color: AppTheme.of(context).divider,
        ),
        Expanded(
          child: TabBarView(
            physics: NeverScrollableScrollPhysics(),
            children: <Widget>[
              LogScreen(
                exerciseLog: exerciseLog,
                exercise: exercise,
              ),
              MyGraphWidget(
                exerciseLog: exerciseLog,
              ),
              HistoryView(
                exerciseLog: exerciseLog,
              ),
              RepMaxView(
                exerciseLog: exerciseLog,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
