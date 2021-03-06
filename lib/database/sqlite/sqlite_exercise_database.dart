import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:workout_notes_app/database/sqlite/exercise_const.dart';
import 'package:workout_notes_app/database/sqlite/sql_keys.dart';

final exerciseDatabase = Provider.autoDispose((ref) {
  ref.onDispose(() {
    SqliteExerciseService.instance.dispose();
  });
  return SqliteExerciseService.instance;
});

class SqliteExerciseService {
  SqliteExerciseService._();

  static final instance = SqliteExerciseService._();
  static Database? _db;
  bool _onCreateTable = false;

  Future<Database> get db async {
    if (_db != null) {
      return _db!;
    }
    _db = await initDb();
    return _db!;
  }

  Future<Database> initDb() async {
    final documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, SQLKeys.exerciseDbName);
    final _database =
        await openDatabase(path, version: 1, onCreate: _createDatabase);
    List entries = jsonDecode(ExerciseJson.exercises);
    if (_onCreateTable) {
      entries.forEach((element) {
        print("addig exercise");
        _database.insert(SQLKeys.exerciseTable, element);
      });
    }
    _onCreateTable = false;
    return _database;
  }

  Future<void> _createDatabase(Database database, int version) async {
    print("onCreate ");
    _onCreateTable = true;
    await database.execute("""
      CREATE TABLE ${SQLKeys.exerciseTable}
      ( 
        id TEXT,
        exerciseName TEXT,
        exerciseType TEXT
      )
      """);
  }

  void dispose() {
    if (_db != null) {
      _db!.close();
    }
  }

  //
}
