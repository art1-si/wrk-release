import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:intl/intl.dart';
import 'package:workout_notes_app/models/exercise_log_model.dart';
import 'package:workout_notes_app/provider/exercise_log_stream.dart';

class HistoryView extends StatelessWidget {
  final List<ExerciseLogModel> exerciseLog;

  final ExerciseLogStreams exerciseLogStream = ExerciseLogStreams();

  HistoryView({Key key, this.exerciseLog}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("history page build ");
    if (exerciseLog.isEmpty) {
      return Center(
        child: Text(
          "EMPTY LOG",
          style: Theme.of(context).textTheme.headline2,
        ),
      );
    }

    return GroupedListView<ExerciseLogModel, String>(
      groupBy: (element) => element.dateCreated,
      elements: exerciseLog,
      order: GroupedListOrder.DESC,
      groupSeparatorBuilder: (value) {
        var dateGroupBy = DateTime.parse(value);
        return _DateTitle(
          date: DateFormat("yMMMMEEEEd").format(dateGroupBy).toString(),
        );
      },
      indexedItemBuilder: (context, exerciseLogModel, index) {
        return _Table(
          weightField: exerciseLogModel.weight.toString(),
          repsField: exerciseLogModel.reps.toString(),
          rpe: exerciseLogModel.exerciseRPE.toString(),
        );
      },
    );
  }
}

class _DateTitle extends StatelessWidget {
  final String date;

  const _DateTitle({Key key, this.date}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 30,
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.circular(2),
        ),
        child: Align(
          alignment: Alignment.centerRight,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Text(
              date,
              style: Theme.of(context).textTheme.bodyText2,
            ),
          ),
        ),
      ),
    );
  }
}

class _Table extends StatelessWidget {
  final String weightField;
  final String repsField;
  final String rpe;

  const _Table({Key key, this.weightField, this.repsField, this.rpe})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Text(
          "WEIGHT: $weightField",
          style: Theme.of(context).textTheme.caption,
        ),
        Text(
          "REPS: $repsField",
          style: Theme.of(context).textTheme.caption,
        ),
        Text(
          "RPE: $rpe",
          style: Theme.of(context).textTheme.caption,
        ),
      ],
    );
  }
}
