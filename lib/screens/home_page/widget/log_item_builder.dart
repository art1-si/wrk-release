import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workout_notes_app/data_models/exercise_log.dart';
import 'package:workout_notes_app/data_models/group_by_model.dart';
import 'package:workout_notes_app/database/sqlite/sqlite_service.dart';
import 'package:workout_notes_app/provider/day_selector_provider.dart';
import 'package:workout_notes_app/screens/home_page/service/entries_view_model.dart';
import 'package:workout_notes_app/screens/home_page/widget/entries_table.dart';
import 'package:workout_notes_app/services/providers.dart';
import 'package:workout_notes_app/widgets/center_progress_indicator.dart';

final entriesTableModelStreamProvider =
    StreamProvider.autoDispose<List<GroupByModel<ExerciseLog>>>((ref) {
  final database = ref.watch(sqlDatabase);
  final date = ref.watch(selectedDateProvider);
  final vm = EntriesViewModel(database: database, toDate: date.daySelected);
  return vm.entriesTableModelStream;
});

class LogItemBuilder extends ConsumerWidget {
  const LogItemBuilder({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final tableEntries = watch(entriesTableModelStreamProvider);
    return tableEntries.when(
        data: (items) => EntriesTable(
              model: items,
            ),
        loading: () => CenterProgressIndicator(),
        error: (e, __) {
          print(e);
          return Text("Something went wrong");
        });
  }
}
