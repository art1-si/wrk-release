import 'package:flutter/material.dart';
import 'package:workout_notes_app/data_models/exercise.dart';
import 'package:workout_notes_app/data_models/exercise_log.dart';
import 'package:workout_notes_app/provider/day_selector_provider.dart';
import 'package:workout_notes_app/screens/home_page/service/entries_view_model.dart';
import 'package:workout_notes_app/screens/home_page/widget/buttons.dart';
import 'package:workout_notes_app/screens/new_entry_page/widgets/decimal_text_field_number_picker.dart';
import 'package:workout_notes_app/screens/new_entry_page/widgets/text_field_number_picker.dart';
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

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        DecimalTextFieldNumPicker(
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
              ? widget.exerciseLog.last.reps
              : 0, //TODO: make it to accept ints
          onChange: (value) => _reps = value.toInt(),
          changesByValue: 1,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedHomePageButton(
                onPress: () {
                  final database = context.read(databaseProvider);
                  final date = context.read(selectedDateProvider);
                  _submitEntry(database: database, date: date);
                },
                title: "Submit",
                backgroundColor:
                    AppTheme.of(context).accentPrimary.withOpacity(0.05),
                titleColor: AppTheme.of(context).accentPrimary,
              ),
              ElevatedHomePageButton(
                onPress: () {},
                title: "Reset",
                backgroundColor:
                    AppTheme.of(context).accentPositive.withOpacity(0.05),
                titleColor:
                    AppTheme.of(context).accentPositive.withOpacity(0.7),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
