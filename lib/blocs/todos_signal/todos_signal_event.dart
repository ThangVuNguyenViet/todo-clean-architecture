import 'package:equatable/equatable.dart';
import 'package:todos/domain/domain.dart';

abstract class TodoSignalEvent extends Equatable {
  const TodoSignalEvent();

  @override
  List<Object> get props => [];
}

class TodoSignalAdded extends TodoSignalEvent {
  final Todo todo;

  const TodoSignalAdded(this.todo);

  @override
  List<Object> get props => [todo];

  @override
  String toString() => 'TodoSignalAdded { todo: $todo }';
}

class TodoSignalUpdated extends TodoSignalEvent {
  final Todo todo;

  const TodoSignalUpdated(this.todo);

  @override
  List<Object> get props => [todo];

  @override
  String toString() => 'TodoUpdated { updatedTodo: $todo }';
}

class TodoSignalDeleted extends TodoSignalEvent {
  final Todo todo;

  const TodoSignalDeleted(this.todo);

  @override
  List<Object> get props => [todo];

  @override
  String toString() => 'TodoSignalDeleted { todo: $todo }';
}
