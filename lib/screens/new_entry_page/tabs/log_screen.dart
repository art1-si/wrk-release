import 'package:flutter/material.dart';
import 'package:workout_notes_app/data_models/exercise_log.dart';
import 'package:workout_notes_app/screens/new_entry_page/widgets/text_field_number_picker.dart';

class LogScreen extends StatelessWidget {
  final List<ExerciseLog> exerciseLog;
  LogScreen({
    Key? key,
    required this.exerciseLog,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[],
    );
  }
}
