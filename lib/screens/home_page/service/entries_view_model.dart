import 'package:collection/collection.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workout_notes_app/data_models/exercise_log.dart';
import 'package:workout_notes_app/data_models/group_by_model.dart';
import 'package:workout_notes_app/provider/day_selector_provider.dart';
import 'package:workout_notes_app/screens/new_entry_page/services/add_exercise_log_page_view_model.dart';
import 'package:workout_notes_app/screens/new_entry_page/tabs/graph_page.dart/services/graph_model_provider.dart';
import 'package:workout_notes_app/services/database.dart';
import 'package:workout_notes_app/services/providers.dart';

final exerciseLogStream = StreamProvider.autoDispose<List<ExerciseLog>>((ref) {
  /* final database = ref.watch(databaseProvider);
  final date = ref.watch(selectedDateProvider).daySelected;
  final seletedExercise = ref.watch(addExerciseLogProvider).selectedExercise.id;
  final vm = EntriesViewModel(
    database: database,
    toDate: date,
    byExerciseID: seletedExercise,
  );
  return vm.getEntriesByExercise; */
  return ref.watch(entriesViewModel).getEntriesByExercise;
});
final entriesViewModel = Provider.autoDispose<EntriesViewModel>((ref) {
  final database = ref.watch(databaseProvider);
  final date = ref.watch(selectedDateProvider).daySelected;
  final seletedExercise = ref.watch(addExerciseLogProvider).selectedExercise.id;
  final vm = EntriesViewModel(
    database: database,
    toDate: date,
    byExerciseID: seletedExercise,
  );
  return vm;
});

final graphEntriesStream = StreamProvider.autoDispose<List<GraphModel>>((ref) {
  /* final database = ref.watch(databaseProvider);
  final date = ref.watch(selectedDateProvider).daySelected;
  final seletedExercise = ref.watch(addExerciseLogProvider).selectedExercise.id;
  final vm = EntriesViewModel(
    database: database,
    toDate: date,
    byExerciseID: seletedExercise,
  );
  return vm.graphEntries; */
  return ref.watch(entriesViewModel).graphEntries;
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

  double _minValue = double.infinity;
  double _maxValue = 0;

  double get maxValue => _maxValue;
  double get minValue => _minValue;

  void setMinAndMaxValue(List<ExerciseLog> exerciseLog) {
    if (exerciseLog.length > 1) {
      exerciseLog.forEach((element) {
        if (element.weight > _maxValue) {
          _maxValue = element.weight;
        }
        if (element.weight < _minValue) {
          _minValue = element.weight;
        }
      });
    } else if (exerciseLog.isNotEmpty) {
      _maxValue = exerciseLog.first.weight * 2;

      _minValue = 0;
    }
  }

  double getRelativeYposition({
    required double value,
  }) {
    double height = 1.0;

    double weightGraphValue = value;
    double relativeYposition =
        (weightGraphValue - minValue) / (maxValue - minValue);
    double yOffset = height - relativeYposition * height;

    return yOffset;
  }

  List<GraphModel> findOffsets({required List<ExerciseLog> exerciseLog}) {
    var _results = <GraphModel>[];
    double width = 1.0;
    bool isLast = false;
    var distance = 0.07; //!may couse bugs in graph layout part 1
    var nextDistance = (width - 0.1) / (exerciseLog.length - 1);
    int nextValueIndex = 1;
    exerciseLog.forEach((log) {
      double nextValue = exerciseLog.length > nextValueIndex
          ? exerciseLog[nextValueIndex].weight
          : log.weight;
      var _yPosition = getRelativeYposition(value: log.weight);
      var _nextYPosition = getRelativeYposition(value: nextValue);
      _results.add(
        GraphModel(
          x: distance,
          nextX: isLast ? distance : distance + nextDistance,
          y: _yPosition,
          nextY: _nextYPosition,
          corespondingLog: log,
        ),
      );

      nextValueIndex++;
      isLast = exerciseLog.length == nextValueIndex;
      distance = distance + nextDistance;
    });
    return _results;
  }

  Stream<List<GraphModel>> get graphEntries =>
      getEntriesByExercise.map((exerciseLog) {
        setMinAndMaxValue(exerciseLog);
        final _graphEntries = findOffsets(exerciseLog: exerciseLog);
        return _graphEntries;
      });

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
      titleBuilder: (log) => log.exerciseName,
      dataID: (log) => log.exerciseID,
    );
  }
}
