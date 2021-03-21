import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:workout_notes_app/models/exercise_log_model.dart';

class ExerciseLogDatabase {
  static final ExerciseLogDatabase _instance = ExerciseLogDatabase.internal();
  factory ExerciseLogDatabase() => _instance;
  static Database _db;

  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDb();
    return _db;
  }

  ExerciseLogDatabase.internal();

  initDb() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, "exerciseLogDatabase.db");
    var ourDb = await openDatabase(path, version: 1, onCreate: exerciseDb);
    return ourDb;
  }

  void exerciseDb(Database database, int version) async {
    await database.execute("""
      CREATE TABLE exerciseLog
      (
        id INTEGER PRIMARY KEY,
        exerciseName TEXT,
        exerciseType TEXT,
        weight INTEGER,
        reps INTEGER,
        dateCreated TEXT,
        exerciseRPE INTEGER,
        notes TEXT
      )
      """);
  }

  Future<int> saveExercise(ExerciseLogModel exerciseLogModel) async {
    var dbClient = await db;
    int res = await dbClient.insert("exerciseLog", exerciseLogModel.toMap());
    return res;
  }

  Future<List> getExercises() async {
    var dbClient = await db;
    var result = await dbClient.rawQuery("SELECT * FROM exerciseLog");
    return result.toList();
  }

  Future<List> getExercisesByDate(String date) async {
    var dbClient = await db;
    var result = await dbClient
        .rawQuery("SELECT * FROM exerciseLog WHERE dateCreated LIKE '%$date%'");
    return result.toList();
  }

  Future<int> deleteExercise(int id) async {
    var dbClient = await db;
    return await dbClient
        .delete("exerciseLog", where: "id = ?", whereArgs: [id]);
  }

  Future<int> updateExercise(ExerciseLogModel exerciseModel, int id) async {
    var dbClient = await db;
    return await dbClient.update("exercise", exerciseModel.toMap());
  }

  Future close() async {
    var dbClient = await db;
    return dbClient.close();
  }
}
