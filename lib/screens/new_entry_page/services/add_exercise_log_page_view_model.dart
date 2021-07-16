import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workout_notes_app/data_models/exercise.dart';
import 'package:workout_notes_app/data_models/group_by_model.dart';

final addExerciseLogProvider = ChangeNotifierProvider(
  (ref) => AddExerciseLogPageViewModel(),
);

class AddExerciseLogPageViewModel extends ChangeNotifier {
  List<Exercise>? _selectedExercises;
  int _exerciseIndex = 0;

  Exercise get selectedExercise => _selectedExercises![_exerciseIndex];

  bool get indexIsOnZero => _exerciseIndex == 0;

  bool get indexReachedEnd => _exerciseIndex == _selectedExercises!.length - 1;

  List<Exercise>? get selectedExercises => _selectedExercises;

  void setSelectedExerciseIndex(index) {
    print("set selected ExerciseIndex $index");
    return _exerciseIndex = index;
  }

  List<String> _getExercisesID<T>(
    List<GroupByModel<T>> log,
  ) {
    List<String> _exercisesID = [];
    log.forEach((element) {
      _exercisesID.add(element.exerciseID);
    });
    return _exercisesID;
  }

  void setExercisesToCorrespondingItems<T>(List<GroupByModel<T>> items) {
    List<Exercise> _results = [];
    final _ids = _getExercisesID(items);
    for (var _id in _ids) {
      var _res =
          _selectedExercises!.firstWhere((exercise) => exercise.id == _id);
      _results.add(_res);
    }
    print(_results);
    _selectedExercises = _results;
  }

  void selectExercisesWithoutNotify(List<Exercise>? exercises) {
    print("seleceting Exercises function without notifing");
    _selectedExercises = null;
    _selectedExercises = exercises;
  }

  void selectExercises(List<Exercise>? exercises) {
    print("seleceting Exercises function");
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
