import 'package:flutter/material.dart';
import 'package:workout_notes_app/data_models/exercise.dart';
import 'package:workout_notes_app/data_models/exercise_log.dart';
import 'package:workout_notes_app/provider/day_selector_provider.dart';
import 'package:workout_notes_app/screens/home_page/service/entries_view_model.dart';
import 'package:workout_notes_app/screens/new_entry_page/tabs/create_entry/create_new_entry.dart';
import 'package:workout_notes_app/screens/new_entry_page/tabs/create_entry/current_entries.dart';
import 'package:workout_notes_app/screens/new_entry_page/tabs/create_entry/services/create_new_entry_provider.dart';
import 'package:workout_notes_app/screens/new_entry_page/tabs/create_entry/widgets/bottom_buttons.dart';
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

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Consumer(builder: (context, watch, child) {
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
              currentEntries: widget.exerciseLog
                  .where((element) => compareDatesToDay(
                        DateTime.tryParse(element.dateCreated)!,
                        context.read(selectedDateProvider).daySelected,
                      ))
                  .toList(),
            ),
          ],
        );
      }),
    );
  }
}
