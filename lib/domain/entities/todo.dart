import 'package:equatable/equatable.dart';

class Todo extends Equatable {
  final String? id;
  final bool complete;
  final String note;
  final String task;

  const Todo({
    this.id,
    required this.task,
    this.complete = false,
    this.note = '',
  });

  Todo copyWith({bool? complete, String? id, String? note, String? task}) {
    return Todo(
      task: task ?? this.task,
      complete: complete ?? this.complete,
      id: id ?? this.id,
      note: note ?? this.note,
    );
  }

  @override
  List<Object?> get props => [complete, id, note, task];

  @override
  String toString() {
    return 'Todo { complete: $complete, task: $task, note: $note, id: $id }';
  }
}
