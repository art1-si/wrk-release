import 'dart:math';

double roundDouble(double value, int places) {
  double mod = pow(10.0, places).toDouble();
  return ((value * mod).round().toDouble() / mod);
}

int roundDoubleToInt(double value) {
  double mod = pow(10.0, 0).toDouble();
  return (value * mod).round().toDouble() ~/ mod;
}

bool compareDatesToDay(DateTime date1, DateTime date2) {
  return date1.year == date2.year &&
      date1.month == date2.month &&
      date1.day == date2.day;
}
