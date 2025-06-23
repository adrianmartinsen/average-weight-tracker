/*

ISAR TO DO MODEL

Converst to do model into and isar to do model that can be stored in our isar db.

*/

import 'package:isar/isar.dart';

import '../../domain/models/todo_model.dart';

part 'isar_todo.g.dart';

@collection
class TodoIsar {
  Id? id = Isar.autoIncrement;
  late String text;
  late bool isCompleted;
  late DateTime createdOn;

  // convert isar object -> pure todo object to use in our app
  Todo toDomain() {
    return Todo(
      id: id,
      text: text,
      isCompleted: isCompleted,
      createOn: createdOn,
    );
  }

  // convert a pure todo object -> isar object to store in the db
  static TodoIsar fromDomain(Todo todo) {
    return TodoIsar()
      ..id = todo.id
      ..text = todo.text
      ..isCompleted = todo.isCompleted;
  }
}
