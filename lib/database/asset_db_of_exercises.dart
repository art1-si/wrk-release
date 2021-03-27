import 'dart:io';

import 'package:path/path.dart';
import 'dart:typed_data';
import 'package:flutter/services.dart';
import 'package:sqflite/sqflite.dart';
import 'package:workout_notes_app/models/exercise_model.dart';

class ExerciseListDb {
  ExerciseListDb._();
  static final instance = ExerciseListDb._();
  Database _db;
  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await getExerciseListFromAsset();
    return _db;
  }

  getExerciseListFromAsset() async {
    var databasesPath = await getDatabasesPath();
    var path = join(databasesPath, "exercises.db");

    // Check if the database exists
    var exists = await databaseExists(path);

    if (!exists) {
      // Should happen only the first time you launch your application

      // Make sure the parent directory exists
      try {
        await Directory(dirname(path)).create(recursive: true);
      } catch (_) {}

      // Copy from asset
      ByteData data = await rootBundle.load(join("assets", "exercises.db"));
      List<int> bytes =
          data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

      // Write and flush the bytes written
      await File(path).writeAsBytes(bytes, flush: true);
    } else {}
    // open the database
    _db = await openDatabase(path, readOnly: false);
    return _db;
  }

  Future<List> getExercises() async {
    var dbClient = await db;
    var result = await dbClient.rawQuery("SELECT * FROM exercises");
    return result.toList();
  }

  Future<List> getExercisesByType(String type) async {
    var dbClient = await db;
    var result = await dbClient
        .rawQuery("SELECT * FROM exercises WHERE exerciseType LIKE '%$type%' ");
    return result.toList();
  }

  Future<List> getExercisesType() async {
    var dbClient = await db;
    var result = await dbClient
        .rawQuery("SELECT * FROM exercises GROUP BY exerciseType");
    return result.toList();
  }

  Future<int> saveExercise(ExerciseModel exerciseModel) async {
    var dbClient = await db;
    int res = await dbClient.insert("exercises", exerciseModel.toMap());
    return res;
  }

  Future<int> deleteExercise(int id) async {
    var dbClient = await db;
    return await dbClient.delete("exercise", where: "id = ?", whereArgs: [id]);
  }

  Future<int> updateExercise(ExerciseModel exerciseModel, int id) async {
    var dbClient = await db;
    return await dbClient.update("exercises", exerciseModel.toMap(),
        where: "id = ?", whereArgs: [id]);
  }

  Future close() async {
    var dbClient = await db;
    return dbClient.close();
  }
}
