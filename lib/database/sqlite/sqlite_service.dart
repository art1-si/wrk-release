import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:workout_notes_app/data_models/exercise_log.dart';
import 'package:workout_notes_app/database/sqlite/sql_crud.dart';
import 'package:workout_notes_app/database/sqlite/sql_keys.dart';

class SqliteService implements SQLCrud {
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

  @override
  Future<void> createEntry<ExerciseLog>(ExerciseLog entry) async {
    final _entryToJson = entry!.toJson;
    final _dbClient = await db;
    await _dbClient.insert(SQLKeys.exerciseLogTable, _entryToJson);
  }

  @override
  Future<void> deleteEntry(String entryID) {
    // TODO: implement deleteEntry
    throw UnimplementedError();
  }

  @override
  Future<List<T>> fetchEntries<T>() {
    // TODO: implement fetchEntries
    throw UnimplementedError();
  }

  @override
  Future<void> updateEntry<T>(T entry) {
    // TODO: implement updateEntry
    throw UnimplementedError();
  }
}
