import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workout_notes_app/data_models/exercise_log.dart';
import 'package:workout_notes_app/screens/exercises_selector/services/exercise_view_model.dart';
import 'package:workout_notes_app/services/providers.dart';

AutoDisposeChangeNotifierProvider<GraphModelProvider> graphProvider(
    List<ExerciseLog> exerciseLog) {
  return ChangeNotifierProvider.autoDispose(
      (ref) => GraphModelProvider(exerciseLog: exerciseLog));
}

class GraphModelProvider extends ChangeNotifier {
  GraphModelProvider({required this.exerciseLog}) {
    setMinAndMaxValue();
  }
  final List<ExerciseLog> exerciseLog;
  double _maxValue = 0;
  double _minValue = double.infinity;

  double get maxValue => _maxValue;
  double get minValue => _minValue;

  void setMinAndMaxValue() {
    print("is setting");
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
}
