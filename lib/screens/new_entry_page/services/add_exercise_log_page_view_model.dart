import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workout_notes_app/data_models/exercise.dart';

final addExerciseLogProvider = ChangeNotifierProvider(
  (ref) => AddExerciseLogPageViewModel(),
);

class AddExerciseLogPageViewModel extends ChangeNotifier {
  List<Exercise>? _selectedExercises;
  int _exerciseIndex = 0;

  Exercise get seletedExercise => _selectedExercises![_exerciseIndex];

  bool get indexIsOnZero => _exerciseIndex == 0;

  bool get indexReachedEnd => _exerciseIndex == _selectedExercises!.length - 1;
  List<Exercise>? get selectedExercises => _selectedExercises;

  void setSelectedExerciseIndex(index) => _exerciseIndex = index;

  void selectExercises(List<Exercise>? exercises) {
    _selectedExercises = exercises;
    notifyListeners();
  }

  void nextExercise() {
    _exerciseIndex++;
    notifyListeners();
  }

  void previousExercise() {
    _exerciseIndex--;
    notifyListeners();
  }
}
