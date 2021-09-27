import 'package:flutter/material.dart';
import 'package:workout_notes_app/data_models/exercise.dart';
import 'package:workout_notes_app/data_models/exercise_log.dart';
import 'package:workout_notes_app/provider/day_selector_provider.dart';
import 'package:workout_notes_app/screens/new_entry_page/tabs/create_entry/create_new_entry.dart';
import 'package:workout_notes_app/screens/new_entry_page/tabs/create_entry/current_entries.dart';
import 'package:workout_notes_app/screens/new_entry_page/tabs/create_entry/services/create_new_entry_provider.dart';
import 'package:workout_notes_app/screens/new_entry_page/tabs/create_entry/widgets/bottom_buttons.dart';
import 'package:workout_notes_app/services/logics.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workout_notes_app/theme/app_theme.dart';

class LogScreen extends StatelessWidget {
  LogScreen({
    Key? key,
    required this.exerciseLog,
    required this.exercise,
  }) : super(key: key);
  final List<ExerciseLog> exerciseLog;
  final Exercise exercise;

  @override
  Widget build(BuildContext context) {
    if (exerciseLog.isNotEmpty &&
        context.read(createNewEntryProvider).latestLogIsNull) {
      context.read(createNewEntryProvider).setLatestLog(exerciseLog.last);
    }
    return ListView(
      children: <Widget>[
        CreateNewEntry(
          bottomButtons: RowWithBottomButtons(),
        ),
        Divider(
          color: AppTheme.of(context).divider,
          thickness: 0.5,
          height: 20,
        ),
        CurrentEntries(
          onLongPressed: (log) =>
              context.read(createNewEntryProvider).handleEditMode(log),
          currentEntries: exerciseLog
              .where((element) => compareDatesToDay(
                    DateTime.tryParse(element.dateCreated)!,
                    context.read(selectedDateProvider).daySelected,
                  ))
              .toList(),
        ),
      ],
    );
  }
}
