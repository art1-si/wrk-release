import 'package:flutter/cupertino.dart';

class GraphDetailProvider extends ChangeNotifier {
  double? _weight;
  int? _reps;
  String? _dateCreated;

  get getWeight => _weight;
  get getReps => _reps;
  get getDate => _dateCreated;

  void setWeight(double value) {
    _weight = value;
  }

  void setReps(int value) {
    _reps = value;
  }

  void setDate(String value) {
    _dateCreated = value;
  }

  void changeWeightOnTap(double value) {
    _weight = value;
    notifyListeners();
  }

  void changeRepsOnTap(int value) {
    _reps = value;
    notifyListeners();
  }

  void changeDateOnTap(String value) {
    _dateCreated = value;
    notifyListeners();
  }
}
