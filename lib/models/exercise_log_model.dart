class ExerciseLogModel {
  int _id;
  String _exerciseName;
  String _exerciseType;
  double _weight;
  int _reps;
  String _dateCreated;
  int _exerciseRPE;
  String _notes;

  ExerciseLogModel(
    this._exerciseName,
    this._exerciseType,
    this._weight,
    this._reps,
    this._dateCreated,
    this._exerciseRPE,
    this._notes,
  );
  int get id => _id;
  String get exerciseName => _exerciseName;
  String get exerciseType => _exerciseType;
  double get weight => _weight.toDouble();
  int get reps => _reps;
  String get dateCreated => _dateCreated;
  int get exerciseRPE => _exerciseRPE;
  String get notes => _notes;

  ExerciseLogModel.map(dynamic obj) {
    this._id = obj["id"];
    this._exerciseName = obj["exerciseName"];
    this._exerciseType = obj["exerciseType"];
    this._weight = obj["weight"].toDouble();
    this._reps = obj["reps"];
    this._dateCreated = obj["dateCreated"];
    this._exerciseRPE = obj["exerciseRPE"];
    this._notes = obj["notes"];
  }

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

  ExerciseLogModel.fromMap(dynamic data) {
    this._id = data["id"];
    this._exerciseName = data["exerciseName"];
    this._exerciseType = data["exerciseType"];
    this._weight = data["weight"].toDouble();
    this._reps = data["reps"];
    this._dateCreated = data["dateCreated"];
    this._exerciseRPE = data["exerciseRPE"];
    this._notes = data["notes"];
  }
}
