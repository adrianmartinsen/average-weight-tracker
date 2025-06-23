/*

DATABASE REPOSITORY

This implements the todo repo and handles storing, retrieving, updating and deleting todos in the isar database.

*/

import 'package:bloc_todo_mk/data/models/isar_todo.dart';
import 'package:isar/isar.dart';

import '../../domain/models/todo_model.dart';
import '../../domain/repository/todo_repo.dart';

class IsarTodoRepo implements TodoRepo {
  final Isar isar;

  IsarTodoRepo(this.isar);

  @override
  Future<List<Todo>> getTodos() async {
    final todos = await isar.todoIsars.where().findAll();
    return todos.map((todoIsar) => todoIsar.toDomain()).toList();
  }

  @override
  Future<void> addTodo(Todo newTodo) async {
    final todoIsar = TodoIsar.fromDomain(newTodo);
    await isar.writeTxn(() => isar.todoIsars.put(todoIsar));
  }

  @override
  Future<void> deleteTodo(Todo todo) async {
    await isar.writeTxn(() => isar.todoIsars.delete(todo.id!));
  }

  @override
  Future<void> updateTodo(Todo todo) async {
    final todoIsar = TodoIsar.fromDomain(todo);
    await isar.writeTxn(() => isar.todoIsars.put(todoIsar));
  }
}
