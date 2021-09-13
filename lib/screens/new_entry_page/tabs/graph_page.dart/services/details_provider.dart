import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workout_notes_app/screens/new_entry_page/tabs/graph_page.dart/services/graph_model.dart';

final detailsProvider = ChangeNotifierProvider.autoDispose(
  (ref) => DetailsProvider(),
);

class DetailsProvider extends ChangeNotifier {
  GraphModel? _log;
  Offset? _offset;
  int? _index;
  List<GraphModel>? points;
  //double? width;

  GraphModel? get logDetails => _log ?? points!.last;
  int? get index => _index;
  Offset? get offset => _offset;

  void setOffset(Offset? offset) {
    _offset = offset;
    _comperOffset();
  }

  void _setDetails(GraphModel? value) {
    _log = value;
    notifyListeners();
  }

  void _comperOffset() {
    if (_offset != null) {
      double distance = points!.first.nextX - points!.first.x;
      double halfDistance = (points!.first.nextX - points!.first.x) / 2;
      for (var i = 0; i < points!.length; i++) {
        var point = points![i];
        if (_offset!.dx + halfDistance < (point.x + distance) &&
            _offset!.dx + halfDistance >= point.x) {
          _index = i;
          if (_log != point) {
            _setDetails(point);
          }
        }
      }
    } else {
      _setDetails(null);
      _index = null;
    }
  }
}
