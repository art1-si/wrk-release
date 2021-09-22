import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workout_notes_app/data_models/exercise.dart';
import 'package:workout_notes_app/data_models/exercise_log.dart';
import 'package:workout_notes_app/provider/day_selector_provider.dart';
import 'package:workout_notes_app/screens/new_entry_page/services/add_exercise_log_page_view_model.dart';
import 'package:workout_notes_app/services/database.dart';
import 'package:workout_notes_app/services/providers.dart';

final createNewEntryProvider =
    ChangeNotifierProvider.autoDispose<CreateNewEntryProvider>((ref) {
  final _dayDifferenceBetweenNowAndDateSelected =
      ref.watch(selectedDateProvider).n;
  final database = ref.watch(databaseProvider);
  final _selectedExercise = ref.watch(addExerciseLogProvider).selectedExercise;
  return CreateNewEntryProvider(
      selectedExercise: _selectedExercise,
      dayDifferenceBetweenNowAndDateSelected:
          _dayDifferenceBetweenNowAndDateSelected,
      database: database);
});

class CreateNewEntryProvider with ChangeNotifier {
  CreateNewEntryProvider({
    required this.selectedExercise,
    required this.dayDifferenceBetweenNowAndDateSelected,
    required this.database,
  });

  final Exercise selectedExercise;
  final int dayDifferenceBetweenNowAndDateSelected;
  final FirestoreDatabase database;

  bool _editModeActive = false;
  double _weight = 40.0;
  int _reps = 12;
  int _rpe = 10;
  ExerciseLog? _selectedLog;
  ExerciseLog? _latestLog;

  bool get editModeActive => _editModeActive;
  double get weight => _weight;
  int get reps => _reps;
  int get rpe => _rpe;

  void setWeightWithNewValue(double value) {
    _weight = value;
    notifyListeners();
  }

  void setRepsWithNewValue(int value) {
    _reps = value;
    notifyListeners();
  }

  void weightSetter(double value) {
    _weight = value;
  }

  void repsSetter(int value) {
    _reps = value;
  }

  void setLatestLog(ExerciseLog? log) {
    _weight = log?.weight ?? 40;
    _reps = log?.reps ?? 12;
    _latestLog = log;
  }

  void handleOnTapSubmitEditButton() {
    // if (_formKey.currentState!.validate()) {
    if (_editModeActive) {
      _upadateEntry();
      handleEditMode(null);
    } else {
      _submitEntry();
    }
    // }
    print("empty");
  }

  void handleOnTapDeleteOrReset() {
    if (_editModeActive) {
      database.deleteExerciseLog(_selectedLog!);
      handleEditMode(null);
    } else {
      _resetValues();
    }
  }

  Future<void> _upadateEntry() async {
    final entry = _selectedLog!.copyWith(
      weight: _weight,
      reps: _reps,
    );
    await database.upadateExerciseLog(entry);
  }

  Future<void> _submitEntry() async {
    final entry = _serializeEntry(
      id: documentIdFromCurrentDate(),
      dateCreated: DateTime.now()
          .add(Duration(days: dayDifferenceBetweenNowAndDateSelected))
          .toIso8601String(),
      setCount: null,
    );
    await database.createExerciseLog(entry);
  }

  void _resetValues() {
    _weight = _latestLog?.weight ?? 40;
    _reps = _latestLog?.reps ?? 12;
    notifyListeners();
  }

  void handleEditMode(ExerciseLog? log) {
    print("callback works, pressed log is $log");

    if (log != null) {
      _selectedLog = log;
      _weight = log.weight;
      _reps = log.reps;
      _editModeActive = true;
    } else {
      _selectedLog = null;
      _weight = _latestLog?.weight ?? 40;

      _reps = _latestLog?.reps ?? 12;
      _editModeActive = false;
    }
    notifyListeners();
  }

  ExerciseLog _serializeEntry({
    required String id,
    required String dateCreated,
    required int? setCount,
  }) {
    return ExerciseLog(
      id: id,
      exerciseID: selectedExercise.id,
      exerciseName: selectedExercise.exerciseName,
      exerciseType: selectedExercise.exerciseType,
      weight: _weight,
      reps: _reps,
      setCount: null, //TODO: delete required antotation
      dateCreated: dateCreated, //TODO:serielize date
      exerciseRPE: _rpe, //TODO: create rpe selector
    );
  }
}
