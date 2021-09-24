import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:workout_notes_app/database/sqlite/sql_keys.dart';

class SqliteExerciseService {
  SqliteExerciseService._();

  static final instance = SqliteExerciseService._();
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
    String path = join(documentDirectory.path, SQLKeys.exerciseDbName);
    final _database =
        await openDatabase(path, version: 1, onCreate: _createDatabase);
    return _database;
  }

  Future<void> _createDatabase(Database database, int version) async {
    await database.execute("""
      CREATE TABLE ${SQLKeys.exerciseTable}
      ( 
        id TEXT PRIMARY KEY,
        exerciseName TEXT,
        exerciseType TEXT,
      )
      """);
  }
}
