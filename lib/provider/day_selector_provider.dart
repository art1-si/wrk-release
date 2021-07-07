import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final selectedDateProvider = ChangeNotifierProvider<DaySelectorModel>(
  (ref) => DaySelectorModel(),
);

//TODO: make syntax cleaner
class DaySelectorModel extends ChangeNotifier {
  static DateTime _now = DateTime.now();

  static int n = 0;
  DateTime _dateSelected = _now.add(Duration(days: n));
  void increment() async {
    n++;
    _dateSelected = _now.add(Duration(days: n));
    _dateSelected.add(Duration(days: n));
    notifyListeners();
  }

  void decrement() {
    n--;
    _dateSelected = _now.add(Duration(days: n));
    _dateSelected.add(Duration(days: n));
    notifyListeners();
  }

  DateTime get daySelected => _dateSelected;
  DateTime get today => _now;
  DateTime get yesterday => _now.subtract(
        Duration(days: 1),
      );
  DateTime get tomorrow => _now.add(
        Duration(days: 1),
      );
  void resetDate() {
    n = 0;
    _dateSelected = _now.add(
      Duration(days: 0),
    );
    _dateSelected.add(
      Duration(days: 0),
    );
    notifyListeners();
  }
}
