import 'package:equatable/equatable.dart';
import 'package:todos/domain/domain.dart';

abstract class TodosState extends Equatable {
  const TodosState();

  @override
  List<Object> get props => [];
}

class TodosLoadInProgress extends TodosState {}

class TodosCreatedSuccess extends TodosState {
  final Todo todo;

  TodosCreatedSuccess(this.todo);
  @override
  List<Object> get props => [todo];
}

class TodosUpdatedSuccess extends TodosState {
  final Todo todo;

  TodosUpdatedSuccess(this.todo);
  @override
  List<Object> get props => [todo];
}

class TodosDeletedSuccess extends TodosState {
  final Todo todo;

  TodosDeletedSuccess(this.todo);
  @override
  List<Object> get props => [todo];
}

class TodosLoadSuccess extends TodosState {
  final List<Todo> todos;

  const TodosLoadSuccess([this.todos = const []]);

  @override
  List<Object> get props => [todos];

  @override
  String toString() => 'TodosLoadSuccess { todos: $todos }';
}

class TodosLoadFailure extends TodosState {}
