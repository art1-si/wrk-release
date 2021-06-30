import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workout_notes_app/data_models/exercise_log.dart';
import 'package:workout_notes_app/screens/new_entry_page/tabs/history_view.dart';

import 'package:workout_notes_app/screens/new_entry_page/tabs/log_screen.dart';
import 'package:workout_notes_app/screens/new_entry_page/services/add_exercise_log_page_view_model.dart';
import 'package:workout_notes_app/screens/new_entry_page/tabs/my_graph_widget.dart';
import 'package:workout_notes_app/screens/new_entry_page/tabs/rep_max_view.dart';
import 'package:workout_notes_app/services/providers.dart';
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
        child: Scaffold(
          backgroundColor: Theme.of(context).backgroundColor,
          appBar: AppBar(
            actions: [
              GestureDetector(
                onTap: () {
                  if (!exerciseProvider.indexIsOnZero) {
                    exerciseProvider.previousExercise();
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
                    exerciseProvider.nextExercise();
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
            backgroundColor: Theme.of(context).backgroundColor,
            elevation: 0,
            centerTitle: true,
            title: Text(
              exerciseProvider.selectedExercise.exerciseName,
              //style: Theme.of(context).textTheme.headline4,
            ),
            bottom: _bottom(),
          ),
          body: _exerciseLogStream.when(
            data: (exerciseLog) => _body(exerciseLog: exerciseLog),
            loading: () => CenterProgressIndicator(),
            error: (error, __) => Center(
              child: Text("Something went wrong\nerror"),
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
        labelStyle: TextStyle(fontSize: 13),
        labelColor: Colors.white,
        unselectedLabelStyle: TextStyle(fontSize: 12),
        tabs: <Widget>[
          Text("LOG"),
          Text("GRAPH"),
          Text("HISTORY"),
          Text("%RM"),
        ]);
  }

  Widget _body({
    required List<ExerciseLog> exerciseLog,
  }) {
    return Column(
      children: [
        Divider(
          thickness: 1,
        ),
        Expanded(
          child: TabBarView(
            physics: NeverScrollableScrollPhysics(),
            children: <Widget>[
              LogScreen(
                exerciseLog: exerciseLog,
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
