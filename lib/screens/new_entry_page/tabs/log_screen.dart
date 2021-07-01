import 'package:flutter/material.dart';
import 'package:workout_notes_app/data_models/exercise.dart';
import 'package:workout_notes_app/data_models/exercise_log.dart';
import 'package:workout_notes_app/provider/day_selector_provider.dart';
import 'package:workout_notes_app/screens/new_entry_page/widgets/text_field_number_picker.dart';
import 'package:workout_notes_app/services/database.dart';
import 'package:workout_notes_app/services/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LogScreen extends StatefulWidget {
  LogScreen({
    Key? key,
    required this.exerciseLog,
    required this.exercise,
  }) : super(key: key);
  final List<ExerciseLog> exerciseLog;
  final Exercise exercise;

  @override
  _LogScreenState createState() => _LogScreenState();
}

class _LogScreenState extends State<LogScreen> {
  double _weight = 0;
  int _reps = 0;
  ExerciseLog _serializeEntry({
    required String id,
    required String dateCreated,
  }) {
    return ExerciseLog(
      id: id,
      exerciseID: widget.exercise.id,
      exerciseName: widget.exercise.exerciseName,
      exerciseType: widget.exercise.exerciseType,
      weight: _weight,
      reps: _reps,
      setCount: 1, //TODO: Create set counter
      dateCreated: dateCreated,
      exerciseRPE: 10, //TODO: create rpe selector
    );
  }

  Future<void> _submitEntry(
      {required FirestoreDatabase database,
      required DaySelectorModel date}) async {
    final entry = _serializeEntry(
      id: documentIdFromCurrentDate(),
      dateCreated: date.daySelected.toIso8601String(),
    );
    await database.createExerciseLog(entry);
  }

  @override
  Widget build(BuildContext context) {
    final database = context.read(databaseProvider);
    final date = context.read(selectedDateProvider);
    return ListView(
      children: <Widget>[
        TextFieldNumerPicker(
          title: "WEIGHT",
          initValue: widget.exerciseLog.isNotEmpty
              ? widget.exerciseLog.last.weight
              : 0,
          onChange: (value) => _weight = value,
          changesByValue: 2.5,
        ),
        TextFieldNumerPicker(
          title: "Reps",
          initValue: widget.exerciseLog.isNotEmpty
              ? widget.exerciseLog.last.reps.toDouble()
              : 0, //TODO: make it to accept ints
          onChange: (value) => _reps = value.toInt(),
          changesByValue: 1,
        ),
        ElevatedButton(
          onPressed: () => _submitEntry(database: database, date: date),
          child: Text("Submit"),
        ),
      ],
    );
  }
}
