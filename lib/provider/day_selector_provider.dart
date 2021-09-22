import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

final selectedDateProvider = ChangeNotifierProvider<DaySelectorModel>(
  (ref) => DaySelectorModel(),
);

extension PrettyDate on DateTime {
  String prettyToString() {
    final _now = DateTime.now();
    final formatter = DateFormat("MMMMEEEEd");
    final _formatterWithYear = DateFormat("yMMMMEEEEd");
    if (_now.year == this.year) {
      return formatter.format(this);
    } else {
      return _formatterWithYear.format(this);
    }
  }
}

class DaySelectorModel extends ChangeNotifier {
  int n = 0;

  void increment() {
    print(DateTime.now());
    n++;
    notifyListeners();
  }

  void decrement() {
    n--;
    notifyListeners();
  }

  DateTime get daySelected => DateTime.now().add(Duration(days: n));
  DateTime get today => DateTime.now();
  DateTime get yesterday => DateTime.now().subtract(
        Duration(days: 1),
      );
  DateTime get tomorrow => DateTime.now().add(
        Duration(days: 1),
      );
  void resetDate() {
    n = 0;
    notifyListeners();
  }

  String daySelectedToText() {
    if (n == 0) {
      return "TODAY";
    } else if (n == 1) {
      return "TOMORROW";
    } else if (n == -1) {
      return "YESTERDAY";
    } else {
      return daySelected.prettyToString();
    }
  }
}
