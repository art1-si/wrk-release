import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final selectedDateProvider = ChangeNotifierProvider<DaySelectorModel>(
  (ref) => DaySelectorModel(),
);

//TODO: make syntax cleaner
class DaySelectorModel extends ChangeNotifier {
  static DateTime _now = DateTime.now();
  static DateTime lastMidnight = _now.subtract(Duration(
    hours: _now.hour,
    minutes: _now.minute,
    seconds: _now.second,
    milliseconds: _now.millisecond,
    microseconds: _now.microsecond,
  ));

  static int n = 0;
  DateTime _dateSelected = lastMidnight.add(Duration(days: n));
  void daySelectorAdd() async {
    n++;
    _dateSelected = lastMidnight.add(Duration(days: n));
    _dateSelected.add(Duration(days: n));
    notifyListeners();
  }

  void daySelectorSub() {
    n--;
    _dateSelected = lastMidnight.add(Duration(days: n));
    _dateSelected.add(Duration(days: n));
    notifyListeners();
  }

  DateTime get daySelected => _dateSelected;
  DateTime get today => _now;
  DateTime get yesterday => _now.subtract(Duration(days: 1));
  DateTime get tomorrow => _now.add(Duration(days: 1));
  void resetDate() {
    n = 0;
    _dateSelected = lastMidnight.add(Duration(days: 0));
    _dateSelected.add(Duration(days: 0));
    notifyListeners();
  }
}
