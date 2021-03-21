import 'package:flutter/cupertino.dart';

class LogValuesProvider extends ChangeNotifier {
  double _weightValue;
  int _repsValue;
  int _rpeValue;

  get weightValue => _weightValue ?? 0.0;
  get repsValue => _repsValue;
  get rpeValue => _rpeValue;

  void weightSetter(double newValue) {
    _weightValue = newValue;
  }

  void repsSetter(int value) {
    _repsValue = value;
  }

  void rpeSetter(int value) {
    _rpeValue = value;
  }

  void setWeightTo(double newWeight) {
    _weightValue = newWeight;
    notifyListeners();
  }

  void setRepsTo(int newReps) {
    _repsValue = newReps;
    notifyListeners();
  }

  void setRpeTo(int rpe) {
    _rpeValue = rpe;
    notifyListeners();
  }
}
