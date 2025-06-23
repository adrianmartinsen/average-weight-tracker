/*

TO DO Cubit - simple state management

Each cubit is a list of todos.

*/

import 'package:flutter_bloc/flutter_bloc.dart';

import '../domain/models/todo_model.dart';
import '../domain/repository/todo_repo.dart';

class TodoCubit extends Cubit<List<Todo>> {
  // reference todo repo
  final TodoRepo todoRepo;

  // Constructor initializes the cubit with an empty list of todos
  TodoCubit(this.todoRepo) : super([]) {
    loadTodos();
  }

  // LOAD
  Future<void> loadTodos() async {
    final todos = await todoRepo.getTodos();
    emit(todos);
  }

  // ADD
  Future<void> addTodo(String text) async {
    final newTodo = Todo(
      id: DateTime.now().microsecondsSinceEpoch,
      text: text,
      createOn: DateTime.now(),
    );

    await todoRepo.addTodo(newTodo);

    loadTodos();
  }

  // Delete
  Future<void> deleteTodo(Todo todo) async {
    await todoRepo.deleteTodo(todo);
    loadTodos();
  }

  // Toggle
  Future<void> toggleCompletion(Todo todo) async {
    final updatedTodo = todo.toggleCompletion();
    await todoRepo.updateTodo(updatedTodo);
    loadTodos();
  }
}
