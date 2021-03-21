import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:workout_notes_app/models/exercise_log_model.dart';
import 'package:workout_notes_app/models/exercise_model.dart';
import 'package:workout_notes_app/provider/exercise_streams.dart';
import 'package:workout_notes_app/screens/add_exercise_to_log.dart';
import 'package:workout_notes_app/widgets/log_table.dart';

class LogListWidget extends StatelessWidget {
  final List<ExerciseLogModel> snapshotData;

  LogListWidget({Key key, this.snapshotData}) : super(key: key);
  final ExerciseStreams exerciseStreams = ExerciseStreams();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<ExerciseModel>>(
      stream: exerciseStreams.exerciseStream,
      builder: (context, AsyncSnapshot<List<ExerciseModel>> exerciseSnapshot) {
        if (!exerciseSnapshot.hasData) {
          return Container();
        }
        final List snapshotKeys = [];
        final List<ExerciseModel> selectedExerciseFromHomePage =
            <ExerciseModel>[];
        var groupedSnapshot = groupBy(snapshotData, (obj) => obj.exerciseName);
        for (var element in groupedSnapshot.keys) {
          snapshotKeys.add(element);
        }
        for (var snapshotKey in snapshotKeys) {
          int i = 0;

          var exercise = exerciseSnapshot.data
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
                title: "${snapshotKeys[i]}",
                itemCount: groupedSnapshot[snapshotKeys[i]].length,
                data: groupedSnapshot[snapshotKeys[i]],
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AddExerciseToLog(
                              showPlanDetails: false,
                              selectedIndex: i,
                              selectedExercise: selectedExerciseFromHomePage
                                  .reversed
                                  .toList())));
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
  final List<ExerciseLogModel> data;
  final int index;
  final GestureTapCallback onTap;

  const _LogItem(
      {Key key, this.title, this.itemCount, this.data, this.index, this.onTap})
      : super(key: key);
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
