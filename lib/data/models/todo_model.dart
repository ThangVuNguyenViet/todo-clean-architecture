import 'package:hive/hive.dart';
import 'package:todos/domain/domain.dart';

part 'todo_model.g.dart';

@HiveType(typeId: 0)
// ignore: must_be_immutable
class TodoModel extends Todo with HiveObjectMixin {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final bool complete;
  @HiveField(2)
  final String note;
  @HiveField(3)
  final String task;

  TodoModel(this.task, this.id, this.note, this.complete)
      : super(task: task, complete: complete, id: id, note: note);

  factory TodoModel.fromTodo(Todo todo) =>
      TodoModel(todo.task, todo.id!, todo.note, todo.complete);

  Todo get toTodo => Todo(task: task, complete: complete, id: id, note: note);
}
