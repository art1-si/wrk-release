import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

final selectedDateProvider = ChangeNotifierProvider<DaySelectorModel>(
  (ref) => DaySelectorModel(),
);

extension PrettyDate on DateTime {
  String prettyToString() {
    final formatter = DateFormat("MMMMEEEEd");
    return formatter.format(this);
  }
}

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

  String daySelectedToText() {
    if (_dateSelected == _now) {
      return "TODAY";
    } else if (_dateSelected == tomorrow) {
      return "TOMORROW";
    } else if (_dateSelected == yesterday) {
      return "YESTERDAY";
    } else {
      return _dateSelected.prettyToString();
    }
  }
}
