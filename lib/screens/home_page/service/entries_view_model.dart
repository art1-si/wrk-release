import 'package:collection/collection.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workout_notes_app/data_models/exercise_log.dart';
import 'package:workout_notes_app/data_models/group_by_model.dart';
import 'package:workout_notes_app/provider/day_selector_provider.dart';
import 'package:workout_notes_app/screens/new_entry_page/services/add_exercise_log_page_view_model.dart';
import 'package:workout_notes_app/services/database.dart';
import 'package:workout_notes_app/services/providers.dart';

final exerciseLogStream = StreamProvider.autoDispose<List<ExerciseLog>>((ref) {
  final database = ref.watch(databaseProvider);
  final date = ref.watch(selectedDateProvider).daySelected;
  final seletedExercise = ref.watch(addExerciseLogProvider).selectedExercise.id;
  final vm = EntriesViewModel(
    database: database,
    toDate: date,
    byExerciseID: seletedExercise,
  );
  return vm.getEntriesByExercise;
});

bool compairDatesToDay(DateTime date1, DateTime date2) {
  return date1.year == date2.year &&
      date1.month == date2.month &&
      date1.day == date2.day;
}

class EntriesViewModel {
  EntriesViewModel(
      {this.byExerciseID, required this.database, required this.toDate});

  final FirestoreDatabase database;
  final DateTime toDate;
  final String? byExerciseID;

  Stream<List<ExerciseLog>> get allEntriesStreamToDate => database
      .exerciseLogStream()
      .map(
        (entries) => entries.where((entry) {
          if (byExerciseID == null) {
            return compairDatesToDay(DateTime.parse(entry.dateCreated), toDate);
          } else {
            return compairDatesToDay(
                    DateTime.parse(entry.dateCreated), toDate) &&
                entry.exerciseID == byExerciseID;
          }
        }).toList(),
      );
  Stream<List<ExerciseLog>> get getEntriesByExercise =>
      database.exerciseLogStream().map(
            (entries) => entries.where(
              (entry) {
                if (byExerciseID == null) {
                  throw UnimplementedError();
                } else {
                  return entry.exerciseID == byExerciseID;
                }
              },
            ).sortedBy((element) => element.id),
          );

  Stream<List<GroupByModel<ExerciseLog>>> get entriesTableModelStream {
    print("entriesTableModelStream");
    return database.groupByValue(
        data: allEntriesStreamToDate,
        groupByValue: (log) => log.exerciseID,
        titleBuilder: (log) => log.exerciseName);
  }
}
