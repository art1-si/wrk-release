import 'package:collection/collection.dart';
import 'package:workout_notes_app/data_models/exercise_log.dart';
import 'package:workout_notes_app/data_models/group_by_model.dart';
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

  Stream<List<GroupByModel<ExerciseLog>>> get entriesTableModelStream {
    print("entriesTableModelStream");
    return database.groupByValue(
        data: _allEntriesStreamToDate,
        groupByValue: (log) => log.exerciseID,
        titleBuilder: (log) => log.exerciseName);
  }
}
