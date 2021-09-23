import 'dart:html';

import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:workout_notes_app/data_models/exercise_log.dart';
import 'package:workout_notes_app/database/sqlite/sql_crud.dart';
import 'package:workout_notes_app/database/sqlite/sql_keys.dart';

class SqliteService {
  SqliteService._();

  static final instance = SqliteService._();
  static Database? _db;

  Future<Database> get db async {
    if (_db != null) {
      return _db!;
    }
    _db = await initDb();
    return _db!;
  }

  Future<Database> initDb() async {
    final documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, SQLKeys.exerciseLogDbName);
    final _database =
        await openDatabase(path, version: 1, onCreate: _createDatabase);
    return _database;
  }

  Future<void> _createDatabase(Database database, int version) async {
    await database.execute("""
      CREATE TABLE ${SQLKeys.exerciseLogTable}
      ( 
        id TEXT PRIMARY KEY,
        exerciseID TEXT,
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

  Future<void> createEntry(ExerciseLog entry) async {
    final _entryToJson = entry.toJson();
    final _dbClient = await db;
    await _dbClient.insert(SQLKeys.exerciseLogTable, _entryToJson);
  }

  Future<void> deleteEntry(String entryID) async {
    final _dbClient = await db;
    await _dbClient.delete(SQLKeys.exerciseLogTable,
        where: "id = ?", whereArgs: [entryID]);
  }

  Future<List<ExerciseLog>> fetchEntries() async {
    final _dbClient = await db;
    final _query = await _dbClient.rawQuery(
        "SELECT * FROM ${SQLKeys.exerciseLogTable} ORDER BY dateCreated DESC");
    final _res = _query.map((e) => ExerciseLog.fromJson(e)).toList();
    return _res;
  }

  Future<void> updateEntry(ExerciseLog entry) async {
    final _dbClient = await db;
    await _dbClient.update(SQLKeys.exerciseLogTable, entry.toJson(),
        where: '"id" = ?', whereArgs: [entry.id]);
  }
}
