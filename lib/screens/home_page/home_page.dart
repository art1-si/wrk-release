import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:workout_notes_app/componets/day_selector.dart';
import 'package:workout_notes_app/data_models/exercise.dart';
import 'package:workout_notes_app/data_models/exercise_log.dart';

import 'package:workout_notes_app/provider/day_selector_provider.dart';

import 'package:workout_notes_app/screens/home_page/exercise-button.dart';

import 'package:workout_notes_app/screens/home_page/widget/new_log_list_widget.dart';
import 'package:workout_notes_app/services/database.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    print("MyHomePage build");
    //var showButton = Provider.of<ProviderOfQuickAddButton>(context);
    //exerciseLogStream.addExercieLogToStream();
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            title: Text(
              "Workout Notes",
              style: Theme.of(context).textTheme.headline1,
            ),
            elevation: 0,
            expandedHeight: 0,
            backgroundColor: Theme.of(context).backgroundColor,
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              <Widget>[
                const Divider(
                  height: 20,
                  color: Colors.transparent,
                ),
                const ExerciseButton(),
                const Divider(
                  height: 40,
                  color: Colors.transparent,
                ),
                WeekdaysSelector(),
                const Divider(
                  height: 12,
                ),
                StreamBuilder<List<Exercise>>(
                    stream: null, //TODO
                    builder: (context,
                        AsyncSnapshot<List<Exercise>> exerciseSnapshot) {
                      if (!exerciseSnapshot.hasData) {
                        return Container();
                      }
                      return Consumer<DaySelectorModel>(
                        builder: (context, dateSe, child) {
                          return StreamBuilder<List<ExerciseLog>>(
                              stream: null,
                              builder: (context,
                                  AsyncSnapshot<List<ExerciseLog>> snapshot) {
                                if (!snapshot.hasData ||
                                    snapshot.data!.isEmpty ||
                                    snapshot.data!.first.dateCreated !=
                                        "${dateSe.daySelected.year}-${DateFormat('MM').format(dateSe.daySelected)}-${DateFormat('dd').format(dateSe.daySelected)}") {
                                  print("Exercise log is empty");
                                  return Container();
                                }
                                print(
                                    "its working but ${dateSe.daySelected.year}-${DateFormat('MM').format(dateSe.daySelected)}-${DateFormat('dd').format(dateSe.daySelected)}");

                                print(
                                    " new log list is working  ${dateSe.daySelected.year}-${DateFormat('MM').format(dateSe.daySelected)}-${DateFormat('dd').format(dateSe.daySelected)}");
                                return NewLogListWidget(
                                  exerciseStreamSnasphot:
                                      exerciseSnapshot.data!,
                                  snapshotData: snapshot.data!,
                                );
                              });
                        },
                      );
                    }),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
