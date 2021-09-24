import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sqflite/sqflite.dart';
import 'package:workout_notes_app/database/sqlite/sql_keys.dart';
import 'package:workout_notes_app/database/sqlite/sqlite_exercise_database.dart';
import 'package:workout_notes_app/database/sqlite/sqlite_exerciselog_database.dart';

final exerciseSQLCrud = Provider.autoDispose((ref) {
  final _exerciseDB = ref.watch(exerciseDatabase).db;
  final _exerciseService = SQLCrud(
    database: _exerciseDB,
    tableName: SQLKeys.exerciseTable,
  );
  return _exerciseService;
});
final exerciseLogSQLCrud = Provider.autoDispose((ref) {
  final _exerciseLogDB = ref.watch(exerciseLogDatabase).db;
  final _exerciseService = SQLCrud(
    database: _exerciseLogDB,
    tableName: SQLKeys.exerciseLogTable,
  );
  return _exerciseService;
});

class SQLCrud<T> {
  SQLCrud({
    required this.database,
    required this.tableName,
  });
  final Future<Database> database;
  final String tableName;

  Future<void> createEntry({
    required Map<String, dynamic> entry,
  }) async {
    final _dbClient = await database;
    await _dbClient.insert(tableName, entry);
  }

  Future<void> deleteEntry(String entryID) async {
    final _dbClient = await database;
    await _dbClient.delete(tableName, where: "id = ?", whereArgs: [entryID]);
  }

  Future<void> updateEntry(
      {required Map<String, dynamic> entry, required String elementId}) async {
    final _dbClient = await database;
    await _dbClient
        .update(tableName, entry, where: '"id" = ?', whereArgs: [elementId]);
  }

  Future<List<T>> fetchEntries<T>({
    required T entryBuilder(Map<String, dynamic> data),
  }) async {
    final _dbClient = await database;
    final _query = await _dbClient.rawQuery("SELECT * FROM $tableName");
    final _res = _query.map((e) => entryBuilder(e)).toList();
    return _res;
  }
}
