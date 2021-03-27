import 'package:workout_notes_app/services/logics.dart';

epleyCalOneRepMax(weight, reps) {
  var oneRepMax = weight * (1 + reps / 30);
  return roundDouble(oneRepMax, 1);
}
