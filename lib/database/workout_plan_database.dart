import 'dart:io';
import 'package:flutter/services.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:workout_notes_app/models/exercise_plan_model.dart';

class WorkoutPlanDatabase {
  static final WorkoutPlanDatabase _instance = WorkoutPlanDatabase.internal();
  factory WorkoutPlanDatabase() => _instance;
  static Database _db;

  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDb();
    return _db;
  }

  WorkoutPlanDatabase.internal();

  initDb() async {
    var databasesPath = await getDatabasesPath();
    var path = join(databasesPath, "workoutPlans.db");

    // Check if the database exists
    var exists = await databaseExists(path);

    if (!exists) {
      // Should happen only the first time you launch your application

      // Make sure the parent directory exists
      try {
        await Directory(dirname(path)).create(recursive: true);
      } catch (_) {}

      // Copy from asset
      ByteData data = await rootBundle.load(join("assets", "workoutPlans.db"));
      List<int> bytes =
          data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

      // Write and flush the bytes written
      await File(path).writeAsBytes(bytes, flush: true);
    } else {}
    // open the database
    _db = await openDatabase(path, readOnly: false);
    return _db;
  }

  void exerciseDb(Database database, int version) async {
    await database.execute("""
      CREATE TABLE workoutPlan
      (
        id INTEGER PRIMARY KEY,
        planName TEXT,
        exerciseName TEXT,
        minRepsPerSet INTEGER,
        maxRepsPerSet INTEGER,
        sets INTEGER,
        rpe INTEGER,
        notes TEXT,
        weekdayForWorkout TEXT,
        restTime INTEGER
      )
      """);
  }

  Future<int> saveExercise(ExercisePlanModel exercisePlanModel) async {
    var dbClient = await db;
    int res = await dbClient.insert("WorkoutPlans", exercisePlanModel.toMap());
    return res;
  }

  Future<List> getExercises() async {
    var dbClient = await db;
    var result = await dbClient.rawQuery("SELECT * FROM WorkoutPlans");
    return result.toList();
  }

  Future<List> getPlanNames() async {
    var dbClient = await db;
    var result =
        await dbClient.rawQuery("SELECT * FROM WorkoutPlans GROUP BY planName");
    return result.toList();
  }

  Future<int> deleteExercise(int id) async {
    var dbClient = await db;
    return await dbClient
        .delete("WorkoutPlans", where: "id = ?", whereArgs: [id]);
  }

  Future<int> updateExercise(
      ExercisePlanModel exercisePlanModel, int id) async {
    var dbClient = await db;
    return await dbClient.update("WorkoutPlans", exercisePlanModel.toMap());
  }

  Future close() async {
    var dbClient = await db;
    return dbClient.close();
  }
}
