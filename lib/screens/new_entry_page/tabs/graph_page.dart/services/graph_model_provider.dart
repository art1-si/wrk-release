import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workout_notes_app/data_models/exercise_log.dart';

final graphProvider =
    ChangeNotifierProvider.autoDispose((ref) => GraphProvider());

class GraphProvider extends ChangeNotifier {
  GraphProvider() {
    {}
  }

  Offset? _pressedPosition;
  List<GraphModel>? _graphLogPosition;
  GraphModel? _tappedExerciseLog;

  List<GraphModel>? get graphLogPosition => _graphLogPosition;
  GraphModel? get tappedLog => _tappedExerciseLog;
  Offset? get pressedPosition => _pressedPosition;

  void setPressedPosition(Offset? value) {
    print("new offset: $value");
    _pressedPosition = value;
    notifyListeners();
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
