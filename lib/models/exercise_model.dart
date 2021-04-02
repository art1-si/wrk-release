import 'package:flutter/foundation.dart';

class ExerciseModel {
  String id;
  String exerciseName;
  String exerciseType;
  double lastWeight;
  int lastReps;
  int lastRPE;

  ExerciseModel({
    @required this.id,
    @required this.exerciseName,
    @required this.exerciseType,
    @required this.lastWeight,
    @required this.lastReps,
    @required this.lastRPE,
  });

  Map<String, dynamic> toMap() => {
        "id": id,
        "exerciseName": exerciseName,
        "exerciseType": exerciseType,
        "lastWeight": lastWeight.toDouble(),
        "lastReps": lastReps,
        "lastRPE": lastRPE,
      };

  factory ExerciseModel.fromMap(Map<dynamic, dynamic> value, String id) {
    return ExerciseModel(
      id: id,
      exerciseName: value["exerciseName"],
      exerciseType: value["exerciseType"],
      lastWeight: value["lastWeight"].toDouble(),
      lastReps: value["lastReps"],
      lastRPE: value["lastRPE"],
    );
  }
}
