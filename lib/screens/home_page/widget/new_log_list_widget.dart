import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:workout_notes_app/models/exercise_log_model.dart';
import 'package:workout_notes_app/models/exercise_model.dart';

import 'package:workout_notes_app/screens/home_page/widget/log_table.dart';
import 'package:workout_notes_app/screens/new_entry_page/add_exercise_to_log.dart';

class NewLogListWidget extends StatefulWidget {
  final List<ExerciseLogModel> snapshotData;
  final List<ExerciseModel> exerciseStreamSnasphot;
  NewLogListWidget({Key key, this.snapshotData, this.exerciseStreamSnasphot})
      : super(key: key);

  @override
  _NewLogListWidgetState createState() => _NewLogListWidgetState();
}

class _NewLogListWidgetState extends State<NewLogListWidget> {
  //final ExerciseStreams exerciseStreams = ExerciseStreams();
  List snapshotKeys = [];
  List<ExerciseModel> selectedExerciseFromHomePage = <ExerciseModel>[];
  var groupedSnapshot;
  @override
  void initState() {
    super.initState();
    groupedSnapshot = groupBy(widget.snapshotData, (obj) => obj.exerciseName);

    for (var element in groupedSnapshot.keys) {
      snapshotKeys.add(element);
    }
    for (var snapshotKey in snapshotKeys) {
      int i = 0;

      var exercise = widget.exerciseStreamSnasphot
          .where((element) => element.exerciseName == snapshotKey);

      selectedExerciseFromHomePage.insertAll(i, exercise);
      i++;
    }
  }

  @override
  Widget build(BuildContext context) {
    print("new log list widget is rebuiling");
    return ListView(
      addAutomaticKeepAlives: true,
      addRepaintBoundaries: false,
      padding: EdgeInsets.all(0.0),
      shrinkWrap: true,
      physics: ScrollPhysics(), //AlwaysScrollableScrollPhysics(),
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
                          selectedExercise:
                              selectedExerciseFromHomePage.reversed.toList())));
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
