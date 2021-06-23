import 'dart:math';

double roundDouble(double value, int places) {
  double mod = pow(10.0, places).toDouble();
  return ((value * mod).round().toDouble() / mod);
}

int roundDoubleToInt(double value) {
  double mod = pow(10.0, 0).toDouble();
  return (value * mod).round().toDouble() ~/ mod;
}
