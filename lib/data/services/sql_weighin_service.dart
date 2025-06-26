import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class SqlWeighin {
  static final SqlWeighin instance = SqlWeighin._instance();
  static Database? _database;

  SqlWeighin._instance();

  // Get database instance
  static Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDatabase();
    return _database!;
  }

  // Initialize database using DatabaseFactory
  static Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'weighin_database.db');

    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  // Create tables
  static Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE weighins (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        weight TEXT,
        date INTEGER
      )
    ''');
  }

  Future<void> insertWeighin(String weight, int date) async {
    final db = await database;

    await db.insert(
      'weighins',
      {'weight': weight, 'date': date},
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Map<String, dynamic>>> getWeighins() async {
    final db = await database;

    return await db.query('weighins');
  }

  Future<void> updateWeighin(int id, String weight, int date) async {
    final db = await database;

    await db.update('weighins', {'weight': weight, 'date': date},
        where: 'id = ?', whereArgs: [id]);
  }

  Future<void> deleteWeighin(int id) async {
    final db = await database;

    await db.delete('weighins', where: 'id = ?', whereArgs: [id]);
  }
}
