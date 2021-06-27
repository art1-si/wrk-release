import 'dart:html';

import 'package:collection/collection.dart';
import 'package:workout_notes_app/data_models/exercise_log.dart';
import 'package:workout_notes_app/screens/home_page/widget/entries_table.dart';
import 'package:workout_notes_app/services/database.dart';

bool compairDatesToDay(DateTime date1, DateTime date2) {
  return date1.year == date2.year &&
      date1.month == date2.month &&
      date1.day == date2.day;
}

class EntriesViewModel {
  EntriesViewModel({required this.database, required this.toDate});

  final FirestoreDatabase database;
  final DateTime toDate;

  Stream<List<ExerciseLog>> get _allEntriesStreamToDate => database
      .exerciseLogStream()
      .map(
        (entries) => entries
            .where(
              (entry) =>
                  compairDatesToDay(DateTime.parse(entry.dateCreated), toDate),
            )
            .toList(),
      );

  Stream<List<EntriesTableModel>> get entriesTableModelStream {
    return _allEntriesStreamToDate.map(
      (entries) {
        var entriesToTableModel = <EntriesTableModel>[];
        var groupEntry =
            groupBy(entries, (ExerciseLog entry) => entry.exerciseID);
        for (var key in groupEntry.keys) {
          entriesToTableModel.add(
            EntriesTableModel(title: key, data: groupEntry[key]!),
          );
        }
        return entriesToTableModel;
      },
    );
  }
}
