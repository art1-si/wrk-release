class ExercisePlanModel {
  int _id;
  String _planName;
  String _exerciseName;
  int _minRepsPerSet;
  int _maxRepsPerSet;
  int _sets;
  int _rpe;
  String _notes;
  String _weekdayForWorkout;
  double _restTime;
  int _orderId;

  ExercisePlanModel(
    this._planName,
    this._exerciseName,
    this._minRepsPerSet,
    this._maxRepsPerSet,
    this._sets,
    this._rpe,
    this._notes,
    this._weekdayForWorkout,
    this._restTime,
    this._orderId,
  );
  int get id => _id;
  String get planName => _planName;
  String get exerciseName => _exerciseName;
  int get minRepsPerSet => _minRepsPerSet;
  int get maxRepsPerSet => _maxRepsPerSet;
  int get sets => _sets;
  int get rpe => _rpe;
  String get notes => _notes;
  String get weekdayForWorkout => _weekdayForWorkout;
  double get restTime => _restTime;
  int get orderId => _orderId;

  ExercisePlanModel.map(dynamic obj) {
    this._id = obj["id"];
    this._planName = obj["planName"];
    this._exerciseName = obj["exerciseName"];
    this._minRepsPerSet = obj["minRepsPerSet"];
    this._maxRepsPerSet = obj["maxRepsPerSet"];
    this._sets = obj["sets"].toInt();
    this._rpe = obj["rpe"];
    this._notes = obj["notes"];
    this._weekdayForWorkout = obj["weekdayForWorkout"];
    this._restTime = obj["restTime"].toDouble();
    this._orderId = obj["orderId"];
  }
  Map<String, dynamic> toMap() => {
        "id": id,
        "planName": planName,
        "exerciseName": exerciseName,
        "minRepsPerSet": minRepsPerSet,
        "maxRepsPerSet": maxRepsPerSet,
        "sets": sets,
        "rpe": rpe,
        "notes": notes,
        "weekdayForWorkout": weekdayForWorkout,
        "restTime": restTime.toDouble(),
        "orderId": orderId,
      };

  ExercisePlanModel.fromMap(dynamic data) {
    this._id = data["id"];
    this._planName = data["planName"];
    this._exerciseName = data["exerciseName"];
    this._minRepsPerSet = data["minRepsPerSet"];
    this._maxRepsPerSet = data["maxRepsPerSet"];
    this._sets = data["sets"];
    this._rpe = data["rpe"];
    this._notes = data["notes"];
    this._weekdayForWorkout = data["weekdayForWorkout"];
    this._restTime = data["restTime"].toDouble();
    this._orderId = data["orderId"];
  }
}
