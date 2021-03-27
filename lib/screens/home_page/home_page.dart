import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:workout_notes_app/componets/day_selector.dart';
import 'package:workout_notes_app/models/exercise_log_model.dart';
import 'package:workout_notes_app/models/exercise_model.dart';
import 'package:workout_notes_app/provider/day_selector_provider.dart';
import 'package:workout_notes_app/provider/exercise_log_stream.dart';
import 'package:workout_notes_app/provider/exercise_streams.dart';
import 'package:workout_notes_app/screens/home_page/exercise-button.dart';

import 'package:workout_notes_app/screens/home_page/widget/new_log_list_widget.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  ExerciseLogStreams exerciseLogStream = ExerciseLogStreams();
  final ExerciseStreams exerciseStreams = ExerciseStreams();
  @override
  void dispose() {
    exerciseLogStream.dispose();
    exerciseStreams.dispose();
    super.dispose();
  }

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
                StreamBuilder<List<ExerciseModel>>(
                    stream: exerciseStreams.exerciseStream,
                    builder: (context,
                        AsyncSnapshot<List<ExerciseModel>> exerciseSnapshot) {
                      if (!exerciseSnapshot.hasData) {
                        return Container();
                      }
                      return Consumer<DaySelectorModel>(
                        builder: (context, dateSe, child) {
                          exerciseLogStream.getLogToDate(
                              "${dateSe.daySelected.year}-${DateFormat('MM').format(dateSe.daySelected)}-${DateFormat('dd').format(dateSe.daySelected)}");
                          print("consumer is rebuilding");
                          return StreamBuilder<List<ExerciseLogModel>>(
                              stream: exerciseLogStream.getLogToDate(
                                  "${dateSe.daySelected.year}-${DateFormat('MM').format(dateSe.daySelected)}-${DateFormat('dd').format(dateSe.daySelected)}"),
                              builder: (context,
                                  AsyncSnapshot<List<ExerciseLogModel>>
                                      snapshot) {
                                if (!snapshot.hasData ||
                                    snapshot.data.isEmpty ||
                                    snapshot.data.first.dateCreated !=
                                        "${dateSe.daySelected.year}-${DateFormat('MM').format(dateSe.daySelected)}-${DateFormat('dd').format(dateSe.daySelected)}") {
                                  print("Exercise log is empty");
                                  return Container();
                                }
                                print(
                                    "its working but ${dateSe.daySelected.year}-${DateFormat('MM').format(dateSe.daySelected)}-${DateFormat('dd').format(dateSe.daySelected)}");

                                print(
                                    " new log list is working  ${dateSe.daySelected.year}-${DateFormat('MM').format(dateSe.daySelected)}-${DateFormat('dd').format(dateSe.daySelected)}");
                                return NewLogListWidget(
                                  exerciseStreamSnasphot: exerciseSnapshot.data,
                                  snapshotData: snapshot.data,
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
