import 'package:flutter/foundation.dart';

class ExerciseLogModel {
  String id;
  String exerciseName;
  String exerciseType;
  double weight;
  int reps;
  String dateCreated;
  int exerciseRPE;
  String notes;

  ExerciseLogModel({
    @required this.id,
    @required this.exerciseName,
    @required this.exerciseType,
    @required this.weight,
    @required this.reps,
    @required this.dateCreated,
    @required this.exerciseRPE,
    @required this.notes,
  });

  Map<String, dynamic> toMap() => {
        "id": id,
        "exerciseName": exerciseName,
        "exerciseType": exerciseType,
        "weight": weight.toDouble(),
        "reps": reps,
        "dateCreated": dateCreated,
        "exerciseRPE": exerciseRPE,
        "notes": notes,
      };

  factory ExerciseLogModel.fromMap(Map<dynamic, dynamic> data, String id) {
    return ExerciseLogModel(
      id: id,
      exerciseName: data["exerciseName"],
      exerciseType: data["exerciseType"],
      weight: data["weight"].toDouble(),
      reps: data["reps"],
      dateCreated: data["dateCreated"],
      exerciseRPE: data["exerciseRPE"],
      notes: data["notes"],
    );
  }
}
