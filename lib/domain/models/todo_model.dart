/*

TO DO MODEL

This is what a todo object is. It will have these properties:
- id
- text
- isCompleted

And one method to toggle completion on/off

*/

class Todo {
  final int? id;
  final String text;
  final bool isCompleted;
  final DateTime createOn;

  Todo({
    required this.id,
    required this.text,
    this.isCompleted = false, // initially, todo is incomplete
    required this.createOn,
  });

  Todo toggleCompletion() {
    return Todo(
      id: id,
      text: text,
      isCompleted: !isCompleted,
      createOn: createOn,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'text': text,
      'isCompleted': isCompleted ? 1 : 0, // SQLite uses 0 and 1 for boolean
      'createdOn':
          createOn.millisecondsSinceEpoch // SQLite doesn't have datetime
    };
  }

  factory Todo.fromMap(Map<String, dynamic> map) {
    return Todo(
      id: map['id'],
      text: map['text'],
      isCompleted: map['isCompleted'] == 0
          ? false
          : true, // SQLite uses 0 and 1 for boolean
      createOn: DateTime.fromMillisecondsSinceEpoch(map['createdOn']),
    );
  }
}
