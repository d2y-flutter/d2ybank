import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static Database? _database;
  static const int _version = 1;
  static const String _dbName = 'd2ybank.db';

  static Future<Database> get database async {
    _database ??= await _initDatabase();
    return _database!;
  }

  static Future<Database> _initDatabase() async {
    final path = join(await getDatabasesPath(), _dbName);
    return openDatabase(path, version: _version, onCreate: _onCreate);
  }

  static Future<void> _onCreate(Database db, int version) async {
    await db.execute('CREATE TABLE cache (key TEXT PRIMARY KEY, value TEXT NOT NULL, expires_at TEXT NOT NULL)');
  }
}
