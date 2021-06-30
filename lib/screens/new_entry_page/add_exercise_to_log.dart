import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:workout_notes_app/screens/new_entry_page/tabs/log_screen.dart';
import 'package:workout_notes_app/screens/new_entry_page/services/add_exercise_log_page_view_model.dart';

class AddExerciseToLog extends ConsumerWidget {
  AddExerciseToLog({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    var exerciseProvider = watch(addExerciseLogProvider);
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
              exerciseProvider.seletedExercise.exerciseName,
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
              Expanded(
                child: TabBarView(
                  physics: NeverScrollableScrollPhysics(),
                  children: <Widget>[
                    LogScreen(),
                    Container(),
                    Container(),
                    Container(),
                    /* MyGraphWidget(
                          //exerciseLog: snapshot.data!,
                        ),
                        HistoryView(
                          //exerciseLog: snapshot.data!,
                        ),
                        RepMaxView(
                          //exerciseLog: snapshot.data!,
                        ), */
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
