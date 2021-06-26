import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:workout_notes_app/data_models/exercise.dart';
import 'package:workout_notes_app/data_models/exercise_log.dart';

import 'package:workout_notes_app/screens/home_page/widget/log_table.dart';

import 'package:workout_notes_app/screens/new_entry_page/add_exercise_to_log.dart.copy';

class LogListWidget extends StatelessWidget {
  final List<ExerciseLog> snapshotData;

  LogListWidget({Key? key, required this.snapshotData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Exercise>>(
      stream: null, //TODO: add stream exercise
      builder: (context, AsyncSnapshot<List<Exercise>> exerciseSnapshot) {
        if (!exerciseSnapshot.hasData) {
          return Container();
        }
        final List snapshotKeys = [];
        final List<Exercise> selectedExerciseFromHomePage = <Exercise>[];
        var groupedSnapshot =
            groupBy(snapshotData, (ExerciseLog obj) => obj.exerciseID);
        for (var element in groupedSnapshot.keys) {
          snapshotKeys.add(element);
        }
        for (var snapshotKey in snapshotKeys) {
          int i = 0;

          var exercise = exerciseSnapshot.data!
              .where((element) => element.exerciseName == snapshotKey);

          selectedExerciseFromHomePage.insertAll(i, exercise);
          i++;
        }

        return ListView(
          addAutomaticKeepAlives: true,
          addRepaintBoundaries: false,
          padding: EdgeInsets.all(0.0),
          shrinkWrap: true,
          physics: AlwaysScrollableScrollPhysics(),
          children: <Widget>[
            for (var i = 0; i < snapshotKeys.length; i++)
              _LogItem(
                index: i,
                title: "${snapshotKeys[i]}",
                itemCount: groupedSnapshot[snapshotKeys[i]]!.length,
                data: groupedSnapshot[snapshotKeys[i]]!,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddExerciseToLog(
                        showPlanDetails: false,
                        selectedIndex: i,
                        selectedExercise:
                            selectedExerciseFromHomePage.reversed.toList(),
                      ),
                    ),
                  );
                },
              ),
          ],
        );
        /*return ListView.builder(
          padding: EdgeInsets.all(0.0),
          shrinkWrap: true,
          physics: ScrollPhysics(),
          itemCount: snapshotKeys.length,
          itemBuilder: (BuildContext context, int index) {
            return 
          },
        );*/
      },
    );
  }
}

class _LogItem extends StatelessWidget {
  final String title;
  final int itemCount;
  final List<ExerciseLog> data;
  final int index;
  final GestureTapCallback onTap;

  const _LogItem({
    Key? key,
    required this.title,
    required this.itemCount,
    required this.data,
    required this.index,
    required this.onTap,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4, top: 4),
      child: Column(
        children: [
          Divider(
            indent: 120,
            endIndent: 120,
            height: 0,
          ),
          GestureDetector(
            onTap: onTap,
            child: LogTable(
              title: title,
              itemCount: itemCount,
              fieldData: data,
            ),
          ),
        ],
      ),
    );
  }
}
