import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

import 'data/models/isar_todo.dart';
import 'data/models/sql_todo.dart';
import 'data/repository/isar_todo_repo.dart';
import 'data/repository/sql_todo_repo.dart';
import 'domain/repository/todo_repo.dart';
import 'presentation/todo_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // get directory path for storing data
  // final dir = await getApplicationDocumentsDirectory();

  // open isar database
  // final isar = await Isar.open([TodoIsarSchema], directory: dir.path);
  await TodoSql.instance.initDb();

  // initialize repo with isar database
  // final isarTodoRepo = IsarTodoRepo(isar);
  final sqlTodoRepo = SqlTodoRepo(TodoSql.instance);

  runApp(MainApp(
    todoRepo: sqlTodoRepo,
  ));
}

class MainApp extends StatelessWidget {
  // database injection
  final TodoRepo todoRepo;

  const MainApp({super.key, required this.todoRepo});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: TodoPage(todoRepo: todoRepo),
    );
  }
}
