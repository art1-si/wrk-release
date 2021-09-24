import 'package:sqflite/sqflite.dart';

class SQLCrud<T> {
  SQLCrud({
    required this.database,
    required this.tableName,
  });
  final Database database;
  final String tableName;

  Future<void> createEntry({
    required Map<String, dynamic> entry,
  }) async {
    final _dbClient = database;
    await _dbClient.insert(tableName, entry);
  }

  Future<void> deleteEntry(String entryID) async {
    final _dbClient = database;
    await _dbClient.delete(tableName, where: "id = ?", whereArgs: [entryID]);
  }

  Future<void> updateEntry(
      {required Map<String, dynamic> entry, required String elementId}) async {
    final _dbClient = database;
    await _dbClient
        .update(tableName, entry, where: '"id" = ?', whereArgs: [elementId]);
  }

  Future<List<T>> fetchEntries<T>({
    required T entryBuilder(Map<String, dynamic> data),
  }) async {
    final _dbClient = database;
    final _query = await _dbClient
        .rawQuery("SELECT * FROM $tableName ORDER BY dateCreated DESC");
    final _res = _query.map((e) => entryBuilder(e)).toList();
    return _res;
  }
}
