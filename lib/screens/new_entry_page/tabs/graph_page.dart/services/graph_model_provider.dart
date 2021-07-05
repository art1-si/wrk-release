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

  double getRelativeYposition({required double value, required double height}) {
    double weightGraphValue = value;
    double relativeYposition =
        (weightGraphValue - minValue) / (maxValue - minValue);
    double yOffset = height - relativeYposition * height;

    /* double lastRelativeYposition =
            (lastWeighValue - minValue) / (maxValue - minValue);
        double yLastOffset = height - lastRelativeYposition * height; */
    return yOffset;
  }

  List<GraphModel> findOffsets({required Size size}) {
    var _results = <GraphModel>[];
    bool isLast = false;
    var distance = 30.0;
    var nextDistance = (size.width - 50) / (exerciseLog.length - 1);
    int nextValueIndex = 1;
    exerciseLog.forEach((log) {
      double nextValue = exerciseLog.length > nextValueIndex
          ? exerciseLog[nextValueIndex].weight
          : log.weight;
      var _yPosition =
          getRelativeYposition(value: log.weight, height: size.height);
      var _nextYPosition =
          getRelativeYposition(value: nextValue, height: size.height);
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
}

class GraphModel {
  GraphModel({
    required this.x,
    required this.nextX,
    required this.nextY,
    required this.y,
    required this.corespondingLog,
  });
  final double x;
  final double nextX;
  final double y;
  final double nextY;
  final ExerciseLog corespondingLog;
}
