import 'package:flutter/material.dart';
import 'package:workout_notes_app/data_models/exercise.dart';
import 'package:workout_notes_app/data_models/exercise_log.dart';
import 'package:workout_notes_app/provider/day_selector_provider.dart';
import 'package:workout_notes_app/screens/home_page/service/entries_view_model.dart';
import 'package:workout_notes_app/screens/home_page/widget/buttons.dart';
import 'package:workout_notes_app/screens/new_entry_page/tabs/create_entry/create_new_entry.dart';
import 'package:workout_notes_app/screens/new_entry_page/tabs/create_entry/current_entries.dart';
import 'package:workout_notes_app/screens/new_entry_page/tabs/create_entry/widgets/bottom_buttons.dart';
import 'package:workout_notes_app/screens/new_entry_page/tabs/create_entry/widgets/decimal_text_field_number_picker.dart';
import 'package:workout_notes_app/screens/new_entry_page/tabs/create_entry/widgets/text_field_number_picker.dart';
import 'package:workout_notes_app/services/database.dart';
import 'package:workout_notes_app/services/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workout_notes_app/theme/app_theme.dart';

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
  final _formKey = GlobalKey<FormState>();

  double _weight = 0;
  int _reps = 0;
  ExerciseLog _serializeEntry({
    required String id,
    required String dateCreated,
    required int setCount,
  }) {
    return ExerciseLog(
      id: id,
      exerciseID: widget.exercise.id,
      exerciseName: widget.exercise.exerciseName,
      exerciseType: widget.exercise.exerciseType,
      weight: _weight,
      reps: _reps,
      setCount: setCount, //TODO: Create set counter
      dateCreated:
          context.read(selectedDateProvider).daySelected.toIso8601String(),
      exerciseRPE: 10, //TODO: create rpe selector
    );
  }

  int _setCounter(DateTime date) {
    int _set = 1;
    List<ExerciseLog> _exerciseLog = widget.exerciseLog
        .where((element) =>
            compareDatesToDay(DateTime.parse(element.dateCreated), date))
        .toList();
    if (_exerciseLog.isNotEmpty) {
      print(widget.exerciseLog.last.setCount!);
      print(widget.exerciseLog.last.dateCreated);
      print(_set);
      return _set + widget.exerciseLog.last.setCount!;
    }
    return _set;
  }

  Future<void> _submitEntry(
      {required FirestoreDatabase database,
      required DaySelectorModel date}) async {
    final entry = _serializeEntry(
      id: documentIdFromCurrentDate(),
      dateCreated: date.daySelected.toIso8601String(),
      setCount: _setCounter(date.daySelected),
    );
    await database.createExerciseLog(entry);
  }

  @override
  void initState() {
    if (widget.exerciseLog.isNotEmpty) {
      _weight = widget.exerciseLog.last.weight;
      _reps = widget.exerciseLog.last.reps;
    }
    super.initState();
  }

  void _handleEditMode(ExerciseLog log) {
    print("callback works, pressed log is $log");
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: ListView(
        children: <Widget>[
          CreateNewEntry(
            weightInitValue: widget.exerciseLog.isNotEmpty
                ? widget.exerciseLog.last.weight
                : 0,
            onRepsValueChanged: (int value) => _reps = value,
            onWeightValueChanged: (double value) => _weight = value,
            repsInitValue: widget.exerciseLog.isNotEmpty
                ? widget.exerciseLog.last.reps
                : 0,
            bottomButtons: RowWithBottomButtons(
              submitButtonPressed: () {
                if (_formKey.currentState!.validate()) {
                  final database = context.read(databaseProvider);
                  final date = context.read(selectedDateProvider);
                  _submitEntry(database: database, date: date);
                }
                print("empty");
              },
              resetOrDeleteButtonPressed: () {},
            ),
          ),
          Divider(
            color: AppTheme.of(context).divider,
            thickness: 0.5,
            height: 20,
          ),
          CurrentEntries(
            onLongPressed: (log) => _handleEditMode(log),
            currentEntries: widget.exerciseLog
                .where((element) => compareDatesToDay(
                      DateTime.tryParse(element.dateCreated)!,
                      context.read(selectedDateProvider).daySelected,
                    ))
                .toList(),
          ),
        ],
      ),
    );
  }
}
