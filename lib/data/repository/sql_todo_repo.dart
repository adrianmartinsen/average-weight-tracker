import '../../domain/models/todo_model.dart';
import '../../domain/repository/todo_repo.dart';
import '../models/sql_todo.dart';

class SqlTodoRepo implements TodoRepo {
  SqlTodoRepo(this.db);

  final TodoSql? db;

  @override
  Future<void> addTodo(Todo newTodo) async {
    await db?.insertTodo(newTodo);
  }

  @override
  Future<void> deleteTodo(Todo todo) async {
    await db?.deleteTodo(todo.id!);
  }

  @override
  Future<List<Todo>> getTodos() async {
    final todos = await db?.getTodos();
    return todos?.map((todo) => Todo.fromMap(todo)).toList() ?? [];
  }

  @override
  Future<void> updateTodo(Todo todo) async {
    await db?.updateTodo(todo);
  }
}
