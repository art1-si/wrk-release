import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workout_notes_app/data_models/exercise_log.dart';
import 'package:workout_notes_app/screens/home_page/service/entries_view_model.dart';
import 'package:workout_notes_app/screens/new_entry_page/tabs/graph_page.dart/services/details_provider.dart';
import 'package:workout_notes_app/services/providers.dart';

final container = ProviderContainer();
final graphProvider = ChangeNotifierProvider.autoDispose
    .family<GraphModelProvider, List<ExerciseLog>>(
        (ref, log) => GraphModelProvider(exerciseLog: log));

class GraphModelProvider extends ChangeNotifier {
  GraphModelProvider({required this.exerciseLog}) {
    setMinAndMaxValue();
  }
  final List<ExerciseLog> exerciseLog;
  double _maxValue = 0;
  Offset? _pressedPosition;
  double _minValue = double.infinity;
  List<GraphModel>? _graphLogPosition;
  GraphModel? _tappedExerciseLog;

  double get maxValue => _maxValue;
  double get minValue => _minValue;
  List<GraphModel>? get graphLogPosition => _graphLogPosition;
  GraphModel? get tappedLog => _tappedExerciseLog;
  Offset? get pressedPosition => _pressedPosition;

  void setPressedPosition(Offset? value) {
    print("new offset: $value");
    _pressedPosition = value;
    notifyListeners();
  }

  void setMinAndMaxValue() {
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
    _graphLogPosition = _results;
    return _results;
  }

  void setTappedLog() {
    if (pressedPosition != null) {
      if (_graphLogPosition != null && _graphLogPosition!.length > 1) {
        var distance =
            _graphLogPosition!.first.nextX - _graphLogPosition!.first.x;
        for (var position in _graphLogPosition!) {
          if (position.x < pressedPosition!.dx + distance / 2 &&
              position.nextX > pressedPosition!.dx + distance / 2) {
            _tappedExerciseLog = position;
            container.read(detailsProvider).setDetails(position);
            print("position ${position.corespondingLog.weight}");
            break;
          }
        }
      }
    } else {
      _tappedExerciseLog = null;
    }
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
