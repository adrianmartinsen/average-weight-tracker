import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../../domain/models/todo_model.dart';

class TodoSql {
  static final TodoSql instance = TodoSql._instance();
  static Database? _database;

  TodoSql._instance();

  Future<Database> get db async {
    _database ??= await initDb();
    return _database!;
  }

  Future<Database> initDb() async {
    String databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'app_database.db');

    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE todos (
        id INTEGER PRIMARY KEY,
        text TEXT,
        isCompleted INTEGER,
        createdOn INTEGER
      )
    ''');
  }

  Future<void> insertTodo(Todo todo) async {
    final db = await instance.db;
    await db.insert('todos', todo.toMap());
  }

  Future<List<Map<String, dynamic>>> getTodos() async {
    final db = await instance.db;
    return await db.query('todos');
  }

  Future<void> updateTodo(Todo todo) async {
    final db = await instance.db;
    await db
        .update('todos', todo.toMap(), where: 'id = ?', whereArgs: [todo.id]);
  }

  Future<void> deleteTodo(int id) async {
    final db = await instance.db;
    await db.delete('todos', where: 'id = ?', whereArgs: [id]);
  }

  Future close() async {
    await _database?.close();
    _database = null;
  }
}
