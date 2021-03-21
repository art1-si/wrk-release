class ExerciseModel {
  int _id;
  String _exerciseName;
  String _exerciseType;
  double _lastWeight;
  int _lastReps;
  int _lastRPE;

  ExerciseModel(
    this._id,
    this._exerciseName,
    this._exerciseType,
    this._lastWeight,
    this._lastReps,
    this._lastRPE,
  );
  int get id => _id;
  String get exerciseName => _exerciseName;
  String get exerciseType => _exerciseType;
  double get lastWeight => _lastWeight.toDouble();
  int get lastReps => _lastReps;
  int get lastRPE => _lastRPE;

  ExerciseModel.map(dynamic obj) {
    this._id = obj["id"];
    this._exerciseName = obj["exerciseName"];
    this._exerciseType = obj["exerciseType"];
    this._lastWeight = obj["lastWeight"].toDouble();
    this._lastReps = obj["lastReps"];
    this._lastRPE = obj["lastRPE"];
  }

  Map<String, dynamic> toMap() => {
        "id": id,
        "exerciseName": exerciseName,
        "exerciseType": exerciseType,
        "lastWeight": lastWeight.toDouble(),
        "lastReps": lastReps,
        "lastRPE": lastRPE,
      };

  ExerciseModel.fromMap(dynamic data) {
    this._id = data["id"];
    this._exerciseName = data["exerciseName"];
    this._exerciseType = data["exerciseType"];
    this._lastWeight = data["lastWeight"].toDouble();
    this._lastReps = data["lastReps"];
    this._lastRPE = data["lastRPE"];
  }
}
