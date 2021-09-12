import 'package:collection/collection.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workout_notes_app/data_models/exercise_log.dart';
import 'package:workout_notes_app/data_models/group_by_model.dart';
import 'package:workout_notes_app/provider/day_selector_provider.dart';
import 'package:workout_notes_app/screens/new_entry_page/services/add_exercise_log_page_view_model.dart';
import 'package:workout_notes_app/screens/new_entry_page/tabs/graph_page.dart/services/graph_model_provider.dart';
import 'package:workout_notes_app/services/1rm_formula.dart';
import 'package:workout_notes_app/services/database.dart';
import 'package:workout_notes_app/services/providers.dart';

enum GraphProperties { perWeight, oneRepMax, simpleVolumePerSet }

//?Main EntriesViewProvider
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

//*Return Exercise Log by specific exercise
final exerciseLogStream = StreamProvider.autoDispose<List<ExerciseLog>>((ref) {
  return ref.watch(entriesViewModel).getEntriesByExercise;
});

//*Returns parameters for graph widget
final graphEntriesStream = StreamProvider.autoDispose<List<GraphModel>>((ref) {
  final log = ref.watch(entriesViewModel).getEntriesByExercise;
  log.last;
  final graphProvider = ref.watch(entriesViewModel).graphEntries;
  return graphProvider;
});

//!Shoud not be here
bool compareDatesToDay(DateTime date1, DateTime date2) {
  return date1.year == date2.year &&
      date1.month == date2.month &&
      date1.day == date2.day;
} //TODO: get this to new file

class EntriesViewModel {
  EntriesViewModel(
      {this.byExerciseID, required this.database, required this.toDate});

  final FirestoreDatabase database;
  final DateTime toDate;
  final String? byExerciseID;

  double _minValue = double.infinity;
  double _maxValue = 0;
  GraphProperties _properties = GraphProperties.simpleVolumePerSet;

  double get maxValue => _maxValue;
  double get minValue => _minValue;
  GraphProperties get graphProperties => _properties;

  setGraphProperties(GraphProperties newValue) {
    return _properties = newValue;
  }

  double _getGraphValueToPropertie(ExerciseLog log) {
    late final _element;
    switch (_properties) {
      case GraphProperties.perWeight:
        _element = log.weight;
        break;
      case GraphProperties.oneRepMax:
        _element = epleyCalOneRepMax(log.weight, log.reps);
        break;
      case GraphProperties.simpleVolumePerSet:
        _element = log.weight * log.reps;
        break;
    }
    return _element;
  }

  void setMinAndMaxValue(List<ExerciseLog> exerciseLog) {
    if (exerciseLog.length > 1) {
      exerciseLog.forEach((element) {
        final _value = _getGraphValueToPropertie(element);
        if (_value > _maxValue) {
          _maxValue = _value;
        }
        if (_value < _minValue) {
          _minValue = _value;
        }
      });
    } else if (exerciseLog.isNotEmpty && exerciseLog.length < 2) {
      _maxValue = exerciseLog.first.weight * 2;

      _minValue = 0;
    }
  }

  double getRelativeYposition({
    required double value,
  }) {
    double height = 1.0;

    double relativeYposition = (value - minValue) / (maxValue - minValue);
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
      final _valueToProperty = _getGraphValueToPropertie(log);
      double nextValue = exerciseLog.length > nextValueIndex
          ? _getGraphValueToPropertie(exerciseLog[nextValueIndex])
          : _valueToProperty;

      var _yPosition = getRelativeYposition(value: _valueToProperty);
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
            return compareDatesToDay(DateTime.parse(entry.dateCreated), toDate);
          } else {
            return compareDatesToDay(
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
