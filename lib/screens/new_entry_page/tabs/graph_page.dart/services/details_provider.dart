import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workout_notes_app/screens/new_entry_page/tabs/graph_page.dart/services/graph_model_provider.dart';

final detailsProvider = ChangeNotifierProvider.autoDispose(
  (ref) => DetailsProvider(),
);

class DetailsProvider extends ChangeNotifier {
  GraphModel? _log;
  Offset? _offset;
  int? _index;

  GraphModel? get logDetails => _log;
  int? get index => _index;

  void setOffset(Offset? offset) {
    _offset = offset;
    notifyListeners();
  }

  void setDetails(GraphModel? value) {
    print("new detail value ${value!.corespondingLog.weight}");
    print("log details before $logDetails");
    _log = value;
    print("log details after $logDetails");
  }

  int? comperOffset(List<GraphModel> points, double width) {
    if (_offset != null) {
      int _index = 0;
      double distance = ((points.first.nextX - points.first.x));
      double halfDistance = ((points.first.nextX - points.first.x) / 2) * width;
      for (var point in points) {
        if (_offset!.dx + halfDistance < (point.x + distance) * width &&
            _offset!.dx + halfDistance >= point.x * width) {
          setDetails(point);
          print("index $_index");
          return _index;
        }

        _index++;
      }
    }
  }
}
